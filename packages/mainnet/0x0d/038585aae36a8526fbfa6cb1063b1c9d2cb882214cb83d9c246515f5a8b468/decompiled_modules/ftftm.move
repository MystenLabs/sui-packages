module 0xd038585aae36a8526fbfa6cb1063b1c9d2cb882214cb83d9c246515f5a8b468::ftftm {
    struct FTFTM has drop {
        dummy_field: bool,
    }

    fun init(arg0: FTFTM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FTFTM>(arg0, 6, b"FTFTM", b"FTFTM", b"Launched on Odyssey", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FTFTM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FTFTM>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

