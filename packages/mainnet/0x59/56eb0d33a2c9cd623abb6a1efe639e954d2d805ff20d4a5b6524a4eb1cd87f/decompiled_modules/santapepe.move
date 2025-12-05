module 0x5956eb0d33a2c9cd623abb6a1efe639e954d2d805ff20d4a5b6524a4eb1cd87f::santapepe {
    struct SANTAPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SANTAPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"rQgIif81fc4IVCfZ                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SANTAPEPE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SantaPepe   ")))), trim_right(b"Santa Pepe                      "), trim_right(b"Santa Pepe is the jolly green meme machine, sliding down the blockchain chimney to fill your bags with holiday cheer (and maybe some gains)! Decked out in his froggy Santa hat, he's here to spread laughter, lols, and a bit of FOMO, proving that the best gifts come wrapped in memes. Ho-ho-HODL!                          "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SANTAPEPE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SANTAPEPE>>(v4);
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

