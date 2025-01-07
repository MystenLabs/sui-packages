module 0x813ec0564b3bd969c48f2fc75a31556333a37fac1b95b71e40b6b163a8483a1f::capybara_portal {
    struct CAPYBARA_PORTAL has drop {
        dummy_field: bool,
    }

    struct ClaimedPoints has copy, drop {
        amount: u64,
    }

    public fun claim(arg0: &mut 0x813ec0564b3bd969c48f2fc75a31556333a37fac1b95b71e40b6b163a8483a1f::capybara_game_card::Registry, arg1: &mut 0x813ec0564b3bd969c48f2fc75a31556333a37fac1b95b71e40b6b163a8483a1f::capybara_game_card::NFTData, arg2: u64) {
        0x813ec0564b3bd969c48f2fc75a31556333a37fac1b95b71e40b6b163a8483a1f::capybara_game_card::spend<CAPYBARA_PORTAL>(arg0, arg1, arg2);
        let v0 = ClaimedPoints{amount: arg2};
        0x2::event::emit<ClaimedPoints>(v0);
    }

    fun init(arg0: CAPYBARA_PORTAL, arg1: &mut 0x2::tx_context::TxContext) {
    }

    // decompiled from Move bytecode v6
}

