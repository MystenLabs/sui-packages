module 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2 {
    struct OwnerCap has store, key {
        id: 0x2::object::UID,
    }

    struct Incentive has store, key {
        id: 0x2::object::UID,
        version: u64,
        pool_objs: vector<address>,
        inactive_objs: vector<address>,
        pools: 0x2::table::Table<address, IncentivePool>,
        funds: 0x2::table::Table<address, IncentiveFundsPoolInfo>,
    }

    struct IncentivePool has store, key {
        id: 0x2::object::UID,
        phase: u64,
        funds: address,
        start_at: u64,
        end_at: u64,
        closed_at: u64,
        total_supply: u64,
        option: u8,
        asset_id: u8,
        factor: u256,
        last_update_at: u64,
        distributed: u64,
        index_reward: u256,
        index_rewards_paids: 0x2::table::Table<address, u256>,
        total_rewards_of_users: 0x2::table::Table<address, u256>,
        total_claimed_of_users: 0x2::table::Table<address, u256>,
    }

    struct IncentiveFundsPool<phantom T0> has store, key {
        id: 0x2::object::UID,
        oracle_id: u8,
        balance: 0x2::balance::Balance<T0>,
        coin_type: 0x1::type_name::TypeName,
    }

    struct IncentiveFundsPoolInfo has store, key {
        id: 0x2::object::UID,
        oracle_id: u8,
        coin_type: 0x1::type_name::TypeName,
    }

    struct CreateFundsPool has copy, drop {
        sender: address,
        coin_type: 0x1::type_name::TypeName,
        oracle_id: u8,
        force: bool,
    }

    struct IncreasedFunds has copy, drop {
        sender: address,
        balance_before: u64,
        balance_after: u64,
    }

    struct WithdrawFunds has copy, drop {
        sender: address,
        value: u64,
    }

    struct CreateIncentive has copy, drop {
        sender: address,
        incentive_pool_pro: address,
    }

    struct CreateIncentivePool has copy, drop {
        sender: address,
        pool: address,
    }

    struct RewardsClaimed has copy, drop {
        sender: address,
        pool: address,
        amount: u64,
    }

    public fun borrow<T0>(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: &mut Incentive, arg7: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        abort 0
    }

    public fun add_funds<T0>(arg0: &OwnerCap, arg1: &mut IncentiveFundsPool<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = IncreasedFunds{
            sender         : 0x2::tx_context::sender(arg4),
            balance_before : 0x2::balance::value<T0>(&arg1.balance),
            balance_after  : 0x2::balance::join<T0>(&mut arg1.balance, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::utils::split_coin_to_balance<T0>(arg2, arg3, arg4)),
        };
        0x2::event::emit<IncreasedFunds>(v0);
    }

    public fun borrow_with_account_cap<T0>(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: &mut Incentive, arg7: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap) : 0x2::balance::Balance<T0> {
        abort 0
    }

    fun calculate_one(arg0: &IncentivePool, arg1: u64, arg2: u256, arg3: address, arg4: u256) : (u256, u256) {
        let v0 = arg0.start_at;
        let v1 = v0;
        if (v0 < arg0.last_update_at) {
            v1 = arg0.last_update_at;
        };
        let v2 = arg0.end_at;
        let v3 = v2;
        if (arg1 < v2) {
            v3 = arg1;
        };
        let v4 = arg0.index_reward;
        let v5 = v4;
        if (v1 < v3) {
            let v6 = 0;
            if (arg2 > 0) {
                v6 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::safe_math::mul(calculate_release_rate(arg0), ((v3 - v1) as u256)) / arg2;
            };
            v5 = v4 + v6;
        };
        let v7 = 0;
        if (0x2::table::contains<address, u256>(&arg0.total_rewards_of_users, arg3)) {
            v7 = *0x2::table::borrow<address, u256>(&arg0.total_rewards_of_users, arg3);
        };
        let v8 = 0;
        if (0x2::table::contains<address, u256>(&arg0.index_rewards_paids, arg3)) {
            v8 = *0x2::table::borrow<address, u256>(&arg0.index_rewards_paids, arg3);
        };
        (v5, v7 + (v5 - v8) * arg4)
    }

    public fun calculate_one_from_pool(arg0: &Incentive, arg1: address, arg2: u64, arg3: u256, arg4: address, arg5: u256) : (u256, u256) {
        calculate_one(0x2::table::borrow<address, IncentivePool>(&arg0.pools, arg1), arg2, arg3, arg4, arg5)
    }

    public fun calculate_release_rate(arg0: &IncentivePool) : u256 {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::ray_math::ray_div((arg0.total_supply as u256), ((arg0.end_at - arg0.start_at) as u256))
    }

    public fun calculate_user_effective_amount(arg0: u8, arg1: u256, arg2: u256, arg3: u256) : u256 {
        let v0 = arg1;
        if (arg0 == 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::constants::option_type_borrow()) {
            arg1 = arg2;
            arg2 = v0;
        };
        let v1 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::ray_math::ray_mul(arg3, arg2);
        if (arg1 > v1) {
            return arg1 - v1
        };
        0
    }

    public entry fun claim_reward<T0>(arg0: &0x2::clock::Clock, arg1: &mut Incentive, arg2: &mut IncentiveFundsPool<T0>, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: u8, arg5: u8, arg6: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun claim_reward_non_entry<T0>(arg0: &0x2::clock::Clock, arg1: &mut Incentive, arg2: &mut IncentiveFundsPool<T0>, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: u8, arg5: u8, arg6: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        abort 0
    }

    public fun claim_reward_with_account_cap<T0>(arg0: &0x2::clock::Clock, arg1: &mut Incentive, arg2: &mut IncentiveFundsPool<T0>, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: u8, arg5: u8, arg6: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap) : 0x2::balance::Balance<T0> {
        abort 0
    }

    public fun create_and_transfer_owner(arg0: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::OwnerCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = OwnerCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<OwnerCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun create_funds_pool<T0>(arg0: &OwnerCap, arg1: &mut Incentive, arg2: u8, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        version_verification(arg1);
        let v0 = 0x2::object::new(arg4);
        let v1 = IncentiveFundsPool<T0>{
            id        : v0,
            oracle_id : arg2,
            balance   : 0x2::balance::zero<T0>(),
            coin_type : 0x1::type_name::get<T0>(),
        };
        0x2::transfer::share_object<IncentiveFundsPool<T0>>(v1);
        let v2 = IncentiveFundsPoolInfo{
            id        : 0x2::object::new(arg4),
            oracle_id : arg2,
            coin_type : 0x1::type_name::get<T0>(),
        };
        0x2::table::add<address, IncentiveFundsPoolInfo>(&mut arg1.funds, 0x2::object::uid_to_address(&v0), v2);
        let v3 = CreateFundsPool{
            sender    : 0x2::tx_context::sender(arg4),
            coin_type : 0x1::type_name::get<T0>(),
            oracle_id : arg2,
            force     : arg3,
        };
        0x2::event::emit<CreateFundsPool>(v3);
    }

    public fun create_incentive(arg0: &OwnerCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg1);
        let v1 = Incentive{
            id            : v0,
            version       : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::version::this_version(),
            pool_objs     : 0x1::vector::empty<address>(),
            inactive_objs : 0x1::vector::empty<address>(),
            pools         : 0x2::table::new<address, IncentivePool>(arg1),
            funds         : 0x2::table::new<address, IncentiveFundsPoolInfo>(arg1),
        };
        0x2::transfer::share_object<Incentive>(v1);
        let v2 = CreateIncentive{
            sender             : 0x2::tx_context::sender(arg1),
            incentive_pool_pro : 0x2::object::uid_to_address(&v0),
        };
        0x2::event::emit<CreateIncentive>(v2);
    }

    public fun create_incentive_pool<T0>(arg0: &OwnerCap, arg1: &mut Incentive, arg2: &IncentiveFundsPool<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u8, arg9: u8, arg10: u256, arg11: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun deposit_with_account_cap<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg3: u8, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg6: &mut Incentive, arg7: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap) {
        abort 0
    }

    public entry fun entry_borrow<T0>(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: &mut Incentive, arg7: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun entry_deposit<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg3: u8, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg7: &mut Incentive, arg8: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun entry_deposit_on_behalf_of_user<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg3: u8, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: address, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg8: &mut Incentive, arg9: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun entry_liquidation<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: u8, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: 0x2::coin::Coin<T0>, arg6: u8, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg8: address, arg9: u64, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg11: &mut Incentive, arg12: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun entry_repay<T0>(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: u8, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut Incentive, arg8: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun entry_repay_on_behalf_of_user<T0>(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: u8, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: address, arg8: &mut Incentive, arg9: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun entry_withdraw<T0>(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg7: &mut Incentive, arg8: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun freeze_incentive_pool(arg0: &OwnerCap, arg1: &mut Incentive, arg2: u64) {
        let v0 = 0x1::vector::empty<address>();
        let v1 = 0x1::vector::empty<address>();
        let v2 = 0x1::vector::length<address>(&arg1.pool_objs);
        while (v2 > 0) {
            let v3 = *0x1::vector::borrow<address>(&arg1.pool_objs, v2 - 1);
            if (0x2::table::borrow<address, IncentivePool>(&arg1.pools, v3).phase < arg2) {
                0x1::vector::push_back<address>(&mut v1, v3);
            } else {
                0x1::vector::push_back<address>(&mut v0, v3);
            };
            v2 = v2 - 1;
        };
        arg1.pool_objs = v0;
        0x1::vector::append<address>(&mut arg1.inactive_objs, v1);
    }

    public fun get_active_pools(arg0: &Incentive, arg1: u8, arg2: u8, arg3: u64) : vector<address> {
        let v0 = arg0.pool_objs;
        let v1 = 0x1::vector::length<address>(&v0);
        let v2 = 0x1::vector::empty<address>();
        while (v1 > 0) {
            let v3 = *0x1::vector::borrow<address>(&v0, v1 - 1);
            let v4 = 0x2::table::borrow<address, IncentivePool>(&arg0.pools, v3);
            let v5 = if (v4.asset_id == arg1) {
                if (v4.option == arg2) {
                    if (v4.start_at <= arg3) {
                        v4.end_at >= arg3
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            if (v5) {
                0x1::vector::push_back<address>(&mut v2, v3);
            };
            v1 = v1 - 1;
        };
        v2
    }

    public fun get_funds_info(arg0: &Incentive, arg1: address) : (address, u8, 0x1::type_name::TypeName) {
        let v0 = 0x2::table::borrow<address, IncentiveFundsPoolInfo>(&arg0.funds, arg1);
        (0x2::object::uid_to_address(&v0.id), v0.oracle_id, v0.coin_type)
    }

    public fun get_funds_value<T0>(arg0: &IncentiveFundsPool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun get_inactive_pool_objects(arg0: &Incentive) : vector<address> {
        arg0.inactive_objs
    }

    public fun get_pool_from_asset_and_option(arg0: &Incentive, arg1: u8, arg2: u8) : (vector<address>, vector<address>, vector<address>) {
        let v0 = arg0.pool_objs;
        let v1 = 0x1::vector::length<address>(&v0);
        let v2 = 0x1::vector::empty<address>();
        let v3 = 0x1::vector::empty<address>();
        let v4 = 0x1::vector::empty<address>();
        while (v1 > 0) {
            let v5 = *0x1::vector::borrow<address>(&v0, v1 - 1);
            let v6 = 0x2::table::borrow<address, IncentivePool>(&arg0.pools, v5);
            if (v6.asset_id == arg1 && v6.option == arg2) {
                0x1::vector::push_back<address>(&mut v2, v5);
                0x1::vector::push_back<address>(&mut v3, v5);
                0x1::vector::push_back<address>(&mut v4, v5);
                v1 = v1 - 1;
                continue
            };
            if (v6.asset_id == arg1) {
                0x1::vector::push_back<address>(&mut v2, v5);
            };
            if (v6.option == arg2) {
                0x1::vector::push_back<address>(&mut v3, v5);
            };
            v1 = v1 - 1;
        };
        (v2, v3, v4)
    }

    public fun get_pool_from_funds_pool<T0>(arg0: &Incentive, arg1: &IncentiveFundsPool<T0>, arg2: u8, arg3: u8) : vector<address> {
        let v0 = 0x1::vector::empty<address>();
        let v1 = arg0.pool_objs;
        let v2 = 0x1::vector::length<address>(&v1);
        while (v2 > 0) {
            let v3 = *0x1::vector::borrow<address>(&v1, v2 - 1);
            let v4 = 0x2::table::borrow<address, IncentivePool>(&arg0.pools, v3);
            let v5 = if (v4.asset_id == arg2) {
                if (v4.option == arg3) {
                    v4.funds == 0x2::object::uid_to_address(&arg1.id)
                } else {
                    false
                }
            } else {
                false
            };
            if (v5) {
                0x1::vector::push_back<address>(&mut v0, v3);
            };
            v2 = v2 - 1;
        };
        v0
    }

    public fun get_pool_info(arg0: &Incentive, arg1: address) : (address, u64, address, u64, u64, u64, u64, u8, u8, u256, u64, u64, u256) {
        let v0 = 0x2::table::borrow<address, IncentivePool>(&arg0.pools, arg1);
        (0x2::object::uid_to_address(&v0.id), v0.phase, v0.funds, v0.start_at, v0.end_at, v0.closed_at, v0.total_supply, v0.option, v0.asset_id, v0.factor, v0.last_update_at, v0.distributed, v0.index_reward)
    }

    public fun get_pool_length(arg0: &Incentive) : u64 {
        0x1::vector::length<address>(&arg0.pool_objs)
    }

    public fun get_pool_objects(arg0: &Incentive) : vector<address> {
        arg0.pool_objs
    }

    public fun get_total_claimed_from_user(arg0: &Incentive, arg1: address, arg2: address) : u256 {
        let v0 = 0x2::table::borrow<address, IncentivePool>(&arg0.pools, arg1);
        let v1 = 0;
        if (0x2::table::contains<address, u256>(&v0.total_claimed_of_users, arg2)) {
            v1 = *0x2::table::borrow<address, u256>(&v0.total_claimed_of_users, arg2);
        };
        v1
    }

    public fun liquidation<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: u8, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: 0x2::balance::Balance<T0>, arg6: u8, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg8: address, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg10: &mut Incentive, arg11: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>) {
        abort 0
    }

    public fun option_borrow() : u8 {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::constants::option_type_borrow()
    }

    public fun option_repay() : u8 {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::constants::option_type_repay()
    }

    public fun option_supply() : u8 {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::constants::option_type_supply()
    }

    public fun option_withdraw() : u8 {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::constants::option_type_withdraw()
    }

    public fun repay<T0>(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: u8, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut Incentive, arg8: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        abort 0
    }

    public fun repay_with_account_cap<T0>(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: u8, arg5: 0x2::coin::Coin<T0>, arg6: &mut Incentive, arg7: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap) : 0x2::balance::Balance<T0> {
        abort 0
    }

    public fun version_migrate(arg0: &OwnerCap, arg1: &mut Incentive) {
        assert!(arg1.version < 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::version::this_version(), 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::error::incorrect_version());
        arg1.version = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::version::this_version();
    }

    public fun version_verification(arg0: &Incentive) {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::version::pre_check_version(arg0.version);
    }

    public fun withdraw<T0>(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg7: &mut Incentive, arg8: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        abort 0
    }

    public fun withdraw_funds<T0>(arg0: &OwnerCap, arg1: &mut IncentiveFundsPool<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<T0>(&arg1.balance) >= arg2, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::error::insufficient_balance());
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, arg2), arg3), 0x2::tx_context::sender(arg3));
        let v0 = WithdrawFunds{
            sender : 0x2::tx_context::sender(arg3),
            value  : arg2,
        };
        0x2::event::emit<WithdrawFunds>(v0);
    }

    public fun withdraw_with_account_cap<T0>(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg7: &mut Incentive, arg8: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap) : 0x2::balance::Balance<T0> {
        abort 0
    }

    // decompiled from Move bytecode v7
}

