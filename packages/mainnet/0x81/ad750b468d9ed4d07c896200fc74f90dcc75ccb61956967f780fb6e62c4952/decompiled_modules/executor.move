module 0x81ad750b468d9ed4d07c896200fc74f90dcc75ccb61956967f780fb6e62c4952::executor {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
        executor_id: 0x2::object::ID,
    }

    struct Executor has store, key {
        id: 0x2::object::UID,
        active: bool,
        caps: Caps,
        balance_manager: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager,
        market: 0x81ad750b468d9ed4d07c896200fc74f90dcc75ccb61956967f780fb6e62c4952::market::Market,
        config: 0x81ad750b468d9ed4d07c896200fc74f90dcc75ccb61956967f780fb6e62c4952::config::AMMConfig,
        info: 0x81ad750b468d9ed4d07c896200fc74f90dcc75ccb61956967f780fb6e62c4952::info::Info,
    }

    struct Caps has store {
        trade_cap: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap,
        deposit_cap: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap,
        withdraw_cap: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap,
    }

    struct LimitOrderParams has copy, drop {
        price: u64,
        quantity: u64,
        is_bid: bool,
    }

    struct RefreshTicket {
        executor_id: 0x2::object::ID,
    }

    struct EXECUTOR has drop {
        dummy_field: bool,
    }

    public fun id(arg0: &Executor) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun balance_manager(arg0: &Executor) : &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager {
        &arg0.balance_manager
    }

    public fun owner(arg0: &Executor) : address {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::owner(&arg0.balance_manager)
    }

    public fun config(arg0: &Executor) : &0x81ad750b468d9ed4d07c896200fc74f90dcc75ccb61956967f780fb6e62c4952::config::AMMConfig {
        &arg0.config
    }

    public fun active(arg0: &Executor) : bool {
        arg0.active
    }

    fun cancel_orders<T0, T1>(arg0: &mut Executor, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_trader(&mut arg0.balance_manager, &arg0.caps.trade_cap, arg3);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg1, &mut arg0.balance_manager, &v0, arg2, arg3);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::withdraw_settled_amounts<T0, T1>(arg1, &mut arg0.balance_manager, &v0);
        0x81ad750b468d9ed4d07c896200fc74f90dcc75ccb61956967f780fb6e62c4952::info::update(&mut arg0.info, volume_base<T0, T1>(arg0, arg1), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(&arg0.balance_manager), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(&arg0.balance_manager));
        v0
    }

    public fun cancel_orders_after_update<T0, T1>(arg0: &mut Executor, arg1: RefreshTicket, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let RefreshTicket { executor_id: v0 } = arg1;
        assert!(v0 == id(arg0), 13835622886431522821);
        assert!(0x81ad750b468d9ed4d07c896200fc74f90dcc75ccb61956967f780fb6e62c4952::market::has_valid_pool<T0, T1>(&arg0.market, arg2), 13835341415749648387);
        cancel_orders<T0, T1>(arg0, arg2, arg3, arg4);
    }

    public fun cap_id(arg0: &AdminCap) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    fun compute_ask_price(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = 0x1::u64::checked_add(arg0, arg1);
        if (0x1::option::is_some<u64>(&v0)) {
            let v1 = 0x1::option::destroy_some<u64>(v0);
            let v2 = v1 % arg2;
            let v3 = if (v2 == 0) {
                v1
            } else {
                let v4 = 0x1::u64::checked_add(v1, arg2 - v2);
                if (0x1::option::is_some<u64>(&v4)) {
                    0x1::option::destroy_some<u64>(v4)
                } else {
                    0x1::option::destroy_none<u64>(v4);
                    abort 13837312857279037457
                }
            };
            assert!(v3 <= 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::max_price(), 13837312865868972049);
            return v3
        } else {
            0x1::option::destroy_none<u64>(v0);
            abort 13837312827214266385
        };
    }

    fun compute_bid_price(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = 0x1::u64::checked_sub(arg0, arg1);
        if (0x1::option::is_some<u64>(&v0)) {
            let v1 = 0x1::option::destroy_some<u64>(v0);
            let v2 = v1 - v1 % arg2;
            assert!(v2 >= 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::min_price(), 13837031304992784399);
            return v2
        } else {
            0x1::option::destroy_none<u64>(v0);
            abort 13837031287812915215
        };
    }

    public fun create(arg0: 0x81ad750b468d9ed4d07c896200fc74f90dcc75ccb61956967f780fb6e62c4952::market::Market, arg1: 0x81ad750b468d9ed4d07c896200fc74f90dcc75ccb61956967f780fb6e62c4952::config::AMMConfig, arg2: &mut 0x2::tx_context::TxContext) : (Executor, AdminCap) {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::new(arg2);
        let v1 = 0x2::object::new(arg2);
        let v2 = 0x2::object::new(arg2);
        0x81ad750b468d9ed4d07c896200fc74f90dcc75ccb61956967f780fb6e62c4952::events::emit_executor_created(0x2::object::uid_to_inner(&v1), 0x2::object::uid_to_inner(&v2));
        let v3 = AdminCap{
            id          : v2,
            executor_id : 0x2::object::uid_to_inner(&v1),
        };
        let v4 = Caps{
            trade_cap    : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::mint_trade_cap(&mut v0, arg2),
            deposit_cap  : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::mint_deposit_cap(&mut v0, arg2),
            withdraw_cap : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::mint_withdraw_cap(&mut v0, arg2),
        };
        let v5 = Executor{
            id              : v1,
            active          : false,
            caps            : v4,
            balance_manager : v0,
            market          : arg0,
            config          : arg1,
            info            : 0x81ad750b468d9ed4d07c896200fc74f90dcc75ccb61956967f780fb6e62c4952::info::empty(),
        };
        (v5, v3)
    }

    public fun market(arg0: &Executor) : &0x81ad750b468d9ed4d07c896200fc74f90dcc75ccb61956967f780fb6e62c4952::market::Market {
        &arg0.market
    }

    public fun deposit<T0>(arg0: &mut Executor, arg1: &AdminCap, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(id(arg0) == arg1.executor_id, 13835621889999110149);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x2::coin::value<T0>(&arg2);
        if (v0 == 0x81ad750b468d9ed4d07c896200fc74f90dcc75ccb61956967f780fb6e62c4952::market::base_type(&arg0.market)) {
            0x81ad750b468d9ed4d07c896200fc74f90dcc75ccb61956967f780fb6e62c4952::info::record_base_deposit(&mut arg0.info, v1);
        } else {
            assert!(v0 == 0x81ad750b468d9ed4d07c896200fc74f90dcc75ccb61956967f780fb6e62c4952::market::quote_type(&arg0.market), 13837592253491707923);
            0x81ad750b468d9ed4d07c896200fc74f90dcc75ccb61956967f780fb6e62c4952::info::record_quote_deposit(&mut arg0.info, v1);
        };
        0x81ad750b468d9ed4d07c896200fc74f90dcc75ccb61956967f780fb6e62c4952::events::emit_deposited(id(arg0), v0, v1);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit_with_cap<T0>(&mut arg0.balance_manager, &arg0.caps.deposit_cap, arg2, arg3);
    }

    public fun deposit_cap_id(arg0: &Executor) : 0x2::object::ID {
        0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap>(&arg0.caps.deposit_cap)
    }

    public fun discard_paused_after_update(arg0: &Executor, arg1: RefreshTicket) {
        let RefreshTicket { executor_id: v0 } = arg1;
        assert!(v0 == id(arg0), 13835622937971130373);
        assert!(!arg0.active, 13836185892219781129);
    }

    fun has_open_orders<T0, T1>(arg0: &Executor, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock) : bool {
        if (!0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::account_exists<T0, T1>(arg1, &arg0.balance_manager)) {
            return false
        };
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::account<T0, T1>(arg1, &arg0.balance_manager);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_orders<T0, T1>(arg1, 0x2::vec_set::into_keys<u128>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::account::open_orders(&v0)));
        let v2 = &v1;
        let v3 = 0;
        let v4;
        while (v3 < 0x1::vector::length<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(v2)) {
            if (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::expire_timestamp(0x1::vector::borrow<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(v2, v3)) >= 0x2::clock::timestamp_ms(arg2)) {
                v4 = true;
                return v4
            };
            v3 = v3 + 1;
        };
        v4 = false;
        v4
    }

    public fun info(arg0: &Executor) : &0x81ad750b468d9ed4d07c896200fc74f90dcc75ccb61956967f780fb6e62c4952::info::Info {
        &arg0.info
    }

    fun init(arg0: EXECUTOR, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<EXECUTOR>(arg0, arg1);
    }

    public fun pause<T0, T1>(arg0: &mut Executor, arg1: &AdminCap, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(id(arg0) == arg1.executor_id, 13835621769740025861);
        assert!(arg0.active, 13835903249011834887);
        assert!(0x81ad750b468d9ed4d07c896200fc74f90dcc75ccb61956967f780fb6e62c4952::market::has_valid_pool<T0, T1>(&arg0.market, arg2), 13835340303353118723);
        cancel_orders<T0, T1>(arg0, arg2, arg3, arg4);
        0x81ad750b468d9ed4d07c896200fc74f90dcc75ccb61956967f780fb6e62c4952::events::emit_executor_paused(id(arg0));
        arg0.active = false;
    }

    fun quote_to_base_quantity(arg0: u64, arg1: u64) : u64 {
        let v0 = 0x1::u128::try_as_u64((arg0 as u128) * 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::float_scaling_u128() / (arg1 as u128));
        if (0x1::option::is_some<u64>(&v0)) {
            return 0x1::option::destroy_some<u64>(v0)
        } else {
            0x1::option::destroy_none<u64>(v0);
            abort 13836468775945895947
        };
    }

    public fun refresh_quotes<T0, T1>(arg0: &mut Executor, arg1: &AdminCap, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(id(arg0) == arg1.executor_id, 13835622590078779397);
        assert!(0x81ad750b468d9ed4d07c896200fc74f90dcc75ccb61956967f780fb6e62c4952::market::has_valid_pool<T0, T1>(&arg0.market, arg2), 13835341123691872259);
        assert!(arg0.active, 13835904082235490311);
        0x81ad750b468d9ed4d07c896200fc74f90dcc75ccb61956967f780fb6e62c4952::market::set_latest_publish_times(&mut arg0.market, arg5);
        refresh_quotes_inner<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6);
    }

    public fun refresh_quotes_after_update<T0, T1>(arg0: &mut Executor, arg1: RefreshTicket, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let RefreshTicket { executor_id: v0 } = arg1;
        assert!(v0 == id(arg0), 13835622706042896389);
        assert!(0x81ad750b468d9ed4d07c896200fc74f90dcc75ccb61956967f780fb6e62c4952::market::has_valid_pool<T0, T1>(&arg0.market, arg2), 13835341235361021955);
        assert!(arg0.active, 13835904189609672711);
        refresh_quotes_inner<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6);
    }

    fun refresh_quotes_inner<T0, T1>(arg0: &mut Executor, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        let v0 = cancel_orders<T0, T1>(arg0, arg1, arg4, arg5);
        let v1 = 0x81ad750b468d9ed4d07c896200fc74f90dcc75ccb61956967f780fb6e62c4952::config::base_spread(&arg0.config, arg2);
        let v2 = 0x81ad750b468d9ed4d07c896200fc74f90dcc75ccb61956967f780fb6e62c4952::config::outer_spread(&arg0.config, arg2, arg3);
        assert!(v1 > 0, 13837874858044948501);
        let v3 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(&arg0.balance_manager);
        let v4 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(&arg0.balance_manager);
        let v5 = 0x81ad750b468d9ed4d07c896200fc74f90dcc75ccb61956967f780fb6e62c4952::config::reservation_mid(&arg0.config, arg2, v3, v4);
        let (v6, v7, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg1);
        let v9 = compute_bid_price(v5, v2, v6);
        let v10 = compute_bid_price(v5, v1, v6);
        let v11 = compute_ask_price(v5, v1, v6);
        let v12 = compute_ask_price(v5, v2, v6);
        let v13 = 0x81ad750b468d9ed4d07c896200fc74f90dcc75ccb61956967f780fb6e62c4952::config::max_commit_balance(&arg0.config, v4);
        let v14 = 0x81ad750b468d9ed4d07c896200fc74f90dcc75ccb61956967f780fb6e62c4952::config::max_commit_balance(&arg0.config, v3);
        let v15 = if (v9 == v10) {
            0
        } else {
            0x81ad750b468d9ed4d07c896200fc74f90dcc75ccb61956967f780fb6e62c4952::config::outer_balance(&arg0.config, v13)
        };
        let v16 = if (v12 == v11) {
            0
        } else {
            0x81ad750b468d9ed4d07c896200fc74f90dcc75ccb61956967f780fb6e62c4952::config::outer_balance(&arg0.config, v14)
        };
        let v17 = LimitOrderParams{
            price    : v9,
            quantity : round_down_quantity(quote_to_base_quantity(v15, v9), v7),
            is_bid   : true,
        };
        let v18 = LimitOrderParams{
            price    : v10,
            quantity : round_down_quantity(quote_to_base_quantity(v13 - v15, v10), v7),
            is_bid   : true,
        };
        let v19 = LimitOrderParams{
            price    : v11,
            quantity : round_down_quantity(v14 - v16, v7),
            is_bid   : false,
        };
        let v20 = LimitOrderParams{
            price    : v12,
            quantity : round_down_quantity(v16, v7),
            is_bid   : false,
        };
        let v21 = 0x1::vector::empty<LimitOrderParams>();
        let v22 = &mut v21;
        0x1::vector::push_back<LimitOrderParams>(v22, v17);
        0x1::vector::push_back<LimitOrderParams>(v22, v18);
        0x1::vector::push_back<LimitOrderParams>(v22, v19);
        0x1::vector::push_back<LimitOrderParams>(v22, v20);
        let v23 = try_place_limit_orders<T0, T1>(arg0, arg1, &v0, v21, arg4, arg5);
        0x81ad750b468d9ed4d07c896200fc74f90dcc75ccb61956967f780fb6e62c4952::market::set_price_and_conf(&mut arg0.market, arg2, arg3);
        0x81ad750b468d9ed4d07c896200fc74f90dcc75ccb61956967f780fb6e62c4952::events::emit_quote_updated(id(arg0), arg2, v23);
    }

    public fun refresh_quotes_permissionless<T0, T1>(arg0: &mut Executor, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg3: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x81ad750b468d9ed4d07c896200fc74f90dcc75ccb61956967f780fb6e62c4952::market::has_valid_pool<T0, T1>(&arg0.market, arg1), 13835340737144815619);
        assert!(arg0.active, 13835903695688433671);
        assert!(0x81ad750b468d9ed4d07c896200fc74f90dcc75ccb61956967f780fb6e62c4952::market::has_valid_base_pyth_feed_id(&arg0.market, arg2), 13835059287937777665);
        assert!(0x81ad750b468d9ed4d07c896200fc74f90dcc75ccb61956967f780fb6e62c4952::market::has_valid_quote_pyth_feed_id(&arg0.market, arg3), 13835059305117646849);
        let v0 = 0x81ad750b468d9ed4d07c896200fc74f90dcc75ccb61956967f780fb6e62c4952::config::max_price_age_secs(&arg0.config);
        let v1 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::pyth::get_price_no_older_than(arg2, arg4, v0);
        let v2 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::pyth::get_price_no_older_than(arg3, arg4, v0);
        let v3 = has_open_orders<T0, T1>(arg0, arg1, arg4);
        if (v3 && !0x81ad750b468d9ed4d07c896200fc74f90dcc75ccb61956967f780fb6e62c4952::market::try_update_publish_times(&mut arg0.market, v1, v2)) {
            return
        };
        let (v4, v5) = 0x81ad750b468d9ed4d07c896200fc74f90dcc75ccb61956967f780fb6e62c4952::market::deepbook_price(&arg0.market, v1, v2, 0x81ad750b468d9ed4d07c896200fc74f90dcc75ccb61956967f780fb6e62c4952::config::max_conf_ratio_bps(&arg0.config));
        let v6 = 0x81ad750b468d9ed4d07c896200fc74f90dcc75ccb61956967f780fb6e62c4952::market::mid_price(&arg0.market);
        let v7 = 0x81ad750b468d9ed4d07c896200fc74f90dcc75ccb61956967f780fb6e62c4952::market::conf_ratio_bps(&arg0.market);
        let v8 = if (v3) {
            if (0x1::option::is_some<u64>(&v6)) {
                0x1::option::is_some<u64>(&v7)
            } else {
                false
            }
        } else {
            false
        };
        if (v8) {
            if (0x81ad750b468d9ed4d07c896200fc74f90dcc75ccb61956967f780fb6e62c4952::config::is_stale_tolerant(&arg0.config, v4, v5, 0x1::option::destroy_some<u64>(v6), 0x1::option::destroy_some<u64>(v7))) {
                return
            };
        };
        refresh_quotes_inner<T0, T1>(arg0, arg1, v4, v5, arg4, arg5);
    }

    public fun refresh_quotes_pyth_after_update<T0, T1>(arg0: &mut Executor, arg1: RefreshTicket, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg4: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let RefreshTicket { executor_id: v0 } = arg1;
        assert!(v0 == id(arg0), 13835622791942242309);
        refresh_quotes_permissionless<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6);
    }

    fun round_down_quantity(arg0: u64, arg1: u64) : u64 {
        arg0 - arg0 % arg1
    }

    public fun trade_cap_id(arg0: &Executor) : 0x2::object::ID {
        0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>(&arg0.caps.trade_cap)
    }

    fun try_place_limit_orders<T0, T1>(arg0: &mut Executor, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg3: vector<LimitOrderParams>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : vector<0x81ad750b468d9ed4d07c896200fc74f90dcc75ccb61956967f780fb6e62c4952::events::LimitOrder> {
        let (_, _, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg1);
        let v3 = if (0x81ad750b468d9ed4d07c896200fc74f90dcc75ccb61956967f780fb6e62c4952::config::post_only(&arg0.config)) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::post_only()
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::no_restriction()
        };
        let v4 = 0x1::vector::empty<0x81ad750b468d9ed4d07c896200fc74f90dcc75ccb61956967f780fb6e62c4952::events::LimitOrder>();
        let v5 = 0;
        while (v5 < 0x1::vector::length<LimitOrderParams>(&arg3)) {
            let LimitOrderParams {
                price    : v6,
                quantity : v7,
                is_bid   : v8,
            } = *0x1::vector::borrow<LimitOrderParams>(&arg3, v5);
            let v9 = v5 + 1;
            v5 = v9;
            if (v7 < v2) {
                continue
            };
            let v10 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg1, &mut arg0.balance_manager, arg2, v9, v3, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::cancel_taker(), v6, v7, v8, false, 0x2::clock::timestamp_ms(arg4) + 0x81ad750b468d9ed4d07c896200fc74f90dcc75ccb61956967f780fb6e62c4952::config::order_expiration_time_ms(&arg0.config), arg4, arg5);
            0x1::vector::push_back<0x81ad750b468d9ed4d07c896200fc74f90dcc75ccb61956967f780fb6e62c4952::events::LimitOrder>(&mut v4, 0x81ad750b468d9ed4d07c896200fc74f90dcc75ccb61956967f780fb6e62c4952::events::new_order(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::order_id(&v10), v6, v7, v8));
        };
        v4
    }

    public fun unpause(arg0: &mut Executor, arg1: &AdminCap) {
        assert!(id(arg0) == arg1.executor_id, 13835621834164535301);
        assert!(!arg0.active, 13836184788413186057);
        0x81ad750b468d9ed4d07c896200fc74f90dcc75ccb61956967f780fb6e62c4952::events::emit_executor_unpaused(id(arg0));
        arg0.active = true;
    }

    public fun update_config(arg0: &mut Executor, arg1: &AdminCap, arg2: 0x81ad750b468d9ed4d07c896200fc74f90dcc75ccb61956967f780fb6e62c4952::config::AMMConfig) : RefreshTicket {
        assert!(id(arg0) == arg1.executor_id, 13835621688135647237);
        assert!(&arg0.config != &arg2, 13836747592337981453);
        0x81ad750b468d9ed4d07c896200fc74f90dcc75ccb61956967f780fb6e62c4952::events::emit_executor_config_updated(id(arg0));
        0x81ad750b468d9ed4d07c896200fc74f90dcc75ccb61956967f780fb6e62c4952::market::reset_freshness_state(&mut arg0.market);
        arg0.config = arg2;
        RefreshTicket{executor_id: id(arg0)}
    }

    fun volume_base<T0, T1>(arg0: &Executor, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>) : u128 {
        if (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::account_exists<T0, T1>(arg1, &arg0.balance_manager)) {
            let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::account<T0, T1>(arg1, &arg0.balance_manager);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::account::total_volume(&v1)
        } else {
            0
        }
    }

    public fun withdraw<T0>(arg0: &mut Executor, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(id(arg0) == arg1.executor_id, 13835622018848129029);
        assert!(!arg0.active, 13836184973096779785);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (v0 == 0x81ad750b468d9ed4d07c896200fc74f90dcc75ccb61956967f780fb6e62c4952::market::base_type(&arg0.market)) {
            0x81ad750b468d9ed4d07c896200fc74f90dcc75ccb61956967f780fb6e62c4952::info::record_base_withdraw(&mut arg0.info, arg2);
        } else {
            assert!(v0 == 0x81ad750b468d9ed4d07c896200fc74f90dcc75ccb61956967f780fb6e62c4952::market::quote_type(&arg0.market), 13837592382340726803);
            0x81ad750b468d9ed4d07c896200fc74f90dcc75ccb61956967f780fb6e62c4952::info::record_quote_withdraw(&mut arg0.info, arg2);
        };
        0x81ad750b468d9ed4d07c896200fc74f90dcc75ccb61956967f780fb6e62c4952::events::emit_withdrawn(id(arg0), v0, arg2);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_with_cap<T0>(&mut arg0.balance_manager, &arg0.caps.withdraw_cap, arg2, arg3)
    }

    public fun withdraw_all<T0>(arg0: &mut Executor, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(&arg0.balance_manager);
        withdraw<T0>(arg0, arg1, v0, arg2)
    }

    public fun withdraw_cap_id(arg0: &Executor) : 0x2::object::ID {
        0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap>(&arg0.caps.withdraw_cap)
    }

    // decompiled from Move bytecode v7
}

