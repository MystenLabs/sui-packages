module 0x3a74fca532924fd7a288546ccae92b90be2685ea271be2e6886f8163db3f40d9::youxz {
    struct YOUXZ has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<YOUXZ>, arg1: 0x2::coin::Coin<YOUXZ>) {
        0x2::coin::burn<YOUXZ>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<YOUXZ>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<YOUXZ>>(0x2::coin::mint<YOUXZ>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: YOUXZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YOUXZ>(arg0, 9, b"Youxz", b"YOUXZ", b"test token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YOUXZ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOUXZ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

