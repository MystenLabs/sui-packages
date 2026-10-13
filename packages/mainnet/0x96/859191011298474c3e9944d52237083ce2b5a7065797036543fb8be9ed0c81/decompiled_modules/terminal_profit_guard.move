module 0x1c89f1442b2dcebcfbbf226263c6f4228f4397edff700a0af0a31cef41677713::terminal_profit_guard {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct OperatorCap has store, key {
        id: 0x2::object::UID,
        operator: address,
        treasury: address,
    }

    struct PauseCap has store, key {
        id: 0x2::object::UID,
        paused: bool,
    }

    struct ProfitSwept<phantom T0> has copy, drop {
        amount: u64,
        treasury: address,
        operator: address,
        route_hash: vector<u8>,
    }

    struct ExecutionPauseChanged has copy, drop {
        paused: bool,
    }

    public entry fun assert_min_profit_and_transfer<T0>(arg0: &OperatorCap, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(v0 == arg0.operator, 1);
        let v1 = 0x2::coin::value<T0>(&arg1);
        assert!(v1 >= arg2, 2);
        let v2 = ProfitSwept<T0>{
            amount     : v1,
            treasury   : arg0.treasury,
            operator   : v0,
            route_hash : arg3,
        };
        0x2::event::emit<ProfitSwept<T0>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, arg0.treasury);
    }

    public entry fun assert_min_profit_and_transfer_with_pause<T0>(arg0: &OperatorCap, arg1: &PauseCap, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(v0 == arg0.operator, 1);
        assert!(!arg1.paused, 4);
        let v1 = 0x2::coin::value<T0>(&arg2);
        assert!(v1 >= arg3, 2);
        let v2 = ProfitSwept<T0>{
            amount     : v1,
            treasury   : arg0.treasury,
            operator   : v0,
            route_hash : arg4,
        };
        0x2::event::emit<ProfitSwept<T0>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, arg0.treasury);
    }

    public entry fun create_pause_cap(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = PauseCap{
            id     : 0x2::object::new(arg1),
            paused : false,
        };
        0x2::transfer::transfer<PauseCap>(v0, 0x2::tx_context::sender(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        let v2 = OperatorCap{
            id       : 0x2::object::new(arg0),
            operator : v0,
            treasury : v0,
        };
        0x2::transfer::transfer<AdminCap>(v1, v0);
        0x2::transfer::transfer<OperatorCap>(v2, v0);
    }

    public entry fun rotate_operator(arg0: &AdminCap, arg1: &mut OperatorCap, arg2: address, arg3: address) {
        assert!(arg3 != @0x0, 3);
        arg1.operator = arg2;
        arg1.treasury = arg3;
    }

    public entry fun set_execution_paused(arg0: &AdminCap, arg1: &mut PauseCap, arg2: bool) {
        arg1.paused = arg2;
        let v0 = ExecutionPauseChanged{paused: arg2};
        0x2::event::emit<ExecutionPauseChanged>(v0);
    }

    // decompiled from Move bytecode v6
}

