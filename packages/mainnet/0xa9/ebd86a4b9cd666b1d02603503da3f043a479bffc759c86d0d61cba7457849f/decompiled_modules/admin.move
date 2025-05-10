module 0x862810efecf0296db2e9df3e075a7af8034ba374e73ff1098e88cc4bb7c15437::admin {
    struct CitizenCap has store, key {
        id: 0x2::object::UID,
    }

    public fun destroy_admin_cap(arg0: CitizenCap) {
        let CitizenCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CitizenCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<CitizenCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun mint(arg0: &CitizenCap, arg1: &mut 0x2::tx_context::TxContext) : CitizenCap {
        CitizenCap{id: 0x2::object::new(arg1)}
    }

    // decompiled from Move bytecode v6
}

