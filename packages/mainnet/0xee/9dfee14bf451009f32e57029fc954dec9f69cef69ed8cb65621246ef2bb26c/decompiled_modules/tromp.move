module 0xee9dfee14bf451009f32e57029fc954dec9f69cef69ed8cb65621246ef2bb26c::tromp {
    struct TROMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TROMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/C2JcKNK8f4CZGajZYTJ9JxLFdP2EezDbG5t92T4npump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<TROMP>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"TROMP       ")))), trim_right(b"OFFICIAL TROMP                  "), trim_right(x"54524d503a2054484520505245534944454e54204f4620414c4c204d454d4520434f494e530a0a576861746576657273207472656e64696e672077697468205472756d70206973207472656e64696e6720776974682054524f4d50210a0a2454524f4d50206973206120536f6c616e612d706f7765726564206d656d6520636f696e206275696c7420666f722074686520636f6d6d756e6974792c2062792047726f6b20616e642061204b59432d766572696669656420554b2f55532d6c656420446576205465616d2e20496e73706972656420627920776f726c64206576656e74732c20746865206d656d6561626c65205472756d7020707265736964656e63792c20616e6420676c6f62616c206368616f732c202454524f4d502069732061207472616e73706172656e742c20646576656c6f7065722d64726976656e20"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TROMP>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TROMP>>(v4);
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

