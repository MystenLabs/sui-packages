module 0x1ade636df344cc669d3ec43964bff92ecdd6e02a3f7787349b38047bd320c094::admin {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct DelegatedCap has key {
        id: 0x2::object::UID,
        authorities: 0x2::vec_set::VecSet<address>,
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

    struct RefreshIncentiveBoostEvent has copy, drop {
        obligation_id: 0x2::object::ID,
        binded_ve_sca_id: 0x1::option::Option<0x2::object::ID>,
        sender: address,
        timestamp: u64,
    }

    public entry fun add_delegated_authority(arg0: &AdminCap, arg1: &mut DelegatedCap, arg2: address) {
        0x2::vec_set::insert<address>(&mut arg1.authorities, arg2);
    }

    public entry fun add_points<T0, T1>(arg0: &AdminCap, arg1: &mut 0x1ade636df344cc669d3ec43964bff92ecdd6e02a3f7787349b38047bd320c094::incentive_pool::IncentivePools, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock) {
        0x1ade636df344cc669d3ec43964bff92ecdd6e02a3f7787349b38047bd320c094::incentive_pool::accrue_all_points(arg1, arg6);
        assert!(arg2 <= 0x1ade636df344cc669d3ec43964bff92ecdd6e02a3f7787349b38047bd320c094::incentive_pool::weight_scale(), 1);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        0x1ade636df344cc669d3ec43964bff92ecdd6e02a3f7787349b38047bd320c094::incentive_pool::create_incentive_pool_point_if_not_exist<T0, T1>(arg1, arg6);
        let v2 = 0x1ade636df344cc669d3ec43964bff92ecdd6e02a3f7787349b38047bd320c094::incentive_pool::points(0x1ade636df344cc669d3ec43964bff92ecdd6e02a3f7787349b38047bd320c094::incentive_pool::pool_point(0x1ade636df344cc669d3ec43964bff92ecdd6e02a3f7787349b38047bd320c094::incentive_pool::incentive_pool(arg1, v0), v1));
        let v3 = v2 + arg5;
        let v4 = v3 / arg4 / arg3;
        0x1ade636df344cc669d3ec43964bff92ecdd6e02a3f7787349b38047bd320c094::incentive_pool::update_incentive_pool_point<T0, T1>(arg1, v4, arg3, arg2, v3);
        let v5 = UpdateIncentivePoolPointEvent{
            incentive_pool_id            : 0x2::object::id<0x1ade636df344cc669d3ec43964bff92ecdd6e02a3f7787349b38047bd320c094::incentive_pool::IncentivePools>(arg1),
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

    public entry fun add_rewards<T0, T1>(arg0: &mut 0x1ade636df344cc669d3ec43964bff92ecdd6e02a3f7787349b38047bd320c094::incentive_pool::IncentivePools, arg1: 0x2::coin::Coin<T1>) {
        assert!(0x2::coin::value<T1>(&arg1) > 0, 3);
        0x1ade636df344cc669d3ec43964bff92ecdd6e02a3f7787349b38047bd320c094::incentive_pool::add_rewards<T1>(arg0, 0x1::type_name::get<T0>(), 0x2::coin::into_balance<T1>(arg1));
    }

    public entry fun add_similar_coin<T0, T1>(arg0: &AdminCap, arg1: &mut 0x1ade636df344cc669d3ec43964bff92ecdd6e02a3f7787349b38047bd320c094::incentive_pool::IncentivePools) {
        0x1ade636df344cc669d3ec43964bff92ecdd6e02a3f7787349b38047bd320c094::incentive_pool::add_similar_coin(arg1, 0x1::type_name::get<T0>(), 0x1::type_name::get<T1>());
    }

    public fun assert_delegate_authority(arg0: &DelegatedCap, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::vec_set::contains<address>(&arg0.authorities, &v0), 4);
    }

    public entry fun create_incentive_pools(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1ade636df344cc669d3ec43964bff92ecdd6e02a3f7787349b38047bd320c094::incentive_pool::create_incentive_pools(arg1);
        let v1 = CreateIncentivePoolsEvent{
            incentive_pools_id    : 0x1ade636df344cc669d3ec43964bff92ecdd6e02a3f7787349b38047bd320c094::typed_id::to_id<0x1ade636df344cc669d3ec43964bff92ecdd6e02a3f7787349b38047bd320c094::incentive_pool::IncentivePools>(v0),
            incentive_accounts_id : 0x1ade636df344cc669d3ec43964bff92ecdd6e02a3f7787349b38047bd320c094::typed_id::to_id<0x1ade636df344cc669d3ec43964bff92ecdd6e02a3f7787349b38047bd320c094::incentive_account::IncentiveAccounts>(0x1ade636df344cc669d3ec43964bff92ecdd6e02a3f7787349b38047bd320c094::incentive_account::create_incentive_accounts(&v0, arg1)),
        };
        0x2::event::emit<CreateIncentivePoolsEvent>(v1);
    }

    public entry fun disable(arg0: &AdminCap, arg1: &mut 0x1ade636df344cc669d3ec43964bff92ecdd6e02a3f7787349b38047bd320c094::incentive_config::IncentiveConfig, arg2: &0x2::clock::Clock) {
        0x1ade636df344cc669d3ec43964bff92ecdd6e02a3f7787349b38047bd320c094::incentive_config::disable(arg1);
        let v0 = UpdateConfigEvent{
            prev_version : 0x1ade636df344cc669d3ec43964bff92ecdd6e02a3f7787349b38047bd320c094::incentive_config::version(arg1),
            version      : 0x1ade636df344cc669d3ec43964bff92ecdd6e02a3f7787349b38047bd320c094::incentive_config::version(arg1),
            prev_enabled : 0x1ade636df344cc669d3ec43964bff92ecdd6e02a3f7787349b38047bd320c094::incentive_config::enabled(arg1),
            enabled      : false,
            updated_at   : 0x2::clock::timestamp_ms(arg2) / 1000,
        };
        0x2::event::emit<UpdateConfigEvent>(v0);
    }

    public entry fun enable(arg0: &AdminCap, arg1: &mut 0x1ade636df344cc669d3ec43964bff92ecdd6e02a3f7787349b38047bd320c094::incentive_config::IncentiveConfig, arg2: &0x2::clock::Clock) {
        0x1ade636df344cc669d3ec43964bff92ecdd6e02a3f7787349b38047bd320c094::incentive_config::enable(arg1);
        let v0 = UpdateConfigEvent{
            prev_version : 0x1ade636df344cc669d3ec43964bff92ecdd6e02a3f7787349b38047bd320c094::incentive_config::version(arg1),
            version      : 0x1ade636df344cc669d3ec43964bff92ecdd6e02a3f7787349b38047bd320c094::incentive_config::version(arg1),
            prev_enabled : 0x1ade636df344cc669d3ec43964bff92ecdd6e02a3f7787349b38047bd320c094::incentive_config::enabled(arg1),
            enabled      : true,
            updated_at   : 0x2::clock::timestamp_ms(arg2) / 1000,
        };
        0x2::event::emit<UpdateConfigEvent>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        let v2 = &mut v1;
        init_delegated_cap(v2, arg0);
        0x2::transfer::transfer<AdminCap>(v1, v0);
    }

    fun init_delegated_cap(arg0: &mut AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<DelegatedCap>();
        assert!(!0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0), 5);
        0x2::dynamic_field::add<0x1::type_name::TypeName, bool>(&mut arg0.id, v0, true);
        let v1 = DelegatedCap{
            id          : 0x2::object::new(arg1),
            authorities : 0x2::vec_set::empty<address>(),
        };
        0x2::transfer::share_object<DelegatedCap>(v1);
    }

    public entry fun init_delegated_cap_if_not_exist(arg0: &mut AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        init_delegated_cap(arg0, arg1);
    }

    public entry fun refresh_incentive_boost(arg0: &DelegatedCap, arg1: &0x1ade636df344cc669d3ec43964bff92ecdd6e02a3f7787349b38047bd320c094::incentive_config::IncentiveConfig, arg2: &mut 0x1ade636df344cc669d3ec43964bff92ecdd6e02a3f7787349b38047bd320c094::incentive_pool::IncentivePools, arg3: &mut 0x1ade636df344cc669d3ec43964bff92ecdd6e02a3f7787349b38047bd320c094::incentive_account::IncentiveAccounts, arg4: &0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::config::VeScaProtocolConfig, arg5: &mut 0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::treasury::VeScaTreasury, arg6: &0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaTable, arg7: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert_delegate_authority(arg0, arg9);
        0x1ade636df344cc669d3ec43964bff92ecdd6e02a3f7787349b38047bd320c094::incentive_config::assert_version_and_status(arg1);
        0x1ade636df344cc669d3ec43964bff92ecdd6e02a3f7787349b38047bd320c094::incentive_account::assert_incentive_pools(arg3, arg2);
        if (!0x1ade636df344cc669d3ec43964bff92ecdd6e02a3f7787349b38047bd320c094::incentive_account::is_incentive_account_exist(arg3, arg7)) {
            return
        };
        let v0 = 0;
        let v1 = 0;
        let v2 = 0x1::option::none<0x2::object::ID>();
        if (0x1ade636df344cc669d3ec43964bff92ecdd6e02a3f7787349b38047bd320c094::incentive_account::is_ve_sca_key_binded(arg3, arg7)) {
            0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::treasury::refresh(arg4, arg5, arg8);
            let v3 = 0x1ade636df344cc669d3ec43964bff92ecdd6e02a3f7787349b38047bd320c094::incentive_account::get_binded_ve_sca(arg3, arg7);
            let v4 = *0x1ade636df344cc669d3ec43964bff92ecdd6e02a3f7787349b38047bd320c094::typed_id::as_id<0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey>(&v3);
            v0 = 0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::ve_sca_amount(v4, arg6, arg8);
            v1 = 0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::treasury::total_ve_sca_amount(arg5, arg8);
            v2 = 0x1::option::some<0x2::object::ID>(v4);
        };
        0x1ade636df344cc669d3ec43964bff92ecdd6e02a3f7787349b38047bd320c094::incentive_pool::accrue_all_points(arg2, arg8);
        0x1ade636df344cc669d3ec43964bff92ecdd6e02a3f7787349b38047bd320c094::incentive_account::accrue_all_points(arg2, arg3, arg7, arg8);
        0x1ade636df344cc669d3ec43964bff92ecdd6e02a3f7787349b38047bd320c094::incentive_account::recalculate_stake(arg7, arg3, arg2, v0, v1, arg9);
        let v5 = RefreshIncentiveBoostEvent{
            obligation_id    : 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation>(arg7),
            binded_ve_sca_id : v2,
            sender           : 0x2::tx_context::sender(arg9),
            timestamp        : 0x2::clock::timestamp_ms(arg8) / 1000,
        };
        0x2::event::emit<RefreshIncentiveBoostEvent>(v5);
    }

    public entry fun remove_delegated_authority(arg0: &AdminCap, arg1: &mut DelegatedCap, arg2: address) {
        0x2::vec_set::remove<address>(&mut arg1.authorities, &arg2);
    }

    public entry fun remove_similar_coin<T0, T1>(arg0: &AdminCap, arg1: &mut 0x1ade636df344cc669d3ec43964bff92ecdd6e02a3f7787349b38047bd320c094::incentive_pool::IncentivePools) {
        0x1ade636df344cc669d3ec43964bff92ecdd6e02a3f7787349b38047bd320c094::incentive_pool::remove_similar_coin(arg1, 0x1::type_name::get<T0>(), 0x1::type_name::get<T1>());
    }

    public entry fun take_points<T0, T1>(arg0: &AdminCap, arg1: &mut 0x1ade636df344cc669d3ec43964bff92ecdd6e02a3f7787349b38047bd320c094::incentive_pool::IncentivePools, arg2: 0x1::option::Option<u64>, arg3: &0x2::clock::Clock) {
        0x1ade636df344cc669d3ec43964bff92ecdd6e02a3f7787349b38047bd320c094::incentive_pool::accrue_all_points(arg1, arg3);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        let v2 = 0x1ade636df344cc669d3ec43964bff92ecdd6e02a3f7787349b38047bd320c094::incentive_pool::pool_point(0x1ade636df344cc669d3ec43964bff92ecdd6e02a3f7787349b38047bd320c094::incentive_pool::incentive_pool(arg1, v0), v1);
        let v3 = 0x1ade636df344cc669d3ec43964bff92ecdd6e02a3f7787349b38047bd320c094::incentive_pool::points(v2);
        if (0x1::option::is_some<u64>(&arg2)) {
            v3 = 0x1::option::extract<u64>(&mut arg2);
        };
        let v4 = 0x1ade636df344cc669d3ec43964bff92ecdd6e02a3f7787349b38047bd320c094::incentive_pool::points(v2) - v3;
        let v5 = 0x1ade636df344cc669d3ec43964bff92ecdd6e02a3f7787349b38047bd320c094::incentive_pool::distributed_point_per_period(v2);
        let v6 = 0x1ade636df344cc669d3ec43964bff92ecdd6e02a3f7787349b38047bd320c094::incentive_pool::point_distribution_time(v2);
        0x1ade636df344cc669d3ec43964bff92ecdd6e02a3f7787349b38047bd320c094::incentive_pool::update_incentive_pool_point<T0, T1>(arg1, v5, v6, 0x1ade636df344cc669d3ec43964bff92ecdd6e02a3f7787349b38047bd320c094::incentive_pool::base_weight(v2), v4);
        let v7 = UpdateIncentivePoolPointEvent{
            incentive_pool_id            : 0x2::object::id<0x1ade636df344cc669d3ec43964bff92ecdd6e02a3f7787349b38047bd320c094::incentive_pool::IncentivePools>(arg1),
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

    public fun take_rewards<T0, T1>(arg0: &AdminCap, arg1: &mut 0x1ade636df344cc669d3ec43964bff92ecdd6e02a3f7787349b38047bd320c094::incentive_pool::IncentivePools, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(arg2 > 0, 3);
        0x2::coin::from_balance<T1>(0x1ade636df344cc669d3ec43964bff92ecdd6e02a3f7787349b38047bd320c094::incentive_pool::take_rewards<T1>(arg1, 0x1::type_name::get<T0>(), arg2), arg3)
    }

    public entry fun update_incentive_pool_params<T0>(arg0: &AdminCap, arg1: &mut 0x1ade636df344cc669d3ec43964bff92ecdd6e02a3f7787349b38047bd320c094::incentive_pool::IncentivePools, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        abort 0x1ade636df344cc669d3ec43964bff92ecdd6e02a3f7787349b38047bd320c094::app_error::deprecated()
    }

    public entry fun update_incentive_pool_params_v2<T0>(arg0: &AdminCap, arg1: &mut 0x1ade636df344cc669d3ec43964bff92ecdd6e02a3f7787349b38047bd320c094::incentive_pool::IncentivePools, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= arg3, 2);
        0x1ade636df344cc669d3ec43964bff92ecdd6e02a3f7787349b38047bd320c094::incentive_pool::create_incentive_pool_if_not_exist<T0>(arg1, arg5);
        0x1ade636df344cc669d3ec43964bff92ecdd6e02a3f7787349b38047bd320c094::incentive_pool::accrue_all_points(arg1, arg4);
        0x1ade636df344cc669d3ec43964bff92ecdd6e02a3f7787349b38047bd320c094::incentive_pool::update_incentive_pool_params<T0>(arg1, arg2, arg3);
        let v0 = UpdateIncentivePoolParamsEvent{
            incentive_pool_id : 0x2::object::id<0x1ade636df344cc669d3ec43964bff92ecdd6e02a3f7787349b38047bd320c094::incentive_pool::IncentivePools>(arg1),
            pool_type         : 0x1::type_name::get<T0>(),
            max_stakes        : arg3,
        };
        0x2::event::emit<UpdateIncentivePoolParamsEvent>(v0);
    }

    public entry fun update_reward_fee_pool_config(arg0: &AdminCap, arg1: &mut 0x1ade636df344cc669d3ec43964bff92ecdd6e02a3f7787349b38047bd320c094::incentive_pool::IncentivePools, arg2: u64, arg3: u64, arg4: address) {
        0x1ade636df344cc669d3ec43964bff92ecdd6e02a3f7787349b38047bd320c094::incentive_pool::update_reward_fee(arg1, arg2, arg3, arg4);
        let v0 = UpdateRewardFeeConfigEvent{
            incentive_pool_id    : 0x2::object::id<0x1ade636df344cc669d3ec43964bff92ecdd6e02a3f7787349b38047bd320c094::incentive_pool::IncentivePools>(arg1),
            fee_rate_numerator   : arg2,
            fee_rate_denominator : arg3,
            fee_recipient        : arg4,
        };
        0x2::event::emit<UpdateRewardFeeConfigEvent>(v0);
    }

    public entry fun upgrade_version(arg0: &AdminCap, arg1: &mut 0x1ade636df344cc669d3ec43964bff92ecdd6e02a3f7787349b38047bd320c094::incentive_config::IncentiveConfig, arg2: &0x2::clock::Clock) {
        let v0 = 0x1ade636df344cc669d3ec43964bff92ecdd6e02a3f7787349b38047bd320c094::incentive_config::version(arg1) + 1;
        0x1ade636df344cc669d3ec43964bff92ecdd6e02a3f7787349b38047bd320c094::incentive_config::upgrade_version(arg1, v0);
        let v1 = UpdateConfigEvent{
            prev_version : 0x1ade636df344cc669d3ec43964bff92ecdd6e02a3f7787349b38047bd320c094::incentive_config::version(arg1),
            version      : v0,
            prev_enabled : 0x1ade636df344cc669d3ec43964bff92ecdd6e02a3f7787349b38047bd320c094::incentive_config::enabled(arg1),
            enabled      : 0x1ade636df344cc669d3ec43964bff92ecdd6e02a3f7787349b38047bd320c094::incentive_config::enabled(arg1),
            updated_at   : 0x2::clock::timestamp_ms(arg2) / 1000,
        };
        0x2::event::emit<UpdateConfigEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

