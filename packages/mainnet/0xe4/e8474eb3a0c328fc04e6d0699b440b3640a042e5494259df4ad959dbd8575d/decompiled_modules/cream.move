module 0xe4e8474eb3a0c328fc04e6d0699b440b3640a042e5494259df4ad959dbd8575d::cream {
    struct CREAM has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<CREAM>, arg1: 0x2::coin::Coin<CREAM>) {
        0x2::coin::burn<CREAM>(arg0, arg1);
    }

    fun init(arg0: CREAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CREAM>(arg0, 9, b"CREAM", b"CREAM", b"Custom SUI Token: CREAM", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CREAM>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CREAM>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CREAM>>(v1);
    }

    public fun mint(arg0: &AdminCap, arg1: &mut 0x2::coin::TreasuryCap<CREAM>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<CREAM>(arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v7
}

