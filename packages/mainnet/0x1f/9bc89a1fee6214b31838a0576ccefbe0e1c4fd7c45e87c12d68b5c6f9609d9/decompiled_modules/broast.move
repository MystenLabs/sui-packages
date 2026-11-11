module 0x1f9bc89a1fee6214b31838a0576ccefbe0e1c4fd7c45e87c12d68b5c6f9609d9::broast {
    struct BROAST has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<BROAST>, arg1: 0x2::coin::Coin<BROAST>) {
        0x2::coin::burn<BROAST>(arg0, arg1);
    }

    fun init(arg0: BROAST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BROAST>(arg0, 9, b"BROAST ", b"BROAST ", b"Custom SUI Token: BROAST ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BROAST>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BROAST>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BROAST>>(v1);
    }

    public fun mint(arg0: &AdminCap, arg1: &mut 0x2::coin::TreasuryCap<BROAST>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BROAST>(arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v7
}

