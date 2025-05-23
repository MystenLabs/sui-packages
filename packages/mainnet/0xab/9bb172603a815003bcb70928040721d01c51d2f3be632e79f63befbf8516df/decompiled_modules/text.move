module 0xab9bb172603a815003bcb70928040721d01c51d2f3be632e79f63befbf8516df::text {
    struct TEXT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEXT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<TEXT>(arg0, 6, b"TEXT", b"text", b"", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRtgEAABXRUJQVlA4WAoAAAAQAAAAfwAAfwAAQUxQSKsDAAABoIVt2xlJelM1nunuyaw9tu2sbdu2bdu2rbFt27bRdn0H9b1fsKmjVURMAP73f+aet1cdnrmWijrqb0J3PElbxdClT9JuocwSekYM/Sz0+r931KjfoU1OTHXwPM9bxO731Fa2To/3W14sIpWbx795etKw/+230vq2w26ltx3U1PM8bxh7zlPb+holgX5nuXBspZiX31+L4CehAx3Tb0J/wzsSaL+INR0q/hccTQ5cTeQ2y41CN9WPheM2SZBFN2k4v4LsasXqbyaVFyEOjt4twZZfr+ETIiMdzRkg9HPEQaMNEnRBX63uYiJ3ajcLXbF/LPQXPu+lq06/4N5+xURmVVVwVDHZ2yat2XZSfgqiMzaYn9LOTJGCO5JQu04jcpWGV4mMSQKJoULfRPr7wQzyleW6rjubXeSqtdOGiV5xMfh+M8lUR6sxhci9wH1C52cptVzXdX9lt7tqHV9In8XOgLFlOfka1t7lmngauueT3E4td5PCXrD+zK6HzwjcLHqqrwnDyCMEjxEZN0roU4iHr8kK2B8mA1hyNDFOrBoTi0h/H2eSZQzNdvjZ2x4xsYN84cMj2w24yc/tiImsMtL/TPs9pDzbgD9tw524aClhH2Gpv9GypRHionOUcHGKpa5GRsIoNh6Z6YRSVn52RtpniRhXHxgbHaP0pZi/j42DUuRDN+CE4eJKW+qquEjkkk8Rdv2N4nNL45jAatIvLKef+B6e+CudZRlNVjkh3SF0/hwi9wZ0YyjT2fWWV4mcZOuzQP+YtNpNSk7oXURyO5p+YI+FMpJ9bTmODXMsieGi36VVHSP0VeAlItNqWj5iY50wfmSVn118tOd5WQASc4i8aEh+IHphE+1ZobNrAzWnE3nR8hyT/pce63levWAeYLQPANzM5PummjdC6AdQ+xSRkqMAoFsBKTnWcJ5BPyWY7hWBJCcxKR7z1hNPfjgzJXRLAyVrrtCXoD5HZGk9dsCeSGBYIGi/k/kuOQvqB0Jn19aqTSHyMcMH0eiRGwjOKAio9E6oZ1aQwl6g3fJJ5aWs/rpI4KrCQHDy5kByL4F60Gqhz8H4DJFNRxCcsD0SOH52IGjcL+VvaHvoPwidUcNSdRyRPxyCjmMjgcSFH83cVKj1ZcApf5aYygZfBHpjihT2gLl9LpF7GXDKW1M25munBqdWddWkBTjk0ncnLttWVrR53rd3t4Exy6XZ8Jnl0ixLetJVq4QUZq1qiNnoxe/ff+btVYdnrv/9bwQAVlA4IAYBAAAwCwCdASqAAIAAPm02lkikIyIhIItIgA2JaQhwABeyZn9Aeg9mui7/P9pvv+/yJUYTeuyroBQEch3/ElVyIOZXpU+2KwPekJpqrsttOWRzZUj7mnDvgM0BQg6Lv2HzeMwewAD+w0wAYy9/44XsL/8GorfQWXsZJNNp+yAGlioDkMVk4NA0pQMEycMAbrLETbIFqcjpxRuxO488lFYEIT3xvphaB7igALcFqMM2P50nR+J7Bh2Uxb+Ze3xbmrUbJa0Zn/8tEeC99brDdmjXowMVF+VjkrT8KebwLocSf0oAyLwk1fAzlTfugWZWmvieDMke2M9qRfG4dAoX/D/6aUjN1AAAAAAA"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEXT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TEXT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

