module 0xd670189e77ecf19ff80a8ffcdd958000ef8e1e3562ac8cfa2963a157b3ec52da::bop {
    struct BOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/9TWe3N38dCHkLKSJ314ag4do8FsJRR9L9HEmh35Rpump.png?claimId=Uncix_qro0ep68gB                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BOP>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BOP         ")))), trim_right(b"The Shoebody Bop                "), trim_right(x"48656172207468652063616c6c206f662024424f502e0a4c6574207468652072687974686d20666c6f6f6420796f7572206d696e642e0a52656d656d626572207468652063686f727573206f6620697473206d656c6f64792e0a4665656c207468652024424f502e0a53696e67207468652024424f502e0a4c697665207468652024424f502e0a546865726573206e6f207475726e696e67206261636b2e0a0a5468652063756c742068617320626567756e2e0a5468652024424f5020697320636f6e746167696f75732e0a497420697320696e6576697461626c652e0a54686520766965777320737065616b20666f722075732e0a4465766f74696f6e206472697665732075732e20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOP>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOP>>(v4);
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

