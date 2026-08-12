module 0x6bbc3f35a4207d8b1a17baeb5e4018b5cb9ef02f0eee01e9810d033ed52d08ae::ship {
    struct SHIP has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<SHIP>, arg1: 0x2::coin::Coin<SHIP>) {
        0x2::coin::burn<SHIP>(arg0, arg1);
    }

    fun init(arg0: SHIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIP>(arg0, 9, b"SHIP", b"SHIP", b"Custom SUI Token: SHIP", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SHIP>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIP>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHIP>>(v1);
    }

    public fun mint(arg0: &AdminCap, arg1: &mut 0x2::coin::TreasuryCap<SHIP>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SHIP>(arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v7
}

