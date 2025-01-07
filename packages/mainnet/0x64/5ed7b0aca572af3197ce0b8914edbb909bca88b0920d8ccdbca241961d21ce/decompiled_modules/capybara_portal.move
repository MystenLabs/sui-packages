module 0x645ed7b0aca572af3197ce0b8914edbb909bca88b0920d8ccdbca241961d21ce::capybara_portal {
    struct CAPYBARA_PORTAL has drop {
        dummy_field: bool,
    }

    struct ClaimedPoints has copy, drop {
        amount: u64,
    }

    public fun claim(arg0: &mut 0x645ed7b0aca572af3197ce0b8914edbb909bca88b0920d8ccdbca241961d21ce::capybara_game_card::Registry, arg1: &mut 0x645ed7b0aca572af3197ce0b8914edbb909bca88b0920d8ccdbca241961d21ce::capybara_game_card::NFTData, arg2: u64) {
        0x645ed7b0aca572af3197ce0b8914edbb909bca88b0920d8ccdbca241961d21ce::capybara_game_card::spend<CAPYBARA_PORTAL>(arg0, arg1, arg2);
        let v0 = ClaimedPoints{amount: arg2};
        0x2::event::emit<ClaimedPoints>(v0);
    }

    fun init(arg0: CAPYBARA_PORTAL, arg1: &mut 0x2::tx_context::TxContext) {
    }

    // decompiled from Move bytecode v6
}

