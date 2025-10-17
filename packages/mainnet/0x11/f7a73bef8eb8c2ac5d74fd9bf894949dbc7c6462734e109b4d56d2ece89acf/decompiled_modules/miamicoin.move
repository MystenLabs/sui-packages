module 0x11f7a73bef8eb8c2ac5d74fd9bf894949dbc7c6462734e109b4d56d2ece89acf::miamicoin {
    struct MIAMICOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIAMICOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"1b4b3ff50f92947a1061b3fb16dff89991ba383e9c0aba237af215c5cce21343                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MIAMICOIN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Miamicoin   ")))), trim_right(b"Miamicoin                       "), trim_right(b"Miami Coin ($MIAMI)  The ultimate fusion of crypto, culture, and chaos  Led by Miamis own EliPreme, were going live for 7 straight days of unfiltered energy  wild stunts, surprise guests, and nonstop entertainment. Experience the city like never before as Miamis top influencers and celebrities give you the all-access V"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIAMICOIN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIAMICOIN>>(v4);
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

