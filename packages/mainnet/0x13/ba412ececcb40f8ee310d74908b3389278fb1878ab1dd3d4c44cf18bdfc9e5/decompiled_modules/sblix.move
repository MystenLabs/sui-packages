module 0x13ba412ececcb40f8ee310d74908b3389278fb1878ab1dd3d4c44cf18bdfc9e5::sblix {
    struct SBLIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBLIX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"uFBoJTVYPlV9kfOO                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SBLIX>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SBLIX       ")))), trim_right(b"Super Bowl LIX                  "), trim_right(b"Super Bowl LIX  is the ultimate meme coin for football and crypto fans!  Celebrate the biggest game of the year with a token that unites the gridiron and blockchain. Join the community to share your predictions, show your team pride, and talk all the trash you want about the opposition. Its game timelets bring the heat"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBLIX>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBLIX>>(v4);
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

