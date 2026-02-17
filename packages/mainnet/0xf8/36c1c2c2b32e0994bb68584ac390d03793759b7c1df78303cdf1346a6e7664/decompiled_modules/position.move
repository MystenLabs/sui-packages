module 0xf836c1c2c2b32e0994bb68584ac390d03793759b7c1df78303cdf1346a6e7664::position {
    struct Position has drop, store {
        yes_shares: u64,
        no_shares: u64,
        yes_cost_basis: u64,
        no_cost_basis: u64,
    }

    public(friend) fun credit_shares(arg0: &mut Position, arg1: u8, arg2: u64, arg3: u64) {
        if (arg1 == 0) {
            arg0.yes_shares = arg0.yes_shares + arg2;
            arg0.yes_cost_basis = arg0.yes_cost_basis + arg3;
        } else {
            arg0.no_shares = arg0.no_shares + arg2;
            arg0.no_cost_basis = arg0.no_cost_basis + arg3;
        };
    }

    public(friend) fun debit_shares(arg0: &mut Position, arg1: u8, arg2: u64) : u64 {
        if (arg1 == 0) {
            assert!(arg0.yes_shares >= arg2, 16);
            arg0.yes_shares = arg0.yes_shares - arg2;
            arg0.yes_cost_basis = arg0.yes_cost_basis - (((arg2 as u128) * (arg0.yes_cost_basis as u128) / (arg0.yes_shares as u128)) as u64);
        } else {
            assert!(arg0.no_shares >= arg2, 16);
            arg0.no_shares = arg0.no_shares - arg2;
            arg0.no_cost_basis = arg0.no_cost_basis - (((arg2 as u128) * (arg0.no_cost_basis as u128) / (arg0.no_shares as u128)) as u64);
        };
        arg2
    }

    public(friend) fun is_empty(arg0: &Position) : bool {
        arg0.yes_shares == 0 && arg0.no_shares == 0
    }

    public(friend) fun new() : Position {
        Position{
            yes_shares     : 0,
            no_shares      : 0,
            yes_cost_basis : 0,
            no_cost_basis  : 0,
        }
    }

    public(friend) fun no_cost_basis(arg0: &Position) : u64 {
        arg0.no_cost_basis
    }

    public(friend) fun no_shares(arg0: &Position) : u64 {
        arg0.no_shares
    }

    public(friend) fun shares_for_side(arg0: &Position, arg1: u8) : u64 {
        if (arg1 == 0) {
            arg0.yes_shares
        } else {
            arg0.no_shares
        }
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

    // decompiled from Move bytecode v6
}

