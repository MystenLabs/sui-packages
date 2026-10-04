module 0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session {
    struct Leg has copy, drop, store {
        pool: 0x2::object::ID,
        a2b: bool,
    }

    struct Session<phantom T0> {
        phase: u8,
        fixed: bool,
        legs: u64,
        route: vector<Leg>,
        search: 0x1::option::Option<0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::search::Search>,
        inputs: vector<u64>,
        amounts: vector<u64>,
        costs: vector<u64>,
        returned: vector<u64>,
        quoted: u64,
        evaluations: u64,
        amount: u64,
        quoted_output: u64,
        minimums: vector<u64>,
        executed: u64,
        cost: u64,
        carry: 0x2::balance::Balance<T0>,
        min_surplus: u64,
        deadline_ms: u64,
        clock_ms: u64,
    }

    struct Result<phantom T0> has copy, drop {
        fixed: bool,
        legs: u64,
        evaluations: u64,
        selected_input: u64,
        quoted_output: u64,
        surplus: u64,
        min_surplus: u64,
        cost: u64,
        gas_price: u64,
        epoch: u64,
        deadline_ms: u64,
        clock_ms: u64,
    }

    public fun add_cost<T0>(arg0: &mut Session<T0>, arg1: u64) {
        assert!(arg0.phase == 2, 3);
        arg0.cost = 0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::search::checked_sum(arg0.cost, arg1);
    }

    fun add_costs<T0>(arg0: &mut Session<T0>, arg1: &vector<u64>) {
        let v0 = 0x1::vector::length<u64>(&arg0.inputs);
        assert!(0x1::vector::length<u64>(arg1) == v0, 1);
        let v1 = 0;
        while (v1 < v0) {
            *0x1::vector::borrow_mut<u64>(&mut arg0.costs, v1) = 0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::search::checked_sum(*0x1::vector::borrow<u64>(&arg0.costs, v1), *0x1::vector::borrow<u64>(arg1, v1));
            v1 = v1 + 1;
        };
    }

    public fun candidate_inputs<T0>(arg0: &Session<T0>) : vector<u64> {
        assert!(arg0.phase == 0, 3);
        arg0.inputs
    }

    public fun charge_quote<T0>(arg0: &mut Session<T0>, arg1: vector<u64>) {
        assert!(arg0.phase == 0, 3);
        add_costs<T0>(arg0, &arg1);
    }

    fun check_context(arg0: u64, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : u64 {
        assert!(arg1 == 0x2::tx_context::gas_price(arg4) && arg2 == 0x2::tx_context::epoch(arg4), 1);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 <= arg0 && arg0 - v0 <= 60000, 2);
        v0
    }

    public fun close_loan<T0>(arg0: &mut Session<T0>, arg1: &mut 0x2::balance::Balance<T0>) : u64 {
        assert!(arg0.phase == 2 && arg0.executed == arg0.legs, 3);
        0x2::balance::join<T0>(arg1, 0x2::balance::withdraw_all<T0>(&mut arg0.carry));
        assert!(0x2::balance::value<T0>(arg1) >= arg0.amount, 6);
        arg0.phase = 3;
        arg0.amount
    }

    fun close_round<T0>(arg0: &mut Session<T0>) {
        let v0 = arg0.inputs;
        let v1 = arg0.amounts;
        let v2 = arg0.costs;
        let v3 = arg0.returned;
        let v4 = 0x1::option::borrow_mut<0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::search::Search>(&mut arg0.search);
        let v5 = 0x1::vector::length<u64>(&v0);
        let v6 = 0;
        while (v6 < v5) {
            0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::search::record(v4, *0x1::vector::borrow<u64>(&v0, v6), 0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::search::checked_sum(*0x1::vector::borrow<u64>(&v1, v6), *0x1::vector::borrow<u64>(&v3, v6)), *0x1::vector::borrow<u64>(&v2, v6), *0x1::vector::borrow<u64>(&v1, v6) > 0);
            v6 = v6 + 1;
        };
        0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::search::advance(v4);
        arg0.evaluations = arg0.evaluations + v5;
        if (0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::search::finished(v4)) {
            let (v7, v8, v9, _) = 0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::search::result(v4);
            assert!(v7 > 0 && 0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::search::qualifies(v7, v8, v9, arg0.min_surplus), 8);
            arg0.amount = v7;
            arg0.quoted_output = v8;
            arg0.phase = 1;
        } else {
            let v11 = 0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::search::candidates(v4);
            arg0.costs = zeros(0x1::vector::length<u64>(&v11));
            arg0.returned = zeros(0x1::vector::length<u64>(&v11));
            arg0.amounts = v11;
            arg0.inputs = v11;
            arg0.quoted = 0;
        };
    }

    public fun finish<T0>(arg0: Session<T0>, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        settle<T0>(arg0, 0x2::balance::value<T0>(&arg1), arg2);
        0x2::coin::from_balance<T0>(arg1, arg2)
    }

    public fun finish_to_sender<T0>(arg0: Session<T0>, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::tx_context::TxContext) {
        settle<T0>(arg0, 0x2::balance::value<T0>(&arg1), arg2);
        0x2::balance::send_funds<T0>(arg1, 0x2::tx_context::sender(arg2));
    }

    public fun keep<T0>(arg0: &mut Session<T0>, arg1: 0x2::balance::Balance<T0>) {
        assert!(arg0.phase == 2, 3);
        0x2::balance::join<T0>(&mut arg0.carry, arg1);
    }

    fun new_session<T0>(arg0: bool, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : Session<T0> {
        let v0 = if (arg1 >= 2) {
            if (arg1 <= 5) {
                arg2 > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1);
        Session<T0>{
            phase         : 0,
            fixed         : arg0,
            legs          : arg1,
            route         : 0x1::vector::empty<Leg>(),
            search        : 0x1::option::none<0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::search::Search>(),
            inputs        : vector[],
            amounts       : vector[],
            costs         : vector[],
            returned      : vector[],
            quoted        : 0,
            evaluations   : 0,
            amount        : 0,
            quoted_output : 0,
            minimums      : vector[],
            executed      : 0,
            cost          : 0,
            carry         : 0x2::balance::zero<T0>(),
            min_surplus   : arg2,
            deadline_ms   : arg3,
            clock_ms      : arg4,
        }
    }

    public fun no_opportunity_code() : u64 {
        8
    }

    public fun open_loan<T0>(arg0: &mut Session<T0>) : u64 {
        assert!(arg0.phase == 1, 3);
        arg0.phase = 2;
        arg0.amount
    }

    public fun quote_inputs<T0>(arg0: &Session<T0>) : vector<u64> {
        assert!(arg0.phase == 0, 3);
        arg0.amounts
    }

    public fun record_leg<T0>(arg0: &mut Session<T0>, arg1: 0x2::object::ID, arg2: bool, arg3: u64) {
        assert!(arg0.phase == 2, 3);
        let v0 = arg0.executed;
        let v1 = if (v0 < arg0.legs) {
            let v2 = Leg{
                pool : arg1,
                a2b  : arg2,
            };
            *0x1::vector::borrow<Leg>(&arg0.route, v0) == v2
        } else {
            false
        };
        assert!(v1, 4);
        if (!0x1::vector::is_empty<u64>(&arg0.minimums)) {
            assert!(arg3 >= *0x1::vector::borrow<u64>(&arg0.minimums, v0), 5);
        };
        arg0.executed = v0 + 1;
    }

    public fun record_quote<T0>(arg0: &mut Session<T0>, arg1: 0x2::object::ID, arg2: bool, arg3: vector<u64>, arg4: vector<u64>, arg5: vector<u64>) {
        assert!(arg0.phase == 0, 3);
        let v0 = 0x1::vector::length<u64>(&arg0.amounts);
        let v1 = if (0x1::vector::length<u64>(&arg3) == v0) {
            if (0x1::vector::is_empty<u64>(&arg4) || 0x1::vector::length<u64>(&arg4) == v0) {
                0x1::vector::is_empty<u64>(&arg5) || 0x1::vector::length<u64>(&arg5) == v0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 1);
        let v2 = Leg{
            pool : arg1,
            a2b  : arg2,
        };
        if (0x1::vector::length<Leg>(&arg0.route) < arg0.legs) {
            assert!(0x1::vector::length<Leg>(&arg0.route) == arg0.quoted, 4);
            0x1::vector::push_back<Leg>(&mut arg0.route, v2);
        } else {
            assert!(*0x1::vector::borrow<Leg>(&arg0.route, arg0.quoted) == v2, 4);
        };
        if (!0x1::vector::is_empty<u64>(&arg4)) {
            add_costs<T0>(arg0, &arg4);
        };
        if (!0x1::vector::is_empty<u64>(&arg5)) {
            let v3 = 0;
            while (v3 < v0) {
                *0x1::vector::borrow_mut<u64>(&mut arg0.returned, v3) = 0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::search::checked_sum(*0x1::vector::borrow<u64>(&arg0.returned, v3), *0x1::vector::borrow<u64>(&arg5, v3));
                v3 = v3 + 1;
            };
        };
        arg0.amounts = arg3;
        arg0.quoted = arg0.quoted + 1;
        if (arg0.quoted == arg0.legs) {
            close_round<T0>(arg0);
        };
    }

    public fun refund<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
        } else {
            0x2::balance::send_funds<T0>(arg0, 0x2::tx_context::sender(arg1));
        };
    }

    fun settle<T0>(arg0: Session<T0>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        let Session {
            phase         : v0,
            fixed         : v1,
            legs          : v2,
            route         : _,
            search        : _,
            inputs        : _,
            amounts       : _,
            costs         : _,
            returned      : _,
            quoted        : _,
            evaluations   : v10,
            amount        : v11,
            quoted_output : v12,
            minimums      : _,
            executed      : _,
            cost          : v15,
            carry         : v16,
            min_surplus   : v17,
            deadline_ms   : v18,
            clock_ms      : v19,
        } = arg0;
        assert!(v0 == 3, 3);
        0x2::balance::destroy_zero<T0>(v16);
        assert!((arg1 as u128) >= (v17 as u128) + (v15 as u128), 7);
        let v20 = Result<T0>{
            fixed          : v1,
            legs           : v2,
            evaluations    : v10,
            selected_input : v11,
            quoted_output  : v12,
            surplus        : arg1,
            min_surplus    : v17,
            cost           : v15,
            gas_price      : 0x2::tx_context::gas_price(arg2),
            epoch          : 0x2::tx_context::epoch(arg2),
            deadline_ms    : v18,
            clock_ms       : v19,
        };
        0x2::event::emit<Result<T0>>(v20);
    }

    public fun start_fixed<T0>(arg0: vector<u64>, arg1: vector<0x2::object::ID>, arg2: vector<bool>, arg3: vector<u64>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : Session<T0> {
        assert!(0x1::vector::length<u64>(&arg0) == 5, 1);
        let v0 = 0x1::vector::length<0x2::object::ID>(&arg1);
        let v1 = new_session<T0>(true, v0, *0x1::vector::borrow<u64>(&arg0, 1), *0x1::vector::borrow<u64>(&arg0, 2), check_context(*0x1::vector::borrow<u64>(&arg0, 2), *0x1::vector::borrow<u64>(&arg0, 3), *0x1::vector::borrow<u64>(&arg0, 4), arg4, arg5));
        assert!(0x1::vector::length<bool>(&arg2) == v0 && (0x1::vector::is_empty<u64>(&arg3) || 0x1::vector::length<u64>(&arg3) == v0), 1);
        0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::search::new(*0x1::vector::borrow<u64>(&arg0, 0), *0x1::vector::borrow<u64>(&arg0, 0), *0x1::vector::borrow<u64>(&arg0, 0), 1);
        let v2 = 0;
        while (v2 < v0) {
            let v3 = Leg{
                pool : *0x1::vector::borrow<0x2::object::ID>(&arg1, v2),
                a2b  : *0x1::vector::borrow<bool>(&arg2, v2),
            };
            0x1::vector::push_back<Leg>(&mut v1.route, v3);
            v2 = v2 + 1;
        };
        v1.minimums = arg3;
        v1.amount = *0x1::vector::borrow<u64>(&arg0, 0);
        v1.phase = 1;
        v1
    }

    public fun start_search<T0>(arg0: vector<u64>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) : Session<T0> {
        assert!(0x1::vector::length<u64>(&arg0) == 9, 1);
        let v0 = new_session<T0>(false, *0x1::vector::borrow<u64>(&arg0, 8), *0x1::vector::borrow<u64>(&arg0, 4), *0x1::vector::borrow<u64>(&arg0, 5), check_context(*0x1::vector::borrow<u64>(&arg0, 5), *0x1::vector::borrow<u64>(&arg0, 6), *0x1::vector::borrow<u64>(&arg0, 7), arg1, arg2));
        let v1 = 0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::search::new(*0x1::vector::borrow<u64>(&arg0, 1), *0x1::vector::borrow<u64>(&arg0, 2), *0x1::vector::borrow<u64>(&arg0, 0), *0x1::vector::borrow<u64>(&arg0, 3));
        let v2 = 0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::search::candidates(&v1);
        v0.costs = zeros(0x1::vector::length<u64>(&v2));
        v0.returned = zeros(0x1::vector::length<u64>(&v2));
        v0.amounts = v2;
        v0.inputs = v2;
        0x1::option::fill<0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::search::Search>(&mut v0.search, v1);
        v0
    }

    fun zeros(arg0: u64) : vector<u64> {
        let v0 = vector[];
        let v1 = 0;
        while (v1 < arg0) {
            0x1::vector::push_back<u64>(&mut v0, 0);
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v7
}

