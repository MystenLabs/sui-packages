module 0xe1a55aca5134798cc41c920192ae0c99f680de3c3f029f837500f1a1732937f::clink {
    struct CLINK has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<CLINK>, arg1: 0x2::coin::Coin<CLINK>) {
        0x2::coin::burn<CLINK>(arg0, arg1);
    }

    fun init(arg0: CLINK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLINK>(arg0, 9, b"CLINK", b"CLINK", b"Custom SUI Token: CLINK", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CLINK>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLINK>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CLINK>>(v1);
    }

    public fun mint(arg0: &AdminCap, arg1: &mut 0x2::coin::TreasuryCap<CLINK>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<CLINK>(arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v6
}

