module 0x7d73c5c4b0e97ffa7e8475222852b9151af3f5c15e1ea719b425e87d6a9feb21::heir {
    struct HEIR has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<HEIR>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<HEIR>>(0x2::coin::mint<HEIR>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: HEIR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/base/0x01e75e59eabf83c85360351a100d22e025a75bc2.png?size=lg&key=131f1d                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<HEIR>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"HEIR    ")))), trim_right(b"HEIR                            "), trim_right(b"Welcome! Here you'll get an overview of all the amazing features H3IR offers to help you open an Onchain Trust!  You'll see some of the best parts of H3IR in action  and find help on how you can set up your estate.                                                                                                          "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HEIR>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<HEIR>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<HEIR>>(0x2::coin::mint<HEIR>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

