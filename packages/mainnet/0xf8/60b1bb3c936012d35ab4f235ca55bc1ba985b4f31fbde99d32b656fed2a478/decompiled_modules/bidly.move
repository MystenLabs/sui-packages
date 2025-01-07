module 0xf860b1bb3c936012d35ab4f235ca55bc1ba985b4f31fbde99d32b656fed2a478::bidly {
    struct BIDLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIDLY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0x85d6ae9aff9d8fb38240a945e6798803827df2e2.png?size=lg&key=299bfa                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BIDLY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BIDLY   ")))), trim_right(b"Bidly                           "), trim_right(b"Welcome to Bidly, where we combine the excitement of penny auctions with the reliability of blockchain technology. Like a loyal dog that tracks down hidden treasures, Bidly empowers you to uncover amazing deals on sought-after products while ensuring a secure and transparent bidding experience.                         "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIDLY>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIDLY>>(v4);
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

