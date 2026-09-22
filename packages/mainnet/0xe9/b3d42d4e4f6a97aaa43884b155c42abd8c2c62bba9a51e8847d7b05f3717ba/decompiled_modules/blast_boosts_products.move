module 0xe9b3d42d4e4f6a97aaa43884b155c42abd8c2c62bba9a51e8847d7b05f3717ba::blast_boosts_products {
    struct BLAST_BOOSTS_PRODUCTS has drop {
        dummy_field: bool,
    }

    struct BTC_BULL_2X {
        dummy_field: bool,
    }

    struct BTC_BEAR_2X {
        dummy_field: bool,
    }

    struct CARDS_BULL_2X {
        dummy_field: bool,
    }

    struct CARDS_BEAR_2X {
        dummy_field: bool,
    }

    struct CHIP_BULL_2X {
        dummy_field: bool,
    }

    struct CHIP_BEAR_2X {
        dummy_field: bool,
    }

    struct ETH_BULL_2X {
        dummy_field: bool,
    }

    struct ETH_BEAR_2X {
        dummy_field: bool,
    }

    struct HYPE_BULL_2X {
        dummy_field: bool,
    }

    struct HYPE_BEAR_2X {
        dummy_field: bool,
    }

    struct LIT_BULL_2X {
        dummy_field: bool,
    }

    struct LIT_BEAR_2X {
        dummy_field: bool,
    }

    struct MON_BULL_2X {
        dummy_field: bool,
    }

    struct MON_BEAR_2X {
        dummy_field: bool,
    }

    struct NEAR_BULL_2X {
        dummy_field: bool,
    }

    struct NEAR_BEAR_2X {
        dummy_field: bool,
    }

    struct PUMP_BULL_2X {
        dummy_field: bool,
    }

    struct PUMP_BEAR_2X {
        dummy_field: bool,
    }

    struct SOL_BULL_2X {
        dummy_field: bool,
    }

    struct SOL_BEAR_2X {
        dummy_field: bool,
    }

    struct SUI_BULL_2X {
        dummy_field: bool,
    }

    struct SUI_BEAR_2X {
        dummy_field: bool,
    }

    struct UNI_BULL_2X {
        dummy_field: bool,
    }

    struct UNI_BEAR_2X {
        dummy_field: bool,
    }

    struct XMR_BULL_2X {
        dummy_field: bool,
    }

    struct XMR_BEAR_2X {
        dummy_field: bool,
    }

    struct XRP_BULL_2X {
        dummy_field: bool,
    }

    struct XRP_BEAR_2X {
        dummy_field: bool,
    }

    struct ZEC_BULL_2X {
        dummy_field: bool,
    }

    struct ZEC_BEAR_2X {
        dummy_field: bool,
    }

    struct AMC_BULL_2X {
        dummy_field: bool,
    }

    struct AMC_BEAR_2X {
        dummy_field: bool,
    }

    struct CRCL_BULL_2X {
        dummy_field: bool,
    }

    struct CRCL_BEAR_2X {
        dummy_field: bool,
    }

    struct CYPH_BULL_2X {
        dummy_field: bool,
    }

    struct CYPH_BEAR_2X {
        dummy_field: bool,
    }

    struct DRAM_BULL_2X {
        dummy_field: bool,
    }

    struct DRAM_BEAR_2X {
        dummy_field: bool,
    }

    struct GOOGL_BULL_2X {
        dummy_field: bool,
    }

    struct GOOGL_BEAR_2X {
        dummy_field: bool,
    }

    struct INTC_BULL_2X {
        dummy_field: bool,
    }

    struct INTC_BEAR_2X {
        dummy_field: bool,
    }

    struct IOVA_BULL_2X {
        dummy_field: bool,
    }

    struct IOVA_BEAR_2X {
        dummy_field: bool,
    }

    struct LLY_BULL_2X {
        dummy_field: bool,
    }

    struct LLY_BEAR_2X {
        dummy_field: bool,
    }

    struct META_BULL_2X {
        dummy_field: bool,
    }

    struct META_BEAR_2X {
        dummy_field: bool,
    }

    struct MRVL_BULL_2X {
        dummy_field: bool,
    }

    struct MRVL_BEAR_2X {
        dummy_field: bool,
    }

    struct MU_BULL_2X {
        dummy_field: bool,
    }

    struct MU_BEAR_2X {
        dummy_field: bool,
    }

    struct NVDA_BULL_2X {
        dummy_field: bool,
    }

    struct NVDA_BEAR_2X {
        dummy_field: bool,
    }

    struct SAMSUNG_BULL_2X {
        dummy_field: bool,
    }

    struct SAMSUNG_BEAR_2X {
        dummy_field: bool,
    }

    struct SKHYNIX_BULL_2X {
        dummy_field: bool,
    }

    struct SKHYNIX_BEAR_2X {
        dummy_field: bool,
    }

    struct SNDK_BULL_2X {
        dummy_field: bool,
    }

    struct SNDK_BEAR_2X {
        dummy_field: bool,
    }

    struct SPCX_BULL_2X {
        dummy_field: bool,
    }

    struct SPCX_BEAR_2X {
        dummy_field: bool,
    }

    struct TSLA_BULL_2X {
        dummy_field: bool,
    }

    struct TSLA_BEAR_2X {
        dummy_field: bool,
    }

    struct US500_BULL_2X {
        dummy_field: bool,
    }

    struct US500_BEAR_2X {
        dummy_field: bool,
    }

    struct BRENT_BULL_2X {
        dummy_field: bool,
    }

    struct BRENT_BEAR_2X {
        dummy_field: bool,
    }

    struct WTI_BULL_2X {
        dummy_field: bool,
    }

    struct WTI_BEAR_2X {
        dummy_field: bool,
    }

    struct XAG_BULL_2X {
        dummy_field: bool,
    }

    struct XAG_BEAR_2X {
        dummy_field: bool,
    }

    struct XAUT_BULL_2X {
        dummy_field: bool,
    }

    struct XAUT_BEAR_2X {
        dummy_field: bool,
    }

    fun init(arg0: BLAST_BOOSTS_PRODUCTS, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<BLAST_BOOSTS_PRODUCTS>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

