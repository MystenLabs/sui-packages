module 0x30df077497677ba2d58d4225fb20b191e684c20778f76c66f7152534b4944d18::doodle {
    struct DOODLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOODLE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/87ibyCjJA1PbGvQA3bXF7c6FiNhE4eg9NMCVcwaPBAGS.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<DOODLE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"DOODLE      ")))), trim_right(b"Doodle jump                     "), trim_right(x"24444f4f444c45202020546865204d656d6520436f696e204275696c7420746f20427265616b20436861727473200a0a24444f4f444c452069736e7420616e6f7468657220746f6b656e2020697473206120676c6f62616c206272616e64207475726e65642062696c6c696f6e2d646f6c6c617220726f636b65742e0a546865206368617261637465722065766572796f6e65206b6e6f77732e205468652067616d652065766572796f6e6520706c617965642e204e6f77207265626f726e206f6e2d636861696e2e0a0a5768792024444f4f444c452077696c6c20646f6d696e6174653a0a20556e6976657273616c205265636f676e6974696f6e2020696e7374616e746c792072656c617461626c652c206e6f7374616c67696120746861742073656c6c7320697473656c662e0a20456e67696e65657265642053636172"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOODLE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOODLE>>(v4);
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

