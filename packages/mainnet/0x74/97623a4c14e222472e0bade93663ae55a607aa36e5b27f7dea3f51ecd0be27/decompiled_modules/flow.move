module 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::flow {
    struct DepositLeg has copy, drop, store {
        token: 0x1::type_name::TypeName,
        leg_value: u64,
        expected_out: u64,
        spent: u64,
    }

    struct Trail has copy, drop, store {
        amount_paid: u64,
        fee: u64,
        share_price: u64,
        tokens: vector<0x1::type_name::TypeName>,
        given: vector<u64>,
        received: vector<u64>,
    }

    struct OpenLeg has copy, drop, store {
        kind: u8,
        token_in: 0x1::type_name::TypeName,
        token_out: 0x1::type_name::TypeName,
        amount_in: u64,
        min_out: u64,
        value: u64,
        reserve_wanted: u64,
    }

    struct Open has drop, store {
        kind: u8,
        ticket: 0x1::option::Option<0x2::object::ID>,
        denomination: 0x1::option::Option<0x1::type_name::TypeName>,
        deposit_legs: vector<DepositLeg>,
        shortfall: u64,
        leg: 0x1::option::Option<OpenLeg>,
        trail: Trail,
    }

    struct Flow has store {
        open: 0x1::option::Option<Open>,
        cycle_trades: u64,
        cycle_opened_ms: u64,
    }

    public(friend) fun assert_deposit(arg0: &Flow, arg1: 0x2::object::ID) {
        assert_ticket(arg0, 1, arg1);
    }

    public(friend) fun assert_idle(arg0: &Flow) {
        assert!(0x1::option::is_none<Open>(&arg0.open), 2000);
    }

    public(friend) fun assert_redeem(arg0: &Flow, arg1: 0x2::object::ID) {
        assert_ticket(arg0, 3, arg1);
    }

    fun assert_ticket(arg0: &Flow, arg1: u8, arg2: 0x2::object::ID) {
        assert!(0x1::option::is_some<Open>(&arg0.open), 2001);
        let v0 = 0x1::option::borrow<Open>(&arg0.open);
        assert!(v0.kind == arg1, 2001);
        assert!(v0.ticket == 0x1::option::some<0x2::object::ID>(arg2), 2001);
    }

    public(friend) fun assert_valuation(arg0: &Flow) {
        assert!(0x1::option::is_some<Open>(&arg0.open), 2001);
        assert!(0x1::option::borrow<Open>(&arg0.open).kind == 5, 2001);
    }

    public(friend) fun assert_withdraw(arg0: &Flow, arg1: 0x2::object::ID) {
        assert_ticket(arg0, 2, arg1);
    }

    public(friend) fun close_deposit(arg0: &mut Flow, arg1: 0x2::object::ID) : u64 {
        assert_ticket(arg0, 1, arg1);
        let v0 = 0x1::option::extract<Open>(&mut arg0.open);
        assert!(0x1::vector::is_empty<DepositLeg>(&v0.deposit_legs), 2004);
        v0.shortfall
    }

    public(friend) fun close_leg(arg0: &mut Flow, arg1: bool, arg2: 0x1::type_name::TypeName, arg3: 0x1::type_name::TypeName, arg4: u64, arg5: u64) : (u8, u64, u64) {
        assert!(0x1::option::is_some<Open>(&arg0.open), 2001);
        assert!(0x1::option::borrow<Open>(&arg0.open).kind == 4, 2001);
        let v0 = 0x1::option::extract<Open>(&mut arg0.open);
        let v1 = *0x1::option::borrow<OpenLeg>(&v0.leg);
        assert!(v1.kind == 1 == arg1, 2002);
        assert!(v1.token_in == arg2, 2002);
        assert!(v1.token_out == arg3, 2002);
        assert!(v1.amount_in == arg4, 2002);
        assert!(v1.min_out == arg5, 2002);
        arg0.cycle_trades = arg0.cycle_trades + 1;
        (v1.kind, v1.value, v1.reserve_wanted)
    }

    public(friend) fun close_redeem(arg0: &mut Flow, arg1: 0x2::object::ID) {
        assert_ticket(arg0, 3, arg1);
        0x1::option::extract<Open>(&mut arg0.open);
    }

    public(friend) fun close_valuation(arg0: &mut Flow) {
        assert_valuation(arg0);
        0x1::option::extract<Open>(&mut arg0.open);
    }

    public(friend) fun close_withdraw(arg0: &mut Flow, arg1: 0x2::object::ID) {
        assert_ticket(arg0, 2, arg1);
        0x1::option::extract<Open>(&mut arg0.open);
    }

    public(friend) fun cycle_opened_ms(arg0: &Flow) : u64 {
        arg0.cycle_opened_ms
    }

    public(friend) fun deposit_denomination(arg0: &Flow, arg1: 0x2::object::ID) : 0x1::type_name::TypeName {
        assert_ticket(arg0, 1, arg1);
        *0x1::option::borrow<0x1::type_name::TypeName>(&0x1::option::borrow<Open>(&arg0.open).denomination)
    }

    public(friend) fun deposit_leg_begin(arg0: &mut Flow, arg1: 0x2::object::ID, arg2: 0x1::type_name::TypeName, arg3: 0x1::type_name::TypeName, arg4: u64, arg5: u64, arg6: u64) {
        assert_ticket(arg0, 1, arg1);
        let v0 = 0x1::option::borrow_mut<Open>(&mut arg0.open);
        assert!(v0.denomination == 0x1::option::some<0x1::type_name::TypeName>(arg2), 2005);
        let v1 = 0;
        while (v1 < 0x1::vector::length<DepositLeg>(&v0.deposit_legs)) {
            assert!(0x1::vector::borrow<DepositLeg>(&v0.deposit_legs, v1).token != arg3, 2003);
            v1 = v1 + 1;
        };
        let v2 = DepositLeg{
            token        : arg3,
            leg_value    : arg4,
            expected_out : arg5,
            spent        : arg6,
        };
        0x1::vector::push_back<DepositLeg>(&mut v0.deposit_legs, v2);
    }

    public(friend) fun deposit_leg_settle(arg0: &mut Flow, arg1: 0x2::object::ID, arg2: 0x1::type_name::TypeName, arg3: u64) {
        assert_ticket(arg0, 1, arg1);
        let v0 = 0x1::option::borrow_mut<Open>(&mut arg0.open);
        let v1 = 0;
        let v2 = 0x1::vector::length<DepositLeg>(&v0.deposit_legs);
        let v3 = v2;
        while (v1 < v2) {
            if (0x1::vector::borrow<DepositLeg>(&v0.deposit_legs, v1).token == arg2) {
                v3 = v1;
                break
            };
            v1 = v1 + 1;
        };
        assert!(v3 < v2, 2003);
        let DepositLeg {
            token        : _,
            leg_value    : v5,
            expected_out : v6,
            spent        : v7,
        } = 0x1::vector::swap_remove<DepositLeg>(&mut v0.deposit_legs, v3);
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut v0.trail.tokens, arg2);
        0x1::vector::push_back<u64>(&mut v0.trail.given, v7);
        0x1::vector::push_back<u64>(&mut v0.trail.received, arg3);
        let v8 = if (v6 == 0) {
            0
        } else if (arg3 >= v6) {
            v5
        } else {
            (((v5 as u128) * (arg3 as u128) / (v6 as u128)) as u64)
        };
        v0.shortfall = v0.shortfall + v5 - v8;
    }

    fun empty_trail() : Trail {
        Trail{
            amount_paid : 0,
            fee         : 0,
            share_price : 0,
            tokens      : 0x1::vector::empty<0x1::type_name::TypeName>(),
            given       : vector[],
            received    : vector[],
        }
    }

    public(friend) fun is_idle(arg0: &Flow) : bool {
        0x1::option::is_none<Open>(&arg0.open)
    }

    public(friend) fun leg_buy() : u8 {
        1
    }

    public(friend) fun leg_exit() : u8 {
        2
    }

    public(friend) fun leg_sell() : u8 {
        0
    }

    public(friend) fun new() : Flow {
        Flow{
            open            : 0x1::option::none<Open>(),
            cycle_trades    : 0,
            cycle_opened_ms : 0,
        }
    }

    public(friend) fun note(arg0: &mut Flow, arg1: 0x1::type_name::TypeName, arg2: u64, arg3: u64) {
        let v0 = &mut 0x1::option::borrow_mut<Open>(&mut arg0.open).trail;
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut v0.tokens, arg1);
        0x1::vector::push_back<u64>(&mut v0.given, arg2);
        0x1::vector::push_back<u64>(&mut v0.received, arg3);
    }

    public(friend) fun note_cycle_opened(arg0: &mut Flow, arg1: u64) {
        arg0.cycle_opened_ms = arg1;
    }

    public(friend) fun note_deposit(arg0: &mut Flow, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = &mut 0x1::option::borrow_mut<Open>(&mut arg0.open).trail;
        v0.amount_paid = arg1;
        v0.fee = arg2;
        v0.share_price = arg3;
    }

    public(friend) fun open_deposit(arg0: &mut Flow, arg1: 0x2::object::ID, arg2: 0x1::type_name::TypeName) {
        open_ticket(arg0, 1, arg1, 0x1::option::some<0x1::type_name::TypeName>(arg2));
    }

    public(friend) fun open_leg(arg0: &mut Flow, arg1: u8, arg2: 0x1::type_name::TypeName, arg3: 0x1::type_name::TypeName, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        assert!(0x1::option::is_none<Open>(&arg0.open), 2000);
        let v0 = OpenLeg{
            kind           : arg1,
            token_in       : arg2,
            token_out      : arg3,
            amount_in      : arg4,
            min_out        : arg5,
            value          : arg6,
            reserve_wanted : arg7,
        };
        let v1 = Open{
            kind         : 4,
            ticket       : 0x1::option::none<0x2::object::ID>(),
            denomination : 0x1::option::none<0x1::type_name::TypeName>(),
            deposit_legs : 0x1::vector::empty<DepositLeg>(),
            shortfall    : 0,
            leg          : 0x1::option::some<OpenLeg>(v0),
            trail        : empty_trail(),
        };
        0x1::option::fill<Open>(&mut arg0.open, v1);
    }

    public(friend) fun open_redeem(arg0: &mut Flow, arg1: 0x2::object::ID) {
        open_ticket(arg0, 3, arg1, 0x1::option::none<0x1::type_name::TypeName>());
    }

    fun open_ticket(arg0: &mut Flow, arg1: u8, arg2: 0x2::object::ID, arg3: 0x1::option::Option<0x1::type_name::TypeName>) {
        assert!(0x1::option::is_none<Open>(&arg0.open), 2000);
        let v0 = Open{
            kind         : arg1,
            ticket       : 0x1::option::some<0x2::object::ID>(arg2),
            denomination : arg3,
            deposit_legs : 0x1::vector::empty<DepositLeg>(),
            shortfall    : 0,
            leg          : 0x1::option::none<OpenLeg>(),
            trail        : empty_trail(),
        };
        0x1::option::fill<Open>(&mut arg0.open, v0);
    }

    public(friend) fun open_valuation(arg0: &mut Flow) {
        assert!(0x1::option::is_none<Open>(&arg0.open), 2000);
        let v0 = Open{
            kind         : 5,
            ticket       : 0x1::option::none<0x2::object::ID>(),
            denomination : 0x1::option::none<0x1::type_name::TypeName>(),
            deposit_legs : 0x1::vector::empty<DepositLeg>(),
            shortfall    : 0,
            leg          : 0x1::option::none<OpenLeg>(),
            trail        : empty_trail(),
        };
        0x1::option::fill<Open>(&mut arg0.open, v0);
    }

    public(friend) fun open_withdraw(arg0: &mut Flow, arg1: 0x2::object::ID) {
        open_ticket(arg0, 2, arg1, 0x1::option::none<0x1::type_name::TypeName>());
    }

    public(friend) fun take_cycle_trades(arg0: &mut Flow) : u64 {
        arg0.cycle_trades = 0;
        arg0.cycle_trades
    }

    public(friend) fun trail(arg0: &Flow) : Trail {
        assert!(0x1::option::is_some<Open>(&arg0.open), 2001);
        0x1::option::borrow<Open>(&arg0.open).trail
    }

    public(friend) fun trail_amount_paid(arg0: &Trail) : u64 {
        arg0.amount_paid
    }

    public(friend) fun trail_fee(arg0: &Trail) : u64 {
        arg0.fee
    }

    public(friend) fun trail_given(arg0: &Trail) : vector<u64> {
        arg0.given
    }

    public(friend) fun trail_received(arg0: &Trail) : vector<u64> {
        arg0.received
    }

    public(friend) fun trail_share_price(arg0: &Trail) : u64 {
        arg0.share_price
    }

    public(friend) fun trail_tokens(arg0: &Trail) : vector<0x1::type_name::TypeName> {
        arg0.tokens
    }

    // decompiled from Move bytecode v7
}

