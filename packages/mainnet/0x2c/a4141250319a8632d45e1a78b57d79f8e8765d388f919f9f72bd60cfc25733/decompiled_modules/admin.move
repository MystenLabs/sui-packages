module 0x2ca4141250319a8632d45e1a78b57d79f8e8765d388f919f9f72bd60cfc25733::admin {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct CreateIncentivePoolsEvent has copy, drop {
        incentive_pools_id: 0x2::object::ID,
        incentive_accounts_id: 0x2::object::ID,
    }

    struct UpdateIncentivePoolPointEvent has copy, drop {
        incentive_pool_id: 0x2::object::ID,
        pool_type: 0x1::type_name::TypeName,
        point_type: 0x1::type_name::TypeName,
        incentive_duration: u64,
        distributed_point_per_period: u64,
        previous_points: u64,
        current_points: u64,
        updated_at: u64,
    }

    struct UpdateIncentivePoolParamsEvent has copy, drop {
        incentive_pool_id: 0x2::object::ID,
        pool_type: 0x1::type_name::TypeName,
        max_stakes: u64,
    }

    struct UpdateRewardFeeConfigEvent has copy, drop {
        incentive_pool_id: 0x2::object::ID,
        fee_rate_numerator: u64,
        fee_rate_denominator: u64,
        fee_recipient: address,
    }

    struct UpdateConfigEvent has copy, drop {
        prev_version: u64,
        version: u64,
        prev_enabled: bool,
        enabled: bool,
        updated_at: u64,
    }

    public entry fun add_points<T0, T1>(arg0: &AdminCap, arg1: &mut 0x2ca4141250319a8632d45e1a78b57d79f8e8765d388f919f9f72bd60cfc25733::incentive_pool::IncentivePools, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock) {
        0x2ca4141250319a8632d45e1a78b57d79f8e8765d388f919f9f72bd60cfc25733::incentive_pool::accrue_all_points(arg1, arg6);
        assert!(arg2 <= 0x2ca4141250319a8632d45e1a78b57d79f8e8765d388f919f9f72bd60cfc25733::incentive_pool::weight_scale(), 1);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        0x2ca4141250319a8632d45e1a78b57d79f8e8765d388f919f9f72bd60cfc25733::incentive_pool::create_incentive_pool_point_if_not_exist<T0, T1>(arg1, arg6);
        let v2 = 0x2ca4141250319a8632d45e1a78b57d79f8e8765d388f919f9f72bd60cfc25733::incentive_pool::points(0x2ca4141250319a8632d45e1a78b57d79f8e8765d388f919f9f72bd60cfc25733::incentive_pool::pool_point(0x2ca4141250319a8632d45e1a78b57d79f8e8765d388f919f9f72bd60cfc25733::incentive_pool::incentive_pool(arg1, v0), v1));
        let v3 = v2 + arg5;
        let v4 = v3 / arg4 / arg3;
        0x2ca4141250319a8632d45e1a78b57d79f8e8765d388f919f9f72bd60cfc25733::incentive_pool::update_incentive_pool_point<T0, T1>(arg1, v4, arg3, arg2, v3);
        let v5 = UpdateIncentivePoolPointEvent{
            incentive_pool_id            : 0x2::object::id<0x2ca4141250319a8632d45e1a78b57d79f8e8765d388f919f9f72bd60cfc25733::incentive_pool::IncentivePools>(arg1),
            pool_type                    : v0,
            point_type                   : v1,
            incentive_duration           : arg4,
            distributed_point_per_period : v4,
            previous_points              : v2,
            current_points               : v3,
            updated_at                   : 0x2::clock::timestamp_ms(arg6) / 1000,
        };
        0x2::event::emit<UpdateIncentivePoolPointEvent>(v5);
    }

    public entry fun add_rewards<T0, T1>(arg0: &mut 0x2ca4141250319a8632d45e1a78b57d79f8e8765d388f919f9f72bd60cfc25733::incentive_pool::IncentivePools, arg1: 0x2::coin::Coin<T1>) {
        assert!(0x2::coin::value<T1>(&arg1) > 0, 3);
        0x2ca4141250319a8632d45e1a78b57d79f8e8765d388f919f9f72bd60cfc25733::incentive_pool::add_rewards<T1>(arg0, 0x1::type_name::get<T0>(), 0x2::coin::into_balance<T1>(arg1));
    }

    public entry fun create_incentive_pools(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2ca4141250319a8632d45e1a78b57d79f8e8765d388f919f9f72bd60cfc25733::incentive_pool::create_incentive_pools(arg1);
        let v1 = CreateIncentivePoolsEvent{
            incentive_pools_id    : 0x2ca4141250319a8632d45e1a78b57d79f8e8765d388f919f9f72bd60cfc25733::typed_id::to_id<0x2ca4141250319a8632d45e1a78b57d79f8e8765d388f919f9f72bd60cfc25733::incentive_pool::IncentivePools>(v0),
            incentive_accounts_id : 0x2ca4141250319a8632d45e1a78b57d79f8e8765d388f919f9f72bd60cfc25733::typed_id::to_id<0x2ca4141250319a8632d45e1a78b57d79f8e8765d388f919f9f72bd60cfc25733::incentive_account::IncentiveAccounts>(0x2ca4141250319a8632d45e1a78b57d79f8e8765d388f919f9f72bd60cfc25733::incentive_account::create_incentive_accounts(&v0, arg1)),
        };
        0x2::event::emit<CreateIncentivePoolsEvent>(v1);
    }

    public entry fun disable(arg0: &AdminCap, arg1: &mut 0x2ca4141250319a8632d45e1a78b57d79f8e8765d388f919f9f72bd60cfc25733::incentive_config::IncentiveConfig, arg2: &0x2::clock::Clock) {
        0x2ca4141250319a8632d45e1a78b57d79f8e8765d388f919f9f72bd60cfc25733::incentive_config::disable(arg1);
        let v0 = UpdateConfigEvent{
            prev_version : 0x2ca4141250319a8632d45e1a78b57d79f8e8765d388f919f9f72bd60cfc25733::incentive_config::version(arg1),
            version      : 0x2ca4141250319a8632d45e1a78b57d79f8e8765d388f919f9f72bd60cfc25733::incentive_config::version(arg1),
            prev_enabled : 0x2ca4141250319a8632d45e1a78b57d79f8e8765d388f919f9f72bd60cfc25733::incentive_config::enabled(arg1),
            enabled      : false,
            updated_at   : 0x2::clock::timestamp_ms(arg2) / 1000,
        };
        0x2::event::emit<UpdateConfigEvent>(v0);
    }

    public entry fun enable(arg0: &AdminCap, arg1: &mut 0x2ca4141250319a8632d45e1a78b57d79f8e8765d388f919f9f72bd60cfc25733::incentive_config::IncentiveConfig, arg2: &0x2::clock::Clock) {
        0x2ca4141250319a8632d45e1a78b57d79f8e8765d388f919f9f72bd60cfc25733::incentive_config::enable(arg1);
        let v0 = UpdateConfigEvent{
            prev_version : 0x2ca4141250319a8632d45e1a78b57d79f8e8765d388f919f9f72bd60cfc25733::incentive_config::version(arg1),
            version      : 0x2ca4141250319a8632d45e1a78b57d79f8e8765d388f919f9f72bd60cfc25733::incentive_config::version(arg1),
            prev_enabled : 0x2ca4141250319a8632d45e1a78b57d79f8e8765d388f919f9f72bd60cfc25733::incentive_config::enabled(arg1),
            enabled      : true,
            updated_at   : 0x2::clock::timestamp_ms(arg2) / 1000,
        };
        0x2::event::emit<UpdateConfigEvent>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun take_points<T0, T1>(arg0: &AdminCap, arg1: &mut 0x2ca4141250319a8632d45e1a78b57d79f8e8765d388f919f9f72bd60cfc25733::incentive_pool::IncentivePools, arg2: 0x1::option::Option<u64>, arg3: &0x2::clock::Clock) {
        0x2ca4141250319a8632d45e1a78b57d79f8e8765d388f919f9f72bd60cfc25733::incentive_pool::accrue_all_points(arg1, arg3);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        let v2 = 0x2ca4141250319a8632d45e1a78b57d79f8e8765d388f919f9f72bd60cfc25733::incentive_pool::pool_point(0x2ca4141250319a8632d45e1a78b57d79f8e8765d388f919f9f72bd60cfc25733::incentive_pool::incentive_pool(arg1, v0), v1);
        let v3 = 0x2ca4141250319a8632d45e1a78b57d79f8e8765d388f919f9f72bd60cfc25733::incentive_pool::points(v2);
        if (0x1::option::is_some<u64>(&arg2)) {
            v3 = 0x1::option::extract<u64>(&mut arg2);
        };
        let v4 = 0x2ca4141250319a8632d45e1a78b57d79f8e8765d388f919f9f72bd60cfc25733::incentive_pool::points(v2) - v3;
        let v5 = 0x2ca4141250319a8632d45e1a78b57d79f8e8765d388f919f9f72bd60cfc25733::incentive_pool::distributed_point_per_period(v2);
        let v6 = 0x2ca4141250319a8632d45e1a78b57d79f8e8765d388f919f9f72bd60cfc25733::incentive_pool::point_distribution_time(v2);
        0x2ca4141250319a8632d45e1a78b57d79f8e8765d388f919f9f72bd60cfc25733::incentive_pool::update_incentive_pool_point<T0, T1>(arg1, v5, v6, 0x2ca4141250319a8632d45e1a78b57d79f8e8765d388f919f9f72bd60cfc25733::incentive_pool::base_weight(v2), v4);
        let v7 = UpdateIncentivePoolPointEvent{
            incentive_pool_id            : 0x2::object::id<0x2ca4141250319a8632d45e1a78b57d79f8e8765d388f919f9f72bd60cfc25733::incentive_pool::IncentivePools>(arg1),
            pool_type                    : v0,
            point_type                   : v1,
            incentive_duration           : v4 / v5 * v6,
            distributed_point_per_period : v5,
            previous_points              : v4 + v3,
            current_points               : v4,
            updated_at                   : 0x2::clock::timestamp_ms(arg3) / 1000,
        };
        0x2::event::emit<UpdateIncentivePoolPointEvent>(v7);
    }

    public fun take_rewards<T0, T1>(arg0: &AdminCap, arg1: &mut 0x2ca4141250319a8632d45e1a78b57d79f8e8765d388f919f9f72bd60cfc25733::incentive_pool::IncentivePools, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(arg2 > 0, 3);
        0x2::coin::from_balance<T1>(0x2ca4141250319a8632d45e1a78b57d79f8e8765d388f919f9f72bd60cfc25733::incentive_pool::take_rewards<T1>(arg1, 0x1::type_name::get<T0>(), arg2), arg3)
    }

    public entry fun update_incentive_pool_params<T0>(arg0: &AdminCap, arg1: &mut 0x2ca4141250319a8632d45e1a78b57d79f8e8765d388f919f9f72bd60cfc25733::incentive_pool::IncentivePools, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        abort 0x2ca4141250319a8632d45e1a78b57d79f8e8765d388f919f9f72bd60cfc25733::app_error::deprecated()
    }

    public entry fun update_incentive_pool_params_v2<T0>(arg0: &AdminCap, arg1: &mut 0x2ca4141250319a8632d45e1a78b57d79f8e8765d388f919f9f72bd60cfc25733::incentive_pool::IncentivePools, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= arg3, 2);
        0x2ca4141250319a8632d45e1a78b57d79f8e8765d388f919f9f72bd60cfc25733::incentive_pool::create_incentive_pool_if_not_exist<T0>(arg1, arg5);
        0x2ca4141250319a8632d45e1a78b57d79f8e8765d388f919f9f72bd60cfc25733::incentive_pool::accrue_all_points(arg1, arg4);
        0x2ca4141250319a8632d45e1a78b57d79f8e8765d388f919f9f72bd60cfc25733::incentive_pool::update_incentive_pool_params<T0>(arg1, arg2, arg3);
        let v0 = UpdateIncentivePoolParamsEvent{
            incentive_pool_id : 0x2::object::id<0x2ca4141250319a8632d45e1a78b57d79f8e8765d388f919f9f72bd60cfc25733::incentive_pool::IncentivePools>(arg1),
            pool_type         : 0x1::type_name::get<T0>(),
            max_stakes        : arg3,
        };
        0x2::event::emit<UpdateIncentivePoolParamsEvent>(v0);
    }

    public entry fun update_reward_fee_pool_config(arg0: &AdminCap, arg1: &mut 0x2ca4141250319a8632d45e1a78b57d79f8e8765d388f919f9f72bd60cfc25733::incentive_pool::IncentivePools, arg2: u64, arg3: u64, arg4: address) {
        0x2ca4141250319a8632d45e1a78b57d79f8e8765d388f919f9f72bd60cfc25733::incentive_pool::update_reward_fee(arg1, arg2, arg3, arg4);
        let v0 = UpdateRewardFeeConfigEvent{
            incentive_pool_id    : 0x2::object::id<0x2ca4141250319a8632d45e1a78b57d79f8e8765d388f919f9f72bd60cfc25733::incentive_pool::IncentivePools>(arg1),
            fee_rate_numerator   : arg2,
            fee_rate_denominator : arg3,
            fee_recipient        : arg4,
        };
        0x2::event::emit<UpdateRewardFeeConfigEvent>(v0);
    }

    public entry fun upgrade_version(arg0: &AdminCap, arg1: &mut 0x2ca4141250319a8632d45e1a78b57d79f8e8765d388f919f9f72bd60cfc25733::incentive_config::IncentiveConfig, arg2: &0x2::clock::Clock) {
        let v0 = 0x2ca4141250319a8632d45e1a78b57d79f8e8765d388f919f9f72bd60cfc25733::incentive_config::version(arg1) + 1;
        0x2ca4141250319a8632d45e1a78b57d79f8e8765d388f919f9f72bd60cfc25733::incentive_config::upgrade_version(arg1, v0);
        let v1 = UpdateConfigEvent{
            prev_version : 0x2ca4141250319a8632d45e1a78b57d79f8e8765d388f919f9f72bd60cfc25733::incentive_config::version(arg1),
            version      : v0,
            prev_enabled : 0x2ca4141250319a8632d45e1a78b57d79f8e8765d388f919f9f72bd60cfc25733::incentive_config::enabled(arg1),
            enabled      : 0x2ca4141250319a8632d45e1a78b57d79f8e8765d388f919f9f72bd60cfc25733::incentive_config::enabled(arg1),
            updated_at   : 0x2::clock::timestamp_ms(arg2) / 1000,
        };
        0x2::event::emit<UpdateConfigEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

