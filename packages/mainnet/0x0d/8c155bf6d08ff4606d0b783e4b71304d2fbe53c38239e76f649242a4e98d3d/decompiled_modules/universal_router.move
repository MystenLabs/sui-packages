module 0x63d178468dfb8ee54e6819e34165219b118d154d4c613eb6b1ef230843eb87b3::universal_router {
    struct BalanceKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct PathIndex has copy, drop, store {
        value: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Treasury has store, key {
        id: 0x2::object::UID,
        fee_on: bool,
        balances: 0x2::bag::Bag,
        deepbook_account_cap: 0xdee9::custodian_v2::AccountCap,
    }

    struct Route {
        coin_in: 0x1::type_name::TypeName,
        amount_in: u64,
        amount_out_expected: u64,
        slippage: u64,
        deadline: u64,
        current: u64,
        size: u64,
        paths: 0x2::bag::Bag,
    }

    struct Path<phantom T0, phantom T1> has store {
        coin_in: 0x1::option::Option<0x2::coin::Coin<T0>>,
        coin_out: 0x1::option::Option<0x2::coin::Coin<T1>>,
        fee_rate: u64,
        sqrt_price_limit: u128,
    }

    struct Collect has copy, drop, store {
        swapper: address,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct Swap has copy, drop, store {
        swapper: address,
        coin_in: 0x1::type_name::TypeName,
        coin_out: 0x1::type_name::TypeName,
        amount_in: u64,
        amount_out: u64,
    }

    public fun aftermath_swap_exact_input<T0, T1, T2>(arg0: &mut Route, arg1: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg2: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>, arg3: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg4: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg5: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg6: &mut 0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = borrow_mut_current_path<T1, T2>(arg0);
        0x1::option::fill<0x2::coin::Coin<T2>>(&mut v0.coin_out, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::swap::swap_exact_in<T0, T1, T2>(arg2, arg1, arg3, arg4, arg5, arg6, 0x1::option::extract<0x2::coin::Coin<T1>>(&mut v0.coin_in), arg7, 1000000000000000000, arg8));
    }

    fun borrow_mut_current_path<T0, T1>(arg0: &mut Route) : &mut Path<T0, T1> {
        check_path_exists<T0, T1>(arg0);
        0x2::bag::borrow_mut<PathIndex, Path<T0, T1>>(&mut arg0.paths, path_index_key(arg0.current - 1))
    }

    public fun cetus_swap_exact_x_to_y<T0, T1>(arg0: &mut Route, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = borrow_mut_current_path<T0, T1>(arg0);
        let v1 = 0x1::option::extract<0x2::coin::Coin<T0>>(&mut v0.coin_in);
        let (v2, v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, true, true, 0x2::coin::value<T0>(&v1), v0.sqrt_price_limit, arg3);
        let v5 = v4;
        refund_if_necessary<T0>(v1, 0x2::tx_context::sender(arg4));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v5), arg4)), 0x2::balance::zero<T1>(), v5);
        refund_if_necessary<T0>(0x2::coin::from_balance<T0>(v2, arg4), 0x2::tx_context::sender(arg4));
        0x1::option::fill<0x2::coin::Coin<T1>>(&mut v0.coin_out, 0x2::coin::from_balance<T1>(v3, arg4));
    }

    public fun cetus_swap_exact_y_to_x<T0, T1>(arg0: &mut Route, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = borrow_mut_current_path<T1, T0>(arg0);
        let v1 = 0x1::option::extract<0x2::coin::Coin<T1>>(&mut v0.coin_in);
        let (v2, v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, false, true, 0x2::coin::value<T1>(&v1), v0.sqrt_price_limit, arg3);
        let v5 = v4;
        refund_if_necessary<T1>(v1, 0x2::tx_context::sender(arg4));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v5), arg4)), v5);
        refund_if_necessary<T1>(0x2::coin::from_balance<T1>(v3, arg4), 0x2::tx_context::sender(arg4));
        0x1::option::fill<0x2::coin::Coin<T0>>(&mut v0.coin_out, 0x2::coin::from_balance<T0>(v2, arg4));
    }

    fun check_amount_threshold<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        if (0x2::coin::value<T0>(arg0) < arg1) {
            abort 1
        };
    }

    fun check_deadline(arg0: &0x2::clock::Clock, arg1: u64) {
        if (0x2::clock::timestamp_ms(arg0) > arg1) {
            abort 0
        };
    }

    fun check_path_exists<T0, T1>(arg0: &Route) {
        if (!0x2::bag::contains_with_type<PathIndex, Path<T0, T1>>(&arg0.paths, path_index_key(arg0.current - 1))) {
            abort 5
        };
    }

    fun check_slippage(arg0: u64) {
        if (arg0 > 1000000) {
            abort 2
        };
    }

    fun collect<T0>(arg0: &mut Treasury, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        let v0 = BalanceKey<T0>{dummy_field: false};
        if (!0x2::bag::contains<BalanceKey<T0>>(&arg0.balances, v0)) {
            let v1 = BalanceKey<T0>{dummy_field: false};
            0x2::bag::add<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.balances, v1, 0x2::balance::zero<T0>());
        };
        let v2 = BalanceKey<T0>{dummy_field: false};
        0x2::coin::put<T0>(0x2::bag::borrow_mut<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.balances, v2), arg1);
        let v3 = Collect{
            swapper   : 0x2::tx_context::sender(arg2),
            coin_type : 0x1::type_name::get<T0>(),
            amount    : 0x2::coin::value<T0>(&arg1),
        };
        0x2::event::emit<Collect>(v3);
    }

    fun deepbook_prune_input<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        refund_if_necessary<T0>(0x2::coin::split<T0>(arg0, 0x2::coin::value<T0>(arg0) % arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public fun deepbook_swap_exact_base_for_quote<T0, T1>(arg0: &mut Treasury, arg1: &mut Route, arg2: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = borrow_mut_current_path<T0, T1>(arg1);
        let v1 = 0x1::option::extract<0x2::coin::Coin<T0>>(&mut v0.coin_in);
        let v2 = &mut v1;
        deepbook_prune_input<T0>(v2, 1000, arg4);
        let (v3, v4, _) = 0xdee9::clob_v2::swap_exact_base_for_quote<T0, T1>(arg2, 0x2::clock::timestamp_ms(arg3), &arg0.deepbook_account_cap, 0x2::coin::value<T0>(&v1), v1, 0x2::coin::zero<T1>(arg4), arg3, arg4);
        refund_if_necessary<T0>(v3, 0x2::tx_context::sender(arg4));
        0x1::option::fill<0x2::coin::Coin<T1>>(&mut v0.coin_out, v4);
    }

    public fun deepbook_swap_exact_base_for_quote_v2<T0, T1>(arg0: &mut Treasury, arg1: &mut Route, arg2: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = borrow_mut_current_path<T0, T1>(arg1);
        let v1 = 0x1::option::extract<0x2::coin::Coin<T0>>(&mut v0.coin_in);
        let v2 = &mut v1;
        deepbook_prune_input<T0>(v2, arg3, arg5);
        let (v3, v4, _) = 0xdee9::clob_v2::swap_exact_base_for_quote<T0, T1>(arg2, 0x2::clock::timestamp_ms(arg4), &arg0.deepbook_account_cap, 0x2::coin::value<T0>(&v1), v1, 0x2::coin::zero<T1>(arg5), arg4, arg5);
        refund_if_necessary<T0>(v3, 0x2::tx_context::sender(arg5));
        0x1::option::fill<0x2::coin::Coin<T1>>(&mut v0.coin_out, v4);
    }

    public fun deepbook_swap_exact_quote_for_base<T0, T1>(arg0: &mut Treasury, arg1: &mut Route, arg2: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = borrow_mut_current_path<T1, T0>(arg1);
        let v1 = 0x1::option::extract<0x2::coin::Coin<T1>>(&mut v0.coin_in);
        let v2 = &mut v1;
        deepbook_prune_input<T1>(v2, 1000, arg4);
        let (v3, v4, _) = 0xdee9::clob_v2::swap_exact_quote_for_base<T0, T1>(arg2, 0x2::clock::timestamp_ms(arg3), &arg0.deepbook_account_cap, 0x2::coin::value<T1>(&v1), arg3, v1, arg4);
        refund_if_necessary<T1>(v4, 0x2::tx_context::sender(arg4));
        0x1::option::fill<0x2::coin::Coin<T0>>(&mut v0.coin_out, v3);
    }

    public fun deepbook_swap_exact_quote_for_base_v2<T0, T1>(arg0: &mut Treasury, arg1: &mut Route, arg2: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = borrow_mut_current_path<T1, T0>(arg1);
        let v1 = 0x1::option::extract<0x2::coin::Coin<T1>>(&mut v0.coin_in);
        let v2 = &mut v1;
        deepbook_prune_input<T1>(v2, arg3, arg5);
        let (v3, v4, _) = 0xdee9::clob_v2::swap_exact_quote_for_base<T0, T1>(arg2, 0x2::clock::timestamp_ms(arg4), &arg0.deepbook_account_cap, 0x2::coin::value<T1>(&v1), arg4, v1, arg5);
        refund_if_necessary<T1>(v4, 0x2::tx_context::sender(arg5));
        0x1::option::fill<0x2::coin::Coin<T0>>(&mut v0.coin_out, v3);
    }

    fun extract_from_current_path<T0, T1>(arg0: &mut Route) : 0x2::coin::Coin<T1> {
        check_path_exists<T0, T1>(arg0);
        let Path {
            coin_in          : v0,
            coin_out         : v1,
            fee_rate         : _,
            sqrt_price_limit : _,
        } = 0x2::bag::remove<PathIndex, Path<T0, T1>>(&mut arg0.paths, path_index_key(arg0.current - 1));
        0x1::option::destroy_none<0x2::coin::Coin<T0>>(v0);
        0x1::option::destroy_some<0x2::coin::Coin<T1>>(v1)
    }

    public fun flowx_clmm_swap_exact_input<T0, T1>(arg0: &mut Route, arg1: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg2: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.deadline;
        let v1 = borrow_mut_current_path<T0, T1>(arg0);
        0x1::option::fill<0x2::coin::Coin<T1>>(&mut v1.coin_out, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::swap_router::swap_exact_input<T0, T1>(arg1, v1.fee_rate, 0x1::option::extract<0x2::coin::Coin<T0>>(&mut v1.coin_in), 0, v1.sqrt_price_limit, v0, arg2, arg3, arg4));
    }

    public fun flowx_swap_exact_input<T0, T1>(arg0: &mut Route, arg1: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = borrow_mut_current_path<T0, T1>(arg0);
        0x1::option::fill<0x2::coin::Coin<T1>>(&mut v0.coin_out, 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_input_direct<T0, T1>(arg1, 0x1::option::extract<0x2::coin::Coin<T0>>(&mut v0.coin_in), arg2));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Treasury{
            id                   : 0x2::object::new(arg0),
            fee_on               : false,
            balances             : 0x2::bag::new(arg0),
            deepbook_account_cap : 0xdee9::clob_v2::create_account(arg0),
        };
        0x2::transfer::share_object<Treasury>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun initialize_path<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u128) : Path<T0, T1> {
        Path<T0, T1>{
            coin_in          : 0x1::option::some<0x2::coin::Coin<T0>>(arg0),
            coin_out         : 0x1::option::none<0x2::coin::Coin<T1>>(),
            fee_rate         : arg1,
            sqrt_price_limit : arg2,
        }
    }

    public fun initialize_routing<T0, T1>(arg0: Path<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : Route {
        check_slippage(arg2);
        let v0 = Route{
            coin_in             : 0x1::type_name::get<T0>(),
            amount_in           : 0x2::coin::value<T0>(0x1::option::borrow<0x2::coin::Coin<T0>>(&arg0.coin_in)),
            amount_out_expected : arg1,
            slippage            : arg2,
            deadline            : arg3,
            current             : 0,
            size                : arg4,
            paths               : 0x2::bag::new(arg5),
        };
        let v1 = &mut v0;
        push<T0, T1>(v1, arg0);
        v0
    }

    public fun kriya_swap_exact_x_to_y<T0, T1>(arg0: &mut Route, arg1: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = borrow_mut_current_path<T0, T1>(arg0);
        let v1 = 0x1::option::extract<0x2::coin::Coin<T0>>(&mut v0.coin_in);
        0x1::option::fill<0x2::coin::Coin<T1>>(&mut v0.coin_out, 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::swap_token_x<T0, T1>(arg1, v1, 0x2::coin::value<T0>(&v1), 0, arg2));
    }

    public fun kriya_swap_exact_y_to_x<T0, T1>(arg0: &mut Route, arg1: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = borrow_mut_current_path<T1, T0>(arg0);
        let v1 = 0x1::option::extract<0x2::coin::Coin<T1>>(&mut v0.coin_in);
        0x1::option::fill<0x2::coin::Coin<T0>>(&mut v0.coin_out, 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::swap_token_y<T0, T1>(arg1, v1, 0x2::coin::value<T1>(&v1), 0, arg2));
    }

    public fun next<T0, T1, T2>(arg0: &mut Route, arg1: u64, arg2: u128) {
        let v0 = extract_from_current_path<T0, T1>(arg0);
        push<T1, T2>(arg0, initialize_path<T1, T2>(v0, arg1, arg2));
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
        if (arg0.current > arg0.size) {
            abort 3
        };
    }

    fun refund_if_necessary<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    public entry fun set_fee_on(arg0: &AdminCap, arg1: &mut Treasury, arg2: bool) {
        arg1.fee_on = arg2;
    }

    public fun settle<T0, T1>(arg0: &mut Treasury, arg1: Route, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        if (arg1.current != arg1.size) {
            abort 4
        };
        let v0 = &mut arg1;
        let v1 = extract_from_current_path<T0, T1>(v0);
        let Route {
            coin_in             : v2,
            amount_in           : v3,
            amount_out_expected : v4,
            slippage            : v5,
            deadline            : v6,
            current             : _,
            size                : _,
            paths               : v9,
        } = arg1;
        check_deadline(arg2, v6);
        0x2::bag::destroy_empty(v9);
        check_amount_threshold<T1>(&v1, 0x63d178468dfb8ee54e6819e34165219b118d154d4c613eb6b1ef230843eb87b3::math::mul_div(1000000 - v5, v4, 1000000));
        let v10 = &mut v1;
        pay_router_fee_if_necessary<T1>(arg0, v10, v4, arg3);
        let v11 = Swap{
            swapper    : 0x2::tx_context::sender(arg3),
            coin_in    : v2,
            coin_out   : 0x1::type_name::get<T1>(),
            amount_in  : v3,
            amount_out : 0x2::coin::value<T1>(&v1),
        };
        0x2::event::emit<Swap>(v11);
        v1
    }

    public fun turbos_swap_exact_x_to_y<T0, T1, T2>(arg0: &mut Route, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = borrow_mut_current_path<T0, T1>(arg0);
        let v1 = 0x1::option::extract<0x2::coin::Coin<T0>>(&mut v0.coin_in);
        let (v2, v3) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_with_return_<T0, T1, T2>(arg1, 0x1::vector::singleton<0x2::coin::Coin<T0>>(v1), 0x2::coin::value<T0>(&v1), 0, v0.sqrt_price_limit, true, 0x2::tx_context::sender(arg4), 18446744073709551615, arg3, arg2, arg4);
        refund_if_necessary<T0>(v3, 0x2::tx_context::sender(arg4));
        0x1::option::fill<0x2::coin::Coin<T1>>(&mut v0.coin_out, v2);
    }

    public fun turbos_swap_exact_y_to_x<T0, T1, T2>(arg0: &mut Route, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = borrow_mut_current_path<T1, T0>(arg0);
        let v1 = 0x1::option::extract<0x2::coin::Coin<T1>>(&mut v0.coin_in);
        let (v2, v3) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a_with_return_<T0, T1, T2>(arg1, 0x1::vector::singleton<0x2::coin::Coin<T1>>(v1), 0x2::coin::value<T1>(&v1), 0, v0.sqrt_price_limit, true, 0x2::tx_context::sender(arg4), 18446744073709551615, arg3, arg2, arg4);
        refund_if_necessary<T1>(v3, 0x2::tx_context::sender(arg4));
        0x1::option::fill<0x2::coin::Coin<T0>>(&mut v0.coin_out, v2);
    }

    public entry fun withdraw<T0>(arg0: &AdminCap, arg1: &mut Treasury, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = BalanceKey<T0>{dummy_field: false};
        let v1 = 0x2::bag::borrow_mut<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg1.balances, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(v1, 0x2::math::min(arg2, 0x2::balance::value<T0>(v1)), arg4), arg3);
    }

    // decompiled from Move bytecode v6
}

