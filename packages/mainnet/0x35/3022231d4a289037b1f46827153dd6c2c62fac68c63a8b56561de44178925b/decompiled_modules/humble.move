module 0x353022231d4a289037b1f46827153dd6c2c62fac68c63a8b56561de44178925b::humble {
    struct HUMBLE has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<HUMBLE>, arg1: 0x2::coin::Coin<HUMBLE>) {
        0x2::coin::burn<HUMBLE>(arg0, arg1);
    }

    fun init(arg0: HUMBLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUMBLE>(arg0, 9, b"HUMBLE ", b"HUMBLE", b"Custom SUI Token: HUMBLE", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HUMBLE>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUMBLE>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HUMBLE>>(v1);
    }

    public fun mint(arg0: &AdminCap, arg1: &mut 0x2::coin::TreasuryCap<HUMBLE>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<HUMBLE>(arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v7
}

