module 0xe7e1d27bb5bc3732c0c9ad853732cffc5e914529d05af1ee8e96841418483438::renzo {
    struct RENZO has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<RENZO>, arg1: 0x2::coin::Coin<RENZO>) {
        0x2::coin::burn<RENZO>(arg0, arg1);
    }

    fun init(arg0: RENZO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RENZO>(arg0, 9, b"RENZO", b"RENZO", b"Custom SUI Token: RENZO", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RENZO>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RENZO>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RENZO>>(v1);
    }

    public fun mint(arg0: &AdminCap, arg1: &mut 0x2::coin::TreasuryCap<RENZO>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<RENZO>(arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v7
}

