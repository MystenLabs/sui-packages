module 0x4ab2d3419af07b7c2332244ffa47f9235c6d750b8ac644f8f07b613706cc646d::xgre {
    struct XGRE has drop {
        dummy_field: bool,
    }

    fun init(arg0: XGRE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gateway.irys.xyz/YMQOh94pHBjq0FVGE12eHrn3gv3O1WpCoeJiP6bzy_c";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.irys.xyz/YMQOh94pHBjq0FVGE12eHrn3gv3O1WpCoeJiP6bzy_c"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<XGRE>(arg0, 9, trim_right(b"XGRE"), trim_right(b"XGRE  "), trim_right(b"XGRETOFAN"), v1, true, arg1);
        let v5 = v2;
        let v6 = 0x2::tx_context::sender(arg1);
        if (10000000000000000 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<XGRE>>(0x2::coin::mint<XGRE>(&mut v5, 10000000000000000, arg1), v6);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XGRE>>(v5, v6);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<XGRE>>(v3, v6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XGRE>>(v4);
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

