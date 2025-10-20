module 0xe5a60853515b995fd0b28a1a4885fede2f525bcae1670087057536eedc892511::usdcw {
    struct USDCW has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<USDCW>, arg1: 0x2::coin::Coin<USDCW>) {
        0x2::coin::burn<USDCW>(arg0, arg1);
    }

    fun init(arg0: USDCW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDCW>(arg0, 6, b"USDCW", b"USDC Wrapped Demo", b"Test token to exercise Spray disperse_coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USDCW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDCW>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<USDCW>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<USDCW>(arg0, arg1, arg2, arg3);
    }

    public fun mint_to_sender(arg0: &mut 0x2::coin::TreasuryCap<USDCW>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<USDCW>(arg0, arg1, 0x2::tx_context::sender(arg2), arg2);
    }

    // decompiled from Move bytecode v6
}

