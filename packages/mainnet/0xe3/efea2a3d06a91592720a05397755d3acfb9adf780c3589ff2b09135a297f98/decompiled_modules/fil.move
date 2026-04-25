module 0xe3efea2a3d06a91592720a05397755d3acfb9adf780c3589ff2b09135a297f98::fil {
    struct FIL has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<FIL>, arg1: 0x2::coin::Coin<FIL>) {
        0x2::coin::burn<FIL>(arg0, arg1);
    }

    fun init(arg0: FIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIL>(arg0, 9, b"FIL", b"FIL", b"Custom SUI Token: FIL", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FIL>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIL>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FIL>>(v1);
    }

    public fun mint(arg0: &AdminCap, arg1: &mut 0x2::coin::TreasuryCap<FIL>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<FIL>(arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v7
}

