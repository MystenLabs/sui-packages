module 0xc30d5610a99d09d47aa926ee1f647859771233c6c754b418bdbc168386b1f456::admin {
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

