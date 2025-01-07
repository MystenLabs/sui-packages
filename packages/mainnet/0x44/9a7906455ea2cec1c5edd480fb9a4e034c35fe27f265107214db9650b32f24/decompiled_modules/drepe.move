module 0x449a7906455ea2cec1c5edd480fb9a4e034c35fe27f265107214db9650b32f24::drepe {
    struct DREPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DREPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DREPE>(arg0, 6, b"DREPE", b"Dragon Pepe", x"447261676f6e2050657065202d2074686520737570657220706f77657266756c206d656d6520636f6d62696e6174696f6e20636f696e2e0a0a5765206172652061626f757420696d6167696e6174696f6e2c206372656174697669747920616e642066756e2e0a0a546865206675747572652069732062726967687421", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tiny_d769b46fed.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DREPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DREPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

