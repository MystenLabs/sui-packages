module 0xc58550dad5157b90aafc5a2cf66b91795c09aaecfdab9acbe5a2a5fe9090f152::dihmaxxing {
    struct DIHMAXXING has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIHMAXXING, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/FYoYG3JDDQyniRh55taRVM8hAxoNdF5a8SzruDnZpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<DIHMAXXING>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"dihmaxxing  ")))), trim_right(b"dihmaxxing                      "), trim_right(b"its mr. wang to you                                                                                                                                                                                                                                                                                                             "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIHMAXXING>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DIHMAXXING>>(v4);
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

