module 0xdd250dfa7be43f91126c8bf3ed6ee4c6d2a1a3a026593975256e3f5613d05d15::swap {
    struct LP<phantom T0, phantom T1> has drop, store {
        dummy_field: bool,
    }

    struct Pool<phantom T0, phantom T1> has store {
        global: 0x2::object::ID,
        coin_x: 0x2::balance::Balance<T0>,
        fee_coin_x: 0x2::balance::Balance<T0>,
        coin_y: 0x2::balance::Balance<T1>,
        fee_coin_y: 0x2::balance::Balance<T1>,
        lp_supply: 0x2::balance::Supply<LP<T0, T1>>,
        min_liquidity: 0x2::balance::Balance<LP<T0, T1>>,
    }

    struct Global has key {
        id: 0x2::object::UID,
        has_paused: bool,
        controller: address,
        beneficiary: address,
    }

    struct Fees has key {
        id: 0x2::object::UID,
        fee_stores: 0x2::bag::Bag,
    }

    struct Pools has key {
        id: 0x2::object::UID,
        pools: 0x2::bag::Bag,
    }

    public entry fun swap<T0, T1>(arg0: &mut Global, arg1: &mut Pools, arg2: &mut Fees, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!is_emergency(arg0), 102);
        let v0 = swap_out<T0, T1>(arg1, arg2, arg3, arg4, is_order<T0, T1>(), arg5);
        0xdd250dfa7be43f91126c8bf3ed6ee4c6d2a1a3a026593975256e3f5613d05d15::event::swapped_event(id<T0, T1>(arg0), generate_lp_name<T0, T1>(), 0x1::vector::pop_back<u64>(&mut v0), 0x1::vector::pop_back<u64>(&mut v0), 0x1::vector::pop_back<u64>(&mut v0), 0x1::vector::pop_back<u64>(&mut v0));
    }

    public entry fun add_can_add_lp<T0, T1>(arg0: &mut Fees, arg1: address, arg2: &0x2::coin::TreasuryCap<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        0xdd250dfa7be43f91126c8bf3ed6ee4c6d2a1a3a026593975256e3f5613d05d15::fee::add_can_add_lp<T0, T1>(get_mut_fee_store<T0>(arg0), arg1);
    }

    public entry fun add_fee_exempt<T0, T1>(arg0: &mut Fees, arg1: address, arg2: &0x2::coin::TreasuryCap<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        0xdd250dfa7be43f91126c8bf3ed6ee4c6d2a1a3a026593975256e3f5613d05d15::fee::add_fee_exempt<T0, T1>(get_mut_fee_store<T0>(arg0), arg1);
    }

    fun distribute_fee<T0>(arg0: &mut Pools, arg1: &mut 0xdd250dfa7be43f91126c8bf3ed6ee4c6d2a1a3a026593975256e3f5613d05d15::fee::FeeStore<T0>, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xdd250dfa7be43f91126c8bf3ed6ee4c6d2a1a3a026593975256e3f5613d05d15::fee::pool_balance<T0>(arg1);
        if (v0 > 0) {
            let v1 = 0xdd250dfa7be43f91126c8bf3ed6ee4c6d2a1a3a026593975256e3f5613d05d15::fee::get_fee<T0>(arg2, arg1);
            let (v2, v3, v4, v5) = 0xdd250dfa7be43f91126c8bf3ed6ee4c6d2a1a3a026593975256e3f5613d05d15::fee::get_fee_amount<T0>(arg1, v0, v1);
            let v6 = 0x2::coin::from_balance<T0>(v5, arg3);
            let v7 = swap_back<T0, 0x2::sui::SUI>(arg0, v6, arg3);
            0xdd250dfa7be43f91126c8bf3ed6ee4c6d2a1a3a026593975256e3f5613d05d15::fee::distribute_fee<T0>(arg1, v1, v2, v3, v4, v7, arg3);
        };
    }

    public fun get_fee_amount<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.fee_coin_x), 0x2::balance::value<T1>(&arg0.fee_coin_y))
    }

    public entry fun lottery_jackpot<T0>(arg0: &mut Fees, arg1: &0x2::clock::Clock, arg2: &0x2::coin::TreasuryCap<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        0xdd250dfa7be43f91126c8bf3ed6ee4c6d2a1a3a026593975256e3f5613d05d15::fee::lottery_jackpot<T0>(arg1, get_mut_fee_store<T0>(arg0), arg3);
    }

    public entry fun update_jackpot_bonus<T0>(arg0: &mut Fees, arg1: u64, arg2: u64, arg3: &0x2::coin::TreasuryCap<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0xdd250dfa7be43f91126c8bf3ed6ee4c6d2a1a3a026593975256e3f5613d05d15::fee::update_jackpot_bonus<T0>(get_mut_fee_store<T0>(arg0), arg1, arg2);
    }

    public entry fun update_price<T0>(arg0: &mut Fees, arg1: &0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::state::State, arg2: &0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_info::PriceInfoObject, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xdd250dfa7be43f91126c8bf3ed6ee4c6d2a1a3a026593975256e3f5613d05d15::fee::update_price<T0>(get_mut_fee_store<T0>(arg0), arg1, arg2, arg3);
    }

    public entry fun update_whitelist<T0, T1>(arg0: &mut Fees, arg1: bool, arg2: bool, arg3: &0x2::coin::TreasuryCap<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0xdd250dfa7be43f91126c8bf3ed6ee4c6d2a1a3a026593975256e3f5613d05d15::fee::update_whitelist<T0, T1>(get_mut_fee_store<T0>(arg0), arg1, arg2);
    }

    public entry fun add_liquidity<T0, T1>(arg0: &mut Global, arg1: &mut Pools, arg2: &mut Fees, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!is_emergency(arg0), 102);
        let v0 = is_order<T0, T1>();
        let v1 = has_registered<T0, T1>(arg1);
        if (!v1) {
            register_pool<T0, T1>(arg0, arg1, v0);
        };
        let (v2, v3) = add_liquidity_internal<T0, T1>(arg2, arg1, arg3, arg4, arg5, arg6, v0, arg7);
        let v4 = v3;
        assert!(0x1::vector::length<u64>(&v4) == 3, 104);
        0x2::transfer::public_transfer<0x2::coin::Coin<LP<T0, T1>>>(v2, 0x2::tx_context::sender(arg7));
        0xdd250dfa7be43f91126c8bf3ed6ee4c6d2a1a3a026593975256e3f5613d05d15::event::added_event(global_id<T0, T1>(get_pool<T0, T1>(arg1, v0)), generate_lp_name<T0, T1>(), 0x1::vector::pop_back<u64>(&mut v4), 0x1::vector::pop_back<u64>(&mut v4), 0x1::vector::pop_back<u64>(&mut v4));
    }

    fun add_liquidity_internal<T0, T1>(arg0: &mut Fees, arg1: &mut Pools, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<LP<T0, T1>>, vector<u64>) {
        assert!(arg6, 12);
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = 0x2::coin::value<T1>(&arg4);
        assert!(v0 > 0 && v1 > 0, 0);
        let v2 = 0x2::coin::into_balance<T0>(arg2);
        let v3 = 0x2::coin::into_balance<T1>(arg4);
        let (v4, v5, v6) = get_reserves_size<T0, T1>(get_pool<T0, T1>(arg1, arg6));
        let (v7, v8) = calc_optimal_coin_values(v0, v1, arg3, arg5, v4, v5);
        let v9 = if (0 == v6) {
            let v10 = 0xdd250dfa7be43f91126c8bf3ed6ee4c6d2a1a3a026593975256e3f5613d05d15::math::sqrt(0xdd250dfa7be43f91126c8bf3ed6ee4c6d2a1a3a026593975256e3f5613d05d15::math::mul_to_u128(v7, v8));
            assert!(v10 > 1000, 8);
            let v11 = get_mut_pool<T0, T1>(arg1, arg6);
            0x2::balance::join<LP<T0, T1>>(&mut v11.min_liquidity, 0x2::balance::increase_supply<LP<T0, T1>>(&mut v11.lp_supply, 1000));
            v10 - 1000
        } else {
            let v12 = (v6 as u128) * (v7 as u128) / (v4 as u128);
            let v13 = (v6 as u128) * (v8 as u128) / (v5 as u128);
            if (v12 < v13) {
                assert!(v12 < (18446744073709551615 as u128), 13);
                (v12 as u64)
            } else {
                assert!(v13 < (18446744073709551615 as u128), 13);
                (v13 as u64)
            }
        };
        assert!(v9 > 0, 15);
        if (v7 < v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v2, v0 - v7), arg7), 0x2::tx_context::sender(arg7));
        };
        if (v8 < v1) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v3, v1 - v8), arg7), 0x2::tx_context::sender(arg7));
        };
        let v14 = if (is_fee_store_existed<T0>(arg0)) {
            let v15 = 0x2::coin::from_balance<T0>(v2, arg7);
            let v16 = get_mut_fee_store<T0>(arg0);
            into_balance_check_fee<T0, T1>(arg1, v16, v15, true, arg7)
        } else {
            v2
        };
        v2 = v14;
        let v17 = if (is_fee_store_existed<T1>(arg0)) {
            let v18 = get_mut_fee_store<T1>(arg0);
            let v19 = 0x2::coin::from_balance<T1>(v3, arg7);
            into_balance_check_fee<T1, T0>(arg1, v18, v19, true, arg7)
        } else {
            v3
        };
        v3 = v17;
        let v20 = get_mut_pool<T0, T1>(arg1, arg6);
        assert!(0x2::balance::join<T0>(&mut v20.coin_x, v2) < 1844674407370955, 2);
        assert!(0x2::balance::join<T1>(&mut v20.coin_y, v3) < 1844674407370955, 2);
        let v21 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v21, v0);
        0x1::vector::push_back<u64>(&mut v21, v1);
        0x1::vector::push_back<u64>(&mut v21, v9);
        (0x2::coin::from_balance<LP<T0, T1>>(0x2::balance::increase_supply<LP<T0, T1>>(&mut v20.lp_supply, v9), arg7), v21)
    }

    public fun assert_lp_value_is_increased(arg0: u64, arg1: u64, arg2: u64, arg3: u64) {
        assert!((arg0 as u128) * (arg1 as u128) < (arg2 as u128) * (arg3 as u128), 14);
    }

    public(friend) fun beneficiary(arg0: &Global) : address {
        arg0.beneficiary
    }

    public fun calc_optimal_coin_values(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : (u64, u64) {
        if (arg4 == 0 && arg5 == 0) {
            return (arg0, arg1)
        };
        let v0 = 0xdd250dfa7be43f91126c8bf3ed6ee4c6d2a1a3a026593975256e3f5613d05d15::math::mul_div(arg0, arg5, arg4);
        if (v0 <= arg1) {
            assert!(v0 >= arg3, 4);
            return (arg0, v0)
        };
        let v1 = 0xdd250dfa7be43f91126c8bf3ed6ee4c6d2a1a3a026593975256e3f5613d05d15::math::mul_div(arg1, arg4, arg5);
        assert!(v1 <= arg0, 6);
        assert!(v1 >= arg2, 3);
        (v1, arg1)
    }

    public(friend) fun controller(arg0: &Global) : address {
        arg0.controller
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

    public fun get_amount_out(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg0 as u128) * ((10000 - 30) as u128);
        0xdd250dfa7be43f91126c8bf3ed6ee4c6d2a1a3a026593975256e3f5613d05d15::math::mul_div_u128(v0, (arg2 as u128), (arg1 as u128) * (10000 as u128) + v0)
    }

    public fun get_fee_store<T0>(arg0: &Fees) : &0xdd250dfa7be43f91126c8bf3ed6ee4c6d2a1a3a026593975256e3f5613d05d15::fee::FeeStore<T0> {
        assert!(is_fee_store_existed<T0>(arg0), 16);
        0x2::bag::borrow<0x1::ascii::String, 0xdd250dfa7be43f91126c8bf3ed6ee4c6d2a1a3a026593975256e3f5613d05d15::fee::FeeStore<T0>>(&arg0.fee_stores, 0xdd250dfa7be43f91126c8bf3ed6ee4c6d2a1a3a026593975256e3f5613d05d15::utils::get_type_name_str<T0>())
    }

    public fun get_fee_to_fundation(arg0: u64) : u64 {
        0xdd250dfa7be43f91126c8bf3ed6ee4c6d2a1a3a026593975256e3f5613d05d15::math::mul_div(arg0, 30 / 5, 10000)
    }

    fun get_mut_fee_store<T0>(arg0: &mut Fees) : &mut 0xdd250dfa7be43f91126c8bf3ed6ee4c6d2a1a3a026593975256e3f5613d05d15::fee::FeeStore<T0> {
        assert!(is_fee_store_existed<T0>(arg0), 16);
        0x2::bag::borrow_mut<0x1::ascii::String, 0xdd250dfa7be43f91126c8bf3ed6ee4c6d2a1a3a026593975256e3f5613d05d15::fee::FeeStore<T0>>(&mut arg0.fee_stores, 0xdd250dfa7be43f91126c8bf3ed6ee4c6d2a1a3a026593975256e3f5613d05d15::utils::get_type_name_str<T0>())
    }

    public(friend) fun get_mut_pool<T0, T1>(arg0: &mut Pools, arg1: bool) : &mut Pool<T0, T1> {
        assert!(arg1, 12);
        let v0 = generate_lp_name<T0, T1>();
        assert!(0x2::bag::contains_with_type<0x1::string::String, Pool<T0, T1>>(&arg0.pools, v0), 11);
        0x2::bag::borrow_mut<0x1::string::String, Pool<T0, T1>>(&mut arg0.pools, v0)
    }

    fun get_mut_pool_and_fee_store<T0, T1, T2>(arg0: &mut Pools, arg1: &mut Fees, arg2: bool) : (&mut Pool<T0, T1>, &mut 0xdd250dfa7be43f91126c8bf3ed6ee4c6d2a1a3a026593975256e3f5613d05d15::fee::FeeStore<T2>) {
        (get_mut_pool<T0, T1>(arg0, arg2), get_mut_fee_store<T2>(arg1))
    }

    fun get_pool<T0, T1>(arg0: &Pools, arg1: bool) : &Pool<T0, T1> {
        assert!(arg1, 12);
        let v0 = generate_lp_name<T0, T1>();
        assert!(0x2::bag::contains_with_type<0x1::string::String, Pool<T0, T1>>(&arg0.pools, v0), 11);
        0x2::bag::borrow<0x1::string::String, Pool<T0, T1>>(&arg0.pools, v0)
    }

    public fun get_quote<T0, T1>(arg0: &Pools, arg1: u64) : u64 {
        let v0 = is_order<T0, T1>();
        if (v0) {
            let (v2, v3, _) = get_reserves_size<T0, T1>(get_pool<T0, T1>(arg0, v0));
            assert!(v2 > 0 && v3 > 0, 1);
            get_amount_out(arg1, v2, v3)
        } else {
            let (v5, v6, _) = get_reserves_size<T1, T0>(get_pool<T1, T0>(arg0, !v0));
            assert!(v5 > 0 && v6 > 0, 1);
            get_amount_out(arg1, v6, v5)
        }
    }

    public fun get_reserves<T0, T1>(arg0: &Pools) : (u64, u64, u64) {
        let v0 = get_pool<T0, T1>(arg0, is_order<T0, T1>());
        (0x2::balance::value<T0>(&v0.coin_x), 0x2::balance::value<T1>(&v0.coin_y), 0x2::balance::supply_value<LP<T0, T1>>(&v0.lp_supply))
    }

    public fun get_reserves_size<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64, u64) {
        (0x2::balance::value<T0>(&arg0.coin_x), 0x2::balance::value<T1>(&arg0.coin_y), 0x2::balance::supply_value<LP<T0, T1>>(&arg0.lp_supply))
    }

    fun get_sui_amount<T0>(arg0: u64, arg1: &Pools) : u64 {
        let v0 = is_order<0x2::sui::SUI, T0>();
        if (v0) {
            let (v2, v3, _) = get_reserves_size<0x2::sui::SUI, T0>(get_pool<0x2::sui::SUI, T0>(arg1, v0));
            if (v2 > 0) {
                0xdd250dfa7be43f91126c8bf3ed6ee4c6d2a1a3a026593975256e3f5613d05d15::math::mul_div(arg0, v3, v2)
            } else {
                0
            }
        } else {
            let (v5, v6, _) = get_reserves_size<0x2::sui::SUI, T0>(get_pool<0x2::sui::SUI, T0>(arg1, v0));
            if (v6 > 0) {
                0xdd250dfa7be43f91126c8bf3ed6ee4c6d2a1a3a026593975256e3f5613d05d15::math::mul_div(arg0, v5, v6)
            } else {
                0
            }
        }
    }

    public fun global_id<T0, T1>(arg0: &Pool<T0, T1>) : 0x2::object::ID {
        arg0.global
    }

    fun has_registered<T0, T1>(arg0: &mut Pools) : bool {
        0x2::bag::contains_with_type<0x1::string::String, Pool<T0, T1>>(&arg0.pools, generate_lp_name<T0, T1>())
    }

    fun id<T0, T1>(arg0: &Global) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Global{
            id          : 0x2::object::new(arg0),
            has_paused  : false,
            controller  : @0xc1ff6d7a02d14cb152597dada79920ff4f5cab64e4beb104ebd84141923e8d85,
            beneficiary : @0xc1ff6d7a02d14cb152597dada79920ff4f5cab64e4beb104ebd84141923e8d85,
        };
        let v1 = Fees{
            id         : 0x2::object::new(arg0),
            fee_stores : 0x2::bag::new(arg0),
        };
        let v2 = Pools{
            id    : 0x2::object::new(arg0),
            pools : 0x2::bag::new(arg0),
        };
        0x2::transfer::share_object<Global>(v0);
        0x2::transfer::share_object<Fees>(v1);
        0x2::transfer::share_object<Pools>(v2);
    }

    fun into_balance_check_fee<T0, T1>(arg0: &mut Pools, arg1: &mut 0xdd250dfa7be43f91126c8bf3ed6ee4c6d2a1a3a026593975256e3f5613d05d15::fee::FeeStore<T0>, arg2: 0x2::coin::Coin<T0>, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        if (0xdd250dfa7be43f91126c8bf3ed6ee4c6d2a1a3a026593975256e3f5613d05d15::fee::should_take_fee<T0, T1>(0x2::tx_context::sender(arg4), arg1)) {
            let (v1, _) = 0xdd250dfa7be43f91126c8bf3ed6ee4c6d2a1a3a026593975256e3f5613d05d15::fee::take_fee<T0>(arg2, get_sui_amount<T0>(0x2::coin::value<T0>(&arg2), arg0), arg3, arg1, arg4);
            distribute_fee<T0>(arg0, arg1, arg3, arg4);
            0x2::coin::into_balance<T0>(v1)
        } else {
            0x2::coin::into_balance<T0>(arg2)
        }
    }

    public(friend) fun is_emergency(arg0: &Global) : bool {
        arg0.has_paused
    }

    fun is_fee_store_existed<T0>(arg0: &Fees) : bool {
        0x2::bag::contains_with_type<0x1::ascii::String, 0xdd250dfa7be43f91126c8bf3ed6ee4c6d2a1a3a026593975256e3f5613d05d15::fee::FeeStore<T0>>(&arg0.fee_stores, 0xdd250dfa7be43f91126c8bf3ed6ee4c6d2a1a3a026593975256e3f5613d05d15::utils::get_type_name_str<T0>())
    }

    public fun is_order<T0, T1>() : bool {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        let v2 = 0xdd250dfa7be43f91126c8bf3ed6ee4c6d2a1a3a026593975256e3f5613d05d15::comparator::compare<0x1::type_name::TypeName>(&v0, &v1);
        assert!(!0xdd250dfa7be43f91126c8bf3ed6ee4c6d2a1a3a026593975256e3f5613d05d15::comparator::is_equal(&v2), 9);
        0xdd250dfa7be43f91126c8bf3ed6ee4c6d2a1a3a026593975256e3f5613d05d15::comparator::is_smaller_than(&v2)
    }

    public(friend) fun modify_controller(arg0: &mut Global, arg1: address) {
        arg0.controller = arg1;
    }

    public(friend) fun pause(arg0: &mut Global) {
        arg0.has_paused = true;
    }

    public entry fun register_fee_store<T0>(arg0: &mut Fees, arg1: &0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_info::PriceInfoObject, arg2: &0x2::coin::TreasuryCap<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xdd250dfa7be43f91126c8bf3ed6ee4c6d2a1a3a026593975256e3f5613d05d15::utils::get_type_name_str<T0>();
        assert!(!0x2::bag::contains_with_type<0x1::ascii::String, 0xdd250dfa7be43f91126c8bf3ed6ee4c6d2a1a3a026593975256e3f5613d05d15::fee::FeeStore<T0>>(&mut arg0.fee_stores, v0), 17);
        0x2::bag::add<0x1::ascii::String, 0xdd250dfa7be43f91126c8bf3ed6ee4c6d2a1a3a026593975256e3f5613d05d15::fee::FeeStore<T0>>(&mut arg0.fee_stores, v0, 0xdd250dfa7be43f91126c8bf3ed6ee4c6d2a1a3a026593975256e3f5613d05d15::fee::initialize<T0>(arg1, arg3));
    }

    fun register_pool<T0, T1>(arg0: &mut Global, arg1: &mut Pools, arg2: bool) {
        assert!(arg2, 12);
        let v0 = generate_lp_name<T0, T1>();
        assert!(!0x2::bag::contains_with_type<0x1::string::String, Pool<T0, T1>>(&mut arg1.pools, v0), 10);
        let v1 = LP<T0, T1>{dummy_field: false};
        let v2 = Pool<T0, T1>{
            global        : 0x2::object::uid_to_inner(&arg0.id),
            coin_x        : 0x2::balance::zero<T0>(),
            fee_coin_x    : 0x2::balance::zero<T0>(),
            coin_y        : 0x2::balance::zero<T1>(),
            fee_coin_y    : 0x2::balance::zero<T1>(),
            lp_supply     : 0x2::balance::create_supply<LP<T0, T1>>(v1),
            min_liquidity : 0x2::balance::zero<LP<T0, T1>>(),
        };
        0x2::bag::add<0x1::string::String, Pool<T0, T1>>(&mut arg1.pools, v0, v2);
    }

    public entry fun remove_liquidity<T0, T1>(arg0: &mut Global, arg1: &mut Pools, arg2: &mut Fees, arg3: 0x2::coin::Coin<LP<T0, T1>>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!is_emergency(arg0), 102);
        let v0 = is_order<T0, T1>();
        let v1 = get_mut_pool<T0, T1>(arg1, v0);
        let (v2, v3) = remove_liquidity_internal<T0, T1>(v1, arg3, v0, arg4);
        let v4 = v3;
        let v5 = v2;
        if (is_fee_store_existed<T0>(arg2)) {
            let v6 = get_mut_fee_store<T0>(arg2);
            transfer_check_fee<T0, T1>(arg1, v6, v5, false, arg4);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, 0x2::tx_context::sender(arg4));
        };
        if (is_fee_store_existed<T1>(arg2)) {
            let v7 = get_mut_fee_store<T1>(arg2);
            transfer_check_fee<T1, T0>(arg1, v7, v4, false, arg4);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v4, 0x2::tx_context::sender(arg4));
        };
        0xdd250dfa7be43f91126c8bf3ed6ee4c6d2a1a3a026593975256e3f5613d05d15::event::removed_event(global_id<T0, T1>(get_pool<T0, T1>(arg1, v0)), generate_lp_name<T0, T1>(), 0x2::coin::value<T0>(&v5), 0x2::coin::value<T1>(&v4), 0x2::coin::value<LP<T0, T1>>(&arg3));
    }

    fun remove_liquidity_internal<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<LP<T0, T1>>, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(arg2, 12);
        let v0 = 0x2::coin::value<LP<T0, T1>>(&arg1);
        assert!(v0 > 0, 0);
        let (v1, v2, v3) = get_reserves_size<T0, T1>(arg0);
        0x2::balance::decrease_supply<LP<T0, T1>>(&mut arg0.lp_supply, 0x2::coin::into_balance<LP<T0, T1>>(arg1));
        (0x2::coin::take<T0>(&mut arg0.coin_x, 0xdd250dfa7be43f91126c8bf3ed6ee4c6d2a1a3a026593975256e3f5613d05d15::math::mul_div(v1, v0, v3), arg3), 0x2::coin::take<T1>(&mut arg0.coin_y, 0xdd250dfa7be43f91126c8bf3ed6ee4c6d2a1a3a026593975256e3f5613d05d15::math::mul_div(v2, v0, v3), arg3))
    }

    public(friend) fun resume(arg0: &mut Global) {
        arg0.has_paused = false;
    }

    fun swap_back<T0, T1>(arg0: &mut Pools, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        assert!(0x2::coin::value<T0>(&arg1) > 0, 0);
        let v0 = is_order<T0, T1>();
        if (v0) {
            let v2 = get_mut_pool<T0, T1>(arg0, v0);
            let (v3, v4, _) = get_reserves_size<T0, T1>(v2);
            assert!(v3 > 0 && v4 > 0, 1);
            0x2::balance::join<T0>(&mut v2.coin_x, 0x2::coin::into_balance<T0>(arg1));
            0x2::coin::into_balance<T1>(0x2::coin::take<T1>(&mut v2.coin_y, get_amount_out(0x2::coin::value<T0>(&arg1), v3, v4), arg2))
        } else {
            let v6 = get_mut_pool<T1, T0>(arg0, !v0);
            let (v7, v8, _) = get_reserves_size<T1, T0>(v6);
            assert!(v7 > 0 && v8 > 0, 1);
            0x2::balance::join<T0>(&mut v6.coin_y, 0x2::coin::into_balance<T0>(arg1));
            0x2::coin::into_balance<T1>(0x2::coin::take<T1>(&mut v6.coin_x, get_amount_out(0x2::coin::value<T0>(&arg1), v8, v7), arg2))
        }
    }

    fun swap_out<T0, T1>(arg0: &mut Pools, arg1: &mut Fees, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) : vector<u64> {
        assert!(0x2::coin::value<T0>(&arg2) > 0, 0);
        if (arg4) {
            let (v1, v2, _) = get_reserves_size<T0, T1>(get_pool<T0, T1>(arg0, arg4));
            assert!(v1 > 0 && v2 > 0, 1);
            let v4 = 0x2::coin::value<T0>(&arg2);
            let v5 = get_amount_out(v4, v1, v2);
            assert!(v5 >= arg3, 7);
            let v6 = if (is_fee_store_existed<T0>(arg1)) {
                let v7 = get_mut_fee_store<T0>(arg1);
                into_balance_check_fee<T0, T1>(arg0, v7, arg2, false, arg5)
            } else {
                0x2::coin::into_balance<T0>(arg2)
            };
            let v8 = v6;
            let v9 = get_mut_pool<T0, T1>(arg0, arg4);
            0x2::balance::join<T0>(&mut v9.fee_coin_x, 0x2::balance::split<T0>(&mut v8, get_fee_to_fundation(v4)));
            0x2::balance::join<T0>(&mut v9.coin_x, v8);
            let v10 = 0x2::coin::take<T1>(&mut v9.coin_y, v5, arg5);
            if (is_fee_store_existed<T1>(arg1)) {
                let v11 = get_mut_fee_store<T1>(arg1);
                transfer_check_fee<T1, T0>(arg0, v11, v10, true, arg5);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v10, 0x2::tx_context::sender(arg5));
            };
            let v12 = get_pool<T0, T1>(arg0, arg4);
            if (!is_fee_store_existed<T0>(arg1) && !is_fee_store_existed<T1>(arg1)) {
                let (v13, v14, _) = get_reserves_size<T0, T1>(v12);
                assert_lp_value_is_increased(v1, v2, v13, v14);
            };
            let v16 = 0x1::vector::empty<u64>();
            0x1::vector::push_back<u64>(&mut v16, v4);
            0x1::vector::push_back<u64>(&mut v16, 0);
            0x1::vector::push_back<u64>(&mut v16, 0);
            0x1::vector::push_back<u64>(&mut v16, v5);
            v16
        } else {
            let (v17, v18, _) = get_reserves_size<T1, T0>(get_pool<T1, T0>(arg0, !arg4));
            assert!(v17 > 0 && v18 > 0, 1);
            let v20 = 0x2::coin::value<T0>(&arg2);
            let v21 = get_amount_out(v20, v18, v17);
            assert!(v21 >= arg3, 7);
            let v22 = if (is_fee_store_existed<T0>(arg1)) {
                let v23 = get_mut_fee_store<T0>(arg1);
                into_balance_check_fee<T0, T1>(arg0, v23, arg2, false, arg5)
            } else {
                0x2::coin::into_balance<T0>(arg2)
            };
            let v24 = v22;
            let v25 = get_mut_pool<T1, T0>(arg0, !arg4);
            0x2::balance::join<T0>(&mut v25.fee_coin_y, 0x2::balance::split<T0>(&mut v24, get_fee_to_fundation(v20)));
            0x2::balance::join<T0>(&mut v25.coin_y, v24);
            let v26 = 0x2::coin::take<T1>(&mut v25.coin_x, v21, arg5);
            if (is_fee_store_existed<T1>(arg1)) {
                let v27 = get_mut_fee_store<T1>(arg1);
                transfer_check_fee<T1, T0>(arg0, v27, v26, true, arg5);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v26, 0x2::tx_context::sender(arg5));
            };
            let v28 = get_pool<T1, T0>(arg0, !arg4);
            if (!is_fee_store_existed<T0>(arg1) && !is_fee_store_existed<T1>(arg1)) {
                let (v29, v30, _) = get_reserves_size<T1, T0>(v28);
                assert_lp_value_is_increased(v17, v18, v29, v30);
            };
            let v32 = 0x1::vector::empty<u64>();
            0x1::vector::push_back<u64>(&mut v32, 0);
            0x1::vector::push_back<u64>(&mut v32, v21);
            0x1::vector::push_back<u64>(&mut v32, v20);
            0x1::vector::push_back<u64>(&mut v32, 0);
            v32
        }
    }

    fun transfer_check_fee<T0, T1>(arg0: &mut Pools, arg1: &mut 0xdd250dfa7be43f91126c8bf3ed6ee4c6d2a1a3a026593975256e3f5613d05d15::fee::FeeStore<T0>, arg2: 0x2::coin::Coin<T0>, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = into_balance_check_fee<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg4), 0x2::tx_context::sender(arg4));
    }

    public(friend) fun withdraw<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, u64, u64) {
        let v0 = 0x2::balance::value<T0>(&arg0.fee_coin_x);
        let v1 = 0x2::balance::value<T1>(&arg0.fee_coin_y);
        assert!(v0 > 0 && v1 > 0, 0);
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.fee_coin_x, v0), arg1), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.fee_coin_y, v1), arg1), v0, v1)
    }

    // decompiled from Move bytecode v6
}

