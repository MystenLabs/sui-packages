module 0xa7359ac04951c879fa61155f0a3aba51a9fefbfdd489b95a894c411254e8f2de::kingm {
    struct KINGM has drop {
        dummy_field: bool,
    }

    fun init(arg0: KINGM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<KINGM>(arg0, 6, b"KINGM", b"KingMidas", b"Everything | touch always turns golden or in this case to Bitcoin. Let me help you turn your $l into a golden Bitcoin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_6514_eb438fe064.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KINGM>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KINGM>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

