module 0x7952b17ed79ad43f3f2e23176ed60a0a3e3ccb78ff8324e231a887a45b048b97::zeros {
    struct ZEROS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZEROS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZEROS>(arg0, 6, b"ZEROS", b"ZEROS coin", b"ZEROS coin description", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZEROS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZEROS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

