Shader "Custom/Zoom"
{
    Properties
    {
        _Zoom ("Zoom", Range(1, 30)) = 1
    }
    SubShader
    {
        Tags { "Queue" = "Transparent" "RenderType" = "Opaque" }
        LOD 100
        GrabPass
        {
            "_BackTex"
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            struct appdata
            {
                float4 vertex : POSITION;
            };
            struct v2f
            {
                float4 worldPos : TEXCOORD0;
                float4 grabPos : TEXCOORD1;
                float4 vertex : SV_POSITION;
            };
            sampler2D _BackTex;
            float _Zoom;
            v2f vert (appdata v)
            {
                v2f o;
                o.worldPos = ComputeScreenPos(UnityObjectToClipPos(float4(0, 0, 0, 1)));
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.grabPos = ComputeGrabScreenPos(o.vertex);
                return o;
            }
            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 col = tex2Dproj(_BackTex, (i.grabPos - i.worldPos) / float4(_Zoom, _Zoom, _Zoom, 1) + i.worldPos);
                return col;
            }
            ENDCG
        }
    }
}