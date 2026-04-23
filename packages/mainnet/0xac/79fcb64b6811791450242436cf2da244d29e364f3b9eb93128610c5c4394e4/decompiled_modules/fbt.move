module 0xac79fcb64b6811791450242436cf2da244d29e364f3b9eb93128610c5c4394e4::fbt {
    struct FBT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FBT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FBT>(arg0, 6, b"FBT", b"FBT", b"Launched on Odyssey", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FBT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FBT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

