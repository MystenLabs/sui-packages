module 0xb2009e702e72d13d1b417488a9b49caff963ad3d25bb4f4cf4dca4bcd0e6e737::selector {
    public fun chosen_amount(arg0: &vector<u128>, arg1: &vector<bool>) : u128 {
        0xb6306a92f72f0bf98fed6e6276142ccf4548656da348130605f0e0e6e077b04b::selector::chosen<u128>(arg0, arg1)
    }

    public fun chosen_results(arg0: &vector<0xb6306a92f72f0bf98fed6e6276142ccf4548656da348130605f0e0e6e077b04b::optimizer::OptimizeResult>, arg1: &vector<bool>) : 0xb6306a92f72f0bf98fed6e6276142ccf4548656da348130605f0e0e6e077b04b::optimizer::OptimizeResult {
        0xb6306a92f72f0bf98fed6e6276142ccf4548656da348130605f0e0e6e077b04b::selector::chosen<0xb6306a92f72f0bf98fed6e6276142ccf4548656da348130605f0e0e6e077b04b::optimizer::OptimizeResult>(arg0, arg1)
    }

    public fun new() : vector<bool> {
        0xb6306a92f72f0bf98fed6e6276142ccf4548656da348130605f0e0e6e077b04b::selector::new()
    }

    public fun take_first(arg0: &mut vector<bool>, arg1: bool) : bool {
        0xb6306a92f72f0bf98fed6e6276142ccf4548656da348130605f0e0e6e077b04b::selector::take_first(arg0, arg1)
    }

    // decompiled from Move bytecode v7
}

