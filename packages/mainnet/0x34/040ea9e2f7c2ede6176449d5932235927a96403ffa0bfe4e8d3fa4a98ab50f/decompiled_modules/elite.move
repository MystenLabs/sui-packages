module 0x34040ea9e2f7c2ede6176449d5932235927a96403ffa0bfe4e8d3fa4a98ab50f::elite {
    struct ELITE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELITE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"VbUP63HOJxlsBpEM                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<ELITE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"ELITE       ")))), trim_right(b"New Wealthy Elite               "), trim_right(x"496e20323031312c2061206c6567656e6461727920426974636f696e54616c6b20706f737420626f6c646c79206465636c617265643a2057652061726520746865206e6577207765616c74687920656c6974652c2067656e746c656d656e2e0d0a0d0a4e6f77207265646973636f7665726564206f766572206120646563616465206c617465722c207468617420666f72676f7474656e2074687265616420686173206265636f6d6520612073796d626f6c206f66206561726c7920426974636f696e2070726f70686563792020616e642024454c49544520697320697473207265766976616c2e0d0a0d0a4120746f6b656e20666f7220746865206e6578742067656e65726174696f6e206f662063727970746f20656c697465732e204261636b6564206279207265616c206c6f72652e204275696c7420666f7220766972"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELITE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ELITE>>(v4);
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

