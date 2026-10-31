module 0xdad6eaa5512713cc4c2b1948687c6724a8da6812cadc00902d1c563623339231::dca {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct KeeperCap has key {
        id: 0x2::object::UID,
    }

    struct Config has key {
        id: 0x2::object::UID,
        version: u64,
        paused: bool,
        keeper: 0x2::object::ID,
        fee_recipient: address,
        min_interval_ms: u64,
        inputs: 0x2::table::Table<0x1::ascii::String, u64>,
        outputs: 0x2::table::Table<0x1::ascii::String, u64>,
        any_output: bool,
        any_output_fee_bps: u64,
        blocked: 0x2::table::Table<0x1::ascii::String, bool>,
    }

    struct Plan<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        owner: address,
        recipient: address,
        funds: 0x2::balance::Balance<T0>,
        per_buy: u64,
        interval_ms: u64,
        next_buy_ms: u64,
        fee_bps: u64,
        min_out: u64,
        max_out: u64,
        buys: u64,
        spent: u128,
        bought: u128,
    }

    struct Buy<phantom T0, phantom T1> {
        plan: 0x2::object::ID,
        spent: u64,
        fee: u64,
        min_out: u64,
    }

    struct Opened has copy, drop {
        plan: 0x2::object::ID,
        owner: address,
        recipient: address,
        input: 0x1::ascii::String,
        output: 0x1::ascii::String,
        deposit: u64,
        per_buy: u64,
        interval_ms: u64,
        first_buy_ms: u64,
        fee_bps: u64,
        min_out: u64,
        max_out: u64,
    }

    struct ToppedUp has copy, drop {
        plan: 0x2::object::ID,
        amount: u64,
        funds: u64,
    }

    struct Skipped has copy, drop {
        plan: 0x2::object::ID,
        next_buy_ms: u64,
    }

    struct KeeperChanged has copy, drop {
        cap: 0x2::object::ID,
        to: address,
    }

    struct FeeRecipientChanged has copy, drop {
        to: address,
    }

    struct RangeSet has copy, drop {
        plan: 0x2::object::ID,
        min_out: u64,
        max_out: u64,
    }

    struct Bought has copy, drop {
        plan: 0x2::object::ID,
        owner: address,
        recipient: address,
        spent: u64,
        fee: u64,
        change: u64,
        received: u64,
        buys: u64,
        funds_left: u64,
        next_buy_ms: u64,
    }

    struct Closed has copy, drop {
        plan: 0x2::object::ID,
        owner: address,
        refunded: u64,
        buys: u64,
        spent: u128,
        bought: u128,
    }

    struct ConfigChanged has copy, drop {
        what: 0x1::ascii::String,
        coin: 0x1::ascii::String,
        value: u64,
    }

    fun advance<T0, T1>(arg0: &mut Plan<T0, T1>, arg1: u64) {
        arg0.next_buy_ms = arg0.next_buy_ms + ((arg1 - arg0.next_buy_ms) / arg0.interval_ms + 1) * arg0.interval_ms;
    }

    fun assert_live(arg0: &Config) {
        assert_version(arg0);
        assert!(!arg0.paused, 1);
    }

    fun assert_version(arg0: &Config) {
        assert!(arg0.version == 1, 0);
    }

    public fun bought<T0, T1>(arg0: &Plan<T0, T1>) : u128 {
        arg0.bought
    }

    public fun buys<T0, T1>(arg0: &Plan<T0, T1>) : u64 {
        arg0.buys
    }

    fun changed(arg0: vector<u8>, arg1: vector<u8>, arg2: u64) {
        let v0 = ConfigChanged{
            what  : 0x1::ascii::string(arg0),
            coin  : 0x1::ascii::string(arg1),
            value : arg2,
        };
        0x2::event::emit<ConfigChanged>(v0);
    }

    public fun close<T0, T1>(arg0: Plan<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 8);
        destroy<T0, T1>(arg0, arg1)
    }

    public fun close_empty<T0, T1>(arg0: Plan<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<T0>(&arg0.funds) == 0, 14);
        0x2::coin::destroy_zero<T0>(destroy<T0, T1>(arg0, arg1));
    }

    fun coin_key<T0>() : 0x1::ascii::String {
        0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())
    }

    fun destroy<T0, T1>(arg0: Plan<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let Plan {
            id          : v0,
            owner       : v1,
            recipient   : _,
            funds       : v3,
            per_buy     : _,
            interval_ms : _,
            next_buy_ms : _,
            fee_bps     : _,
            min_out     : _,
            max_out     : _,
            buys        : v10,
            spent       : v11,
            bought      : v12,
        } = arg0;
        let v13 = v3;
        let v14 = v0;
        let v15 = Closed{
            plan     : 0x2::object::uid_to_inner(&v14),
            owner    : v1,
            refunded : 0x2::balance::value<T0>(&v13),
            buys     : v10,
            spent    : v11,
            bought   : v12,
        };
        0x2::event::emit<Closed>(v15);
        0x2::object::delete(v14);
        0x2::coin::from_balance<T0>(v13, arg1)
    }

    public fun destroy_keeper_cap(arg0: &Config, arg1: KeeperCap) {
        assert!(0x2::object::id<KeeperCap>(&arg1) != arg0.keeper, 27);
        let KeeperCap { id: v0 } = arg1;
        0x2::object::delete(v0);
    }

    public fun fee_bps<T0, T1>(arg0: &Plan<T0, T1>) : u64 {
        arg0.fee_bps
    }

    public fun fee_recipient(arg0: &Config) : address {
        arg0.fee_recipient
    }

    public fun finish_buy<T0, T1>(arg0: &mut Plan<T0, T1>, arg1: Buy<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: 0x2::coin::Coin<T0>) {
        let Buy {
            plan    : v0,
            spent   : v1,
            fee     : v2,
            min_out : v3,
        } = arg1;
        assert!(v0 == 0x2::object::id<Plan<T0, T1>>(arg0), 11);
        let v4 = 0x2::coin::value<T1>(&arg2);
        assert!(v4 > 0 && v4 >= v3, 12);
        let v5 = 0x2::coin::value<T0>(&arg3);
        let v6 = v1 - v5;
        let v7 = (v4 as u128) * (arg0.per_buy as u128);
        assert!(v7 >= (arg0.min_out as u128) * (v6 as u128), 24);
        assert!(arg0.max_out == 0 || v7 <= (arg0.max_out as u128) * (v6 as u128), 25);
        arg0.spent = arg0.spent - (v5 as u128);
        arg0.bought = arg0.bought + (v4 as u128);
        let v8 = Bought{
            plan        : v0,
            owner       : arg0.owner,
            recipient   : arg0.recipient,
            spent       : v6,
            fee         : v2,
            change      : v5,
            received    : v4,
            buys        : arg0.buys,
            funds_left  : 0x2::balance::value<T0>(&arg0.funds),
            next_buy_ms : arg0.next_buy_ms,
        };
        0x2::event::emit<Bought>(v8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg2, arg0.recipient);
        if (v5 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, arg0.owner);
        } else {
            0x2::coin::destroy_zero<T0>(arg3);
        };
    }

    public fun funds<T0, T1>(arg0: &Plan<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.funds)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = KeeperCap{id: 0x2::object::new(arg0)};
        let v1 = Config{
            id                 : 0x2::object::new(arg0),
            version            : 1,
            paused             : false,
            keeper             : 0x2::object::id<KeeperCap>(&v0),
            fee_recipient      : 0x2::tx_context::sender(arg0),
            min_interval_ms    : 3600000,
            inputs             : 0x2::table::new<0x1::ascii::String, u64>(arg0),
            outputs            : 0x2::table::new<0x1::ascii::String, u64>(arg0),
            any_output         : false,
            any_output_fee_bps : 50,
            blocked            : 0x2::table::new<0x1::ascii::String, bool>(arg0),
        };
        0x2::transfer::share_object<Config>(v1);
        let v2 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v2, 0x2::tx_context::sender(arg0));
        0x2::transfer::transfer<KeeperCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun interval_ms<T0, T1>(arg0: &Plan<T0, T1>) : u64 {
        arg0.interval_ms
    }

    public fun keeper(arg0: &Config) : 0x2::object::ID {
        arg0.keeper
    }

    public fun migrate(arg0: &mut Config, arg1: &AdminCap) {
        assert!(arg0.version < 1, 18);
        arg0.version = 1;
        changed(b"migrate", b"", 1);
    }

    public fun new_keeper_cap(arg0: &mut Config, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        let v0 = KeeperCap{id: 0x2::object::new(arg3)};
        arg0.keeper = 0x2::object::id<KeeperCap>(&v0);
        let v1 = KeeperChanged{
            cap : 0x2::object::id<KeeperCap>(&v0),
            to  : arg2,
        };
        0x2::event::emit<KeeperChanged>(v1);
        0x2::transfer::transfer<KeeperCap>(v0, arg2);
    }

    public fun next_buy_ms<T0, T1>(arg0: &Plan<T0, T1>) : u64 {
        arg0.next_buy_ms
    }

    public fun open<T0, T1>(arg0: &Config, arg1: &0x2::coin::CoinMetadata<T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: address, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        open_plan<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
    }

    fun open_plan<T0, T1>(arg0: &Config, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: address, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert_live(arg0);
        let v0 = coin_key<T0>();
        let v1 = coin_key<T1>();
        assert!(v0 != v1, 4);
        assert!(0x2::table::contains<0x1::ascii::String, u64>(&arg0.inputs, v0), 2);
        assert!(!0x2::table::contains<0x1::ascii::String, bool>(&arg0.blocked, v1), 19);
        assert!(0x2::table::contains<0x1::ascii::String, u64>(&arg0.outputs, v1) || arg0.any_output, 3);
        assert!(arg2 > 0 && arg2 >= *0x2::table::borrow<0x1::ascii::String, u64>(&arg0.inputs, v0), 5);
        assert!(arg3 >= arg0.min_interval_ms && arg3 <= 2592000000, 6);
        assert!(arg4 <= 2592000000, 20);
        assert!(arg6 == 0 || arg6 >= arg5, 21);
        assert!(arg8 != @0x0, 26);
        assert!(arg8 == 0x2::tx_context::sender(arg10) || 0x2::table::contains<0x1::ascii::String, u64>(&arg0.outputs, v1), 26);
        let v2 = 0x2::coin::value<T0>(&arg1);
        assert!(v2 >= arg2, 7);
        let v3 = if (0x2::table::contains<0x1::ascii::String, u64>(&arg0.outputs, v1)) {
            *0x2::table::borrow<0x1::ascii::String, u64>(&arg0.outputs, v1)
        } else {
            arg0.any_output_fee_bps
        };
        assert!(v3 <= arg7, 23);
        let v4 = 0x2::tx_context::sender(arg10);
        let v5 = 0x2::clock::timestamp_ms(arg9) + arg4;
        let v6 = Plan<T0, T1>{
            id          : 0x2::object::new(arg10),
            owner       : v4,
            recipient   : arg8,
            funds       : 0x2::coin::into_balance<T0>(arg1),
            per_buy     : arg2,
            interval_ms : arg3,
            next_buy_ms : v5,
            fee_bps     : v3,
            min_out     : arg5,
            max_out     : arg6,
            buys        : 0,
            spent       : 0,
            bought      : 0,
        };
        let v7 = Opened{
            plan         : 0x2::object::id<Plan<T0, T1>>(&v6),
            owner        : v4,
            recipient    : arg8,
            input        : v0,
            output       : v1,
            deposit      : v2,
            per_buy      : arg2,
            interval_ms  : arg3,
            first_buy_ms : v5,
            fee_bps      : v3,
            min_out      : arg5,
            max_out      : arg6,
        };
        0x2::event::emit<Opened>(v7);
        0x2::transfer::share_object<Plan<T0, T1>>(v6);
    }

    public fun open_with_currency<T0, T1>(arg0: &Config, arg1: &0x2::coin_registry::Currency<T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: address, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        open_plan<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
    }

    public fun owner<T0, T1>(arg0: &Plan<T0, T1>) : address {
        arg0.owner
    }

    public fun paused(arg0: &Config) : bool {
        arg0.paused
    }

    public fun per_buy<T0, T1>(arg0: &Plan<T0, T1>) : u64 {
        arg0.per_buy
    }

    public fun range<T0, T1>(arg0: &Plan<T0, T1>) : (u64, u64) {
        (arg0.min_out, arg0.max_out)
    }

    public fun recipient<T0, T1>(arg0: &Plan<T0, T1>) : address {
        arg0.recipient
    }

    public fun remove_input<T0>(arg0: &mut Config, arg1: &AdminCap) {
        assert_version(arg0);
        let v0 = coin_key<T0>();
        0x2::table::remove<0x1::ascii::String, u64>(&mut arg0.inputs, v0);
        let v1 = ConfigChanged{
            what  : 0x1::ascii::string(b"remove_input"),
            coin  : v0,
            value : 0,
        };
        0x2::event::emit<ConfigChanged>(v1);
    }

    public fun remove_output<T0>(arg0: &mut Config, arg1: &AdminCap) {
        assert_version(arg0);
        let v0 = coin_key<T0>();
        0x2::table::remove<0x1::ascii::String, u64>(&mut arg0.outputs, v0);
        let v1 = ConfigChanged{
            what  : 0x1::ascii::string(b"remove_output"),
            coin  : v0,
            value : 0,
        };
        0x2::event::emit<ConfigChanged>(v1);
    }

    public fun set_any_output(arg0: &mut Config, arg1: &AdminCap, arg2: bool, arg3: u64) {
        assert_version(arg0);
        assert!(arg3 <= 100, 13);
        arg0.any_output = arg2;
        arg0.any_output_fee_bps = arg3;
        let v0 = if (arg2) {
            b"any_output_on"
        } else {
            b"any_output_off"
        };
        changed(v0, b"", arg3);
    }

    public fun set_blocked<T0>(arg0: &mut Config, arg1: &AdminCap, arg2: bool) {
        assert_version(arg0);
        let v0 = coin_key<T0>();
        if (arg2 && !0x2::table::contains<0x1::ascii::String, bool>(&arg0.blocked, v0)) {
            0x2::table::add<0x1::ascii::String, bool>(&mut arg0.blocked, v0, true);
        } else if (!arg2 && 0x2::table::contains<0x1::ascii::String, bool>(&arg0.blocked, v0)) {
            0x2::table::remove<0x1::ascii::String, bool>(&mut arg0.blocked, v0);
        };
        let v1 = if (arg2) {
            b"block"
        } else {
            b"unblock"
        };
        let v2 = ConfigChanged{
            what  : 0x1::ascii::string(v1),
            coin  : v0,
            value : 0,
        };
        0x2::event::emit<ConfigChanged>(v2);
    }

    public fun set_fee_recipient(arg0: &mut Config, arg1: &AdminCap, arg2: address) {
        assert_version(arg0);
        arg0.fee_recipient = arg2;
        let v0 = FeeRecipientChanged{to: arg2};
        0x2::event::emit<FeeRecipientChanged>(v0);
    }

    public fun set_input<T0>(arg0: &mut Config, arg1: &AdminCap, arg2: u64) {
        assert_version(arg0);
        assert!(arg2 > 0, 5);
        let v0 = coin_key<T0>();
        if (0x2::table::contains<0x1::ascii::String, u64>(&arg0.inputs, v0)) {
            *0x2::table::borrow_mut<0x1::ascii::String, u64>(&mut arg0.inputs, v0) = arg2;
        } else {
            0x2::table::add<0x1::ascii::String, u64>(&mut arg0.inputs, v0, arg2);
        };
        let v1 = ConfigChanged{
            what  : 0x1::ascii::string(b"input"),
            coin  : v0,
            value : arg2,
        };
        0x2::event::emit<ConfigChanged>(v1);
    }

    public fun set_min_interval(arg0: &mut Config, arg1: &AdminCap, arg2: u64) {
        assert_version(arg0);
        assert!(arg2 >= 60000 && arg2 <= 2592000000, 17);
        arg0.min_interval_ms = arg2;
        changed(b"min_interval", b"", arg2);
    }

    public fun set_output<T0>(arg0: &mut Config, arg1: &AdminCap, arg2: u64) {
        assert_version(arg0);
        assert!(arg2 <= 100, 13);
        let v0 = coin_key<T0>();
        if (0x2::table::contains<0x1::ascii::String, u64>(&arg0.outputs, v0)) {
            *0x2::table::borrow_mut<0x1::ascii::String, u64>(&mut arg0.outputs, v0) = arg2;
        } else {
            0x2::table::add<0x1::ascii::String, u64>(&mut arg0.outputs, v0, arg2);
        };
        let v1 = ConfigChanged{
            what  : 0x1::ascii::string(b"output"),
            coin  : v0,
            value : arg2,
        };
        0x2::event::emit<ConfigChanged>(v1);
    }

    public fun set_paused(arg0: &mut Config, arg1: &AdminCap, arg2: bool) {
        assert_version(arg0);
        arg0.paused = arg2;
        let v0 = if (arg2) {
            b"pause"
        } else {
            b"unpause"
        };
        changed(v0, b"", 0);
    }

    public fun set_range<T0, T1>(arg0: &mut Plan<T0, T1>, arg1: u64, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 8);
        assert!(arg2 == 0 || arg2 >= arg1, 21);
        arg0.min_out = arg1;
        arg0.max_out = arg2;
        let v0 = RangeSet{
            plan    : 0x2::object::id<Plan<T0, T1>>(arg0),
            min_out : arg1,
            max_out : arg2,
        };
        0x2::event::emit<RangeSet>(v0);
    }

    public fun skip_buy<T0, T1>(arg0: &Config, arg1: &KeeperCap, arg2: &mut Plan<T0, T1>, arg3: &0x2::clock::Clock) {
        assert_version(arg0);
        assert!(0x2::object::id<KeeperCap>(arg1) == arg0.keeper, 15);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 >= arg2.next_buy_ms, 28);
        advance<T0, T1>(arg2, v0);
        let v1 = Skipped{
            plan        : 0x2::object::id<Plan<T0, T1>>(arg2),
            next_buy_ms : arg2.next_buy_ms,
        };
        0x2::event::emit<Skipped>(v1);
    }

    public fun spent<T0, T1>(arg0: &Plan<T0, T1>) : u128 {
        arg0.spent
    }

    public fun start_buy<T0, T1>(arg0: &Config, arg1: &KeeperCap, arg2: &mut Plan<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Buy<T0, T1>) {
        assert_live(arg0);
        assert!(0x2::object::id<KeeperCap>(arg1) == arg0.keeper, 15);
        assert!(!0x2::table::contains<0x1::ascii::String, bool>(&arg0.blocked, coin_key<T1>()), 19);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(v0 >= arg2.next_buy_ms, 9);
        let v1 = 0x2::balance::value<T0>(&arg2.funds);
        assert!(v1 > 0, 10);
        let v2 = if (v1 - arg2.per_buy < arg2.per_buy) {
            v1
        } else {
            arg2.per_buy
        };
        let v3 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg2.funds, v2), arg5);
        let v4 = (((v2 as u128) * (arg2.fee_bps as u128) / (10000 as u128)) as u64);
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v3, v4, arg5), arg0.fee_recipient);
        };
        advance<T0, T1>(arg2, v0);
        arg2.buys = arg2.buys + 1;
        arg2.spent = arg2.spent + (v2 as u128);
        let v5 = Buy<T0, T1>{
            plan    : 0x2::object::id<Plan<T0, T1>>(arg2),
            spent   : v2,
            fee     : v4,
            min_out : arg3,
        };
        (v3, v5)
    }

    public fun top_up<T0, T1>(arg0: &mut Plan<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 8);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0 && 0x2::balance::value<T0>(&arg0.funds) + v0 >= arg0.per_buy, 16);
        0x2::balance::join<T0>(&mut arg0.funds, 0x2::coin::into_balance<T0>(arg1));
        let v1 = ToppedUp{
            plan   : 0x2::object::id<Plan<T0, T1>>(arg0),
            amount : v0,
            funds  : 0x2::balance::value<T0>(&arg0.funds),
        };
        0x2::event::emit<ToppedUp>(v1);
    }

    // decompiled from Move bytecode v7
}

