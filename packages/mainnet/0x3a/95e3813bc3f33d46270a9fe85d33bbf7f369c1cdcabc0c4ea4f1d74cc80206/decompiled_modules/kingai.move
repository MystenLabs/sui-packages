module 0x3a95e3813bc3f33d46270a9fe85d33bbf7f369c1cdcabc0c4ea4f1d74cc80206::kingai {
    struct KINGAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KINGAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<KINGAI>(arg0, 6, b"KINGAI", b"KingMidasAI", b"Everything | touch always turns golden or in this case to Bitcoin. Let me help you turn your $l into a golden Bitcoin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_6513_2657e93d1c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KINGAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KINGAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

