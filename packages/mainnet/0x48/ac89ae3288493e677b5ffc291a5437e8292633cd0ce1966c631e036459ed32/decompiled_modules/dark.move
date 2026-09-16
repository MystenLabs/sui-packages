module 0x48ac89ae3288493e677b5ffc291a5437e8292633cd0ce1966c631e036459ed32::dark {
    struct DARK has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<DARK>, arg1: 0x2::coin::Coin<DARK>) {
        0x2::coin::burn<DARK>(arg0, arg1);
    }

    fun init(arg0: DARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DARK>(arg0, 9, b"DARK", b"DARK", b"Custom SUI Token: DARK", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DARK>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DARK>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DARK>>(v1);
    }

    public fun mint(arg0: &AdminCap, arg1: &mut 0x2::coin::TreasuryCap<DARK>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DARK>(arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v7
}

