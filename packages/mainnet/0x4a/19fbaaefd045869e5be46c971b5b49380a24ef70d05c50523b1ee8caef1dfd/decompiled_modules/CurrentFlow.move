module 0x4a19fbaaefd045869e5be46c971b5b49380a24ef70d05c50523b1ee8caef1dfd::CurrentFlow {
    struct CURRENTFLOW has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<CURRENTFLOW>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CURRENTFLOW>>(0x2::coin::mint<CURRENTFLOW>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: CURRENTFLOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CURRENTFLOW>(arg0, 6, b"CURRENTFLOW", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CURRENTFLOW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CURRENTFLOW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

