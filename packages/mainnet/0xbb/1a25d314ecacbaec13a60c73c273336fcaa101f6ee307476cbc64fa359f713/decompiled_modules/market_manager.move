module 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_manager {
    struct Markets has store {
        enabled: 0x2::vec_set::VecSet<0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::MarketKey>,
    }

    public(friend) fun assert_enabled(arg0: &Markets, arg1: &0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::MarketKey) {
        assert!(is_enabled(arg0, arg1), 1);
    }

    public(friend) fun disable_market(arg0: &mut Markets, arg1: &0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::MarketKey) {
        assert!(0x2::vec_set::contains<0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::MarketKey>(&arg0.enabled, arg1), 1);
        0x2::vec_set::remove<0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::MarketKey>(&mut arg0.enabled, arg1);
    }

    public(friend) fun enable_market<T0>(arg0: &mut Markets, arg1: &0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::oracle_block_scholes::OracleSVI<T0>, arg2: 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::MarketKey) {
        assert!(0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::oracle_block_scholes::is_active<T0>(arg1), 2);
        assert!(!0x2::vec_set::contains<0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::MarketKey>(&arg0.enabled, &arg2), 0);
        0x2::vec_set::insert<0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::MarketKey>(&mut arg0.enabled, arg2);
    }

    public fun is_enabled(arg0: &Markets, arg1: &0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::MarketKey) : bool {
        0x2::vec_set::contains<0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::MarketKey>(&arg0.enabled, arg1)
    }

    public(friend) fun new() : Markets {
        Markets{enabled: 0x2::vec_set::empty<0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::MarketKey>()}
    }

    // decompiled from Move bytecode v6
}

