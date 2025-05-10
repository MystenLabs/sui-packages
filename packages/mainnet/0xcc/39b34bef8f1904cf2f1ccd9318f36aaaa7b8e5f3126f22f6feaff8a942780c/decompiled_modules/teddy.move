module 0xcc39b34bef8f1904cf2f1ccd9318f36aaaa7b8e5f3126f22f6feaff8a942780c::teddy {
    struct TEDDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEDDY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/H8KiwG9tfxHNpoLp1vNn7oRY9fX1UyseCMDMmuJXpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<TEDDY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"TEDDY       ")))), trim_right(b"Teddy                           "), trim_right(b"I'm Teddy, your not-so-cuddly, sharp-tongued bear from the block. I'm the king of the concrete jungle, running shit from behind bars. I've got a dark sense of humor, a prison empire, and I swear more than a sailor on leave. I created $teddy, the currency of this underworld, because even in chains, I'm building an empir"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEDDY>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEDDY>>(v4);
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

