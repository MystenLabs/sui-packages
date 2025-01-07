module 0x2c4c1704e32a741db1c9756c3d142a91759d5ce86a9989fdac786a35dc6b2a5::admin {
    struct OwnerCap<phantom T0> has key {
        id: 0x2::object::UID,
    }

    struct OperatorCap<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    public fun create_operator_cap<T0: drop>(arg0: &OwnerCap<T0>, arg1: &mut 0x2::tx_context::TxContext) : OperatorCap<T0> {
        OperatorCap<T0>{id: 0x2::object::new(arg1)}
    }

    public fun create_owner_cap<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : OwnerCap<T0> {
        OwnerCap<T0>{id: 0x2::object::new(arg1)}
    }

    public fun destroy_operator_cap<T0: drop>(arg0: OperatorCap<T0>) {
        let OperatorCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public fun destroy_owner_cap<T0: drop>(arg0: OwnerCap<T0>) {
        let OwnerCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public fun transfer_owner_cap<T0: drop>(arg0: OwnerCap<T0>, arg1: address) {
        0x2::transfer::transfer<OwnerCap<T0>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

