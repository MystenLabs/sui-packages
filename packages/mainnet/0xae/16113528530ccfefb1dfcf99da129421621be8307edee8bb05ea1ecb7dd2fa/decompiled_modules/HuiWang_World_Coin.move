module 0xae16113528530ccfefb1dfcf99da129421621be8307edee8bb05ea1ecb7dd2fa::HuiWang_World_Coin {
    struct HUIWANG_WORLD_COIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<HUIWANG_WORLD_COIN>, arg1: 0x2::coin::Coin<HUIWANG_WORLD_COIN>) {
        0x2::coin::burn<HUIWANG_WORLD_COIN>(arg0, arg1);
    }

    fun init(arg0: HUIWANG_WORLD_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUIWANG_WORLD_COIN>(arg0, 3, b"HuiWang_World", b"HuiWang_World", b"Move-cn Faucet Task Coin by HuiWang_World", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://imagedelivery.net/cBNDGgkrsEA-b_ixIp9SkQ/sui.svg/public")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HUIWANG_WORLD_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<HUIWANG_WORLD_COIN>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<HUIWANG_WORLD_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<HUIWANG_WORLD_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

