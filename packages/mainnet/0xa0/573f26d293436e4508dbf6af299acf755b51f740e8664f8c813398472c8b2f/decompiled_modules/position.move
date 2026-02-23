module 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::position {
    struct Outcome has store {
        shares: u128,
        open_cost_quote: u128,
        realized_cash_in_quote: u128,
        realized_entry_cost_quote: u128,
        realized_fees_quote: u128,
    }

    struct Position<phantom T0> has key {
        id: 0x2::object::UID,
        closed: bool,
        market_id: 0x2::object::ID,
        num_trades: u64,
        outcome_count: u8,
        last_trade_ms: u64,
        cumulative_quote_in: u128,
        cumulative_quote_out: u128,
        cumulative_fees_paid: u128,
        outcomes: vector<Outcome>,
    }

    public fun transfer<T0>(arg0: Position<T0>, arg1: address) {
        assert!(derive_id(arg0.market_id, arg1) == 0x2::object::uid_to_inner(&arg0.id), 0);
        0x2::transfer::transfer<Position<T0>>(arg0, arg1);
    }

    public fun receive<T0>(arg0: &mut 0x2::object::UID, arg1: 0x2::transfer::Receiving<Position<T0>>) : Position<T0> {
        0x2::transfer::receive<Position<T0>>(arg0, arg1)
    }

    public(friend) fun apply_buy<T0>(arg0: &mut Position<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        sync<T0>(arg0, arg5);
        let v0 = 0x1::vector::borrow_mut<Outcome>(&mut arg0.outcomes, arg1);
        v0.shares = v0.shares + (arg2 as u128);
        v0.open_cost_quote = v0.open_cost_quote + (arg3 as u128);
        arg0.cumulative_fees_paid = arg0.cumulative_fees_paid + (arg4 as u128);
        arg0.cumulative_quote_in = arg0.cumulative_quote_in + (arg3 as u128);
    }

    public(friend) fun apply_redeem<T0>(arg0: &mut Position<T0>, arg1: u64, arg2: u64, arg3: u64) {
        sync<T0>(arg0, arg3);
        let v0 = close_outcome<T0>(arg0, arg1, arg2);
        arg0.cumulative_quote_out = arg0.cumulative_quote_out + (arg2 as u128);
        let v1 = 0x1::vector::borrow_mut<Outcome>(&mut arg0.outcomes, arg1);
        v1.realized_cash_in_quote = v1.realized_cash_in_quote + (arg2 as u128);
        v1.realized_entry_cost_quote = v1.realized_entry_cost_quote + v0;
    }

    public(friend) fun apply_sell<T0>(arg0: &mut Position<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        sync<T0>(arg0, arg5);
        let v0 = close_outcome<T0>(arg0, arg1, arg2);
        arg0.cumulative_fees_paid = arg0.cumulative_fees_paid + (arg4 as u128);
        arg0.cumulative_quote_out = arg0.cumulative_quote_out + (arg3 as u128);
        let v1 = 0x1::vector::borrow_mut<Outcome>(&mut arg0.outcomes, arg1);
        v1.realized_fees_quote = v1.realized_fees_quote + (arg4 as u128);
        v1.realized_entry_cost_quote = v1.realized_entry_cost_quote + v0;
        v1.realized_cash_in_quote = v1.realized_cash_in_quote + (arg3 as u128);
    }

    public(friend) fun apply_void_refund<T0>(arg0: &mut Position<T0>, arg1: u64, arg2: u64) {
        assert!(!arg0.closed, 2);
        arg0.closed = true;
        arg0.last_trade_ms = arg2;
        arg0.num_trades = arg0.num_trades + 1;
        arg0.cumulative_quote_out = arg0.cumulative_quote_out + (arg1 as u128);
        let v0 = &mut arg0.outcomes;
        let v1 = 0;
        while (v1 < 0x1::vector::length<Outcome>(v0)) {
            let v2 = 0x1::vector::borrow_mut<Outcome>(v0, v1);
            v2.shares = 0;
            v2.open_cost_quote = 0;
            v1 = v1 + 1;
        };
    }

    fun close_outcome<T0>(arg0: &mut Position<T0>, arg1: u64, arg2: u64) : u128 {
        if (arg2 == 0) {
            return 0
        };
        let v0 = 0x1::vector::borrow_mut<Outcome>(&mut arg0.outcomes, arg1);
        assert!(v0.shares >= (arg2 as u128), 1);
        let v1 = if (v0.shares == (arg2 as u128)) {
            v0.open_cost_quote
        } else {
            0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::u128::mul_div_down(v0.open_cost_quote, (arg2 as u128), v0.shares)
        };
        v0.shares = v0.shares - (arg2 as u128);
        assert!(v0.open_cost_quote >= v1, 1);
        v0.open_cost_quote = v0.open_cost_quote - v1;
        v1
    }

    public(friend) fun derive_id(arg0: 0x2::object::ID, arg1: address) : 0x2::object::ID {
        0x2::object::id_from_address(0x2::derived_object::derive_address<address>(arg0, arg1))
    }

    public fun id<T0>(arg0: &Position<T0>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public(friend) fun is_closed<T0>(arg0: &Position<T0>) : bool {
        arg0.closed
    }

    public fun market_id<T0>(arg0: &Position<T0>) : 0x2::object::ID {
        arg0.market_id
    }

    public(friend) fun net_spent_without_fees<T0>(arg0: &Position<T0>) : u64 {
        assert!(arg0.cumulative_quote_in >= arg0.cumulative_fees_paid, 2);
        let v0 = arg0.cumulative_quote_in - arg0.cumulative_fees_paid;
        assert!(v0 >= arg0.cumulative_quote_out, 2);
        let v1 = v0 - arg0.cumulative_quote_out;
        assert!(v1 == v1, 2);
        (v1 as u64)
    }

    public(friend) fun new<T0>(arg0: &mut 0x2::object::UID, arg1: address, arg2: u64) : Position<T0> {
        Position<T0>{
            id                   : 0x2::derived_object::claim<address>(arg0, arg1),
            closed               : false,
            market_id            : 0x2::object::uid_to_inner(arg0),
            num_trades           : 0,
            outcome_count        : (arg2 as u8),
            last_trade_ms        : 0,
            cumulative_quote_in  : 0,
            cumulative_quote_out : 0,
            cumulative_fees_paid : 0,
            outcomes             : zero_outcomes(arg2),
        }
    }

    public fun outcome_count<T0>(arg0: &Position<T0>) : u8 {
        arg0.outcome_count
    }

    fun sync<T0>(arg0: &mut Position<T0>, arg1: u64) {
        arg0.last_trade_ms = arg1;
        arg0.num_trades = arg0.num_trades + 1;
    }

    fun zero_outcomes(arg0: u64) : vector<Outcome> {
        let v0 = 0x1::vector::empty<Outcome>();
        let v1 = 0;
        while (v1 < arg0) {
            let v2 = Outcome{
                shares                    : 0,
                open_cost_quote           : 0,
                realized_cash_in_quote    : 0,
                realized_entry_cost_quote : 0,
                realized_fees_quote       : 0,
            };
            0x1::vector::push_back<Outcome>(&mut v0, v2);
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

