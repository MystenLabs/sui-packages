module 0xfb6a4fad49d6e58c02dcec45d3f08212c5d50464d8cebb54ed459ab4a8dee8a7::capybara_portal {
    struct CAPYBARA_PORTAL has drop {
        dummy_field: bool,
    }

    struct ClaimedPoints has copy, drop {
        amount: u64,
    }

    public fun claim(arg0: &mut 0xfb6a4fad49d6e58c02dcec45d3f08212c5d50464d8cebb54ed459ab4a8dee8a7::capybara_game_card::Registry, arg1: &mut 0xfb6a4fad49d6e58c02dcec45d3f08212c5d50464d8cebb54ed459ab4a8dee8a7::capybara_game_card::NFTData, arg2: u64) {
        0xfb6a4fad49d6e58c02dcec45d3f08212c5d50464d8cebb54ed459ab4a8dee8a7::capybara_game_card::spend<CAPYBARA_PORTAL>(arg0, arg1, arg2);
        let v0 = ClaimedPoints{amount: arg2};
        0x2::event::emit<ClaimedPoints>(v0);
    }

    fun init(arg0: CAPYBARA_PORTAL, arg1: &mut 0x2::tx_context::TxContext) {
    }

    // decompiled from Move bytecode v6
}

