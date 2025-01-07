module 0xeda6b4d807ddb0fd80e063fb4bc87e40ffaab39ad6f763a893f182f7a9ce4944::pool {
    struct GlobalConfig has key {
        id: 0x2::object::UID,
        version: u64,
        platform: address,
    }

    struct PoolList has key {
        id: 0x2::object::UID,
        pool_ids: vector<0x2::object::ID>,
    }

    struct TimeInfo has store {
        start_time: u64,
        reward_duration: u64,
    }

    struct StakeInfo has store {
        user_record: 0x2::table::Table<address, u64>,
        user_list: vector<address>,
        user_index: 0x2::table::Table<address, u64>,
        total_amount: u64,
    }

    struct RewardAllocate has store {
        allocate_user_amount: u64,
        platform_ratio: u64,
        reward_ratio: u64,
        allocate_gas_payer_ratio: u64,
    }

    struct Pool<phantom T0> has key {
        id: 0x2::object::UID,
        pool_type: vector<u8>,
        current_round: u64,
        stake_info: StakeInfo,
        time_info: TimeInfo,
        reward_allocate: RewardAllocate,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct StakedValidatorKey has copy, drop, store {
        dummy_field: bool,
    }

    public fun allocate_gas_payer_ratio<T0>(arg0: &Pool<T0>) : u64 {
        arg0.reward_allocate.allocate_gas_payer_ratio
    }

    public(friend) fun borrow_mut_pool_asset<T0, T1: store + key>(arg0: &mut Pool<T0>) : &mut T1 {
        0x2::dynamic_object_field::borrow_mut<0x1::type_name::TypeName, T1>(&mut arg0.id, 0x1::type_name::get<T1>())
    }

    public fun check_arrived_reward_time(arg0: &Pool<0x2::sui::SUI>, arg1: &0x2::clock::Clock) {
        assert!(arg0.time_info.start_time + arg0.time_info.reward_duration <= 0x2::clock::timestamp_ms(arg1), 10);
    }

    public fun check_pool_type<T0>(arg0: &Pool<T0>, arg1: vector<u8>) : bool {
        arg0.pool_type == arg1
    }

    public fun check_reward_time(arg0: &Pool<0x2::sui::SUI>, arg1: &0x2::clock::Clock) {
        assert!(arg0.time_info.start_time + arg0.time_info.reward_duration <= 0x2::clock::timestamp_ms(arg1), 10);
    }

    public fun check_staked_amount<T0>(arg0: &mut Pool<T0>, arg1: address, arg2: u64) {
        assert!(*0x2::table::borrow<address, u64>(&arg0.stake_info.user_record, arg1) >= arg2, 9);
    }

    public fun check_user_in_pool<T0>(arg0: &Pool<T0>, arg1: address) {
        assert!(0x2::table::contains<address, u64>(&arg0.stake_info.user_record, arg1), 8);
    }

    public fun create_pool<T0>(arg0: 0x1::string::String, arg1: &0x2::clock::Clock, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : Pool<T0> {
        assert!(arg4 + arg5 + arg6 == 10000, 1);
        let v0 = StakeInfo{
            user_record  : 0x2::table::new<address, u64>(arg7),
            user_list    : vector[],
            user_index   : 0x2::table::new<address, u64>(arg7),
            total_amount : 0,
        };
        let v1 = TimeInfo{
            start_time      : 0x2::clock::timestamp_ms(arg1) + arg2,
            reward_duration : arg3,
        };
        let v2 = RewardAllocate{
            allocate_user_amount     : 1,
            platform_ratio           : arg4,
            reward_ratio             : arg5,
            allocate_gas_payer_ratio : arg6,
        };
        Pool<T0>{
            id              : 0x2::object::new(arg7),
            pool_type       : *0x1::string::bytes(&arg0),
            current_round   : 0,
            stake_info      : v0,
            time_info       : v1,
            reward_allocate : v2,
        }
    }

    public fun current_round<T0>(arg0: &Pool<T0>) : u64 {
        arg0.current_round
    }

    fun exist_asset<T0, T1: store + key>(arg0: &Pool<T0>) {
        assert!(0x2::dynamic_object_field::exists_<0x1::type_name::TypeName>(&arg0.id, 0x1::type_name::get<T1>()), 11);
    }

    public(friend) fun id<T0>(arg0: &Pool<T0>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun include_pool_list_check<T0>(arg0: &Pool<T0>, arg1: &PoolList) {
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        assert!(0x1::vector::contains<0x2::object::ID>(&arg1.pool_ids, &v0), 4);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = PoolList{
            id       : 0x2::object::new(arg0),
            pool_ids : 0x1::vector::empty<0x2::object::ID>(),
        };
        let v2 = GlobalConfig{
            id       : 0x2::object::new(arg0),
            version  : 1,
            platform : @0x452f24341b3a45c422cf9c8ee488d606fab3585a6e536b2dc656f60036dae95,
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<PoolList>(v1);
        0x2::transfer::share_object<GlobalConfig>(v2);
    }

    public entry fun new_pool<T0>(arg0: &GlobalConfig, arg1: &AdminCap, arg2: &mut PoolList, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 0);
        let v0 = create_pool<T0>(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        0x1::vector::push_back<0x2::object::ID>(&mut arg2.pool_ids, 0x2::object::uid_to_inner(&v0.id));
        0x2::transfer::share_object<Pool<T0>>(v0);
    }

    public(friend) fun next_round<T0>(arg0: &mut Pool<T0>) {
        arg0.current_round = arg0.current_round + 1;
    }

    public fun platform_address(arg0: &GlobalConfig) : address {
        arg0.platform
    }

    public fun platform_ratio<T0>(arg0: &Pool<T0>) : u64 {
        arg0.reward_allocate.platform_ratio
    }

    public(friend) fun pool_asset<T0, T1: store + key>(arg0: &mut Pool<T0>) : T1 {
        exist_asset<T0, T1>(arg0);
        0x2::dynamic_object_field::remove<0x1::type_name::TypeName, T1>(&mut arg0.id, 0x1::type_name::get<T1>())
    }

    public fun reward_ratio<T0>(arg0: &Pool<T0>) : u64 {
        arg0.reward_allocate.reward_ratio
    }

    public fun staked_user_amount<T0>(arg0: &Pool<T0>) : u64 {
        0x1::vector::length<address>(&arg0.stake_info.user_list)
    }

    public fun total_amount<T0>(arg0: &Pool<T0>) : u64 {
        arg0.stake_info.total_amount
    }

    public(friend) fun uid<T0>(arg0: &mut Pool<T0>) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public(friend) fun update_stake_info<T0>(arg0: &mut Pool<T0>, arg1: address, arg2: u64, arg3: bool) {
        if (arg3) {
            arg0.stake_info.total_amount = arg0.stake_info.total_amount + arg2;
            if (0x2::table::contains<address, u64>(&arg0.stake_info.user_record, arg1)) {
                0x2::table::add<address, u64>(&mut arg0.stake_info.user_record, arg1, 0x2::table::remove<address, u64>(&mut arg0.stake_info.user_record, arg1) + arg2);
            } else {
                0x2::table::add<address, u64>(&mut arg0.stake_info.user_record, arg1, arg2);
                0x2::table::add<address, u64>(&mut arg0.stake_info.user_index, arg1, 0x1::vector::length<address>(&arg0.stake_info.user_list));
                0x1::vector::push_back<address>(&mut arg0.stake_info.user_list, arg1);
            };
        } else {
            assert!(arg0.stake_info.total_amount >= arg2, 2);
            arg0.stake_info.total_amount = arg0.stake_info.total_amount - arg2;
            assert!(0x2::table::contains<address, u64>(&arg0.stake_info.user_record, arg1), 6);
            let v0 = 0x2::table::remove<address, u64>(&mut arg0.stake_info.user_record, arg1);
            assert!(v0 >= arg2, 5);
            0x2::table::add<address, u64>(&mut arg0.stake_info.user_record, arg1, v0 - arg2);
        };
    }

    public(friend) fun update_validator_table_data_on_pool(arg0: &mut Pool<0x2::sui::SUI>, arg1: address, arg2: u64, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        check_pool_type<0x2::sui::SUI>(arg0, b"to_validator");
        let v0 = StakedValidatorKey{dummy_field: false};
        if (0x2::dynamic_object_field::exists_<StakedValidatorKey>(&arg0.id, v0)) {
            let v1 = StakedValidatorKey{dummy_field: false};
            let v2 = 0x2::dynamic_object_field::borrow_mut<StakedValidatorKey, 0x2::table::Table<address, u64>>(&mut arg0.id, v1);
            if (arg3) {
                if (0x2::table::contains<address, u64>(v2, arg1)) {
                    0x2::table::add<address, u64>(v2, arg1, 0x2::table::remove<address, u64>(v2, arg1) + arg2);
                } else {
                    0x2::table::add<address, u64>(v2, arg1, arg2);
                };
            } else {
                assert!(0x2::table::contains<address, u64>(v2, arg1), 7);
                let v3 = 0x2::table::remove<address, u64>(v2, arg1);
                assert!(v3 >= arg2, 7);
                0x2::table::add<address, u64>(v2, arg1, v3 - arg2);
            };
        } else {
            assert!(arg3, 3);
            let v4 = 0x2::table::new<address, u64>(arg4);
            0x2::table::add<address, u64>(&mut v4, arg1, arg2);
            let v5 = StakedValidatorKey{dummy_field: false};
            0x2::dynamic_object_field::add<StakedValidatorKey, 0x2::table::Table<address, u64>>(&mut arg0.id, v5, v4);
        };
    }

    public fun user_by_idx<T0>(arg0: &Pool<T0>, arg1: u64) : address {
        *0x1::vector::borrow<address>(&arg0.stake_info.user_list, arg1)
    }

    // decompiled from Move bytecode v6
}

