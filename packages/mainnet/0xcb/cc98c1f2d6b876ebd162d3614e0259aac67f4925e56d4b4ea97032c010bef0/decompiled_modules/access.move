module 0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access {
    struct AdminCap<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    struct MinterCap<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    struct BurnerCap<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    public fun issue_burner<T0>(arg0: &AdminCap<T0>, arg1: &mut 0x2::tx_context::TxContext) : BurnerCap<T0> {
        BurnerCap<T0>{id: 0x2::object::new(arg1)}
    }

    public fun issue_minter<T0>(arg0: &AdminCap<T0>, arg1: &mut 0x2::tx_context::TxContext) : MinterCap<T0> {
        MinterCap<T0>{id: 0x2::object::new(arg1)}
    }

    public fun new_admin<T0>(arg0: &T0, arg1: &mut 0x2::tx_context::TxContext) : AdminCap<T0> {
        AdminCap<T0>{id: 0x2::object::new(arg1)}
    }

    public fun revoke_burner<T0>(arg0: BurnerCap<T0>) {
        let BurnerCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public fun revoke_minter<T0>(arg0: MinterCap<T0>) {
        let MinterCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    // decompiled from Move bytecode v7
}

