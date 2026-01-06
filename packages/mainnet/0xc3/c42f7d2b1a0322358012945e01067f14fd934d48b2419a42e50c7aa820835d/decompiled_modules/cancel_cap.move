module 0xc3c42f7d2b1a0322358012945e01067f14fd934d48b2419a42e50c7aa820835d::cancel_cap {
    struct CancelCap has store, key {
        id: 0x2::object::UID,
        stream_id: 0x2::object::ID,
    }

    public fun destroy_cancel_cap(arg0: CancelCap) {
        let CancelCap {
            id        : v0,
            stream_id : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun get_stream_id(arg0: &CancelCap) : 0x2::object::ID {
        arg0.stream_id
    }

    public fun new_cancel_cap(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : CancelCap {
        CancelCap{
            id        : 0x2::object::new(arg1),
            stream_id : arg0,
        }
    }

    // decompiled from Move bytecode v6
}

