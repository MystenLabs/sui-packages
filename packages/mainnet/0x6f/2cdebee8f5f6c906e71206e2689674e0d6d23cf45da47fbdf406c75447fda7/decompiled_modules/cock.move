module 0x6f2cdebee8f5f6c906e71206e2689674e0d6d23cf45da47fbdf406c75447fda7::cock {
    struct COCK has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<COCK>, arg1: 0x2::coin::Coin<COCK>) {
        0x2::coin::burn<COCK>(arg0, arg1);
    }

    fun init(arg0: COCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COCK>(arg0, 9, b"COCK", b"COCK", b"Custom SUI Token: COCK", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<COCK>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COCK>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COCK>>(v1);
    }

    public fun mint(arg0: &AdminCap, arg1: &mut 0x2::coin::TreasuryCap<COCK>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<COCK>(arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v7
}

