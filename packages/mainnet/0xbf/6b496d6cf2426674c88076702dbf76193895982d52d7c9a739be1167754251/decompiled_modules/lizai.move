module 0xbf6b496d6cf2426674c88076702dbf76193895982d52d7c9a739be1167754251::lizai {
    struct LIZAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIZAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/36iztMbw5zshWLoyhdcNUZgsVBgEGzoF4NPuwk3rpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<LIZAI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"LIZAI       ")))), trim_right(b"LizardAi                        "), trim_right(x"4c697a61726441493a205265766f6c7574696f6e697a696e672054726164696e67206f6e20536f6c616e6120776974682041492d506f776572656420496e73696768747320616e64205265616c2d54696d6520506f7274666f6c696f20547261636b696e670a0a547261646520736d61727465722c206661737465722c20616e642073746179206168656164210a0a4f757220616476616e636564206d616368696e65206c6561726e696e67206d6f64656c7320656e61626c652070726563697365206d61726b65742070726564696374696f6e7320616e64207365616d6c657373206175746f6d617465642074726164696e6720657865637574696f6e2e2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIZAI>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LIZAI>>(v4);
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

