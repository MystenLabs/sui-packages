module 0xa8bdb16f4d889794cf3e3863973480cfd5ad4a97e82fb989b87e22ea82833077::hmstr {
    struct HMSTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: HMSTR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"eH1ROhfB71MEAavr                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<HMSTR>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"HMSTR       ")))), trim_right(b"Hamster Kombat                  "), trim_right(b"Hamster Kombat is the popular Play-to-Earn game on Telegram, designed to power the in-game economy and reward players. As the original token on the Solana network, Hamster Kombat offers scalability and accessibility for all users. Join the battle and earn rewards in Hamster Kombat.                                      "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HMSTR>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HMSTR>>(v4);
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

