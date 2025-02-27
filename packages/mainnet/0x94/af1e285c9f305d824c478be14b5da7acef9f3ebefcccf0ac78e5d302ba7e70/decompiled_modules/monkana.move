module 0x94af1e285c9f305d824c478be14b5da7acef9f3ebefcccf0ac78e5d302ba7e70::monkana {
    struct MONKANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONKANA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/22amBVCHPF1JgF181jxrNe5nDwg6Ta3NEh8n2QvRpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MONKANA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MonkanA     ")))), trim_right(b"MonkanA                         "), trim_right(x"496e20746865206865617274206f662074686520626c6f636b636861696e2c207768657265206279746573207261636520666173746572207468616e206120676f72696c6c6120696e20686561742c2061206c6567656e6420697320626f726e3a2068616c66206d6f6e6b65792c2068616c662062616e616e612c20616e6420636f6d706c6574656c7920696e73616e65200a0a4d6f6e6b616e412c207468652053757072656d65204b696e67206f6620536f6c616e612120202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONKANA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MONKANA>>(v4);
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

