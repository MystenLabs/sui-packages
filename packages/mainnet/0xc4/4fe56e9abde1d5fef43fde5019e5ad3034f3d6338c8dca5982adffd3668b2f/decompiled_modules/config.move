module 0xc44fe56e9abde1d5fef43fde5019e5ad3034f3d6338c8dca5982adffd3668b2f::config {
    struct CONFIG has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct StakingConfig has store, key {
        id: 0x2::object::UID,
        staking_rules: 0x2::vec_map::VecMap<u64, StakingRule>,
    }

    struct StakingRule has drop, store {
        staking_days: u64,
        annualized_interest_rate_bp: u16,
        staking_quantity_range_min: u64,
        staking_quantity_range_max: u64,
    }

    struct AddedRule has copy, drop {
        added_staking_days: u64,
        added_time: u64,
        added_interest_rate: u16,
        added_quantity_range_min: u64,
        added_quantity_range_max: u64,
    }

    struct RemovedRule has copy, drop {
        removed_staking_days: u64,
        removed_time: u64,
        removed_intrest_rate: u16,
        removed_quantity_range_min: u64,
        removed_quantity_range_max: u64,
    }

    public fun add_staking_rule(arg0: &AdminCap, arg1: &mut StakingConfig, arg2: u64, arg3: u16, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock) {
        assert!(arg2 > 0, 1);
        assert!(arg3 <= 10000, 0);
        assert!(!0x2::vec_map::contains<u64, StakingRule>(&arg1.staking_rules, &arg2), 2);
        assert!(arg4 < arg5, 3);
        let v0 = StakingRule{
            staking_days                : arg2,
            annualized_interest_rate_bp : arg3,
            staking_quantity_range_min  : arg4,
            staking_quantity_range_max  : arg5,
        };
        0x2::vec_map::insert<u64, StakingRule>(&mut arg1.staking_rules, arg2, v0);
        let v1 = AddedRule{
            added_staking_days       : arg2,
            added_time               : 0x2::clock::timestamp_ms(arg6),
            added_interest_rate      : arg3,
            added_quantity_range_min : arg4,
            added_quantity_range_max : arg5,
        };
        0x2::event::emit<AddedRule>(v1);
    }

    public fun annualized_interest_rate_bp(arg0: &StakingRule) : u16 {
        arg0.annualized_interest_rate_bp
    }

    public fun get_staking_rule(arg0: &StakingConfig, arg1: u64) : &StakingRule {
        assert!(0x2::vec_map::contains<u64, StakingRule>(&arg0.staking_rules, &arg1), 4);
        let (_, v1) = 0x2::vec_map::get_entry_by_idx<u64, StakingRule>(&arg0.staking_rules, 0x2::vec_map::get_idx<u64, StakingRule>(&arg0.staking_rules, &arg1));
        v1
    }

    fun init(arg0: CONFIG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = StakingConfig{
            id            : 0x2::object::new(arg1),
            staking_rules : 0x2::vec_map::empty<u64, StakingRule>(),
        };
        let v1 = StakingRule{
            staking_days                : 10,
            annualized_interest_rate_bp : 1000,
            staking_quantity_range_min  : 1 * 1000000000,
            staking_quantity_range_max  : 1000000000 * 1000000000,
        };
        0x2::vec_map::insert<u64, StakingRule>(&mut v0.staking_rules, 10, v1);
        0x2::transfer::public_share_object<StakingConfig>(v0);
        let v2 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v2, 0x2::tx_context::sender(arg1));
        0x2::package::claim_and_keep<CONFIG>(arg0, arg1);
    }

    public fun mul_div_round(arg0: u64, arg1: u64, arg2: u64) : u64 {
        ((((arg0 as u128) * (arg1 as u128) + ((arg2 as u128) >> 1)) / (arg2 as u128)) as u64)
    }

    public fun remove_staking_rule(arg0: &AdminCap, arg1: &mut StakingConfig, arg2: u64, arg3: &0x2::clock::Clock) : StakingRule {
        let (_, v1) = 0x2::vec_map::remove<u64, StakingRule>(&mut arg1.staking_rules, &arg2);
        let v2 = v1;
        let v3 = RemovedRule{
            removed_staking_days       : arg2,
            removed_time               : 0x2::clock::timestamp_ms(arg3),
            removed_intrest_rate       : v2.annualized_interest_rate_bp,
            removed_quantity_range_min : v2.staking_quantity_range_min,
            removed_quantity_range_max : v2.staking_quantity_range_max,
        };
        0x2::event::emit<RemovedRule>(v3);
        v2
    }

    public fun staking_quantity_range(arg0: &StakingRule) : (u64, u64) {
        (arg0.staking_quantity_range_min, arg0.staking_quantity_range_max)
    }

    public fun staking_reward(arg0: &StakingConfig, arg1: u64, arg2: u64) : u64 {
        mul_div_round(0x2::math::divide_and_round_up((get_staking_rule(arg0, arg1).annualized_interest_rate_bp as u64) * arg1, 360), arg2, 10000)
    }

    // decompiled from Move bytecode v6
}

