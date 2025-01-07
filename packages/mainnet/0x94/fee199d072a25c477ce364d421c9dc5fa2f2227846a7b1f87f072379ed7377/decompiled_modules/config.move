module 0x94fee199d072a25c477ce364d421c9dc5fa2f2227846a7b1f87f072379ed7377::config {
    struct GlobalConfig has key {
        id: 0x2::object::UID,
        version: u64,
        max_trader_fee: u64,
        min_fund_base: u64,
        max_fund_base: u64,
        min_rewards: u64,
        settle_percentage: u64,
        base_percentage: u64,
        platform_fee: u64,
        platform: address,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public(friend) fun assert_if_base_over_max(arg0: &GlobalConfig, arg1: u64) {
        assert!(arg1 <= arg0.max_fund_base, 1);
    }

    public(friend) fun assert_if_less_than_min_fund_base(arg0: &GlobalConfig, arg1: u64) {
        assert!(min_fund_base(arg0) <= arg1, 2);
    }

    public(friend) fun assert_if_version_not_matched(arg0: &GlobalConfig, arg1: u64) {
        assert!(arg0.version == arg1, 0);
    }

    public(friend) fun base_percentage(arg0: &GlobalConfig) : u64 {
        arg0.base_percentage
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = GlobalConfig{
            id                : 0x2::object::new(arg0),
            version           : 1,
            max_trader_fee    : 2000,
            min_fund_base     : 100000000,
            max_fund_base     : 500000000,
            min_rewards       : 1000000,
            settle_percentage : 100,
            base_percentage   : 10000,
            platform_fee      : 200,
            platform          : @0x39dfa26ecaf49a466cfe33b2e98de9b46425eec170e59eb40d3f69d061a67778,
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<GlobalConfig>(v1);
    }

    public(friend) fun max_fund_base(arg0: &GlobalConfig) : u64 {
        arg0.max_fund_base
    }

    public(friend) fun max_trader_fee(arg0: &GlobalConfig) : u64 {
        arg0.max_trader_fee
    }

    public(friend) fun min_fund_base(arg0: &GlobalConfig) : u64 {
        arg0.min_fund_base
    }

    public(friend) fun min_rewards(arg0: &GlobalConfig) : u64 {
        arg0.min_rewards
    }

    public(friend) fun platform(arg0: &GlobalConfig) : address {
        arg0.platform
    }

    public(friend) fun platform_fee(arg0: &GlobalConfig) : u64 {
        arg0.platform_fee
    }

    public fun set_platform(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: address) {
        arg1.platform = arg2;
    }

    public(friend) fun settle_percentage(arg0: &GlobalConfig) : u64 {
        arg0.settle_percentage
    }

    public fun update_max_base(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: u64) {
        arg1.max_fund_base = arg2;
    }

    public fun update_min_base(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: u64) {
        arg1.min_fund_base = arg2;
    }

    public fun update_platform_fee(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: u64) {
        arg1.platform_fee = arg2;
    }

    public fun update_trader_fee(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: u64) {
        arg1.max_trader_fee = arg2;
    }

    public fun upgrade(arg0: &AdminCap, arg1: &mut GlobalConfig) {
        arg1.version = arg1.version + 1;
    }

    // decompiled from Move bytecode v6
}

