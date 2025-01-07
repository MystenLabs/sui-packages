module 0xf1b33a1ca2b56e5aac8231e425b72b58aaabbe29572840a7e2df46f8f6b007d8::hro {
    struct HRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HRO>(arg0, 6, b"Hro", b"RRR", b"gRRRR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sasuke_uchiha_vs_naruto_a184cc4dfb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

