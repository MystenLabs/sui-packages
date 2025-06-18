module 0x5aea742e523fce6ce547c52b5b403d1c23449aa98459fdebe367d6061d3d7fe0::dawg {
    struct DAWG has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<DAWG>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DAWG>>(0x2::coin::mint<DAWG>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: DAWG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/4AUxzdRiyMwp4tSGw7r1Bntp3nHfMr5Wk959hYbbpump.png?size=lg&key=ac4dcd                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<DAWG>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"DAWG    ")))), trim_right(b"DAWG PEACE ARMY                 "), trim_right(b"DAWG PEACE ARMY was built by those whod rather hug than hustle. Were not chasing battleswere building brotherhoods.                                                                                                                                                                                                             "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DAWG>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DAWG>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<DAWG>>(0x2::coin::mint<DAWG>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

