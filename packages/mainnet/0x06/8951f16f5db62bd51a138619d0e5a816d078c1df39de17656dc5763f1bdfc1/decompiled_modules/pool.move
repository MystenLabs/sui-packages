module 0x68951f16f5db62bd51a138619d0e5a816d078c1df39de17656dc5763f1bdfc1::pool {
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
        pool_list: vector<0x2::object::ID>,
    }

    struct TimeInfo has store {
        start_time: u64,
        reward_duration: u64,
    }

    struct RewardAllocate has store {
        allocate_user_amount: u64,
        platform_ratio: u64,
        reward_ratio: u64,
        allocate_gas_payer_ratio: u64,
    }

    struct Pool<phantom T0, phantom T1: store + key> has key {
        id: 0x2::object::UID,
        current_round: u64,
        time_info: TimeInfo,
        reward_allocate: RewardAllocate,
        rewards: 0x2::bag::Bag,
        claimable: 0x2::table::Table<u64, T1>,
        claimed: 0x2::table::Table<u64, address>,
        number_pool: 0x1::option::Option<0x2::object::ID>,
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

    public fun allocate_gas_payer_ratio<T0, T1: store + key>(arg0: &Pool<T0, T1>) : u64 {
        arg0.reward_allocate.allocate_gas_payer_ratio
    }

    public(friend) fun borrow_mut_claimed<T0, T1: store + key>(arg0: &mut Pool<T0, T1>) : &mut 0x2::table::Table<u64, address> {
        &mut arg0.claimed
    }

    public(friend) fun borrow_mut_rewards<T0, T1: store + key>(arg0: &mut Pool<T0, T1>) : &mut 0x2::bag::Bag {
        &mut arg0.rewards
    }

    public(friend) fun borrow_mut_rewards_of_specific_asset<T0, T1: store + key, T2, T3: store + key>(arg0: &mut Pool<T0, T1>) : &mut T3 {
        0x2::bag::borrow_mut<0x1::type_name::TypeName, T3>(&mut arg0.rewards, 0x1::type_name::get<T2>())
    }

    public fun check_arrived_reward_time<T0, T1: store + key>(arg0: &Pool<T0, T1>, arg1: &0x2::clock::Clock) {
        assert!(arg0.time_info.start_time + arg0.time_info.reward_duration <= 0x2::clock::timestamp_ms(arg1), 3);
    }

    fun check_duplicated<T0, T1>(arg0: &GlobalConfig) {
        if (0x2::dynamic_object_field::exists_<0x1::type_name::TypeName>(&arg0.id, 0x1::type_name::get<T0>())) {
            if (0x2::table::contains<0x1::type_name::TypeName, 0x2::object::ID>(0x2::dynamic_object_field::borrow<0x1::type_name::TypeName, 0x2::table::Table<0x1::type_name::TypeName, 0x2::object::ID>>(&arg0.id, 0x1::type_name::get<T0>()), 0x1::type_name::get<T1>())) {
                abort 4
            };
        };
    }

    public(friend) fun check_is_claimed<T0, T1: store + key>(arg0: &Pool<T0, T1>, arg1: u64) {
        assert!(!0x2::table::contains<u64, address>(&arg0.claimed, arg1), 6);
    }

    public fun check_round<T0, T1: store + key>(arg0: &Pool<T0, T1>, arg1: u64) {
        assert!(arg0.current_round < arg1, 7);
    }

    public(friend) fun check_round_reward_exist<T0, T1: store + key>(arg0: &Pool<T0, T1>, arg1: u64) {
        assert!(0x2::table::contains<u64, T1>(&arg0.claimable, arg1), 5);
    }

    public(friend) fun contains_asset<T0, T1: store + key, T2: store + key>(arg0: &Pool<T0, T1>) : bool {
        0x2::bag::contains<0x1::type_name::TypeName>(&arg0.rewards, 0x1::type_name::get<T2>())
    }

    public fun create_pool<T0: copy + drop + store, T1: store + key>(arg0: &0x2::clock::Clock, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : Pool<T0, T1> {
        assert!(arg3 + arg4 + arg5 == 10000, 1);
        let v0 = TimeInfo{
            start_time      : 0x2::clock::timestamp_ms(arg0) + arg1,
            reward_duration : arg2,
        };
        let v1 = RewardAllocate{
            allocate_user_amount     : 1,
            platform_ratio           : arg3,
            reward_ratio             : arg4,
            allocate_gas_payer_ratio : arg5,
        };
        Pool<T0, T1>{
            id              : 0x2::object::new(arg6),
            current_round   : 0,
            time_info       : v0,
            reward_allocate : v1,
            rewards         : 0x2::bag::new(arg6),
            claimable       : 0x2::table::new<u64, T1>(arg6),
            claimed         : 0x2::table::new<u64, address>(arg6),
            number_pool     : 0x1::option::none<0x2::object::ID>(),
        }
    }

    public fun current_round<T0, T1: store + key>(arg0: &Pool<T0, T1>) : u64 {
        arg0.current_round
    }

    public(friend) fun extract_rewards_of_specific_asset<T0, T1: store + key, T2: store + key>(arg0: &mut Pool<T0, T1>) : T2 {
        0x2::bag::remove<0x1::type_name::TypeName, T2>(&mut arg0.rewards, 0x1::type_name::get<T2>())
    }

    public(friend) fun extract_round_claimable_reward<T0, T1: store + key>(arg0: &mut Pool<T0, T1>, arg1: u64) : T1 {
        0x2::table::remove<u64, T1>(&mut arg0.claimable, arg1)
    }

    public(friend) fun fill_number_pool<T0, T1: store + key>(arg0: &mut Pool<T0, T1>, arg1: 0x2::object::ID) {
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.number_pool), 8);
        0x1::option::fill<0x2::object::ID>(&mut arg0.number_pool, arg1);
    }

    public fun include_pool_list_check<T0, T1: store + key>(arg0: &GlobalConfig, arg1: &Pool<T0, T1>) {
        let v0 = 0x2::object::uid_to_inner(&arg1.id);
        assert!(0x1::vector::contains<0x2::object::ID>(&arg0.pool_list, &v0), 2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = GlobalConfig{
            id        : 0x2::object::new(arg0),
            version   : 1,
            platform  : 0x2::tx_context::sender(arg0),
            pool_list : 0x1::vector::empty<0x2::object::ID>(),
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<GlobalConfig>(v1);
    }

    public entry fun new_pool<T0: copy + drop + store, T1: store + key>(arg0: &mut GlobalConfig, arg1: &AdminCap, arg2: &0x2::clock::Clock, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 0);
        check_duplicated<T0, T1>(arg0);
        let v0 = create_pool<T0, T1>(arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.pool_list, 0x2::object::uid_to_inner(&v0.id));
        if (0x2::dynamic_object_field::exists_<0x1::type_name::TypeName>(&arg0.id, 0x1::type_name::get<T0>())) {
            0x2::table::add<0x1::type_name::TypeName, 0x2::object::ID>(0x2::dynamic_object_field::borrow_mut<0x1::type_name::TypeName, 0x2::table::Table<0x1::type_name::TypeName, 0x2::object::ID>>(&mut arg0.id, 0x1::type_name::get<T0>()), 0x1::type_name::get<T1>(), 0x2::object::uid_to_inner(&v0.id));
        } else {
            let v1 = 0x2::table::new<0x1::type_name::TypeName, 0x2::object::ID>(arg8);
            0x2::table::add<0x1::type_name::TypeName, 0x2::object::ID>(&mut v1, 0x1::type_name::get<T1>(), 0x2::object::uid_to_inner(&v0.id));
            0x2::dynamic_object_field::add<0x1::type_name::TypeName, 0x2::table::Table<0x1::type_name::TypeName, 0x2::object::ID>>(&mut v0.id, 0x1::type_name::get<T0>(), v1);
        };
        0x2::transfer::share_object<Pool<T0, T1>>(v0);
    }

    public(friend) fun next_round<T0, T1: store + key>(arg0: &mut Pool<T0, T1>) {
        arg0.current_round = arg0.current_round + 1;
    }

    public fun platform_address(arg0: &GlobalConfig) : address {
        arg0.platform
    }

    public fun platform_ratio<T0, T1: store + key>(arg0: &Pool<T0, T1>) : u64 {
        arg0.reward_allocate.platform_ratio
    }

    public(friend) fun put_current_round_reward_to_claimable<T0, T1: store + key>(arg0: &mut Pool<T0, T1>, arg1: T1) {
        0x2::table::add<u64, T1>(&mut arg0.claimable, arg0.current_round, arg1);
    }

    public fun reward_ratio<T0, T1: store + key>(arg0: &Pool<T0, T1>) : u64 {
        arg0.reward_allocate.reward_ratio
    }

    public(friend) fun uid<T0, T1: store + key>(arg0: &mut Pool<T0, T1>) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    // decompiled from Move bytecode v6
}

