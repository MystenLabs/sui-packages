module 0x3d19ee353aab1168be294593377daec29c70a85d4da313a7703018e9c72362dc::two {
    struct TWO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TWO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TWO>(arg0, 6, b"TWO", b"MEWTWO", b"Relaunch", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreih2vjqyqdfbch5wlfskoss6yil7s3c2n2mslpmftd6dxiclvi5uru")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TWO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TWO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

