module 0x5f51d02fa049194239ffeac3e446a0020e7bbfc5d9149ff888366c24b2456b1::SRMV1 {
    struct PoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
        a: 0x1::type_name::TypeName,
        b: 0x1::type_name::TypeName,
        init_a: u64,
        init_b: u64,
        lp_minted: u64,
        locked_lp_balance: u64,
        lp_builder_fee: u64,
        burn_fee: u64,
        creator_royalty_fee: u64,
        rewards_fee: u64,
        creator_royalty_wallet: address,
        timestamp: u64,
    }

    struct LiquidityAdded has copy, drop {
        pool_id: 0x2::object::ID,
        a: 0x1::type_name::TypeName,
        b: 0x1::type_name::TypeName,
        amountin_a: u64,
        amountin_b: u64,
        lp_minted: u64,
        total_lp_supply: u64,
        timestamp: u64,
    }

    struct LiquidityRemoved has copy, drop {
        pool_id: 0x2::object::ID,
        a: 0x1::type_name::TypeName,
        b: 0x1::type_name::TypeName,
        amountout_a: u64,
        amountout_b: u64,
        lp_burnt: u64,
        total_lp_supply: u64,
        timestamp: u64,
    }

    struct LPLocked has copy, drop, store {
        pool_id: 0x2::object::ID,
        amount: u64,
    }

    struct Swapped has copy, drop {
        pool_id: 0x2::object::ID,
        wallet: address,
        tokenin: 0x1::type_name::TypeName,
        amountin: u64,
        tokenout: 0x1::type_name::TypeName,
        amountout: u64,
        is_buy: bool,
        reserve_a: u64,
        reserve_b: u64,
        swap_fee: u64,
        burn_fee: u64,
        royalty_fee: u64,
        rewards_fee: u64,
        lp_in_fee: u64,
        lp_out_fee: u64,
        timestamp: u64,
    }

    struct CreatorRoyaltyFeeDistributed has copy, drop {
        pool_id: 0x2::object::ID,
        creator_royalty_wallet: address,
        amount: u64,
        timestamp: u64,
    }

    struct BuyBackandBurn has copy, drop {
        pool_id: 0x2::object::ID,
        amount_a_buy: u64,
        amount_b_burnt: u64,
        timestamp: u64,
    }

    struct BurnCoins has copy, drop {
        pool_id: 0x2::object::ID,
        amount_b_burnt: u64,
        timestamp: u64,
    }

    struct RewardsProcessing has copy, drop {
        pool_id: 0x2::object::ID,
        recipient: address,
        amount: u64,
    }

    struct RewardsDeposited has copy, drop {
        pool_id: 0x2::object::ID,
        amount: u64,
    }

    struct SwapFeeDistributed has copy, drop {
        pool_id: 0x2::object::ID,
        amount: u64,
        timestamp: u64,
    }

    struct Config has key {
        id: 0x2::object::UID,
        swap_fee: u64,
        swap_fee_wallet: address,
        admin: address,
        rewards_manager: address,
    }

    struct CreatePoolLock has key {
        id: 0x2::object::UID,
        locked: bool,
        allowlist: vector<address>,
    }

    struct LP<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    struct Pool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        balance_a: 0x2::balance::Balance<T0>,
        balance_b: 0x2::balance::Balance<T1>,
        lp_supply: 0x2::balance::Supply<LP<T0, T1>>,
        lp_builder_fee: u64,
        burn_fee: u64,
        creator_royalty_fee: u64,
        rewards_fee: u64,
        swap_balance_a: 0x2::balance::Balance<T0>,
        burn_balance_a: 0x2::balance::Balance<T0>,
        burn_balance_b: 0x2::balance::Balance<T1>,
        creator_balance_a: 0x2::balance::Balance<T0>,
        reward_balance_a: 0x2::balance::Balance<T0>,
        locked_lp_balance: 0x2::balance::Balance<LP<T0, T1>>,
        creator_royalty_wallet: address,
    }

    struct Factory has key {
        id: 0x2::object::UID,
        pools: 0x2::table::Table<PoolItem, 0x2::object::ID>,
    }

    struct PoolItem has copy, drop, store {
        a: 0x1::type_name::TypeName,
        b: 0x1::type_name::TypeName,
    }

    public fun add_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>, arg3: u64, arg4: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<LP<T0, T1>>) {
        assert!(0x2::balance::value<T0>(&arg1) > 0 && 0x2::balance::value<T1>(&arg2) > 0, 0);
        let v0 = (0x2::balance::value<T0>(&arg1) as u128) * (0x2::balance::value<T1>(&arg0.balance_b) as u128);
        let v1 = (0x2::balance::value<T1>(&arg2) as u128) * (0x2::balance::value<T0>(&arg0.balance_a) as u128);
        let (v2, v3, v4) = if (v0 > v1) {
            let v5 = 0x2::balance::value<T1>(&arg2);
            ((ceil_div_u128(v1, (0x2::balance::value<T1>(&arg0.balance_b) as u128)) as u64), v5, muldiv(v5, 0x2::balance::supply_value<LP<T0, T1>>(&arg0.lp_supply), 0x2::balance::value<T1>(&arg0.balance_b)))
        } else if (v0 < v1) {
            let v6 = 0x2::balance::value<T0>(&arg1);
            (v6, (ceil_div_u128(v0, (0x2::balance::value<T0>(&arg0.balance_a) as u128)) as u64), muldiv(v6, 0x2::balance::supply_value<LP<T0, T1>>(&arg0.lp_supply), 0x2::balance::value<T0>(&arg0.balance_a)))
        } else {
            let v7 = 0x2::balance::value<T0>(&arg1);
            let v8 = 0x2::balance::value<T1>(&arg2);
            let v4 = if (0x2::balance::supply_value<LP<T0, T1>>(&arg0.lp_supply) == 0) {
                mulsqrt(v7, v8)
            } else {
                muldiv(v7, 0x2::balance::supply_value<LP<T0, T1>>(&arg0.lp_supply), 0x2::balance::value<T0>(&arg0.balance_a))
            };
            (v7, v8, v4)
        };
        0x2::balance::join<T0>(&mut arg0.balance_a, 0x2::balance::split<T0>(&mut arg1, v2));
        0x2::balance::join<T1>(&mut arg0.balance_b, 0x2::balance::split<T1>(&mut arg2, v3));
        assert!(v4 >= arg3, 3);
        let v9 = LiquidityAdded{
            pool_id         : 0x2::object::id<Pool<T0, T1>>(arg0),
            a               : 0x1::type_name::get<T0>(),
            b               : 0x1::type_name::get<T1>(),
            amountin_a      : v2,
            amountin_b      : v3,
            lp_minted       : v4,
            total_lp_supply : 0x2::balance::supply_value<LP<T0, T1>>(&arg0.lp_supply),
            timestamp       : get_timestamp(arg4),
        };
        0x2::event::emit<LiquidityAdded>(v9);
        (arg1, arg2, 0x2::balance::increase_supply<LP<T0, T1>>(&mut arg0.lp_supply, v4))
    }

    public fun add_liquidity_with_coins<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<LP<T0, T1>>) {
        let (v0, v1, v2) = add_liquidity<T0, T1>(arg0, 0x2::coin::into_balance<T0>(arg1), 0x2::coin::into_balance<T1>(arg2), arg3, arg4);
        (0x2::coin::from_balance<T0>(v0, arg5), 0x2::coin::from_balance<T1>(v1, arg5), 0x2::coin::from_balance<LP<T0, T1>>(v2, arg5))
    }

    public entry fun add_liquidity_with_coins_and_transfer_to_sender<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(arg2 > 0, 7);
        assert!(arg4 > 0, 7);
        let (v1, v2, v3) = add_liquidity<T0, T1>(arg0, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg1, arg2, arg7)), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg3, arg4, arg7)), arg5, arg6);
        destroy_zero_or_transfer_balance<LP<T0, T1>>(v3, v0, arg7);
        let v4 = 0x2::coin::from_balance<T0>(v1, arg7);
        let v5 = 0x2::coin::from_balance<T1>(v2, arg7);
        destroy_zero_or_transfer_balance<T0>(0x2::coin::into_balance<T0>(arg1), v0, arg7);
        destroy_zero_or_transfer_balance<T1>(0x2::coin::into_balance<T1>(arg3), v0, arg7);
        destroy_zero_or_transfer_balance<T0>(0x2::coin::into_balance<T0>(v4), v0, arg7);
        destroy_zero_or_transfer_balance<T1>(0x2::coin::into_balance<T1>(v5), v0, arg7);
    }

    fun add_pool<T0, T1>(arg0: &mut Factory, arg1: 0x2::object::ID) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        assert!(v0 != v1, 1);
        let v2 = PoolItem{
            a : v0,
            b : v1,
        };
        let v3 = PoolItem{
            a : v1,
            b : v0,
        };
        let v4 = 0x2::table::contains<PoolItem, 0x2::object::ID>(&arg0.pools, v2) || 0x2::table::contains<PoolItem, 0x2::object::ID>(&arg0.pools, v3);
        assert!(!v4, 2);
        let v5 = PoolItem{
            a : v0,
            b : v1,
        };
        0x2::table::add<PoolItem, 0x2::object::ID>(&mut arg0.pools, v5, arg1);
    }

    public entry fun add_to_allowlist(arg0: &mut CreatePoolLock, arg1: &Config, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg1.admin, 6);
        assert!(!0x1::vector::contains<address>(&arg0.allowlist, &arg2), 10);
        0x1::vector::push_back<address>(&mut arg0.allowlist, arg2);
    }

    fun calc_burn_swap_out_b(arg0: u64, arg1: u64, arg2: u64, arg3: &Config) : (u64, u64) {
        assert!(arg1 > 0 && arg2 > 0, 0);
        let v0 = arg3.swap_fee;
        let v1 = if (v0 > 0) {
            ceil_muldiv(arg0, v0, 10000)
        } else {
            0
        };
        let v2 = arg0 - v1;
        let v3 = arg1 + v2;
        assert!(v3 > 1, 0);
        (muldiv(v2, arg2, v3), v1)
    }

    fun calc_swap_out_a(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) : (u64, u64, u64, u64, u64, u64, u64) {
        assert!(arg1 > 0 && arg2 > 0, 4);
        let v0 = if (arg4 > 0) {
            ceil_muldiv(arg0, arg4, 2 * 10000)
        } else {
            0
        };
        let v1 = arg0 - v0;
        let v2 = arg1 + v1;
        assert!(v2 > 1, 0);
        let v3 = muldiv(v1, arg2, v2);
        let v4 = if (arg3 > 0) {
            ceil_muldiv(v3, arg3, 10000)
        } else {
            0
        };
        let v5 = if (arg5 > 0) {
            ceil_muldiv(v3, arg5, 10000)
        } else {
            0
        };
        let v6 = if (arg6 > 0) {
            ceil_muldiv(v3, arg6, 10000)
        } else {
            0
        };
        let v7 = if (arg7 > 0) {
            ceil_muldiv(v3, arg7, 10000)
        } else {
            0
        };
        let v8 = if (arg4 > 0) {
            ceil_muldiv(v3, arg4, 2 * 10000)
        } else {
            0
        };
        (v3 - v4 - v5 - v6 - v7 - v8, v0, v8, v4, v5, v6, v7)
    }

    fun calc_swap_out_b(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) : (u64, u64, u64, u64, u64, u64, u64) {
        assert!(arg1 > 0 && arg2 > 0, 0);
        let v0 = if (arg3 > 0) {
            ceil_muldiv(arg0, arg3, 10000)
        } else {
            0
        };
        let v1 = if (arg5 > 0) {
            ceil_muldiv(arg0, arg5, 10000)
        } else {
            0
        };
        let v2 = if (arg6 > 0) {
            ceil_muldiv(arg0, arg6, 10000)
        } else {
            0
        };
        let v3 = if (arg7 > 0) {
            ceil_muldiv(arg0, arg7, 10000)
        } else {
            0
        };
        let v4 = if (arg4 > 0) {
            ceil_muldiv(arg0, arg4, 2 * 10000)
        } else {
            0
        };
        let v5 = arg0 - v0 - v1 - v2 - v3 - v4;
        let v6 = arg1 + v5;
        assert!(v6 > 1, 0);
        let v7 = muldiv(v5, arg2, v6);
        let v8 = if (arg4 > 0) {
            ceil_muldiv(v7, arg4, 2 * 10000)
        } else {
            0
        };
        (v7 - v8, v4, v8, v0, v1, v2, v3)
    }

    fun ceil_div_u128(arg0: u128, arg1: u128) : u128 {
        if (arg0 == 0) {
            0
        } else {
            (arg0 - 1) / arg1 + 1
        }
    }

    fun ceil_muldiv(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 > 0, 0);
        let v0 = (arg0 as u128) * (arg1 as u128);
        assert!(v0 / (arg2 as u128) <= 18446744073709551615, 0);
        (ceil_div_u128(v0, (arg2 as u128)) as u64)
    }

    public fun create_pool<T0, T1>(arg0: &mut Factory, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: address, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<LP<T0, T1>> {
        assert!(0x2::balance::value<T0>(&arg1) > 0 && 0x2::balance::value<T1>(&arg2) > 0, 0);
        assert!(arg3 <= 300, 5);
        assert!(arg4 <= 500, 5);
        assert!(arg5 <= 100, 5);
        assert!(arg6 <= 500, 5);
        assert!(arg7 != @0x0, 12);
        let v0 = LP<T0, T1>{dummy_field: false};
        let v1 = Pool<T0, T1>{
            id                     : 0x2::object::new(arg9),
            balance_a              : arg1,
            balance_b              : arg2,
            lp_supply              : 0x2::balance::create_supply<LP<T0, T1>>(v0),
            lp_builder_fee         : arg3,
            burn_fee               : arg4,
            creator_royalty_fee    : arg5,
            rewards_fee            : arg6,
            swap_balance_a         : 0x2::balance::zero<T0>(),
            burn_balance_a         : 0x2::balance::zero<T0>(),
            burn_balance_b         : 0x2::balance::zero<T1>(),
            creator_balance_a      : 0x2::balance::zero<T0>(),
            reward_balance_a       : 0x2::balance::zero<T0>(),
            locked_lp_balance      : 0x2::balance::zero<LP<T0, T1>>(),
            creator_royalty_wallet : arg7,
        };
        let v2 = 0x2::object::id<Pool<T0, T1>>(&v1);
        add_pool<T0, T1>(arg0, v2);
        let v3 = mulsqrt(0x2::balance::value<T0>(&v1.balance_a), 0x2::balance::value<T1>(&v1.balance_b));
        let v4 = PoolCreated{
            pool_id                : v2,
            a                      : 0x1::type_name::get<T0>(),
            b                      : 0x1::type_name::get<T1>(),
            init_a                 : 0x2::balance::value<T0>(&v1.balance_a),
            init_b                 : 0x2::balance::value<T1>(&v1.balance_b),
            lp_minted              : v3,
            locked_lp_balance      : 0x2::balance::value<LP<T0, T1>>(&v1.locked_lp_balance),
            lp_builder_fee         : arg3,
            burn_fee               : arg4,
            creator_royalty_fee    : arg5,
            rewards_fee            : arg6,
            creator_royalty_wallet : arg7,
            timestamp              : get_timestamp(arg8),
        };
        0x2::event::emit<PoolCreated>(v4);
        0x2::transfer::share_object<Pool<T0, T1>>(v1);
        0x2::balance::increase_supply<LP<T0, T1>>(&mut v1.lp_supply, v3)
    }

    public fun create_pool_and_lock_lp<T0, T1>(arg0: &mut Factory, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: address, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<T0>(&arg1) > 0 && 0x2::balance::value<T1>(&arg2) > 0, 0);
        assert!(arg3 <= 300, 5);
        assert!(arg4 <= 500, 5);
        assert!(arg5 <= 100, 5);
        assert!(arg6 <= 500, 5);
        assert!(arg7 != @0x0, 12);
        let v0 = LP<T0, T1>{dummy_field: false};
        let v1 = Pool<T0, T1>{
            id                     : 0x2::object::new(arg9),
            balance_a              : arg1,
            balance_b              : arg2,
            lp_supply              : 0x2::balance::create_supply<LP<T0, T1>>(v0),
            lp_builder_fee         : arg3,
            burn_fee               : arg4,
            creator_royalty_fee    : arg5,
            rewards_fee            : arg6,
            swap_balance_a         : 0x2::balance::zero<T0>(),
            burn_balance_a         : 0x2::balance::zero<T0>(),
            burn_balance_b         : 0x2::balance::zero<T1>(),
            creator_balance_a      : 0x2::balance::zero<T0>(),
            reward_balance_a       : 0x2::balance::zero<T0>(),
            locked_lp_balance      : 0x2::balance::zero<LP<T0, T1>>(),
            creator_royalty_wallet : arg7,
        };
        let v2 = 0x2::object::id<Pool<T0, T1>>(&v1);
        add_pool<T0, T1>(arg0, v2);
        let v3 = mulsqrt(0x2::balance::value<T0>(&v1.balance_a), 0x2::balance::value<T1>(&v1.balance_b));
        let v4 = 0x2::balance::increase_supply<LP<T0, T1>>(&mut v1.lp_supply, v3);
        0x2::balance::join<LP<T0, T1>>(&mut v1.locked_lp_balance, v4);
        let v5 = LPLocked{
            pool_id : v2,
            amount  : 0x2::balance::value<LP<T0, T1>>(&v4),
        };
        0x2::event::emit<LPLocked>(v5);
        let v6 = PoolCreated{
            pool_id                : v2,
            a                      : 0x1::type_name::get<T0>(),
            b                      : 0x1::type_name::get<T1>(),
            init_a                 : 0x2::balance::value<T0>(&v1.balance_a),
            init_b                 : 0x2::balance::value<T1>(&v1.balance_b),
            lp_minted              : v3,
            locked_lp_balance      : 0x2::balance::value<LP<T0, T1>>(&v1.locked_lp_balance),
            lp_builder_fee         : arg3,
            burn_fee               : arg4,
            creator_royalty_fee    : arg5,
            rewards_fee            : arg6,
            creator_royalty_wallet : arg7,
            timestamp              : get_timestamp(arg8),
        };
        0x2::event::emit<PoolCreated>(v6);
        0x2::transfer::share_object<Pool<T0, T1>>(v1);
    }

    public entry fun create_pool_and_lock_lp_in_pool<T0, T1>(arg0: &CreatePoolLock, arg1: &mut Factory, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: address, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0, 7);
        assert!(arg5 > 0, 7);
        let v0 = 0x2::tx_context::sender(arg12);
        assert!(!arg0.locked || 0x1::vector::contains<address>(&arg0.allowlist, &v0), 6);
        let v1 = 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, arg3, arg12));
        let v2 = 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg4, arg5, arg12));
        create_pool_and_lock_lp<T0, T1>(arg1, v1, v2, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
        destroy_zero_or_transfer_balance<T0>(0x2::coin::into_balance<T0>(arg2), v0, arg12);
        destroy_zero_or_transfer_balance<T1>(0x2::coin::into_balance<T1>(arg4), v0, arg12);
    }

    public fun create_pool_with_coins<T0, T1>(arg0: &CreatePoolLock, arg1: &mut Factory, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: address, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<LP<T0, T1>>) {
        let v0 = 0x2::tx_context::sender(arg12);
        assert!(!arg0.locked || 0x1::vector::contains<address>(&arg0.allowlist, &v0), 6);
        let v1 = 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, arg3, arg12));
        let v2 = 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg4, arg5, arg12));
        let v3 = create_pool<T0, T1>(arg1, v1, v2, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
        (arg2, arg4, 0x2::coin::from_balance<LP<T0, T1>>(v3, arg12))
    }

    public entry fun create_pool_with_coins_and_transfer_lp_to_sender<T0, T1>(arg0: &CreatePoolLock, arg1: &mut Factory, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: address, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0, 7);
        assert!(arg5 > 0, 7);
        let v0 = 0x2::tx_context::sender(arg12);
        assert!(!arg0.locked || 0x1::vector::contains<address>(&arg0.allowlist, &v0), 6);
        let v1 = 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, arg3, arg12));
        let v2 = 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg4, arg5, arg12));
        let v3 = create_pool<T0, T1>(arg1, v1, v2, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
        destroy_zero_or_transfer_balance<T0>(0x2::coin::into_balance<T0>(arg2), v0, arg12);
        destroy_zero_or_transfer_balance<T1>(0x2::coin::into_balance<T1>(arg4), v0, arg12);
        destroy_zero_or_transfer_balance<LP<T0, T1>>(v3, v0, arg12);
    }

    public entry fun deposit_coinB_tokens<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 0);
        assert!(0x2::coin::value<T1>(&arg1) >= arg2, 9);
        0x2::balance::join<T1>(&mut arg0.burn_balance_b, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg1, arg2, arg4)));
        let v0 = BurnCoins{
            pool_id        : 0x2::object::id<Pool<T0, T1>>(arg0),
            amount_b_burnt : arg2,
            timestamp      : get_timestamp(arg3),
        };
        0x2::event::emit<BurnCoins>(v0);
        let v1 = 0x2::tx_context::sender(arg4);
        destroy_zero_or_transfer_balance<T1>(0x2::coin::into_balance<T1>(arg1), v1, arg4);
    }

    public entry fun deposit_lp_tokens<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<LP<T0, T1>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 0);
        assert!(0x2::coin::value<LP<T0, T1>>(&arg1) >= arg2, 9);
        0x2::balance::join<LP<T0, T1>>(&mut arg0.locked_lp_balance, 0x2::coin::into_balance<LP<T0, T1>>(0x2::coin::split<LP<T0, T1>>(&mut arg1, arg2, arg3)));
        let v0 = LPLocked{
            pool_id : 0x2::object::id<Pool<T0, T1>>(arg0),
            amount  : arg2,
        };
        0x2::event::emit<LPLocked>(v0);
        let v1 = 0x2::tx_context::sender(arg3);
        destroy_zero_or_transfer_balance<LP<T0, T1>>(0x2::coin::into_balance<LP<T0, T1>>(arg1), v1, arg3);
    }

    public entry fun deposit_rewards_to_pool<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &Config, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(v0 == arg1.rewards_manager || v0 == arg1.admin, 6);
        assert!(0x2::coin::value<T0>(&arg2) >= arg3, 9);
        0x2::balance::join<T0>(&mut arg0.reward_balance_a, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, arg3, arg4)));
        let v1 = RewardsDeposited{
            pool_id : 0x2::object::id<Pool<T0, T1>>(arg0),
            amount  : 0x2::balance::value<T0>(&arg0.reward_balance_a),
        };
        0x2::event::emit<RewardsDeposited>(v1);
        destroy_zero_or_transfer_balance<T0>(0x2::coin::into_balance<T0>(arg2), v0, arg4);
    }

    fun destroy_zero_or_transfer_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
        };
    }

    public fun distribute_burn_fee<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: &Config, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&arg0.burn_balance_a);
        if (v0 >= 100000000) {
            let (v1, v2) = calc_burn_swap_out_b(v0, 0x2::balance::value<T0>(&arg0.balance_a), 0x2::balance::value<T1>(&arg0.balance_b), arg2);
            let v3 = 0x2::balance::split<T0>(&mut arg0.burn_balance_a, v0);
            if (v2 > 0) {
                0x2::balance::join<T0>(&mut arg0.swap_balance_a, 0x2::balance::split<T0>(&mut v3, v2));
            };
            0x2::balance::join<T0>(&mut arg0.balance_a, v3);
            0x2::balance::join<T1>(&mut arg0.burn_balance_b, 0x2::balance::split<T1>(&mut arg0.balance_b, v1));
            let v4 = BuyBackandBurn{
                pool_id        : 0x2::object::id<Pool<T0, T1>>(arg0),
                amount_a_buy   : v0,
                amount_b_burnt : v1,
                timestamp      : get_timestamp(arg1),
            };
            0x2::event::emit<BuyBackandBurn>(v4);
        };
    }

    public fun distribute_creator_royalty_fee<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&arg0.creator_balance_a);
        if (v0 >= 100000000) {
            let v1 = arg0.creator_royalty_wallet;
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.creator_balance_a, v0), arg2), v1);
            let v2 = CreatorRoyaltyFeeDistributed{
                pool_id                : 0x2::object::id<Pool<T0, T1>>(arg0),
                creator_royalty_wallet : v1,
                amount                 : v0,
                timestamp              : get_timestamp(arg1),
            };
            0x2::event::emit<CreatorRoyaltyFeeDistributed>(v2);
        };
    }

    public fun distribute_swap_fee<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &Config, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&arg0.swap_balance_a);
        if (v0 >= 100000000) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.swap_balance_a, v0), arg3), arg1.swap_fee_wallet);
            let v1 = SwapFeeDistributed{
                pool_id   : 0x2::object::id<Pool<T0, T1>>(arg0),
                amount    : v0,
                timestamp : get_timestamp(arg2),
            };
            0x2::event::emit<SwapFeeDistributed>(v1);
        };
    }

    public fun get_pool_fees<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64, u64, u64) {
        (arg0.lp_builder_fee, arg0.burn_fee, arg0.creator_royalty_fee, arg0.rewards_fee)
    }

    public fun get_pool_info<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64, u64, u64, u64, u64, u64, u64, u64, u64, u64, u64, address) {
        (0x2::balance::value<T0>(&arg0.balance_a), 0x2::balance::value<T1>(&arg0.balance_b), 0x2::balance::supply_value<LP<T0, T1>>(&arg0.lp_supply), arg0.lp_builder_fee, arg0.burn_fee, arg0.creator_royalty_fee, arg0.rewards_fee, 0x2::balance::value<T0>(&arg0.swap_balance_a), 0x2::balance::value<T0>(&arg0.burn_balance_a), 0x2::balance::value<T1>(&arg0.burn_balance_b), 0x2::balance::value<T0>(&arg0.creator_balance_a), 0x2::balance::value<T0>(&arg0.reward_balance_a), arg0.creator_royalty_wallet)
    }

    public fun get_swap_fee(arg0: &Config) : u64 {
        arg0.swap_fee
    }

    fun get_timestamp(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Factory{
            id    : 0x2::object::new(arg0),
            pools : 0x2::table::new<PoolItem, 0x2::object::ID>(arg0),
        };
        0x2::transfer::share_object<Factory>(v0);
        let v1 = 0x2::tx_context::sender(arg0);
        let v2 = Config{
            id              : 0x2::object::new(arg0),
            swap_fee        : 100,
            swap_fee_wallet : v1,
            admin           : v1,
            rewards_manager : v1,
        };
        0x2::transfer::share_object<Config>(v2);
        let v3 = CreatePoolLock{
            id        : 0x2::object::new(arg0),
            locked    : true,
            allowlist : 0x1::vector::singleton<address>(v1),
        };
        0x2::transfer::share_object<CreatePoolLock>(v3);
    }

    fun muldiv(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 > 0, 0);
        let v0 = (arg0 as u128) * (arg1 as u128) / (arg2 as u128);
        assert!(v0 <= 18446744073709551615, 0);
        (v0 as u64)
    }

    fun mulsqrt(arg0: u64, arg1: u64) : u64 {
        (0x2::math::sqrt_u128((arg0 as u128) * (arg1 as u128)) as u64)
    }

    public fun pool_balances<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64, u64) {
        (0x2::balance::value<T0>(&arg0.balance_a), 0x2::balance::value<T1>(&arg0.balance_b), 0x2::balance::supply_value<LP<T0, T1>>(&arg0.lp_supply))
    }

    public entry fun remove_from_allowlist(arg0: &mut CreatePoolLock, arg1: &Config, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg1.admin, 6);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.allowlist, &arg2);
        assert!(v0, 11);
        0x1::vector::swap_remove<address>(&mut arg0.allowlist, v1);
    }

    public fun remove_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::balance::Balance<LP<T0, T1>>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(0x2::balance::value<LP<T0, T1>>(&arg1) > 0, 0);
        assert!(0x2::balance::supply_value<LP<T0, T1>>(&arg0.lp_supply) > 0, 4);
        let v0 = 0x2::balance::value<LP<T0, T1>>(&arg1);
        let v1 = 0x2::balance::supply_value<LP<T0, T1>>(&arg0.lp_supply);
        let v2 = muldiv(v0, 0x2::balance::value<T0>(&arg0.balance_a), v1);
        let v3 = muldiv(v0, 0x2::balance::value<T1>(&arg0.balance_b), v1);
        assert!(v2 >= arg2, 3);
        assert!(v3 >= arg3, 3);
        0x2::balance::decrease_supply<LP<T0, T1>>(&mut arg0.lp_supply, arg1);
        let v4 = LiquidityRemoved{
            pool_id         : 0x2::object::id<Pool<T0, T1>>(arg0),
            a               : 0x1::type_name::get<T0>(),
            b               : 0x1::type_name::get<T1>(),
            amountout_a     : v2,
            amountout_b     : v3,
            lp_burnt        : v0,
            total_lp_supply : 0x2::balance::supply_value<LP<T0, T1>>(&arg0.lp_supply),
            timestamp       : get_timestamp(arg4),
        };
        0x2::event::emit<LiquidityRemoved>(v4);
        (0x2::balance::split<T0>(&mut arg0.balance_a, v2), 0x2::balance::split<T1>(&mut arg0.balance_b, v3))
    }

    public fun remove_liquidity_with_coins<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<LP<T0, T1>>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1) = remove_liquidity<T0, T1>(arg0, 0x2::coin::into_balance<LP<T0, T1>>(arg1), arg2, arg3, arg4);
        (0x2::coin::from_balance<T0>(v0, arg5), 0x2::coin::from_balance<T1>(v1, arg5))
    }

    public entry fun remove_liquidity_with_coins_and_transfer_to_sender<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<LP<T0, T1>>, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 7);
        let v0 = 0x2::tx_context::sender(arg6);
        let (v1, v2) = remove_liquidity<T0, T1>(arg0, 0x2::coin::into_balance<LP<T0, T1>>(0x2::coin::split<LP<T0, T1>>(&mut arg1, arg2, arg6)), arg3, arg4, arg5);
        destroy_zero_or_transfer_balance<T0>(v1, v0, arg6);
        destroy_zero_or_transfer_balance<T1>(v2, v0, arg6);
        destroy_zero_or_transfer_balance<LP<T0, T1>>(0x2::coin::into_balance<LP<T0, T1>>(arg1), v0, arg6);
    }

    public entry fun set_create_pool_lock(arg0: &mut CreatePoolLock, arg1: &Config, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg1.admin, 6);
        arg0.locked = arg2;
    }

    public fun swap_a_for_b<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &Config, arg2: 0x2::balance::Balance<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        assert!(0x2::balance::value<T0>(&arg2) > 0, 0);
        assert!(0x2::balance::value<T0>(&arg0.balance_a) > 0 && 0x2::balance::value<T1>(&arg0.balance_b) > 0, 4);
        let v0 = 0x2::balance::value<T0>(&arg2);
        let (v1, v2, v3, v4) = get_pool_fees<T0, T1>(arg0);
        let (v5, v6, v7, v8, v9, v10, v11) = calc_swap_out_b(v0, 0x2::balance::value<T0>(&arg0.balance_a), 0x2::balance::value<T1>(&arg0.balance_b), arg1.swap_fee, v1, v2, v3, v4);
        assert!(v5 >= arg3, 3);
        0x2::balance::join<T0>(&mut arg0.balance_a, arg2);
        if (v8 != 0) {
            0x2::balance::join<T0>(&mut arg0.swap_balance_a, 0x2::balance::split<T0>(&mut arg0.balance_a, v8));
        };
        if (v9 != 0) {
            0x2::balance::join<T0>(&mut arg0.burn_balance_a, 0x2::balance::split<T0>(&mut arg0.balance_a, v9));
        };
        if (v10 != 0) {
            0x2::balance::join<T0>(&mut arg0.creator_balance_a, 0x2::balance::split<T0>(&mut arg0.balance_a, v10));
        };
        if (v11 != 0) {
            0x2::balance::join<T0>(&mut arg0.reward_balance_a, 0x2::balance::split<T0>(&mut arg0.balance_a, v11));
        };
        distribute_creator_royalty_fee<T0, T1>(arg0, arg4, arg5);
        distribute_burn_fee<T0, T1>(arg0, arg4, arg1, arg5);
        distribute_swap_fee<T0, T1>(arg0, arg1, arg4, arg5);
        let v12 = Swapped{
            pool_id     : 0x2::object::id<Pool<T0, T1>>(arg0),
            wallet      : 0x2::tx_context::sender(arg5),
            tokenin     : 0x1::type_name::get<T0>(),
            amountin    : v0,
            tokenout    : 0x1::type_name::get<T1>(),
            amountout   : v5,
            is_buy      : true,
            reserve_a   : 0x2::balance::value<T0>(&arg0.balance_a),
            reserve_b   : 0x2::balance::value<T1>(&arg0.balance_b) - v5,
            swap_fee    : v8,
            burn_fee    : v9,
            royalty_fee : v10,
            rewards_fee : v11,
            lp_in_fee   : v6,
            lp_out_fee  : v7,
            timestamp   : get_timestamp(arg4),
        };
        0x2::event::emit<Swapped>(v12);
        0x2::balance::split<T1>(&mut arg0.balance_b, v5)
    }

    public fun swap_a_for_b_with_coins<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &Config, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, arg3, arg6));
        let v1 = swap_a_for_b<T0, T1>(arg0, arg1, v0, arg4, arg5, arg6);
        (arg2, 0x2::coin::from_balance<T1>(v1, arg6))
    }

    public entry fun swap_a_for_b_with_coins_and_transfer_to_sender<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &Config, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0, 0);
        let v0 = 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, arg3, arg6));
        let v1 = swap_a_for_b<T0, T1>(arg0, arg1, v0, arg4, arg5, arg6);
        let v2 = 0x2::tx_context::sender(arg6);
        destroy_zero_or_transfer_balance<T0>(0x2::coin::into_balance<T0>(arg2), v2, arg6);
        destroy_zero_or_transfer_balance<T1>(v1, v2, arg6);
    }

    public fun swap_b_for_a<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &Config, arg2: 0x2::balance::Balance<T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        assert!(0x2::balance::value<T1>(&arg2) > 0, 0);
        assert!(0x2::balance::value<T0>(&arg0.balance_a) > 0 && 0x2::balance::value<T1>(&arg0.balance_b) > 0, 4);
        let v0 = 0x2::balance::value<T1>(&arg2);
        let (v1, v2, v3, v4) = get_pool_fees<T0, T1>(arg0);
        let (v5, v6, v7, v8, v9, v10, v11) = calc_swap_out_a(v0, 0x2::balance::value<T1>(&arg0.balance_b), 0x2::balance::value<T0>(&arg0.balance_a), arg1.swap_fee, v1, v2, v3, v4);
        assert!(v5 >= arg3, 3);
        0x2::balance::join<T1>(&mut arg0.balance_b, arg2);
        if (v8 != 0) {
            0x2::balance::join<T0>(&mut arg0.swap_balance_a, 0x2::balance::split<T0>(&mut arg0.balance_a, v8));
        };
        if (v9 != 0) {
            0x2::balance::join<T0>(&mut arg0.burn_balance_a, 0x2::balance::split<T0>(&mut arg0.balance_a, v9));
        };
        if (v10 != 0) {
            0x2::balance::join<T0>(&mut arg0.creator_balance_a, 0x2::balance::split<T0>(&mut arg0.balance_a, v10));
        };
        if (v11 != 0) {
            0x2::balance::join<T0>(&mut arg0.reward_balance_a, 0x2::balance::split<T0>(&mut arg0.balance_a, v11));
        };
        distribute_creator_royalty_fee<T0, T1>(arg0, arg4, arg5);
        distribute_burn_fee<T0, T1>(arg0, arg4, arg1, arg5);
        distribute_swap_fee<T0, T1>(arg0, arg1, arg4, arg5);
        let v12 = Swapped{
            pool_id     : 0x2::object::id<Pool<T0, T1>>(arg0),
            wallet      : 0x2::tx_context::sender(arg5),
            tokenin     : 0x1::type_name::get<T1>(),
            amountin    : v0,
            tokenout    : 0x1::type_name::get<T0>(),
            amountout   : v5,
            is_buy      : false,
            reserve_a   : 0x2::balance::value<T0>(&arg0.balance_a) - v5,
            reserve_b   : 0x2::balance::value<T1>(&arg0.balance_b),
            swap_fee    : v8,
            burn_fee    : v9,
            royalty_fee : v10,
            rewards_fee : v11,
            lp_in_fee   : v6,
            lp_out_fee  : v7,
            timestamp   : get_timestamp(arg4),
        };
        0x2::event::emit<Swapped>(v12);
        0x2::balance::split<T0>(&mut arg0.balance_a, v5)
    }

    public fun swap_b_for_a_with_coins<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &Config, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>) {
        let v0 = 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg2, arg3, arg6));
        let v1 = swap_b_for_a<T0, T1>(arg0, arg1, v0, arg4, arg5, arg6);
        (arg2, 0x2::coin::from_balance<T0>(v1, arg6))
    }

    public entry fun swap_b_for_a_with_coins_and_transfer_to_sender<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &Config, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0, 0);
        let v0 = 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg2, arg3, arg6));
        let v1 = swap_b_for_a<T0, T1>(arg0, arg1, v0, arg4, arg5, arg6);
        let v2 = 0x2::tx_context::sender(arg6);
        destroy_zero_or_transfer_balance<T1>(0x2::coin::into_balance<T1>(arg2), v2, arg6);
        destroy_zero_or_transfer_balance<T0>(v1, v2, arg6);
    }

    public entry fun update_admin(arg0: &mut Config, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 6);
        arg0.admin = arg1;
    }

    public entry fun update_creator_royalty_wallet<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &Config, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg1.admin, 6);
        assert!(arg2 != @0x0, 12);
        arg0.creator_royalty_wallet = arg2;
    }

    public entry fun update_rewards_manager(arg0: &mut Config, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 6);
        arg0.rewards_manager = arg1;
    }

    public entry fun update_swap_fee(arg0: &mut Config, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 6);
        assert!(arg1 <= 100, 5);
        arg0.swap_fee = arg1;
    }

    public entry fun update_swap_fee_wallet(arg0: &mut Config, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 6);
        arg0.swap_fee_wallet = arg1;
    }

    public entry fun withdraw_creator_royalty_fees<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.creator_royalty_wallet, 6);
        assert!(0x2::balance::value<T0>(&arg0.creator_balance_a) > 0, 9);
        destroy_zero_or_transfer_balance<T0>(0x2::balance::split<T0>(&mut arg0.creator_balance_a, 0x2::balance::value<T0>(&arg0.creator_balance_a)), v0, arg1);
    }

    public entry fun withdraw_rewards<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &Config, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg1.rewards_manager, 6);
        assert!(arg2 > 0 && arg2 <= 0x2::balance::value<T0>(&arg0.reward_balance_a), 8);
        destroy_zero_or_transfer_balance<T0>(0x2::balance::split<T0>(&mut arg0.reward_balance_a, arg2), arg1.rewards_manager, arg3);
        let v0 = RewardsProcessing{
            pool_id   : 0x2::object::id<Pool<T0, T1>>(arg0),
            recipient : arg1.rewards_manager,
            amount    : arg2,
        };
        0x2::event::emit<RewardsProcessing>(v0);
    }

    public entry fun withdraw_swap_fees<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &Config, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg1.admin, 6);
        assert!(0x2::balance::value<T0>(&arg0.swap_balance_a) > 0, 9);
        destroy_zero_or_transfer_balance<T0>(0x2::balance::split<T0>(&mut arg0.swap_balance_a, 0x2::balance::value<T0>(&arg0.swap_balance_a)), arg1.swap_fee_wallet, arg2);
    }

    // decompiled from Move bytecode v6
}

