module 0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::session {
    struct Leg has copy, drop, store {
        pool: 0x2::object::ID,
        a2b: bool,
    }

    struct Session<phantom T0> {
        phase: u8,
        fixed: bool,
        legs: u64,
        route: vector<Leg>,
        search: 0x1::option::Option<0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::search::Search>,
        inputs: vector<u64>,
        amounts: vector<u64>,
        costs: vector<u64>,
        quoted: u64,
        amount: u64,
        quoted_output: u64,
        executed: u64,
        cost: u64,
        carry: 0x2::balance::Balance<T0>,
        min_surplus: u64,
        deadline_ms: u64,
        clock_ms: u64,
        gas_price: u64,
        epoch: u64,
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

    public fun amount<T0>(arg0: &Session<T0>) : u64 {
        arg0.amount
    }

    public fun amounts<T0>(arg0: &Session<T0>) : vector<u64> {
        arg0.amounts
    }

    fun assert_searching<T0>(arg0: &Session<T0>) {
        let v0 = if (arg0.phase == 0) {
            if (!arg0.fixed) {
                arg0.amount == 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 3);
    }

    fun begin_round<T0>(arg0: &mut Session<T0>) {
        arg0.inputs = 0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::search::candidates(0x1::option::borrow<0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::search::Search>(&arg0.search));
        arg0.amounts = arg0.inputs;
        let v0 = &arg0.inputs;
        let v1 = vector[];
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(v0)) {
            0x1::vector::push_back<u64>(&mut v1, 0);
            v2 = v2 + 1;
        };
        arg0.costs = v1;
        arg0.quoted = 0;
    }

    fun check_leg<T0>(arg0: &mut Session<T0>, arg1: u64, arg2: Leg) {
        assert!(arg1 < arg0.legs, 4);
        if (arg1 == 0x1::vector::length<Leg>(&arg0.route)) {
            0x1::vector::push_back<Leg>(&mut arg0.route, arg2);
        } else {
            assert!(*0x1::vector::borrow<Leg>(&arg0.route, arg1) == arg2, 4);
        };
    }

    public fun close_loan<T0>(arg0: &mut Session<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        assert!(arg0.phase == 1 && arg0.executed == arg0.legs, 3);
        assert!(0x2::balance::value<T0>(&arg0.carry) >= arg1, 6);
        arg0.phase = 2;
        0x2::balance::split<T0>(&mut arg0.carry, arg1)
    }

    public fun close_round<T0>(arg0: &mut Session<T0>) {
        assert_searching<T0>(arg0);
        assert!(arg0.quoted == arg0.legs, 4);
        let v0 = 0x1::option::borrow_mut<0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::search::Search>(&mut arg0.search);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg0.inputs)) {
            0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::search::record(v0, *0x1::vector::borrow<u64>(&arg0.inputs, v1), *0x1::vector::borrow<u64>(&arg0.amounts, v1), *0x1::vector::borrow<u64>(&arg0.costs, v1));
            v1 = v1 + 1;
        };
        0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::search::advance(v0);
        if (!0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::search::is_finished(v0)) {
            begin_round<T0>(arg0);
            return
        };
        assert!(0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::search::qualifies(v0, arg0.min_surplus), 8);
        arg0.amount = 0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::search::best(v0);
        arg0.quoted_output = 0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::search::output(v0);
        arg0.inputs = vector[];
        arg0.amounts = vector[];
        arg0.costs = vector[];
    }

    public fun finish<T0>(arg0: Session<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.phase == 2, 3);
        let Session {
            phase         : _,
            fixed         : v1,
            legs          : v2,
            route         : _,
            search        : v4,
            inputs        : _,
            amounts       : _,
            costs         : _,
            quoted        : _,
            amount        : v9,
            quoted_output : v10,
            executed      : _,
            cost          : v12,
            carry         : v13,
            min_surplus   : v14,
            deadline_ms   : v15,
            clock_ms      : v16,
            gas_price     : v17,
            epoch         : v18,
        } = arg0;
        let v19 = v13;
        let v20 = 0x2::balance::value<T0>(&v19);
        assert!((v20 as u128) >= (v12 as u128) + (v14 as u128), 7);
        let v21 = v4;
        let v22 = if (0x1::option::is_some<0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::search::Search>(&v21)) {
            let v23 = 0x1::option::destroy_some<0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::search::Search>(v21);
            0x1::option::some<u64>(0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::search::evaluations(&v23))
        } else {
            0x1::option::destroy_none<0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::search::Search>(v21);
            0x1::option::none<u64>()
        };
        let v24 = v22;
        let v25 = if (0x1::option::is_some<u64>(&v24)) {
            0x1::option::destroy_some<u64>(v24)
        } else {
            0x1::option::destroy_none<u64>(v24);
            0
        };
        let v26 = Result<T0>{
            fixed          : v1,
            legs           : v2,
            evaluations    : v25,
            selected_input : v9,
            quoted_output  : v10,
            surplus        : v20,
            min_surplus    : v14,
            cost           : v12,
            gas_price      : v17,
            epoch          : v18,
            deadline_ms    : v15,
            clock_ms       : v16,
        };
        0x2::event::emit<Result<T0>>(v26);
        0x2::coin::from_balance<T0>(v19, arg1)
    }

    public fun keep<T0>(arg0: &mut Session<T0>, arg1: 0x2::balance::Balance<T0>) {
        assert!(arg0.phase != 0, 3);
        0x2::balance::join<T0>(&mut arg0.carry, arg1);
    }

    fun new_session<T0>(arg0: bool, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) : Session<T0> {
        let v0 = 0x2::clock::timestamp_ms(arg6);
        assert!(arg1 > 0, 1);
        assert!(0x2::tx_context::gas_price(arg7) == arg4 && 0x2::tx_context::epoch(arg7) == arg5, 2);
        assert!(v0 <= arg3 && arg3 - v0 <= 60000, 2);
        Session<T0>{
            phase         : 0,
            fixed         : arg0,
            legs          : arg1,
            route         : 0x1::vector::empty<Leg>(),
            search        : 0x1::option::none<0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::search::Search>(),
            inputs        : vector[],
            amounts       : vector[],
            costs         : vector[],
            quoted        : 0,
            amount        : 0,
            quoted_output : 0,
            executed      : 0,
            cost          : 0,
            carry         : 0x2::balance::zero<T0>(),
            min_surplus   : arg2,
            deadline_ms   : arg3,
            clock_ms      : v0,
            gas_price     : arg4,
            epoch         : arg5,
        }
    }

    public fun open_loan<T0>(arg0: &mut Session<T0>) : u64 {
        assert!(arg0.phase == 0 && arg0.amount > 0, 3);
        arg0.phase = 1;
        arg0.amount
    }

    public fun record_leg<T0>(arg0: &mut Session<T0>, arg1: 0x2::object::ID, arg2: bool, arg3: u64) {
        assert!(arg0.phase == 1, 3);
        let v0 = arg0.executed;
        let v1 = Leg{
            pool : arg1,
            a2b  : arg2,
        };
        check_leg<T0>(arg0, v0, v1);
        arg0.executed = v0 + 1;
        arg0.cost = arg0.cost + arg3;
    }

    public fun record_quote<T0>(arg0: &mut Session<T0>, arg1: 0x2::object::ID, arg2: bool, arg3: vector<u64>, arg4: vector<u64>) {
        assert_searching<T0>(arg0);
        let v0 = 0x1::vector::length<u64>(&arg0.amounts);
        assert!(0x1::vector::length<u64>(&arg3) == v0 && 0x1::vector::length<u64>(&arg4) == v0, 5);
        let v1 = arg0.quoted;
        let v2 = Leg{
            pool : arg1,
            a2b  : arg2,
        };
        check_leg<T0>(arg0, v1, v2);
        let v3 = 0;
        while (v3 < v0) {
            *0x1::vector::borrow_mut<u64>(&mut arg0.costs, v3) = *0x1::vector::borrow<u64>(&arg0.costs, v3) + *0x1::vector::borrow<u64>(&arg4, v3);
            v3 = v3 + 1;
        };
        arg0.amounts = arg3;
        arg0.quoted = v1 + 1;
    }

    public fun start_fixed<T0>(arg0: vector<u64>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) : Session<T0> {
        assert!(0x1::vector::length<u64>(&arg0) == 6, 1);
        assert!(*0x1::vector::borrow<u64>(&arg0, 0) > 0, 1);
        let v0 = new_session<T0>(true, *0x1::vector::borrow<u64>(&arg0, 5), *0x1::vector::borrow<u64>(&arg0, 1), *0x1::vector::borrow<u64>(&arg0, 2), *0x1::vector::borrow<u64>(&arg0, 3), *0x1::vector::borrow<u64>(&arg0, 4), arg1, arg2);
        v0.amount = *0x1::vector::borrow<u64>(&arg0, 0);
        v0
    }

    public fun start_search<T0>(arg0: vector<u64>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) : Session<T0> {
        assert!(0x1::vector::length<u64>(&arg0) == 9, 1);
        let v0 = new_session<T0>(false, *0x1::vector::borrow<u64>(&arg0, 8), *0x1::vector::borrow<u64>(&arg0, 4), *0x1::vector::borrow<u64>(&arg0, 5), *0x1::vector::borrow<u64>(&arg0, 6), *0x1::vector::borrow<u64>(&arg0, 7), arg1, arg2);
        0x1::option::fill<0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::search::Search>(&mut v0.search, 0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::search::new(*0x1::vector::borrow<u64>(&arg0, 1), *0x1::vector::borrow<u64>(&arg0, 2), *0x1::vector::borrow<u64>(&arg0, 0), *0x1::vector::borrow<u64>(&arg0, 3)));
        let v1 = &mut v0;
        begin_round<T0>(v1);
        v0
    }

    // decompiled from Move bytecode v7
}

