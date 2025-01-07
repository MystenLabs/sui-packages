module 0x5cd33a33f85f562c2246796321e8afb0d9812fcbe9af9e5547dbc995c8c2a7e2::pool {
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

    struct Pool<phantom T0> has key {
        id: 0x2::object::UID,
        pool_type: vector<u8>,
        stake_info: StakeInfo,
        time_info: TimeInfo,
        reward_allocate: RewardAllocate,
    }

    struct RewardAllocate has store {
        allocate_user_amount: u64,
        platform_ratio: u64,
        reward_ratio: u64,
        allocate_gas_payer_ratio: u64,
    }

    struct StakedValidatorKey has copy, drop, store {
        dummy_field: bool,
    }

    struct AssetKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct CetusPoolKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct ScallopPoolKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct BucketPoolKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct NaviPoolKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct KriyaPoolKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct TypusPoolKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct ValidatorPoolKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct UpdatePoolListRequire {
        dummy_field: bool,
    }

    struct PoolToSharedObject {
        dummy_field: bool,
    }

    struct UpdateStakeInfoRequire {
        dummy_field: bool,
    }

    struct UpdateValidatorInfoRequire {
        dummy_field: bool,
    }

    fun allocate_reward<T0>(arg0: &GlobalConfig, arg1: &mut Pool<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg2, 0x2::coin::value<T0>(&arg2) * arg1.reward_allocate.platform_ratio / 10000, arg5), arg0.platform);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg2, 0x2::coin::value<T0>(&arg2) * arg1.reward_allocate.allocate_gas_payer_ratio / 10000, arg5), 0x2::tx_context::sender(arg5));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, *0x1::vector::borrow<address>(&arg1.stake_info.user_list, get_reward_winner(arg3, arg4, 0x1::vector::length<address>(&arg1.stake_info.user_list))));
    }

    public entry fun allocate_validation_reward(arg0: &GlobalConfig, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut Pool<0x2::sui::SUI>, arg3: u64, arg4: vector<u8>, arg5: address, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.time_info.start_time + arg2.time_info.reward_duration <= 0x2::clock::timestamp_ms(arg6), 5);
        let v0 = AssetKey<0x3::staking_pool::StakedSui>{dummy_field: false};
        let v1 = 0x5cd33a33f85f562c2246796321e8afb0d9812fcbe9af9e5547dbc995c8c2a7e2::stake_to_validator::withdraw(arg1, 0x2::dynamic_object_field::remove<AssetKey<0x3::staking_pool::StakedSui>, 0x3::staking_pool::StakedSui>(&mut arg2.id, v0), arg7);
        let v2 = AssetKey<0x2::coin::Coin<0x2::sui::SUI>>{dummy_field: false};
        0x2::coin::join<0x2::sui::SUI>(&mut v1, 0x2::dynamic_object_field::remove<AssetKey<0x2::coin::Coin<0x2::sui::SUI>>, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2.id, v2));
        let v3 = 0x2::coin::split<0x2::sui::SUI>(&mut v1, arg2.stake_info.total_amount, arg7);
        restake_to_valdaitor(arg1, arg2, v3, arg5, arg7);
        allocate_reward<0x2::sui::SUI>(arg0, arg2, v1, arg3, arg4, arg7);
    }

    public fun create_pool<T0>(arg0: 0x1::string::String, arg1: &0x2::clock::Clock, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : (Pool<T0>, UpdatePoolListRequire, PoolToSharedObject) {
        assert!(arg4 + arg5 + arg6 == 10000, 8);
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
            allocate_user_amount     : 5,
            platform_ratio           : arg4,
            reward_ratio             : arg5,
            allocate_gas_payer_ratio : arg6,
        };
        let v3 = Pool<T0>{
            id              : 0x2::object::new(arg7),
            pool_type       : *0x1::string::bytes(&arg0),
            stake_info      : v0,
            time_info       : v1,
            reward_allocate : v2,
        };
        let v4 = UpdatePoolListRequire{dummy_field: false};
        let v5 = PoolToSharedObject{dummy_field: false};
        (v3, v4, v5)
    }

    public entry fun deposit_in_validator(arg0: &GlobalConfig, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut Pool<0x2::sui::SUI>, arg3: address, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 0);
        let v0 = b"to_validator";
        assert!(&arg2.pool_type == &v0, 1);
        let v1 = 0x2::tx_context::sender(arg5);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg4);
        let (v3, v4) = stake_to_validator_and_update_balance(arg1, arg2, arg3, arg4, arg5);
        update_staked_info<0x2::sui::SUI>(arg2, v1, v2, v3);
        update_validator_info(arg2, arg3, v2, v4, arg5);
    }

    fun get_reward_winner(arg0: u64, arg1: vector<u8>, arg2: u64) : u64 {
        0x5cd33a33f85f562c2246796321e8afb0d9812fcbe9af9e5547dbc995c8c2a7e2::drand_lib::verify_drand_signature(arg1, arg0);
        let v0 = 0x5cd33a33f85f562c2246796321e8afb0d9812fcbe9af9e5547dbc995c8c2a7e2::drand_lib::derive_randomness(arg1);
        0x5cd33a33f85f562c2246796321e8afb0d9812fcbe9af9e5547dbc995c8c2a7e2::drand_lib::safe_selection(arg2, &v0)
    }

    public fun id<T0>(arg0: &Pool<T0>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
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
        let (v0, v1, v2) = create_pool<T0>(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        let v3 = v0;
        let v4 = &mut v3;
        update_pool_list<T0>(v4, arg2, arg3, v1);
        pool_to_shared_obejct<T0>(v3, v2);
    }

    public fun pool_staked<T0>(arg0: &Pool<T0>) : u64 {
        arg0.stake_info.total_amount
    }

    public fun pool_to_shared_obejct<T0>(arg0: Pool<T0>, arg1: PoolToSharedObject) {
        let PoolToSharedObject {  } = arg1;
        0x2::transfer::share_object<Pool<T0>>(arg0);
    }

    fun restake_to_valdaitor(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut Pool<0x2::sui::SUI>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = AssetKey<0x3::staking_pool::StakedSui>{dummy_field: false};
        0x2::dynamic_object_field::add<AssetKey<0x3::staking_pool::StakedSui>, 0x3::staking_pool::StakedSui>(&mut arg1.id, v0, 0x5cd33a33f85f562c2246796321e8afb0d9812fcbe9af9e5547dbc995c8c2a7e2::stake_to_validator::stake(arg0, arg2, arg3, arg4));
    }

    fun stake_to_validator_and_update_balance(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut Pool<0x2::sui::SUI>, arg2: address, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) : (UpdateStakeInfoRequire, UpdateValidatorInfoRequire) {
        let v0 = AssetKey<0x3::staking_pool::StakedSui>{dummy_field: false};
        if (0x2::dynamic_object_field::exists_<AssetKey<0x3::staking_pool::StakedSui>>(&arg1.id, v0)) {
            let v1 = AssetKey<0x3::staking_pool::StakedSui>{dummy_field: false};
            0x3::staking_pool::join_staked_sui(0x2::dynamic_object_field::borrow_mut<AssetKey<0x3::staking_pool::StakedSui>, 0x3::staking_pool::StakedSui>(&mut arg1.id, v1), 0x5cd33a33f85f562c2246796321e8afb0d9812fcbe9af9e5547dbc995c8c2a7e2::stake_to_validator::stake(arg0, arg3, arg2, arg4));
        } else {
            let v2 = AssetKey<0x3::staking_pool::StakedSui>{dummy_field: false};
            0x2::dynamic_object_field::add<AssetKey<0x3::staking_pool::StakedSui>, 0x3::staking_pool::StakedSui>(&mut arg1.id, v2, 0x5cd33a33f85f562c2246796321e8afb0d9812fcbe9af9e5547dbc995c8c2a7e2::stake_to_validator::stake(arg0, arg3, arg2, arg4));
        };
        let v3 = UpdateStakeInfoRequire{dummy_field: false};
        let v4 = UpdateValidatorInfoRequire{dummy_field: false};
        (v3, v4)
    }

    public entry fun update_global_config(arg0: &mut GlobalConfig, arg1: &AdminCap, arg2: u64, arg3: address) {
        arg0.version = arg2;
        arg0.platform = arg3;
    }

    public fun update_pool_list<T0>(arg0: &mut Pool<T0>, arg1: &mut PoolList, arg2: 0x1::string::String, arg3: UpdatePoolListRequire) {
        let UpdatePoolListRequire {  } = arg3;
        if (*0x1::string::bytes(&arg2) == b"to_validator") {
            let v0 = ValidatorPoolKey<T0>{dummy_field: false};
            if (0x2::dynamic_field::exists_<ValidatorPoolKey<T0>>(&arg1.id, v0)) {
                abort 7
            };
            let v1 = ValidatorPoolKey<T0>{dummy_field: false};
            0x2::dynamic_field::add<ValidatorPoolKey<T0>, 0x2::object::ID>(&mut arg1.id, v1, 0x2::object::uid_to_inner(&arg0.id));
        } else if (*0x1::string::bytes(&arg2) == b"to_cetus") {
            let v2 = CetusPoolKey<T0>{dummy_field: false};
            if (0x2::dynamic_field::exists_<CetusPoolKey<T0>>(&arg1.id, v2)) {
                abort 7
            };
            let v3 = CetusPoolKey<T0>{dummy_field: false};
            0x2::dynamic_field::add<CetusPoolKey<T0>, 0x2::object::ID>(&mut arg1.id, v3, 0x2::object::uid_to_inner(&arg0.id));
        } else if (*0x1::string::bytes(&arg2) == b"to_navi") {
            let v4 = NaviPoolKey<T0>{dummy_field: false};
            if (0x2::dynamic_field::exists_<NaviPoolKey<T0>>(&arg1.id, v4)) {
                abort 7
            };
            let v5 = NaviPoolKey<T0>{dummy_field: false};
            0x2::dynamic_field::add<NaviPoolKey<T0>, 0x2::object::ID>(&mut arg1.id, v5, 0x2::object::uid_to_inner(&arg0.id));
        } else if (*0x1::string::bytes(&arg2) == b"to_scallop") {
            let v6 = ScallopPoolKey<T0>{dummy_field: false};
            if (0x2::dynamic_field::exists_<ScallopPoolKey<T0>>(&arg1.id, v6)) {
                abort 7
            };
            let v7 = ScallopPoolKey<T0>{dummy_field: false};
            0x2::dynamic_field::add<ScallopPoolKey<T0>, 0x2::object::ID>(&mut arg1.id, v7, 0x2::object::uid_to_inner(&arg0.id));
        } else if (*0x1::string::bytes(&arg2) == b"to_bucket") {
            let v8 = BucketPoolKey<T0>{dummy_field: false};
            if (0x2::dynamic_field::exists_<BucketPoolKey<T0>>(&arg1.id, v8)) {
                abort 7
            };
            let v9 = BucketPoolKey<T0>{dummy_field: false};
            0x2::dynamic_field::add<BucketPoolKey<T0>, 0x2::object::ID>(&mut arg1.id, v9, 0x2::object::uid_to_inner(&arg0.id));
        } else if (*0x1::string::bytes(&arg2) == b"to_kriya") {
            let v10 = KriyaPoolKey<T0>{dummy_field: false};
            if (0x2::dynamic_field::exists_<KriyaPoolKey<T0>>(&arg1.id, v10)) {
                abort 7
            };
            let v11 = KriyaPoolKey<T0>{dummy_field: false};
            0x2::dynamic_field::add<KriyaPoolKey<T0>, 0x2::object::ID>(&mut arg1.id, v11, 0x2::object::uid_to_inner(&arg0.id));
        } else {
            assert!(*0x1::string::bytes(&arg2) == b"to_typus", 6);
            let v12 = TypusPoolKey<T0>{dummy_field: false};
            if (0x2::dynamic_field::exists_<TypusPoolKey<T0>>(&arg1.id, v12)) {
                abort 7
            };
            let v13 = TypusPoolKey<T0>{dummy_field: false};
            0x2::dynamic_field::add<TypusPoolKey<T0>, 0x2::object::ID>(&mut arg1.id, v13, 0x2::object::uid_to_inner(&arg0.id));
        };
        0x1::vector::push_back<0x2::object::ID>(&mut arg1.pool_ids, 0x2::object::uid_to_inner(&arg0.id));
    }

    public fun update_stake_info_after_withdraw_from_validator(arg0: &mut Pool<0x2::sui::SUI>, arg1: address, arg2: u64, arg3: UpdateStakeInfoRequire) {
        let UpdateStakeInfoRequire {  } = arg3;
        let v0 = 0x2::table::remove<address, u64>(&mut arg0.stake_info.user_record, arg1) - arg2;
        if (v0 > 0) {
            0x2::table::add<address, u64>(&mut arg0.stake_info.user_record, arg1, v0);
        } else {
            0x1::vector::swap_remove<address>(&mut arg0.stake_info.user_list, *0x2::table::borrow<address, u64>(&arg0.stake_info.user_index, arg1));
            0x2::table::remove<address, u64>(&mut arg0.stake_info.user_index, arg1);
        };
        arg0.stake_info.total_amount = arg0.stake_info.total_amount - arg2;
    }

    fun update_staked_info<T0>(arg0: &mut Pool<T0>, arg1: address, arg2: u64, arg3: UpdateStakeInfoRequire) {
        let UpdateStakeInfoRequire {  } = arg3;
        arg0.stake_info.total_amount = arg0.stake_info.total_amount + arg2;
        if (0x2::table::contains<address, u64>(&arg0.stake_info.user_record, arg1)) {
            0x2::table::add<address, u64>(&mut arg0.stake_info.user_record, arg1, 0x2::table::remove<address, u64>(&mut arg0.stake_info.user_record, arg1) + arg2);
        } else {
            0x2::table::add<address, u64>(&mut arg0.stake_info.user_record, arg1, arg2);
            0x2::table::add<address, u64>(&mut arg0.stake_info.user_index, arg1, 0x1::vector::length<address>(&arg0.stake_info.user_list));
            0x1::vector::push_back<address>(&mut arg0.stake_info.user_list, arg1);
        };
    }

    fun update_validator_info(arg0: &mut Pool<0x2::sui::SUI>, arg1: address, arg2: u64, arg3: UpdateValidatorInfoRequire, arg4: &mut 0x2::tx_context::TxContext) {
        let UpdateValidatorInfoRequire {  } = arg3;
        let v0 = StakedValidatorKey{dummy_field: false};
        if (0x2::dynamic_object_field::exists_<StakedValidatorKey>(&arg0.id, v0)) {
            let v1 = StakedValidatorKey{dummy_field: false};
            let v2 = 0x2::dynamic_object_field::borrow_mut<StakedValidatorKey, 0x2::table::Table<address, u64>>(&mut arg0.id, v1);
            if (0x2::table::contains<address, u64>(v2, arg1)) {
                0x2::table::add<address, u64>(v2, arg1, 0x2::table::remove<address, u64>(v2, arg1) + arg2);
            } else {
                0x2::table::add<address, u64>(v2, arg1, arg2);
            };
        } else {
            let v3 = 0x2::table::new<address, u64>(arg4);
            0x2::table::add<address, u64>(&mut v3, arg1, arg2);
            let v4 = StakedValidatorKey{dummy_field: false};
            0x2::dynamic_object_field::add<StakedValidatorKey, 0x2::table::Table<address, u64>>(&mut arg0.id, v4, v3);
        };
    }

    public fun user_staked_value<T0>(arg0: &Pool<T0>, arg1: address) : u64 {
        *0x2::table::borrow<address, u64>(&arg0.stake_info.user_record, arg1)
    }

    public entry fun withdraw_from_validator(arg0: &GlobalConfig, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut Pool<0x2::sui::SUI>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(arg0.version == 1, 0);
        assert!(0x2::table::contains<address, u64>(&arg2.stake_info.user_record, v0), 4);
        assert!(arg3 <= *0x2::table::borrow<address, u64>(&arg2.stake_info.user_record, v0), 2);
        let v1 = AssetKey<0x3::staking_pool::StakedSui>{dummy_field: false};
        assert!(0x2::dynamic_object_field::exists_<AssetKey<0x3::staking_pool::StakedSui>>(&arg2.id, v1), 3);
        let (v2, v3) = withdraw_staked_coin_from_validator(arg1, arg2, b"to_validator", arg3, arg5);
        let v4 = v2;
        update_stake_info_after_withdraw_from_validator(arg2, v0, arg3, v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v4, arg3, arg5), v0);
        let v5 = AssetKey<0x2::coin::Coin<0x2::sui::SUI>>{dummy_field: false};
        if (0x2::dynamic_object_field::exists_<AssetKey<0x2::coin::Coin<0x2::sui::SUI>>>(&arg2.id, v5)) {
            let v6 = AssetKey<0x2::coin::Coin<0x2::sui::SUI>>{dummy_field: false};
            0x2::coin::join<0x2::sui::SUI>(0x2::dynamic_object_field::borrow_mut<AssetKey<0x2::coin::Coin<0x2::sui::SUI>>, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2.id, v6), v4);
        } else {
            let v7 = AssetKey<0x2::coin::Coin<0x2::sui::SUI>>{dummy_field: false};
            0x2::dynamic_object_field::add<AssetKey<0x2::coin::Coin<0x2::sui::SUI>>, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2.id, v7, v4);
        };
    }

    public fun withdraw_staked_coin_from_validator(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut Pool<0x2::sui::SUI>, arg2: vector<u8>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, UpdateStakeInfoRequire) {
        let v0 = AssetKey<0x3::staking_pool::StakedSui>{dummy_field: false};
        let v1 = UpdateStakeInfoRequire{dummy_field: false};
        (0x5cd33a33f85f562c2246796321e8afb0d9812fcbe9af9e5547dbc995c8c2a7e2::stake_to_validator::withdraw(arg0, 0x3::staking_pool::split(0x2::dynamic_object_field::borrow_mut<AssetKey<0x3::staking_pool::StakedSui>, 0x3::staking_pool::StakedSui>(&mut arg1.id, v0), arg3, arg4), arg4), v1)
    }

    // decompiled from Move bytecode v6
}

