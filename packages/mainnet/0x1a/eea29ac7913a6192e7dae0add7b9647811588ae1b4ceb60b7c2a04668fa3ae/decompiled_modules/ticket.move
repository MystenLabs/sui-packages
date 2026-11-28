module 0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::ticket {
    struct Ticket<phantom T0> {
        adapter: 0x1::type_name::TypeName,
        intent_id: 0x2::object::ID,
        owner: address,
        hold: u64,
        recipient: address,
        terms: vector<u8>,
    }

    public fun assert_adapter<T0, T1: drop>(arg0: &Ticket<T0>) {
        assert!(arg0.adapter == 0x1::type_name::with_defining_ids<T1>(), 1);
    }

    public fun close<T0, T1: drop>(arg0: T1, arg1: Ticket<T0>) {
        let Ticket {
            adapter   : v0,
            intent_id : _,
            owner     : _,
            hold      : _,
            recipient : _,
            terms     : _,
        } = arg1;
        assert!(v0 == 0x1::type_name::with_defining_ids<T1>(), 1);
    }

    public fun hold<T0>(arg0: &Ticket<T0>) : u64 {
        arg0.hold
    }

    public fun intent_id<T0>(arg0: &Ticket<T0>) : 0x2::object::ID {
        arg0.intent_id
    }

    public fun open<T0, T1: drop>(arg0: T1, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: address, arg5: vector<u8>) : Ticket<T0> {
        Ticket<T0>{
            adapter   : 0x1::type_name::with_defining_ids<T1>(),
            intent_id : arg1,
            owner     : arg2,
            hold      : arg3,
            recipient : arg4,
            terms     : arg5,
        }
    }

    public fun owner<T0>(arg0: &Ticket<T0>) : address {
        arg0.owner
    }

    public fun recipient<T0>(arg0: &Ticket<T0>) : address {
        arg0.recipient
    }

    public fun refund<T0, T1>(arg0: &Ticket<T0>, arg1: 0x2::coin::Coin<T1>) {
        if (0x2::coin::value<T1>(&arg1) == 0) {
            0x2::coin::destroy_zero<T1>(arg1);
        } else {
            0x2::balance::send_funds<T1>(0x2::coin::into_balance<T1>(arg1), arg0.owner);
        };
    }

    public fun terms<T0>(arg0: &Ticket<T0>) : vector<u8> {
        arg0.terms
    }

    // decompiled from Move bytecode v7
}

