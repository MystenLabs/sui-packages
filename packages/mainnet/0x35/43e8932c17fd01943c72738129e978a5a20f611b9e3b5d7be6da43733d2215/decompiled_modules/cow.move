module 0x3543e8932c17fd01943c72738129e978a5a20f611b9e3b5d7be6da43733d2215::cow {
    struct COW has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<COW>, arg1: 0x2::coin::Coin<COW>) {
        0x2::coin::burn<COW>(arg0, arg1);
    }

    fun init(arg0: COW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COW>(arg0, 9, b"COW", b"COW", b"Custom SUI Token: COW", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<COW>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COW>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COW>>(v1);
    }

    public fun mint(arg0: &AdminCap, arg1: &mut 0x2::coin::TreasuryCap<COW>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<COW>(arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v7
}

