module 0x478e2ad06bed73943e12824466f1e4d04a30699bf414d4ec1c75485763faa2ed::home {
    struct HOME has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOME>(arg0, 6, b"HOME", b"Sui Home", x"486f6d652069732061206e6577206d656d65636f696e206f6e2074686520737569206e6574776f726b2c20776869636820686173206120766973696f6e206f66206265636f6d696e67206120636f6d666f727461626c6520686f6d6520666f7220616c6c20737569206e6574776f726b2075736572732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000057916_c00caacb59.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOME>>(v1);
    }

    // decompiled from Move bytecode v6
}

