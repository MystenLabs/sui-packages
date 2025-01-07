module 0x824a4fc9e989019b40c3a218b71ddec54cf7909c0200b38220c97f8947877b49::suirm {
    struct SUIRM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRM>(arg0, 6, b"Suirm", b"SUIRM", x"24535549524d3a205377696d6d696e67204974732057617920746f20746865204d6f6f6e2120f09f9a80f09f909ff09f8c950a0a4469766520696e746f207468652063727970746f206f6365616e20776974682024535549524d2c20746865206d656d6520636f696e20746861742773206d616b696e6720776176657320696e2074686520626c6f636b636861696e20776f726c642120f09f90a0e29ca820546869732061717561746963206d617276656c206973206e6f74206a757374206120636f696e3b2069742773206120746964616c2077617665206f6620636f6d6d756e6974792c2066756e2c20616e64206c756e617220616d626974696f6e732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733564619096.PNG")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIRM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

