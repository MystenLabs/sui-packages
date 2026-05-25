module 0x69e1f1d5f969ada6ae571c7005f67772015b18ef4b80bddca1cc3cebcc90e9b5::sina {
    struct SINA has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<SINA>, arg1: 0x2::coin::Coin<SINA>) {
        0x2::coin::burn<SINA>(arg0, arg1);
    }

    fun init(arg0: SINA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SINA>(arg0, 9, b"SINA", b"SINA", b"Custom SUI Token: SINA", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SINA>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SINA>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SINA>>(v1);
    }

    public fun mint(arg0: &AdminCap, arg1: &mut 0x2::coin::TreasuryCap<SINA>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SINA>(arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v7
}

