using UnityEngine;

namespace SimpleZoomDistortionShader
{
    [HelpURL("https://assetstore.unity.com/packages/slug/243465")]
    public class ZoomPingPongController : MonoBehaviour
    {
        [SerializeField]
        private float speed;

        private Material material;
        private string floatName = "_Zoom";
        private float minValue = 1f, maxValue;

        /// <summary>
        /// Saving initial parameter values and caching components
        /// </summary>
        private void Start()
        {
            material = GetComponent<Renderer>().material;
            maxValue = material.GetFloat(floatName);
        }

        /// <summary>
        /// Animating the zoom value
        /// </summary>
        private void Update()
        {
            material.SetFloat(floatName, minValue + Mathf.PingPong(Time.time * speed, maxValue - minValue));
        }
    }
}