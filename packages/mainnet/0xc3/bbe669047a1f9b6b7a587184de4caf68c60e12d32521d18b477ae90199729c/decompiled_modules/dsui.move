module 0x9bf5a8ad624d16a288cc187bf2eb5a7ff4b9794b08a8c3a2115de0544bb997fb::dsui {
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

