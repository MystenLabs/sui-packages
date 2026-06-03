module 0x1d6e458df23df92b3c014c372235979e88646ce14bca5eb8de4ffeaee0643fb1::n {
    struct N has key {
        id: 0x2::object::UID,
        v: u64,
    }

    public fun bump(arg0: &mut N) {
        arg0.v = arg0.v + 1;
    }

    public fun create(arg0: &mut 0x2::tx_context::TxContext) : N {
        N{
            id : 0x2::object::new(arg0),
            v  : 0,
        }
    }

    public fun destroy(arg0: N) {
        let N {
            id : v0,
            v  : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    // decompiled from Move bytecode v7
}

