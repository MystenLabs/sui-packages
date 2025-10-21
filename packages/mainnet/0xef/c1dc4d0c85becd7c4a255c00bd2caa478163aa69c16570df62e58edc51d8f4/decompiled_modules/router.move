module 0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::router {
    struct Router has key {
        id: 0x2::object::UID,
    }

    struct Reserves has copy, drop, store {
        reserve0: u256,
        reserve1: u256,
    }

    public entry fun create_pair<T0, T1>(arg0: &Router, arg1: &mut 0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::factory::Factory, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::factory::assert_not_paused(arg1);
        let v0 = 0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::factory::get_pair<T0, T1>(arg1);
        assert!(0x1::option::is_none<address>(&v0), 308);
        0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::factory::create_pair<T0, T1>(arg1, arg2, arg3, arg4);
    }

    public entry fun add_liquidity<T0, T1>(arg0: &Router, arg1: &mut 0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::factory::Factory, arg2: &mut 0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::pair::Pair<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: u256, arg6: u256, arg7: u256, arg8: u256, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::factory::assert_not_paused(arg1);
        let v0 = 0x2::tx_context::sender(arg13);
        validate_liquidity_input(arg5, arg6, arg7, arg8, arg11, 0x2::clock::timestamp_ms(arg12) / 1000);
        validate_coin_sufficiency<T0>(&arg3, arg5, b"liquidity");
        validate_coin_sufficiency<T1>(&arg4, arg6, b"liquidity");
        let v1 = 0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::factory::get_pair<T0, T1>(arg1);
        let v2 = 0x1::option::is_some<address>(&v1);
        assert!(v2, 313);
        let v3 = 0x1::option::none<Reserves>();
        if (v2) {
            let (v4, v5, _) = 0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::pair::get_reserves<T0, T1>(arg2);
            let v7 = Reserves{
                reserve0 : v4,
                reserve1 : v5,
            };
            v3 = 0x1::option::some<Reserves>(v7);
        };
        let (v8, v9) = add_liquidity_internal(arg5, arg6, arg7, arg8, (0x2::coin::value<T0>(&arg3) as u256), (0x2::coin::value<T1>(&arg4) as u256), v2, v3);
        let v10 = (0x2::coin::value<T0>(&arg3) as u256);
        if (v10 > v8) {
            let v11 = v10 - v8;
            assert!(v11 <= 18446744073709551615, 326);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg3, (v11 as u64), arg13), v0);
        };
        let v12 = (0x2::coin::value<T1>(&arg4) as u256);
        if (v12 > v9) {
            let v13 = v12 - v9;
            assert!(v13 <= 18446744073709551615, 326);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg4, (v13 as u64), arg13), v0);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::pair::LPCoin<T0, T1>>>(0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::pair::mint<T0, T1>(arg2, arg3, arg4, arg12, arg13), v0);
    }

    fun add_liquidity_internal(arg0: u256, arg1: u256, arg2: u256, arg3: u256, arg4: u256, arg5: u256, arg6: bool, arg7: 0x1::option::Option<Reserves>) : (u256, u256) {
        if (!arg6) {
            validate_initial_ratio(arg0, arg1);
            return (arg0, arg1)
        };
        let (v0, v1) = if (0x1::option::is_some<Reserves>(&arg7)) {
            let v2 = 0x1::option::destroy_some<Reserves>(arg7);
            (v2.reserve0, v2.reserve1)
        } else {
            (0, 0)
        };
        if (v0 == 0 && v1 == 0) {
            validate_initial_ratio(arg0, arg1);
            (arg0, arg1)
        } else {
            let v5 = min(arg0, arg4);
            let v6 = min(arg1, arg5);
            let v7 = 0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::library::quote(v5, v0, v1);
            if (v7 <= v6) {
                assert!(v7 >= arg3, 303);
                (v5, v7)
            } else {
                let v8 = 0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::library::quote(v6, v1, v0);
                assert!(v8 <= v5, 306);
                assert!(v8 >= arg2, 302);
                (v8, v6)
            }
        }
    }

    fun exact_output_tokens0_swap<T0, T1>(arg0: &0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::factory::Factory, arg1: &mut 0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::pair::Pair<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u256, arg4: u256, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::library::get_amounts_in<T0, T1>(arg0, arg3, arg1, !get_token_position<T0, T1>(arg0));
        assert!(v1 <= arg4, 306);
        let v2 = (0x2::coin::value<T0>(&arg2) as u256);
        assert!(v2 >= v1, 317);
        if (v2 > v1) {
            let v3 = v2 - v1;
            assert!(v3 <= 18446744073709551615, 326);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg2, (v3 as u64), arg6), v0);
        };
        let (v4, v5) = 0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::pair::swap<T0, T1>(arg1, 0x1::option::some<0x2::coin::Coin<T0>>(arg2), 0x1::option::none<0x2::coin::Coin<T1>>(), 0, arg3, arg5, arg6);
        let v6 = v5;
        let v7 = v4;
        if (0x1::option::is_some<0x2::coin::Coin<T0>>(&v7)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x1::option::extract<0x2::coin::Coin<T0>>(&mut v7), v0);
        };
        0x1::option::destroy_none<0x2::coin::Coin<T0>>(v7);
        if (0x1::option::is_some<0x2::coin::Coin<T1>>(&v6)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x1::option::extract<0x2::coin::Coin<T1>>(&mut v6), v0);
        };
        0x1::option::destroy_none<0x2::coin::Coin<T1>>(v6);
    }

    fun exact_output_tokens1_swap<T0, T1>(arg0: &0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::factory::Factory, arg1: &mut 0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::pair::Pair<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: u256, arg4: u256, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::library::get_amounts_in<T0, T1>(arg0, arg3, arg1, get_token_position<T0, T1>(arg0));
        assert!(v1 <= arg4, 306);
        let v2 = (0x2::coin::value<T1>(&arg2) as u256);
        assert!(v2 >= v1, 317);
        if (v2 > v1) {
            let v3 = v2 - v1;
            assert!(v3 <= 18446744073709551615, 326);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg2, (v3 as u64), arg6), v0);
        };
        let (v4, v5) = 0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::pair::swap<T0, T1>(arg1, 0x1::option::none<0x2::coin::Coin<T0>>(), 0x1::option::some<0x2::coin::Coin<T1>>(arg2), arg3, 0, arg5, arg6);
        let v6 = v5;
        let v7 = v4;
        if (0x1::option::is_some<0x2::coin::Coin<T0>>(&v7)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x1::option::extract<0x2::coin::Coin<T0>>(&mut v7), v0);
        };
        0x1::option::destroy_none<0x2::coin::Coin<T0>>(v7);
        if (0x1::option::is_some<0x2::coin::Coin<T1>>(&v6)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x1::option::extract<0x2::coin::Coin<T1>>(&mut v6), v0);
        };
        0x1::option::destroy_none<0x2::coin::Coin<T1>>(v6);
    }

    fun exact_tokens0_swap<T0, T1>(arg0: &0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::factory::Factory, arg1: &mut 0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::pair::Pair<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u256, arg4: u256, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = (0x2::coin::value<T0>(&arg2) as u256);
        assert!(v1 >= arg3, 314);
        assert!(arg3 > 0, 323);
        assert!(arg3 <= 18446744073709551615, 322);
        if (v1 > arg3) {
            let v2 = v1 - arg3;
            assert!(v2 <= 18446744073709551615, 326);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg2, (v2 as u64), arg6), v0);
        };
        let v3 = 0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::library::get_amounts_out<T0, T1>(arg0, arg3, arg1, get_token_position<T0, T1>(arg0));
        assert!(v3 >= arg4, 305);
        let (v4, v5) = 0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::pair::swap<T0, T1>(arg1, 0x1::option::some<0x2::coin::Coin<T0>>(arg2), 0x1::option::none<0x2::coin::Coin<T1>>(), 0, v3, arg5, arg6);
        let v6 = v5;
        let v7 = v4;
        if (0x1::option::is_some<0x2::coin::Coin<T0>>(&v7)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x1::option::extract<0x2::coin::Coin<T0>>(&mut v7), v0);
        };
        0x1::option::destroy_none<0x2::coin::Coin<T0>>(v7);
        if (0x1::option::is_some<0x2::coin::Coin<T1>>(&v6)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x1::option::extract<0x2::coin::Coin<T1>>(&mut v6), v0);
        };
        0x1::option::destroy_none<0x2::coin::Coin<T1>>(v6);
    }

    fun exact_tokens1_swap<T0, T1>(arg0: &0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::factory::Factory, arg1: &mut 0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::pair::Pair<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: u256, arg4: u256, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = (0x2::coin::value<T1>(&arg2) as u256);
        assert!(v1 >= arg3, 314);
        assert!(arg3 > 0, 323);
        assert!(arg3 <= 18446744073709551615, 322);
        if (v1 > arg3) {
            let v2 = v1 - arg3;
            assert!(v2 <= 18446744073709551615, 326);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg2, (v2 as u64), arg6), v0);
        };
        let v3 = 0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::library::get_amounts_out<T0, T1>(arg0, arg3, arg1, !get_token_position<T0, T1>(arg0));
        assert!(v3 >= arg4, 305);
        let (v4, v5) = 0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::pair::swap<T0, T1>(arg1, 0x1::option::none<0x2::coin::Coin<T0>>(), 0x1::option::some<0x2::coin::Coin<T1>>(arg2), v3, 0, arg5, arg6);
        let v6 = v5;
        let v7 = v4;
        if (0x1::option::is_some<0x2::coin::Coin<T0>>(&v7)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x1::option::extract<0x2::coin::Coin<T0>>(&mut v7), v0);
        };
        0x1::option::destroy_none<0x2::coin::Coin<T0>>(v7);
        if (0x1::option::is_some<0x2::coin::Coin<T1>>(&v6)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x1::option::extract<0x2::coin::Coin<T1>>(&mut v6), v0);
        };
        0x1::option::destroy_none<0x2::coin::Coin<T1>>(v6);
    }

    public fun get_token_position<T0, T1>(arg0: &0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::factory::Factory) : bool {
        let v0 = 0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::factory::sort_tokens<T0, T1>();
        0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::factory::is_token0<T0>(&v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Router{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<Router>(v0);
    }

    fun min(arg0: u256, arg1: u256) : u256 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun quote_liquidity_amount<T0, T1>(arg0: &0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::factory::Factory, arg1: &0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::pair::Pair<T0, T1>, arg2: u256, arg3: u256) : u256 {
        let (v0, v1) = 0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::library::get_reserves<T0, T1>(arg0, arg1);
        let v2 = 0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::pair::total_supply<T0, T1>(arg1);
        if (v0 == 0 && v1 == 0) {
            let v4 = 0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::math_utils::integer_sqrt(arg2 * arg3);
            assert!(v4 > 10000, 304);
            v4 - 10000
        } else {
            let v5 = arg2 * v2 / v0;
            let v6 = arg3 * v2 / v1;
            assert!(v5 > 0, 304);
            assert!(v6 > 0, 304);
            min(v5, v6)
        }
    }

    public entry fun remove_liquidity<T0, T1>(arg0: &Router, arg1: &0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::factory::Factory, arg2: &mut 0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::pair::Pair<T0, T1>, arg3: vector<0x2::coin::Coin<0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::pair::LPCoin<T0, T1>>>, arg4: u256, arg5: u256, arg6: u256, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::factory::assert_not_paused(arg1);
        let v0 = 0x2::tx_context::sender(arg9);
        validate_remove_liquidity_input(arg4, arg5, arg6, arg7, 0x2::clock::timestamp_ms(arg8) / 1000);
        assert!(!0x1::vector::is_empty<0x2::coin::Coin<0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::pair::LPCoin<T0, T1>>>(&arg3), 325);
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::coin::Coin<0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::pair::LPCoin<T0, T1>>>(&arg3)) {
            v1 = v1 + (0x2::coin::value<0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::pair::LPCoin<T0, T1>>(0x1::vector::borrow<0x2::coin::Coin<0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::pair::LPCoin<T0, T1>>>(&arg3, v2)) as u256);
            v2 = v2 + 1;
        };
        assert!(v1 >= arg4, 321);
        let v3 = 0x1::vector::pop_back<0x2::coin::Coin<0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::pair::LPCoin<T0, T1>>>(&mut arg3);
        while (!0x1::vector::is_empty<0x2::coin::Coin<0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::pair::LPCoin<T0, T1>>>(&arg3)) {
            0x2::coin::join<0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::pair::LPCoin<T0, T1>>(&mut v3, 0x1::vector::pop_back<0x2::coin::Coin<0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::pair::LPCoin<T0, T1>>>(&mut arg3));
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::pair::LPCoin<T0, T1>>>(arg3);
        let v4 = (0x2::coin::value<0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::pair::LPCoin<T0, T1>>(&v3) as u256);
        assert!(v4 >= arg4, 304);
        let v3 = if (v4 == arg4) {
            v3
        } else {
            let v5 = v4 - arg4;
            assert!(v5 <= 18446744073709551615, 326);
            0x2::transfer::public_transfer<0x2::coin::Coin<0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::pair::LPCoin<T0, T1>>>(0x2::coin::split<0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::pair::LPCoin<T0, T1>>(&mut v3, (v5 as u64), arg9), v0);
            v3
        };
        let (v6, v7, _) = 0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::pair::get_reserves<T0, T1>(arg2);
        let (_, _) = remove_liquidity_internal(0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::pair::total_supply<T0, T1>(arg2), arg4, v6, v7, arg5, arg6);
        let (v11, v12) = 0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::pair::burn<T0, T1>(arg2, v3, arg8, arg9);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v11, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v12, v0);
    }

    fun remove_liquidity_internal(arg0: u256, arg1: u256, arg2: u256, arg3: u256, arg4: u256, arg5: u256) : (u256, u256) {
        assert!(arg1 > 0 && arg0 > 0, 304);
        let v0 = arg2 * arg1 / arg0;
        let v1 = arg3 * arg1 / arg0;
        assert!(v0 > 0, 315);
        assert!(v1 > 0, 315);
        assert!(v0 >= arg4, 302);
        assert!(v1 >= arg5, 303);
        (v0, v1)
    }

    public entry fun swap_exact_token0_to_mid_then_mid_to_token0<T0, T1, T2>(arg0: &Router, arg1: &0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::factory::Factory, arg2: &mut 0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::pair::Pair<T0, T1>, arg3: &mut 0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::pair::Pair<T2, T1>, arg4: 0x2::coin::Coin<T0>, arg5: u256, arg6: u256, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::factory::assert_not_paused(arg1);
        let v0 = (0x2::coin::value<T0>(&arg4) as u256);
        validate_multihop_input(v0, arg5, arg6, arg7, 0x2::clock::timestamp_ms(arg8) / 1000);
        let v1 = 0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::library::get_amounts_out<T0, T1>(arg1, v0, arg2, get_token_position<T0, T1>(arg1));
        assert!(v1 >= arg6, 305);
        let (v2, v3) = 0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::pair::swap<T0, T1>(arg2, 0x1::option::some<0x2::coin::Coin<T0>>(arg4), 0x1::option::none<0x2::coin::Coin<T1>>(), 0, v1, arg8, arg9);
        let v4 = v3;
        assert!(0x1::option::is_some<0x2::coin::Coin<T1>>(&v4), 304);
        let v5 = 0x1::option::extract<0x2::coin::Coin<T1>>(&mut v4);
        0x1::option::destroy_none<0x2::coin::Coin<T0>>(v2);
        0x1::option::destroy_none<0x2::coin::Coin<T1>>(v4);
        let v6 = (0x2::coin::value<T1>(&v5) as u256);
        assert!(v6 >= arg6, 305);
        let v7 = 0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::library::get_amounts_out<T2, T1>(arg1, v6, arg3, !get_token_position<T2, T1>(arg1));
        assert!(v7 >= arg5, 305);
        let (v8, v9) = 0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::pair::swap<T2, T1>(arg3, 0x1::option::none<0x2::coin::Coin<T2>>(), 0x1::option::some<0x2::coin::Coin<T1>>(v5), v7, 0, arg8, arg9);
        let v10 = v8;
        assert!(0x1::option::is_some<0x2::coin::Coin<T2>>(&v10), 305);
        0x1::option::destroy_none<0x2::coin::Coin<T2>>(v10);
        0x1::option::destroy_none<0x2::coin::Coin<T1>>(v9);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x1::option::extract<0x2::coin::Coin<T2>>(&mut v10), 0x2::tx_context::sender(arg9));
    }

    public entry fun swap_exact_token0_to_mid_then_mid_to_token1<T0, T1, T2>(arg0: &Router, arg1: &0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::factory::Factory, arg2: &mut 0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::pair::Pair<T0, T1>, arg3: &mut 0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::pair::Pair<T1, T2>, arg4: 0x2::coin::Coin<T0>, arg5: u256, arg6: u256, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::factory::assert_not_paused(arg1);
        let v0 = (0x2::coin::value<T0>(&arg4) as u256);
        validate_multihop_input(v0, arg5, arg6, arg7, 0x2::clock::timestamp_ms(arg8) / 1000);
        let v1 = 0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::library::get_amounts_out<T0, T1>(arg1, v0, arg2, get_token_position<T0, T1>(arg1));
        assert!(v1 >= arg6, 305);
        let (v2, v3) = 0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::pair::swap<T0, T1>(arg2, 0x1::option::some<0x2::coin::Coin<T0>>(arg4), 0x1::option::none<0x2::coin::Coin<T1>>(), 0, v1, arg8, arg9);
        let v4 = v3;
        assert!(0x1::option::is_some<0x2::coin::Coin<T1>>(&v4), 304);
        let v5 = 0x1::option::extract<0x2::coin::Coin<T1>>(&mut v4);
        0x1::option::destroy_none<0x2::coin::Coin<T0>>(v2);
        0x1::option::destroy_none<0x2::coin::Coin<T1>>(v4);
        assert!((0x2::coin::value<T1>(&v5) as u256) >= arg6, 305);
        let v6 = (0x2::coin::value<T1>(&v5) as u256);
        assert!(v6 > 0, 327);
        let v7 = 0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::library::get_amounts_out<T1, T2>(arg1, v6, arg3, get_token_position<T1, T2>(arg1));
        assert!(v7 >= arg5, 305);
        let (v8, v9) = 0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::pair::swap<T1, T2>(arg3, 0x1::option::some<0x2::coin::Coin<T1>>(v5), 0x1::option::none<0x2::coin::Coin<T2>>(), 0, v7, arg8, arg9);
        let v10 = v9;
        assert!(0x1::option::is_some<0x2::coin::Coin<T2>>(&v10), 305);
        0x1::option::destroy_none<0x2::coin::Coin<T1>>(v8);
        0x1::option::destroy_none<0x2::coin::Coin<T2>>(v10);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x1::option::extract<0x2::coin::Coin<T2>>(&mut v10), 0x2::tx_context::sender(arg9));
    }

    public entry fun swap_exact_token1_to_mid_then_mid_to_token0<T0, T1, T2>(arg0: &Router, arg1: &0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::factory::Factory, arg2: &mut 0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::pair::Pair<T1, T2>, arg3: &mut 0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::pair::Pair<T0, T1>, arg4: 0x2::coin::Coin<T2>, arg5: u256, arg6: u256, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::factory::assert_not_paused(arg1);
        let v0 = (0x2::coin::value<T2>(&arg4) as u256);
        validate_multihop_input(v0, arg5, arg6, arg7, 0x2::clock::timestamp_ms(arg8) / 1000);
        let v1 = 0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::library::get_amounts_out<T1, T2>(arg1, v0, arg2, !get_token_position<T1, T2>(arg1));
        assert!(v1 >= arg6, 305);
        let (v2, v3) = 0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::pair::swap<T1, T2>(arg2, 0x1::option::none<0x2::coin::Coin<T1>>(), 0x1::option::some<0x2::coin::Coin<T2>>(arg4), v1, 0, arg8, arg9);
        let v4 = v2;
        assert!(0x1::option::is_some<0x2::coin::Coin<T1>>(&v4), 304);
        let v5 = 0x1::option::extract<0x2::coin::Coin<T1>>(&mut v4);
        0x1::option::destroy_none<0x2::coin::Coin<T1>>(v4);
        0x1::option::destroy_none<0x2::coin::Coin<T2>>(v3);
        assert!((0x2::coin::value<T1>(&v5) as u256) >= arg6, 305);
        let v6 = (0x2::coin::value<T1>(&v5) as u256);
        assert!(v6 > 0, 327);
        let v7 = 0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::library::get_amounts_out<T0, T1>(arg1, v6, arg3, !get_token_position<T0, T1>(arg1));
        assert!(v7 >= arg5, 305);
        let (v8, v9) = 0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::pair::swap<T0, T1>(arg3, 0x1::option::none<0x2::coin::Coin<T0>>(), 0x1::option::some<0x2::coin::Coin<T1>>(v5), v7, 0, arg8, arg9);
        let v10 = v8;
        assert!(0x1::option::is_some<0x2::coin::Coin<T0>>(&v10), 305);
        0x1::option::destroy_none<0x2::coin::Coin<T0>>(v10);
        0x1::option::destroy_none<0x2::coin::Coin<T1>>(v9);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x1::option::extract<0x2::coin::Coin<T0>>(&mut v10), 0x2::tx_context::sender(arg9));
    }

    public entry fun swap_exact_token1_to_mid_then_mid_to_token1<T0, T1, T2>(arg0: &Router, arg1: &0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::factory::Factory, arg2: &mut 0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::pair::Pair<T0, T1>, arg3: &mut 0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::pair::Pair<T0, T2>, arg4: 0x2::coin::Coin<T1>, arg5: u256, arg6: u256, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::factory::assert_not_paused(arg1);
        let v0 = (0x2::coin::value<T1>(&arg4) as u256);
        validate_multihop_input(v0, arg5, arg6, arg7, 0x2::clock::timestamp_ms(arg8) / 1000);
        let v1 = 0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::library::get_amounts_out<T0, T1>(arg1, v0, arg2, !get_token_position<T0, T1>(arg1));
        assert!(v1 >= arg6, 305);
        let (v2, v3) = 0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::pair::swap<T0, T1>(arg2, 0x1::option::none<0x2::coin::Coin<T0>>(), 0x1::option::some<0x2::coin::Coin<T1>>(arg4), v1, 0, arg8, arg9);
        let v4 = v2;
        assert!(0x1::option::is_some<0x2::coin::Coin<T0>>(&v4), 304);
        let v5 = 0x1::option::extract<0x2::coin::Coin<T0>>(&mut v4);
        0x1::option::destroy_none<0x2::coin::Coin<T0>>(v4);
        0x1::option::destroy_none<0x2::coin::Coin<T1>>(v3);
        assert!((0x2::coin::value<T0>(&v5) as u256) >= arg6, 305);
        let v6 = (0x2::coin::value<T0>(&v5) as u256);
        assert!(v6 > 0, 327);
        let v7 = 0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::library::get_amounts_out<T0, T2>(arg1, v6, arg3, get_token_position<T0, T2>(arg1));
        assert!(v7 >= arg5, 305);
        let (v8, v9) = 0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::pair::swap<T0, T2>(arg3, 0x1::option::some<0x2::coin::Coin<T0>>(v5), 0x1::option::none<0x2::coin::Coin<T2>>(), 0, v7, arg8, arg9);
        let v10 = v9;
        assert!(0x1::option::is_some<0x2::coin::Coin<T2>>(&v10), 305);
        0x1::option::destroy_none<0x2::coin::Coin<T0>>(v8);
        0x1::option::destroy_none<0x2::coin::Coin<T2>>(v10);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x1::option::extract<0x2::coin::Coin<T2>>(&mut v10), 0x2::tx_context::sender(arg9));
    }

    public entry fun swap_exact_tokens0_for_tokens1<T0, T1>(arg0: &Router, arg1: &0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::factory::Factory, arg2: &mut 0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::pair::Pair<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: u256, arg5: u256, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::factory::assert_not_paused(arg1);
        validate_swap_input(arg4, arg5, arg6, 0x2::clock::timestamp_ms(arg7) / 1000);
        validate_coin_sufficiency<T0>(&arg3, arg4, b"swap");
        exact_tokens0_swap<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg7, arg8);
    }

    public entry fun swap_exact_tokens1_for_tokens0<T0, T1>(arg0: &Router, arg1: &0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::factory::Factory, arg2: &mut 0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::pair::Pair<T0, T1>, arg3: 0x2::coin::Coin<T1>, arg4: u256, arg5: u256, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::factory::assert_not_paused(arg1);
        validate_swap_input(arg4, arg5, arg6, 0x2::clock::timestamp_ms(arg7) / 1000);
        validate_coin_sufficiency<T1>(&arg3, arg4, b"swap");
        exact_tokens1_swap<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg7, arg8);
    }

    public entry fun swap_tokens0_for_exact_tokens1<T0, T1>(arg0: &Router, arg1: &0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::factory::Factory, arg2: &mut 0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::pair::Pair<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: u256, arg5: u256, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::factory::assert_not_paused(arg1);
        validate_exact_output_input(arg4, arg5, arg6, 0x2::clock::timestamp_ms(arg7) / 1000);
        validate_coin_sufficiency<T0>(&arg3, arg5, b"swap");
        exact_output_tokens0_swap<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg7, arg8);
    }

    public entry fun swap_tokens1_for_exact_tokens0<T0, T1>(arg0: &Router, arg1: &0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::factory::Factory, arg2: &mut 0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::pair::Pair<T0, T1>, arg3: 0x2::coin::Coin<T1>, arg4: u256, arg5: u256, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::factory::assert_not_paused(arg1);
        validate_exact_output_input(arg4, arg5, arg6, 0x2::clock::timestamp_ms(arg7) / 1000);
        validate_coin_sufficiency<T1>(&arg3, arg5, b"swap");
        exact_output_tokens1_swap<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg7, arg8);
    }

    fun validate_coin_sufficiency<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u256, arg2: vector<u8>) {
        assert!((0x2::coin::value<T0>(arg0) as u256) >= arg1, 320);
        if (arg2 == b"liquidity") {
            assert!(arg1 >= 1000, 316);
        };
    }

    fun validate_exact_output_input(arg0: u256, arg1: u256, arg2: u64, arg3: u64) {
        assert!(arg0 > 0, 323);
        assert!(arg1 > 0, 323);
        assert!(arg2 >= arg3, 301);
        assert!(arg0 <= 18446744073709551615, 322);
        assert!(arg1 <= 18446744073709551615, 322);
    }

    fun validate_initial_ratio(arg0: u256, arg1: u256) {
        assert!(arg0 >= 1000, 316);
        assert!(arg1 >= 1000, 316);
    }

    fun validate_liquidity_input(arg0: u256, arg1: u256, arg2: u256, arg3: u256, arg4: u64, arg5: u64) {
        assert!(arg0 > 0, 323);
        assert!(arg1 > 0, 323);
        assert!(arg2 <= arg0, 324);
        assert!(arg3 <= arg1, 324);
        assert!(arg4 >= arg5, 301);
        assert!(arg0 <= 18446744073709551615, 322);
        assert!(arg1 <= 18446744073709551615, 322);
    }

    fun validate_multihop_input(arg0: u256, arg1: u256, arg2: u256, arg3: u64, arg4: u64) {
        assert!(arg0 > 0, 327);
        assert!(arg1 > 0, 328);
        assert!(arg2 > 0, 328);
        assert!(arg3 >= arg4, 301);
        assert!(arg0 <= 18446744073709551615, 322);
        assert!(arg1 <= 18446744073709551615, 322);
        assert!(arg2 <= 18446744073709551615, 322);
    }

    fun validate_remove_liquidity_input(arg0: u256, arg1: u256, arg2: u256, arg3: u64, arg4: u64) {
        assert!(arg0 > 0, 323);
        assert!(arg3 >= arg4, 301);
        assert!(arg0 <= 18446744073709551615, 322);
    }

    fun validate_swap_input(arg0: u256, arg1: u256, arg2: u64, arg3: u64) {
        assert!(arg0 > 0, 323);
        assert!(arg1 > 0, 328);
        assert!(arg2 >= arg3, 301);
        assert!(arg0 <= 18446744073709551615, 322);
        assert!(arg1 <= 18446744073709551615, 322);
    }

    // decompiled from Move bytecode v6
}

