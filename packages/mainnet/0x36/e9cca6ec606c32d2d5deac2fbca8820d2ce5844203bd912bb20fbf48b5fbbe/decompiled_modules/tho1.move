module 0x36e9cca6ec606c32d2d5deac2fbca8820d2ce5844203bd912bb20fbf48b5fbbe::tho1 {
    struct THO1 has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<THO1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<THO1>>(0x2::coin::mint<THO1>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun transfer(arg0: 0x2::coin::TreasuryCap<THO1>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THO1>>(arg0, arg1);
    }

    fun init(arg0: THO1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THO1>(arg0, 6, b"THO1", b"THO1", b"description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"icon_image")), arg1);
        let v2 = v0;
        0x2::pay::keep<THO1>(0x2::coin::from_balance<THO1>(0x2::coin::mint_balance<THO1>(&mut v2, 10000000000000000000), arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<THO1>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THO1>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

