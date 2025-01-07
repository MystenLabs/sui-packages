module 0xc0ebc8c54833fabb7f00cdc0359b0c012d28ec27eabd6b6497e47c1d564843d4::voltd {
    struct VOLTD has drop {
        dummy_field: bool,
    }

    fun init(arg0: VOLTD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://photos.pinksale.finance/file/pinksale-logo-upload/1735526209959-efda81f23b9b068fee6c40f0d2315557.jpg";
        let v1 = if (0x1::vector::length<u8>(&v0) > 0) {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1735526209959-efda81f23b9b068fee6c40f0d2315557.jpg"))
        } else {
            0x1::option::none<0x2::url::Url>()
        };
        let (v2, v3) = 0x2::coin::create_currency<VOLTD>(arg0, 9, b"VOLTD", b"VoltDoge", x"566f6c74446f67652069732061206d656d6520746f6b656e206275696c74206f6e2074727573742c207472616e73706172656e63792c20616e642061207374726f6e6720636f6d6d756e6974792e2057697468206120636c656172206d697373696f6e2c20566f6c74446f67652069732073657420746f206265636f6d65206f6e65206f6620746865206c656164696e67206d656d6520746f6b656e7320696e2074686520776f726c642e20e29aa1", v1, arg1);
        let v4 = v2;
        if (300000000000000000 > 0) {
            0x2::coin::mint_and_transfer<VOLTD>(&mut v4, 300000000000000000, 0x2::tx_context::sender(arg1), arg1);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VOLTD>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<VOLTD>>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

