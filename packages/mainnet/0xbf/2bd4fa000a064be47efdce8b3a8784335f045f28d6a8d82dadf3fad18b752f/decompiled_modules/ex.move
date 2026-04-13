module 0xbf2bd4fa000a064be47efdce8b3a8784335f045f28d6a8d82dadf3fad18b752f::ex {
    struct EX has drop {
        dummy_field: bool,
    }

    fun init(arg0: EX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<EX>(arg0, 6, b"EX", b"Test", b"", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRoAFAABXRUJQVlA4IHQFAABwHQCdASqAAIAAPm00lkekIyIhJxgJ6IANiWQA1qXvfqupJ9o/FD8o/kspT9L/F3qA/R3qi5386Pxn85/NnUK8wD9Nf1R6wHmA/bPqH+gB/Uv+j1h3oAeWn7I/9r/5/7ldgB//9g27LLIv90YkZxQ4dVBDTfIG+qXA9viye9WaKR++5i5TT8rTQCDgOcKFLHvLmE+Y1jicWu+VZSlF0zAXWW9mOxTf1bbH5LC9CQ1FrRIGm8W26K+h4SJszwh5BKAlVIoqWL7mqb/ITskbFiT23F/HsfAC4q23qn6lyubAQ/jUfAwOleofLrr/mBLNokl9wVWAAP7Lt/3q70n3xasP9qvC2YxjaAAMh6sqsxvu4X2nC278xZKN1/e7WpSYuF5Vi5ub9jXV0CKxtADpFcY6iX8Yd7nW/ZWrGTsxBbb5CSdU5zXrHTf2d2yNFpKlMHkg+rz30IX6M1k0enshIsi/ISp67evmod/0ndlJKuj8otTf4J4CA47wgZdC12kz+j8JzUVvtgunyAokQjMv3qO0efSPy7ZwEhxIMzEXSWoMUbTI2Zeqib2MvaulYYXQvrFws+KN55HkLnrZMeB7FUHuMlCP/cOewaxOY8D5NQo8Dry3GHlYg1s2a6tRTPPQwt6LBehlAfec86ABjgV3UGF0i5VL5a8KB4+CFFJoGM4jiQXp3EHF+OejmJFl4EwO/vqTQ3skYKrYs6mcarS8DLskHuBEEw7rHQhiZ3ZWBKSvUSEVJ7y43tp/KoMEMPTGbCjGSj/Bns5fBlbDDlXaHsQdRwtldLmw+1cqAcV5Wr+tYSQE7ZqE18/CzxOSM6F/U25bP3K1jX+119yA5eABEJn6SIxW0u+by38H+2W7387rJ9u5njjU4bzChPf4719MYrtfD6sktnzDPfyespA7p18fH79g46b60LEg5+peDvkMl9rSgJ9FX3ynoRcwy4iVX2n+/AJVpTjRF64uy8Q7eWzEoh5s6ob86Les1jsc2jBiq1eS/MthD2R0XN52+2GmjhNZF8Xqzsy53BrYGkA462WRquv3bmhM/J5QoivaKcvpKayPt9TEoFhW/4Em3jJNiHyw3P7dZbl/Dh3o1KZdTxkO/rE6P3QKX33d4MGJqrKoyCJfVPxszeeQJdwMH5G29mqLl+SWcHM+mZqZ7fdPesEa7LcZa38QPrfR6LJpKDdUCb7lRPLA4OM7BQqCRCK25HbRQwZREqepUH43HYhIccdkWqCy7+VmedsBufjpAj2hgv2mAfu6pC2hP2GqirLcHX2uXAyWI5IM/LdJvRzhlfnc0ssLtnlwoV8c4aYM7hNJUciwI22l7kj+5V8obuPBBoPYiLxNF1ip9moPuPXWM47F1Q6Rrj0UIGombnO5N1E4UmAt0SVDG95dDxFnVInSFeFC8jC+fw5MVypOO+aorWmmaMtcTiM333cGG3dAU7vID5ubIZbsRpqIHN4oznS39wWzWjFsckieBm/vNFN7wgKmeRfwu/ch2n3YqEIBmwenU9eFntEodRIJSNfvWbYeKp2RU3IKyEA2F8XNttySL3yGYjn/1rvP1M7veM2mfwvHoC3O77wc2YM7iuiNajaxRKYdHKRsXwKgRCrZMiMAWp8y/fkDEuwTSoCf9glraNK88OogLdwCO/PbrzaBVeNcV7MIELzjh/NDXJukLEitGBQxyJmfmdAsRz069+Gfwo0X9u359TwP35h2jC4TH1EZPqlFF6flcL/A9UacyVo9/+zcFvPi2p4x5+nOcfX8YYWRlGUTYK097fpoGtlsfv/OPYDfK7CgE/KQ66K05SjGmBmWk/1IfDuuEoJSfVrUUp6yGXK5MxNs7i9+EUodQP4FAGgAAAAA"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EX>>(v1);
    }

    // decompiled from Move bytecode v6
}

