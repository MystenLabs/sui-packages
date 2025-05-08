module 0x53f7a384ba5dd781ac50ecc9e558d235ee469d3a444d9312c38673887fb7fde9::bosu {
    struct BOSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOSU>(arg0, 6, b"BOSU", b"Book Of Sui", x"0a4d656d65636f696e206f6e20746865206d6f737420446567656e20636861696e202b2054686973206469676974616c20626f6f6b206973206c696e6b65642077697468206d6574616461746120746f2074686520746f6b656e20616e642074686520426f6f6b20686173206576656e206d6f7265206c696e6b7320746f20696d616765732073746f726564205355492f4f4e434841494e202b204120646563656e7472616c697a656420736f6369616c206e6574776f726b20617070202b20546f6f6c7320746f20637265617465206d656d6573202b20434330204d656d6520436c697061727420436f6c6c656374696f6e202d20616c6c20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1746740921651.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOSU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOSU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

