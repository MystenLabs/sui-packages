module 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::dsui {
    struct DSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DSUI>(arg0, 9, b"degenSUI", b"degenSUI", b"degenSUI is minted against staked SUI, accruing staking rewards for users and helping secure the network!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d1sell8jrx8uwy.cloudfront.net/DegenSuiLogo.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

