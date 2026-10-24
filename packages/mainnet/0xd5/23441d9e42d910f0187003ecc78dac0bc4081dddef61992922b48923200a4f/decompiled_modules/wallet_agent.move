module 0xd523441d9e42d910f0187003ecc78dac0bc4081dddef61992922b48923200a4f::wallet_agent {
    struct YosukuAgent has drop {
        dummy_field: bool,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        plans_of: 0x2::table::Table<address, vector<0x2::object::ID>>,
        count: u64,
    }

    struct Position has copy, drop, store {
        qty: u64,
        cost: u64,
    }

    struct Plan<phantom T0> has key {
        id: 0x2::object::UID,
        owner: address,
        agent: address,
        paused: bool,
        max_trade: u64,
        slippage_bps: u64,
        pools: 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x2::object::ID>,
        book: 0x2::vec_map::VecMap<0x1::type_name::TypeName, Position>,
        rules: vector<u8>,
        notes: vector<u8>,
        trades: u64,
    }

    struct Ticket {
        plan: 0x2::object::ID,
        side: u8,
        coin: 0x1::type_name::TypeName,
        amount_in: u64,
        value: u64,
        mid: u64,
    }

    struct Created has copy, drop {
        plan: 0x2::object::ID,
        owner: address,
        agent: address,
    }

    struct Configured has copy, drop {
        plan: 0x2::object::ID,
        max_trade: u64,
        slippage_bps: u64,
        paused: bool,
        agent: address,
    }

    struct Allowed has copy, drop {
        plan: 0x2::object::ID,
        coin: 0x1::type_name::TypeName,
        pool: 0x2::object::ID,
        allowed: bool,
    }

    struct Approved has copy, drop {
        plan: 0x2::object::ID,
        coin: 0x1::type_name::TypeName,
        spender: address,
    }

    struct Traded has copy, drop {
        plan: 0x2::object::ID,
        side: u8,
        coin: 0x1::type_name::TypeName,
        amount_in: u64,
        amount_out: u64,
        value: u64,
        mid: u64,
    }

    fun add_book<T0>(arg0: &mut Plan<T0>, arg1: 0x1::type_name::TypeName, arg2: u64, arg3: u64) {
        if (0x2::vec_map::contains<0x1::type_name::TypeName, Position>(&arg0.book, &arg1)) {
            let v0 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, Position>(&mut arg0.book, &arg1);
            v0.qty = v0.qty + arg2;
            v0.cost = v0.cost + arg3;
        } else {
            let v1 = Position{
                qty  : arg2,
                cost : arg3,
            };
            0x2::vec_map::insert<0x1::type_name::TypeName, Position>(&mut arg0.book, arg1, v1);
        };
    }

    public fun agent<T0>(arg0: &Plan<T0>) : address {
        arg0.agent
    }

    public fun allow<T0, T1>(arg0: &mut Plan<T0>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>, arg2: &0x2::tx_context::TxContext) {
        allow_at<T0, T1>(arg0, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>>(arg1), arg2);
    }

    public(friend) fun allow_at<T0, T1>(arg0: &mut Plan<T0>, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) {
        assert_owner<T0>(arg0, arg2);
        let v0 = key<T1>();
        assert!(v0 != key<T0>(), 17);
        if (0x2::vec_map::contains<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.pools, &v0)) {
            *0x2::vec_map::get_mut<0x1::type_name::TypeName, 0x2::object::ID>(&mut arg0.pools, &v0) = arg1;
        } else {
            assert!(0x2::vec_map::length<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.pools) < 16, 16);
            0x2::vec_map::insert<0x1::type_name::TypeName, 0x2::object::ID>(&mut arg0.pools, v0, arg1);
        };
        let v1 = Allowed{
            plan    : 0x2::object::id<Plan<T0>>(arg0),
            coin    : v0,
            pool    : arg1,
            allowed : true,
        };
        0x2::event::emit<Allowed>(v1);
    }

    public fun approve<T0, T1>(arg0: &Plan<T0>, arg1: 0x2::allowance::AllowanceProposal<0x2::balance::Balance<T1>>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_owner<T0>(arg0, arg2);
        let v0 = 0x2::allowance::allowance_proposal_settings<0x2::balance::Balance<T1>>(&arg1);
        assert!(0x2::allowance::funder(v0) == arg0.owner, 19);
        let v1 = 0x2::allowance::spender(v0);
        assert!(0x1::option::contains<address>(&v1, &arg0.agent), 20);
        let v2 = key<T1>();
        assert!(v2 == key<T0>() || 0x2::vec_map::contains<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.pools, &v2), 5);
        0x2::allowance::issue<0x2::balance::Balance<T1>, YosukuAgent>(arg1, 0x2::allowance::settings_permit<YosukuAgent>(0x1::internal::permit<YosukuAgent>()), arg2);
        let v3 = Approved{
            plan    : 0x2::object::id<Plan<T0>>(arg0),
            coin    : v2,
            spender : arg0.agent,
        };
        0x2::event::emit<Approved>(v3);
    }

    fun assert_can_trade<T0, T1>(arg0: &Plan<T0>, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.agent, 2);
        assert!(!arg0.paused, 3);
        let v0 = key<T1>();
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.pools, &v0), 5);
        assert!(*0x2::vec_map::get<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.pools, &v0) == arg1, 6);
    }

    fun assert_owner<T0>(arg0: &Plan<T0>, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 1);
    }

    public fun begin_buy<T0, T1>(arg0: &mut Plan<T0>, arg1: &mut 0x2::allowance::Allowance<0x2::balance::Balance<T0>>, arg2: 0x2::allowance::AllowanceWithdrawal<0x2::balance::Balance<T0>>, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Ticket) {
        begin_buy_at<T0, T1>(arg0, arg1, arg2, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>>(arg3), book_price<T1, T0>(arg3, arg4), arg4, arg5)
    }

    public(friend) fun begin_buy_at<T0, T1>(arg0: &mut Plan<T0>, arg1: &mut 0x2::allowance::Allowance<0x2::balance::Balance<T0>>, arg2: 0x2::allowance::AllowanceWithdrawal<0x2::balance::Balance<T0>>, arg3: 0x2::object::ID, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Ticket) {
        assert_can_trade<T0, T1>(arg0, arg3, arg6);
        assert!(arg4 > 0, 15);
        let v0 = draw<T0, T0>(arg0, arg1, arg2, arg5, arg6);
        let v1 = 0x2::balance::value<T0>(&v0);
        assert!(v1 > 0, 14);
        assert!(v1 <= arg0.max_trade, 7);
        let v2 = Ticket{
            plan      : 0x2::object::id<Plan<T0>>(arg0),
            side      : 0,
            coin      : key<T1>(),
            amount_in : v1,
            value     : v1,
            mid       : arg4,
        };
        (0x2::coin::from_balance<T0>(v0, arg6), v2)
    }

    public fun begin_sell<T0, T1>(arg0: &mut Plan<T0>, arg1: &mut 0x2::allowance::Allowance<0x2::balance::Balance<T1>>, arg2: 0x2::allowance::AllowanceWithdrawal<0x2::balance::Balance<T1>>, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, Ticket) {
        begin_sell_at<T0, T1>(arg0, arg1, arg2, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>>(arg3), book_price<T1, T0>(arg3, arg4), arg4, arg5)
    }

    public(friend) fun begin_sell_at<T0, T1>(arg0: &mut Plan<T0>, arg1: &mut 0x2::allowance::Allowance<0x2::balance::Balance<T1>>, arg2: 0x2::allowance::AllowanceWithdrawal<0x2::balance::Balance<T1>>, arg3: 0x2::object::ID, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, Ticket) {
        assert_can_trade<T0, T1>(arg0, arg3, arg6);
        assert!(arg4 > 0, 15);
        let v0 = draw<T0, T1>(arg0, arg1, arg2, arg5, arg6);
        let v1 = 0x2::balance::value<T1>(&v0);
        assert!(v1 > 0, 14);
        let (v2, _) = position<T0, T1>(arg0);
        assert!(v1 <= v2, 21);
        let v4 = (((v1 as u128) * (arg4 as u128) / 1000000000) as u64);
        assert!(v4 <= arg0.max_trade, 7);
        let v5 = Ticket{
            plan      : 0x2::object::id<Plan<T0>>(arg0),
            side      : 1,
            coin      : key<T1>(),
            amount_in : v1,
            value     : v4,
            mid       : arg4,
        };
        (0x2::coin::from_balance<T1>(v0, arg6), v5)
    }

    fun book_price<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2::clock::Clock) : u64 {
        let (v0, _, v2, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<T0, T1>(arg0, 1, arg1);
        let v4 = v2;
        let v5 = v0;
        assert!(!0x1::vector::is_empty<u64>(&v5) && !0x1::vector::is_empty<u64>(&v4), 15);
        middle(*0x1::vector::borrow<u64>(&v5, 0), *0x1::vector::borrow<u64>(&v4, 0))
    }

    fun configured<T0>(arg0: &Plan<T0>) {
        let v0 = Configured{
            plan         : 0x2::object::id<Plan<T0>>(arg0),
            max_trade    : arg0.max_trade,
            slippage_bps : arg0.slippage_bps,
            paused       : arg0.paused,
            agent        : arg0.agent,
        };
        0x2::event::emit<Configured>(v0);
    }

    public fun count(arg0: &Registry) : u64 {
        arg0.count
    }

    public fun create<T0>(arg0: &mut Registry, arg1: address, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) : Plan<T0> {
        assert!(arg3 <= 500, 12);
        assert!(0x1::vector::length<u8>(&arg4) <= 4096, 13);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = Plan<T0>{
            id           : 0x2::object::new(arg5),
            owner        : v0,
            agent        : arg1,
            paused       : false,
            max_trade    : arg2,
            slippage_bps : arg3,
            pools        : 0x2::vec_map::empty<0x1::type_name::TypeName, 0x2::object::ID>(),
            book         : 0x2::vec_map::empty<0x1::type_name::TypeName, Position>(),
            rules        : arg4,
            notes        : b"",
            trades       : 0,
        };
        let v2 = 0x2::object::id<Plan<T0>>(&v1);
        if (0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.plans_of, v0)) {
            0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.plans_of, v0), v2);
        } else {
            let v3 = 0x1::vector::empty<0x2::object::ID>();
            0x1::vector::push_back<0x2::object::ID>(&mut v3, v2);
            0x2::table::add<address, vector<0x2::object::ID>>(&mut arg0.plans_of, v0, v3);
        };
        arg0.count = arg0.count + 1;
        let v4 = Created{
            plan  : v2,
            owner : v0,
            agent : arg1,
        };
        0x2::event::emit<Created>(v4);
        v1
    }

    public fun disallow<T0, T1>(arg0: &mut Plan<T0>, arg1: &0x2::tx_context::TxContext) {
        assert_owner<T0>(arg0, arg1);
        let v0 = key<T1>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.pools, &v0)) {
            let (_, v2) = 0x2::vec_map::remove<0x1::type_name::TypeName, 0x2::object::ID>(&mut arg0.pools, &v0);
            let v3 = Allowed{
                plan    : 0x2::object::id<Plan<T0>>(arg0),
                coin    : v0,
                pool    : v2,
                allowed : false,
            };
            0x2::event::emit<Allowed>(v3);
        };
    }

    fun draw<T0, T1>(arg0: &Plan<T0>, arg1: &mut 0x2::allowance::Allowance<0x2::balance::Balance<T1>>, arg2: 0x2::allowance::AllowanceWithdrawal<0x2::balance::Balance<T1>>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        assert!(0x2::allowance::funder(0x2::allowance::allowance_settings<0x2::balance::Balance<T1>>(arg1)) == arg0.owner, 19);
        0x2::allowance::app_balance_spend<T1, YosukuAgent>(arg1, 0x2::allowance::spend_permit<YosukuAgent>(0x1::internal::permit<YosukuAgent>()), arg2, arg3, arg4)
    }

    public fun end_buy<T0, T1>(arg0: &mut Plan<T0>, arg1: Ticket, arg2: 0x2::coin::Coin<T1>, arg3: 0x2::coin::Coin<T0>) {
        let Ticket {
            plan      : v0,
            side      : v1,
            coin      : v2,
            amount_in : v3,
            value     : _,
            mid       : v5,
        } = arg1;
        let v6 = if (v0 == 0x2::object::id<Plan<T0>>(arg0)) {
            if (v1 == 0) {
                v2 == key<T1>()
            } else {
                false
            }
        } else {
            false
        };
        assert!(v6, 11);
        let v7 = 0x2::coin::value<T0>(&arg3);
        assert!(v7 < v3, 22);
        let v8 = v3 - v7;
        let v9 = 0x2::coin::value<T1>(&arg2);
        assert!(v9 >= (((v8 as u128) * 1000000000 / (v5 as u128) * (10000 - (arg0.slippage_bps as u128)) / 10000) as u64), 10);
        give<T0, T1>(arg0, arg2);
        give<T0, T0>(arg0, arg3);
        add_book<T0>(arg0, v2, v9, v8);
        arg0.trades = arg0.trades + 1;
        let v10 = Traded{
            plan       : v0,
            side       : v1,
            coin       : v2,
            amount_in  : v8,
            amount_out : v9,
            value      : v8,
            mid        : v5,
        };
        0x2::event::emit<Traded>(v10);
    }

    public fun end_sell<T0, T1>(arg0: &mut Plan<T0>, arg1: Ticket, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>) {
        let Ticket {
            plan      : v0,
            side      : v1,
            coin      : v2,
            amount_in : v3,
            value     : _,
            mid       : v5,
        } = arg1;
        let v6 = if (v0 == 0x2::object::id<Plan<T0>>(arg0)) {
            if (v1 == 1) {
                v2 == key<T1>()
            } else {
                false
            }
        } else {
            false
        };
        assert!(v6, 11);
        let v7 = 0x2::coin::value<T1>(&arg3);
        assert!(v7 < v3, 22);
        let v8 = v3 - v7;
        let v9 = (v8 as u128) * (v5 as u128) / 1000000000;
        let v10 = 0x2::coin::value<T0>(&arg2);
        assert!(v10 >= ((v9 * (10000 - (arg0.slippage_bps as u128)) / 10000) as u64), 10);
        give<T0, T0>(arg0, arg2);
        give<T0, T1>(arg0, arg3);
        reduce_book<T0>(arg0, v2, v8);
        arg0.trades = arg0.trades + 1;
        let v11 = Traded{
            plan       : v0,
            side       : v1,
            coin       : v2,
            amount_in  : v8,
            amount_out : v10,
            value      : (v9 as u64),
            mid        : v5,
        };
        0x2::event::emit<Traded>(v11);
    }

    fun give<T0, T1>(arg0: &Plan<T0>, arg1: 0x2::coin::Coin<T1>) {
        if (0x2::coin::value<T1>(&arg1) == 0) {
            0x2::coin::destroy_zero<T1>(arg1);
        } else {
            0x2::coin::send_funds<T1>(arg1, arg0.owner);
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id       : 0x2::object::new(arg0),
            plans_of : 0x2::table::new<address, vector<0x2::object::ID>>(arg0),
            count    : 0,
        };
        0x2::transfer::share_object<Registry>(v0);
    }

    public fun is_allowed<T0, T1>(arg0: &Plan<T0>) : bool {
        let v0 = key<T1>();
        0x2::vec_map::contains<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.pools, &v0)
    }

    fun key<T0>() : 0x1::type_name::TypeName {
        0x1::type_name::with_defining_ids<T0>()
    }

    public fun max_trade<T0>(arg0: &Plan<T0>) : u64 {
        arg0.max_trade
    }

    public(friend) fun middle(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 > 0 && arg1 >= arg0, 15);
        let v0 = ((((arg0 as u128) + (arg1 as u128)) / 2) as u64);
        assert!(((arg1 - arg0) as u128) * 10000 <= (v0 as u128) * (200 as u128), 18);
        v0
    }

    public fun notes<T0>(arg0: &Plan<T0>) : vector<u8> {
        arg0.notes
    }

    public fun owner<T0>(arg0: &Plan<T0>) : address {
        arg0.owner
    }

    public fun pause<T0>(arg0: &mut Plan<T0>, arg1: &0x2::tx_context::TxContext) {
        assert_owner<T0>(arg0, arg1);
        arg0.paused = true;
        configured<T0>(arg0);
    }

    public fun paused<T0>(arg0: &Plan<T0>) : bool {
        arg0.paused
    }

    public fun plans_of(arg0: &Registry, arg1: address) : vector<0x2::object::ID> {
        if (0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.plans_of, arg1)) {
            *0x2::table::borrow<address, vector<0x2::object::ID>>(&arg0.plans_of, arg1)
        } else {
            0x1::vector::empty<0x2::object::ID>()
        }
    }

    public fun position<T0, T1>(arg0: &Plan<T0>) : (u64, u64) {
        let v0 = key<T1>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, Position>(&arg0.book, &v0)) {
            let v3 = 0x2::vec_map::get<0x1::type_name::TypeName, Position>(&arg0.book, &v0);
            (v3.qty, v3.cost)
        } else {
            (0, 0)
        }
    }

    fun reduce_book<T0>(arg0: &mut Plan<T0>, arg1: 0x1::type_name::TypeName, arg2: u64) {
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, Position>(&arg0.book, &arg1)) {
            return
        };
        let v0 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, Position>(&mut arg0.book, &arg1);
        if (arg2 >= v0.qty) {
            let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, Position>(&mut arg0.book, &arg1);
        } else {
            v0.cost = v0.cost - (((v0.cost as u128) * (arg2 as u128) / (v0.qty as u128)) as u64);
            v0.qty = v0.qty - arg2;
        };
    }

    public fun repoint<T0, T1>(arg0: &Plan<T0>, arg1: &mut 0x2::allowance::Allowance<0x2::balance::Balance<T1>>, arg2: &0x2::tx_context::TxContext) {
        assert_owner<T0>(arg0, arg2);
        assert!(0x2::allowance::funder(0x2::allowance::allowance_settings<0x2::balance::Balance<T1>>(arg1)) == arg0.owner, 19);
        0x2::allowance::rotate_spender<0x2::balance::Balance<T1>, YosukuAgent>(arg1, 0x2::allowance::settings_permit<YosukuAgent>(0x1::internal::permit<YosukuAgent>()), arg0.agent);
    }

    public fun resume<T0>(arg0: &mut Plan<T0>, arg1: &0x2::tx_context::TxContext) {
        assert_owner<T0>(arg0, arg1);
        arg0.paused = false;
        configured<T0>(arg0);
    }

    public fun rules<T0>(arg0: &Plan<T0>) : vector<u8> {
        arg0.rules
    }

    public fun set_agent<T0>(arg0: &mut Plan<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_owner<T0>(arg0, arg2);
        arg0.agent = arg1;
        configured<T0>(arg0);
    }

    public fun set_limits<T0>(arg0: &mut Plan<T0>, arg1: u64, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert_owner<T0>(arg0, arg3);
        assert!(arg2 <= 500, 12);
        arg0.max_trade = arg1;
        arg0.slippage_bps = arg2;
        configured<T0>(arg0);
    }

    public fun set_notes<T0>(arg0: &mut Plan<T0>, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.agent || 0x2::tx_context::sender(arg2) == arg0.owner, 2);
        assert!(0x1::vector::length<u8>(&arg1) <= 2048, 13);
        arg0.notes = arg1;
    }

    public fun set_rules<T0>(arg0: &mut Plan<T0>, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        assert_owner<T0>(arg0, arg2);
        assert!(0x1::vector::length<u8>(&arg1) <= 4096, 13);
        arg0.rules = arg1;
    }

    public fun share<T0>(arg0: Plan<T0>) {
        0x2::transfer::share_object<Plan<T0>>(arg0);
    }

    public fun slippage_bps<T0>(arg0: &Plan<T0>) : u64 {
        arg0.slippage_bps
    }

    public fun trades<T0>(arg0: &Plan<T0>) : u64 {
        arg0.trades
    }

    // decompiled from Move bytecode v7
}

