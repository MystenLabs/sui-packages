module 0x3b77fc573856fd06eb1c28232c252100af863db4cbc0258a3cd0118436dc3958::byxz {
    struct BYXZ has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BYXZ>, arg1: 0x2::coin::Coin<BYXZ>) {
        0x2::coin::burn<BYXZ>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BYXZ>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BYXZ>>(0x2::coin::mint<BYXZ>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: BYXZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BYXZ>(arg0, 9, b"byxz", b"BYXZ", b"test token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BYXZ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BYXZ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

