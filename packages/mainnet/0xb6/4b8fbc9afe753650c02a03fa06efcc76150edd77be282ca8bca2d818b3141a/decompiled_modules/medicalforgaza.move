module 0xb64b8fbc9afe753650c02a03fa06efcc76150edd77be282ca8bca2d818b3141a::medicalforgaza {
    struct MEDICALFORGAZA has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<MEDICALFORGAZA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MEDICALFORGAZA>>(0x2::coin::mint<MEDICALFORGAZA>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MEDICALFORGAZA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEDICALFORGAZA>(arg0, 9, b"MEDICAL FOR GAZA", b"MFG", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<MEDICALFORGAZA>>(0x2::coin::mint<MEDICALFORGAZA>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEDICALFORGAZA>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MEDICALFORGAZA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

