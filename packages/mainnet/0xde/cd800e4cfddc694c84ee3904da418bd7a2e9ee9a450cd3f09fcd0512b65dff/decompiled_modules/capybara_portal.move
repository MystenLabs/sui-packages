module 0xdecd800e4cfddc694c84ee3904da418bd7a2e9ee9a450cd3f09fcd0512b65dff::capybara_portal {
    struct CAPYBARA_PORTAL has drop {
        dummy_field: bool,
    }

    struct ClaimedPoints has copy, drop {
        amount: u64,
    }

    public fun claim(arg0: &mut 0xdecd800e4cfddc694c84ee3904da418bd7a2e9ee9a450cd3f09fcd0512b65dff::capybara_game_card::Registry, arg1: &mut 0xdecd800e4cfddc694c84ee3904da418bd7a2e9ee9a450cd3f09fcd0512b65dff::capybara_game_card::NFTData, arg2: u64) {
        0xdecd800e4cfddc694c84ee3904da418bd7a2e9ee9a450cd3f09fcd0512b65dff::capybara_game_card::spend<CAPYBARA_PORTAL>(arg0, arg1, arg2);
        let v0 = ClaimedPoints{amount: arg2};
        0x2::event::emit<ClaimedPoints>(v0);
    }

    fun init(arg0: CAPYBARA_PORTAL, arg1: &mut 0x2::tx_context::TxContext) {
    }

    // decompiled from Move bytecode v6
}

