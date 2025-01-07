module 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::policy_staking_tier {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        min_stake: u64,
        token_type: 0x1::string::String,
    }

    public(friend) fun add(arg0: &mut 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::policy::Policy, arg1: u64, arg2: 0x1::string::String) {
        let v0 = Config{
            min_stake  : arg1,
            token_type : arg2,
        };
        0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::policy::add_rule<Rule, Config>(arg0, v0);
    }

    public(friend) fun check(arg0: &mut 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::policy::Policy, arg1: &mut 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::policy::Request, arg2: &0xf0cdf14bcac51ef9f468600807f4224c97bc21e4480b34a9cfd51eeae63b297::staking::StakingStorage, arg3: address) {
        let v0 = 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::utils::get_key_by_struct<Rule>();
        if (0x2::vec_set::contains<0x1::string::String>(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::policy::rules(arg0), &v0)) {
            assert!(check_yousui_staking(arg0, arg2, arg3), 1200);
            0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::policy::add_receipt<Rule>(arg1);
        };
    }

    fun check_yousui_staking(arg0: &0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::policy::Policy, arg1: &0xf0cdf14bcac51ef9f468600807f4224c97bc21e4480b34a9cfd51eeae63b297::staking::StakingStorage, arg2: address) : bool {
        let v0 = 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::policy::get_rule<Rule, Config>(arg0);
        0xf0cdf14bcac51ef9f468600807f4224c97bc21e4480b34a9cfd51eeae63b297::staking::get_staking_point_by_address(arg1, arg2, v0.token_type) >= v0.min_stake
    }

    public(friend) fun pass(arg0: &mut 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::policy::Policy, arg1: &mut 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::policy::Request) {
        let v0 = 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::utils::get_key_by_struct<Rule>();
        if (0x2::vec_set::contains<0x1::string::String>(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::policy::rules(arg0), &v0)) {
            0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::policy::add_receipt<Rule>(arg1);
        };
    }

    // decompiled from Move bytecode v6
}

