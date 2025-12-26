module 0x38675467f28ff5f344db9dc23cdedb8997830743ec57fae697d96fdea41aa8b9::tc {
    struct TC has drop {
        dummy_field: bool,
    }

    fun init(arg0: TC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gateway.irys.xyz/_cpQj3lWUv8y2XTjMUE1NoCpCjtIHyq7C-WnswC9JqI";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.irys.xyz/_cpQj3lWUv8y2XTjMUE1NoCpCjtIHyq7C-WnswC9JqI"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<TC>(arg0, 9, trim_right(b"TC"), trim_right(b"testCreate"), trim_right(b"greger"), v1, true, arg1);
        let v5 = v2;
        let v6 = 0x2::tx_context::sender(arg1);
        if (100000000000000000 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<TC>>(0x2::coin::mint<TC>(&mut v5, 100000000000000000, arg1), v6);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TC>>(v5, v6);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<TC>>(v3, v6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TC>>(v4);
    }

    fun trim_right(arg0: vector<u8>) : vector<u8> {
        let v0 = 32;
        while (0x1::vector::length<u8>(&arg0) > 0) {
            if (0x1::vector::borrow<u8>(&arg0, 0x1::vector::length<u8>(&arg0) - 1) != &v0) {
                break
            };
            0x1::vector::pop_back<u8>(&mut arg0);
        };
        arg0
    }

    // decompiled from Move bytecode v6
}

