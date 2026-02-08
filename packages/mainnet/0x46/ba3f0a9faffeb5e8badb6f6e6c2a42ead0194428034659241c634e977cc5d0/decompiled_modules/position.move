module 0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::position {
    struct Position has copy, drop, store {
        yes_shares: u64,
        no_shares: u64,
        yes_cost_basis: u64,
        no_cost_basis: u64,
    }

    public(friend) fun empty() : Position {
        Position{
            yes_shares     : 0,
            no_shares      : 0,
            yes_cost_basis : 0,
            no_cost_basis  : 0,
        }
    }

    public(friend) fun add_no(arg0: &mut Position, arg1: u64, arg2: u64) {
        arg0.no_shares = arg0.no_shares + arg1;
        arg0.no_cost_basis = arg0.no_cost_basis + arg2;
    }

    public(friend) fun add_yes(arg0: &mut Position, arg1: u64, arg2: u64) {
        arg0.yes_shares = arg0.yes_shares + arg1;
        arg0.yes_cost_basis = arg0.yes_cost_basis + arg2;
    }

    public(friend) fun no_cost_basis(arg0: &Position) : u64 {
        arg0.no_cost_basis
    }

    public(friend) fun no_shares(arg0: &Position) : u64 {
        arg0.no_shares
    }

    public(friend) fun remove_no(arg0: &mut Position, arg1: u64) {
        let v0 = if (arg0.no_shares > 0) {
            (((arg0.no_cost_basis as u128) * (arg1 as u128) / (arg0.no_shares as u128)) as u64)
        } else {
            0
        };
        arg0.no_shares = arg0.no_shares - arg1;
        arg0.no_cost_basis = arg0.no_cost_basis - v0;
    }

    public(friend) fun remove_yes(arg0: &mut Position, arg1: u64) {
        let v0 = if (arg0.yes_shares > 0) {
            (((arg0.yes_cost_basis as u128) * (arg1 as u128) / (arg0.yes_shares as u128)) as u64)
        } else {
            0
        };
        arg0.yes_shares = arg0.yes_shares - arg1;
        arg0.yes_cost_basis = arg0.yes_cost_basis - v0;
    }

    public(friend) fun total_shares(arg0: &Position) : u64 {
        arg0.yes_shares + arg0.no_shares
    }

    public(friend) fun yes_cost_basis(arg0: &Position) : u64 {
        arg0.yes_cost_basis
    }

    public(friend) fun yes_shares(arg0: &Position) : u64 {
        arg0.yes_shares
    }

    public(friend) fun zero(arg0: &mut Position) {
        arg0.yes_shares = 0;
        arg0.no_shares = 0;
        arg0.yes_cost_basis = 0;
        arg0.no_cost_basis = 0;
    }

    // decompiled from Move bytecode v6
}

