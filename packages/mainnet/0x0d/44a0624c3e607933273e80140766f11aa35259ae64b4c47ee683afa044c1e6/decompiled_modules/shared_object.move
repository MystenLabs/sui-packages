module 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::shared_object {
    struct SharedObjectRef has copy, drop, store {
        id: 0x2::object::ID,
        ref_mut: bool,
    }

    public fun shared_object_id(arg0: &SharedObjectRef) : 0x2::object::ID {
        arg0.id
    }

    public fun shared_object_ref_imm(arg0: 0x2::object::ID) : SharedObjectRef {
        SharedObjectRef{
            id      : arg0,
            ref_mut : false,
        }
    }

    public fun shared_object_ref_mut(arg0: 0x2::object::ID) : SharedObjectRef {
        SharedObjectRef{
            id      : arg0,
            ref_mut : true,
        }
    }

    public fun shared_object_ref_mutable(arg0: &SharedObjectRef) : bool {
        arg0.ref_mut
    }

    // decompiled from Move bytecode v7
}

