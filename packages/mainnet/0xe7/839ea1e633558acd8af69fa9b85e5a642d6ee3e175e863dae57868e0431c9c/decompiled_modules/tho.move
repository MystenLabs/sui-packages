module 0xe7839ea1e633558acd8af69fa9b85e5a642d6ee3e175e863dae57868e0431c9c::tho {
    struct THO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<THO>, arg1: 0x2::coin::Coin<THO>) {
        0x2::coin::burn<THO>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<THO>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<THO>>(0x2::coin::mint<THO>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun transfer(arg0: 0x2::coin::TreasuryCap<THO>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THO>>(arg0, arg1);
    }

    fun init(arg0: THO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THO>(arg0, 6, b"THO", b"THO", b"description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"icon_image")), arg1);
        let v2 = v0;
        0x2::pay::keep<THO>(0x2::coin::from_balance<THO>(0x2::coin::mint_balance<THO>(&mut v2, 10000000000000000000), arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<THO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THO>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

