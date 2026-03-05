module 0x5270b2f723fa60bd15cfef2a76ab8bb891e15851e0ac3280d25e9d50707a5c10::arb {
    struct ArbConfig has key {
        id: 0x2::object::UID,
        admin: address,
        treasury: address,
        paused: bool,
        max_in_quote: u64,
        min_profit_abs: u64,
        fee_bps: u64,
    }

    struct CycleTicket<phantom T0> has key {
        id: 0x2::object::UID,
        owner: address,
        in_amount: u64,
    }

    struct InitEvent has copy, drop {
        config_id: address,
        admin: address,
        treasury: address,
        max_in_quote: u64,
        min_profit_abs: u64,
        fee_bps: u64,
    }

    struct StartEvent has copy, drop {
        sender: address,
        ticket_id: address,
        in_amount: u64,
    }

    struct FinalizeEvent has copy, drop {
        sender: address,
        in_amount: u64,
        out_amount: u64,
        profit: u64,
        fee_paid: u64,
    }

    public fun finalize_cycle<T0>(arg0: &ArbConfig, arg1: CycleTicket<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 2);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(arg1.owner == v0, 5);
        let v1 = 0x2::coin::value<T0>(&arg2);
        assert!(v1 >= arg3, 6);
        let v2 = if (arg0.min_profit_abs >= arg4) {
            arg0.min_profit_abs
        } else {
            arg4
        };
        assert!(v1 >= arg1.in_amount + v2, 7);
        let v3 = v1 - arg1.in_amount;
        let v4 = v3 * arg0.fee_bps / 10000;
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg2, v4, arg5), arg0.treasury);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, v0);
        let v5 = FinalizeEvent{
            sender     : v0,
            in_amount  : arg1.in_amount,
            out_amount : v1,
            profit     : v3,
            fee_paid   : v4,
        };
        0x2::event::emit<FinalizeEvent>(v5);
        let CycleTicket {
            id        : v6,
            owner     : _,
            in_amount : _,
        } = arg1;
        0x2::object::delete(v6);
    }

    public fun init_config(arg0: address, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 <= 10000, 8);
        let v0 = ArbConfig{
            id             : 0x2::object::new(arg5),
            admin          : arg0,
            treasury       : arg1,
            paused         : false,
            max_in_quote   : arg2,
            min_profit_abs : arg3,
            fee_bps        : arg4,
        };
        let v1 = 0x2::object::uid_to_inner(&v0.id);
        let v2 = InitEvent{
            config_id      : 0x2::object::id_to_address(&v1),
            admin          : arg0,
            treasury       : arg1,
            max_in_quote   : arg2,
            min_profit_abs : arg3,
            fee_bps        : arg4,
        };
        0x2::event::emit<InitEvent>(v2);
        0x2::transfer::share_object<ArbConfig>(v0);
    }

    public fun set_limits(arg0: &mut ArbConfig, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 1);
        assert!(arg3 <= 10000, 8);
        arg0.max_in_quote = arg1;
        arg0.min_profit_abs = arg2;
        arg0.fee_bps = arg3;
    }

    public fun set_paused(arg0: &mut ArbConfig, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        arg0.paused = arg1;
    }

    public fun set_treasury(arg0: &mut ArbConfig, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        arg0.treasury = arg1;
    }

    public fun start_cycle<T0>(arg0: &ArbConfig, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, CycleTicket<T0>) {
        assert!(!arg0.paused, 2);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::coin::value<T0>(&arg1);
        assert!(v1 > 0, 3);
        assert!(v1 <= arg0.max_in_quote, 4);
        let v2 = CycleTicket<T0>{
            id        : 0x2::object::new(arg2),
            owner     : v0,
            in_amount : v1,
        };
        let v3 = 0x2::object::uid_to_inner(&v2.id);
        let v4 = StartEvent{
            sender    : v0,
            ticket_id : 0x2::object::id_to_address(&v3),
            in_amount : v1,
        };
        0x2::event::emit<StartEvent>(v4);
        (arg1, v2)
    }

    // decompiled from Move bytecode v6
}

