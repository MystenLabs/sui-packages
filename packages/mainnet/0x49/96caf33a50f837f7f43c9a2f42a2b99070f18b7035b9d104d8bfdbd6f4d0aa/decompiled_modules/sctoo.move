module 0x4996caf33a50f837f7f43c9a2f42a2b99070f18b7035b9d104d8bfdbd6f4d0aa::sctoo {
    struct SCTOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCTOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<SCTOO>(arg0, 6, b"SCTOO", b"SUI Community Take Over Officer", b"", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRqoEAABXRUJQVlA4IJ4EAADQGgCdASqAAIAAPm02l0ekIyIhJhlZiIANiWIA11nA/qum6+F/Ir2LKZ/cthynbzqOM/zB7qvQB5gH6V9IDzAfrt6vXoA9AD+Z9QB6AH7Aem77Iv9x/7X7VdgB//9gasx7RzshlOsDNI1NC8mD4shzqFwobUI/QpRCwtOkjh64y8fovC1zf/HONhDQphYZE7jl6lSrZcu103auPz67tPH99te8KTdwkVoClZ8R4xaRVa+SmQ5sI+x8We2WptjZxhY6A8O8mgyw4WhJMICxm1u5+TBOBVLezkL7xgbckbQwAP7jd39Iv8fD8fDnjf5qi0sHnJAAIE4Yh0WA7tgvQH2Hv/t2IDPbqRF5nlPq55w4F10AxowF3tA8wJuz0i743iefdfT8IvwFhBwZ/tQfr5UvfWN80iRpYM3VIUsA5TN4xlu/9x4EniYYGbzYw8H48CpgNQWvurXpk9dmPSs71LSCkEDGlHod4CDzrZLpb91YIV5Ob6w88YVT9h/alWPu2UYBl54XQlHFQpdqYUScIpI7wE1PMUjYkFFsx3ziqi6GAxCQMLeAiP9G1kBwKZmc7nlYFP/khEe+qYT4bIjFfP5WZY/HCchsd1DKINKcgyJhwLLo+QEqS7isxRNDFoWfOfCz4vqIwJZgrcP7m7YQVCO2nfKdfpq2mPKlahxZpNi5XuVwMfWNo2W+R+4EQ6iZde0t5Lt5emdI8XhOze9IML+ngXYU1fG31x0kXHW0Oicy3dRhj5B8DnIRTryLFDRL68JH6r67AK20GQZFfM7iwTMncXP6WVPVd+4cadUWitzppmhtLiTYB6fC9/tXkbSyacP/EgSa4808vyTRPdbQfwje6o5ixXcpcg4KdnRZDz/nfBhl2+HLI5X/ctlJMFHdCqllQdDPDI3DueS1iGN/c08lUpC8u/hAVgnGdj5gJJNn8mRfpZpAMqGAbopUjzXyfk/yvhr9l5v8WYz0PiSXRxjUD5c/VgzGm9Ssa1R1HuS0c8kCky5B4yGXMmK5sCRzCeRm2NW8YYuJNOTnc9rYNVHFs+dkBZn0HZUQtIMnb/u70D/gZW5/OfTx43sHvedJrHCoZlUyV1/qVkQa/Eh2bb60T6ZQpfztgRkqRftLGDPxdXa0NygAp34tVGnMYJ4jPaPjsGR9EWAIBimCeexgS4m5QMMtmPk0ZsYgeX5RzFu6RSTqLOy0gCywGKD+7x7KsYnKXhPRqwzlF23U7OO+AFrUSuyFh/unqFo05qo53GurJM6gtEcNdKr0+J2T3aTGCQB8dHTenZj2ua6OKAkNanWoH5WuqGph8ClPDkXwP2ey+RNhMWEJwJ0XH/H+JcnzuH8uIiz9cdVMpc/nvDU3cszC1Cybz+vnMYd5RhROv2vBlG63ZrJsIhWgNHpm+dAK3WpvxLpBvrGyDtEvqoYnVb1zRzvImXxSW/1z4+o8jhfOkFrOmC/ikC6pj/xY9llxFWZux0xIUapaxn+ud/PQxY3MCKexjT5w6nMb/9drIc3uw7bQxIiFFtXhyfX4Af5+oX0f+RaUdgBTXV73DH/wozVdIjwQU27t94BbUCAAAAA="), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCTOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCTOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

