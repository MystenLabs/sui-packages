module 0xec8387f0baa325148ff3bbc7059552fabb21e5f24633e9228107b75ac887c8ce::pool {
    struct VALIDATOR has copy, drop, store {
        dummy_field: bool,
    }

    struct BUCKET_PROTOCOL has copy, drop, store {
        dummy_field: bool,
    }

    struct SCALLOP_PROTOCOL has copy, drop, store {
        dummy_field: bool,
    }

    struct GlobalConfig has key {
        id: 0x2::object::UID,
        version: u64,
        platform: address,
    }

    struct TimeInfo has store {
        start_time: u64,
        lock_stake_duration: u64,
        reward_duration: u64,
        expire_duration: u64,
    }

    struct RewardAllocate has store {
        allocate_user_amount: u64,
        platform_ratio: u64,
        reward_ratio: u64,
        allocate_gas_payer_ratio: u64,
    }

    struct Statistics has store {
        user_set: 0x2::vec_set::VecSet<address>,
        user_amount_table: 0x2::table::Table<address, u64>,
        total_amount: u64,
    }

    struct Pool<phantom T0, phantom T1: store + key, phantom T2: store + key> has key {
        id: 0x2::object::UID,
        current_round: u64,
        time_info: TimeInfo,
        reward_allocate: RewardAllocate,
        rewards: 0x2::bag::Bag,
        claimable: 0x2::table::Table<u64, T2>,
        claimed: 0x2::table::Table<u64, address>,
        statistics: Statistics,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct StakedValidatorKey has copy, drop, store {
        dummy_field: bool,
    }

    struct RestakeReceipt {
        dummy_field: bool,
    }

    struct ClaimExpiredTime has copy, drop, store {
        dummy_field: bool,
    }

    public(friend) fun add_expired_data<T0, T1: store + key, T2: store + key>(arg0: &mut Pool<T0, T1, T2>) {
        let v0 = ClaimExpiredTime{dummy_field: false};
        let v1 = 0x2::dynamic_object_field::borrow_mut<ClaimExpiredTime, 0x2::table::Table<u64, u64>>(&mut arg0.id, v0);
        assert!(!0x2::table::contains<u64, u64>(v1, arg0.current_round), 13);
        0x2::table::add<u64, u64>(v1, arg0.current_round, arg0.time_info.start_time + arg0.time_info.expire_duration);
    }

    public fun allocate_gas_payer_ratio<T0, T1: store + key, T2: store + key>(arg0: &Pool<T0, T1, T2>) : u64 {
        arg0.reward_allocate.allocate_gas_payer_ratio
    }

    public(friend) fun borrow_mut_claimed<T0, T1: store + key, T2: store + key>(arg0: &mut Pool<T0, T1, T2>) : &mut 0x2::table::Table<u64, address> {
        &mut arg0.claimed
    }

    public(friend) fun borrow_mut_rewards<T0, T1: store + key, T2: store + key>(arg0: &mut Pool<T0, T1, T2>) : &mut 0x2::bag::Bag {
        &mut arg0.rewards
    }

    public(friend) fun borrow_mut_rewards_of_specific_asset<T0, T1: store + key, T2: store + key, T3, T4: store>(arg0: &mut Pool<T0, T1, T2>) : &mut T4 {
        0x2::bag::borrow_mut<0x1::type_name::TypeName, T4>(&mut arg0.rewards, 0x1::type_name::get<T3>())
    }

    public fun check_arrived_lock_time<T0, T1: store + key, T2: store + key>(arg0: &Pool<T0, T1, T2>, arg1: &0x2::clock::Clock) {
        assert!(arg0.time_info.start_time + arg0.time_info.lock_stake_duration <= 0x2::clock::timestamp_ms(arg1), 7);
    }

    public fun check_arrived_reward_time<T0, T1: store + key, T2: store + key>(arg0: &Pool<T0, T1, T2>, arg1: &0x2::clock::Clock) {
        assert!(arg0.time_info.start_time + arg0.time_info.reward_duration <= 0x2::clock::timestamp_ms(arg1), 2);
    }

    public(friend) fun check_claim_expired<T0, T1: store + key, T2: store + key>(arg0: &Pool<T0, T1, T2>, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = ClaimExpiredTime{dummy_field: false};
        assert!(*0x2::table::borrow<u64, u64>(0x2::dynamic_object_field::borrow<ClaimExpiredTime, 0x2::table::Table<u64, u64>>(&arg0.id, v0), arg1) <= 0x2::clock::timestamp_ms(arg2), 8);
    }

    fun check_duplicated<T0, T1, T2>(arg0: &GlobalConfig) {
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T1>()));
        0x1::string::append(&mut v0, 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T2>())));
        if (0x2::dynamic_object_field::exists_<0x1::type_name::TypeName>(&arg0.id, 0x1::type_name::get<T0>())) {
            if (0x2::table::contains<0x1::string::String, 0x2::object::ID>(0x2::dynamic_object_field::borrow<0x1::type_name::TypeName, 0x2::table::Table<0x1::string::String, 0x2::object::ID>>(&arg0.id, 0x1::type_name::get<T0>()), v0)) {
                abort 3
            };
        };
    }

    public(friend) fun check_is_claimed<T0, T1: store + key, T2: store + key>(arg0: &Pool<T0, T1, T2>, arg1: u64) {
        assert!(!0x2::table::contains<u64, address>(&arg0.claimed, arg1), 5);
    }

    public fun check_round_could_claim_reward<T0, T1: store + key, T2: store + key>(arg0: &Pool<T0, T1, T2>, arg1: u64) {
        assert!(arg0.current_round > arg1, 6);
    }

    public(friend) fun check_round_reward_exist<T0, T1: store + key, T2: store + key>(arg0: &Pool<T0, T1, T2>, arg1: u64) {
        assert!(0x2::table::contains<u64, T2>(&arg0.claimable, arg1), 4);
    }

    public(friend) fun contains_asset<T0, T1: store + key, T2: store + key, T3: store + key>(arg0: &Pool<T0, T1, T2>) : bool {
        0x2::bag::contains<0x1::type_name::TypeName>(&arg0.rewards, 0x1::type_name::get<T3>())
    }

    public fun create_pool<T0: copy + drop + store, T1: store + key, T2: store + key>(arg0: &0x2::clock::Clock, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : Pool<T0, T1, T2> {
        assert!(arg5 + arg6 + arg7 == 10000, 1);
        assert!(arg2 <= arg3, 10);
        let v0 = TimeInfo{
            start_time          : 0x2::clock::timestamp_ms(arg0) + arg1,
            lock_stake_duration : arg2,
            reward_duration     : arg3,
            expire_duration     : arg4,
        };
        let v1 = RewardAllocate{
            allocate_user_amount     : 1,
            platform_ratio           : arg5,
            reward_ratio             : arg6,
            allocate_gas_payer_ratio : arg7,
        };
        let v2 = Statistics{
            user_set          : 0x2::vec_set::empty<address>(),
            user_amount_table : 0x2::table::new<address, u64>(arg8),
            total_amount      : 0,
        };
        Pool<T0, T1, T2>{
            id              : 0x2::object::new(arg8),
            current_round   : 1,
            time_info       : v0,
            reward_allocate : v1,
            rewards         : 0x2::bag::new(arg8),
            claimable       : 0x2::table::new<u64, T2>(arg8),
            claimed         : 0x2::table::new<u64, address>(arg8),
            statistics      : v2,
        }
    }

    public fun current_round<T0, T1: store + key, T2: store + key>(arg0: &Pool<T0, T1, T2>) : u64 {
        arg0.current_round
    }

    public(friend) fun extract_previous_rewards<T0, T1: store + key, T2: store + key>(arg0: &mut Pool<T0, T1, T2>, arg1: u64) : 0x1::option::Option<T2> {
        assert!(arg1 < arg0.current_round, 9);
        if (0x2::table::contains<u64, T2>(&arg0.claimable, arg1)) {
            0x1::option::some<T2>(extract_round_claimable_reward<T0, T1, T2>(arg0, arg1))
        } else {
            0x1::option::none<T2>()
        }
    }

    public(friend) fun extract_rewards_of_specific_asset<T0, T1: store + key, T2: store + key, T3: store + key>(arg0: &mut Pool<T0, T1, T2>) : T3 {
        0x2::bag::remove<0x1::type_name::TypeName, T3>(&mut arg0.rewards, 0x1::type_name::get<T3>())
    }

    public(friend) fun extract_round_claimable_reward<T0, T1: store + key, T2: store + key>(arg0: &mut Pool<T0, T1, T2>, arg1: u64) : T2 {
        0x2::table::remove<u64, T2>(&mut arg0.claimable, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = GlobalConfig{
            id       : 0x2::object::new(arg0),
            version  : 1,
            platform : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<GlobalConfig>(v1);
    }

    public(friend) fun is_claimed<T0, T1: store + key, T2: store + key>(arg0: &Pool<T0, T1, T2>, arg1: u64) : bool {
        0x2::table::contains<u64, address>(&arg0.claimed, arg1)
    }

    public entry fun new_pool<T0: copy + drop + store, T1: store + key, T2: store + key>(arg0: &mut GlobalConfig, arg1: &AdminCap, arg2: &0x2::clock::Clock, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 0);
        check_duplicated<T0, T1, T2>(arg0);
        let v0 = create_pool<T0, T1, T2>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        if (0x2::dynamic_object_field::exists_<0x1::type_name::TypeName>(&arg0.id, 0x1::type_name::get<T0>())) {
            0x2::table::add<0x1::type_name::TypeName, 0x2::object::ID>(0x2::dynamic_object_field::borrow_mut<0x1::type_name::TypeName, 0x2::table::Table<0x1::type_name::TypeName, 0x2::object::ID>>(&mut arg0.id, 0x1::type_name::get<T0>()), 0x1::type_name::get<T1>(), 0x2::object::uid_to_inner(&v0.id));
        } else {
            let v1 = 0x2::table::new<0x1::type_name::TypeName, 0x2::object::ID>(arg10);
            0x2::table::add<0x1::type_name::TypeName, 0x2::object::ID>(&mut v1, 0x1::type_name::get<T1>(), 0x2::object::uid_to_inner(&v0.id));
            0x2::dynamic_object_field::add<0x1::type_name::TypeName, 0x2::table::Table<0x1::type_name::TypeName, 0x2::object::ID>>(&mut v0.id, 0x1::type_name::get<T0>(), v1);
        };
        record_pool<T0, T1, T2>(arg0, 0x2::object::uid_to_inner(&v0.id), arg10);
        let v2 = 0x2::table::new<u64, u64>(arg10);
        0x2::table::add<u64, u64>(&mut v2, v0.current_round, v0.time_info.start_time + arg6);
        let v3 = ClaimExpiredTime{dummy_field: false};
        0x2::dynamic_object_field::add<ClaimExpiredTime, 0x2::table::Table<u64, u64>>(&mut v0.id, v3, v2);
        0x2::transfer::share_object<Pool<T0, T1, T2>>(v0);
    }

    public(friend) fun next_round<T0, T1: store + key, T2: store + key>(arg0: &mut Pool<T0, T1, T2>) {
        arg0.current_round = arg0.current_round + 1;
    }

    public fun platform_address(arg0: &GlobalConfig) : address {
        arg0.platform
    }

    public fun platform_ratio<T0, T1: store + key, T2: store + key>(arg0: &Pool<T0, T1, T2>) : u64 {
        arg0.reward_allocate.platform_ratio
    }

    public(friend) fun put_current_round_reward_to_claimable<T0, T1: store + key, T2: store + key>(arg0: &mut Pool<T0, T1, T2>, arg1: T2) {
        0x2::table::add<u64, T2>(&mut arg0.claimable, arg0.current_round, arg1);
    }

    fun record_pool<T0, T1, T2>(arg0: &mut GlobalConfig, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T1>()));
        0x1::string::append(&mut v0, 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T2>())));
        if (0x2::dynamic_object_field::exists_<0x1::type_name::TypeName>(&arg0.id, 0x1::type_name::get<T0>())) {
            0x2::table::add<0x1::string::String, 0x2::object::ID>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::table::Table<0x1::string::String, 0x2::object::ID>>(&mut arg0.id, 0x1::type_name::get<T0>()), v0, arg1);
        } else {
            let v1 = 0x2::table::new<0x1::string::String, 0x2::object::ID>(arg2);
            0x2::table::add<0x1::string::String, 0x2::object::ID>(&mut v1, v0, arg1);
            0x2::dynamic_object_field::add<0x1::type_name::TypeName, 0x2::table::Table<0x1::string::String, 0x2::object::ID>>(&mut arg0.id, 0x1::type_name::get<T0>(), v1);
        };
    }

    public fun reward_ratio<T0, T1: store + key, T2: store + key>(arg0: &Pool<T0, T1, T2>) : u64 {
        arg0.reward_allocate.reward_ratio
    }

    public(friend) fun uid<T0, T1: store + key, T2: store + key>(arg0: &mut Pool<T0, T1, T2>) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public(friend) fun update_statistic_for_stake<T0, T1: store + key, T2: store + key>(arg0: &mut Pool<T0, T1, T2>, arg1: address, arg2: u64) {
        arg0.statistics.total_amount = arg0.statistics.total_amount + arg2;
        if (!0x2::vec_set::contains<address>(&arg0.statistics.user_set, &arg1)) {
            0x2::vec_set::insert<address>(&mut arg0.statistics.user_set, arg1);
            0x2::table::add<address, u64>(&mut arg0.statistics.user_amount_table, arg1, arg2);
        } else {
            0x2::table::add<address, u64>(&mut arg0.statistics.user_amount_table, arg1, 0x2::table::remove<address, u64>(&mut arg0.statistics.user_amount_table, arg1) + arg2);
        };
    }

    public(friend) fun update_statistic_for_withdraw<T0, T1: store + key, T2: store + key>(arg0: &mut Pool<T0, T1, T2>, arg1: address, arg2: u64) {
        assert!(0x2::table::contains<address, u64>(&arg0.statistics.user_amount_table, arg1), 11);
        let v0 = 0x2::table::remove<address, u64>(&mut arg0.statistics.user_amount_table, arg1);
        assert!(v0 >= arg2, 12);
        arg0.statistics.total_amount = arg0.statistics.total_amount - arg2;
        let v1 = v0 - arg2;
        if (v1 == 0) {
            0x2::vec_set::remove<address>(&mut arg0.statistics.user_set, &arg1);
        } else {
            0x2::table::add<address, u64>(&mut arg0.statistics.user_amount_table, arg1, v1);
        };
    }

    public(friend) fun update_time<T0, T1: store + key, T2: store + key>(arg0: &mut Pool<T0, T1, T2>, arg1: &0x2::clock::Clock) {
        arg0.time_info.start_time = 0x2::clock::timestamp_ms(arg1);
    }

    // decompiled from Move bytecode v6
}

