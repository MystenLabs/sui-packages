module 0x2eebc97208cdb969f97545955f6eb400908094c85f00255ad14100d8bec12c47::vote {
    struct Vote<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        proposal_id: 0x2::object::ID,
        vote_type_id: 0x2::object::ID,
    }

    public fun balance<T0>(arg0: &Vote<T0>) : &0x2::balance::Balance<T0> {
        &arg0.balance
    }

    public fun value<T0>(arg0: &Vote<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public(friend) fun new<T0>(arg0: 0x2::balance::Balance<T0>, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : Vote<T0> {
        Vote<T0>{
            id           : 0x2::object::new(arg3),
            balance      : arg0,
            proposal_id  : arg1,
            vote_type_id : arg2,
        }
    }

    public fun destroy<T0>(arg0: Vote<T0>) : (0x2::balance::Balance<T0>, 0x2::object::ID, 0x2::object::ID) {
        let Vote {
            id           : v0,
            balance      : v1,
            proposal_id  : v2,
            vote_type_id : v3,
        } = arg0;
        0x2::object::delete(v0);
        (v1, v2, v3)
    }

    public fun mut_balance<T0>(arg0: &mut Vote<T0>) : &mut 0x2::balance::Balance<T0> {
        &mut arg0.balance
    }

    public fun proposal_id<T0>(arg0: &Vote<T0>) : 0x2::object::ID {
        arg0.proposal_id
    }

    public fun vote_type_id<T0>(arg0: &Vote<T0>) : 0x2::object::ID {
        arg0.vote_type_id
    }

    // decompiled from Move bytecode v6
}

