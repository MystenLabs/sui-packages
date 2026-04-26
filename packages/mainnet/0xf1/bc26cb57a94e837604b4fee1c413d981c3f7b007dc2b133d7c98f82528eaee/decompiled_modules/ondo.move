module 0xf1bc26cb57a94e837604b4fee1c413d981c3f7b007dc2b133d7c98f82528eaee::ondo {
    struct ONDO has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<ONDO>, arg1: 0x2::coin::Coin<ONDO>) {
        0x2::coin::burn<ONDO>(arg0, arg1);
    }

    fun init(arg0: ONDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONDO>(arg0, 9, b"ONDO", b"ONDO", b"Custom SUI Token: ONDO", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ONDO>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONDO>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ONDO>>(v1);
    }

    public fun mint(arg0: &AdminCap, arg1: &mut 0x2::coin::TreasuryCap<ONDO>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ONDO>(arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v7
}

