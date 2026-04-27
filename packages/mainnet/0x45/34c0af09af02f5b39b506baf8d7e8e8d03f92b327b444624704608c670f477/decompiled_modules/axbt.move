module 0x4534c0af09af02f5b39b506baf8d7e8e8d03f92b327b444624704608c670f477::axbt {
    struct AXBT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AXBT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AXBT>(arg0, 6, b"AXBT", b"AXBT", b"Launched on Odyssey", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AXBT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AXBT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

