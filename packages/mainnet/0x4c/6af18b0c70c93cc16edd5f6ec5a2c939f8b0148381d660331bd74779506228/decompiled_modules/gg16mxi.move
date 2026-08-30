module 0x4c6af18b0c70c93cc16edd5f6ec5a2c939f8b0148381d660331bd74779506228::gg16mxi {
    struct GG16MXI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GG16MXI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GG16MXI>(arg0, 0, b"GG16MXI", b"Sui Blue Gift Owner G16MXI", b"Sui Blue Gift mainnet Gift owner smoke token", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GG16MXI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<GG16MXI>>(0x2::coin::mint<GG16MXI>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GG16MXI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

