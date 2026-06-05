module 0x66813379a92889ba867f922bd27eb13d742364d8d63075fc07c3a1ae16965c2a::toll {
    struct TOLL has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<TOLL>, arg1: 0x2::coin::Coin<TOLL>) {
        0x2::coin::burn<TOLL>(arg0, arg1);
    }

    fun init(arg0: TOLL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOLL>(arg0, 9, b"TOLL", b"TOLL", b"Custom SUI Token: TOLL", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TOLL>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOLL>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOLL>>(v1);
    }

    public fun mint(arg0: &AdminCap, arg1: &mut 0x2::coin::TreasuryCap<TOLL>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TOLL>(arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v7
}

