module 0x4685fb13ce75051db5d7dc880d1eed958ddf15cbd5edd1097665ddaca01c701b::bon {
    struct BON has drop {
        dummy_field: bool,
    }

    fun init(arg0: BON, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/8g27YYim9YDF9GwaSPNxxAUEmcZPN8ztcJxaWSdKpump.png?claimId=QjRpM9jI6Y_K2cfb                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BON>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"bon         ")))), trim_right(b"smol bonk                       "), trim_right(x"536d6f6c20426f6e6b2024626f6e0a0a536d6f6c20426f6e6b2c20576974682069747320697272657369737469626c6520536869626120496e75206661636520616e64206d697363686965766f7573206772696e2c20536d6f6c20426f6e6b206861732073746f6c656e2074686520686561727473206f662063727970746f20656e74687573696173747320776f726c64776964652e0a0a446573706974652069747320736d616c6c2073697a652c20536d6f6c20426f6e6b207061636b65642061206269672070756e63682e2024426f6e206973206d6f7265207468616e206a757374206120636c65766572206d656d65206f722061206c756372617469766520696e766573746d656e74206f70706f7274756e6974792e20536d6f6c20426f6e6b277320656e746875736961737473207765726520756e69746564206279"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BON>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BON>>(v4);
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

