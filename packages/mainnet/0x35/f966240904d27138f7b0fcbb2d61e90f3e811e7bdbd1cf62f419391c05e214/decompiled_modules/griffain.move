module 0x35f966240904d27138f7b0fcbb2d61e90f3e811e7bdbd1cf62f419391c05e214::griffain {
    struct GRIFFAIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRIFFAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/9wEzswwAPefd3j9TuLsFUPVN6NqL83QMk2v9gxR5LdTR.png?claimId=Y2k-hdpKHZvEUi1W                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<GRIFFAIN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"GRIFFAIN    ")))), trim_right(b"GRIFFAIN OFFICIAL               "), trim_right(b"A wild and chaotic memecoin inspired by the legendary GRIFFAIN creaturepart griffin, part dragon, and 100% meme magic! This token embodies the spirit of the community, pushing the boundaries of imagination and trading frenzy with a touch of mythical allure. Get ready for soaring heights as we ride the waves of meme cul"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRIFFAIN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRIFFAIN>>(v4);
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

