module 0xd523441d9e42d910f0187003ecc78dac0bc4081dddef61992922b48923200a4f::agent_vault {
    struct Registry has key {
        id: 0x2::object::UID,
        owner_of: 0x2::table::Table<0x2::object::ID, address>,
        vaults_of: 0x2::table::Table<address, vector<0x2::object::ID>>,
        count: u64,
    }

    struct Position has copy, drop, store {
        qty: u64,
        cost: u64,
    }

    struct AgentVault<phantom T0> has key {
        id: 0x2::object::UID,
        owner: address,
        agent: address,
        paused: bool,
        expires_ms: u64,
        max_trade: u64,
        max_day: u64,
        day: u64,
        bought_today: u64,
        slippage_bps: u64,
        pools: 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x2::object::ID>,
        funds: 0x2::bag::Bag,
        book: 0x2::vec_map::VecMap<0x1::type_name::TypeName, Position>,
        rules: vector<u8>,
        notes: vector<u8>,
        trades: u64,
    }

    struct Ticket {
        vault: 0x2::object::ID,
        side: u8,
        coin: 0x1::type_name::TypeName,
        amount_in: u64,
        min_out: u64,
        value: u64,
        mid: u64,
    }

    struct Created has copy, drop {
        vault: 0x2::object::ID,
        owner: address,
        agent: address,
        expires_ms: u64,
    }

    struct Configured has copy, drop {
        vault: 0x2::object::ID,
        max_trade: u64,
        max_day: u64,
        slippage_bps: u64,
        paused: bool,
        expires_ms: u64,
        agent: address,
    }

    struct Allowed has copy, drop {
        vault: 0x2::object::ID,
        coin: 0x1::type_name::TypeName,
        pool: 0x2::object::ID,
        allowed: bool,
    }

    struct Deposited has copy, drop {
        vault: 0x2::object::ID,
        amount: u64,
    }

    struct Withdrawn has copy, drop {
        vault: 0x2::object::ID,
        coin: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct Traded has copy, drop {
        vault: 0x2::object::ID,
        side: u8,
        coin: 0x1::type_name::TypeName,
        amount_in: u64,
        amount_out: u64,
        value: u64,
        mid: u64,
    }

    public fun balance<T0, T1>(arg0: &AgentVault<T0>) : u64 {
        let v0 = key<T1>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.funds, v0)) {
            0x2::balance::value<T1>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&arg0.funds, v0))
        } else {
            0
        }
    }

    fun take<T0, T1>(arg0: &mut AgentVault<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = key<T1>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.funds, v0), 9);
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.funds, v0);
        assert!(0x2::balance::value<T1>(v1) >= arg1, 9);
        0x2::coin::take<T1>(v1, arg1, arg2)
    }

    fun add_book<T0>(arg0: &mut AgentVault<T0>, arg1: 0x1::type_name::TypeName, arg2: u64, arg3: u64) {
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

    public fun agent<T0>(arg0: &AgentVault<T0>) : address {
        arg0.agent
    }

    public fun allow<T0, T1>(arg0: &mut AgentVault<T0>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>, arg2: &0x2::tx_context::TxContext) {
        allow_at<T0, T1>(arg0, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>>(arg1), arg2);
    }

    public(friend) fun allow_at<T0, T1>(arg0: &mut AgentVault<T0>, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) {
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
            vault   : 0x2::object::id<AgentVault<T0>>(arg0),
            coin    : v0,
            pool    : arg1,
            allowed : true,
        };
        0x2::event::emit<Allowed>(v1);
    }

    fun assert_can_trade<T0, T1>(arg0: &AgentVault<T0>, arg1: 0x2::object::ID, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.agent, 2);
        assert!(!arg0.paused, 3);
        assert!(arg2 < arg0.expires_ms, 4);
        let v0 = key<T1>();
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.pools, &v0), 5);
        assert!(*0x2::vec_map::get<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.pools, &v0) == arg1, 6);
    }

    fun assert_owner<T0>(arg0: &AgentVault<T0>, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 1);
    }

    public fun begin_buy<T0, T1>(arg0: &mut AgentVault<T0>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Ticket) {
        begin_buy_at<T0, T1>(arg0, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>>(arg1), book_price<T1, T0>(arg1, arg3), arg2, 0x2::clock::timestamp_ms(arg3), arg4)
    }

    public(friend) fun begin_buy_at<T0, T1>(arg0: &mut AgentVault<T0>, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Ticket) {
        assert_can_trade<T0, T1>(arg0, arg1, arg4, arg5);
        assert!(arg3 > 0, 14);
        assert!(arg2 > 0, 15);
        assert!(arg3 <= arg0.max_trade, 7);
        roll_day<T0>(arg0, arg4);
        assert!(arg0.bought_today + arg3 <= arg0.max_day, 8);
        arg0.bought_today = arg0.bought_today + arg3;
        let v0 = (((arg3 as u128) * 1000000000 / (arg2 as u128) * (10000 - (arg0.slippage_bps as u128)) / 10000) as u64);
        let v1 = take<T0, T0>(arg0, arg3, arg5);
        let v2 = Ticket{
            vault     : 0x2::object::id<AgentVault<T0>>(arg0),
            side      : 0,
            coin      : key<T1>(),
            amount_in : arg3,
            min_out   : v0,
            value     : arg3,
            mid       : arg2,
        };
        (v1, v2)
    }

    public fun begin_sell<T0, T1>(arg0: &mut AgentVault<T0>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, Ticket) {
        begin_sell_at<T0, T1>(arg0, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>>(arg1), book_price<T1, T0>(arg1, arg3), arg2, 0x2::clock::timestamp_ms(arg3), arg4)
    }

    public(friend) fun begin_sell_at<T0, T1>(arg0: &mut AgentVault<T0>, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, Ticket) {
        assert_can_trade<T0, T1>(arg0, arg1, arg4, arg5);
        assert!(arg3 > 0, 14);
        assert!(arg2 > 0, 15);
        let v0 = (((arg3 as u128) * (arg2 as u128) / 1000000000) as u64);
        assert!(v0 <= arg0.max_trade, 7);
        let v1 = (((v0 as u128) * (10000 - (arg0.slippage_bps as u128)) / 10000) as u64);
        let v2 = take<T0, T1>(arg0, arg3, arg5);
        let v3 = Ticket{
            vault     : 0x2::object::id<AgentVault<T0>>(arg0),
            side      : 1,
            coin      : key<T1>(),
            amount_in : arg3,
            min_out   : v1,
            value     : v0,
            mid       : arg2,
        };
        (v2, v3)
    }

    fun book_price<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2::clock::Clock) : u64 {
        let (v0, _, v2, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<T0, T1>(arg0, 1, arg1);
        let v4 = v2;
        let v5 = v0;
        assert!(!0x1::vector::is_empty<u64>(&v5) && !0x1::vector::is_empty<u64>(&v4), 15);
        middle(*0x1::vector::borrow<u64>(&v5, 0), *0x1::vector::borrow<u64>(&v4, 0))
    }

    fun configured<T0>(arg0: &AgentVault<T0>) {
        let v0 = Configured{
            vault        : 0x2::object::id<AgentVault<T0>>(arg0),
            max_trade    : arg0.max_trade,
            max_day      : arg0.max_day,
            slippage_bps : arg0.slippage_bps,
            paused       : arg0.paused,
            expires_ms   : arg0.expires_ms,
            agent        : arg0.agent,
        };
        0x2::event::emit<Configured>(v0);
    }

    public fun count(arg0: &Registry) : u64 {
        arg0.count
    }

    public fun create<T0>(arg0: &mut Registry, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : AgentVault<T0> {
        assert!(arg4 <= 500, 12);
        assert!(0x1::vector::length<u8>(&arg6) <= 4096, 13);
        assert!(arg5 > 0 && arg5 <= 366, 4);
        let v0 = 0x2::clock::timestamp_ms(arg7);
        let v1 = 0x2::tx_context::sender(arg8);
        let v2 = AgentVault<T0>{
            id           : 0x2::object::new(arg8),
            owner        : v1,
            agent        : arg1,
            paused       : false,
            expires_ms   : v0 + arg5 * 86400000,
            max_trade    : arg2,
            max_day      : arg3,
            day          : v0 / 86400000,
            bought_today : 0,
            slippage_bps : arg4,
            pools        : 0x2::vec_map::empty<0x1::type_name::TypeName, 0x2::object::ID>(),
            funds        : 0x2::bag::new(arg8),
            book         : 0x2::vec_map::empty<0x1::type_name::TypeName, Position>(),
            rules        : arg6,
            notes        : b"",
            trades       : 0,
        };
        let v3 = 0x2::object::id<AgentVault<T0>>(&v2);
        0x2::table::add<0x2::object::ID, address>(&mut arg0.owner_of, v3, v1);
        if (0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.vaults_of, v1)) {
            0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.vaults_of, v1), v3);
        } else {
            let v4 = 0x1::vector::empty<0x2::object::ID>();
            0x1::vector::push_back<0x2::object::ID>(&mut v4, v3);
            0x2::table::add<address, vector<0x2::object::ID>>(&mut arg0.vaults_of, v1, v4);
        };
        arg0.count = arg0.count + 1;
        let v5 = Created{
            vault      : v3,
            owner      : v1,
            agent      : arg1,
            expires_ms : v2.expires_ms,
        };
        0x2::event::emit<Created>(v5);
        v2
    }

    public fun deposit<T0>(arg0: &mut AgentVault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        assert_owner<T0>(arg0, arg2);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 14);
        put<T0, T0>(arg0, 0x2::coin::into_balance<T0>(arg1));
        let v1 = Deposited{
            vault  : 0x2::object::id<AgentVault<T0>>(arg0),
            amount : v0,
        };
        0x2::event::emit<Deposited>(v1);
    }

    public fun disallow<T0, T1>(arg0: &mut AgentVault<T0>, arg1: &0x2::tx_context::TxContext) {
        assert_owner<T0>(arg0, arg1);
        let v0 = key<T1>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.pools, &v0)) {
            let (_, v2) = 0x2::vec_map::remove<0x1::type_name::TypeName, 0x2::object::ID>(&mut arg0.pools, &v0);
            let v3 = Allowed{
                vault   : 0x2::object::id<AgentVault<T0>>(arg0),
                coin    : v0,
                pool    : v2,
                allowed : false,
            };
            0x2::event::emit<Allowed>(v3);
        };
    }

    public fun end_buy<T0, T1>(arg0: &mut AgentVault<T0>, arg1: Ticket, arg2: 0x2::coin::Coin<T1>) {
        let Ticket {
            vault     : v0,
            side      : v1,
            coin      : v2,
            amount_in : v3,
            min_out   : v4,
            value     : v5,
            mid       : v6,
        } = arg1;
        let v7 = if (v0 == 0x2::object::id<AgentVault<T0>>(arg0)) {
            if (v1 == 0) {
                v2 == key<T1>()
            } else {
                false
            }
        } else {
            false
        };
        assert!(v7, 11);
        let v8 = 0x2::coin::value<T1>(&arg2);
        assert!(v8 >= v4, 10);
        put<T0, T1>(arg0, 0x2::coin::into_balance<T1>(arg2));
        add_book<T0>(arg0, v2, v8, v3);
        arg0.trades = arg0.trades + 1;
        let v9 = Traded{
            vault      : v0,
            side       : v1,
            coin       : v2,
            amount_in  : v3,
            amount_out : v8,
            value      : v5,
            mid        : v6,
        };
        0x2::event::emit<Traded>(v9);
    }

    public fun end_sell<T0, T1>(arg0: &mut AgentVault<T0>, arg1: Ticket, arg2: 0x2::coin::Coin<T0>) {
        let Ticket {
            vault     : v0,
            side      : v1,
            coin      : v2,
            amount_in : v3,
            min_out   : v4,
            value     : v5,
            mid       : v6,
        } = arg1;
        let v7 = if (v0 == 0x2::object::id<AgentVault<T0>>(arg0)) {
            if (v1 == 1) {
                v2 == key<T1>()
            } else {
                false
            }
        } else {
            false
        };
        assert!(v7, 11);
        let v8 = 0x2::coin::value<T0>(&arg2);
        assert!(v8 >= v4, 10);
        put<T0, T0>(arg0, 0x2::coin::into_balance<T0>(arg2));
        reduce_book<T0>(arg0, v2, v3);
        arg0.trades = arg0.trades + 1;
        let v9 = Traded{
            vault      : v0,
            side       : v1,
            coin       : v2,
            amount_in  : v3,
            amount_out : v8,
            value      : v5,
            mid        : v6,
        };
        0x2::event::emit<Traded>(v9);
    }

    public fun expires_ms<T0>(arg0: &AgentVault<T0>) : u64 {
        arg0.expires_ms
    }

    public fun extend<T0>(arg0: &mut AgentVault<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert_owner<T0>(arg0, arg3);
        assert!(arg1 > 0 && arg1 <= 366, 4);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = if (arg0.expires_ms > v0) {
            arg0.expires_ms
        } else {
            v0
        };
        arg0.expires_ms = v1 + arg1 * 86400000;
        configured<T0>(arg0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id        : 0x2::object::new(arg0),
            owner_of  : 0x2::table::new<0x2::object::ID, address>(arg0),
            vaults_of : 0x2::table::new<address, vector<0x2::object::ID>>(arg0),
            count     : 0,
        };
        0x2::transfer::share_object<Registry>(v0);
    }

    public fun is_allowed<T0, T1>(arg0: &AgentVault<T0>) : bool {
        let v0 = key<T1>();
        0x2::vec_map::contains<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.pools, &v0)
    }

    fun key<T0>() : 0x1::type_name::TypeName {
        0x1::type_name::with_defining_ids<T0>()
    }

    public fun left_today<T0>(arg0: &AgentVault<T0>, arg1: &0x2::clock::Clock) : u64 {
        let v0 = if (0x2::clock::timestamp_ms(arg1) / 86400000 == arg0.day) {
            arg0.bought_today
        } else {
            0
        };
        if (v0 >= arg0.max_day) {
            0
        } else {
            arg0.max_day - v0
        }
    }

    public fun max_day<T0>(arg0: &AgentVault<T0>) : u64 {
        arg0.max_day
    }

    public fun max_trade<T0>(arg0: &AgentVault<T0>) : u64 {
        arg0.max_trade
    }

    public(friend) fun middle(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 > 0 && arg1 >= arg0, 15);
        let v0 = ((((arg0 as u128) + (arg1 as u128)) / 2) as u64);
        assert!(((arg1 - arg0) as u128) * 10000 <= (v0 as u128) * (200 as u128), 18);
        v0
    }

    public fun notes<T0>(arg0: &AgentVault<T0>) : vector<u8> {
        arg0.notes
    }

    public fun owner<T0>(arg0: &AgentVault<T0>) : address {
        arg0.owner
    }

    public fun pause<T0>(arg0: &mut AgentVault<T0>, arg1: &0x2::tx_context::TxContext) {
        assert_owner<T0>(arg0, arg1);
        arg0.paused = true;
        configured<T0>(arg0);
    }

    public fun paused<T0>(arg0: &AgentVault<T0>) : bool {
        arg0.paused
    }

    public fun position<T0, T1>(arg0: &AgentVault<T0>) : (u64, u64) {
        let v0 = key<T1>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, Position>(&arg0.book, &v0)) {
            let v3 = 0x2::vec_map::get<0x1::type_name::TypeName, Position>(&arg0.book, &v0);
            (v3.qty, v3.cost)
        } else {
            (0, 0)
        }
    }

    fun put<T0, T1>(arg0: &mut AgentVault<T0>, arg1: 0x2::balance::Balance<T1>) {
        let v0 = key<T1>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.funds, v0)) {
            0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.funds, v0), arg1);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.funds, v0, arg1);
        };
    }

    fun reduce_book<T0>(arg0: &mut AgentVault<T0>, arg1: 0x1::type_name::TypeName, arg2: u64) {
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

    public fun resume<T0>(arg0: &mut AgentVault<T0>, arg1: &0x2::tx_context::TxContext) {
        assert_owner<T0>(arg0, arg1);
        arg0.paused = false;
        configured<T0>(arg0);
    }

    fun roll_day<T0>(arg0: &mut AgentVault<T0>, arg1: u64) {
        let v0 = arg1 / 86400000;
        if (v0 != arg0.day) {
            arg0.day = v0;
            arg0.bought_today = 0;
        };
    }

    public fun rules<T0>(arg0: &AgentVault<T0>) : vector<u8> {
        arg0.rules
    }

    public fun set_agent<T0>(arg0: &mut AgentVault<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_owner<T0>(arg0, arg2);
        arg0.agent = arg1;
        configured<T0>(arg0);
    }

    public fun set_limits<T0>(arg0: &mut AgentVault<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert_owner<T0>(arg0, arg4);
        assert!(arg3 <= 500, 12);
        arg0.max_trade = arg1;
        arg0.max_day = arg2;
        arg0.slippage_bps = arg3;
        configured<T0>(arg0);
    }

    public fun set_notes<T0>(arg0: &mut AgentVault<T0>, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.agent || 0x2::tx_context::sender(arg2) == arg0.owner, 2);
        assert!(0x1::vector::length<u8>(&arg1) <= 2048, 13);
        arg0.notes = arg1;
    }

    public fun set_rules<T0>(arg0: &mut AgentVault<T0>, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        assert_owner<T0>(arg0, arg2);
        assert!(0x1::vector::length<u8>(&arg1) <= 4096, 13);
        arg0.rules = arg1;
    }

    public fun share<T0>(arg0: AgentVault<T0>) {
        0x2::transfer::share_object<AgentVault<T0>>(arg0);
    }

    public fun slippage_bps<T0>(arg0: &AgentVault<T0>) : u64 {
        arg0.slippage_bps
    }

    public fun trades<T0>(arg0: &AgentVault<T0>) : u64 {
        arg0.trades
    }

    public fun vaults_of(arg0: &Registry, arg1: address) : vector<0x2::object::ID> {
        if (0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.vaults_of, arg1)) {
            *0x2::table::borrow<address, vector<0x2::object::ID>>(&arg0.vaults_of, arg1)
        } else {
            0x1::vector::empty<0x2::object::ID>()
        }
    }

    public fun withdraw<T0, T1>(arg0: &mut AgentVault<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_owner<T0>(arg0, arg2);
        assert!(arg1 > 0, 14);
        let v0 = take<T0, T1>(arg0, arg1, arg2);
        let v1 = key<T1>();
        reduce_book<T0>(arg0, v1, arg1);
        let v2 = Withdrawn{
            vault  : 0x2::object::id<AgentVault<T0>>(arg0),
            coin   : v1,
            amount : arg1,
        };
        0x2::event::emit<Withdrawn>(v2);
        v0
    }

    public fun withdraw_all<T0, T1>(arg0: &mut AgentVault<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = balance<T0, T1>(arg0);
        withdraw<T0, T1>(arg0, v0, arg1)
    }

    // decompiled from Move bytecode v7
}

