module 0xfbe84fe0eac685d9edb6e9b4583fd1e5026008e3345c06107996d11b63951aaa::main {
    struct Config has store, key {
        id: 0x2::object::UID,
        times: u8,
        assets: 0x2::table::Table<0x1::ascii::String, u8>,
    }

    public fun add_config(arg0: &Config, arg1: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id     : 0x2::object::new(arg3),
            times  : 2,
            assets : 0x2::table::new<0x1::ascii::String, u8>(arg3),
        };
        let v1 = &mut v0;
        assets(v1, arg1);
        0x2::transfer::public_transfer<Config>(v0, arg2);
    }

    public entry fun assets(arg0: &mut Config, arg1: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage) {
        let v0 = 0;
        while (v0 < 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_reserves_count(arg1)) {
            let v1 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_coin_type(arg1, v0);
            if (!0x2::table::contains<0x1::ascii::String, u8>(&arg0.assets, v1)) {
                0x2::table::add<0x1::ascii::String, u8>(&mut arg0.assets, v1, v0);
            };
            v0 = v0 + 1;
        };
    }

    fun camt(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: u8, arg4: u8, arg5: address) : u256 {
        let (v0, _, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_liquidation_factors(arg2, arg3);
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::calculator::calculate_amount(arg0, arg1, minimal(multiply(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_value(arg0, arg1, arg2, arg3, arg5), v0), 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_loan_value(arg0, arg1, arg2, arg4, arg5)), 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_oracle_id(arg2, arg4))
    }

    public fun ccamt<T0, T1>(arg0: &Config, arg1: &0x2::clock::Clock, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: address) : u256 {
        let (v0, v1) = gid<T0, T1>(arg0);
        camt(arg1, arg2, arg3, v0, v1, arg4)
    }

    public fun fixed_swap_a_to_b<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T0>, arg4: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, true, true, arg4, 4295048016, arg0);
        let v3 = v2;
        let v4 = v0;
        0x2::balance::join<T0>(&mut v4, arg3);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::split<T0>(&mut v4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3)), 0x2::balance::zero<T1>(), v3);
        (v4, v1)
    }

    public fun fixed_swap_a_to_b_out<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T0>, arg4: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, true, false, arg4, 4295048016, arg0);
        let v3 = v2;
        let v4 = v0;
        0x2::balance::join<T0>(&mut v4, arg3);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::split<T0>(&mut v4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3)), 0x2::balance::zero<T1>(), v3);
        (v4, v1)
    }

    public fun fixed_swap_b_to_a<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T1>, arg4: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, false, true, arg4, 79226673515401279992447579055, arg0);
        let v3 = v2;
        let v4 = v1;
        0x2::balance::join<T1>(&mut v4, arg3);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3)), v3);
        (v0, v4)
    }

    public fun fixed_swap_b_to_a_out<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T1>, arg4: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, false, false, arg4, 79226673515401279992447579055, arg0);
        let v3 = v2;
        let v4 = v1;
        0x2::balance::join<T1>(&mut v4, arg3);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3)), v3);
        (v0, v4)
    }

    public fun flash_swap_a<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: u64) : (0x2::balance::Balance<T0>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, false, false, arg3, 79226673515401279992447579055, arg0);
        0x2::balance::destroy_zero<T1>(v1);
        (v0, v2)
    }

    public fun flash_swap_b<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: u64) : (0x2::balance::Balance<T1>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, true, false, arg3, 4295048016, arg0);
        0x2::balance::destroy_zero<T0>(v0);
        (v1, v2)
    }

    fun gid<T0, T1>(arg0: &Config) : (u8, u8) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v1 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        assert!(0x2::table::contains<0x1::ascii::String, u8>(&arg0.assets, v0), 6666);
        assert!(0x2::table::contains<0x1::ascii::String, u8>(&arg0.assets, v1), 7777);
        (*0x2::table::borrow<0x1::ascii::String, u8>(&arg0.assets, v0), *0x2::table::borrow<0x1::ascii::String, u8>(&arg0.assets, v1))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id     : 0x2::object::new(arg0),
            times  : 2,
            assets : 0x2::table::new<0x1::ascii::String, u8>(arg0),
        };
        0x2::transfer::public_transfer<Config>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun l01<T0, T1>(arg0: &Config, arg1: &0x2::clock::Clock, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: 0x2::coin::Coin<T0>, arg5: address, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v1 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        assert!(0x2::table::contains<0x1::ascii::String, u8>(&arg0.assets, v0), 6666);
        assert!(0x2::table::contains<0x1::ascii::String, u8>(&arg0.assets, v1), 7777);
        assert!(!0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::is_health(arg1, arg2, arg3, arg5), 8888);
        let v2 = *0x2::table::borrow<0x1::ascii::String, u8>(&arg0.assets, v0);
        let v3 = 0;
        let v4 = 0x2::coin::into_balance<T0>(arg4);
        let v5 = 0x2::balance::zero<T1>();
        while (v3 < arg0.times && !0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::is_health(arg1, arg2, arg3, arg5)) {
            let (v6, v7) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::liquidation<T0, T1>(arg1, arg2, arg3, v2, arg6, 0x2::balance::split<T0>(&mut v4, 0x2::math::min(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::unnormal_amount<T0>(arg6, (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_loan_balance(arg3, v2, arg5) as u64)), 0x2::balance::value<T0>(&v4))), *0x2::table::borrow<0x1::ascii::String, u8>(&arg0.assets, v1), arg7, arg5, arg8, arg9, arg10);
            0x2::balance::join<T0>(&mut v4, v7);
            0x2::balance::join<T1>(&mut v5, v6);
            v3 = v3 + 1;
        };
        if (0x2::balance::value<T0>(&v4) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v4, arg10), 0x2::tx_context::sender(arg10));
        } else {
            0x2::balance::destroy_zero<T0>(v4);
        };
        if (0x2::balance::value<T1>(&v5) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v5, arg10), 0x2::tx_context::sender(arg10));
        } else {
            0x2::balance::destroy_zero<T1>(v5);
        };
    }

    fun minimal(arg0: u256, arg1: u256) : u256 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    fun multiply(arg0: u256, arg1: u256) : u256 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        assert!(arg0 <= (0x2::address::max() - 500000000000000000000000000) / arg1, 5555);
        (arg0 * arg1 + 500000000000000000000000000) / 1000000000000000000000000000
    }

    public fun pcamt(arg0: &Config, arg1: &0x2::clock::Clock, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: u8, arg5: u8, arg6: address) : u256 {
        camt(arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun repay_flash_swap_a<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T0>, arg4: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>) : 0x2::balance::Balance<T0> {
        let (v0, v1) = fixed_swap_a_to_b_out<T0, T1>(arg0, arg1, arg2, arg3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&arg4));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), v1, arg4);
        v0
    }

    public fun repay_flash_swap_a_from_b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>) : 0x2::balance::Balance<T1> {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&arg3);
        assert!(0x2::balance::value<T1>(&arg2) >= v0, 4444);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg2, v0), arg3);
        arg2
    }

    public fun repay_flash_swap_b<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T1>, arg4: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>) : 0x2::balance::Balance<T1> {
        let (v0, v1) = fixed_swap_b_to_a_out<T0, T1>(arg0, arg1, arg2, arg3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&arg4));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, v0, 0x2::balance::zero<T1>(), arg4);
        v1
    }

    public fun repay_flash_swap_b_from_a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>) : 0x2::balance::Balance<T0> {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&arg3)), 0x2::balance::zero<T1>(), arg3);
        arg2
    }

    public fun spec0<T0, T1>(arg0: &Config, arg1: &0x2::clock::Clock, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: address, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg9: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg10: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg11: bool, arg12: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = gid<T0, T1>(arg0);
        if (arg11) {
            let v2 = camt(arg1, arg2, arg3, v1, v0, arg4);
            let (v3, v4) = flash_swap_a<T0, T1>(arg1, arg9, arg10, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::unnormal_amount<T0>(arg5, (v2 as u64)));
            let (v5, v6) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::liquidation<T0, T1>(arg1, arg2, arg3, v0, arg5, v3, v1, arg6, arg4, arg7, arg8, arg12);
            let v7 = v6;
            let v8 = repay_flash_swap_a_from_b<T0, T1>(arg9, arg10, v5, v4);
            if (0x2::balance::value<T0>(&v7) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v7, arg12), 0x2::tx_context::sender(arg12));
            } else {
                0x2::balance::destroy_zero<T0>(v7);
            };
            if (0x2::balance::value<T1>(&v8) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v8, arg12), 0x2::tx_context::sender(arg12));
            } else {
                0x2::balance::destroy_zero<T1>(v8);
            };
        } else {
            let v9 = camt(arg1, arg2, arg3, v0, v1, arg4);
            let (v10, v11) = flash_swap_b<T0, T1>(arg1, arg9, arg10, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::unnormal_amount<T1>(arg6, (v9 as u64)));
            let (v12, v13) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::liquidation<T1, T0>(arg1, arg2, arg3, v1, arg6, v10, v0, arg5, arg4, arg7, arg8, arg12);
            let v14 = v13;
            let v15 = repay_flash_swap_b_from_a<T0, T1>(arg9, arg10, v12, v11);
            if (0x2::balance::value<T1>(&v14) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v14, arg12), 0x2::tx_context::sender(arg12));
            } else {
                0x2::balance::destroy_zero<T1>(v14);
            };
            if (0x2::balance::value<T0>(&v15) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v15, arg12), 0x2::tx_context::sender(arg12));
            } else {
                0x2::balance::destroy_zero<T0>(v15);
            };
        };
    }

    public fun spec1<T0, T1, T2>(arg0: &Config, arg1: &0x2::clock::Clock, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: address, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg9: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg10: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg11: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg12: bool, arg13: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = gid<T0, T1>(arg0);
        if (arg12) {
            let v2 = camt(arg1, arg2, arg3, v1, v0, arg4);
            let (v3, v4) = flash_swap_a<T0, T2>(arg1, arg9, arg10, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::unnormal_amount<T0>(arg5, (v2 as u64)));
            let (v5, v6) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::liquidation<T0, T1>(arg1, arg2, arg3, v0, arg5, v3, v1, arg6, arg4, arg7, arg8, arg13);
            let v7 = v5;
            let (v8, v9) = fixed_swap_a_to_b<T1, T2>(arg1, arg9, arg11, v7, 0x2::balance::value<T1>(&v7));
            let v10 = v9;
            let v11 = v8;
            let (v12, v13) = fixed_swap_b_to_a<T0, T2>(arg1, arg9, arg10, v10, 0x2::balance::value<T2>(&v10));
            let v14 = v13;
            let v15 = v12;
            0x2::balance::join<T0>(&mut v15, v6);
            let v16 = repay_flash_swap_a<T0, T2>(arg1, arg9, arg10, v15, v4);
            if (0x2::balance::value<T0>(&v16) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v16, arg13), 0x2::tx_context::sender(arg13));
            } else {
                0x2::balance::destroy_zero<T0>(v16);
            };
            if (0x2::balance::value<T2>(&v14) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v14, arg13), 0x2::tx_context::sender(arg13));
            } else {
                0x2::balance::destroy_zero<T2>(v14);
            };
            if (0x2::balance::value<T1>(&v11) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v11, arg13), 0x2::tx_context::sender(arg13));
            } else {
                0x2::balance::destroy_zero<T1>(v11);
            };
        } else {
            let v17 = camt(arg1, arg2, arg3, v0, v1, arg4);
            let (v18, v19) = flash_swap_a<T1, T2>(arg1, arg9, arg11, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::unnormal_amount<T1>(arg6, (v17 as u64)));
            let (v20, v21) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::liquidation<T1, T0>(arg1, arg2, arg3, v1, arg6, v18, v0, arg5, arg4, arg7, arg8, arg13);
            let v22 = v20;
            let (v23, v24) = fixed_swap_a_to_b<T0, T2>(arg1, arg9, arg10, v22, 0x2::balance::value<T0>(&v22));
            let v25 = v24;
            let v26 = v23;
            let (v27, v28) = fixed_swap_b_to_a<T1, T2>(arg1, arg9, arg11, v25, 0x2::balance::value<T2>(&v25));
            let v29 = v28;
            let v30 = v27;
            0x2::balance::join<T1>(&mut v30, v21);
            let v31 = repay_flash_swap_a<T1, T2>(arg1, arg9, arg11, v30, v19);
            if (0x2::balance::value<T1>(&v31) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v31, arg13), 0x2::tx_context::sender(arg13));
            } else {
                0x2::balance::destroy_zero<T1>(v31);
            };
            if (0x2::balance::value<T0>(&v26) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v26, arg13), 0x2::tx_context::sender(arg13));
            } else {
                0x2::balance::destroy_zero<T0>(v26);
            };
            if (0x2::balance::value<T2>(&v29) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v29, arg13), 0x2::tx_context::sender(arg13));
            } else {
                0x2::balance::destroy_zero<T2>(v29);
            };
        };
    }

    public entry fun times(arg0: &mut Config, arg1: u8) {
        arg0.times = arg1;
    }

    // decompiled from Move bytecode v6
}

