module 0x2066ad1b3c47aa3bb134dbf0ec999186ac34e70d0dd5b3664963a710221fcd41::charlie {
    struct CHARLIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHARLIE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"fmnKl8XhayOoNknR                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<CHARLIE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"CHARLIE     ")))), trim_right(b"CoinMarketCat                   "), trim_right(x"24434841524c49452c20616c736f206b6e6f776e2061732022436f696e4d61726b65744361742220686173206265656e2073697474696e6720696e206120436f696e4d61726b65744361702063756269636c652073696e6365206865207761732061646f7074656420627920616e20656d706c6f79656520696e20323032332e20416c74686f756768206c6976696e67207468652068696768206c69666520696e2063727970746f2773206d6f73742066616d6f757320636f6d70616e7920686173206265656e2067726561742c2024434841524c494520647265616d73206f66206d6f72652e2048652773206c61756e6368696e6720686973206e6577206d656d6520636f696e206f6e204d6f6f6e73686f74210d0a0d0a24434841524c49452077696c6c20627265616b20616c6c207265636f726473206f6e204d6f6f6e"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHARLIE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHARLIE>>(v4);
    }

    fun trim_right(arg0: vector<u8>) : vector<u8> {
        let v0 = 32;
        let v1 = &v0;
        while (0x1::vector::length<u8>(&arg0) > 0) {
            if (0x1::vector::borrow<u8>(&arg0, 0x1::vector::length<u8>(&arg0) - 1) != v1) {
                break
            };
            0x1::vector::pop_back<u8>(&mut arg0);
        };
        arg0
    }

    // decompiled from Move bytecode v6
}

