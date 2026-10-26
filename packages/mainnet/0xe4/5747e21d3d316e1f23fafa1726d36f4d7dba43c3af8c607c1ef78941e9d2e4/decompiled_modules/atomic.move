module 0xe45747e21d3d316e1f23fafa1726d36f4d7dba43c3af8c607c1ef78941e9d2e4::atomic {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Config has key {
        id: 0x2::object::UID,
        owner: address,
        paused: bool,
    }

    struct LoanTicket<phantom T0> {
        receipt: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashLoanReceipt,
        repay_amount: u64,
        min_profit: u64,
        debt_change: 0x2::balance::Balance<T0>,
        debt_is_a: bool,
    }

    fun assert_caller(arg0: &Config, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 1);
        assert!(!arg0.paused, 2);
    }

    fun assert_liquidatable(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: u8, arg4: address) {
        let (_, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg2, arg3, arg4);
        assert!(v1 > 0, 5);
        assert!(!0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::is_health(arg0, arg1, arg2, arg4), 4);
    }

    public fun begin_flash_loan_debt_a<T0, T1, T2>(arg0: &Config, arg1: &0x2::clock::Clock, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: u8, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg6: u8, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg8: address, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg13: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg14: u64, arg15: u64, arg16: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, LoanTicket<T0>) {
        assert_caller(arg0, arg16);
        assert_liquidatable(arg1, arg2, arg3, arg4, arg8);
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg12, arg13, true, arg14);
        0x2::balance::destroy_zero<T1>(v1);
        let (v3, v4) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation_v2<T0, T2>(arg1, arg2, arg3, arg4, arg5, v0, arg6, arg7, arg8, arg9, arg10, arg11, arg16);
        let v5 = LoanTicket<T0>{
            receipt      : v2,
            repay_amount : flash_loan_repay_amount(arg14, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T0, T1>(arg13)),
            min_profit   : arg15,
            debt_change  : v4,
            debt_is_a    : true,
        };
        (0x2::coin::from_balance<T2>(v3, arg16), v5)
    }

    public fun begin_flash_loan_debt_b<T0, T1, T2>(arg0: &Config, arg1: &0x2::clock::Clock, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: u8, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg6: u8, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg8: address, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg13: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg14: u64, arg15: u64, arg16: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, LoanTicket<T1>) {
        assert_caller(arg0, arg16);
        assert_liquidatable(arg1, arg2, arg3, arg4, arg8);
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg12, arg13, false, arg14);
        0x2::balance::destroy_zero<T0>(v0);
        let (v3, v4) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation_v2<T1, T2>(arg1, arg2, arg3, arg4, arg5, v1, arg6, arg7, arg8, arg9, arg10, arg11, arg16);
        let v5 = LoanTicket<T1>{
            receipt      : v2,
            repay_amount : flash_loan_repay_amount(arg14, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T0, T1>(arg13)),
            min_profit   : arg15,
            debt_change  : v4,
            debt_is_a    : false,
        };
        (0x2::coin::from_balance<T2>(v3, arg16), v5)
    }

    public fun checked_profit(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg0 >= arg1, 6);
        let v0 = arg0 - arg1;
        assert!(v0 >= arg2, 6);
        v0
    }

    public fun e_already_healthy() : u64 {
        4
    }

    public fun e_no_debt() : u64 {
        5
    }

    public fun e_not_owner() : u64 {
        1
    }

    public fun e_paused() : u64 {
        2
    }

    public fun e_profit_too_low() : u64 {
        6
    }

    public fun finish_flash_loan_debt_a<T0, T1>(arg0: &Config, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: LoanTicket<T0>, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        assert_caller(arg0, arg5);
        let LoanTicket {
            receipt      : v0,
            repay_amount : v1,
            min_profit   : v2,
            debt_change  : v3,
            debt_is_a    : v4,
        } = arg3;
        let v5 = v3;
        assert!(v4, 8);
        0x2::balance::join<T0>(&mut v5, 0x2::coin::into_balance<T0>(arg4));
        checked_profit(0x2::balance::value<T0>(&v5), v1, v2);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg1, arg2, 0x2::balance::split<T0>(&mut v5, v1), 0x2::balance::zero<T1>(), v0);
        send<T0>(v5, arg5);
    }

    public fun finish_flash_loan_debt_b<T0, T1>(arg0: &Config, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: LoanTicket<T1>, arg4: 0x2::coin::Coin<T1>, arg5: &mut 0x2::tx_context::TxContext) {
        assert_caller(arg0, arg5);
        let LoanTicket {
            receipt      : v0,
            repay_amount : v1,
            min_profit   : v2,
            debt_change  : v3,
            debt_is_a    : v4,
        } = arg3;
        let v5 = v3;
        assert!(!v4, 8);
        0x2::balance::join<T1>(&mut v5, 0x2::coin::into_balance<T1>(arg4));
        checked_profit(0x2::balance::value<T1>(&v5), v1, v2);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v5, v1), v0);
        send<T1>(v5, arg5);
    }

    public fun flash_loan_repay_amount(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 > 0, 3);
        assert!(arg1 < 1000000, 7);
        let v0 = (1000000 as u128);
        (((arg0 as u128) + ((arg0 as u128) * (arg1 as u128) + v0 - 1) / v0) as u64)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Config{
            id     : 0x2::object::new(arg0),
            owner  : 0x2::tx_context::sender(arg0),
            paused : false,
        };
        0x2::transfer::share_object<Config>(v1);
    }

    public fun liquidate_flash_swap_debt_a<T0, T1>(arg0: &Config, arg1: &0x2::clock::Clock, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: u8, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg6: u8, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg8: address, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg13: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg14: u64, arg15: u128, arg16: u64, arg17: &mut 0x2::tx_context::TxContext) {
        assert_caller(arg0, arg17);
        assert!(arg14 > 0, 3);
        assert_liquidatable(arg1, arg2, arg3, arg4, arg8);
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg12, arg13, false, false, arg14, arg15, arg1);
        let v3 = v2;
        let v4 = v1;
        let (v5, v6) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation_v2<T0, T1>(arg1, arg2, arg3, arg4, arg5, v0, arg6, arg7, arg8, arg9, arg10, arg11, arg17);
        let v7 = v5;
        let v8 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3);
        checked_profit(0x2::balance::value<T1>(&v7), v8, arg16);
        0x2::balance::join<T1>(&mut v4, 0x2::balance::split<T1>(&mut v7, v8));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg12, arg13, 0x2::balance::zero<T0>(), v4, v3);
        send<T1>(v7, arg17);
        send<T0>(v6, arg17);
    }

    public fun liquidate_flash_swap_debt_b<T0, T1>(arg0: &Config, arg1: &0x2::clock::Clock, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: u8, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg6: u8, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg8: address, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg13: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg14: u64, arg15: u128, arg16: u64, arg17: &mut 0x2::tx_context::TxContext) {
        assert_caller(arg0, arg17);
        assert!(arg14 > 0, 3);
        assert_liquidatable(arg1, arg2, arg3, arg4, arg8);
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg12, arg13, true, false, arg14, arg15, arg1);
        let v3 = v2;
        let v4 = v0;
        let (v5, v6) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation_v2<T1, T0>(arg1, arg2, arg3, arg4, arg5, v1, arg6, arg7, arg8, arg9, arg10, arg11, arg17);
        let v7 = v5;
        let v8 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3);
        checked_profit(0x2::balance::value<T0>(&v7), v8, arg16);
        0x2::balance::join<T0>(&mut v4, 0x2::balance::split<T0>(&mut v7, v8));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg12, arg13, v4, 0x2::balance::zero<T1>(), v3);
        send<T0>(v7, arg17);
        send<T1>(v6, arg17);
    }

    public fun owner(arg0: &Config) : address {
        arg0.owner
    }

    public fun paused(arg0: &Config) : bool {
        arg0.paused
    }

    fun send<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
        };
    }

    public fun set_owner(arg0: &AdminCap, arg1: &mut Config, arg2: address) {
        arg1.owner = arg2;
    }

    public fun set_paused(arg0: &AdminCap, arg1: &mut Config, arg2: bool) {
        arg1.paused = arg2;
    }

    // decompiled from Move bytecode v7
}

