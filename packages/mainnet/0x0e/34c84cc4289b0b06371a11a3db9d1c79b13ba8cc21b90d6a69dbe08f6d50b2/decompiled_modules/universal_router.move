module 0xe34c84cc4289b0b06371a11a3db9d1c79b13ba8cc21b90d6a69dbe08f6d50b2::universal_router {
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
        commission: 0x1::option::Option<0xe34c84cc4289b0b06371a11a3db9d1c79b13ba8cc21b90d6a69dbe08f6d50b2::commission::Commission>,
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

    public fun aftermath_swap_exact_input<T0, T1, T2>(arg0: &mut Route, arg1: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg2: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>, arg3: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg4: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg5: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg6: &mut 0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg7: u64, arg8: &0xe34c84cc4289b0b06371a11a3db9d1c79b13ba8cc21b90d6a69dbe08f6d50b2::versioned::Versioned, arg9: &mut 0x2::tx_context::TxContext) {
        0xe34c84cc4289b0b06371a11a3db9d1c79b13ba8cc21b90d6a69dbe08f6d50b2::versioned::check_version(arg8);
        let v0 = borrow_mut_current_path<T1, T2>(arg0);
        0x1::option::fill<0x2::coin::Coin<T2>>(&mut v0.coin_out, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::swap::swap_exact_in<T0, T1, T2>(arg2, arg1, arg3, arg4, arg5, arg6, 0x1::option::extract<0x2::coin::Coin<T1>>(&mut v0.coin_in), arg7, 1000000000000000000, arg9));
    }

    public fun bluemove_swap_exact_input<T0, T1>(arg0: &mut Route, arg1: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg2: &0xe34c84cc4289b0b06371a11a3db9d1c79b13ba8cc21b90d6a69dbe08f6d50b2::versioned::Versioned, arg3: &mut 0x2::tx_context::TxContext) {
        0xe34c84cc4289b0b06371a11a3db9d1c79b13ba8cc21b90d6a69dbe08f6d50b2::versioned::check_version(arg2);
        let v0 = borrow_mut_current_path<T0, T1>(arg0);
        let v1 = 0x1::option::extract<0x2::coin::Coin<T0>>(&mut v0.coin_in);
        0x1::option::fill<0x2::coin::Coin<T1>>(&mut v0.coin_out, 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::router::swap_exact_input_<T0, T1>(0x2::coin::value<T0>(&v1), v1, 0, arg1, arg3));
    }

    fun borrow_mut_current_path<T0, T1>(arg0: &mut Route) : &mut Path<T0, T1> {
        check_path_exists<T0, T1>(arg0);
        0x2::bag::borrow_mut<PathIndex, Path<T0, T1>>(&mut arg0.paths, path_index_key(arg0.current - 1))
    }

    public fun build<T0, T1>(arg0: &mut 0xe34c84cc4289b0b06371a11a3db9d1c79b13ba8cc21b90d6a69dbe08f6d50b2::trade_id_tracker::TradeIdTracker, arg1: &mut 0xe34c84cc4289b0b06371a11a3db9d1c79b13ba8cc21b90d6a69dbe08f6d50b2::partner_manager::PartnerRegistry, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: vector<u64>, arg7: 0x1::option::Option<0xe34c84cc4289b0b06371a11a3db9d1c79b13ba8cc21b90d6a69dbe08f6d50b2::commission::Commission>, arg8: &0xe34c84cc4289b0b06371a11a3db9d1c79b13ba8cc21b90d6a69dbe08f6d50b2::versioned::Versioned, arg9: &mut 0x2::tx_context::TxContext) : Trade<T0, T1> {
        0xe34c84cc4289b0b06371a11a3db9d1c79b13ba8cc21b90d6a69dbe08f6d50b2::versioned::check_version(arg8);
        if (arg4 > 1000000) {
            abort 2
        };
        0xe34c84cc4289b0b06371a11a3db9d1c79b13ba8cc21b90d6a69dbe08f6d50b2::trade_id_tracker::increment(arg0);
        let v0 = 0xe34c84cc4289b0b06371a11a3db9d1c79b13ba8cc21b90d6a69dbe08f6d50b2::trade_id_tracker::current(arg0);
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
        if (0x1::option::is_some<0xe34c84cc4289b0b06371a11a3db9d1c79b13ba8cc21b90d6a69dbe08f6d50b2::commission::Commission>(&arg7)) {
            let v2 = 0x1::option::borrow<0xe34c84cc4289b0b06371a11a3db9d1c79b13ba8cc21b90d6a69dbe08f6d50b2::commission::Commission>(&arg7);
            if (0xe34c84cc4289b0b06371a11a3db9d1c79b13ba8cc21b90d6a69dbe08f6d50b2::commission::on_input(v2)) {
                0xe34c84cc4289b0b06371a11a3db9d1c79b13ba8cc21b90d6a69dbe08f6d50b2::partner_manager::collect_commission_if_necessary<T0>(arg1, &mut v1.coin_in, v2, arg9);
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

    public fun cetus_swap_exact_x_to_y<T0, T1>(arg0: &mut Route, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: u128, arg4: &0xe34c84cc4289b0b06371a11a3db9d1c79b13ba8cc21b90d6a69dbe08f6d50b2::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xe34c84cc4289b0b06371a11a3db9d1c79b13ba8cc21b90d6a69dbe08f6d50b2::versioned::check_version(arg4);
        let v0 = borrow_mut_current_path<T0, T1>(arg0);
        let v1 = 0x1::option::extract<0x2::coin::Coin<T0>>(&mut v0.coin_in);
        let (v2, v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, true, true, 0x2::coin::value<T0>(&v1), arg3, arg5);
        let v5 = v4;
        refund_if_necessary<T0>(v1, 0x2::tx_context::sender(arg6));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v5), arg6)), 0x2::balance::zero<T1>(), v5);
        refund_if_necessary<T0>(0x2::coin::from_balance<T0>(v2, arg6), 0x2::tx_context::sender(arg6));
        0x1::option::fill<0x2::coin::Coin<T1>>(&mut v0.coin_out, 0x2::coin::from_balance<T1>(v3, arg6));
    }

    public fun cetus_swap_exact_y_to_x<T0, T1>(arg0: &mut Route, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: u128, arg4: &0xe34c84cc4289b0b06371a11a3db9d1c79b13ba8cc21b90d6a69dbe08f6d50b2::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xe34c84cc4289b0b06371a11a3db9d1c79b13ba8cc21b90d6a69dbe08f6d50b2::versioned::check_version(arg4);
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

    public fun deepbook_swap_exact_base_for_quote<T0, T1>(arg0: &mut Treasury, arg1: &mut Route, arg2: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg3: u64, arg4: &0xe34c84cc4289b0b06371a11a3db9d1c79b13ba8cc21b90d6a69dbe08f6d50b2::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xe34c84cc4289b0b06371a11a3db9d1c79b13ba8cc21b90d6a69dbe08f6d50b2::versioned::check_version(arg4);
        let v0 = borrow_mut_current_path<T0, T1>(arg1);
        let v1 = 0x1::option::extract<0x2::coin::Coin<T0>>(&mut v0.coin_in);
        let v2 = &mut v1;
        deepbook_prune_input<T0>(v2, arg3, arg6);
        let (v3, v4, _) = 0xdee9::clob_v2::swap_exact_base_for_quote<T0, T1>(arg2, 0x2::clock::timestamp_ms(arg5), &arg0.deepbook_account_cap, 0x2::coin::value<T0>(&v1), v1, 0x2::coin::zero<T1>(arg6), arg5, arg6);
        refund_if_necessary<T0>(v3, 0x2::tx_context::sender(arg6));
        0x1::option::fill<0x2::coin::Coin<T1>>(&mut v0.coin_out, v4);
    }

    public fun deepbook_swap_exact_quote_for_base<T0, T1>(arg0: &mut Treasury, arg1: &mut Route, arg2: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg3: &0xe34c84cc4289b0b06371a11a3db9d1c79b13ba8cc21b90d6a69dbe08f6d50b2::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xe34c84cc4289b0b06371a11a3db9d1c79b13ba8cc21b90d6a69dbe08f6d50b2::versioned::check_version(arg3);
        let v0 = borrow_mut_current_path<T1, T0>(arg1);
        let v1 = 0x1::option::extract<0x2::coin::Coin<T1>>(&mut v0.coin_in);
        let (v2, v3, _) = 0xdee9::clob_v2::swap_exact_quote_for_base<T0, T1>(arg2, 0x2::clock::timestamp_ms(arg4), &arg0.deepbook_account_cap, 0x2::coin::value<T1>(&v1), arg4, v1, arg5);
        refund_if_necessary<T1>(v3, 0x2::tx_context::sender(arg5));
        0x1::option::fill<0x2::coin::Coin<T0>>(&mut v0.coin_out, v2);
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

    public fun finish_routing<T0, T1, T2>(arg0: &mut Trade<T0, T1>, arg1: Route, arg2: &0xe34c84cc4289b0b06371a11a3db9d1c79b13ba8cc21b90d6a69dbe08f6d50b2::versioned::Versioned) {
        0xe34c84cc4289b0b06371a11a3db9d1c79b13ba8cc21b90d6a69dbe08f6d50b2::versioned::check_version(arg2);
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

    public fun flowx_clmm_swap_exact_input<T0, T1>(arg0: &mut Route, arg1: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg2: u64, arg3: u128, arg4: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg5: &0xe34c84cc4289b0b06371a11a3db9d1c79b13ba8cc21b90d6a69dbe08f6d50b2::versioned::Versioned, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xe34c84cc4289b0b06371a11a3db9d1c79b13ba8cc21b90d6a69dbe08f6d50b2::versioned::check_version(arg5);
        let v0 = borrow_mut_current_path<T0, T1>(arg0);
        0x1::option::fill<0x2::coin::Coin<T1>>(&mut v0.coin_out, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::swap_router::swap_exact_input<T0, T1>(arg1, arg2, 0x1::option::extract<0x2::coin::Coin<T0>>(&mut v0.coin_in), 0, arg3, 18446744073709551615, arg4, arg6, arg7));
    }

    public fun flowx_swap_exact_input<T0, T1>(arg0: &mut Route, arg1: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg2: &0xe34c84cc4289b0b06371a11a3db9d1c79b13ba8cc21b90d6a69dbe08f6d50b2::versioned::Versioned, arg3: &mut 0x2::tx_context::TxContext) {
        0xe34c84cc4289b0b06371a11a3db9d1c79b13ba8cc21b90d6a69dbe08f6d50b2::versioned::check_version(arg2);
        let v0 = borrow_mut_current_path<T0, T1>(arg0);
        0x1::option::fill<0x2::coin::Coin<T1>>(&mut v0.coin_out, 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_input_direct<T0, T1>(arg1, 0x1::option::extract<0x2::coin::Coin<T0>>(&mut v0.coin_in), arg3));
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

    public fun kriya_clmm_swap_exact_x_to_y<T0, T1>(arg0: &mut Route, arg1: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg2: u128, arg3: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg4: &0xe34c84cc4289b0b06371a11a3db9d1c79b13ba8cc21b90d6a69dbe08f6d50b2::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xe34c84cc4289b0b06371a11a3db9d1c79b13ba8cc21b90d6a69dbe08f6d50b2::versioned::check_version(arg4);
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

    public fun kriya_clmm_swap_exact_y_to_x<T0, T1>(arg0: &mut Route, arg1: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg2: u128, arg3: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg4: &0xe34c84cc4289b0b06371a11a3db9d1c79b13ba8cc21b90d6a69dbe08f6d50b2::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xe34c84cc4289b0b06371a11a3db9d1c79b13ba8cc21b90d6a69dbe08f6d50b2::versioned::check_version(arg4);
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

    public fun kriya_swap_exact_x_to_y<T0, T1>(arg0: &mut Route, arg1: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg2: &0xe34c84cc4289b0b06371a11a3db9d1c79b13ba8cc21b90d6a69dbe08f6d50b2::versioned::Versioned, arg3: &mut 0x2::tx_context::TxContext) {
        0xe34c84cc4289b0b06371a11a3db9d1c79b13ba8cc21b90d6a69dbe08f6d50b2::versioned::check_version(arg2);
        let v0 = borrow_mut_current_path<T0, T1>(arg0);
        let v1 = 0x1::option::extract<0x2::coin::Coin<T0>>(&mut v0.coin_in);
        0x1::option::fill<0x2::coin::Coin<T1>>(&mut v0.coin_out, 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::swap_token_x<T0, T1>(arg1, v1, 0x2::coin::value<T0>(&v1), 0, arg3));
    }

    public fun kriya_swap_exact_y_to_x<T0, T1>(arg0: &mut Route, arg1: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg2: &0xe34c84cc4289b0b06371a11a3db9d1c79b13ba8cc21b90d6a69dbe08f6d50b2::versioned::Versioned, arg3: &mut 0x2::tx_context::TxContext) {
        0xe34c84cc4289b0b06371a11a3db9d1c79b13ba8cc21b90d6a69dbe08f6d50b2::versioned::check_version(arg2);
        let v0 = borrow_mut_current_path<T1, T0>(arg0);
        let v1 = 0x1::option::extract<0x2::coin::Coin<T1>>(&mut v0.coin_in);
        0x1::option::fill<0x2::coin::Coin<T0>>(&mut v0.coin_out, 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::swap_token_y<T0, T1>(arg1, v1, 0x2::coin::value<T1>(&v1), 0, arg3));
    }

    public fun next<T0, T1, T2>(arg0: &mut Route, arg1: &0xe34c84cc4289b0b06371a11a3db9d1c79b13ba8cc21b90d6a69dbe08f6d50b2::versioned::Versioned) {
        0xe34c84cc4289b0b06371a11a3db9d1c79b13ba8cc21b90d6a69dbe08f6d50b2::versioned::check_version(arg1);
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

    public entry fun set_fee_on(arg0: &0xe34c84cc4289b0b06371a11a3db9d1c79b13ba8cc21b90d6a69dbe08f6d50b2::admin_cap::AdminCap, arg1: &mut Treasury, arg2: bool, arg3: &0xe34c84cc4289b0b06371a11a3db9d1c79b13ba8cc21b90d6a69dbe08f6d50b2::versioned::Versioned) {
        0xe34c84cc4289b0b06371a11a3db9d1c79b13ba8cc21b90d6a69dbe08f6d50b2::versioned::check_version(arg3);
        arg1.fee_on = arg2;
    }

    public fun settle<T0, T1>(arg0: &mut Treasury, arg1: &mut 0xe34c84cc4289b0b06371a11a3db9d1c79b13ba8cc21b90d6a69dbe08f6d50b2::partner_manager::PartnerRegistry, arg2: Trade<T0, T1>, arg3: &0xe34c84cc4289b0b06371a11a3db9d1c79b13ba8cc21b90d6a69dbe08f6d50b2::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xe34c84cc4289b0b06371a11a3db9d1c79b13ba8cc21b90d6a69dbe08f6d50b2::versioned::check_version(arg3);
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
        if (0x2::coin::value<T1>(&v11) < 0xe34c84cc4289b0b06371a11a3db9d1c79b13ba8cc21b90d6a69dbe08f6d50b2::math::mul_div(1000000 - v3, v2, 1000000)) {
            abort 1
        };
        0x1::vector::destroy_empty<Route>(v10);
        refund_if_necessary<T0>(v5, 0x2::tx_context::sender(arg5));
        let v12 = &mut v11;
        pay_router_fee_if_necessary<T1>(arg0, v12, v2, arg5);
        let v13 = if (0x1::option::is_some<0xe34c84cc4289b0b06371a11a3db9d1c79b13ba8cc21b90d6a69dbe08f6d50b2::commission::Commission>(&v9)) {
            let v14 = 0x1::option::destroy_some<0xe34c84cc4289b0b06371a11a3db9d1c79b13ba8cc21b90d6a69dbe08f6d50b2::commission::Commission>(v9);
            if (!0xe34c84cc4289b0b06371a11a3db9d1c79b13ba8cc21b90d6a69dbe08f6d50b2::commission::on_input(&v14)) {
                0xe34c84cc4289b0b06371a11a3db9d1c79b13ba8cc21b90d6a69dbe08f6d50b2::partner_manager::collect_commission_if_necessary<T1>(arg1, &mut v11, &v14, arg5);
            };
            0x1::option::some<address>(0xe34c84cc4289b0b06371a11a3db9d1c79b13ba8cc21b90d6a69dbe08f6d50b2::commission::partner(&v14))
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

    public fun start_routing<T0, T1, T2>(arg0: &mut Trade<T0, T1>, arg1: &0xe34c84cc4289b0b06371a11a3db9d1c79b13ba8cc21b90d6a69dbe08f6d50b2::versioned::Versioned, arg2: &mut 0x2::tx_context::TxContext) : Route {
        0xe34c84cc4289b0b06371a11a3db9d1c79b13ba8cc21b90d6a69dbe08f6d50b2::versioned::check_version(arg1);
        let v0 = 0x1::vector::pop_back<Route>(&mut arg0.routes);
        let v1 = &mut v0;
        push<T0, T2>(v1, initialize_path<T0, T2>(0x2::coin::split<T0>(&mut arg0.coin_in, v0.amount_in, arg2)));
        v0
    }

    public fun turbos_swap_exact_x_to_y<T0, T1, T2>(arg0: &mut Route, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: u128, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &0xe34c84cc4289b0b06371a11a3db9d1c79b13ba8cc21b90d6a69dbe08f6d50b2::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xe34c84cc4289b0b06371a11a3db9d1c79b13ba8cc21b90d6a69dbe08f6d50b2::versioned::check_version(arg4);
        let v0 = borrow_mut_current_path<T0, T1>(arg0);
        let v1 = 0x1::option::extract<0x2::coin::Coin<T0>>(&mut v0.coin_in);
        let (v2, v3) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_with_return_<T0, T1, T2>(arg1, 0x1::vector::singleton<0x2::coin::Coin<T0>>(v1), 0x2::coin::value<T0>(&v1), 0, arg2, true, 0x2::tx_context::sender(arg6), 18446744073709551615, arg5, arg3, arg6);
        refund_if_necessary<T0>(v3, 0x2::tx_context::sender(arg6));
        0x1::option::fill<0x2::coin::Coin<T1>>(&mut v0.coin_out, v2);
    }

    public fun turbos_swap_exact_y_to_x<T0, T1, T2>(arg0: &mut Route, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: u128, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &0xe34c84cc4289b0b06371a11a3db9d1c79b13ba8cc21b90d6a69dbe08f6d50b2::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xe34c84cc4289b0b06371a11a3db9d1c79b13ba8cc21b90d6a69dbe08f6d50b2::versioned::check_version(arg4);
        let v0 = borrow_mut_current_path<T1, T0>(arg0);
        let v1 = 0x1::option::extract<0x2::coin::Coin<T1>>(&mut v0.coin_in);
        let (v2, v3) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a_with_return_<T0, T1, T2>(arg1, 0x1::vector::singleton<0x2::coin::Coin<T1>>(v1), 0x2::coin::value<T1>(&v1), 0, arg2, true, 0x2::tx_context::sender(arg6), 18446744073709551615, arg5, arg3, arg6);
        refund_if_necessary<T1>(v3, 0x2::tx_context::sender(arg6));
        0x1::option::fill<0x2::coin::Coin<T0>>(&mut v0.coin_out, v2);
    }

    public entry fun withdraw<T0>(arg0: &0xe34c84cc4289b0b06371a11a3db9d1c79b13ba8cc21b90d6a69dbe08f6d50b2::admin_cap::AdminCap, arg1: &mut Treasury, arg2: u64, arg3: address, arg4: &0xe34c84cc4289b0b06371a11a3db9d1c79b13ba8cc21b90d6a69dbe08f6d50b2::versioned::Versioned, arg5: &mut 0x2::tx_context::TxContext) {
        0xe34c84cc4289b0b06371a11a3db9d1c79b13ba8cc21b90d6a69dbe08f6d50b2::versioned::check_version(arg4);
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

    // decompiled from Move bytecode v6
}

