module 0xb5fcd256268e3d95c5cd04bead1436b1e0fe14c93f33cede48d112f0d43e108b::stcoin {
    struct STCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: STCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STCOIN>(arg0, 6, b"STCOIN", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STCOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

