module 0x12dfe0529269812a9c77bd9d319a132730918954ae3aa1cdc23145c2bf76c11d::boat {
    struct BOAT has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<BOAT>, arg1: 0x2::coin::Coin<BOAT>) {
        0x2::coin::burn<BOAT>(arg0, arg1);
    }

    fun init(arg0: BOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOAT>(arg0, 9, b"BOAT", b"BOAT", b"Custom SUI Token: BOAT", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BOAT>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOAT>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOAT>>(v1);
    }

    public fun mint(arg0: &AdminCap, arg1: &mut 0x2::coin::TreasuryCap<BOAT>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BOAT>(arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v7
}

