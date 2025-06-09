module 0x4a81e98ddb6fff2fff9c0ef5dfc7ae60d93df827f6850e89872a0ebce7d8b95::mcga {
    struct MCGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCGA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/8oMfWcyg4M5eQKMqmCGL3Lpt7knDQumpWikfAYr5pump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MCGA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MCGA        ")))), trim_right(b"MAKE CALIFORNIA GREAT AGAIN     "), trim_right(x"4d616b652043616c69666f726e696120477265617420416761696e20244d4347410a0a43616c69666f726e696120776173206f6e6365207468652063726f776e206a6577656c206f662074686520556e69746564205374617465732e2050656f706c652066726f6d2061726f756e642074686520776f726c642061646d69726564206974732062656175747920616e6420666c6f636b656420746f20656e6a6f7920746865207765617468657220616e642072756220656c626f7773207769746820746865207269636820616e642066616d6f75732e200a0a5965617273206f662072657461726465642c206c69626572616c2c206e75742062616720706f6c69636965732068617665206c6566742074686520737461746520696e207368616d626c65732c2063756c6d696e6174696e6720696e207468652077696c646669"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCGA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MCGA>>(v4);
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

