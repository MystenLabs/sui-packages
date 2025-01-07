module 0xf98d5be1bfd5a1bef2d7f114149cb8fbddd177b42c469c747543195c3003d1be::piratesui {
    struct PIRATESUI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<PIRATESUI>, arg1: 0x2::coin::Coin<PIRATESUI>) {
        0x2::coin::burn<PIRATESUI>(arg0, arg1);
    }

    fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<PIRATESUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<PIRATESUI>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: PIRATESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2Fpirates_of_sui_logo_1000_x_1000_px_463af6849f.png&w=640&q=75                                                                                                                                                                                    ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PIRATESUI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"PIRATESUI ")))), trim_right(b"Pirates Of Sui                  "), trim_right(b"Pirates of Sui $PIRATESUI is a meme coin sailing the Sui network, designed purely for fun and community engagement. This lighthearted token aims to unite adventurers across the Sui ecosystem, helping everyone reach their goals while embracing the spirit of camaraderie and exploration. Join the                          "), v2, arg1);
        let v5 = v3;
        let v6 = &mut v5;
        let v7 = 0x2::tx_context::sender(arg1);
        mint_and_transfer(v6, 1000000000000000000, v7, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIRATESUI>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PIRATESUI>>(v5);
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

