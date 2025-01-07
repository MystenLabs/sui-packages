module 0xaf670ea2220ea05286d87724392a8b848f9cf6e42bf61a28f957ecffda8f253e::share_coin {
    struct SHARE_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHARE_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHARE_COIN>(arg0, 6, b"share coin", b"share coin", b"this is share_coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHARE_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<SHARE_COIN>>(v0);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SHARE_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SHARE_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

