Shader "Unlit/StencilWrite"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        [IntRange] _StencilRef ("Stencil Reference", Range(0, 255)) = 0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque"
                "Queue"="Geometry - 1" }

        ColorMask 0
        Stencil {
            Ref [_StencilRef]
            Comp Always
            Pass Replace
        }

        Blend Zero One
        ZWrite Off
        
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);

                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                return 0;
            }
            ENDCG
        }
    }
}
