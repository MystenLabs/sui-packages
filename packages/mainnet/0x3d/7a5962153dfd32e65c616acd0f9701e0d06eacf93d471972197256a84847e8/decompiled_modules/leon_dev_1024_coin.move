module 0x3d7a5962153dfd32e65c616acd0f9701e0d06eacf93d471972197256a84847e8::leon_dev_1024_coin {
    struct LEON_DEV_1024_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEON_DEV_1024_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEON_DEV_1024_COIN>(arg0, 9, b"LeonDev1024", b"LDC", b"this is a coin minted by LeonDev1024 for community rewards", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LEON_DEV_1024_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEON_DEV_1024_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<LEON_DEV_1024_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<LEON_DEV_1024_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

