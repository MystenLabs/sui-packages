module 0x6e70a66f92bffa110576a0536291395f5adeb9924272da800e17b79b209c1571::fighta {
    struct FIGHTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIGHTA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"hoQRuyjin-k2vnh5                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<FIGHTA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"FIGHT       ")))), trim_right(b"$FIGHT                          "), trim_right(x"244649474854202054686520556c74696d61746520436f6d6261742053706f727473204d656d6520436f696e200d0a5374657020696e746f20746865204f637461676f6e206f662043727970746f20776974682024464947485420207468652066697273742d65766572206d656d6520636f696e206275696c7420666f722066696768742066616e732c2073706f72747320626574746f72732c20616e6420616472656e616c696e65206a756e6b69657321205768657468657220796f7572652062657474696e67206f6e20746865206e65787420554643206368616d702c2063616c6c696e6720612066697273742d726f756e64204b4f2c206f72206a757374206c6f76652074686520746872696c6c206f6620636f6d6261742073706f7274732c2024464947485420697320796f7572207469636b657420746f20766963"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIGHTA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FIGHTA>>(v4);
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

