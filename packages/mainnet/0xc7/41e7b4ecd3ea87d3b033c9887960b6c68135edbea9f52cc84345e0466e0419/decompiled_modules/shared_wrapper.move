module 0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::shared_wrapper {
    struct SharedWrapper<T0> has key {
        id: 0x2::object::UID,
        obj: T0,
    }

    public(friend) fun obj_mut_ref<T0>(arg0: &mut SharedWrapper<T0>) : &mut T0 {
        &mut arg0.obj
    }

    public(friend) fun obj_ref<T0>(arg0: &SharedWrapper<T0>) : &T0 {
        &arg0.obj
    }

    public(friend) fun wrap_and_share<T0: store + key>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = SharedWrapper<T0>{
            id  : 0x2::object::new(arg1),
            obj : arg0,
        };
        0x2::transfer::share_object<SharedWrapper<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

