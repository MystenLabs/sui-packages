module 0x2d514117b44a399869f269a003a4269d12ca9ac733ae38a2981167dbaf6881c3::cancel_cap {
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

    public(friend) fun new_cancel_cap(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : CancelCap {
        CancelCap{
            id        : 0x2::object::new(arg1),
            stream_id : arg0,
        }
    }

    // decompiled from Move bytecode v6
}

