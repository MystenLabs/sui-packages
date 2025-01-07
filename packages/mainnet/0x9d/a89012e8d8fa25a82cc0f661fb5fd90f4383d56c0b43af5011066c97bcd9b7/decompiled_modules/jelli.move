module 0x9da89012e8d8fa25a82cc0f661fb5fd90f4383d56c0b43af5011066c97bcd9b7::jelli {
    struct JELLI has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<JELLI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<JELLI>>(0x2::coin::mint<JELLI>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: JELLI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/8WYjhYSedBEZMHwiLMJFz19W11MNATTKaPUAu9w5t2wn.png?size=lg&key=7f1e7f                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<JELLI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"jelli   ")))), trim_right(b"jelli                           "), trim_right(b"The Turritopsis dohrnii, famously dubbed the \"immortal jellyfish,\" is a marvel of naturea small but mighty organism capable of biological immortality.                                                                                                                                                                          "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JELLI>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<JELLI>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<JELLI>>(0x2::coin::mint<JELLI>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

