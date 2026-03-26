module 0xfa63389cc312f1c541e9f62037a4d959a6e291e50e74ba4da5e526cd7ea99233::honey {
    struct HONEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HONEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<HONEY>(arg0, 6, b"HONEY", b"Honey ", b"", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRswDAABXRUJQVlA4IMADAABQEwCdASpAAEAAPmkqkEWkIqGa+XZkQAaEtQBOmWz+q9j/IDnstJfjxy9u1zvOnOegB0rk+m5kRNqnyCG6SWneDrWmnWpHAqZMQ5wfYfxRy6nDCwBOho/hjLtnTSgd91RV3CpqhziWv5mpOdH1ckXA7u2s2HfLTa1ps3rGkQHhXVz5TCzRxTN5hmwxotJch2meRZWOmCIa+9ZeIdsNtpqzfbgAAP6eik9G5DmoM78pJQiNOr6XGX9xAP+Rqhf/73LuhCL4/utU8wT69++iF1cTP+ljuMnK1qwgH/3EGjptbeXjz0JVczocgTE9jSgGAN9NRt2WjZoQ4dCMXooGN4z4jMAQbMVrIcNY26alWwQ3vkOQKF2fjAEHN+MzGLTu7FeQDAziIPz/ope0RiR8FxZCvfO2+djoU61liDdSPjv5S04JE5iCHG4Q6VRz8gm5CNIT4zG0qoA+He8zeUtJQVW/cSjpiv/ST/8tOjzOzVG5p52oRxgB03UJ4ms+0StJnqonSA9fKokqcoOHQkf6W0QHrBmxaki/I2oNLNizYbCMXHAKQ/olXvvtYTKbR0yHyuKnm3t2ptsJgopkyRZ9YzAqj8j3cQiuD8cIJAnU/Cs0lokamqZK13qsJxF2VMsR+9Q9STsbE6Tf3ZA25UFhg/leEfsUoXvRmdjszmbhwkUS+F3IzutBrZ0S32APVYfvt9STbbojAVAY2PPwnnzwcHl8cpBhOJkOHkGlV5bx1OKSrra5PGu9rCU6JjB4k7ouyDIhVlp5o/e/7IHMcHutfLEtTYcnXCuM8bOfEkb0wAjlMivzTYNsO7UWQWbI933XnuP+mN84QQLmW4CKHug0fayiIh+D1Q7qo6L4Fd/j+RO3AWA+0EuCAl/gSuS0c4E35lyBicaC7VbgcnHY4WKp/pXkVYRMihCbNRtkKTv7Dw7ZV+n6JWAYYj4GhyDnHJpLaAjOI2moU/8zOa7Ot1fPu+vBjTL6JlDeKYcTprmh0uDjjkh4aXgwK3lpGlNrudnp3CK4HF1/mW1lphEBOx98vd6EYyFBPGP99keSekHS/iqcSoiwfsjK6fUPttD4yCFMa9PigFWy1AZ2DsvUmZ+gONKUc+180306bzdXDSYx4D/v2nA7toICDrl74xQXdV50QPBUSG/68wwlUigTMBDg9Zx+zhck7WmkDuQXTaxdXYG2JzpL5OY+rFp2qoCN0SlgrepFtmIFtoWkwoJyMal+L1ato3POaU362zgn6jRmQ9FRKKJpuO72nHV2+cWlvdAAAAA="), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HONEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HONEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

