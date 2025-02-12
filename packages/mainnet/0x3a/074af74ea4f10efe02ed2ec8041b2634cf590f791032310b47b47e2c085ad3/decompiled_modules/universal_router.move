module 0x3a074af74ea4f10efe02ed2ec8041b2634cf590f791032310b47b47e2c085ad3::universal_router {
    struct PathIndex has copy, drop, store {
        value: u64,
    }

    struct Treasury has store, key {
        id: 0x2::object::UID,
        fee_on: bool,
        balances: 0x2::bag::Bag,
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
        commission: 0x1::option::Option<0x3a074af74ea4f10efe02ed2ec8041b2634cf590f791032310b47b47e2c085ad3::commission::Commission>,
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

    public fun borrow_mut_current_path<T0, T1>(arg0: &mut Route) : &mut Path<T0, T1> {
        check_path_exists<T0, T1>(arg0);
        0x2::bag::borrow_mut<PathIndex, Path<T0, T1>>(&mut arg0.paths, path_index_key(arg0.current - 1))
    }

    public fun build<T0, T1>(arg0: &mut 0x3a074af74ea4f10efe02ed2ec8041b2634cf590f791032310b47b47e2c085ad3::trade_id_tracker::TradeIdTracker, arg1: &mut 0x3a074af74ea4f10efe02ed2ec8041b2634cf590f791032310b47b47e2c085ad3::partner_manager::PartnerRegistry, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: vector<u64>, arg7: 0x1::option::Option<0x3a074af74ea4f10efe02ed2ec8041b2634cf590f791032310b47b47e2c085ad3::commission::Commission>, arg8: &0x3a074af74ea4f10efe02ed2ec8041b2634cf590f791032310b47b47e2c085ad3::versioned::Versioned, arg9: &mut 0x2::tx_context::TxContext) : Trade<T0, T1> {
        0x3a074af74ea4f10efe02ed2ec8041b2634cf590f791032310b47b47e2c085ad3::versioned::check_version(arg8);
        if (arg4 > 1000000) {
            abort 0
        };
        0x3a074af74ea4f10efe02ed2ec8041b2634cf590f791032310b47b47e2c085ad3::trade_id_tracker::increment(arg0);
        let v0 = 0x3a074af74ea4f10efe02ed2ec8041b2634cf590f791032310b47b47e2c085ad3::trade_id_tracker::current(arg0);
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
        if (0x1::option::is_some<0x3a074af74ea4f10efe02ed2ec8041b2634cf590f791032310b47b47e2c085ad3::commission::Commission>(&arg7)) {
            let v2 = 0x1::option::borrow<0x3a074af74ea4f10efe02ed2ec8041b2634cf590f791032310b47b47e2c085ad3::commission::Commission>(&arg7);
            if (0x3a074af74ea4f10efe02ed2ec8041b2634cf590f791032310b47b47e2c085ad3::commission::on_input(v2)) {
                0x3a074af74ea4f10efe02ed2ec8041b2634cf590f791032310b47b47e2c085ad3::partner_manager::collect_commission_if_necessary<T0>(arg1, &mut v1.coin_in, v2, arg9);
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
            abort 4
        };
        v1
    }

    fun check_path_exists<T0, T1>(arg0: &Route) {
        if (!0x2::bag::contains_with_type<PathIndex, Path<T0, T1>>(&arg0.paths, path_index_key(arg0.current - 1))) {
            abort 1
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

    fun extract_from_current_path<T0, T1>(arg0: &mut Route) : 0x2::coin::Coin<T1> {
        check_path_exists<T0, T1>(arg0);
        let Path {
            coin_in  : v0,
            coin_out : v1,
        } = 0x2::bag::remove<PathIndex, Path<T0, T1>>(&mut arg0.paths, path_index_key(arg0.current - 1));
        0x1::option::destroy_none<0x2::coin::Coin<T0>>(v0);
        0x1::option::destroy_some<0x2::coin::Coin<T1>>(v1)
    }

    public fun fill_coin_out<T0, T1>(arg0: &mut Path<T0, T1>, arg1: 0x2::coin::Coin<T1>) {
        0x1::option::fill<0x2::coin::Coin<T1>>(&mut arg0.coin_out, arg1);
    }

    public fun finish_routing<T0, T1, T2>(arg0: &mut Trade<T0, T1>, arg1: Route, arg2: &0x3a074af74ea4f10efe02ed2ec8041b2634cf590f791032310b47b47e2c085ad3::versioned::Versioned) {
        0x3a074af74ea4f10efe02ed2ec8041b2634cf590f791032310b47b47e2c085ad3::versioned::check_version(arg2);
        if (arg0.trade_id != arg1.trade_id) {
            abort 1
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

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Treasury{
            id       : 0x2::object::new(arg0),
            fee_on   : false,
            balances : 0x2::bag::new(arg0),
        };
        0x2::transfer::share_object<Treasury>(v0);
    }

    fun initialize_path<T0, T1>(arg0: 0x2::coin::Coin<T0>) : Path<T0, T1> {
        Path<T0, T1>{
            coin_in  : 0x1::option::some<0x2::coin::Coin<T0>>(arg0),
            coin_out : 0x1::option::none<0x2::coin::Coin<T1>>(),
        }
    }

    public fun next<T0, T1, T2>(arg0: &mut Route, arg1: &0x3a074af74ea4f10efe02ed2ec8041b2634cf590f791032310b47b47e2c085ad3::versioned::Versioned) {
        0x3a074af74ea4f10efe02ed2ec8041b2634cf590f791032310b47b47e2c085ad3::versioned::check_version(arg1);
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

    public entry fun set_fee_on(arg0: &0x3a074af74ea4f10efe02ed2ec8041b2634cf590f791032310b47b47e2c085ad3::admin_cap::AdminCap, arg1: &mut Treasury, arg2: bool, arg3: &0x3a074af74ea4f10efe02ed2ec8041b2634cf590f791032310b47b47e2c085ad3::versioned::Versioned) {
        0x3a074af74ea4f10efe02ed2ec8041b2634cf590f791032310b47b47e2c085ad3::versioned::check_version(arg3);
        arg1.fee_on = arg2;
    }

    public fun settle<T0, T1>(arg0: &mut Treasury, arg1: &mut 0x3a074af74ea4f10efe02ed2ec8041b2634cf590f791032310b47b47e2c085ad3::partner_manager::PartnerRegistry, arg2: Trade<T0, T1>, arg3: &0x3a074af74ea4f10efe02ed2ec8041b2634cf590f791032310b47b47e2c085ad3::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x3a074af74ea4f10efe02ed2ec8041b2634cf590f791032310b47b47e2c085ad3::versioned::check_version(arg3);
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
            abort 3
        };
        0x3a074af74ea4f10efe02ed2ec8041b2634cf590f791032310b47b47e2c085ad3::utils::check_deadline(arg4, v4);
        0x3a074af74ea4f10efe02ed2ec8041b2634cf590f791032310b47b47e2c085ad3::utils::check_amount_threshold<T1>(&v11, 0x3a074af74ea4f10efe02ed2ec8041b2634cf590f791032310b47b47e2c085ad3::math::mul_div(1000000 - v3, v2, 1000000));
        0x1::vector::destroy_empty<Route>(v10);
        0x3a074af74ea4f10efe02ed2ec8041b2634cf590f791032310b47b47e2c085ad3::utils::refund_if_necessary<T0>(v5, 0x2::tx_context::sender(arg5));
        let v12 = &mut v11;
        pay_router_fee_if_necessary<T1>(arg0, v12, v2, arg5);
        let v13 = if (0x1::option::is_some<0x3a074af74ea4f10efe02ed2ec8041b2634cf590f791032310b47b47e2c085ad3::commission::Commission>(&v9)) {
            let v14 = 0x1::option::destroy_some<0x3a074af74ea4f10efe02ed2ec8041b2634cf590f791032310b47b47e2c085ad3::commission::Commission>(v9);
            if (!0x3a074af74ea4f10efe02ed2ec8041b2634cf590f791032310b47b47e2c085ad3::commission::on_input(&v14)) {
                0x3a074af74ea4f10efe02ed2ec8041b2634cf590f791032310b47b47e2c085ad3::partner_manager::collect_commission_if_necessary<T1>(arg1, &mut v11, &v14, arg5);
            };
            0x1::option::some<address>(0x3a074af74ea4f10efe02ed2ec8041b2634cf590f791032310b47b47e2c085ad3::commission::partner(&v14))
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

    public fun start_routing<T0, T1, T2>(arg0: &mut Trade<T0, T1>, arg1: &0x3a074af74ea4f10efe02ed2ec8041b2634cf590f791032310b47b47e2c085ad3::versioned::Versioned, arg2: &mut 0x2::tx_context::TxContext) : Route {
        0x3a074af74ea4f10efe02ed2ec8041b2634cf590f791032310b47b47e2c085ad3::versioned::check_version(arg1);
        let v0 = 0x1::vector::pop_back<Route>(&mut arg0.routes);
        let v1 = &mut v0;
        push<T0, T2>(v1, initialize_path<T0, T2>(0x2::coin::split<T0>(&mut arg0.coin_in, v0.amount_in, arg2)));
        v0
    }

    public fun take_coin_in<T0, T1>(arg0: &mut Path<T0, T1>) : 0x2::coin::Coin<T0> {
        0x1::option::extract<0x2::coin::Coin<T0>>(&mut arg0.coin_in)
    }

    public entry fun withdraw_protocol_fee<T0>(arg0: &0x3a074af74ea4f10efe02ed2ec8041b2634cf590f791032310b47b47e2c085ad3::admin_cap::AdminCap, arg1: &mut Treasury, arg2: u64, arg3: address, arg4: &0x3a074af74ea4f10efe02ed2ec8041b2634cf590f791032310b47b47e2c085ad3::versioned::Versioned, arg5: &mut 0x2::tx_context::TxContext) {
        0x3a074af74ea4f10efe02ed2ec8041b2634cf590f791032310b47b47e2c085ad3::versioned::check_version(arg4);
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

