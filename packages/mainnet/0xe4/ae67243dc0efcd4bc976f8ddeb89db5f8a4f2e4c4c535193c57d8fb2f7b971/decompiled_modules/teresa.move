module 0xe4ae67243dc0efcd4bc976f8ddeb89db5f8a4f2e4c4c535193c57d8fb2f7b971::teresa {
    struct TERESA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TERESA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"cb528d13e51bb32a093b6ca488d0e9028e36f0ae0c204ac766b3be0e97a39448                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<TERESA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Teresa      ")))), trim_right(b"Jail Teresa Stokes              "), trim_right(x"5465726573612053746f6b65732069732074686520726561736f6e204972796e6120697320646561642e200a0a53686520616c6c6f7765642074686174206372696d696e616c20746f2077616c6b20667265652c206166746572203134207072696f72206f6666656e736573202d20696e636c7564696e672061737361756c7420616e642061726d656420726f62626572792e20200a0a497420636f756c642068617665206265656e2070726576656e7465642e20200a0a53686520697320676f696e6720766972616c20666f72204e4f5420686176696e672061206c6177206465677265652e0a0a4a757374696365206d757374206265207365727665642e20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TERESA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TERESA>>(v4);
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

