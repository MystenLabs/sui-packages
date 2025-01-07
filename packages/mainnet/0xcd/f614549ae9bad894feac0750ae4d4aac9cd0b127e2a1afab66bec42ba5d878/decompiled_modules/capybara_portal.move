module 0xcdf614549ae9bad894feac0750ae4d4aac9cd0b127e2a1afab66bec42ba5d878::capybara_portal {
    struct CAPYBARA_PORTAL has drop {
        dummy_field: bool,
    }

    struct ClaimedPoints has copy, drop {
        amount: u64,
    }

    public fun claim(arg0: &mut 0xcdf614549ae9bad894feac0750ae4d4aac9cd0b127e2a1afab66bec42ba5d878::capybara_game_card::Registry, arg1: &mut 0xcdf614549ae9bad894feac0750ae4d4aac9cd0b127e2a1afab66bec42ba5d878::capybara_game_card::NFTData, arg2: u64) {
        0xcdf614549ae9bad894feac0750ae4d4aac9cd0b127e2a1afab66bec42ba5d878::capybara_game_card::spend<CAPYBARA_PORTAL>(arg0, arg1, arg2);
        let v0 = ClaimedPoints{amount: arg2};
        0x2::event::emit<ClaimedPoints>(v0);
    }

    fun init(arg0: CAPYBARA_PORTAL, arg1: &mut 0x2::tx_context::TxContext) {
    }

    // decompiled from Move bytecode v6
}

