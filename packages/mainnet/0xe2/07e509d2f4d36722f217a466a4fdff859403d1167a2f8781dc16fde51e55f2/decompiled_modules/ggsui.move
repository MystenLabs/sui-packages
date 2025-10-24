module 0xe207e509d2f4d36722f217a466a4fdff859403d1167a2f8781dc16fde51e55f2::ggsui {
    struct GGSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GGSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<GGSUI>(arg0, 9, 0x1::string::utf8(b"ggSUI"), 0x1::string::utf8(b"ggSUI"), 0x1::string::utf8(b"ggSUI is minted against staked SUI, accruing staking rewards + some % of dNFTs marketplace revenue for users!"), 0x1::string::utf8(b"https://d13jtsearj5tgw.cloudfront.net/assets/ggSUI_logo.png"), arg1);
        0x2::transfer::public_freeze_object<0x2::coin_registry::MetadataCap<GGSUI>>(0x2::coin_registry::finalize<GGSUI>(v0, arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GGSUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

