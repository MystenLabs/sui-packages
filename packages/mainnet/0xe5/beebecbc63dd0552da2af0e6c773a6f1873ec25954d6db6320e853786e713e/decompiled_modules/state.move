module 0xe5beebecbc63dd0552da2af0e6c773a6f1873ec25954d6db6320e853786e713e::state {
    struct State has store, key {
        id: 0x2::object::UID,
        campaigns: 0x2::bag::Bag,
        operators: vector<address>,
    }

    public(friend) fun new(arg0: vector<address>, arg1: &mut 0x2::tx_context::TxContext) : State {
        State{
            id        : 0x2::object::new(arg1),
            campaigns : 0x2::bag::new(arg1),
            operators : arg0,
        }
    }

    public(friend) fun add_campaign<T0, T1, T2>(arg0: &mut State, arg1: 0xe5beebecbc63dd0552da2af0e6c773a6f1873ec25954d6db6320e853786e713e::campaign::Campaign<T0, T1, T2>) {
        0x2::bag::add<0x2::object::ID, 0xe5beebecbc63dd0552da2af0e6c773a6f1873ec25954d6db6320e853786e713e::campaign::Campaign<T0, T1, T2>>(&mut arg0.campaigns, 0x2::object::id<0xe5beebecbc63dd0552da2af0e6c773a6f1873ec25954d6db6320e853786e713e::campaign::Campaign<T0, T1, T2>>(&arg1), arg1);
    }

    public(friend) fun add_operator(arg0: &mut State, arg1: address) {
        let (v0, _) = find_operator(arg0, &arg1);
        assert!(!v0, 0);
        0x1::vector::push_back<address>(&mut arg0.operators, arg1);
    }

    public fun borrow_campaign<T0, T1, T2>(arg0: &State, arg1: 0x2::object::ID) : &0xe5beebecbc63dd0552da2af0e6c773a6f1873ec25954d6db6320e853786e713e::campaign::Campaign<T0, T1, T2> {
        0x2::bag::borrow<0x2::object::ID, 0xe5beebecbc63dd0552da2af0e6c773a6f1873ec25954d6db6320e853786e713e::campaign::Campaign<T0, T1, T2>>(&arg0.campaigns, arg1)
    }

    public(friend) fun borrow_mut_campaign<T0, T1, T2>(arg0: &mut State, arg1: 0x2::object::ID) : &mut 0xe5beebecbc63dd0552da2af0e6c773a6f1873ec25954d6db6320e853786e713e::campaign::Campaign<T0, T1, T2> {
        0x2::bag::borrow_mut<0x2::object::ID, 0xe5beebecbc63dd0552da2af0e6c773a6f1873ec25954d6db6320e853786e713e::campaign::Campaign<T0, T1, T2>>(&mut arg0.campaigns, arg1)
    }

    public fun find_operator(arg0: &State, arg1: &address) : (bool, u64) {
        0x1::vector::index_of<address>(&arg0.operators, arg1)
    }

    public fun num_campaigns(arg0: &State) : u64 {
        0x2::bag::length(&arg0.campaigns)
    }

    public fun num_operators(arg0: &State) : u64 {
        0x1::vector::length<address>(&arg0.operators)
    }

    public(friend) fun remove_operator(arg0: &mut State, arg1: address) {
        let (v0, v1) = find_operator(arg0, &arg1);
        assert!(v0, 1);
        0x1::vector::remove<address>(&mut arg0.operators, v1);
    }

    // decompiled from Move bytecode v6
}

