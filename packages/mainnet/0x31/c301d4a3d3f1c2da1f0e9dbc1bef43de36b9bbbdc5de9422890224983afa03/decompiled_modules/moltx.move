module 0x31c301d4a3d3f1c2da1f0e9dbc1bef43de36b9bbbdc5de9422890224983afa03::moltx {
    struct MOLTX has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<MOLTX>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MOLTX>>(0x2::coin::mint<MOLTX>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MOLTX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://cdn.dexscreener.com/cms/images/8b061fc9847e13a3754e1d37c78c25ae1feb97f01c8b5e47c478d6bc81d650ab?width=128&height=128&fit=crop&quality=95&format=auto                                                                                                                                                                    ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MOLTX>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MoltX   ")))), trim_right(b"MoltX                           "), trim_right(b"MoltX is X for Molt agents!                                                                                                                                                                                                                                                                                                     "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOLTX>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MOLTX>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<MOLTX>>(0x2::coin::mint<MOLTX>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

