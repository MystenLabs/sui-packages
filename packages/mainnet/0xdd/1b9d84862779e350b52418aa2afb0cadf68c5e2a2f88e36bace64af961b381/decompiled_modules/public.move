module 0xdd1b9d84862779e350b52418aa2afb0cadf68c5e2a2f88e36bace64af961b381::public {
    struct PUBLIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUBLIC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/8k1AuvYeKJaEhUkdr8ZdfTipY2picvYSxvx4ftHs3prR.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PUBLIC>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"PUBLIC      ")))), trim_right(b"Going Public                    "), trim_right(x"46616e20546f6b656e20666f7220476f696e67205075626c69632e0a0a54686520666972737420696e74657261637469766520736572696573206f6e2058204f726967696e616c732028546865204e6574666c6978204b696c6c6572292c20776865726520796f7520646f6e74206a757374207761746368796f752063616e20696e766573742e2057652074616b6520796f7520626568696e6420746865207363656e657320617320616d626974696f757320666f756e64657273206e6176696761746520686967682d7374616b6573206d6f6d656e74732c20616c6c207768696c6520746f7020696e766573746f727320776569676820696e2077697468207261772c20756e66696c74657265642074616b65732e204e6f2076656c76657420726f7065732c206e6f20636c6f73656420646f6f72736a7573742064697265"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUBLIC>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUBLIC>>(v4);
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

