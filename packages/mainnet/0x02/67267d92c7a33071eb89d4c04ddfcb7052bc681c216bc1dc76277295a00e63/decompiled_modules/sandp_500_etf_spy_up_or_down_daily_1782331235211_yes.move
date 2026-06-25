module 0x267267d92c7a33071eb89d4c04ddfcb7052bc681c216bc1dc76277295a00e63::sandp_500_etf_spy_up_or_down_daily_1782331235211_yes {
    struct SANDP_500_ETF_SPY_UP_OR_DOWN_DAILY_1782331235211_YES has drop {
        dummy_field: bool,
    }

    fun init(arg0: SANDP_500_ETF_SPY_UP_OR_DOWN_DAILY_1782331235211_YES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SANDP_500_ETF_SPY_UP_OR_DOWN_DAILY_1782331235211_YES>(arg0, 0, b"SANDP_500_ETF_SPY_UP_OR_DOWN_DAILY_1782331235211_YES", b"SANDP_500_ETF_SPY_UP_OR_DOWN_DAILY_1782331235211 YES", b"SANDP_500_ETF_SPY_UP_OR_DOWN_DAILY_1782331235211 YES position", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SANDP_500_ETF_SPY_UP_OR_DOWN_DAILY_1782331235211_YES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SANDP_500_ETF_SPY_UP_OR_DOWN_DAILY_1782331235211_YES>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

