module 0xad6250f65de431428516f8e0d2e28dcf1a2e6da5681b39fe2e99215c46a2becf::ggsui {
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

