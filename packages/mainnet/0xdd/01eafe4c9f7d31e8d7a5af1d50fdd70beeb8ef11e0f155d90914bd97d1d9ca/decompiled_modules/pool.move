module 0x6f57572d2ef8fcb9f71f4b399cfd6421f3e70f0016ca2e652c47c91be1bb9940::pool {
    struct AdminCap<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    struct Pool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        weight: u64,
        xTokenSupply: u64,
        tokensInvested: u64,
        alpha_rewards: 0x2::balance::Balance<0x6f57572d2ef8fcb9f71f4b399cfd6421f3e70f0016ca2e652c47c91be1bb9940::alpha::ALPHA>,
        acc_alpha_per_xtoken: u256,
        users: 0x2::vec_map::VecMap<address, Receipt<T0, T1>>,
        locked_period_in_days: u64,
        treasury: 0x2::coin::TreasuryCap<T1>,
    }

    struct Receipt<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        xTokenBalance: u64,
        total_scoin_from_borrow: u64,
        alpha_balance: 0x2::balance::Balance<0x6f57572d2ef8fcb9f71f4b399cfd6421f3e70f0016ca2e652c47c91be1bb9940::alpha::ALPHA>,
        last_acc_alpha_per_xtoken: u256,
        investedAmount: u64,
        locked_balance: 0x2::linked_table::LinkedTable<u64, u64>,
        balance: u256,
    }

    struct Display has drop, store {
        pool_id: 0x2::object::ID,
        xTokenBalance: u64,
        alpha_balance: u64,
        last_acc_alpha_per_xtoken: u256,
        investedAmount: u64,
        balance: u256,
    }

    fun assert_receipt<T0, T1>(arg0: &mut Receipt<T0, T1>, arg1: &mut Pool<T0, T1>) {
        assert!(arg0.pool_id == 0x2::object::uid_to_inner(&arg1.id), 0);
    }

    public fun create<T0, T1>(arg0: 0x2::coin::TreasuryCap<T1>, arg1: &mut 0x2::tx_context::TxContext) : AdminCap<T0> {
        let v0 = Pool<T0, T1>{
            id                    : 0x2::object::new(arg1),
            weight                : 0,
            xTokenSupply          : 0,
            tokensInvested        : 0,
            alpha_rewards         : 0x2::balance::zero<0x6f57572d2ef8fcb9f71f4b399cfd6421f3e70f0016ca2e652c47c91be1bb9940::alpha::ALPHA>(),
            acc_alpha_per_xtoken  : 0,
            users                 : 0x2::vec_map::empty<address, Receipt<T0, T1>>(),
            locked_period_in_days : 0,
            treasury              : arg0,
        };
        0x2::transfer::public_share_object<Pool<T0, T1>>(v0);
        AdminCap<T0>{id: 0x2::object::new(arg1)}
    }

    public fun deposit<T0, T1, T2>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x6f57572d2ef8fcb9f71f4b399cfd6421f3e70f0016ca2e652c47c91be1bb9940::investor::Investor<T2>, arg2: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::rewards_pool::RewardsPool<T0>, arg3: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg6: 0x2::balance::Balance<T0>, arg7: Receipt<T0, T1>, arg8: &0x2::clock::Clock, arg9: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg13: u8, arg14: u8, arg15: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg16: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg17: &mut 0x2::tx_context::TxContext) : Receipt<T0, T1> {
        let v0 = exchange_rate<T0, T1>(arg0);
        let v1 = &mut arg7;
        assert_receipt<T0, T1>(v1, arg0);
        let Receipt {
            id                        : v2,
            pool_id                   : v3,
            xTokenBalance             : v4,
            total_scoin_from_borrow   : v5,
            alpha_balance             : v6,
            last_acc_alpha_per_xtoken : v7,
            investedAmount            : v8,
            locked_balance            : v9,
            balance                   : _,
        } = arg7;
        let v11 = v9;
        0x2::linked_table::push_back<u64, u64>(&mut v11, 0x2::clock::timestamp_ms(arg8), 0x2::balance::value<T0>(&arg6));
        arg0.tokensInvested = arg0.tokensInvested + 0x2::balance::value<T0>(&arg6);
        let v12 = (0x2::balance::value<T0>(&arg6) as u256) * v0 / (1000000000 as u256);
        arg0.xTokenSupply = arg0.xTokenSupply + (v12 as u64);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::mint<T1>(&mut arg0.treasury, (v12 as u64), arg17), 0x2::tx_context::sender(arg17));
        let v13 = v4 + (v12 as u64);
        0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        0x2::object::delete(v2);
        Receipt<T0, T1>{
            id                        : 0x2::object::new(arg17),
            pool_id                   : v3,
            xTokenBalance             : v13,
            total_scoin_from_borrow   : v5 + 0x6f57572d2ef8fcb9f71f4b399cfd6421f3e70f0016ca2e652c47c91be1bb9940::investor::deposit_to_navi<T0, T2>(arg1, arg8, arg9, arg10, arg11, arg12, arg13, arg14, 0x2::coin::from_balance<T0>(arg6, arg17), arg15, arg16, arg3, arg4, arg5, arg17),
            alpha_balance             : v6,
            last_acc_alpha_per_xtoken : v7,
            investedAmount            : v8 + 0x2::balance::value<T0>(&arg6),
            locked_balance            : v11,
            balance                   : (v13 as u256) * (1000000000 as u256) / exchange_rate<T0, T1>(arg0),
        }
    }

    public fun deposit_new<T0, T1, T2>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x6f57572d2ef8fcb9f71f4b399cfd6421f3e70f0016ca2e652c47c91be1bb9940::investor::Investor<T2>, arg2: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::rewards_pool::RewardsPool<T0>, arg3: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg6: 0x2::balance::Balance<T0>, arg7: &0x2::clock::Clock, arg8: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg12: u8, arg13: u8, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg15: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg16: &mut 0x2::tx_context::TxContext) : Receipt<T0, T1> {
        let v0 = exchange_rate<T0, T1>(arg0);
        arg0.tokensInvested = arg0.tokensInvested + 0x2::balance::value<T0>(&arg6);
        let v1 = 0x2::coin::mint<T1>(&mut arg0.treasury, (((0x2::balance::value<T0>(&arg6) as u256) * v0 / (1000000000 as u256)) as u64), arg16);
        let v2 = 0x2::coin::value<T1>(&v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, 0x2::tx_context::sender(arg16));
        arg0.xTokenSupply = arg0.xTokenSupply + v2;
        let v3 = 0x2::balance::value<T0>(&arg6);
        let _ = exchange_rate<T0, T1>(arg0);
        let v5 = 0x2::linked_table::new<u64, u64>(arg16);
        0x2::linked_table::push_back<u64, u64>(&mut v5, 0x2::clock::timestamp_ms(arg7), v3);
        Receipt<T0, T1>{
            id                        : 0x2::object::new(arg16),
            pool_id                   : 0x2::object::uid_to_inner(&arg0.id),
            xTokenBalance             : v2,
            total_scoin_from_borrow   : 0x6f57572d2ef8fcb9f71f4b399cfd6421f3e70f0016ca2e652c47c91be1bb9940::investor::deposit_to_navi<T0, T2>(arg1, arg7, arg8, arg9, arg10, arg11, arg12, arg13, 0x2::coin::from_balance<T0>(arg6, arg16), arg14, arg15, arg3, arg4, arg5, arg16),
            alpha_balance             : 0x2::balance::zero<0x6f57572d2ef8fcb9f71f4b399cfd6421f3e70f0016ca2e652c47c91be1bb9940::alpha::ALPHA>(),
            last_acc_alpha_per_xtoken : arg0.acc_alpha_per_xtoken,
            investedAmount            : v3,
            locked_balance            : v5,
            balance                   : (v3 as u256),
        }
    }

    public fun destroy_receipt<T0, T1>(arg0: Receipt<T0, T1>) {
        let Receipt {
            id                        : v0,
            pool_id                   : _,
            xTokenBalance             : _,
            total_scoin_from_borrow   : _,
            alpha_balance             : v4,
            last_acc_alpha_per_xtoken : _,
            investedAmount            : _,
            locked_balance            : v7,
            balance                   : _,
        } = arg0;
        0x2::balance::destroy_zero<0x6f57572d2ef8fcb9f71f4b399cfd6421f3e70f0016ca2e652c47c91be1bb9940::alpha::ALPHA>(v4);
        0x2::linked_table::destroy_empty<u64, u64>(v7);
        0x2::object::delete(v0);
    }

    fun exchange_rate<T0, T1>(arg0: &mut Pool<T0, T1>) : u256 {
        if (arg0.tokensInvested == 0 || arg0.xTokenSupply == 0) {
            (1000000000 as u256)
        } else {
            (arg0.xTokenSupply as u256) * (1000000000 as u256) / (arg0.tokensInvested as u256)
        }
    }

    public fun unlock_locked_balance_for_user<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut Receipt<T0, T1>, arg2: &0x2::clock::Clock) {
        while (0x2::linked_table::length<u64, u64>(&arg1.locked_balance) > 0) {
            let (v0, v1) = 0x2::linked_table::pop_front<u64, u64>(&mut arg1.locked_balance);
            if ((0x2::clock::timestamp_ms(arg2) - v0) / 8640000 >= arg0.locked_period_in_days) {
                arg1.balance = arg1.balance + (v1 as u256);
            } else {
                0x2::linked_table::push_front<u64, u64>(&mut arg1.locked_balance, v0, v1);
                break
            };
        };
    }

    public fun update_pool<T0, T1, T2>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x6f57572d2ef8fcb9f71f4b399cfd6421f3e70f0016ca2e652c47c91be1bb9940::investor::Investor<T2>, arg2: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::rewards_pool::RewardsPool<T0>, arg3: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg4: &0x2::clock::Clock, arg5: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg7: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg11: u8, arg12: u8, arg13: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg15: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<T2>, arg16: u8, arg17: u8, arg18: &mut 0x2::tx_context::TxContext) {
        arg0.tokensInvested = arg0.tokensInvested + 0x6f57572d2ef8fcb9f71f4b399cfd6421f3e70f0016ca2e652c47c91be1bb9940::investor::collect_all_rewards_and_reinvest<T0, T2>(arg1, arg4, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg3, arg5, arg6, arg15, arg2, arg16, arg17, arg18);
    }

    public entry fun user_deposit<T0, T1, T2>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x6f57572d2ef8fcb9f71f4b399cfd6421f3e70f0016ca2e652c47c91be1bb9940::investor::Investor<T2>, arg2: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::rewards_pool::RewardsPool<T0>, arg3: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg6: 0x2::coin::Coin<T0>, arg7: &0x2::clock::Clock, arg8: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg12: u8, arg13: u8, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg15: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg16: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<T2>, arg17: u8, arg18: &mut 0x2::tx_context::TxContext) {
        update_pool<T0, T1, T2>(arg0, arg1, arg2, arg3, arg7, arg4, arg5, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg12, arg17, arg18);
        let v0 = 0x2::tx_context::sender(arg18);
        let v1 = if (0x2::vec_map::contains<address, Receipt<T0, T1>>(&arg0.users, &v0) == true) {
            let (_, v3) = 0x2::vec_map::remove<address, Receipt<T0, T1>>(&mut arg0.users, &v0);
            deposit<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<T0>(arg6), v3, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg18)
        } else {
            deposit_new<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<T0>(arg6), arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg18)
        };
        0x2::vec_map::insert<address, Receipt<T0, T1>>(&mut arg0.users, v0, v1);
    }

    public entry fun user_withdraw<T0, T1, T2>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x6f57572d2ef8fcb9f71f4b399cfd6421f3e70f0016ca2e652c47c91be1bb9940::investor::Investor<T2>, arg2: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::rewards_pool::RewardsPool<T0>, arg3: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg6: 0x2::coin::Coin<T1>, arg7: &0x2::clock::Clock, arg8: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg12: u8, arg13: u8, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg15: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg16: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<T2>, arg17: u8, arg18: &mut 0x2::tx_context::TxContext) {
        update_pool<T0, T1, T2>(arg0, arg1, arg2, arg3, arg7, arg4, arg5, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg12, arg17, arg18);
        let v0 = 0x2::tx_context::sender(arg18);
        assert!(0x2::vec_map::contains<address, Receipt<T0, T1>>(&arg0.users, &v0) == true, 2);
        let (_, v2) = 0x2::vec_map::remove<address, Receipt<T0, T1>>(&mut arg0.users, &v0);
        let v3 = withdraw<T0, T1, T2>(v2, arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg18);
        0x2::vec_map::insert<address, Receipt<T0, T1>>(&mut arg0.users, v0, v3);
    }

    public fun withdraw<T0, T1, T2>(arg0: Receipt<T0, T1>, arg1: &mut Pool<T0, T1>, arg2: &mut 0x6f57572d2ef8fcb9f71f4b399cfd6421f3e70f0016ca2e652c47c91be1bb9940::investor::Investor<T2>, arg3: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::rewards_pool::RewardsPool<T0>, arg4: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg5: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg7: 0x2::coin::Coin<T1>, arg8: &0x2::clock::Clock, arg9: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg13: u8, arg14: u8, arg15: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg16: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg17: &mut 0x2::tx_context::TxContext) : Receipt<T0, T1> {
        let v0 = exchange_rate<T0, T1>(arg1);
        let v1 = &mut arg0;
        assert_receipt<T0, T1>(v1, arg1);
        let v2 = (0x2::coin::value<T1>(&arg7) as u256) * (1000000000 as u256) / v0;
        let v3 = (v2 as u64);
        let v4 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        let v5 = 0x1::string::utf8(b"ALPHA");
        if (0x1::string::index_of(&v4, &v5) < 0x1::string::length(&v4)) {
            assert!(v2 <= arg0.balance, 1);
        } else {
            assert!(v3 <= (((arg0.xTokenBalance as u256) * (1000000000 as u256) / v0) as u64), 1);
        };
        let v6 = 0x2::coin::into_balance<T1>(arg7);
        arg1.xTokenSupply = arg1.xTokenSupply - 0x2::balance::value<T1>(&v6);
        let Receipt {
            id                        : v7,
            pool_id                   : v8,
            xTokenBalance             : v9,
            total_scoin_from_borrow   : v10,
            alpha_balance             : v11,
            last_acc_alpha_per_xtoken : v12,
            investedAmount            : v13,
            locked_balance            : v14,
            balance                   : _,
        } = arg0;
        let v16 = v9 - 0x2::balance::value<T1>(&v6);
        0x2::balance::decrease_supply<T1>(0x2::coin::supply_mut<T1>(&mut arg1.treasury), v6);
        let v17 = exchange_rate<T0, T1>(arg1);
        0x6f57572d2ef8fcb9f71f4b399cfd6421f3e70f0016ca2e652c47c91be1bb9940::investor::withdraw_from_navi<T0, T2>(arg2, arg8, arg9, arg10, arg11, arg12, arg13, arg14, v3, arg1.tokensInvested, arg15, arg16, arg4, arg5, arg6, arg17);
        0x2::object::delete(v7);
        Receipt<T0, T1>{
            id                        : 0x2::object::new(arg17),
            pool_id                   : v8,
            xTokenBalance             : v16,
            total_scoin_from_borrow   : v10,
            alpha_balance             : v11,
            last_acc_alpha_per_xtoken : v12,
            investedAmount            : v13,
            locked_balance            : v14,
            balance                   : (v16 as u256) * (1000000000 as u256) / v17,
        }
    }

    // decompiled from Move bytecode v6
}

