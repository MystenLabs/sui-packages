module 0x31a7c7a4c3a5224955b5dfeaea4e5f83587d2cbeb9ffeb4865bc32b77280b744::silver {
    struct SILVER has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<SILVER>, arg1: 0x2::coin::Coin<SILVER>) {
        0x2::coin::burn<SILVER>(arg0, arg1);
    }

    fun init(arg0: SILVER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SILVER>(arg0, 9, b"SILVER", b"SILVER", b"Custom SUI Token: SILVER", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SILVER>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SILVER>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SILVER>>(v1);
    }

    public fun mint(arg0: &AdminCap, arg1: &mut 0x2::coin::TreasuryCap<SILVER>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SILVER>(arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v7
}

