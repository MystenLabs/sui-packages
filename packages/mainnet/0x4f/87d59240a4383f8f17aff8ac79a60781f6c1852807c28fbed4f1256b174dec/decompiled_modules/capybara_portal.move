module 0x4f87d59240a4383f8f17aff8ac79a60781f6c1852807c28fbed4f1256b174dec::capybara_portal {
    struct CAPYBARA_PORTAL has drop {
        dummy_field: bool,
    }

    struct ClaimedPoints has copy, drop {
        amount: u64,
    }

    public fun claim(arg0: &mut 0x4f87d59240a4383f8f17aff8ac79a60781f6c1852807c28fbed4f1256b174dec::capybara_game_card::Registry, arg1: &mut 0x4f87d59240a4383f8f17aff8ac79a60781f6c1852807c28fbed4f1256b174dec::capybara_game_card::NFTData, arg2: u64) {
        0x4f87d59240a4383f8f17aff8ac79a60781f6c1852807c28fbed4f1256b174dec::capybara_game_card::spend<CAPYBARA_PORTAL>(arg0, arg1, arg2);
        let v0 = ClaimedPoints{amount: arg2};
        0x2::event::emit<ClaimedPoints>(v0);
    }

    fun init(arg0: CAPYBARA_PORTAL, arg1: &mut 0x2::tx_context::TxContext) {
    }

    // decompiled from Move bytecode v6
}

