module 0x51e60aaf2b3c5e2467bededef6aabf71e3ea1997987b096a512f20f4de21c5be::coin_b {
    struct COIN_B has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<COIN_B>, arg1: 0x2::coin::Coin<COIN_B>) {
        0x2::coin::burn<COIN_B>(arg0, arg1);
    }

    fun init(arg0: COIN_B, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COIN_B>(arg0, 3, b"COIN_B", b"CB", b"lSwap Coin_B", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COIN_B>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<COIN_B>>(v0);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<COIN_B>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<COIN_B>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

