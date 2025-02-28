module 0xa1108f9a030318a75c9b2bfb337ad4d3b7759775470a91c9a6c261e89425960e::bobmoona {
    struct BOBMOONA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOBMOONA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"oWXYaSrwaVr70M-7                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BOBMOONA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BobMoon     ")))), trim_right(b"$BMOON                          "), trim_right(x"224865792c20496d20426f622120492077656e74206372617a792066726f6d20616c6c2074686f7365207275672070756c6c7320746861742068617070656e656420746f206d652c206275742049207374696c6c206c6f7665206d656d6520636f696e732e2049206a75737420686f706520496d206e6f742067657474696e67206576656e206d6f7265207374757069642062656361757365206f66207468656d21220d0a0d0a426f62204d6f6f6e206973206865726520746f206272696e6720736f6d652066756e20616e642073746162696c69747920746f207468652077696c6420776f726c64206f66206d656d6520636f696e732e204e6f206d6f7265207363616d732c206e6f206d6f7265207275672070756c6c736a757374206120686f72736520776974682062696720647265616d732c2061206c6f766520666f"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBMOONA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOBMOONA>>(v4);
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

