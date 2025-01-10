module 0x29b01af2184c82c8a1b053b6a7aceb921806f6bfe2b03c777b659c5a4c79e2de::elai {
    struct ELAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ELAI>(arg0, 6, b"ELAI", b"ELAI by SuiAI", b"Elly is a most amazing dog in the world ?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Ar_Ssam_2ca199667e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ELAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

