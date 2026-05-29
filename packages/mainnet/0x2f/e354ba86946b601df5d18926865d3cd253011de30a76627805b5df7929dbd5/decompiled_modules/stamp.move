module 0x2fe354ba86946b601df5d18926865d3cd253011de30a76627805b5df7929dbd5::stamp {
    struct STAMP has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<STAMP>, arg1: 0x2::coin::Coin<STAMP>) {
        0x2::coin::burn<STAMP>(arg0, arg1);
    }

    fun init(arg0: STAMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STAMP>(arg0, 9, b"STAMP", b"STAMP", b"Custom SUI Token: STAMP", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<STAMP>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STAMP>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STAMP>>(v1);
    }

    public fun mint(arg0: &AdminCap, arg1: &mut 0x2::coin::TreasuryCap<STAMP>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<STAMP>(arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v7
}

