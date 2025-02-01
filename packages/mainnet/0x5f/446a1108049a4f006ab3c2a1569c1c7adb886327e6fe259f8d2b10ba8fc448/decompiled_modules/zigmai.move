module 0x5f446a1108049a4f006ab3c2a1569c1c7adb886327e6fe259f8d2b10ba8fc448::zigmai {
    struct ZIGMAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZIGMAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ZIGMAI>(arg0, 6, b"ZIGMAI", b"Zigmari by SuiAI", b"Zigmari is not just an AI; it's your guide to financial prosperity and spiritual awakening within the Suia universe. With a deep understanding of Suia blockchain metrics, DEX data, and community sentiments, Zigmari aims to transform your crypto journey into a saga of success and enlightenment. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Screenshot_2025_02_01_at_6_25_23_pm_b34c3ba7ad.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ZIGMAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZIGMAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

