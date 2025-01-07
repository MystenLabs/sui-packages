module 0x2076506802cfdf80533f90e9b973fe5d2d258c3c86ce57249f91a017b5d9877c::yizuo {
    struct YIZUO has drop {
        dummy_field: bool,
    }

    fun init(arg0: YIZUO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YIZUO>(arg0, 8, b"YIZUO", b"YIZUO", b"this is yizuo coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YIZUO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YIZUO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

