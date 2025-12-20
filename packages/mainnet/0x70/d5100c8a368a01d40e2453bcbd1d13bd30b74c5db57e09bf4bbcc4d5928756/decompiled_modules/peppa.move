module 0x70d5100c8a368a01d40e2453bcbd1d13bd30b74c5db57e09bf4bbcc4d5928756::peppa {
    struct PEPPA has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<PEPPA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PEPPA>>(0x2::coin::mint<PEPPA>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: PEPPA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://cdn.dexscreener.com/cms/images/fea9a05295af87374d53eaba783579133665fafef6d27daf69b8bcb3daf9e486?width=128&height=128&fit=crop&quality=95&format=auto                                                                                                                                                                    ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PEPPA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Peppa   ")))), trim_right(b"Peppa The Shiba                 "), trim_right(b"Peppa The Shiba Inu was wrongfully poisoned by their Chinese neighbor whilst on holiday.                                                                                                                                                                                                                                        "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPPA>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PEPPA>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<PEPPA>>(0x2::coin::mint<PEPPA>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

