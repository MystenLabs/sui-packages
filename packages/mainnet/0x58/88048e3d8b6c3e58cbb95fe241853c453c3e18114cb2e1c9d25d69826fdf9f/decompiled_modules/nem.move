module 0x5888048e3d8b6c3e58cbb95fe241853c453c3e18114cb2e1c9d25d69826fdf9f::nem {
    struct NEM has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://arweave.net/CFJp7KZ3rgFOgBvjDTFeFARJRw4QP2zId7OEsVPwt8o";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/CFJp7KZ3rgFOgBvjDTFeFARJRw4QP2zId7OEsVPwt8o"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<NEM>(arg0, 9, trim_right(b"NEM"), trim_right(b"Nemoral"), trim_right(b"Beneath the nemoral canopy, soft light filters through ancient oaks, where moss carpets the earth and silence holds a quiet wisdom found only deep within the woodland grove."), v1, true, arg1);
        let v5 = v2;
        let v6 = 0x2::tx_context::sender(arg1);
        if (2100000000000000 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<NEM>>(0x2::coin::mint<NEM>(&mut v5, 2100000000000000, arg1), v6);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEM>>(v5, v6);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<NEM>>(v3, v6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEM>>(v4);
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

