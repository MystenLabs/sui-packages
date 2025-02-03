module 0x8eecac69d846578791ab5ad1405d660b1a3c9a2132eaeb765d773fa683ebb1a6::onijah {
    struct ONIJAH has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONIJAH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/9Jxuz2pXBPqhzunhrz6R4bhEqZfEaKjekxcCxcnfpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<ONIJAH>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Onijah      ")))), trim_right(b"Onijah Andrew Robinson          "), trim_right(x"5468697320697320746865204f6666696369616c20436f696e20666f72204f6e696a616820416e6472657720526f62696e736f6e0a0a4f6e696a616827732050616a656574206a65657465642068657220696e206120666f726569676e20636f756e7472792061667465722074726176656c696e67206163726f73732074686520776f726c6420666f72206c6f76652c20736865206973206e6f7720737472616e64656420696e2050616b697374616e2e0a0a57652077696c6c207265636f6e7374727563742050616b697374616e20616e64206265636f6d6520746865206f6666696369616c20636f696e206f662050616b697374616e20476f642057696c6c696e672e20200a0a57652077696c6c206d616b65204f6e696a616820726963686572207468616e2074686520636f756e747279206f662050616b697374616e"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONIJAH>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ONIJAH>>(v4);
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

