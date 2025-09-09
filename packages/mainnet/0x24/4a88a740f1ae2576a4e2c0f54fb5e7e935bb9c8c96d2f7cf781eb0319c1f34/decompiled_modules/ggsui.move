module 0x244a88a740f1ae2576a4e2c0f54fb5e7e935bb9c8c96d2f7cf781eb0319c1f34::ggsui {
    struct GGSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GGSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GGSUI>(arg0, 9, b"ggSUI", b"ggSUI", b"ggSUI is minted against staked SUI, accruing staking rewards + some % of dNFTs marketplace revenue for users!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d1sell8jrx8uwy.cloudfront.net/DegenSuiLogo.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GGSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GGSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

