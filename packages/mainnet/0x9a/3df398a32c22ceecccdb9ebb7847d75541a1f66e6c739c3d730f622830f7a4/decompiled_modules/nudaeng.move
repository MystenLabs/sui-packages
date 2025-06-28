module 0x9a3df398a32c22ceecccdb9ebb7847d75541a1f66e6c739c3d730f622830f7a4::nudaeng {
    struct NUDAENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: NUDAENG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/CFWnvL9gvg2KiRUZjUm4ARQesJqD2PUrkhyjB9ENpump.png?claimId=mDJketSgWZl1CBBM                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<NUDAENG>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Nudaeng     ")))), trim_right(b"Nudaeng Dog                     "), trim_right(b"Nudeang Dog is a cute meme coin and runs on Solana blockchain. The original developer has abandoned the project by dumping the meme from $3mil down to $12k and now the community has decided to take over to rebuild the project with experienced CTO Team leaders.                                                            "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NUDAENG>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NUDAENG>>(v4);
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

