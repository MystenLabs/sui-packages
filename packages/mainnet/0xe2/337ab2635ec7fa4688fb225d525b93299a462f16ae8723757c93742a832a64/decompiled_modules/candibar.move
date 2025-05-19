module 0xe2337ab2635ec7fa4688fb225d525b93299a462f16ae8723757c93742a832a64::candibar {
    struct CANDIBAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: CANDIBAR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/AfMyy9uiVM7Z3Twx3A8cc8V5jW8fY3escEgUX6tGnY4s.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<CANDIBAR>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"CANDIBAR    ")))), trim_right(b"CandiBar                        "), trim_right(x"4f75722070726f6a65637420756e697175656c7920626c656e64732041492d67656e657261746564206461696c7920686f726f73636f7065732077697468207472616461626c65206469676974616c2061737365747343616e646920636f6e66656374696f6e2d7468656d6564207a6f64696163204e4654732e205468657365204e46547320617265206e6f74206f6e6c7920636f6c6c65637469626c652062757420616c736f2066756e6374696f6e616c2c20617320746865792063616e2062652065786368616e67656420666f7220746f6b656e7320616e6420766963652076657273612c2070726f766964696e672074616e6769626c65207574696c6974792077697468696e206f75722065636f73797374656d2e0a0a467572746865726d6f72652c206f7572204e4654732061726520636f6d70617469626c652077"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CANDIBAR>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CANDIBAR>>(v4);
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

