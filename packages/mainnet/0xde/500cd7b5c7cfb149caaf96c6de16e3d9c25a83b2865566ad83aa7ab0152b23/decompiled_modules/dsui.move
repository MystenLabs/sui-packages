module 0xde500cd7b5c7cfb149caaf96c6de16e3d9c25a83b2865566ad83aa7ab0152b23::dsui {
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

