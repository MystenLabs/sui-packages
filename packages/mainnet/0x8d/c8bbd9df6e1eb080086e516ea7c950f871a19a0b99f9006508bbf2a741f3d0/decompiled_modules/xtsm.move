module 0x8dc8bbd9df6e1eb080086e516ea7c950f871a19a0b99f9006508bbf2a741f3d0::xtsm {
    struct XTSM has drop {
        dummy_field: bool,
    }

    entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<XTSM>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<XTSM>>(0x2::coin::mint<XTSM>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: XTSM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XTSM>(arg0, 9, b"XTSM", b"XTSM Token", b"XTSM Token (Sui Coin standard).", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XTSM>>(v0, v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<XTSM>>(v1, v2);
    }

    // decompiled from Move bytecode v7
}

