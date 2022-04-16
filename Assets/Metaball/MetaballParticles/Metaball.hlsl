#define MAX_PARTICLES 256

float4 _ParticlesPos[MAX_PARTICLES];
float _ParticlesSize[MAX_PARTICLES];
float _NumParticles;

float GetDistanceSphere(float3 p, float3 center, float radius)
{
    return length(p - center) - radius;
}

void SphereTraceMetaballs_float(float3 WorldPosition, out float Alpha)
{
    #if defined(SHADERGRAPH_PREVIEW)
    Alpha = 0;
    #else
    float maxDistance = 100;
    float threshold = 0.00001;
    float t = 0;
    int numSteps = 0;

    float outAlpha = 0;

    float3 viewPosition = GetCurrentViewPosition();
    half3 viewDir = SafeNormalize(WorldPosition - viewPosition);
    while (t < maxDistance)
    {
        float minDistance = 1000000;
        float3 from = viewPosition + t * viewDir;
        float d = GetDistanceSphere(from, float3(0, 0, 0), 0.3);
        if (d < minDistance)
        {
            minDistance = d;
        }

        if (minDistance <= threshold * t)
        {
            outAlpha = 1;
            break;
        }

        t += minDistance;
        ++numSteps;
    }
    
    Alpha = outAlpha;
    #endif
}

