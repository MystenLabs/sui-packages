module 0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::lend {
    struct DepositEvent has copy, drop {
        pool_id: 0x2::object::ID,
        depositor: address,
        amount: u64,
        asset: u8,
    }

    struct WithdrawEvent has copy, drop {
        pool_id: 0x2::object::ID,
        withdrawer: address,
        amount: u64,
        asset: u8,
    }

    struct GiftSweptEvent has copy, drop {
        strategy_id: 0x2::object::ID,
        asset_type: 0x1::type_name::TypeName,
        amount: u64,
        market_id: 0x2::object::ID,
    }

    public fun report_unreadable<T0>(arg0: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Strategy<T0>, arg1: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::AdapterInfo, arg2: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::object::ID> {
        let v0 = account_key(arg1);
        if (0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::has_position_record<T0>(arg0, v0)) {
            0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::assert_bound_venue(0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::position_venue<T0>(arg0, v0), 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage>(arg2));
        };
        assert!(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::pause(arg2), 805);
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::report_unreadable<T0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, 0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::account::NaviWitness>(0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::account::witness(), 0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::version::current_version(), arg0, arg1, v0, 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::reason_market_paused(), arg3, arg4)
    }

    fun account_collateral(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: address) : 0x2::vec_map::VecMap<u8, u256> {
        let (v0, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_assets(arg0, arg1);
        let v2 = v0;
        let v3 = &v2;
        let v4 = vector[];
        let v5 = 0;
        while (v5 < 0x1::vector::length<u8>(v3)) {
            let (v6, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg0, *0x1::vector::borrow<u8>(v3, v5), arg1);
            0x1::vector::push_back<u256>(&mut v4, v6);
            v5 = v5 + 1;
        };
        0x2::vec_map::from_keys_values<u8, u256>(v2, v4)
    }

    fun account_key(arg0: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::AdapterInfo) : 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::PositionKey {
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::position_key_account(0x2::object::id<0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::AdapterInfo>(arg0), 0x1::type_name::with_defining_ids<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>())
    }

    public fun accrue_interest(arg0: &0x2::clock::Clock, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage) {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::update_state_of_all(arg0, arg1);
    }

    public fun admin_finalize_pocket<T0>(arg0: &0x6ed01ddca67b1efc5bcd68fc12d7d4131a129e95455d8ed80275cb530e570620::nami_master_strategy_config::MasterStrategyCap, arg1: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Strategy<T0>, arg2: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Pocket<T0>, arg3: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::AdapterInfo, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &0x2::clock::Clock) {
        let (v0, v1, v2) = closing_reading<T0>(arg2, arg4);
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::admin_finalize_unwind_account<T0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, 0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::account::NaviWitness>(arg0, 0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::account::witness(), 0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::version::current_version(), arg1, arg2, arg3, 0x2::object::id_from_address(v0), v1, v2, arg5);
    }

    fun assert_pool<T0>(arg0: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg2: u8) {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::verify_market_storage_pool<T0>(arg0, arg1);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_coin_type(arg0, arg2) == *0x1::type_name::as_string(&v0), 803);
    }

    fun assets_held_in(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: address, arg2: &vector<0x1::type_name::TypeName>, arg3: &mut 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>) {
        let v0 = 0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::account::supplies_held(arg0, arg1);
        let v1 = &v0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(v1)) {
            let v3 = 0;
            while (v3 < 0x1::vector::length<0x1::type_name::TypeName>(arg2)) {
                let v4 = 0x1::vector::borrow<0x1::type_name::TypeName>(arg2, v3);
                if (*0x1::type_name::as_string(v4) == 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_coin_type(arg0, *0x1::vector::borrow<u8>(v1, v2))) {
                    0x2::vec_map::insert<0x1::type_name::TypeName, u64>(arg3, *v4, 1);
                };
                v3 = v3 + 1;
            };
            v2 = v2 + 1;
        };
    }

    public fun clear_pause_sighting<T0>(arg0: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Strategy<T0>, arg1: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::AdapterInfo, arg2: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage) {
        let v0 = account_key(arg1);
        if (0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::has_position_record<T0>(arg0, v0)) {
            0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::assert_bound_venue(0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::position_venue<T0>(arg0, v0), 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage>(arg2));
        };
        assert!(!0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::pause(arg2), 807);
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::clear_unreadable_sighting<T0, 0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::account::NaviWitness>(0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::account::witness(), 0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::version::current_version(), arg0, arg1, v0);
    }

    public fun close_leg<T0>(arg0: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Pocket<T0>, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::UnwindLeg<0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::account::NaviWitness, u8, u256>, arg4: &0x2::clock::Clock) {
        let v0 = 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::unwind_leg_keys<T0, 0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::account::NaviWitness, u8, u256>(&arg3, 0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::version::current_version(), arg0);
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::assert_bound_venue(0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::pocket_venue<T0>(arg0), 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage>(arg2));
        let v1 = 0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::account::pocket_owner<T0>(arg0);
        let v2 = prices_for(arg4, arg1, arg2, &v0);
        let v3 = held_assets(arg2, v1);
        let v4 = account_collateral(arg2, v1);
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::close_unwind_leg<T0, 0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::account::NaviWitness, u8, u256>(0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::account::witness(), 0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::version::current_version(), arg0, arg3, v2, v3, v4, 0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::account::health_bps(arg4, arg1, arg2, v1));
    }

    fun closing_reading<T0>(arg0: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Pocket<T0>, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage) : (address, 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>, 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>) {
        let v0 = 0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::account::pocket_owner<T0>(arg0);
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::assert_bound_venue(0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::pocket_venue<T0>(arg0), 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage>(arg1));
        let v1 = 0x2::vec_set::keys<0x1::type_name::TypeName>(0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::pocket_pending_liabilities<T0>(arg0));
        let v2 = 0x2::vec_map::empty<0x1::type_name::TypeName, u64>();
        let v3 = &mut v2;
        assets_held_in(arg1, v0, 0x2::vec_set::keys<0x1::type_name::TypeName>(0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::pocket_pending_unwind<T0>(arg0)), v3);
        let v4 = 0x2::vec_map::empty<0x1::type_name::TypeName, u64>();
        let v5 = 0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::account::loans_owed(arg1, v0);
        let v6 = &v5;
        let v7 = 0;
        while (v7 < 0x1::vector::length<u8>(v6)) {
            let v8 = 0;
            while (v8 < 0x1::vector::length<0x1::type_name::TypeName>(v1)) {
                let v9 = 0x1::vector::borrow<0x1::type_name::TypeName>(v1, v8);
                if (*0x1::type_name::as_string(v9) == 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_coin_type(arg1, *0x1::vector::borrow<u8>(v6, v7))) {
                    0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v4, *v9, 1);
                };
                v8 = v8 + 1;
            };
            v7 = v7 + 1;
        };
        (v0, v2, v4)
    }

    fun counted_assets(arg0: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: address, arg2: &vector<0x1::type_name::TypeName>) : vector<u8> {
        let (v0, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_assets(arg0, arg1);
        let v2 = v1;
        let v3 = v0;
        let v4 = b"";
        let v5 = &v3;
        let v6 = 0;
        while (v6 < 0x1::vector::length<u8>(v5)) {
            let v7 = 0x1::vector::borrow<u8>(v5, v6);
            let v8 = 0;
            let v9;
            while (v8 < 0x1::vector::length<0x1::type_name::TypeName>(arg2)) {
                if (*0x1::type_name::as_string(0x1::vector::borrow<0x1::type_name::TypeName>(arg2, v8)) == 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_coin_type(arg0, *v7)) {
                    v9 = true;
                    /* label 7 */
                    if (v9) {
                        let v10 = &mut v4;
                        insert_sorted(v10, *v7);
                    };
                    v6 = v6 + 1;
                    /* goto 1 */
                    continue
                };
                v8 = v8 + 1;
            };
            v9 = false;
            /* goto 7 */
        };
        let v11 = &v2;
        let v12 = 0;
        while (v12 < 0x1::vector::length<u8>(v11)) {
            let v13 = &mut v4;
            insert_sorted(v13, *0x1::vector::borrow<u8>(v11, v12));
            v12 = v12 + 1;
        };
        v4
    }

    public fun deposit<T0, T1>(arg0: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::ManagerCap, arg1: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Strategy<T0>, arg2: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::AdapterInfo, arg3: &0xe596d8ae7010a101545d84cdead3c7c4bcb475c3bd614fc13e456adff21fafe::nami_whitelist::WhitelistRegistry, arg4: &0x6ed01ddca67b1efc5bcd68fc12d7d4131a129e95455d8ed80275cb530e570620::nami_master_strategy_config::MasterStrategyConfig, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg7: u8, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg10 > 0, 800);
        let v0 = 0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::account::open_move<T0>(arg0, arg1, arg4, arg2, arg3, 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::move_enter(), 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::role_flag_lend());
        let v1 = 0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::account::lend_cap<T0>(arg1, &mut v0);
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::deposit_with_account_cap<T1>(arg11, arg5, arg6, arg7, 0x2::coin::from_balance<T1>(0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::take<T0, T1, 0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::account::NaviWitness>(0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::account::witness(), arg1, &mut v0, arg10), arg12), arg8, arg9, &v1);
        let v2 = DepositEvent{
            pool_id   : 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>>(arg6),
            depositor : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&v1),
            amount    : arg10,
            asset     : arg7,
        };
        0x2::event::emit<DepositEvent>(v2);
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::return_account<T0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, 0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::account::NaviWitness>(0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::account::witness(), arg1, &mut v0, v1);
        0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::account::settle<T0>(arg1, arg3, v0, arg5);
    }

    public fun finalize_pocket<T0>(arg0: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Strategy<T0>, arg1: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Pocket<T0>, arg2: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::AdapterInfo, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &0x2::clock::Clock) {
        let (v0, v1, v2) = closing_reading<T0>(arg1, arg3);
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::finalize_unwind_account<T0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, 0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::account::NaviWitness>(0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::account::witness(), 0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::version::current_version(), arg0, arg1, arg2, 0x2::object::id_from_address(v0), v1, v2, arg4);
    }

    fun fingerprint(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: address, arg2: &vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u256>();
        0x1::vector::push_back<u256>(&mut v0, (0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::version::current_version() as u256));
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(arg2)) {
            let v2 = 0x1::vector::borrow<u8>(arg2, v1);
            0x1::vector::push_back<u256>(&mut v0, (*v2 as u256));
            0x1::vector::push_back<u256>(&mut v0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_balance(arg0, *v2, arg1));
            0x1::vector::push_back<u256>(&mut v0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_loan_balance(arg0, *v2, arg1));
            v1 = v1 + 1;
        };
        let v3 = 0x2::bcs::to_bytes<vector<u256>>(&v0);
        0x2::hash::blake2b256(&v3)
    }

    fun from_normalized<T0>(arg0: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg1: u256, arg2: bool) : u64 {
        let v0 = 18446744073709551615;
        let v1 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::get_coin_decimal<T0>(arg0);
        let v2 = if (v1 >= 9) {
            arg1
        } else if (arg2) {
            0x1::u256::div_ceil(arg1, pow10(9 - v1))
        } else {
            arg1 / pow10(9 - v1)
        };
        let v3 = v2;
        let v4 = 0x1::u8::max(v1, 9) - 9;
        while (v4 > 0 && v3 <= v0) {
            v3 = v3 * 10;
            v4 = v4 - 1;
        };
        assert!(v3 <= v0, 801);
        (v3 as u64)
    }

    fun held_assets(arg0: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: address) : vector<u8> {
        let (v0, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_assets(arg0, arg1);
        let v2 = v1;
        let v3 = v0;
        let v4 = b"";
        let v5 = &v3;
        let v6 = 0;
        while (v6 < 0x1::vector::length<u8>(v5)) {
            let v7 = &mut v4;
            insert_sorted(v7, *0x1::vector::borrow<u8>(v5, v6));
            v6 = v6 + 1;
        };
        let v8 = &v2;
        let v9 = 0;
        while (v9 < 0x1::vector::length<u8>(v8)) {
            let v10 = &mut v4;
            insert_sorted(v10, *0x1::vector::borrow<u8>(v8, v9));
            v9 = v9 + 1;
        };
        v4
    }

    fun insert_sorted(arg0: &mut vector<u8>, arg1: u8) {
        if (0x1::vector::contains<u8>(arg0, &arg1)) {
            return
        };
        let v0 = 0x1::vector::length<u8>(arg0);
        0x1::vector::push_back<u8>(arg0, arg1);
        while (v0 > 0 && *0x1::vector::borrow<u8>(arg0, v0 - 1) > arg1) {
            0x1::vector::swap<u8>(arg0, v0 - 1, v0);
            v0 = v0 - 1;
        };
    }

    fun pocket_parts<T0>(arg0: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Pocket<T0>, arg1: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: address) : vector<u8> {
        counted_assets(arg1, arg2, 0x2::vec_set::keys<0x1::type_name::TypeName>(0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::pocket_pending_unwind<T0>(arg0)))
    }

    fun pow10(arg0: u8) : u256 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        v0
    }

    fun prices_for(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &vector<u8>) : vector<u256> {
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(arg3)) {
            let (_, v3, _) = 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::get_token_price(arg0, arg1, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_oracle_id(arg2, *0x1::vector::borrow<u8>(arg3, v1)));
            0x1::vector::push_back<u256>(&mut v0, v3);
            v1 = v1 + 1;
        };
        v0
    }

    fun read_account_asset<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg3: address, arg4: u8, arg5: &vector<u8>) : (0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>, 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>, u8) {
        accrue_interest(arg0, arg1);
        assert_pool<T0>(arg1, arg2, arg4);
        let (v0, v1) = 0x1::vector::index_of<u8>(arg5, &arg4);
        assert!(v0 || 0x1::vector::is_empty<u8>(arg5), 802);
        let v2 = 0x2::vec_map::empty<0x1::type_name::TypeName, u64>();
        let v3 = 0x2::vec_map::empty<0x1::type_name::TypeName, u64>();
        if (!v0) {
            return (v2, v3, 0)
        };
        let v4 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_balance(arg1, arg4, arg3);
        let v5 = to_nav_amount_up<T0>(arg2, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_loan_balance(arg1, arg4, arg3));
        let v6 = 0x1::type_name::with_defining_ids<T0>();
        if (v4 > 0) {
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v2, v6, 0x1::u64::max(to_nav_amount<T0>(arg2, v4), 1));
        };
        if (v5 > 0) {
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v3, v6, v5);
        };
        (v2, v3, (v1 as u8))
    }

    public fun reattach_pocket<T0, T1>(arg0: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Strategy<T0>, arg1: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Pocket<T0>, arg2: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::AdapterInfo, arg3: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg6: u8, arg7: 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::QuoteBook, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::account::pocket_owner<T0>(arg1);
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::assert_bound_venue(0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::pocket_venue<T0>(arg1), 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage>(arg4));
        let v1 = pocket_parts<T0>(arg1, arg4, v0);
        let (v2, v3, v4) = read_account_asset<T1>(arg8, arg4, arg5, v0, arg6, &v1);
        assert!(0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::account::health_bps(arg8, arg3, arg4, v0) >= 10000, 809);
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::reattach_pocket_account<T0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, 0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::account::NaviWitness>(0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::account::witness(), 0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::version::current_version(), arg0, arg1, arg2, 0x2::object::id_from_address(v0), v2, v3, v4, (0x1::u64::max(0x1::vector::length<u8>(&v1), 1) as u8), fingerprint(arg4, v0, &v1), arg7, arg8, arg9);
    }

    public fun refresh_account<T0, T1>(arg0: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Strategy<T0>, arg1: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::AdapterInfo, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg4: u8, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::account::vault_owner<T0>(arg0, arg1);
        let v1 = account_key(arg1);
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::assert_bound_venue(0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::position_venue<T0>(arg0, v1), 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage>(arg2));
        let v2 = 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::counted_account_assets<T0>(arg0, v1);
        let v3 = counted_assets(arg2, v0, &v2);
        let (v4, v5, v6) = read_account_asset<T1>(arg5, arg2, arg3, v0, arg4, &v3);
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::report_account_value<T0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, 0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::account::NaviWitness>(0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::account::witness(), 0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::version::current_version(), arg0, arg1, 0x2::object::id_from_address(v0), v4, v5, v6, (0x1::u64::max(0x1::vector::length<u8>(&v3), 1) as u8), fingerprint(arg2, v0, &v3), arg5, arg6);
    }

    public fun refresh_pocket<T0, T1>(arg0: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Pocket<T0>, arg1: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::AdapterInfo, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg4: u8, arg5: &0x2::clock::Clock) {
        let v0 = 0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::account::pocket_owner<T0>(arg0);
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::assert_bound_venue(0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::pocket_venue<T0>(arg0), 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage>(arg2));
        let v1 = pocket_parts<T0>(arg0, arg2, v0);
        let (v2, v3, v4) = read_account_asset<T1>(arg5, arg2, arg3, v0, arg4, &v1);
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::report_pocket_account_value<T0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, 0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::account::NaviWitness>(0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::account::witness(), 0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::version::current_version(), arg0, arg1, 0x2::object::id_from_address(v0), v2, v3, v4, (0x1::u64::max(0x1::vector::length<u8>(&v1), 1) as u8), fingerprint(arg2, v0, &v1), arg5);
    }

    public fun repay_pocket<T0, T1>(arg0: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Pocket<T0>, arg1: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::AdapterInfo, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg5: u8, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::borrow_pocket_object<T0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, 0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::account::NaviWitness>(0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::account::witness(), 0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::version::current_version(), arg0, arg1, arg9);
        let v2 = v0;
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::assert_bound_venue(0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::pocket_venue<T0>(arg0), 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage>(arg3));
        assert_pool<T1>(arg3, arg4, arg5);
        let v3 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&v2);
        if (!0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::account::owes(arg3, v3, arg5)) {
            0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::account::emit_repay_event(0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>>(arg4), v3, 0, arg5);
            0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::return_pocket_object_debt_cleared<T0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, T1, 0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::account::NaviWitness>(0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::account::witness(), 0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::version::current_version(), arg0, arg1, v2, v1);
            return
        };
        assert!(arg8 > 0, 800);
        accrue_interest(arg9, arg3);
        assert!(0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::account::health_bps(arg9, arg2, arg3, v3) >= 10000, 808);
        let (v4, v5) = 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::take_escrow_for_repay<T0, T1, 0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::account::NaviWitness>(0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::account::witness(), 0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::version::current_version(), arg0, arg1, arg8);
        let v6 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::repay_with_account_cap<T1>(arg9, arg2, arg3, arg4, arg5, 0x2::coin::from_balance<T1>(v4, arg10), arg6, arg7, &v2);
        let v7 = arg8 - 0x2::balance::value<T1>(&v6);
        0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::account::emit_repay_event(0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>>(arg4), v3, v7, arg5);
        let v8 = if (0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::account::owes(arg3, v3, arg5)) {
            to_nav_amount_up<T1>(arg4, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_loan_balance(arg3, arg5, v3))
        } else {
            0
        };
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::return_pocket_object_after_repay<T0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, T1, 0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::account::NaviWitness>(0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::account::witness(), 0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::version::current_version(), arg0, arg1, v2, v1, v5, v7, v8, v6);
    }

    public fun sweep_gift<T0, T1>(arg0: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::ManagerCap, arg1: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Strategy<T0>, arg2: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::AdapterInfo, arg3: &0xe596d8ae7010a101545d84cdead3c7c4bcb475c3bd614fc13e456adff21fafe::nami_whitelist::WhitelistRegistry, arg4: &0x6ed01ddca67b1efc5bcd68fc12d7d4131a129e95455d8ed80275cb530e570620::nami_master_strategy_config::MasterStrategyConfig, arg5: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg8: u8, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        assert!(!0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::is_asset_allowed<T0>(arg1, v0), 806);
        let v1 = 0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::account::open_move<T0>(arg0, arg1, arg4, arg2, arg3, 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::move_exit(), 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::role_flag_lend());
        let v2 = 0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::account::lend_cap<T0>(arg1, &mut v1);
        assert!(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_balance(arg6, arg8, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&v2)) > 0, 800);
        let v3 = withdraw_from<T1>(arg12, arg5, arg6, arg7, arg8, arg9, arg10, &v2, arg11, 18446744073709551615, arg13);
        0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::account::assert_health_floor<T0>(arg1, arg2, arg12, arg5, arg6, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&v2), arg4);
        let v4 = GiftSweptEvent{
            strategy_id : 0x2::object::id<0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Strategy<T0>>(arg1),
            asset_type  : v0,
            amount      : 0x2::balance::value<T1>(&v3),
            market_id   : 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage>(arg6),
        };
        0x2::event::emit<GiftSweptEvent>(v4);
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::return_account<T0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, 0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::account::NaviWitness>(0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::account::witness(), arg1, &mut v1, v2);
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::put_gift<T0, T1, 0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::account::NaviWitness>(0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::account::witness(), arg1, arg4, &mut v1, v3, arg13);
        0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::account::settle<T0>(arg1, arg3, v1, arg6);
    }

    public fun to_nav_amount<T0>(arg0: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg1: u256) : u64 {
        from_normalized<T0>(arg0, arg1, false)
    }

    public fun to_nav_amount_up<T0>(arg0: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg1: u256) : u64 {
        from_normalized<T0>(arg0, arg1, true)
    }

    public fun user_assets(arg0: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap) : (vector<u8>, vector<u8>) {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_assets(arg0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(arg1))
    }

    public fun user_loan_balance(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, arg2: u8) : u256 {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_loan_balance(arg0, arg2, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(arg1))
    }

    public fun user_supply_balance(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, arg2: u8) : u256 {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_balance(arg0, arg2, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(arg1))
    }

    public fun withdraw<T0, T1>(arg0: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::ManagerCap, arg1: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Strategy<T0>, arg2: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::AdapterInfo, arg3: &0xe596d8ae7010a101545d84cdead3c7c4bcb475c3bd614fc13e456adff21fafe::nami_whitelist::WhitelistRegistry, arg4: &0x6ed01ddca67b1efc5bcd68fc12d7d4131a129e95455d8ed80275cb530e570620::nami_master_strategy_config::MasterStrategyConfig, arg5: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg8: u8, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(arg12 > 0, 800);
        let v0 = 0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::account::open_move<T0>(arg0, arg1, arg4, arg2, arg3, 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::move_exit(), 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::role_flag_lend());
        let v1 = 0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::account::lend_cap<T0>(arg1, &mut v0);
        let v2 = withdraw_from<T1>(arg13, arg5, arg6, arg7, arg8, arg9, arg10, &v1, arg11, arg12, arg14);
        0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::account::assert_health_floor<T0>(arg1, arg2, arg13, arg5, arg6, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&v1), arg4);
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::return_account<T0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, 0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::account::NaviWitness>(0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::account::witness(), arg1, &mut v0, v1);
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::put<T0, T1, 0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::account::NaviWitness>(0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::account::witness(), arg1, &mut v0, v2);
        0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::account::settle<T0>(arg1, arg3, v0, arg6);
    }

    fun withdraw_from<T0>(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: u8, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg7: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, arg8: &mut 0x3::sui_system::SuiSystemState, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(arg7);
        let v1 = if (arg9 == 18446744073709551615) {
            accrue_interest(arg0, arg2);
            0x1::u64::max(to_nav_amount<T0>(arg3, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_balance(arg2, arg4, v0)), 1)
        } else {
            arg9
        };
        let v2 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::withdraw_with_account_cap_v2<T0>(arg0, arg1, arg2, arg3, arg4, v1, arg5, arg6, arg7, arg8, arg10);
        let v3 = WithdrawEvent{
            pool_id    : 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>>(arg3),
            withdrawer : v0,
            amount     : 0x2::balance::value<T0>(&v2),
            asset      : arg4,
        };
        0x2::event::emit<WithdrawEvent>(v3);
        v2
    }

    public fun withdraw_pocket<T0, T1>(arg0: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Pocket<T0>, arg1: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::AdapterInfo, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg5: u8, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg8: &mut 0x3::sui_system::SuiSystemState, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::UnwindLeg<0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::account::NaviWitness, u8, u256> {
        assert!(arg9 > 0, 800);
        let (v0, v1) = 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::borrow_pocket_object<T0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, 0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::account::NaviWitness>(0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::account::witness(), 0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::version::current_version(), arg0, arg1, arg10);
        let v2 = v0;
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::assert_bound_venue(0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::pocket_venue<T0>(arg0), 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage>(arg3));
        assert_pool<T1>(arg3, arg4, arg5);
        let v3 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&v2);
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::update_state_of_all(arg10, arg3);
        let v4 = 0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::account::health_bps(arg10, arg2, arg3, v3);
        let v5 = held_assets(arg3, v3);
        let v6 = 0x2::vec_map::from_keys_values<u8, u256>(v5, prices_for(arg10, arg2, arg3, &v5));
        let v7 = withdraw_from<T1>(arg10, arg2, arg3, arg4, arg5, arg6, arg7, &v2, arg8, arg9, arg11);
        let v8 = 0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::account::supplies_held(arg3, v3);
        let v9 = if (0x1::vector::contains<u8>(&v8, &arg5)) {
            to_nav_amount<T1>(arg4, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_balance(arg3, arg5, v3))
        } else {
            0
        };
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::return_pocket_object_after_withdraw<T0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, T1, 0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::account::NaviWitness, u8, u256>(0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::account::witness(), 0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::version::current_version(), arg0, arg1, v2, v1, v9, v7, v4, v6, account_collateral(arg3, v3))
    }

    // decompiled from Move bytecode v7
}

