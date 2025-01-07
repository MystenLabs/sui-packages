module 0x97faf7103f60e97c11d56bd92c35eafb60cae62c13da441b9a6f2395a64614d3::homebound {
    struct HOMEBOUND has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOMEBOUND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOMEBOUND>(arg0, 6, b"HOMEBOUND", b"HOMEBOUND ", x"486f6d6520426f756e64204372697074207c20f09f9a8020496e6e6f766174696f6e20616e642067726f77746820696e207468652063727970746f20756e6976657273652e204920616d207468652053616c616d616e646572206f662074686520537569204e6574776f726b2c206865726520746f20677569646520796f7520746f776172642066696e616e6369616c2066726565646f6d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731086650563.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOMEBOUND>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOMEBOUND>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

