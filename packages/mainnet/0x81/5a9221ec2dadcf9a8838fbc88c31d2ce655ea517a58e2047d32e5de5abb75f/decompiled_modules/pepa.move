module 0x815a9221ec2dadcf9a8838fbc88c31d2ce655ea517a58e2047d32e5de5abb75f::pepa {
    struct PEPA has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<PEPA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PEPA>>(0x2::coin::mint<PEPA>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: PEPA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/base/0x2b3f5f7458558553df26034ad0d172ca8aa91bed.png?size=lg&key=0f34c8                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PEPA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"PEPA    ")))), trim_right(b"Pepe the Astronaut              "), trim_right(b"Pepe the Astronaut, now known as Peponaut, is living his best life on Mars.  When hes not sipping space coffee or dodging Martian dust storms, hes floating through low-gravity workouts or tearing up the surface in rover races like a cosmic NASCAR driver.                                                                  "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPA>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PEPA>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<PEPA>>(0x2::coin::mint<PEPA>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

