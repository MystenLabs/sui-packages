module 0xbc580569b4a4ecf5718a221d93df04a1a8c9e43deae51ff9b619305ebf7b6cc8::dsui {
    struct DSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DSUI>(arg0, 9, b"degenSUI", b"degenSUI", b"Represents SUI liquid staked via DegenHive, used for HiveAssets trade settlement and decentralizing the Sui Network through buybacks from collected AMM fees!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://degenhive.ai/assets/degensui_logo.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

