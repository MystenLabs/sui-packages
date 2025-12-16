module 0x795768e25ca1292302c4356ff28d562670d4e64010407d8a05ac3bbe6583092f::ggsui {
    struct GGSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GGSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<GGSUI>(arg0, 9, 0x1::string::utf8(b"ggSUI"), 0x1::string::utf8(b"ggSUI"), 0x1::string::utf8(b"ggSUI is minted against staked SUI, accruing staking rewards + some % of dNFTs marketplace revenue for users!"), 0x1::string::utf8(b"https://assets.honeyplay.ai/coins/ggsui.png"), arg1);
        0x2::transfer::public_freeze_object<0x2::coin_registry::MetadataCap<GGSUI>>(0x2::coin_registry::finalize<GGSUI>(v0, arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GGSUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

