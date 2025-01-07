module 0xe65025e4f7d555763660e9451e5ba1f1f95cfaeb3d607dbd54ee51af872c3564::MORFEY {
    struct MORFEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MORFEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MORFEY>(arg0, 9, b"MORFEY", b"S. Morpheus Ulixes amicus est", b"The Official Unofficial Sui Mascot. The First Meme Fair Launch Platform on SUI Network. We are bullish on the future of the Sui. To the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn4.cdn-telegram.org/file/qVHomTUGNzKv1frWE2T_GwLOtP9OBInwY0P_O1cUOCbolH4Q9N9S27V9Dsj3w3Mx11YAeClBEOMofCRiqqoIUTsFBlrRLM0zG7Uv02o0zykxz9sBtE8KyIUaB9TidWuOSHIpH2QwpqmTgjbvXM4DVECBf99-9KnC0v9i73IlkPUi9aN6pipRKDrP-nunDJkqMEf4_Ui1bUkbkQzbyyiFJu3AZafqryBFfKdqS_AeDeZaTkT-cZ5mLGfN0j5Jo6HAGIwkxu5dqPkz7xFkh96YfatOeIWLxpce6k-hLLyhc6V2oWLy0jujAR8rR4KwC_ASN89D0kUJuGQOPhOQDCRUnA.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MORFEY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<MORFEY>>(0x2::coin::mint<MORFEY>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MORFEY>>(v2);
    }

    // decompiled from Move bytecode v6
}

