module 0xecdc1645e6ee066955ee90ffe5b3ae1172f6d4adf08e6a33d80ded40e2faf13f::npcai {
    struct NPCAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NPCAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<NPCAI>(arg0, 6, b"NPCAI", b"NPCAI by SuiAI", b"NPCAI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/images_12_f9d39f747b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NPCAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NPCAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

