module 0xb3449a91bf79e602829c153f5f37509dbd75cb2f844777cd34f12a698e8aea40::river {
    struct RIVER has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<RIVER>, arg1: 0x2::coin::Coin<RIVER>) {
        0x2::coin::burn<RIVER>(arg0, arg1);
    }

    fun init(arg0: RIVER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIVER>(arg0, 9, b"RIVER", b"RIVER", b"Custom SUI Token: RIVER", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RIVER>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIVER>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RIVER>>(v1);
    }

    public fun mint(arg0: &AdminCap, arg1: &mut 0x2::coin::TreasuryCap<RIVER>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<RIVER>(arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v7
}

