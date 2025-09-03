module 0x191845ba5e5a5f3e960ac5371d308f845d9c40a1cb375abd0c03c00e6bf97f3a::mlue {
    struct MLUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MLUE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/64FJMn61GCVdA9aeqUu1EXtRVdYYbFw5WfXCCDBspump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MLUE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MLUE        ")))), trim_right(b"MLUE Color                      "), trim_right(x"4f6e63652075706f6e20612074696d652c2074686520696e7465726e657420676176652075732061206c6567656e64617279206d6f6d656e743a204120626f79207761732061736b65642c2047697665206d65206120636f6c6f72207468617420737461727473207769746820746865206c6574746572204d2e2068652070726f75646c7920616e7377657265643a204d4c5545210a5769746820244d4c5545202c2077657265206275696c64696e672074686520666972737420636f6d6d756e6974792074686174207475726e732061206d656d6520696e746f2061207265616c20636f6c6f722e200a42656361757365207768656e20796f752062656c6965766520696e204d4c55452c20796f7520737461727420746f20736565204d4c5545204d4c554520436f6c6f72202054686520436f696e206f66207468652057"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MLUE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MLUE>>(v4);
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

