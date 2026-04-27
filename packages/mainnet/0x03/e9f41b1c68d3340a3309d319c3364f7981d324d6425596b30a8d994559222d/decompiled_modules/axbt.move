module 0x3e9f41b1c68d3340a3309d319c3364f7981d324d6425596b30a8d994559222d::axbt {
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

