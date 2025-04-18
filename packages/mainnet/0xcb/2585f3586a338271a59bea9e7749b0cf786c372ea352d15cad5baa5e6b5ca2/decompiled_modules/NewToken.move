module 0xcb2585f3586a338271a59bea9e7749b0cf786c372ea352d15cad5baa5e6b5ca2::NewToken {
    struct NEWTOKEN has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<NEWTOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<NEWTOKEN>>(0x2::coin::mint<NEWTOKEN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: NEWTOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEWTOKEN>(arg0, 6, b"$ RWTOKEN.com reward token", b"Reward", b"Token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEWTOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEWTOKEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

