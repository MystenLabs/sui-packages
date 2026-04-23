module 0x70a662a4f8ceed66f9f58995ddf9833ca75651a94361cd261d5feddcfd095568::elien {
    struct ELIEN has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<ELIEN>, arg1: 0x2::coin::Coin<ELIEN>) {
        0x2::coin::burn<ELIEN>(arg0, arg1);
    }

    fun init(arg0: ELIEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELIEN>(arg0, 9, b"ELIEN", b"Elien", b"Custom SUI Token: Elien", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ELIEN>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELIEN>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ELIEN>>(v1);
    }

    public fun mint(arg0: &AdminCap, arg1: &mut 0x2::coin::TreasuryCap<ELIEN>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ELIEN>(arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v7
}

