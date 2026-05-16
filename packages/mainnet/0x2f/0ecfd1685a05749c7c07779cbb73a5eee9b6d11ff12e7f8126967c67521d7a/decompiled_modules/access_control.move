module 0x2f0ecfd1685a05749c7c07779cbb73a5eee9b6d11ff12e7f8126967c67521d7a::access_control {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
        form_id: 0x1::string::String,
    }

    public fun check_admin(arg0: &AdminCap, arg1: 0x1::string::String) : bool {
        arg0.form_id == arg1
    }

    public entry fun grant_admin(arg0: 0x1::string::String, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{
            id      : 0x2::object::new(arg2),
            form_id : arg0,
        };
        0x2::transfer::public_transfer<AdminCap>(v0, arg1);
    }

    public entry fun revoke_admin(arg0: AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let AdminCap {
            id      : v0,
            form_id : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public entry fun transfer_admin(arg0: AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<AdminCap>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

