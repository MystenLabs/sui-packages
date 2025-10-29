module 0x3462f998f92e4d3b630e4fb84a934f07bd24fea5b9d57c886f2c7690115f6eec::dust {
    struct DUST has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUST, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"cc56292790027dbc961d3b7489049fc0099864c9409488e67279f735ce40c586                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<DUST>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"DUST        ")))), trim_right(b"Phantom Bucket Full Of Dust     "), trim_right(x"48616c6c6f7765656e73206372656570696e672075702e2045766572796f6e6573206f757420746865726520736d696c696e6720776964652c20686f617264696e672063616e64792c20666c6578696e6720636f7374756d657320206c6976696e6720746865697220626573742073756761722072757368206c6966652e20427574206e6f7420796f752e20596f7572652062726f6b652e204e6f207377656574732e204e6f207472656174732e204a7573742061205068616e746f6d2077616c6c65742066756c6c206f662062726f6b656e20647265616d7320616e6420647573742020746865206b696e64206f6620746f6b656e73206e6f206f6e65732065766572206865617264206f662e0a0a456d6f74696f6e616c6c792c20796f7564206665656c20626574746572206275726e696e67207468656d20616c6c2c20"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUST>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUST>>(v4);
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

