module 0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::admin {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct CreateSpoolEvent has copy, drop {
        spool_id: 0x2::object::ID,
        staking_type: 0x1::type_name::TypeName,
        max_stakes: u64,
        created_at: u64,
    }

    struct UpdateSpoolParamsEvent has copy, drop {
        spool_id: 0x2::object::ID,
        max_stakes: u64,
        updated_at: u64,
    }

    struct UpdateConfigEvent has copy, drop {
        prev_version: u64,
        version: u64,
        prev_enabled: bool,
        enabled: bool,
        updated_at: u64,
    }

    struct UpdateSpoolPointsEvent has copy, drop {
        spool_id: 0x2::object::ID,
        incentive_duration: u64,
        distributed_point_per_period: u64,
        previous_points: u64,
        current_points: u64,
        updated_at: u64,
    }

    struct AddRewardsEvent has copy, drop {
        spool_id: 0x2::object::ID,
        reward_type: 0x1::type_name::TypeName,
        added_rewards: u64,
    }

    struct TakeRewardsEvent has copy, drop {
        spool_id: 0x2::object::ID,
        reward_type: 0x1::type_name::TypeName,
        taken_rewards: u64,
    }

    struct UpdateRewardFeeEvent has copy, drop {
        spool_id: 0x2::object::ID,
        fee_rate_numerator: u64,
        fee_rate_denominator: u64,
        fee_recipient: address,
    }

    public entry fun add_points<T0>(arg0: &AdminCap, arg1: &0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool_config::SpoolConfig, arg2: &mut 0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool::Spool, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock) {
        0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool_config::assert_version(arg1);
        0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool::accrue_points(arg2, arg7);
        assert!(arg3 <= 0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool::weight_scale(), 1);
        let v0 = 0x1::type_name::get<T0>();
        0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool::create_spool_point_if_not_exist<T0>(arg2, arg7);
        let v1 = 0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool::points(0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool::spool_point(arg2, v0));
        let v2 = v1 + arg6;
        let v3 = v2 / arg5 / arg4;
        0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool::update_point(arg2, v0, arg3, arg4, v3, v2);
        let v4 = UpdateSpoolPointsEvent{
            spool_id                     : 0x2::object::id<0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool::Spool>(arg2),
            incentive_duration           : arg5,
            distributed_point_per_period : v3,
            previous_points              : v1,
            current_points               : v2,
            updated_at                   : 0x2::clock::timestamp_ms(arg7) / 1000,
        };
        0x2::event::emit<UpdateSpoolPointsEvent>(v4);
    }

    public entry fun add_rewards<T0>(arg0: &0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool_config::SpoolConfig, arg1: &mut 0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool::Spool, arg2: 0x2::coin::Coin<T0>) {
        0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool_config::assert_version(arg0);
        0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool::add_reward<T0>(arg1, 0x2::coin::into_balance<T0>(arg2));
        let v0 = AddRewardsEvent{
            spool_id      : 0x2::object::id<0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool::Spool>(arg1),
            reward_type   : 0x1::type_name::get<T0>(),
            added_rewards : 0x2::coin::value<T0>(&arg2),
        };
        0x2::event::emit<AddRewardsEvent>(v0);
    }

    public entry fun create_spool<T0>(arg0: &AdminCap, arg1: &0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool_config::SpoolConfig, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool_config::assert_version(arg1);
        assert!(arg2 <= arg3, 2);
        let v0 = 0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool::new<T0>(arg2, arg3, arg5);
        let v1 = CreateSpoolEvent{
            spool_id     : 0x2::object::id<0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool::Spool>(&v0),
            staking_type : 0x1::type_name::get<T0>(),
            max_stakes   : arg3,
            created_at   : 0x2::clock::timestamp_ms(arg4) / 1000,
        };
        0x2::event::emit<CreateSpoolEvent>(v1);
        0x2::transfer::public_share_object<0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool::Spool>(v0);
    }

    public entry fun disable(arg0: &AdminCap, arg1: &mut 0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool_config::SpoolConfig, arg2: &0x2::clock::Clock) {
        0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool_config::disable(arg1);
        let v0 = UpdateConfigEvent{
            prev_version : 0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool_config::version(arg1),
            version      : 0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool_config::version(arg1),
            prev_enabled : 0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool_config::enabled(arg1),
            enabled      : false,
            updated_at   : 0x2::clock::timestamp_ms(arg2) / 1000,
        };
        0x2::event::emit<UpdateConfigEvent>(v0);
    }

    public entry fun enable(arg0: &AdminCap, arg1: &mut 0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool_config::SpoolConfig, arg2: &0x2::clock::Clock) {
        0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool_config::enable(arg1);
        let v0 = UpdateConfigEvent{
            prev_version : 0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool_config::version(arg1),
            version      : 0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool_config::version(arg1),
            prev_enabled : 0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool_config::enabled(arg1),
            enabled      : true,
            updated_at   : 0x2::clock::timestamp_ms(arg2) / 1000,
        };
        0x2::event::emit<UpdateConfigEvent>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun take_points<T0>(arg0: &AdminCap, arg1: &0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool_config::SpoolConfig, arg2: &mut 0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool::Spool, arg3: 0x1::option::Option<u64>, arg4: &0x2::clock::Clock) {
        0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool_config::assert_version(arg1);
        0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool::accrue_points(arg2, arg4);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool::spool_point(arg2, v0);
        let v2 = 0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool::points(v1);
        if (0x1::option::is_some<u64>(&arg3)) {
            v2 = 0x1::option::extract<u64>(&mut arg3);
        };
        let v3 = 0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool::points(v1) - v2;
        let v4 = 0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool::distributed_point_per_period(v1);
        let v5 = 0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool::point_distribution_time(v1);
        0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool::update_point(arg2, v0, 0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool::base_weight(v1), v5, v4, v3);
        let v6 = UpdateSpoolPointsEvent{
            spool_id                     : 0x2::object::id<0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool::Spool>(arg2),
            incentive_duration           : v3 / v4 * v5,
            distributed_point_per_period : v4,
            previous_points              : v3 + v2,
            current_points               : v3,
            updated_at                   : 0x2::clock::timestamp_ms(arg4) / 1000,
        };
        0x2::event::emit<UpdateSpoolPointsEvent>(v6);
    }

    public fun take_rewards<T0>(arg0: &AdminCap, arg1: &0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool_config::SpoolConfig, arg2: &mut 0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool::Spool, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool_config::assert_version(arg1);
        let v0 = TakeRewardsEvent{
            spool_id      : 0x2::object::id<0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool::Spool>(arg2),
            reward_type   : 0x1::type_name::get<T0>(),
            taken_rewards : arg3,
        };
        0x2::event::emit<TakeRewardsEvent>(v0);
        0x2::coin::from_balance<T0>(0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool::take_reward<T0>(arg2, arg3), arg4)
    }

    public entry fun update_reward_fee_config(arg0: &AdminCap, arg1: &0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool_config::SpoolConfig, arg2: &mut 0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool::Spool, arg3: u64, arg4: u64, arg5: address) {
        0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool_config::assert_version(arg1);
        0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool::update_reward_fee(arg2, arg3, arg4, arg5);
        let v0 = UpdateRewardFeeEvent{
            spool_id             : 0x2::object::id<0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool::Spool>(arg2),
            fee_rate_numerator   : arg3,
            fee_rate_denominator : arg4,
            fee_recipient        : arg5,
        };
        0x2::event::emit<UpdateRewardFeeEvent>(v0);
    }

    public entry fun update_spool_params(arg0: &AdminCap, arg1: &0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool_config::SpoolConfig, arg2: &mut 0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool::Spool, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) {
        0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool_config::assert_version(arg1);
        assert!(arg3 <= arg4, 2);
        0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool::accrue_points(arg2, arg5);
        0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool::update_spool_params(arg2, arg3, arg4);
        let v0 = UpdateSpoolParamsEvent{
            spool_id   : 0x2::object::id<0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool::Spool>(arg2),
            max_stakes : arg4,
            updated_at : 0x2::clock::timestamp_ms(arg5) / 1000,
        };
        0x2::event::emit<UpdateSpoolParamsEvent>(v0);
    }

    public entry fun upgrade_version(arg0: &AdminCap, arg1: &mut 0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool_config::SpoolConfig, arg2: &0x2::clock::Clock) {
        let v0 = 0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool_config::version(arg1) + 1;
        0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool_config::upgrade_version(arg1, v0);
        let v1 = UpdateConfigEvent{
            prev_version : 0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool_config::version(arg1),
            version      : v0,
            prev_enabled : 0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool_config::enabled(arg1),
            enabled      : 0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool_config::enabled(arg1),
            updated_at   : 0x2::clock::timestamp_ms(arg2) / 1000,
        };
        0x2::event::emit<UpdateConfigEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

