module 0x4c1b8ce1ee351c0cf4e5818f4d15ab68da3bd02fb1eb1c30886b3baa964ee97a::pepetest {
    struct PEPETEST has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<PEPETEST>, arg1: 0x2::coin::Coin<PEPETEST>) {
        0x2::coin::burn<PEPETEST>(arg0, arg1);
    }

    fun init(arg0: PEPETEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPETEST>(arg0, 9, b"PEPETES", b"PEPETEST", b"my coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPETEST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPETEST>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<PEPETEST>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<PEPETEST>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

