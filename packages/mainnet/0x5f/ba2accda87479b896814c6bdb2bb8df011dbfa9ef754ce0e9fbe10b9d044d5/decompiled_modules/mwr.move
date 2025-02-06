module 0x5fba2accda87479b896814c6bdb2bb8df011dbfa9ef754ce0e9fbe10b9d044d5::mwr {
    struct MWR has drop {
        dummy_field: bool,
    }

    fun init(arg0: MWR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/4PmSARcyVNAUq6jTE7G7pZrchk5mxBjHJrwddrVJpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MWR>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MWR         ")))), trim_right(b"My Wedding Raise                "), trim_right(b"Hello everyone, Our wedding is this weekend, and were really happy about it. However, after the biggest dump in Crypto's history on February 3rd, weve almost lost all our money, even the funds to the wedding are gone. I know I must sound terrible saying this, but I was overly confident in my market experience, using hi"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MWR>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MWR>>(v4);
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

