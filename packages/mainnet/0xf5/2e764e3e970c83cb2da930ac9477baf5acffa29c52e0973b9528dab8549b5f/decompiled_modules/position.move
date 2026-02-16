module 0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::position {
    struct Position has copy, drop, store {
        yes_amount: u64,
        no_amount: u64,
        claimed: bool,
    }

    public(friend) fun empty() : Position {
        Position{
            yes_amount : 0,
            no_amount  : 0,
            claimed    : false,
        }
    }

    public(friend) fun add_no(arg0: &mut Position, arg1: u64) {
        arg0.no_amount = arg0.no_amount + arg1;
    }

    public(friend) fun add_yes(arg0: &mut Position, arg1: u64) {
        arg0.yes_amount = arg0.yes_amount + arg1;
    }

    public(friend) fun claimed(arg0: &Position) : bool {
        arg0.claimed
    }

    public(friend) fun mark_claimed(arg0: &mut Position) {
        arg0.claimed = true;
    }

    public(friend) fun no_amount(arg0: &Position) : u64 {
        arg0.no_amount
    }

    public(friend) fun total_deposited(arg0: &Position) : u64 {
        arg0.yes_amount + arg0.no_amount
    }

    public(friend) fun yes_amount(arg0: &Position) : u64 {
        arg0.yes_amount
    }

    // decompiled from Move bytecode v6
}

