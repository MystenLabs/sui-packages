module 0xd455ae9d4327eeb67316bc0eb1652608453ae9cf4d189aef82b2cd3cdf3ae7e0::secxx {
    struct SECXX has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SECXX>, arg1: 0x2::coin::Coin<SECXX>) {
        0x2::coin::burn<SECXX>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SECXX>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SECXX>>(0x2::coin::mint<SECXX>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SECXX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SECXX>(arg0, 9, b"SECXX", b"SECXX", b"tester", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SECXX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SECXX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

