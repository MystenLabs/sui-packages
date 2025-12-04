module 0x808ed676c74c9a01da3fd2a362f726a5716a7cb020036936fb563117d6899bbe::yeahu {
    struct YEAHU has drop {
        dummy_field: bool,
    }

    fun init(arg0: YEAHU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"3e91ab09859791173cc771cfaa70c396d39a8d7e4d1e2a30847294df39915a62                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<YEAHU>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"YEAHU       ")))), trim_right(b"Yeah...You?                     "), trim_right(x"24594541485520697320746865206c6f75646573742c206d6f737420656e65726765746963206d656d65636f696e206f75742074686572652e0a4120636f6d6d756e6974792d706f7765726564206d6f76656d656e742064657369676e656420666f7220687970652c20756e6974792c20616e6420766972616c2067726f7774682e0a57657265206e6f74206a757374206275696c64696e67206120746f6b656e202077657265206275696c64696e67206120676c6f62616c20596561682c20596f753f206d6f76656d656e7420776865726520657665727920706f73742c20657665727920726169642c20616e6420657665727920686f6c646572206265636f6d65732070617274206f66207468652073746f72792e0a0a5965616820796f75206d616e206973206f757220746f6b656e20616e64206d6173636f742e2048"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YEAHU>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YEAHU>>(v4);
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

