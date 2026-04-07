module 0xa33635429571fcd0e7dfb6df409915025badb9675d1b6757ee2a5c7f93f64acc::light {
    struct LIGHT has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<LIGHT>, arg1: 0x2::coin::Coin<LIGHT>) {
        0x2::coin::burn<LIGHT>(arg0, arg1);
    }

    fun init(arg0: LIGHT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIGHT>(arg0, 9, b"LIGHT", b"LIGHT", b"Custom SUI Token: LIGHT", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LIGHT>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIGHT>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LIGHT>>(v1);
    }

    public fun mint(arg0: &AdminCap, arg1: &mut 0x2::coin::TreasuryCap<LIGHT>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<LIGHT>(arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v7
}

