module 0xe8ea5a69f51ed0d58cb6b30b6a4101aac83ea7a665a622b3c9da0c63bbc66a47::winter {
    struct WINTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: WINTER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"2ac26a9e7639943bb9bc045a6252e998774f590364326944160addd93123e991                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<WINTER>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"WINTER      ")))), trim_right(b"WINTER ARC                      "), trim_right(x"57696e746572204172632069736e74206a757374206120746f6b656e206974732061206d696e647365742e0a546865206d6f6e746873206f662072656c656e746c65737320657865637574696f6e206c69652061686561642e0a5768696c65206f746865727320736974206f6e2074686520736964656c696e65732c207765726520737461636b696e6720616e64206f7574776f726b696e672074686520656e746972652073706163652e0a57696e7465722072657761726473207468652070726570617265643a206561726c79206275696c646572732c20616e6420747275652062656c69657665727320726561647920746f206772696e64206265666f7265207468652063726f77642077616b65732075702e0a5475726e206368696c6c20696e746f206d6f6d656e74756d2c2057696e74657220417263206973206f6e"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WINTER>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WINTER>>(v4);
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

