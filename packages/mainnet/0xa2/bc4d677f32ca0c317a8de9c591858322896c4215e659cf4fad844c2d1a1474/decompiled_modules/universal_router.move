module 0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::universal_router {
    struct DeepBalanceKey has copy, drop, store {
        dummy_field: bool,
    }

    struct PathIndex has copy, drop, store {
        value: u64,
    }

    struct Treasury has store, key {
        id: 0x2::object::UID,
        fee_on: bool,
        balances: 0x2::bag::Bag,
        deepbook_account_cap: 0xdee9::custodian_v2::AccountCap,
    }

    struct Path<phantom T0, phantom T1> has store {
        coin_in: 0x1::option::Option<0x2::coin::Coin<T0>>,
        coin_out: 0x1::option::Option<0x2::coin::Coin<T1>>,
    }

    struct Route has store {
        trade_id: u256,
        amount_in: u64,
        current: u64,
        paths: 0x2::bag::Bag,
    }

    struct Trade<phantom T0, phantom T1> {
        trade_id: u256,
        amount_in: u64,
        amount_out_expected: u64,
        slippage: u64,
        deadline: u64,
        coin_in: 0x2::coin::Coin<T0>,
        coin_out: 0x2::coin::Coin<T1>,
        routes: vector<Route>,
        commission: 0x1::option::Option<0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::commission::Commission>,
    }

    struct Collect has copy, drop, store {
        swapper: address,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct Withdraw has copy, drop, store {
        sender: address,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct Swap has copy, drop, store {
        swapper: address,
        partner: 0x1::option::Option<address>,
        trade_id: u256,
        coin_in: 0x1::type_name::TypeName,
        coin_out: 0x1::type_name::TypeName,
        amount_in: u64,
        amount_out: u64,
    }

    struct DeepDeposit has copy, drop, store {
        amount: u64,
        sender: address,
    }

    struct DeepWithdraw has copy, drop, store {
        amount: u64,
        sender: address,
    }

    public fun aftermath_swap_exact_input<T0, T1, T2>(arg0: &mut Route, arg1: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg2: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>, arg3: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg4: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg5: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg6: &mut 0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg7: u64, arg8: &0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::versioned::Versioned, arg9: &mut 0x2::tx_context::TxContext) {
        0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::versioned::check_version(arg8);
        let v0 = borrow_mut_current_path<T1, T2>(arg0);
        0x1::option::fill<0x2::coin::Coin<T2>>(&mut v0.coin_out, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::swap::swap_exact_in<T0, T1, T2>(arg2, arg1, arg3, arg4, arg5, arg6, 0x1::option::extract<0x2::coin::Coin<T1>>(&mut v0.coin_in), arg7, 1000000000000000000, arg9));
    }

    public fun blue_move_fun_swap_exact_base_for_quote<T0>(arg0: &mut Route, arg1: &mut 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::Configuration, arg2: &0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::versioned::Versioned, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::versioned::check_version(arg2);
        let v0 = borrow_mut_current_path<T0, 0x2::sui::SUI>(arg0);
        let (v1, v2) = 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::sell_returns<T0>(arg1, 0x1::option::extract<0x2::coin::Coin<T0>>(&mut v0.coin_in), 0, arg3, arg4);
        refund_if_necessary<T0>(v2, 0x2::tx_context::sender(arg4));
        0x1::option::fill<0x2::coin::Coin<0x2::sui::SUI>>(&mut v0.coin_out, v1);
    }

    public fun blue_move_fun_swap_exact_quote_for_base<T0>(arg0: &mut Route, arg1: &mut 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::Configuration, arg2: &mut 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::ThresholdConfig, arg3: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg4: u64, arg5: &0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::versioned::Versioned, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::versioned::check_version(arg5);
        let v0 = borrow_mut_current_path<0x2::sui::SUI, T0>(arg0);
        let (v1, v2) = 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::buy_returns_v2<T0>(arg1, arg2, 0x1::option::extract<0x2::coin::Coin<0x2::sui::SUI>>(&mut v0.coin_in), arg3, arg4, arg6, arg7);
        refund_if_necessary<0x2::sui::SUI>(v1, 0x2::tx_context::sender(arg7));
        0x1::option::fill<0x2::coin::Coin<T0>>(&mut v0.coin_out, v2);
    }

    public fun bluefin_swap_exact_x_to_y<T0, T1>(arg0: &mut Route, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: u128, arg4: &0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::versioned::check_version(arg4);
        let v0 = borrow_mut_current_path<T0, T1>(arg0);
        let v1 = 0x1::option::extract<0x2::coin::Coin<T0>>(&mut v0.coin_in);
        let (v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg5, arg1, arg2, 0x2::coin::into_balance<T0>(v1), 0x2::balance::zero<T1>(), true, true, 0x2::coin::value<T0>(&v1), 0, arg3);
        refund_if_necessary<T0>(0x2::coin::from_balance<T0>(v2, arg6), 0x2::tx_context::sender(arg6));
        0x1::option::fill<0x2::coin::Coin<T1>>(&mut v0.coin_out, 0x2::coin::from_balance<T1>(v3, arg6));
    }

    public fun bluefin_swap_exact_y_to_x<T0, T1>(arg0: &mut Route, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: u128, arg4: &0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::versioned::check_version(arg4);
        let v0 = borrow_mut_current_path<T1, T0>(arg0);
        let v1 = 0x1::option::extract<0x2::coin::Coin<T1>>(&mut v0.coin_in);
        let (v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg5, arg1, arg2, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(v1), false, true, 0x2::coin::value<T1>(&v1), 0, arg3);
        refund_if_necessary<T1>(0x2::coin::from_balance<T1>(v3, arg6), 0x2::tx_context::sender(arg6));
        0x1::option::fill<0x2::coin::Coin<T0>>(&mut v0.coin_out, 0x2::coin::from_balance<T0>(v2, arg6));
    }

    public fun bluemove_swap_exact_input<T0, T1>(arg0: &mut Route, arg1: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg2: &0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::versioned::Versioned, arg3: &mut 0x2::tx_context::TxContext) {
        0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::versioned::check_version(arg2);
        let v0 = borrow_mut_current_path<T0, T1>(arg0);
        let v1 = 0x1::option::extract<0x2::coin::Coin<T0>>(&mut v0.coin_in);
        0x1::option::fill<0x2::coin::Coin<T1>>(&mut v0.coin_out, 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::router::swap_exact_input_<T0, T1>(0x2::coin::value<T0>(&v1), v1, 0, arg1, arg3));
    }

    fun borrow_mut_current_path<T0, T1>(arg0: &mut Route) : &mut Path<T0, T1> {
        check_path_exists<T0, T1>(arg0);
        0x2::bag::borrow_mut<PathIndex, Path<T0, T1>>(&mut arg0.paths, path_index_key(arg0.current - 1))
    }

    public fun build<T0, T1>(arg0: &mut 0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::trade_id_tracker::TradeIdTracker, arg1: &mut 0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::partner_manager::PartnerRegistry, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: vector<u64>, arg7: 0x1::option::Option<0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::commission::Commission>, arg8: &0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::versioned::Versioned, arg9: &mut 0x2::tx_context::TxContext) : Trade<T0, T1> {
        0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::versioned::check_version(arg8);
        if (arg4 > 1000000) {
            abort 2
        };
        0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::trade_id_tracker::increment(arg0);
        let v0 = 0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::trade_id_tracker::current(arg0);
        let v1 = Trade<T0, T1>{
            trade_id            : v0,
            amount_in           : 0x2::coin::value<T0>(&arg2),
            amount_out_expected : arg3,
            slippage            : arg4,
            deadline            : arg5,
            coin_in             : arg2,
            coin_out            : 0x2::coin::zero<T1>(arg9),
            routes              : 0x1::vector::empty<Route>(),
            commission          : arg7,
        };
        if (0x1::option::is_some<0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::commission::Commission>(&arg7)) {
            let v2 = 0x1::option::borrow<0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::commission::Commission>(&arg7);
            if (0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::commission::on_input(v2)) {
                0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::partner_manager::collect_commission_if_necessary<T0>(arg1, &mut v1.coin_in, v2, arg9);
            };
        };
        let v3 = 0;
        while (!0x1::vector::is_empty<u64>(&arg6)) {
            let v4 = 0x1::vector::pop_back<u64>(&mut arg6);
            v3 = v3 + v4;
            let v5 = Route{
                trade_id  : v0,
                amount_in : v4,
                current   : 0,
                paths     : 0x2::bag::new(arg9),
            };
            0x1::vector::push_back<Route>(&mut v1.routes, v5);
        };
        if (v3 != 0x2::coin::value<T0>(&v1.coin_in)) {
            abort 6
        };
        v1
    }

    public fun cetus_swap_exact_x_to_y<T0, T1>(arg0: &mut Route, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: u128, arg4: &0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::versioned::check_version(arg4);
        let v0 = borrow_mut_current_path<T0, T1>(arg0);
        let v1 = 0x1::option::extract<0x2::coin::Coin<T0>>(&mut v0.coin_in);
        let (v2, v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, true, true, 0x2::coin::value<T0>(&v1), arg3, arg5);
        let v5 = v4;
        refund_if_necessary<T0>(v1, 0x2::tx_context::sender(arg6));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v5), arg6)), 0x2::balance::zero<T1>(), v5);
        refund_if_necessary<T0>(0x2::coin::from_balance<T0>(v2, arg6), 0x2::tx_context::sender(arg6));
        0x1::option::fill<0x2::coin::Coin<T1>>(&mut v0.coin_out, 0x2::coin::from_balance<T1>(v3, arg6));
    }

    public fun cetus_swap_exact_y_to_x<T0, T1>(arg0: &mut Route, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: u128, arg4: &0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::versioned::check_version(arg4);
        let v0 = borrow_mut_current_path<T1, T0>(arg0);
        let v1 = 0x1::option::extract<0x2::coin::Coin<T1>>(&mut v0.coin_in);
        let (v2, v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, false, true, 0x2::coin::value<T1>(&v1), arg3, arg5);
        let v5 = v4;
        refund_if_necessary<T1>(v1, 0x2::tx_context::sender(arg6));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v5), arg6)), v5);
        refund_if_necessary<T1>(0x2::coin::from_balance<T1>(v3, arg6), 0x2::tx_context::sender(arg6));
        0x1::option::fill<0x2::coin::Coin<T0>>(&mut v0.coin_out, 0x2::coin::from_balance<T0>(v2, arg6));
    }

    fun check_path_exists<T0, T1>(arg0: &Route) {
        if (!0x2::bag::contains_with_type<PathIndex, Path<T0, T1>>(&arg0.paths, path_index_key(arg0.current - 1))) {
            abort 4
        };
    }

    fun collect<T0>(arg0: &mut Treasury, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, 0x1::type_name::get<T0>())) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, 0x1::type_name::get<T0>(), 0x2::balance::zero<T0>());
        };
        0x2::coin::put<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, 0x1::type_name::get<T0>()), arg1);
        let v0 = Collect{
            swapper   : 0x2::tx_context::sender(arg2),
            coin_type : 0x1::type_name::get<T0>(),
            amount    : 0x2::coin::value<T0>(&arg1),
        };
        0x2::event::emit<Collect>(v0);
    }

    fun deepbook_prune_input<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        refund_if_necessary<T0>(0x2::coin::split<T0>(arg0, 0x2::coin::value<T0>(arg0) % arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public fun deepbook_swap_exact_base_for_quote<T0, T1>(arg0: &mut Treasury, arg1: &mut Route, arg2: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg3: u64, arg4: &0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::versioned::check_version(arg4);
        let v0 = borrow_mut_current_path<T0, T1>(arg1);
        let v1 = 0x1::option::extract<0x2::coin::Coin<T0>>(&mut v0.coin_in);
        let v2 = &mut v1;
        deepbook_prune_input<T0>(v2, arg3, arg6);
        let (v3, v4, _) = 0xdee9::clob_v2::swap_exact_base_for_quote<T0, T1>(arg2, 0x2::clock::timestamp_ms(arg5), &arg0.deepbook_account_cap, 0x2::coin::value<T0>(&v1), v1, 0x2::coin::zero<T1>(arg6), arg5, arg6);
        refund_if_necessary<T0>(v3, 0x2::tx_context::sender(arg6));
        0x1::option::fill<0x2::coin::Coin<T1>>(&mut v0.coin_out, v4);
    }

    public fun deepbook_swap_exact_quote_for_base<T0, T1>(arg0: &mut Treasury, arg1: &mut Route, arg2: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg3: &0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::versioned::check_version(arg3);
        let v0 = borrow_mut_current_path<T1, T0>(arg1);
        let v1 = 0x1::option::extract<0x2::coin::Coin<T1>>(&mut v0.coin_in);
        let (v2, v3, _) = 0xdee9::clob_v2::swap_exact_quote_for_base<T0, T1>(arg2, 0x2::clock::timestamp_ms(arg4), &arg0.deepbook_account_cap, 0x2::coin::value<T1>(&v1), arg4, v1, arg5);
        refund_if_necessary<T1>(v3, 0x2::tx_context::sender(arg5));
        0x1::option::fill<0x2::coin::Coin<T0>>(&mut v0.coin_out, v2);
    }

    public fun deepbook_v3_swap_exact_base_for_quote<T0, T1>(arg0: &mut Treasury, arg1: &mut Route, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: u64, arg4: &0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::versioned::check_version(arg4);
        let v0 = borrow_mut_current_path<T0, T1>(arg1);
        let v1 = DeepBalanceKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<DeepBalanceKey, 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(&mut arg0.id, v1);
        assert!(0x2::balance::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v2) >= arg3, 7);
        let (v3, v4, v5) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T0, T1>(arg2, 0x1::option::extract<0x2::coin::Coin<T0>>(&mut v0.coin_in), 0x2::coin::take<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v2, arg3, arg6), 0, arg5, arg6);
        0x2::coin::put<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v2, v5);
        refund_if_necessary<T0>(v3, 0x2::tx_context::sender(arg6));
        0x1::option::fill<0x2::coin::Coin<T1>>(&mut v0.coin_out, v4);
    }

    public fun deepbook_v3_swap_exact_quote_for_base<T0, T1>(arg0: &mut Treasury, arg1: &mut Route, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: u64, arg4: &0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::versioned::check_version(arg4);
        let v0 = borrow_mut_current_path<T1, T0>(arg1);
        let v1 = DeepBalanceKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<DeepBalanceKey, 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(&mut arg0.id, v1);
        assert!(0x2::balance::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v2) >= arg3, 7);
        let (v3, v4, v5) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T0, T1>(arg2, 0x1::option::extract<0x2::coin::Coin<T1>>(&mut v0.coin_in), 0x2::coin::take<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v2, arg3, arg6), 0, arg5, arg6);
        0x2::coin::put<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v2, v5);
        refund_if_necessary<T1>(v4, 0x2::tx_context::sender(arg6));
        0x1::option::fill<0x2::coin::Coin<T0>>(&mut v0.coin_out, v3);
    }

    public entry fun deposit_deep(arg0: &0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::admin_cap::AdminCap, arg1: &mut Treasury, arg2: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg3: &0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::versioned::Versioned, arg4: &0x2::tx_context::TxContext) {
        0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::versioned::check_version(arg3);
        let v0 = DeepBalanceKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<DeepBalanceKey>(&arg1.id, v0)) {
            let v1 = DeepBalanceKey{dummy_field: false};
            0x2::dynamic_field::add<DeepBalanceKey, 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(&mut arg1.id, v1, 0x2::balance::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>());
        };
        let v2 = DeepBalanceKey{dummy_field: false};
        0x2::coin::put<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(0x2::dynamic_field::borrow_mut<DeepBalanceKey, 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(&mut arg1.id, v2), arg2);
        let v3 = DeepDeposit{
            amount : 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg2),
            sender : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<DeepDeposit>(v3);
    }

    fun extract_from_current_path<T0, T1>(arg0: &mut Route) : 0x2::coin::Coin<T1> {
        check_path_exists<T0, T1>(arg0);
        let Path {
            coin_in  : v0,
            coin_out : v1,
        } = 0x2::bag::remove<PathIndex, Path<T0, T1>>(&mut arg0.paths, path_index_key(arg0.current - 1));
        0x1::option::destroy_none<0x2::coin::Coin<T0>>(v0);
        0x1::option::destroy_some<0x2::coin::Coin<T1>>(v1)
    }

    public fun finish_routing<T0, T1, T2>(arg0: &mut Trade<T0, T1>, arg1: Route, arg2: &0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::versioned::Versioned) {
        0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::versioned::check_version(arg2);
        if (arg0.trade_id != arg1.trade_id) {
            abort 3
        };
        let v0 = &mut arg1;
        let Route {
            trade_id  : _,
            amount_in : _,
            current   : _,
            paths     : v4,
        } = arg1;
        0x2::bag::destroy_empty(v4);
        0x2::coin::join<T1>(&mut arg0.coin_out, extract_from_current_path<T2, T1>(v0));
    }

    public fun flowx_clmm_swap_exact_input<T0, T1>(arg0: &mut Route, arg1: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg2: u64, arg3: u128, arg4: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg5: &0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::versioned::Versioned, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::versioned::check_version(arg5);
        let v0 = borrow_mut_current_path<T0, T1>(arg0);
        0x1::option::fill<0x2::coin::Coin<T1>>(&mut v0.coin_out, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::swap_router::swap_exact_input<T0, T1>(arg1, arg2, 0x1::option::extract<0x2::coin::Coin<T0>>(&mut v0.coin_in), 0, arg3, 18446744073709551615, arg4, arg6, arg7));
    }

    public fun flowx_pmm_swap_exact_base_for_quote<T0, T1>(arg0: &mut Route, arg1: &mut 0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::state::State, arg2: &mut 0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::pool::Pool<T0, T1>, arg3: 0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::quote::Quote<T0, T1>, arg4: vector<vector<u8>>, arg5: &0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::versioned::Versioned, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::versioned::check_version(arg5);
        let v0 = borrow_mut_current_path<T0, T1>(arg0);
        let v1 = 0x1::option::extract<0x2::coin::Coin<T0>>(&mut v0.coin_in);
        refund_if_necessary<T0>(v1, 0x2::tx_context::sender(arg7));
        0x1::option::fill<0x2::coin::Coin<T1>>(&mut v0.coin_out, 0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::converter::convert_base_for_quote<T0, T1>(arg1, arg2, &mut v1, arg3, arg4, arg6, arg7));
    }

    public fun flowx_pmm_swap_exact_quote_for_base<T0, T1>(arg0: &mut Route, arg1: &mut 0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::state::State, arg2: &mut 0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::pool::Pool<T0, T1>, arg3: 0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::quote::Quote<T1, T0>, arg4: vector<vector<u8>>, arg5: &0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::versioned::Versioned, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::versioned::check_version(arg5);
        let v0 = borrow_mut_current_path<T1, T0>(arg0);
        let v1 = 0x1::option::extract<0x2::coin::Coin<T1>>(&mut v0.coin_in);
        refund_if_necessary<T1>(v1, 0x2::tx_context::sender(arg7));
        0x1::option::fill<0x2::coin::Coin<T0>>(&mut v0.coin_out, 0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::converter::convert_quote_for_base<T0, T1>(arg1, arg2, &mut v1, arg3, arg4, arg6, arg7));
    }

    public fun flowx_swap_exact_input<T0, T1>(arg0: &mut Route, arg1: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg2: &0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::versioned::Versioned, arg3: &mut 0x2::tx_context::TxContext) {
        0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::versioned::check_version(arg2);
        let v0 = borrow_mut_current_path<T0, T1>(arg0);
        0x1::option::fill<0x2::coin::Coin<T1>>(&mut v0.coin_out, 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_input_direct<T0, T1>(arg1, 0x1::option::extract<0x2::coin::Coin<T0>>(&mut v0.coin_in), arg3));
    }

    public fun fun_7k_swap_exact_base_for_quote<T0>(arg0: &mut Route, arg1: &mut 0xc42fd2cde04281a5d2659e5c96c89ba625ddeef9b622713c3d6aa1efd5ea21ab::fun_7k::Configuration, arg2: &0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::versioned::Versioned, arg3: &mut 0x2::tx_context::TxContext) {
        0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::versioned::check_version(arg2);
        let v0 = borrow_mut_current_path<T0, 0x2::sui::SUI>(arg0);
        let v1 = 0x1::option::extract<0x2::coin::Coin<T0>>(&mut v0.coin_in);
        refund_if_necessary<T0>(v1, 0x2::tx_context::sender(arg3));
        0x1::option::fill<0x2::coin::Coin<0x2::sui::SUI>>(&mut v0.coin_out, 0xc42fd2cde04281a5d2659e5c96c89ba625ddeef9b622713c3d6aa1efd5ea21ab::fun_7k::sell_<T0>(arg1, &mut v1, true, 0, arg3));
    }

    public fun fun_7k_swap_exact_quote_for_base<T0>(arg0: &mut Route, arg1: &mut 0xc42fd2cde04281a5d2659e5c96c89ba625ddeef9b622713c3d6aa1efd5ea21ab::fun_7k::Configuration, arg2: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg3: &0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::versioned::check_version(arg3);
        let v0 = borrow_mut_current_path<0x2::sui::SUI, T0>(arg0);
        let v1 = 0x1::option::extract<0x2::coin::Coin<0x2::sui::SUI>>(&mut v0.coin_in);
        let (v2, v3) = 0xc42fd2cde04281a5d2659e5c96c89ba625ddeef9b622713c3d6aa1efd5ea21ab::fun_7k::buy_<T0>(arg1, &mut v1, true, 0, arg4, arg2, arg5);
        0xc42fd2cde04281a5d2659e5c96c89ba625ddeef9b622713c3d6aa1efd5ea21ab::locked_coin::destroy_zero<T0>(v3);
        refund_if_necessary<0x2::sui::SUI>(v1, 0x2::tx_context::sender(arg5));
        0x1::option::fill<0x2::coin::Coin<T0>>(&mut v0.coin_out, v2);
    }

    public fun hop_fun_swap_exact_base_for_quote<T0>(arg0: &mut Route, arg1: &0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::meme::MemeConfig, arg2: &mut 0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::meme::BondingCurve<T0>, arg3: &0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::versioned::Versioned, arg4: &mut 0x2::tx_context::TxContext) {
        0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::versioned::check_version(arg3);
        let v0 = borrow_mut_current_path<T0, 0x2::sui::SUI>(arg0);
        0x1::option::fill<0x2::coin::Coin<0x2::sui::SUI>>(&mut v0.coin_out, 0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::meme::sell_returns<T0>(arg2, arg1, 0x1::option::extract<0x2::coin::Coin<T0>>(&mut v0.coin_in), 0, arg4));
    }

    public fun hop_fun_swap_exact_quote_for_base<T0>(arg0: &mut Route, arg1: &0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::meme::MemeConfig, arg2: &mut 0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::meme::BondingCurve<T0>, arg3: u64, arg4: &0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::versioned::Versioned, arg5: &mut 0x2::tx_context::TxContext) {
        0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::versioned::check_version(arg4);
        let v0 = borrow_mut_current_path<0x2::sui::SUI, T0>(arg0);
        let (v1, v2) = 0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::meme::buy_returns<T0>(arg2, arg1, 0x1::option::extract<0x2::coin::Coin<0x2::sui::SUI>>(&mut v0.coin_in), arg3, 0, 0x2::tx_context::sender(arg5), arg5);
        refund_if_necessary<0x2::sui::SUI>(v1, 0x2::tx_context::sender(arg5));
        0x1::option::fill<0x2::coin::Coin<T0>>(&mut v0.coin_out, v2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Treasury{
            id                   : 0x2::object::new(arg0),
            fee_on               : false,
            balances             : 0x2::bag::new(arg0),
            deepbook_account_cap : 0xdee9::clob_v2::create_account(arg0),
        };
        0x2::transfer::share_object<Treasury>(v0);
    }

    fun initialize_path<T0, T1>(arg0: 0x2::coin::Coin<T0>) : Path<T0, T1> {
        Path<T0, T1>{
            coin_in  : 0x1::option::some<0x2::coin::Coin<T0>>(arg0),
            coin_out : 0x1::option::none<0x2::coin::Coin<T1>>(),
        }
    }

    public fun kriya_clmm_swap_exact_x_to_y<T0, T1>(arg0: &mut Route, arg1: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg2: u128, arg3: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg4: &0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::versioned::check_version(arg4);
        let v0 = borrow_mut_current_path<T0, T1>(arg0);
        let v1 = 0x1::option::extract<0x2::coin::Coin<T0>>(&mut v0.coin_in);
        let (v2, v3, v4) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::flash_swap<T0, T1>(arg1, true, true, 0x2::coin::value<T0>(&v1), arg2, arg5, arg3, arg6);
        let v5 = v4;
        0x2::coin::join<T0>(&mut v1, 0x2::coin::from_balance<T0>(v2, arg6));
        0x1::option::fill<0x2::coin::Coin<T1>>(&mut v0.coin_out, 0x2::coin::from_balance<T1>(v3, arg6));
        let (v6, _) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::swap_receipt_debts(&v5);
        refund_if_necessary<T0>(v1, 0x2::tx_context::sender(arg6));
        0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::repay_flash_swap<T0, T1>(arg1, v5, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v1, v6, arg6)), 0x2::balance::zero<T1>(), arg3, arg6);
    }

    public fun kriya_clmm_swap_exact_y_to_x<T0, T1>(arg0: &mut Route, arg1: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg2: u128, arg3: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg4: &0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::versioned::check_version(arg4);
        let v0 = borrow_mut_current_path<T1, T0>(arg0);
        let v1 = 0x1::option::extract<0x2::coin::Coin<T1>>(&mut v0.coin_in);
        let (v2, v3, v4) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::flash_swap<T0, T1>(arg1, false, true, 0x2::coin::value<T1>(&v1), arg2, arg5, arg3, arg6);
        let v5 = v4;
        0x2::coin::join<T1>(&mut v1, 0x2::coin::from_balance<T1>(v3, arg6));
        0x1::option::fill<0x2::coin::Coin<T0>>(&mut v0.coin_out, 0x2::coin::from_balance<T0>(v2, arg6));
        let (_, v7) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::swap_receipt_debts(&v5);
        refund_if_necessary<T1>(v1, 0x2::tx_context::sender(arg6));
        0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::repay_flash_swap<T0, T1>(arg1, v5, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v1, v7, arg6)), arg3, arg6);
    }

    public fun kriya_swap_exact_x_to_y<T0, T1>(arg0: &mut Route, arg1: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg2: &0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::versioned::Versioned, arg3: &mut 0x2::tx_context::TxContext) {
        0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::versioned::check_version(arg2);
        let v0 = borrow_mut_current_path<T0, T1>(arg0);
        let v1 = 0x1::option::extract<0x2::coin::Coin<T0>>(&mut v0.coin_in);
        0x1::option::fill<0x2::coin::Coin<T1>>(&mut v0.coin_out, 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::swap_token_x<T0, T1>(arg1, v1, 0x2::coin::value<T0>(&v1), 0, arg3));
    }

    public fun kriya_swap_exact_y_to_x<T0, T1>(arg0: &mut Route, arg1: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg2: &0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::versioned::Versioned, arg3: &mut 0x2::tx_context::TxContext) {
        0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::versioned::check_version(arg2);
        let v0 = borrow_mut_current_path<T1, T0>(arg0);
        let v1 = 0x1::option::extract<0x2::coin::Coin<T1>>(&mut v0.coin_in);
        0x1::option::fill<0x2::coin::Coin<T0>>(&mut v0.coin_out, 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::swap_token_y<T0, T1>(arg1, v1, 0x2::coin::value<T1>(&v1), 0, arg3));
    }

    public fun next<T0, T1, T2>(arg0: &mut Route, arg1: &0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::versioned::Versioned) {
        0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::versioned::check_version(arg1);
        let v0 = extract_from_current_path<T0, T1>(arg0);
        push<T1, T2>(arg0, initialize_path<T1, T2>(v0));
    }

    fun path_index_key(arg0: u64) : PathIndex {
        PathIndex{value: arg0}
    }

    fun pay_router_fee_if_necessary<T0>(arg0: &mut Treasury, arg1: &mut 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg0.fee_on && 0x2::coin::value<T0>(arg1) > arg2) {
            collect<T0>(arg0, 0x2::coin::split<T0>(arg1, 0x2::coin::value<T0>(arg1) - arg2, arg3), arg3);
        };
    }

    fun push<T0, T1>(arg0: &mut Route, arg1: Path<T0, T1>) {
        0x2::bag::add<PathIndex, Path<T0, T1>>(&mut arg0.paths, path_index_key(arg0.current), arg1);
        arg0.current = arg0.current + 1;
    }

    fun refund_if_necessary<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    public entry fun set_fee_on(arg0: &0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::admin_cap::AdminCap, arg1: &mut Treasury, arg2: bool, arg3: &0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::versioned::Versioned) {
        0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::versioned::check_version(arg3);
        arg1.fee_on = arg2;
    }

    public fun settle<T0, T1>(arg0: &mut Treasury, arg1: &mut 0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::partner_manager::PartnerRegistry, arg2: Trade<T0, T1>, arg3: &0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::versioned::check_version(arg3);
        let Trade {
            trade_id            : v0,
            amount_in           : v1,
            amount_out_expected : v2,
            slippage            : v3,
            deadline            : v4,
            coin_in             : v5,
            coin_out            : v6,
            routes              : v7,
            commission          : v8,
        } = arg2;
        let v9 = v8;
        let v10 = v7;
        let v11 = v6;
        if (!0x1::vector::is_empty<Route>(&v10)) {
            abort 5
        };
        if (0x2::clock::timestamp_ms(arg4) > v4) {
            abort 0
        };
        if (0x2::coin::value<T1>(&v11) < 0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::math::mul_div(1000000 - v3, v2, 1000000)) {
            abort 1
        };
        0x1::vector::destroy_empty<Route>(v10);
        refund_if_necessary<T0>(v5, 0x2::tx_context::sender(arg5));
        let v12 = &mut v11;
        pay_router_fee_if_necessary<T1>(arg0, v12, v2, arg5);
        let v13 = if (0x1::option::is_some<0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::commission::Commission>(&v9)) {
            let v14 = 0x1::option::destroy_some<0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::commission::Commission>(v9);
            if (!0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::commission::on_input(&v14)) {
                0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::partner_manager::collect_commission_if_necessary<T1>(arg1, &mut v11, &v14, arg5);
            };
            0x1::option::some<address>(0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::commission::partner(&v14))
        } else {
            0x1::option::none<address>()
        };
        let v15 = Swap{
            swapper    : 0x2::tx_context::sender(arg5),
            partner    : v13,
            trade_id   : v0,
            coin_in    : 0x1::type_name::get<T0>(),
            coin_out   : 0x1::type_name::get<T1>(),
            amount_in  : v1,
            amount_out : 0x2::coin::value<T1>(&v11),
        };
        0x2::event::emit<Swap>(v15);
        v11
    }

    public fun start_routing<T0, T1, T2>(arg0: &mut Trade<T0, T1>, arg1: &0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::versioned::Versioned, arg2: &mut 0x2::tx_context::TxContext) : Route {
        0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::versioned::check_version(arg1);
        let v0 = 0x1::vector::pop_back<Route>(&mut arg0.routes);
        let v1 = &mut v0;
        push<T0, T2>(v1, initialize_path<T0, T2>(0x2::coin::split<T0>(&mut arg0.coin_in, v0.amount_in, arg2)));
        v0
    }

    public fun turbos_fun_swap_exact_base_for_quote<T0>(arg0: &mut Route, arg1: &mut 0x96e1396c8a771c8ae404b86328dc27e7b66af39847a31926980c96dbc1096a15::turbospump::Configuration, arg2: &0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::versioned::Versioned, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::versioned::check_version(arg2);
        let v0 = borrow_mut_current_path<T0, 0x2::sui::SUI>(arg0);
        let v1 = 0x1::option::extract<0x2::coin::Coin<T0>>(&mut v0.coin_in);
        let (v2, v3) = 0x96e1396c8a771c8ae404b86328dc27e7b66af39847a31926980c96dbc1096a15::turbospump::sell_with_return<T0>(arg1, v1, 0x2::coin::value<T0>(&v1), 0, true, arg3, arg4);
        refund_if_necessary<T0>(v3, 0x2::tx_context::sender(arg4));
        0x1::option::fill<0x2::coin::Coin<0x2::sui::SUI>>(&mut v0.coin_out, v2);
    }

    public fun turbos_fun_swap_exact_quote_for_base<T0>(arg0: &mut Route, arg1: &mut 0x96e1396c8a771c8ae404b86328dc27e7b66af39847a31926980c96dbc1096a15::turbospump::Configuration, arg2: &0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::versioned::Versioned, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::versioned::check_version(arg2);
        let v0 = borrow_mut_current_path<0x2::sui::SUI, T0>(arg0);
        let v1 = 0x1::option::extract<0x2::coin::Coin<0x2::sui::SUI>>(&mut v0.coin_in);
        let (v2, v3) = 0x96e1396c8a771c8ae404b86328dc27e7b66af39847a31926980c96dbc1096a15::turbospump::buy_with_return<T0>(arg1, v1, 0x2::coin::value<0x2::sui::SUI>(&v1), 0, true, arg3, arg4);
        refund_if_necessary<0x2::sui::SUI>(v2, 0x2::tx_context::sender(arg4));
        0x1::option::fill<0x2::coin::Coin<T0>>(&mut v0.coin_out, v3);
    }

    public fun turbos_swap_exact_x_to_y<T0, T1, T2>(arg0: &mut Route, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: u128, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::versioned::check_version(arg4);
        let v0 = borrow_mut_current_path<T0, T1>(arg0);
        let v1 = 0x1::option::extract<0x2::coin::Coin<T0>>(&mut v0.coin_in);
        let (v2, v3) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_with_return_<T0, T1, T2>(arg1, 0x1::vector::singleton<0x2::coin::Coin<T0>>(v1), 0x2::coin::value<T0>(&v1), 0, arg2, true, 0x2::tx_context::sender(arg6), 18446744073709551615, arg5, arg3, arg6);
        refund_if_necessary<T0>(v3, 0x2::tx_context::sender(arg6));
        0x1::option::fill<0x2::coin::Coin<T1>>(&mut v0.coin_out, v2);
    }

    public fun turbos_swap_exact_y_to_x<T0, T1, T2>(arg0: &mut Route, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: u128, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::versioned::check_version(arg4);
        let v0 = borrow_mut_current_path<T1, T0>(arg0);
        let v1 = 0x1::option::extract<0x2::coin::Coin<T1>>(&mut v0.coin_in);
        let (v2, v3) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a_with_return_<T0, T1, T2>(arg1, 0x1::vector::singleton<0x2::coin::Coin<T1>>(v1), 0x2::coin::value<T1>(&v1), 0, arg2, true, 0x2::tx_context::sender(arg6), 18446744073709551615, arg5, arg3, arg6);
        refund_if_necessary<T1>(v3, 0x2::tx_context::sender(arg6));
        0x1::option::fill<0x2::coin::Coin<T0>>(&mut v0.coin_out, v2);
    }

    public entry fun withdraw<T0>(arg0: &0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::admin_cap::AdminCap, arg1: &mut Treasury, arg2: u64, arg3: address, arg4: &0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::versioned::Versioned, arg5: &mut 0x2::tx_context::TxContext) {
        0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::versioned::check_version(arg4);
        let v0 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.balances, 0x1::type_name::get<T0>());
        let v1 = 0x2::math::min(arg2, 0x2::balance::value<T0>(v0));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(v0, v1, arg5), arg3);
        let v2 = Withdraw{
            sender    : 0x2::tx_context::sender(arg5),
            coin_type : 0x1::type_name::get<T0>(),
            amount    : v1,
        };
        0x2::event::emit<Withdraw>(v2);
    }

    public entry fun withdraw_deep(arg0: &0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::admin_cap::AdminCap, arg1: &mut Treasury, arg2: u64, arg3: address, arg4: &0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::versioned::Versioned, arg5: &mut 0x2::tx_context::TxContext) {
        0x3ea2c0ece58d9aacad69ced54e6242b40f63925410ad92ccc46317eb75194136::versioned::check_version(arg4);
        let v0 = DeepBalanceKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<DeepBalanceKey, 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(&mut arg1.id, v0);
        let v2 = 0x2::math::min(arg2, 0x2::balance::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(0x2::coin::take<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v1, v2, arg5), arg3);
        let v3 = DeepWithdraw{
            amount : v2,
            sender : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<DeepWithdraw>(v3);
    }

    // decompiled from Move bytecode v6
}

