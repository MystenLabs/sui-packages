module 0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::account {
    struct NaviWitness has drop {
        dummy_field: bool,
    }

    struct AccountCreatedEvent has copy, drop {
        account_cap_id: 0x2::object::ID,
        owner: address,
        creator: address,
        storage_id: 0x2::object::ID,
    }

    struct BorrowEvent has copy, drop {
        pool_id: 0x2::object::ID,
        borrower: address,
        amount: u64,
        debt_opened: u64,
        asset: u8,
    }

    struct RepayEvent has copy, drop {
        pool_id: 0x2::object::ID,
        repayer: address,
        amount: u64,
        asset: u8,
    }

    struct RewardsClaimedEvent has copy, drop {
        storage_id: 0x2::object::ID,
        owner: address,
        reward_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct LiquidateEvent has copy, drop {
        debt_pool_id: 0x2::object::ID,
        collateral_pool_id: 0x2::object::ID,
        liquidator: address,
        liquidate_user: address,
        debt_asset: u8,
        collateral_asset: u8,
        debt_amount: u64,
        collateral_amount: u64,
    }

    public fun borrow<T0, T1>(arg0: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::ManagerCap, arg1: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Strategy<T0>, arg2: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::AdapterInfo, arg3: &0xe596d8ae7010a101545d84cdead3c7c4bcb475c3bd614fc13e456adff21fafe::nami_whitelist::WhitelistRegistry, arg4: &0x6ed01ddca67b1efc5bcd68fc12d7d4131a129e95455d8ed80275cb530e570620::nami_master_strategy_config::MasterStrategyConfig, arg5: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg8: u8, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(arg12 > 0, 850);
        let v0 = open_move<T0>(arg0, arg1, arg4, arg2, arg3, 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::move_enter(), 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::role_flag_borrow());
        let v1 = &mut v0;
        let v2 = lend_cap<T0>(arg1, v1);
        let v3 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&v2);
        let v4 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::borrow_with_account_cap_v2<T1>(arg13, arg5, arg6, arg7, arg8, arg12, arg9, arg10, &v2, arg11, arg14);
        assert_health_floor<T0>(arg1, arg2, arg13, arg5, arg6, v3, arg4);
        let v5 = 0x2::balance::value<T1>(&v4);
        let v6 = v5 + 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::get_borrow_fee_v2(arg10, v3, arg8, v5);
        let v7 = BorrowEvent{
            pool_id     : 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>>(arg7),
            borrower    : v3,
            amount      : v5,
            debt_opened : v6,
            asset       : arg8,
        };
        0x2::event::emit<BorrowEvent>(v7);
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::return_account<T0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, NaviWitness>(witness(), arg1, &mut v0, v2);
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::put<T0, T1, NaviWitness>(witness(), arg1, &mut v0, v4);
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::record_debt_opened<T0, T1, NaviWitness>(witness(), arg1, &mut v0, 0x2::object::id_from_address(v3), v6);
        settle<T0>(arg1, arg3, v0, arg6);
    }

    public(friend) fun settle<T0>(arg0: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Strategy<T0>, arg1: &0xe596d8ae7010a101545d84cdead3c7c4bcb475c3bd614fc13e456adff21fafe::nami_whitelist::WhitelistRegistry, arg2: 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Ticket, arg3: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage) {
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::settle<T0, NaviWitness>(witness(), arg0, arg1, arg2, 0x1::option::some<0x2::object::ID>(0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage>(arg3)));
    }

    public(friend) fun assert_health_floor<T0>(arg0: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Strategy<T0>, arg1: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::AdapterInfo, arg2: &0x2::clock::Clock, arg3: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: address, arg6: &0x6ed01ddca67b1efc5bcd68fc12d7d4131a129e95455d8ed80275cb530e570620::nami_master_strategy_config::MasterStrategyConfig) {
        let v0 = 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::counted_account_assets<T0>(arg0, 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::position_key_account(0x2::object::id<0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::AdapterInfo>(arg1), 0x1::type_name::with_defining_ids<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>()));
        assert!(counted_health_bps(arg2, arg3, arg4, arg5, &v0) >= 0x6ed01ddca67b1efc5bcd68fc12d7d4131a129e95455d8ed80275cb530e570620::nami_master_strategy_config::lending_min_health_bps(arg6), 852);
    }

    public fun claim_rewards<T0, T1>(arg0: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::ManagerCap, arg1: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Strategy<T0>, arg2: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::AdapterInfo, arg3: &0xe596d8ae7010a101545d84cdead3c7c4bcb475c3bd614fc13e456adff21fafe::nami_whitelist::WhitelistRegistry, arg4: &0x6ed01ddca67b1efc5bcd68fc12d7d4131a129e95455d8ed80275cb530e570620::nami_master_strategy_config::MasterStrategyConfig, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::RewardFund<T1>, arg8: vector<0x1::ascii::String>, arg9: vector<address>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = open_move<T0>(arg0, arg1, arg4, arg2, arg3, 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::move_exit(), 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::role_flag_lend());
        let v1 = &mut v0;
        let v2 = lend_cap<T0>(arg1, v1);
        let v3 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::claim_reward_with_account_cap<T1>(arg10, arg6, arg5, arg7, arg8, arg9, &v2);
        if (0x2::balance::value<T1>(&v3) > 0) {
            let v4 = RewardsClaimedEvent{
                storage_id  : 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage>(arg5),
                owner       : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&v2),
                reward_type : 0x1::type_name::with_defining_ids<T1>(),
                amount      : 0x2::balance::value<T1>(&v3),
            };
            0x2::event::emit<RewardsClaimedEvent>(v4);
        };
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::return_account<T0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, NaviWitness>(witness(), arg1, &mut v0, v2);
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::put_reward<T0, T1, NaviWitness>(witness(), arg1, arg4, &mut v0, v3, arg11);
        settle<T0>(arg1, arg3, v0, arg5);
    }

    public(friend) fun counted_health_bps(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: address, arg4: &vector<0x1::type_name::TypeName>) : u64 {
        let v0 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::weighted_user_health_loan_value(arg0, arg1, arg2, arg3);
        let v1 = loans_owed(arg2, arg3);
        let v2 = 0x1::vector::length<u8>(&v1);
        if (v2 == 0) {
            return 18446744073709551615
        };
        let (v3, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_assets(arg2, arg3);
        let v5 = 0;
        let v6 = v3;
        0x1::vector::reverse<u8>(&mut v6);
        let v7 = 0;
        while (v7 < 0x1::vector::length<u8>(&v6)) {
            let v8 = 0x1::vector::pop_back<u8>(&mut v6);
            let v9 = 0;
            let v10;
            while (v9 < 0x1::vector::length<0x1::type_name::TypeName>(arg4)) {
                if (*0x1::type_name::as_string(0x1::vector::borrow<0x1::type_name::TypeName>(arg4, v9)) == 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_coin_type(arg2, v8)) {
                    v10 = true;
                    /* label 9 */
                    if (v10) {
                        let (_, _, v13) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_liquidation_factors(arg2, v8);
                        v5 = v5 + 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_value(arg0, arg1, arg2, v8, arg3) * v13;
                    };
                    v7 = v7 + 1;
                    /* goto 3 */
                    continue
                };
                v9 = v9 + 1;
            };
            v10 = false;
            /* goto 9 */
        };
        0x1::vector::destroy_empty<u8>(v6);
        (0x1::u256::min(v5 / (v0 + 2 * (v2 as u256)) / 100000000000000000000000, 18446744073709551615) as u64)
    }

    public fun create_account<T0>(arg0: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::ManagerCap, arg1: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Strategy<T0>, arg2: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::AdapterInfo, arg3: &0xe596d8ae7010a101545d84cdead3c7c4bcb475c3bd614fc13e456adff21fafe::nami_whitelist::WhitelistRegistry, arg4: &0x6ed01ddca67b1efc5bcd68fc12d7d4131a129e95455d8ed80275cb530e570620::nami_master_strategy_config::MasterStrategyConfig, arg5: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = open_move<T0>(arg0, arg1, arg4, arg2, arg3, 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::move_enter(), 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::role_flag_lend());
        let v1 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::create_account(arg6);
        let v2 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&v1);
        let v3 = AccountCreatedEvent{
            account_cap_id : 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(&v1),
            owner          : v2,
            creator        : 0x2::tx_context::sender(arg6),
            storage_id     : 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage>(arg5),
        };
        0x2::event::emit<AccountCreatedEvent>(v3);
        let v4 = 0x2::object::id_from_address(v2);
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::store_account<T0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, NaviWitness>(witness(), arg1, &mut v0, v1, v4);
        settle<T0>(arg1, arg3, v0, arg5);
        v4
    }

    public(friend) fun emit_repay_event(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u8) {
        let v0 = RepayEvent{
            pool_id : arg0,
            repayer : arg1,
            amount  : arg2,
            asset   : arg3,
        };
        0x2::event::emit<RepayEvent>(v0);
    }

    public fun get_borrow_fee(arg0: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg1: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, arg2: u8, arg3: u64) : u64 {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::get_borrow_fee_v2(arg0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(arg1), arg2, arg3)
    }

    public(friend) fun health_bps(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: address) : u64 {
        let (_, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_assets(arg2, arg3);
        let v2 = v1;
        if (0x1::vector::is_empty<u8>(&v2)) {
            return 18446744073709551615
        };
        (0x1::u256::min(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_health_factor(arg0, arg2, arg1, arg3) / 100000000000000000000000, 18446744073709551615) as u64)
    }

    public(friend) fun lend_cap<T0>(arg0: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Strategy<T0>, arg1: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Ticket) : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap {
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::lend_account<T0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, NaviWitness>(witness(), arg0, arg1)
    }

    public fun liquidate<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: u8, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: 0x2::coin::Coin<T0>, arg6: u8, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg8: address, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg11: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>) {
        let v0 = 0x2::coin::value<T0>(&arg5);
        assert!(v0 > 0, 850);
        let (v1, v2) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T0, T1>(arg0, arg1, arg2, arg3, arg4, 0x2::coin::into_balance<T0>(arg5), arg6, arg7, arg8, arg9, arg10, arg11);
        let v3 = v2;
        let v4 = v1;
        let v5 = LiquidateEvent{
            debt_pool_id       : 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>>(arg4),
            collateral_pool_id : 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>>(arg7),
            liquidator         : 0x2::tx_context::sender(arg11),
            liquidate_user     : arg8,
            debt_asset         : arg3,
            collateral_asset   : arg6,
            debt_amount        : v0 - 0x2::balance::value<T0>(&v3),
            collateral_amount  : 0x2::balance::value<T1>(&v4),
        };
        0x2::event::emit<LiquidateEvent>(v5);
        (v4, v3)
    }

    entry fun liquidate_entry<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: u8, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: 0x2::coin::Coin<T0>, arg6: u8, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg8: address, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = liquidate<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        maybe_transfer_or_destroy_balance<T1>(v0, arg11);
        maybe_transfer_or_destroy_balance<T0>(v1, arg11);
    }

    public(friend) fun loans_owed(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: address) : vector<u8> {
        let (_, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_assets(arg0, arg1);
        let v2 = b"";
        let v3 = v1;
        0x1::vector::reverse<u8>(&mut v3);
        let v4 = 0;
        while (v4 < 0x1::vector::length<u8>(&v3)) {
            let v5 = 0x1::vector::pop_back<u8>(&mut v3);
            if (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_loan_balance(arg0, v5, arg1) > 0) {
                0x1::vector::push_back<u8>(&mut v2, v5);
            };
            v4 = v4 + 1;
        };
        0x1::vector::destroy_empty<u8>(v3);
        v2
    }

    fun maybe_transfer_or_destroy_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
        } else {
            0x2::balance::destroy_zero<T0>(arg0);
        };
    }

    public(friend) fun open_move<T0>(arg0: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::ManagerCap, arg1: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Strategy<T0>, arg2: &0x6ed01ddca67b1efc5bcd68fc12d7d4131a129e95455d8ed80275cb530e570620::nami_master_strategy_config::MasterStrategyConfig, arg3: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::AdapterInfo, arg4: &0xe596d8ae7010a101545d84cdead3c7c4bcb475c3bd614fc13e456adff21fafe::nami_whitelist::WhitelistRegistry, arg5: u8, arg6: u64) : 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Ticket {
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::open_ticket<T0, NaviWitness>(witness(), 0x9edf603d9cd358c96c46ed422e64fbe8b9e3adeddde49a77d8498c14024a2274::version::current_version(), arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public(friend) fun owes(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: address, arg2: u8) : bool {
        let v0 = loans_owed(arg0, arg1);
        0x1::vector::contains<u8>(&v0, &arg2)
    }

    public(friend) fun pocket_owner<T0>(arg0: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Pocket<T0>) : address {
        let v0 = 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::pocket_account_subject<T0>(arg0);
        assert!(0x1::option::is_some<0x2::object::ID>(&v0), 851);
        let v1 = 0x1::option::destroy_some<0x2::object::ID>(v0);
        0x2::object::id_to_address(&v1)
    }

    public fun repay<T0, T1>(arg0: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::ManagerCap, arg1: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Strategy<T0>, arg2: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::AdapterInfo, arg3: &0xe596d8ae7010a101545d84cdead3c7c4bcb475c3bd614fc13e456adff21fafe::nami_whitelist::WhitelistRegistry, arg4: &0x6ed01ddca67b1efc5bcd68fc12d7d4131a129e95455d8ed80275cb530e570620::nami_master_strategy_config::MasterStrategyConfig, arg5: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg8: u8, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(arg11 > 0, 850);
        let v0 = open_move<T0>(arg0, arg1, arg4, arg2, arg3, 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::move_exit(), 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::role_flag_borrow());
        let v1 = &mut v0;
        let v2 = lend_cap<T0>(arg1, v1);
        let v3 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&v2);
        let v4 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::repay_with_account_cap<T1>(arg12, arg5, arg6, arg7, arg8, 0x2::coin::from_balance<T1>(0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::take<T0, T1, NaviWitness>(witness(), arg1, &mut v0, arg11), arg13), arg9, arg10, &v2);
        let v5 = arg11 - 0x2::balance::value<T1>(&v4);
        emit_repay_event(0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>>(arg7), v3, v5, arg8);
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::put<T0, T1, NaviWitness>(witness(), arg1, &mut v0, v4);
        let v6 = owes(arg6, v3, arg8);
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::record_debt_repaid<T0, T1, NaviWitness>(witness(), arg1, &mut v0, 0x2::object::id_from_address(v3), v5, !v6, arg12);
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::return_account<T0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, NaviWitness>(witness(), arg1, &mut v0, v2);
        settle<T0>(arg1, arg3, v0, arg6);
    }

    public(friend) fun supplies_held(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: address) : vector<u8> {
        let (v0, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_assets(arg0, arg1);
        let v2 = b"";
        let v3 = v0;
        0x1::vector::reverse<u8>(&mut v3);
        let v4 = 0;
        while (v4 < 0x1::vector::length<u8>(&v3)) {
            let v5 = 0x1::vector::pop_back<u8>(&mut v3);
            if (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_balance(arg0, v5, arg1) > 0) {
                0x1::vector::push_back<u8>(&mut v2, v5);
            };
            v4 = v4 + 1;
        };
        0x1::vector::destroy_empty<u8>(v3);
        v2
    }

    public fun user_emode_id(arg0: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap) : u64 {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_emode_id(arg0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(arg1))
    }

    public(friend) fun vault_owner<T0>(arg0: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Strategy<T0>, arg1: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::AdapterInfo) : address {
        let v0 = 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::position_key_account(0x2::object::id<0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::AdapterInfo>(arg1), 0x1::type_name::with_defining_ids<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>());
        assert!(0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::has_position_record<T0>(arg0, v0), 851);
        let v1 = 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::position_record<T0>(arg0, v0);
        let v2 = 0x1::option::destroy_some<0x2::object::ID>(0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::record_subject(&v1));
        0x2::object::id_to_address(&v2)
    }

    public(friend) fun witness() : NaviWitness {
        NaviWitness{dummy_field: false}
    }

    // decompiled from Move bytecode v7
}

