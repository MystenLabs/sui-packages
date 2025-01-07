module 0xfc4b83a05983ec487c7f3ac25f7830b12184f9fe679070d68d192845d3cc308d::sainta {
    struct SAINTA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SAINTA>, arg1: vector<0x2::coin::Coin<SAINTA>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<SAINTA>>(&mut arg1);
        0x2::pay::join_vec<SAINTA>(&mut v0, arg1);
        0x2::coin::burn<SAINTA>(arg0, 0x2::coin::split<SAINTA>(&mut v0, arg2, arg3));
        if (0x2::coin::value<SAINTA>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<SAINTA>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<SAINTA>(v0);
        };
    }

    fun init(arg0: SAINTA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b"https://img.freepik.com/premium-vector/cryptocurrency-coins-logo-design_652638-29.jpg"));
        let (v2, v3) = 0x2::coin::create_currency<SAINTA>(arg0, 2, b"sainta", b"sainta", b"This", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAINTA>>(v3);
        0x2::coin::mint_and_transfer<SAINTA>(&mut v4, 1100, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAINTA>>(v4, v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SAINTA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SAINTA>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<SAINTA>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SAINTA>>(arg0);
    }

    // decompiled from Move bytecode v6
}

