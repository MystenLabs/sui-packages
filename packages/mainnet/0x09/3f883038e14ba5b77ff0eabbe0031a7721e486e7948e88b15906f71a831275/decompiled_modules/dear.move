module 0x93f883038e14ba5b77ff0eabbe0031a7721e486e7948e88b15906f71a831275::dear {
    struct DEAR has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<DEAR>, arg1: 0x2::coin::Coin<DEAR>) {
        0x2::coin::burn<DEAR>(arg0, arg1);
    }

    fun init(arg0: DEAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEAR>(arg0, 9, b"DEAR", b"DEAR", b"Custom SUI Token: DEAR", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DEAR>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEAR>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEAR>>(v1);
    }

    public fun mint(arg0: &AdminCap, arg1: &mut 0x2::coin::TreasuryCap<DEAR>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DEAR>(arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v7
}

