module 0x2955d298e1d06e645a2165f1c6e056b10dc1dae8d0a5eadea7a30d5480d9fd9c::bcc {
    struct BCC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BCC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/5bCoEbADG2WLx6rQCXEs4p7BdnFEMkKhfM5SJmbNpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BCC>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BCC         ")))), trim_right(b"BLUE COLLAR CRYPTO              "), trim_right(x"424c554520434f4c4c41522043525950544f2028424343290a426c756520436f6c6c61722043727970746f202842434329206973206120636f6d6d756e6974792d64726976656e206d656d6520636f696e2064657369676e656420746f20737570706f727420626c75652d636f6c6c617220776f726b65727320616e6420656d706f776572207468656d20696e20746865206469676974616c2065636f6e6f6d792e2057697468206120666f637573206f6e20656475636174696f6e2c207370656e64696e672c20616e642066696e616e6369616c20656d706f7765726d656e742c204243432061696d7320746f2063726561746520616e2061636365737369626c6520706c6174666f726d20666f7220776f726b65727320746f206c6561726e2061626f75742063727970746f63757272656e63792c207370656e64207468"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BCC>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BCC>>(v4);
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

