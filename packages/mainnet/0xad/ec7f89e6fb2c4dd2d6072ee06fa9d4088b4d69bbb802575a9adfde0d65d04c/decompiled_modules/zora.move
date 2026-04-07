module 0xadec7f89e6fb2c4dd2d6072ee06fa9d4088b4d69bbb802575a9adfde0d65d04c::zora {
    struct ZORA has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<ZORA>, arg1: 0x2::coin::Coin<ZORA>) {
        0x2::coin::burn<ZORA>(arg0, arg1);
    }

    fun init(arg0: ZORA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZORA>(arg0, 9, b"ZORA", b"ZORA", b"Custom SUI Token: ZORA", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ZORA>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZORA>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZORA>>(v1);
    }

    public fun mint(arg0: &AdminCap, arg1: &mut 0x2::coin::TreasuryCap<ZORA>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ZORA>(arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v7
}

