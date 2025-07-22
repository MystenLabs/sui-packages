module 0x2cdccf27f67f76c0dc9579b0402e5e298f6e75c91fc72d16b771c308dd8c67cd::admin {
    struct DropkitAdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun create_admin_cap(arg0: &DropkitAdminCap, arg1: &mut 0x2::tx_context::TxContext) : DropkitAdminCap {
        DropkitAdminCap{id: 0x2::object::new(arg1)}
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DropkitAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<DropkitAdminCap>(v0, @0x68c21dbb9a72c729e3dd57afb16f5101782b568f6b3375f0c6f90a5b9e74f947);
    }

    // decompiled from Move bytecode v6
}

