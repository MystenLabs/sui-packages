module 0x1cec4c37c4d6ef1b5d6f0c9cb8e6958a243557a6b42adddf721e29e265f0c741::bluz {
    struct BLUZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUZ>(arg0, 6, b"BLUZ", b"bluz", b"just bluz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/reward_122c64218a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

