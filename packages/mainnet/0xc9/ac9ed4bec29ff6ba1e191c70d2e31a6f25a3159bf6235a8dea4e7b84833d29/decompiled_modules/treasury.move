module 0xc9ac9ed4bec29ff6ba1e191c70d2e31a6f25a3159bf6235a8dea4e7b84833d29::treasury {
    struct TREASURY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TREASURY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"556f3a5517a1c3c553e18f3970841b4de821386306683a6b0782972597ce0aed                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<TREASURY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Treasury    ")))), trim_right(b"Treasury Coin                   "), trim_right(x"54686520547265617375727920436f696e206973206275696c7420736f2074686520666c6f6f7220707269636520616c7761797320636c696d62732c206e6f206d6174746572207768617420646972656374696f6e2074686520707269636520616374696f6e206d6f7665732e0a486572657320686f7720697420776f726b733a204576657279207472616e73616374696f6e20636f6d6573207769746820612031252063726561746f72207265776172642e20496e7374656164206f662063617368696e67206f75742c2077652077696c6c207075742031303025206f6620697420496e2061205472656173757279205661756c742c20746f206265207065726d616e656e746c79206c6f636b65642e20417320766f6c756d6520696e637265617365732c206d6f726520616e64206d6f726520737570706c792067657473"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TREASURY>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TREASURY>>(v4);
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

