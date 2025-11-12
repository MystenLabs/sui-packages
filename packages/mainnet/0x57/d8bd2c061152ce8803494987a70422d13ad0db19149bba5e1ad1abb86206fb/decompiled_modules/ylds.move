module 0x57d8bd2c061152ce8803494987a70422d13ad0db19149bba5e1ad1abb86206fb::ylds {
    struct YLDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: YLDS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gateway.irys.xyz/Tg0P4H5wck8I1qN9-rg9zs8IVuaDOeQoJCdLmbAhEew";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.irys.xyz/Tg0P4H5wck8I1qN9-rg9zs8IVuaDOeQoJCdLmbAhEew"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<YLDS>(arg0, 9, trim_right(b"YLDS"), trim_right(b"YLDS  "), trim_right(b"YLDS "), v1, true, arg1);
        let v5 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YLDS>>(v2, v5);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<YLDS>>(v3, v5);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YLDS>>(v4);
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

