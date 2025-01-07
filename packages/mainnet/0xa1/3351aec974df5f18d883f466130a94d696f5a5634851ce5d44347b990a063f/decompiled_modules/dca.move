module 0xa13351aec974df5f18d883f466130a94d696f5a5634851ce5d44347b990a063f::dca {
    struct DCA<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        owner: address,
        delegatee: address,
        start_timestamp: u64,
        last_trade_timestamp: u64,
        every: u64,
        remaining_orders: u64,
        time_scale: u8,
        cooldown: u64,
        input_balance: 0x2::balance::Balance<T0>,
        amount_per_trade: u64,
        min: u64,
        max: u64,
        active: bool,
        fee_percent: u64,
        total_owner_output: u64,
        total_delegatee_output: u64,
        witness: 0x1::type_name::TypeName,
    }

    struct Admin has store, key {
        id: 0x2::object::UID,
    }

    struct TradePolicy has key {
        id: 0x2::object::UID,
        whitelist: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    struct Request<phantom T0> has key {
        id: 0x2::object::UID,
        dca: address,
        owner: address,
        rule: 0x1::option::Option<0x1::type_name::TypeName>,
        witness: 0x1::type_name::TypeName,
        output: 0x2::coin::Coin<T0>,
    }

    struct Start has copy, drop, store {
        input: 0x1::type_name::TypeName,
        output: 0x1::type_name::TypeName,
        every: u64,
        time_scale: u8,
        input_amount: u64,
        dca: address,
        delegatee: address,
    }

    struct Resolve has copy, drop, store {
        input: 0x1::type_name::TypeName,
        output: 0x1::type_name::TypeName,
        fee: u64,
        input_amount: u64,
        output_amount: u64,
        request: address,
        dca: address,
    }

    struct Destroy has copy, drop, store {
        input: 0x1::type_name::TypeName,
        output: 0x1::type_name::TypeName,
        input_amount: u64,
        dca: address,
        owner: address,
    }

    public fun new<T0, T1, T2: drop>(arg0: &TradePolicy, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: u8, arg6: u64, arg7: u64, arg8: u64, arg9: address, arg10: &mut 0x2::tx_context::TxContext) : DCA<T0, T1> {
        assert!(3000000 > arg8, 6);
        let v0 = 0x1::type_name::get<T2>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.whitelist, &v0), 9);
        assert_every(arg3, arg5);
        let v1 = DCA<T0, T1>{
            id                     : 0x2::object::new(arg10),
            owner                  : 0x2::tx_context::sender(arg10),
            delegatee              : arg9,
            start_timestamp        : timestamp_s(arg1),
            last_trade_timestamp   : 0,
            every                  : arg3,
            remaining_orders       : arg4,
            time_scale             : arg5,
            cooldown               : convert_to_timestamp(arg5) * arg3,
            input_balance          : 0x2::coin::into_balance<T0>(arg2),
            amount_per_trade       : 0x6c42b435f4963a617f25d2b4630f3c2162d910d6c2f14dd0f440f8ad83a2f52f::math64::div_down(0x2::coin::value<T0>(&arg2), arg4),
            min                    : arg6,
            max                    : arg7,
            active                 : true,
            fee_percent            : arg8,
            total_owner_output     : 0,
            total_delegatee_output : 0,
            witness                : 0x1::type_name::get<T2>(),
        };
        let v2 = Start{
            input        : 0x1::type_name::get<T0>(),
            output       : 0x1::type_name::get<T1>(),
            every        : arg3,
            time_scale   : arg5,
            input_amount : 0x2::balance::value<T0>(&v1.input_balance),
            dca          : 0x2::object::id_address<DCA<T0, T1>>(&v1),
            delegatee    : arg9,
        };
        0x2::event::emit<Start>(v2);
        v1
    }

    public fun min<T0, T1>(arg0: &DCA<T0, T1>) : u64 {
        arg0.min
    }

    public fun dca<T0>(arg0: &Request<T0>) : address {
        arg0.dca
    }

    public fun active<T0, T1>(arg0: &DCA<T0, T1>) : bool {
        arg0.active
    }

    public fun add<T0: drop, T1>(arg0: &mut Request<T1>, arg1: T0, arg2: 0x2::coin::Coin<T1>) {
        assert!(0x1::option::is_none<0x1::type_name::TypeName>(&arg0.rule), 10);
        arg0.rule = 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::get<T0>());
        0x2::coin::join<T1>(&mut arg0.output, arg2);
    }

    public fun amount_per_trade<T0, T1>(arg0: &DCA<T0, T1>) : u64 {
        arg0.amount_per_trade
    }

    public fun approve<T0: drop>(arg0: &mut TradePolicy, arg1: &Admin) {
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.whitelist, 0x1::type_name::get<T0>());
    }

    public fun assert_every(arg0: u64, arg1: u8) {
        let v0 = if (arg1 == 0) {
            arg0 >= 1 && arg0 <= 59
        } else if (arg1 == 1) {
            arg0 >= 1 && arg0 <= 24
        } else if (arg1 == 2) {
            arg0 >= 1 && arg0 <= 6
        } else if (arg1 == 3) {
            arg0 >= 1 && arg0 <= 4
        } else {
            assert!(arg1 == 4, 2);
            arg0 >= 1 && arg0 <= 12
        };
        assert!(v0, 3);
    }

    public fun confirm<T0, T1>(arg0: &mut DCA<T0, T1>, arg1: &0x2::clock::Clock, arg2: Request<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        let Request {
            id      : v0,
            dca     : v1,
            owner   : _,
            rule    : v3,
            witness : v4,
            output  : v5,
        } = arg2;
        let v6 = v3;
        let v7 = v0;
        0x2::object::delete(v7);
        assert!(0x2::object::uid_to_address(&arg0.id) == v1, 11);
        assert!(0x1::option::is_some<0x1::type_name::TypeName>(&v6), 12);
        assert!(v4 == 0x1::option::destroy_some<0x1::type_name::TypeName>(v6), 13);
        resolve<T0, T1>(arg0, arg1, v5, 0x2::object::uid_to_address(&v7), arg3);
    }

    fun convert_to_timestamp(arg0: u8) : u64 {
        if (arg0 == 0) {
            return 60
        };
        if (arg0 == 1) {
            return 3600
        };
        if (arg0 == 2) {
            return 86400
        };
        if (arg0 == 3) {
            return 604800
        };
        assert!(arg0 == 4, 4);
        2419200
    }

    public fun cooldown<T0, T1>(arg0: &DCA<T0, T1>) : u64 {
        arg0.cooldown
    }

    public fun delegatee<T0, T1>(arg0: &DCA<T0, T1>) : address {
        arg0.delegatee
    }

    public fun destroy<T0, T1>(arg0: DCA<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        let DCA {
            id                     : v0,
            owner                  : v1,
            delegatee              : _,
            start_timestamp        : _,
            last_trade_timestamp   : _,
            every                  : _,
            remaining_orders       : _,
            time_scale             : _,
            cooldown               : _,
            input_balance          : v9,
            amount_per_trade       : _,
            min                    : _,
            max                    : _,
            active                 : v13,
            fee_percent            : _,
            total_owner_output     : _,
            total_delegatee_output : _,
            witness                : _,
        } = arg0;
        let v18 = v9;
        let v19 = v0;
        assert!(!v13, 8);
        let v20 = 0x2::balance::value<T0>(&v18);
        let v21 = Destroy{
            input        : 0x1::type_name::get<T0>(),
            output       : 0x1::type_name::get<T1>(),
            input_amount : v20,
            dca          : 0x2::object::uid_to_address(&v19),
            owner        : v1,
        };
        0x2::event::emit<Destroy>(v21);
        if (v20 == 0) {
            0x2::balance::destroy_zero<T0>(v18);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v18, arg1), v1);
        };
        0x2::object::delete(v19);
    }

    public fun disapprove<T0: drop>(arg0: &mut TradePolicy, arg1: &Admin) {
        let v0 = 0x1::type_name::get<T0>();
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.whitelist, &v0);
    }

    public fun every<T0, T1>(arg0: &DCA<T0, T1>) : u64 {
        arg0.every
    }

    public fun fee_percent<T0, T1>(arg0: &DCA<T0, T1>) : u64 {
        arg0.fee_percent
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TradePolicy{
            id        : 0x2::object::new(arg0),
            whitelist : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        };
        0x2::transfer::share_object<TradePolicy>(v0);
        let v1 = Admin{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<Admin>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun input<T0, T1>(arg0: &DCA<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.input_balance)
    }

    public fun last_trade_timestamp<T0, T1>(arg0: &DCA<T0, T1>) : u64 {
        arg0.last_trade_timestamp
    }

    public fun max<T0, T1>(arg0: &DCA<T0, T1>) : u64 {
        arg0.max
    }

    public fun output<T0>(arg0: &Request<T0>) : u64 {
        0x2::coin::value<T0>(&arg0.output)
    }

    public fun owner<T0, T1>(arg0: &DCA<T0, T1>) : address {
        arg0.owner
    }

    public fun remaining_orders<T0, T1>(arg0: &DCA<T0, T1>) : u64 {
        arg0.remaining_orders
    }

    public fun request<T0, T1>(arg0: &mut DCA<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : (Request<T1>, 0x2::coin::Coin<T0>) {
        let v0 = Request<T1>{
            id      : 0x2::object::new(arg1),
            dca     : 0x2::object::uid_to_address(&arg0.id),
            owner   : arg0.owner,
            rule    : 0x1::option::none<0x1::type_name::TypeName>(),
            witness : arg0.witness,
            output  : 0x2::coin::zero<T1>(arg1),
        };
        (v0, take<T0, T1>(arg0, arg1))
    }

    public fun request_owner<T0>(arg0: &Request<T0>) : address {
        arg0.owner
    }

    fun resolve<T0, T1>(arg0: &mut DCA<T0, T1>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T1>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.active, 1);
        let v0 = timestamp_s(arg1);
        assert!(v0 - arg0.last_trade_timestamp >= arg0.cooldown, 5);
        arg0.last_trade_timestamp = v0;
        let v1 = 0x2::coin::value<T1>(&arg2);
        assert!(v1 >= arg0.min && arg0.max >= v1, 0);
        arg0.remaining_orders = arg0.remaining_orders - 1;
        if (arg0.remaining_orders == 0 || 0x2::balance::value<T0>(&arg0.input_balance) == 0) {
            arg0.active = false;
        };
        let v2 = 0x2::coin::into_balance<T1>(arg2);
        let v3 = 0x2::balance::split<T1>(&mut v2, 0x6c42b435f4963a617f25d2b4630f3c2162d910d6c2f14dd0f440f8ad83a2f52f::math64::mul_div_up(v1, arg0.fee_percent, 1000000000));
        arg0.total_owner_output = arg0.total_owner_output + 0x2::balance::value<T1>(&v2);
        arg0.total_delegatee_output = arg0.total_delegatee_output + 0x2::balance::value<T1>(&v3);
        let v4 = Resolve{
            input         : 0x1::type_name::get<T0>(),
            output        : 0x1::type_name::get<T1>(),
            fee           : 0x2::balance::value<T1>(&v3),
            input_amount  : arg0.amount_per_trade,
            output_amount : v1,
            request       : arg3,
            dca           : 0x2::object::id_address<DCA<T0, T1>>(arg0),
        };
        0x2::event::emit<Resolve>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v3, arg4), arg0.delegatee);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v2, arg4), arg0.owner);
    }

    public fun rule<T0>(arg0: &Request<T0>) : 0x1::option::Option<0x1::type_name::TypeName> {
        arg0.rule
    }

    public fun share<T0, T1>(arg0: DCA<T0, T1>) {
        0x2::transfer::share_object<DCA<T0, T1>>(arg0);
    }

    public fun start_timestamp<T0, T1>(arg0: &DCA<T0, T1>) : u64 {
        arg0.start_timestamp
    }

    public fun stop<T0, T1>(arg0: &mut DCA<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 7);
        arg0.active = false;
    }

    fun take<T0, T1>(arg0: &mut DCA<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.input_balance, 0x6c42b435f4963a617f25d2b4630f3c2162d910d6c2f14dd0f440f8ad83a2f52f::math64::min(arg0.amount_per_trade, 0x2::balance::value<T0>(&arg0.input_balance))), arg1)
    }

    public fun time_scale<T0, T1>(arg0: &DCA<T0, T1>) : u8 {
        arg0.time_scale
    }

    fun timestamp_s(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    public fun total_delegatee_output<T0, T1>(arg0: &DCA<T0, T1>) : u64 {
        arg0.total_delegatee_output
    }

    public fun total_owner_output<T0, T1>(arg0: &DCA<T0, T1>) : u64 {
        arg0.total_owner_output
    }

    public fun whitelist(arg0: &TradePolicy) : vector<0x1::type_name::TypeName> {
        0x2::vec_set::into_keys<0x1::type_name::TypeName>(arg0.whitelist)
    }

    public fun witness<T0, T1>(arg0: &DCA<T0, T1>) : 0x1::type_name::TypeName {
        arg0.witness
    }

    // decompiled from Move bytecode v6
}

