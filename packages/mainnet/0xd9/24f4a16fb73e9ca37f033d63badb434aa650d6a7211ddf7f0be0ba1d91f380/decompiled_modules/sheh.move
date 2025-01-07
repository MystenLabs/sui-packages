module 0xd924f4a16fb73e9ca37f033d63badb434aa650d6a7211ddf7f0be0ba1d91f380::sheh {
    struct SHEH has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SHEH>, arg1: 0x2::coin::Coin<SHEH>) {
        0x2::coin::burn<SHEH>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SHEH>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SHEH>>(0x2::coin::mint<SHEH>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SHEH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHEH>(arg0, 9, b"sheh", b"SHEH", b"hey", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHEH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHEH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

