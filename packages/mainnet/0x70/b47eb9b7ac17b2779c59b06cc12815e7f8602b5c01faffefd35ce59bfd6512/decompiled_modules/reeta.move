module 0x70b47eb9b7ac17b2779c59b06cc12815e7f8602b5c01faffefd35ce59bfd6512::reeta {
    struct REETA has drop {
        dummy_field: bool,
    }

    fun init(arg0: REETA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"5c650168ec03e7513d0eab7ea584787106f2fadf04ed986af8f298b47a7f1a84                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<REETA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"REET        ")))), trim_right(b"Ctrl+Alt+DelCoin                "), trim_right(x"5468652063727970746f20776f726c642063616e206665656c206c696b652069742773206d61646520666f72207468652062696720706c61796572732c206c656176696e672065766572796461792070656f706c65207374727567676c696e6720746f206b6565702075702e0a497427732074696d6520746f206368616e676520746861742e20437472492b416c742b44656c436f696e20285245244554292069732061206672657368206e65772063727970746f63757272656e637920746861742773206275696c7420746f20676976652065766572796f6e6520612066616972206368616e636520746f20737563636565642e20496e737069726564206279207468652069636f6e696320437472492b416c742b44656c2073686f72746375742c2052455345542069732061626f757420726573657474696e6720746865"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REETA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REETA>>(v4);
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

