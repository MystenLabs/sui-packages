module 0xd080be44f455b02fd2c270da6bac8e6ffd508e3fd98ee6b5bdfa9a337b96ed2d::admin {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct UpdateIncentivePoolConfigEvent has copy, drop {
        incentive_pool_id: 0x2::object::ID,
        distributed_point_per_period: u64,
        point_distribution_time: u64,
        max_distributed_point: u64,
        max_stakes: u64,
        updated_at: u64,
    }

    struct UpdateRewardPoolConfigEvent has copy, drop {
        incentive_pool_id: 0x2::object::ID,
        reward_type: 0x1::type_name::TypeName,
        exchange_rate_denominator: u64,
        exchange_rate_numerator: u64,
        updated_at: u64,
    }

    public entry fun add_rewards<T0>(arg0: &mut 0xd080be44f455b02fd2c270da6bac8e6ffd508e3fd98ee6b5bdfa9a337b96ed2d::incentive_pool::IncentivePools<T0>, arg1: 0x2::coin::Coin<T0>) {
        0xd080be44f455b02fd2c270da6bac8e6ffd508e3fd98ee6b5bdfa9a337b96ed2d::incentive_pool::add_rewards<T0>(arg0, 0x2::coin::into_balance<T0>(arg1));
    }

    public entry fun create_incentive_pools<T0>(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<0xd080be44f455b02fd2c270da6bac8e6ffd508e3fd98ee6b5bdfa9a337b96ed2d::incentive_pool::IncentivePools<T0>>(0xd080be44f455b02fd2c270da6bac8e6ffd508e3fd98ee6b5bdfa9a337b96ed2d::incentive_pool::create_incentive_pools<T0>(arg0, arg1, arg2));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun take_rewards<T0>(arg0: &AdminCap, arg1: &mut 0xd080be44f455b02fd2c270da6bac8e6ffd508e3fd98ee6b5bdfa9a337b96ed2d::incentive_pool::IncentivePools<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0xd080be44f455b02fd2c270da6bac8e6ffd508e3fd98ee6b5bdfa9a337b96ed2d::incentive_pool::take_rewards<T0>(arg1, arg2), arg3)
    }

    public entry fun update_pool_config<T0, T1>(arg0: &AdminCap, arg1: &mut 0xd080be44f455b02fd2c270da6bac8e6ffd508e3fd98ee6b5bdfa9a337b96ed2d::incentive_pool::IncentivePools<T1>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock) {
        0xd080be44f455b02fd2c270da6bac8e6ffd508e3fd98ee6b5bdfa9a337b96ed2d::incentive_pool::accrue_all_points<T1>(arg1, arg6);
        0xd080be44f455b02fd2c270da6bac8e6ffd508e3fd98ee6b5bdfa9a337b96ed2d::incentive_pool::update_pool<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6);
        let v0 = UpdateIncentivePoolConfigEvent{
            incentive_pool_id            : 0x2::object::id<0xd080be44f455b02fd2c270da6bac8e6ffd508e3fd98ee6b5bdfa9a337b96ed2d::incentive_pool::IncentivePools<T1>>(arg1),
            distributed_point_per_period : arg2,
            point_distribution_time      : arg3,
            max_distributed_point        : arg4,
            max_stakes                   : arg5,
            updated_at                   : 0x2::clock::timestamp_ms(arg6) / 1000,
        };
        0x2::event::emit<UpdateIncentivePoolConfigEvent>(v0);
    }

    public entry fun update_reward_pool_config<T0>(arg0: &AdminCap, arg1: &mut 0xd080be44f455b02fd2c270da6bac8e6ffd508e3fd98ee6b5bdfa9a337b96ed2d::incentive_pool::IncentivePools<T0>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) {
        0xd080be44f455b02fd2c270da6bac8e6ffd508e3fd98ee6b5bdfa9a337b96ed2d::incentive_pool::update_reward_pool<T0>(arg1, arg2, arg3);
        let v0 = UpdateRewardPoolConfigEvent{
            incentive_pool_id         : 0x2::object::id<0xd080be44f455b02fd2c270da6bac8e6ffd508e3fd98ee6b5bdfa9a337b96ed2d::incentive_pool::IncentivePools<T0>>(arg1),
            reward_type               : 0x1::type_name::get<T0>(),
            exchange_rate_denominator : arg3,
            exchange_rate_numerator   : arg2,
            updated_at                : 0x2::clock::timestamp_ms(arg4) / 1000,
        };
        0x2::event::emit<UpdateRewardPoolConfigEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

