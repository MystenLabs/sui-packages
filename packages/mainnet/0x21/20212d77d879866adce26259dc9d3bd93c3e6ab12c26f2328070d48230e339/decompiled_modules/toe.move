module 0x2120212d77d879866adce26259dc9d3bd93c3e6ab12c26f2328070d48230e339::toe {
    struct TOE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/9fUinPugsTUmaMak6XtKxMkCEvdcRunuKtY6CB5EKE4o.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<TOE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"ToE         ")))), trim_right(b"Theory of Everything            "), trim_right(b"The Theory of Everything (ToE) Meme Coin is a cryptocurrency designed to incentivize and reward innovative minds working on groundbreaking scientific theories and technological advancements. This project is tied to the a major scientific paper, The Theory of Everything- Time Field Model. And unlike Bitcoin, Ethereum or"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOE>>(v4);
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

