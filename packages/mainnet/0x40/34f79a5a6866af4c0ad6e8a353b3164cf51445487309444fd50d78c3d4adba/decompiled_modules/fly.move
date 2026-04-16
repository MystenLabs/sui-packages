module 0x4034f79a5a6866af4c0ad6e8a353b3164cf51445487309444fd50d78c3d4adba::fly {
    struct FLY has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<FLY>, arg1: 0x2::coin::Coin<FLY>) {
        0x2::coin::burn<FLY>(arg0, arg1);
    }

    fun init(arg0: FLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLY>(arg0, 9, b"FLY", b"FLY", b"Custom SUI Token: FLY", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FLY>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLY>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLY>>(v1);
    }

    public fun mint(arg0: &AdminCap, arg1: &mut 0x2::coin::TreasuryCap<FLY>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<FLY>(arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v7
}

