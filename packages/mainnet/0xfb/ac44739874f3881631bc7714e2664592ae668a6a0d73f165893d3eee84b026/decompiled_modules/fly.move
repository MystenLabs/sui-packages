module 0xfbac44739874f3881631bc7714e2664592ae668a6a0d73f165893d3eee84b026::fly {
    struct FLY has drop {
        dummy_field: bool,
    }

    public fun fly_mint(arg0: &mut 0x2::coin::TreasuryCap<FLY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<FLY>>(0x2::coin::mint<FLY>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: FLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLY>(arg0, 8, b"FLY", b"FLY", b"FLY currency Coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

