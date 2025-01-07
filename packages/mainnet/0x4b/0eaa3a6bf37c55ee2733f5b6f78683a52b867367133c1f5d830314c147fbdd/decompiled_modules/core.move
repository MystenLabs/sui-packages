module 0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core {
    struct Global has key {
        id: 0x2::object::UID,
        version: u64,
        admin: 0x2::object::ID,
        pause: bool,
        beneficiary: address,
        swap_fee: u64,
        beneficiary_profit: u64,
        pools: 0x2::bag::Bag,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct LP<phantom T0, phantom T1> has drop, store {
        dummy_field: bool,
    }

    struct Pool<phantom T0, phantom T1> has store {
        coin_a: 0x2::balance::Balance<T0>,
        coin_b: 0x2::balance::Balance<T1>,
        coin_a_fee: 0x2::balance::Balance<T0>,
        coin_b_fee: 0x2::balance::Balance<T1>,
        lp_supply: 0x2::balance::Supply<LP<T0, T1>>,
        min_liquidity: 0x2::balance::Balance<LP<T0, T1>>,
    }

    struct StakePool<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        reward_per_sec: u64,
        accum_reward: u128,
        last_updated: u64,
        start_timestamp: u64,
        end_timestamp: u64,
        stakes: 0x2::table::Table<address, UserStake>,
        stake_coin: 0x2::coin::Coin<LP<T0, T1>>,
        reward_coin: 0x2::coin::Coin<T2>,
        scale: u128,
        emergency_locked: bool,
        duration_unstake_time_sec: u64,
        max_stake: u64,
    }

    struct UserStake has store {
        amount: u64,
        unobtainable_reward: u128,
        earned_reward: u64,
        unlock_time: u64,
    }

    fun accum_rewards_since_last_updated<T0, T1, T2>(arg0: &StakePool<T0, T1, T2>, arg1: u64) : u128 {
        let v0 = arg1 - arg0.last_updated;
        if (v0 == 0) {
            return 0
        };
        let v1 = lp_pool_total_staked<T0, T1, T2>(arg0);
        if (v1 == 0) {
            return 0
        };
        (arg0.reward_per_sec as u128) * (v0 as u128) * arg0.scale / v1
    }

    public fun add_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<LP<T0, T1>>, vector<u64>) {
        assert!(arg5, 115);
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = 0x2::coin::value<T1>(&arg2);
        assert!(v0 > 0 && v1 > 0, 100);
        let v2 = 0x2::coin::into_balance<T0>(arg1);
        let v3 = 0x2::coin::into_balance<T1>(arg2);
        let (v4, v5, v6) = get_reserves_size<T0, T1>(arg0);
        let (v7, v8) = 0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::utils::calc_optimal_coin_values(v0, v1, arg3, arg4, v4, v5);
        let v9 = if (0 == v6) {
            let v10 = 0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::math::sqrt(0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::math::mul_to_u128(v7, v8));
            assert!(v10 > 1000, 108);
            0x2::balance::join<LP<T0, T1>>(&mut arg0.min_liquidity, 0x2::balance::increase_supply<LP<T0, T1>>(&mut arg0.lp_supply, 1000));
            v10 - 1000
        } else {
            let v11 = (v6 as u128) * (v7 as u128) / (v4 as u128);
            let v12 = (v6 as u128) * (v8 as u128) / (v5 as u128);
            if (v11 < v12) {
                assert!(v11 < (18446744073709551615 as u128), 113);
                (v11 as u64)
            } else {
                assert!(v12 < (18446744073709551615 as u128), 113);
                (v12 as u64)
            }
        };
        assert!(v9 > 0, 114);
        if (v7 < v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v2, v0 - v7), arg6), 0x2::tx_context::sender(arg6));
        };
        if (v8 < v1) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v3, v1 - v8), arg6), 0x2::tx_context::sender(arg6));
        };
        assert!(0x2::balance::join<T0>(&mut arg0.coin_a, v2) < 1844674407370955, 102);
        assert!(0x2::balance::join<T1>(&mut arg0.coin_b, v3) < 1844674407370955, 102);
        let v13 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v13, v0);
        0x1::vector::push_back<u64>(&mut v13, v1);
        0x1::vector::push_back<u64>(&mut v13, v9);
        (0x2::coin::from_balance<LP<T0, T1>>(0x2::balance::increase_supply<LP<T0, T1>>(&mut arg0.lp_supply, v9), arg6), v13)
    }

    public fun beneficiary(arg0: &Global) : address {
        arg0.beneficiary
    }

    public fun beneficiary_profit(arg0: &Global) : u64 {
        arg0.beneficiary_profit
    }

    public(friend) fun change_beneficiary(arg0: &mut Global, arg1: address) {
        arg0.beneficiary = arg1;
    }

    public(friend) fun change_beneficiary_profit(arg0: &mut Global, arg1: u64) {
        assert!(arg1 <= 100, 117);
        arg0.beneficiary_profit = arg1;
    }

    public(friend) fun change_swap_fee(arg0: &mut Global, arg1: u64) {
        assert!(arg1 <= 100, 116);
        arg0.swap_fee = arg1;
    }

    public fun check_pause(arg0: &Global) {
        assert!(!arg0.pause, 112);
    }

    public fun check_version(arg0: &Global) {
        assert!(arg0.version == 1, 118);
    }

    public(friend) fun collect_fee<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, u64, u64) {
        let v0 = 0x2::balance::value<T0>(&arg0.coin_a_fee);
        let v1 = 0x2::balance::value<T1>(&arg0.coin_b_fee);
        assert!(v0 > 0 && v1 > 0, 100);
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.coin_a_fee, v0), arg1), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.coin_b_fee, v1), arg1), v0, v1)
    }

    public(friend) fun create_admin_cap(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v0, arg0);
    }

    public(friend) fun deposit_farm_reward<T0, T1, T2>(arg0: bool, arg1: &mut StakePool<T0, T1, T2>, arg2: 0x2::coin::Coin<T2>, arg3: u64) {
        assert!(arg0, 115);
        assert!(!is_finished_inner<T0, T1, T2>(arg1, arg3), 210);
        let v0 = 0x2::coin::value<T2>(&arg2);
        assert!(v0 > 0, 205);
        let v1 = v0 / arg1.reward_per_sec;
        assert!(v1 > 0, 209);
        arg1.end_timestamp = arg1.end_timestamp + v1;
        0x2::coin::join<T2>(&mut arg1.reward_coin, arg2);
    }

    public fun emergency_unstake_lp<T0, T1, T2>(arg0: &mut StakePool<T0, T1, T2>, arg1: &Global, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<LP<T0, T1>> {
        assert!(arg2, 115);
        assert!(is_emergency_inner<T0, T1, T2>(arg0, arg1), 208);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<address, UserStake>(&arg0.stakes, v0), 203);
        let UserStake {
            amount              : v1,
            unobtainable_reward : _,
            earned_reward       : _,
            unlock_time         : _,
        } = 0x2::table::remove<address, UserStake>(&mut arg0.stakes, v0);
        0x2::coin::split<LP<T0, T1>>(&mut arg0.stake_coin, v1, arg3)
    }

    public(friend) fun enable_emergency<T0, T1, T2>(arg0: bool, arg1: &mut StakePool<T0, T1, T2>, arg2: &Global) {
        assert!(arg0, 115);
        assert!(!is_emergency_inner<T0, T1, T2>(arg1, arg2), 213);
        arg1.emergency_locked = true;
    }

    public fun generate_lp_name<T0, T1>() : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"");
        0x1::string::append_utf8(&mut v0, b"LP-");
        if (is_order<T0, T1>()) {
            0x1::string::append_utf8(&mut v0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())));
            0x1::string::append_utf8(&mut v0, b"-");
            0x1::string::append_utf8(&mut v0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T1>())));
        } else {
            0x1::string::append_utf8(&mut v0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T1>())));
            0x1::string::append_utf8(&mut v0, b"-");
            0x1::string::append_utf8(&mut v0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())));
        };
        v0
    }

    public fun generate_token_name<T0>() : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"");
        0x1::string::append_utf8(&mut v0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())));
        v0
    }

    public fun get_amounts_in<T0, T1>(arg0: &Global, arg1: u64, arg2: bool) : u64 {
        if (arg2) {
            let (v1, v2, _) = get_reserves_size<T0, T1>(get_pool<T0, T1>(arg0, arg2));
            0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::utils::get_amount_in(arg1, v1, v2, arg0.swap_fee)
        } else {
            let (v4, v5, _) = get_reserves_size<T1, T0>(get_pool<T1, T0>(arg0, !arg2));
            0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::utils::get_amount_in(arg1, v4, v5, arg0.swap_fee)
        }
    }

    public fun get_amounts_in_two_pairs<T0, T1, T2>(arg0: &Global, arg1: u64) : u64 {
        let v0 = is_order<T1, T2>();
        let v1 = if (v0) {
            let (v2, v3, _) = get_reserves_size<T1, T2>(get_pool<T1, T2>(arg0, v0));
            0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::utils::get_amount_in(arg1, v2, v3, arg0.swap_fee)
        } else {
            let (v5, v6, _) = get_reserves_size<T2, T1>(get_pool<T2, T1>(arg0, !v0));
            0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::utils::get_amount_in(arg1, v6, v5, arg0.swap_fee)
        };
        let v8 = is_order<T0, T1>();
        if (v8) {
            let (v10, v11, _) = get_reserves_size<T0, T1>(get_pool<T0, T1>(arg0, v8));
            0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::utils::get_amount_in(v1, v10, v11, arg0.swap_fee)
        } else {
            let (v13, v14, _) = get_reserves_size<T1, T0>(get_pool<T1, T0>(arg0, !v8));
            0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::utils::get_amount_in(v1, v14, v13, arg0.swap_fee)
        }
    }

    public fun get_amounts_out<T0, T1>(arg0: &Global, arg1: u64, arg2: bool) : u64 {
        if (arg2) {
            let (v1, v2, _) = get_reserves_size<T0, T1>(get_pool<T0, T1>(arg0, arg2));
            0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::utils::get_amount_out(arg1, v1, v2, arg0.swap_fee)
        } else {
            let (v4, v5, _) = get_reserves_size<T1, T0>(get_pool<T1, T0>(arg0, !arg2));
            0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::utils::get_amount_out(arg1, v4, v5, arg0.swap_fee)
        }
    }

    public fun get_mut_pool<T0, T1>(arg0: &mut Global, arg1: bool) : &mut Pool<T0, T1> {
        assert!(arg1, 115);
        let v0 = generate_lp_name<T0, T1>();
        assert!(0x2::bag::contains_with_type<0x1::string::String, Pool<T0, T1>>(&arg0.pools, v0), 111);
        0x2::bag::borrow_mut<0x1::string::String, Pool<T0, T1>>(&mut arg0.pools, v0)
    }

    public fun get_pause_status(arg0: &Global) : bool {
        arg0.pause
    }

    public fun get_pending_user_rewards<T0, T1, T2>(arg0: &StakePool<T0, T1, T2>, arg1: address, arg2: u64) : u64 {
        assert!(0x2::table::contains<address, UserStake>(&arg0.stakes, arg1), 203);
        let v0 = 0x2::table::borrow<address, UserStake>(&arg0.stakes, arg1);
        v0.earned_reward + (user_earned_since_last_update(arg0.accum_reward + accum_rewards_since_last_updated<T0, T1, T2>(arg0, get_time_for_last_update<T0, T1, T2>(arg0, arg2)), arg0.scale, v0) as u64)
    }

    public fun get_pool<T0, T1>(arg0: &Global, arg1: bool) : &Pool<T0, T1> {
        assert!(arg1, 115);
        let v0 = generate_lp_name<T0, T1>();
        assert!(0x2::bag::contains_with_type<0x1::string::String, Pool<T0, T1>>(&arg0.pools, v0), 111);
        0x2::bag::borrow<0x1::string::String, Pool<T0, T1>>(&arg0.pools, v0)
    }

    public fun get_pool_fee<T0, T1>(arg0: &Global) : (u64, u64) {
        let v0 = is_order<T0, T1>();
        assert!(v0, 115);
        let v1 = get_pool<T0, T1>(arg0, v0);
        (0x2::balance::value<T0>(&v1.coin_a_fee), 0x2::balance::value<T1>(&v1.coin_b_fee))
    }

    public fun get_reserves_size<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64, u64) {
        (0x2::balance::value<T0>(&arg0.coin_a), 0x2::balance::value<T1>(&arg0.coin_b), 0x2::balance::supply_value<LP<T0, T1>>(&arg0.lp_supply))
    }

    public fun get_swap_fee(arg0: &Global) : u64 {
        arg0.swap_fee
    }

    fun get_time_for_last_update<T0, T1, T2>(arg0: &StakePool<T0, T1, T2>, arg1: u64) : u64 {
        (0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::math::min((arg0.end_timestamp as u128), ((arg1 / 1000) as u128)) as u64)
    }

    public fun harvest<T0, T1, T2>(arg0: &mut StakePool<T0, T1, T2>, arg1: &Global, arg2: bool, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        assert!(arg2, 115);
        assert!(!is_emergency_inner<T0, T1, T2>(arg0, arg1), 213);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::table::contains<address, UserStake>(&arg0.stakes, v0), 203);
        update_accum_reward<T0, T1, T2>(arg0, arg3);
        let v1 = 0x2::table::borrow_mut<address, UserStake>(&mut arg0.stakes, v0);
        update_user_earnings(arg0.accum_reward, arg0.scale, v1);
        let v2 = v1.earned_reward;
        assert!(v2 > 0, 206);
        v1.earned_reward = 0;
        0x2::coin::split<T2>(&mut arg0.reward_coin, v2, arg4)
    }

    public fun has_registered<T0, T1>(arg0: &Global) : bool {
        0x2::bag::contains_with_type<0x1::string::String, Pool<T0, T1>>(&arg0.pools, generate_lp_name<T0, T1>())
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = Global{
            id                 : 0x2::object::new(arg0),
            version            : 1,
            admin              : 0x2::object::id<AdminCap>(&v0),
            pause              : false,
            beneficiary        : @0xf7a8ed42705cf8e6f921cd12b9a2bafff6c7ed55efaa8bbc81259040a0945f51,
            swap_fee           : 30,
            beneficiary_profit : 20,
            pools              : 0x2::bag::new(arg0),
        };
        0x2::transfer::share_object<Global>(v1);
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun internal_swap<T0, T1>(arg0: &mut Global, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: 0x2::balance::Balance<T1>, arg4: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(0x2::balance::value<T0>(&arg1) > 0 || 0x2::balance::value<T1>(&arg3) > 0, 103);
        assert!(arg2 > 0 || arg4 > 0, 104);
        let v0 = get_mut_pool<T0, T1>(arg0, true);
        let (v1, v2, _) = get_reserves_size<T0, T1>(v0);
        assert!(v1 > 0 && v2 > 0, 101);
        0x2::balance::join<T0>(&mut v0.coin_a, arg1);
        0x2::balance::join<T1>(&mut v0.coin_b, arg3);
        let (v4, v5, _) = get_reserves_size<T0, T1>(v0);
        0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::utils::assert_lp_amount_is_increased(v1, v2, v4, v5);
        (0x2::balance::split<T0>(&mut v0.coin_a, arg2), 0x2::balance::split<T1>(&mut v0.coin_b, arg4))
    }

    public fun internal_swap_balance_for_balance<T0, T1>(arg0: &mut Global, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = is_order<T0, T1>();
        assert!(v0, 115);
        let v1 = arg0.swap_fee;
        let v2 = arg0.beneficiary_profit;
        let v3 = get_mut_pool<T0, T1>(arg0, v0);
        let v4 = 0x2::balance::value<T0>(&arg1);
        let v5 = 0x2::balance::value<T1>(&arg2);
        assert!(v4 > 0 && v5 == 0 || v4 == 0 || v4 > 0, 119);
        if (v4 > 0) {
            let (v8, v9, _) = get_reserves_size<T0, T1>(v3);
            0x2::balance::join<T0>(&mut v3.coin_a_fee, 0x2::balance::split<T0>(&mut arg1, 0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::utils::get_fee_to_fundation(v4, v1, v2)));
            internal_swap<T0, T1>(arg0, arg1, 0, arg2, 0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::utils::get_amount_out(v4, v8, v9, v1))
        } else {
            let (v11, v12, _) = get_reserves_size<T0, T1>(v3);
            0x2::balance::join<T1>(&mut v3.coin_b_fee, 0x2::balance::split<T1>(&mut arg2, 0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::utils::get_fee_to_fundation(v5, v1, v2)));
            internal_swap<T0, T1>(arg0, arg1, 0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::utils::get_amount_out(v5, v12, v11, v1), arg2, 0)
        }
    }

    public fun internal_swap_coins_for_coins<T0, T1>(arg0: &mut Global, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1) = internal_swap_balance_for_balance<T0, T1>(arg0, 0x2::coin::into_balance<T0>(arg1), 0x2::coin::into_balance<T1>(arg2));
        (0x2::coin::from_balance<T0>(v0, arg3), 0x2::coin::from_balance<T1>(v1, arg3))
    }

    fun is_emergency_inner<T0, T1, T2>(arg0: &StakePool<T0, T1, T2>, arg1: &Global) : bool {
        arg0.emergency_locked || arg1.pause
    }

    fun is_finished_inner<T0, T1, T2>(arg0: &StakePool<T0, T1, T2>, arg1: u64) : bool {
        arg1 / 1000 >= arg0.end_timestamp
    }

    public fun is_order<T0, T1>() : bool {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        let v2 = 0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::compare::compare<0x1::type_name::TypeName>(&v0, &v1);
        assert!(!0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::compare::is_equal(&v2), 109);
        0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::compare::is_smaller_than(&v2)
    }

    fun lp_pool_total_staked<T0, T1, T2>(arg0: &StakePool<T0, T1, T2>) : u128 {
        (0x2::coin::value<LP<T0, T1>>(&arg0.stake_coin) as u128)
    }

    public(friend) fun pause(arg0: &mut Global) {
        arg0.pause = true;
    }

    public(friend) fun register_lp_pool<T0, T1, T2>(arg0: bool, arg1: 0x2::coin::Coin<T2>, arg2: u64, arg3: u8, arg4: u8, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg0, 115);
        assert!(arg2 > 0, 209);
        let v0 = 0x2::coin::value<T2>(&arg1) / arg2;
        assert!(v0 > 0, 202);
        let v1 = arg5 / 1000;
        let v2 = (arg4 as u128);
        assert!(v2 <= 10, 211);
        let v3 = StakePool<T0, T1, T2>{
            id                        : 0x2::object::new(arg8),
            reward_per_sec            : v0,
            accum_reward              : 0,
            last_updated              : v1,
            start_timestamp           : v1,
            end_timestamp             : v1 + arg2,
            stakes                    : 0x2::table::new<address, UserStake>(arg8),
            stake_coin                : 0x2::coin::zero<LP<T0, T1>>(arg8),
            reward_coin               : arg1,
            scale                     : 0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::math::pow(10, (arg3 as u128)) * 1000000000000 / 0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::math::pow(10, v2),
            emergency_locked          : false,
            duration_unstake_time_sec : arg6 / 1000,
            max_stake                 : arg7,
        };
        0x2::transfer::share_object<StakePool<T0, T1, T2>>(v3);
    }

    public(friend) fun register_pool<T0, T1>(arg0: &mut Global, arg1: bool) {
        assert!(arg1, 115);
        assert!(!has_registered<T0, T1>(arg0), 110);
        let v0 = LP<T0, T1>{dummy_field: false};
        let v1 = Pool<T0, T1>{
            coin_a        : 0x2::balance::zero<T0>(),
            coin_b        : 0x2::balance::zero<T1>(),
            coin_a_fee    : 0x2::balance::zero<T0>(),
            coin_b_fee    : 0x2::balance::zero<T1>(),
            lp_supply     : 0x2::balance::create_supply<LP<T0, T1>>(v0),
            min_liquidity : 0x2::balance::zero<LP<T0, T1>>(),
        };
        0x2::bag::add<0x1::string::String, Pool<T0, T1>>(&mut arg0.pools, generate_lp_name<T0, T1>(), v1);
    }

    public fun remove_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<LP<T0, T1>>, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(arg2, 115);
        let v0 = 0x2::coin::value<LP<T0, T1>>(&arg1);
        assert!(v0 > 0, 100);
        let (v1, v2, v3) = get_reserves_size<T0, T1>(arg0);
        0x2::balance::decrease_supply<LP<T0, T1>>(&mut arg0.lp_supply, 0x2::coin::into_balance<LP<T0, T1>>(arg1));
        (0x2::coin::take<T0>(&mut arg0.coin_a, 0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::math::mul_div_u64(v1, v0, v3), arg3), 0x2::coin::take<T1>(&mut arg0.coin_b, 0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::math::mul_div_u64(v2, v0, v3), arg3))
    }

    public(friend) fun resume(arg0: &mut Global) {
        arg0.pause = false;
    }

    public fun return_remaining_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        };
    }

    public fun stake_lp<T0, T1, T2>(arg0: &mut StakePool<T0, T1, T2>, arg1: 0x2::coin::Coin<LP<T0, T1>>, arg2: &Global, arg3: bool, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3, 115);
        let v0 = 0x2::coin::value<LP<T0, T1>>(&arg1);
        assert!(v0 > 0, 205);
        assert!(!is_emergency_inner<T0, T1, T2>(arg0, arg2), 213);
        assert!(!is_finished_inner<T0, T1, T2>(arg0, arg4), 210);
        update_accum_reward<T0, T1, T2>(arg0, arg4);
        let v1 = 0x2::tx_context::sender(arg5);
        let v2 = arg0.accum_reward;
        if (!0x2::table::contains<address, UserStake>(&arg0.stakes, v1)) {
            let v3 = UserStake{
                amount              : v0,
                unobtainable_reward : 0,
                earned_reward       : 0,
                unlock_time         : arg4 / 1000 + arg0.duration_unstake_time_sec,
            };
            v3.unobtainable_reward = v2 * (v0 as u128) / arg0.scale;
            0x2::table::add<address, UserStake>(&mut arg0.stakes, v1, v3);
        } else {
            let v4 = 0x2::table::borrow_mut<address, UserStake>(&mut arg0.stakes, v1);
            update_user_earnings(v2, arg0.scale, v4);
            v4.amount = v4.amount + v0;
            v4.unobtainable_reward = v2 * user_stake_amount(v4) / arg0.scale;
            v4.unlock_time = arg4 / 1000 + arg0.duration_unstake_time_sec;
        };
        assert!(0x2::table::borrow<address, UserStake>(&mut arg0.stakes, v1).amount <= arg0.max_stake, 212);
        0x2::coin::join<LP<T0, T1>>(&mut arg0.stake_coin, arg1);
    }

    public fun unstake_lp<T0, T1, T2>(arg0: &mut StakePool<T0, T1, T2>, arg1: u64, arg2: &Global, arg3: bool, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<LP<T0, T1>> {
        assert!(arg3, 115);
        assert!(arg1 > 0, 205);
        assert!(!is_emergency_inner<T0, T1, T2>(arg0, arg2), 213);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0x2::table::contains<address, UserStake>(&arg0.stakes, v0), 203);
        update_accum_reward<T0, T1, T2>(arg0, arg4);
        let v1 = 0x2::table::borrow_mut<address, UserStake>(&mut arg0.stakes, v0);
        assert!(arg1 <= v1.amount, 204);
        let v2 = arg4 / 1000;
        if (arg0.end_timestamp >= v2) {
            assert!(v2 >= v1.unlock_time, 207);
        };
        update_user_earnings(arg0.accum_reward, arg0.scale, v1);
        v1.amount = v1.amount - arg1;
        v1.unobtainable_reward = arg0.accum_reward * user_stake_amount(v1) / arg0.scale;
        0x2::coin::split<LP<T0, T1>>(&mut arg0.stake_coin, arg1, arg5)
    }

    fun update_accum_reward<T0, T1, T2>(arg0: &mut StakePool<T0, T1, T2>, arg1: u64) {
        let v0 = get_time_for_last_update<T0, T1, T2>(arg0, arg1);
        let v1 = accum_rewards_since_last_updated<T0, T1, T2>(arg0, v0);
        arg0.last_updated = v0;
        if (v1 != 0) {
            arg0.accum_reward = arg0.accum_reward + v1;
        };
    }

    fun update_user_earnings(arg0: u128, arg1: u128, arg2: &mut UserStake) {
        let v0 = user_earned_since_last_update(arg0, arg1, arg2);
        arg2.earned_reward = arg2.earned_reward + (v0 as u64);
        arg2.unobtainable_reward = arg2.unobtainable_reward + v0;
    }

    fun user_earned_since_last_update(arg0: u128, arg1: u128, arg2: &UserStake) : u128 {
        arg0 * user_stake_amount(arg2) / arg1 - arg2.unobtainable_reward
    }

    fun user_stake_amount(arg0: &UserStake) : u128 {
        (arg0.amount as u128)
    }

    // decompiled from Move bytecode v6
}

