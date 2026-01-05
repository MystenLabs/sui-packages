module 0xf5dfbac8b564aa0c524cfe390418d8b62483ff989c08b01d2307a47d35d0af21::madurow3 {
    struct MADUROW3 has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<MADUROW3>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MADUROW3>>(0x2::coin::mint<MADUROW3>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MADUROW3, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://cdn.dexscreener.com/cms/images/21796ce782944d0dbdc6eaebd9cee04dae8956b4eba368990ddd49be3b865382?width=128&height=128&fit=crop&quality=95&format=auto                                                                                                                                                                    ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MADUROW3>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MADUROW3")))), trim_right(b"Maduro War White Whale          "), trim_right(b"The legendary protector WhiteWhale rides through the cosmos with Maduro. Join the revolution on Sui                                                                                                                                                                                                                             "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MADUROW3>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MADUROW3>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<MADUROW3>>(0x2::coin::mint<MADUROW3>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

