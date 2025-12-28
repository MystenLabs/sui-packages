module 0x80a1cf0954c2f1f54c2d725780239c583a60c5779b881bd21267e530998991df::vtio {
    struct VTIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: VTIO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gateway.irys.xyz/NAFY4OOd7YyLYod1e4hxHriL_yo_r-J896MeXDADwNQ";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.irys.xyz/NAFY4OOd7YyLYod1e4hxHriL_yo_r-J896MeXDADwNQ"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<VTIO>(arg0, 8, trim_right(b"VTIO"), trim_right(b"VTIO  "), trim_right(b"VTIOGOTOFAN"), v1, true, arg1);
        let v5 = v2;
        let v6 = 0x2::tx_context::sender(arg1);
        if (1000000000000000 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<VTIO>>(0x2::coin::mint<VTIO>(&mut v5, 1000000000000000, arg1), v6);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VTIO>>(v5, v6);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<VTIO>>(v3, v6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VTIO>>(v4);
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

