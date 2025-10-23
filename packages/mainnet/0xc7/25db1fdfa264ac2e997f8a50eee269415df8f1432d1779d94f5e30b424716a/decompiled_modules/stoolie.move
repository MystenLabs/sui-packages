module 0xc725db1fdfa264ac2e997f8a50eee269415df8f1432d1779d94f5e30b424716a::stoolie {
    struct STOOLIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: STOOLIE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"14fbe725801564ecf684fdc58a00d40a40590abe4a969b57fb107a501b796cba                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<STOOLIE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"STOOLIE     ")))), trim_right(b"Stoolie Coin                    "), trim_right(x"57652772652073656e64696e67204461766520506f72746e6f7920313025206f66207468652063697263756c6174696e6720737570706c792c20746f20646f6e61746520746f20686973206661766f72697465206368617269746965732120506c75732c20446176652077696c6c207265636569766520616c6c207472616e73616374696f6e204645455320666f722068697320706572736f6e616c207573652e20424f54482073686f756c64207265616c6c792068656c7020746f206d6f746976617465204461766520746f206a6f696e206f757220636f6d6d756e69747920616e6420737570706f7274202353746f6f6c69652c206c6f6e672d7465726d21200a0a4e6f207363616d6d6572732c206e6f205255474749455320616e64204e4f20224765726d792044616e73222e2e2053544f4f4c494553206f6e6c7921"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STOOLIE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STOOLIE>>(v4);
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

