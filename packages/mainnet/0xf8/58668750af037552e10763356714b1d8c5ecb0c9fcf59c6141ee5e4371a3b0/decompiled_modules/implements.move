module 0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::implements {
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

    struct PoolExtraInfo<phantom T0, phantom T1> has store {
        locker: address,
        unlock_at: u64,
        locked_balance: 0x2::balance::Balance<LP<T0, T1>>,
        coin_x_treasuryCap: 0x1::option::Option<0x2::coin::TreasuryCap<T0>>,
        coin_y_treasuryCap: 0x1::option::Option<0x2::coin::TreasuryCap<T1>>,
        max_x_swap_amount: u64,
        max_y_swap_amount: u64,
        slots_1: vector<u256>,
        slots_2: vector<address>,
    }

    struct Global has key {
        id: 0x2::object::UID,
        has_paused: bool,
        controller: address,
        beneficiary: address,
        pools: 0x2::bag::Bag,
        users: 0x2::table::Table<address, UserInfo>,
        update_cd: u64,
        coin_map: 0x2::table::Table<0x1::type_name::TypeName, CoinInfo>,
    }

    struct UserInfo has copy, drop, store {
        point: u64,
        last_update_at: u64,
        update_count: u64,
        extra_point: u256,
    }

    struct CoinInfo has copy, drop, store {
        fees: vector<FeeInfo>,
        total_fee_rate: u64,
    }

    struct FeeInfo has copy, drop, store {
        self_coin_as_fee: bool,
        fee_rate: u64,
        receiver: address,
    }

    public(friend) fun add_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<LP<T0, T1>>, vector<u64>) {
        assert!(arg5, 12);
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = 0x2::coin::value<T1>(&arg3);
        assert!(v0 > 0 && v1 > 0, 0);
        let v2 = 0x2::coin::into_balance<T0>(arg1);
        let v3 = 0x2::coin::into_balance<T1>(arg3);
        let (v4, v5, v6) = get_reserves_size<T0, T1>(arg0);
        let (v7, v8) = calc_optimal_coin_values(v0, v1, arg2, arg4, v4, v5);
        let v9 = if (0 == v6) {
            let v10 = 0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::math::sqrt(0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::math::mul_to_u128(v7, v8));
            assert!(v10 > 1000, 8);
            0x2::balance::join<LP<T0, T1>>(&mut arg0.min_liquidity, 0x2::balance::increase_supply<LP<T0, T1>>(&mut arg0.lp_supply, 1000));
            v10 - 1000
        } else {
            let v11 = (v6 as u128) * (v7 as u128) / (v4 as u128);
            let v12 = (v6 as u128) * (v8 as u128) / (v5 as u128);
            if (v11 < v12) {
                assert!(v11 < (18446744073709551615 as u128), 13);
                (v11 as u64)
            } else {
                assert!(v12 < (18446744073709551615 as u128), 13);
                (v12 as u64)
            }
        };
        assert!(v9 > 0, 15);
        if (v7 < v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v2, v0 - v7), arg6), 0x2::tx_context::sender(arg6));
        };
        if (v8 < v1) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v3, v1 - v8), arg6), 0x2::tx_context::sender(arg6));
        };
        assert!(0x2::balance::join<T0>(&mut arg0.coin_x, v2) < 1844674407370955, 2);
        assert!(0x2::balance::join<T1>(&mut arg0.coin_y, v3) < 1844674407370955, 2);
        let v13 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v13, v0);
        0x1::vector::push_back<u64>(&mut v13, v1);
        0x1::vector::push_back<u64>(&mut v13, v9);
        (0x2::coin::from_balance<LP<T0, T1>>(0x2::balance::increase_supply<LP<T0, T1>>(&mut arg0.lp_supply, v9), arg6), v13)
    }

    public(friend) fun add_points(arg0: &mut Global, arg1: &0x2::clock::Clock, arg2: address, arg3: u64) {
        if (!0x2::table::contains<address, UserInfo>(&mut arg0.users, arg2)) {
            let v0 = UserInfo{
                point          : 0,
                last_update_at : 0,
                update_count   : 0,
                extra_point    : 0,
            };
            0x2::table::add<address, UserInfo>(&mut arg0.users, arg2, v0);
        };
        let v1 = 0x2::table::borrow_mut<address, UserInfo>(&mut arg0.users, arg2);
        v1.point = v1.point + arg3;
        v1.last_update_at = 0x2::clock::timestamp_ms(arg1) / 1000;
        if (arg0.update_cd == 0) {
            arg0.update_cd = 448465;
        };
        arg0.update_cd = arg0.update_cd + arg3;
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
        let v0 = 0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::math::mul_div(arg0, arg5, arg4);
        if (v0 <= arg1) {
            assert!(v0 >= arg3, 4);
            return (arg0, v0)
        };
        let v1 = 0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::math::mul_div(arg1, arg4, arg5);
        assert!(v1 <= arg0, 6);
        assert!(v1 >= arg2, 3);
        (v1, arg1)
    }

    public(friend) fun controller(arg0: &Global) : address {
        arg0.controller
    }

    public fun generate_lp_extra_name<T0, T1>() : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"");
        0x1::string::append_utf8(&mut v0, b"extra-LP-");
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
        0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::math::mul_div_u128(v0, (arg2 as u128), (arg1 as u128) * (10000 as u128) + v0)
    }

    public fun get_fee_amount<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.fee_coin_x), 0x2::balance::value<T1>(&arg0.fee_coin_y))
    }

    public fun get_fee_to_fundation(arg0: u64) : u64 {
        let v0 = 25;
        assert!(v0 <= 30, 16);
        0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::math::mul_div(arg0, v0, 10000)
    }

    public fun get_lock_info<T0, T1>(arg0: &Global) : (address, u64, u64) {
        let v0 = 0x2::bag::borrow<0x1::string::String, PoolExtraInfo<T0, T1>>(&arg0.pools, generate_lp_extra_name<T0, T1>());
        (v0.locker, v0.unlock_at, 0x2::balance::value<LP<T0, T1>>(&v0.locked_balance))
    }

    public(friend) fun get_mut_pool<T0, T1>(arg0: &mut Global, arg1: bool) : &mut Pool<T0, T1> {
        assert!(arg1, 12);
        let v0 = generate_lp_name<T0, T1>();
        assert!(0x2::bag::contains_with_type<0x1::string::String, Pool<T0, T1>>(&arg0.pools, v0), 11);
        0x2::bag::borrow_mut<0x1::string::String, Pool<T0, T1>>(&mut arg0.pools, v0)
    }

    public fun get_reserves_size<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64, u64) {
        (0x2::balance::value<T0>(&arg0.coin_x), 0x2::balance::value<T1>(&arg0.coin_y), 0x2::balance::supply_value<LP<T0, T1>>(&arg0.lp_supply))
    }

    public fun global_id<T0, T1>(arg0: &Pool<T0, T1>) : 0x2::object::ID {
        arg0.global
    }

    public(friend) fun has_registered<T0, T1>(arg0: &Global) : bool {
        0x2::bag::contains_with_type<0x1::string::String, Pool<T0, T1>>(&arg0.pools, generate_lp_name<T0, T1>())
    }

    public(friend) fun id<T0, T1>(arg0: &Global) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Global{
            id          : 0x2::object::new(arg0),
            has_paused  : false,
            controller  : @0x41db77874ed08f9997ed00770a2cb0ca83aa3b81d3a50330cd809237bbd76553,
            beneficiary : @0x41db77874ed08f9997ed00770a2cb0ca83aa3b81d3a50330cd809237bbd76553,
            pools       : 0x2::bag::new(arg0),
            users       : 0x2::table::new<address, UserInfo>(arg0),
            update_cd   : 0,
            coin_map    : 0x2::table::new<0x1::type_name::TypeName, CoinInfo>(arg0),
        };
        0x2::transfer::share_object<Global>(v0);
    }

    public(friend) fun is_emergency(arg0: &Global) : bool {
        arg0.has_paused
    }

    public fun is_order<T0, T1>() : bool {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        let v2 = 0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::comparator::compare<0x1::type_name::TypeName>(&v0, &v1);
        assert!(!0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::comparator::is_equal(&v2), 9);
        0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::comparator::is_smaller_than(&v2)
    }

    public(friend) fun lock_liquidity<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut Global, arg2: 0x2::coin::Coin<LP<T0, T1>>, arg3: bool, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3, 12);
        assert!(0x2::coin::value<LP<T0, T1>>(&arg2) > 0, 0);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = generate_lp_extra_name<T0, T1>();
        if (!0x2::bag::contains_with_type<0x1::string::String, PoolExtraInfo<T0, T1>>(&arg1.pools, v1)) {
            let v2 = PoolExtraInfo<T0, T1>{
                locker             : v0,
                unlock_at          : 0x2::clock::timestamp_ms(arg0) / 1000,
                locked_balance     : 0x2::balance::zero<LP<T0, T1>>(),
                coin_x_treasuryCap : 0x1::option::none<0x2::coin::TreasuryCap<T0>>(),
                coin_y_treasuryCap : 0x1::option::none<0x2::coin::TreasuryCap<T1>>(),
                max_x_swap_amount  : 18446744073709551615,
                max_y_swap_amount  : 18446744073709551615,
                slots_1            : 0x1::vector::empty<u256>(),
                slots_2            : 0x1::vector::empty<address>(),
            };
            0x2::bag::add<0x1::string::String, PoolExtraInfo<T0, T1>>(&mut arg1.pools, v1, v2);
        };
        let v3 = 0x2::bag::borrow_mut<0x1::string::String, PoolExtraInfo<T0, T1>>(&mut arg1.pools, v1);
        assert!(v0 == v3.locker, 18);
        v3.unlock_at = v3.unlock_at + arg4;
        0x2::balance::join<LP<T0, T1>>(&mut v3.locked_balance, 0x2::coin::into_balance<LP<T0, T1>>(arg2));
    }

    public(friend) fun modify_controller(arg0: &mut Global, arg1: address) {
        arg0.controller = arg1;
    }

    public(friend) fun pause(arg0: &mut Global) {
        arg0.has_paused = true;
    }

    public(friend) fun register_pool<T0, T1>(arg0: &mut Global, arg1: bool) {
        assert!(arg1, 12);
        let v0 = generate_lp_name<T0, T1>();
        assert!(!0x2::bag::contains_with_type<0x1::string::String, Pool<T0, T1>>(&arg0.pools, v0), 10);
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
        0x2::bag::add<0x1::string::String, Pool<T0, T1>>(&mut arg0.pools, v0, v2);
    }

    public(friend) fun remove_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<LP<T0, T1>>, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(arg2, 12);
        let v0 = 0x2::coin::value<LP<T0, T1>>(&arg1);
        assert!(v0 > 0, 0);
        let (v1, v2, v3) = get_reserves_size<T0, T1>(arg0);
        0x2::balance::decrease_supply<LP<T0, T1>>(&mut arg0.lp_supply, 0x2::coin::into_balance<LP<T0, T1>>(arg1));
        (0x2::coin::take<T0>(&mut arg0.coin_x, 0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::math::mul_div(v1, v0, v3), arg3), 0x2::coin::take<T1>(&mut arg0.coin_y, 0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::math::mul_div(v2, v0, v3), arg3))
    }

    public(friend) fun resume(arg0: &mut Global) {
        arg0.has_paused = false;
    }

    public(friend) fun set_swap_fee<T0>(arg0: &mut Global, arg1: vector<address>, arg2: vector<u64>) {
        assert!(0x1::vector::length<address>(&arg1) == 0x1::vector::length<u64>(&arg2), 19);
        let v0 = 0x1::type_name::get<T0>();
        assert!(!0x2::table::contains<0x1::type_name::TypeName, CoinInfo>(&arg0.coin_map, v0), 21);
        let v1 = 0;
        let v2 = 0x1::vector::empty<FeeInfo>();
        let v3 = 0;
        while (v3 < 0x1::vector::length<address>(&arg1)) {
            let v4 = FeeInfo{
                self_coin_as_fee : false,
                fee_rate         : *0x1::vector::borrow<u64>(&arg2, v3),
                receiver         : *0x1::vector::borrow<address>(&arg1, v3),
            };
            v1 = v1 + v4.fee_rate;
            0x1::vector::insert<FeeInfo>(&mut v2, v4, v3);
            v3 = v3 + 1;
        };
        assert!(v1 <= 3000, 20);
        if (!0x2::table::contains<0x1::type_name::TypeName, CoinInfo>(&arg0.coin_map, v0)) {
            let v5 = CoinInfo{
                fees           : v2,
                total_fee_rate : v1,
            };
            0x2::table::add<0x1::type_name::TypeName, CoinInfo>(&mut arg0.coin_map, v0, v5);
        } else {
            let v6 = 0x2::table::borrow_mut<0x1::type_name::TypeName, CoinInfo>(&mut arg0.coin_map, v0);
            v6.fees = v2;
            v6.total_fee_rate = v1;
        };
    }

    public(friend) fun swap_out<T0, T1>(arg0: &mut Global, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) : vector<u64> {
        assert!(0x2::coin::value<T0>(&arg1) > 0, 0);
        if (arg3) {
            let v1 = get_mut_pool<T0, T1>(arg0, arg3);
            let (v2, v3, _) = get_reserves_size<T0, T1>(v1);
            assert!(v2 > 0 && v3 > 0, 1);
            let v5 = 0x2::coin::value<T0>(&arg1);
            let v6 = get_amount_out(v5, v2, v3);
            assert!(v6 >= arg2, 7);
            let v7 = 0x2::coin::into_balance<T0>(arg1);
            0x2::balance::join<T0>(&mut v1.fee_coin_x, 0x2::balance::split<T0>(&mut v7, get_fee_to_fundation(v5)));
            0x2::balance::join<T0>(&mut v1.coin_x, v7);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut v1.coin_y, v6, arg4), 0x2::tx_context::sender(arg4));
            let (v8, v9, _) = get_reserves_size<T0, T1>(v1);
            assert_lp_value_is_increased(v2, v3, v8, v9);
            let v11 = 0x1::vector::empty<u64>();
            0x1::vector::push_back<u64>(&mut v11, v5);
            0x1::vector::push_back<u64>(&mut v11, 0);
            0x1::vector::push_back<u64>(&mut v11, 0);
            0x1::vector::push_back<u64>(&mut v11, v6);
            v11
        } else {
            let v12 = get_mut_pool<T1, T0>(arg0, !arg3);
            let (v13, v14, _) = get_reserves_size<T1, T0>(v12);
            assert!(v13 > 0 && v14 > 0, 1);
            let v16 = 0x2::coin::value<T0>(&arg1);
            let v17 = get_amount_out(v16, v14, v13);
            assert!(v17 >= arg2, 7);
            let v18 = 0x2::coin::into_balance<T0>(arg1);
            0x2::balance::join<T0>(&mut v12.fee_coin_y, 0x2::balance::split<T0>(&mut v18, get_fee_to_fundation(v16)));
            0x2::balance::join<T0>(&mut v12.coin_y, v18);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut v12.coin_x, v17, arg4), 0x2::tx_context::sender(arg4));
            let (v19, v20, _) = get_reserves_size<T1, T0>(v12);
            assert_lp_value_is_increased(v13, v14, v19, v20);
            let v22 = 0x1::vector::empty<u64>();
            0x1::vector::push_back<u64>(&mut v22, 0);
            0x1::vector::push_back<u64>(&mut v22, v17);
            0x1::vector::push_back<u64>(&mut v22, v16);
            0x1::vector::push_back<u64>(&mut v22, 0);
            v22
        }
    }

    public(friend) fun swap_out_with_fee<T0, T1>(arg0: &mut Global, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) : vector<u64> {
        assert!(0x2::coin::value<T0>(&arg1) > 0, 0);
        let v0 = if (0x2::table::contains<0x1::type_name::TypeName, CoinInfo>(&arg0.coin_map, 0x1::type_name::get<T0>())) {
            *0x2::table::borrow<0x1::type_name::TypeName, CoinInfo>(&arg0.coin_map, 0x1::type_name::get<T0>())
        } else {
            CoinInfo{fees: 0x1::vector::empty<FeeInfo>(), total_fee_rate: 0}
        };
        if (arg3) {
            let v2 = get_mut_pool<T0, T1>(arg0, arg3);
            let (v3, v4, _) = get_reserves_size<T0, T1>(v2);
            assert!(v3 > 0 && v4 > 0, 1);
            let v6 = 0x2::coin::value<T0>(&arg1);
            let v7 = 0x2::coin::into_balance<T0>(arg1);
            0x2::balance::join<T0>(&mut v2.fee_coin_x, 0x2::balance::split<T0>(&mut v7, get_fee_to_fundation(v6)));
            0x2::balance::join<T0>(&mut v2.coin_x, v7);
            let v8 = transfer_out_with_fee<T1>(v0, 0x2::balance::split<T1>(&mut v2.coin_y, get_amount_out(v6, v3, v4)), arg4);
            assert!(v8 >= arg2, 7);
            let (v9, v10, _) = get_reserves_size<T0, T1>(v2);
            assert_lp_value_is_increased(v3, v4, v9, v10);
            let v12 = 0x1::vector::empty<u64>();
            0x1::vector::push_back<u64>(&mut v12, v6);
            0x1::vector::push_back<u64>(&mut v12, 0);
            0x1::vector::push_back<u64>(&mut v12, 0);
            0x1::vector::push_back<u64>(&mut v12, v8);
            v12
        } else {
            let v13 = get_mut_pool<T1, T0>(arg0, !arg3);
            let (v14, v15, _) = get_reserves_size<T1, T0>(v13);
            assert!(v14 > 0 && v15 > 0, 1);
            let v17 = 0x2::coin::value<T0>(&arg1);
            let v18 = 0x2::coin::into_balance<T0>(arg1);
            0x2::balance::join<T0>(&mut v13.fee_coin_y, 0x2::balance::split<T0>(&mut v18, get_fee_to_fundation(v17)));
            0x2::balance::join<T0>(&mut v13.coin_y, v18);
            let v19 = transfer_out_with_fee<T1>(v0, 0x2::balance::split<T1>(&mut v13.coin_x, get_amount_out(v17, v15, v14)), arg4);
            assert!(v19 >= arg2, 7);
            let (v20, v21, _) = get_reserves_size<T1, T0>(v13);
            assert_lp_value_is_increased(v14, v15, v20, v21);
            let v23 = 0x1::vector::empty<u64>();
            0x1::vector::push_back<u64>(&mut v23, 0);
            0x1::vector::push_back<u64>(&mut v23, v19);
            0x1::vector::push_back<u64>(&mut v23, v17);
            0x1::vector::push_back<u64>(&mut v23, 0);
            v23
        }
    }

    fun transfer_out_with_fee<T0>(arg0: CoinInfo, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg0.total_fee_rate > 0) {
            let v0 = 0;
            while (v0 < 0x1::vector::length<FeeInfo>(&arg0.fees)) {
                let v1 = 0x1::vector::borrow<FeeInfo>(&arg0.fees, v0);
                let v2 = 0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::math::mul_div(0x2::balance::value<T0>(&arg1), v1.fee_rate, 10000);
                if (v2 > 0) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1, v2, arg2), v1.receiver);
                };
                v0 = v0 + 1;
            };
        };
        let v3 = 0x2::balance::value<T0>(&arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1, v3, arg2), 0x2::tx_context::sender(arg2));
        0x2::balance::destroy_zero<T0>(arg1);
        v3
    }

    public(friend) fun withdraw<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, u64, u64) {
        let v0 = 0x2::balance::value<T0>(&arg0.fee_coin_x);
        let v1 = 0x2::balance::value<T1>(&arg0.fee_coin_y);
        assert!(v0 > 0 && v1 > 0, 0);
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.fee_coin_x, v0), arg1), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.fee_coin_y, v1), arg1), v0, v1)
    }

    // decompiled from Move bytecode v6
}

