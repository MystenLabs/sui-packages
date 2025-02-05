module 0xbcc296b4b5170d6ad92a5b04e161e57a92cc9d701e4915f8766e46deb8fd9e17::suvarna {
    struct SUVARNA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUVARNA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/ALSHzSP363jtG3JrpA4o6XWNaQyp3p6pPpV2zuEMUwbB.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SUVARNA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Suvarna     ")))), trim_right(b"Only A Million                  "), trim_right(x"2a2a4f6e6c792061204d696c6c696f6e20546f6b656e202054686520506f77657220426568696e642047454f4c542044414f2a2a20200a0a54686520204f6e6c792061204d696c6c696f6e202853555641524e412920546f6b656e202069732073657420746f206265636f6d65207468652020676f7665726e696e6720666f726365206f662044414f2c206d616b696e67206974206120747275652067616d652d6368616e67657220696e20646563656e7472616c697a656420414920616e6420626c6f636b636861696e20676f7665726e616e63652e200a0a57697468206120666978656420737570706c79206f66206a75737420312c3030302c30303020746f6b656e73202c202053757661726e6120656e7375726573202073636172636974792d64726976656e2076616c7565202c20676976696e6720686f6c646572"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUVARNA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUVARNA>>(v4);
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

