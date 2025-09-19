module 0xaba77bbf3c9444f74eb285276d0e8ee4ac96f06b90b0a3b31cab937465dbe875::operator_cap {
    struct OperatorCap has store, key {
        id: 0x2::object::UID,
    }

    public fun create_operator_cap(arg0: &0xaba77bbf3c9444f74eb285276d0e8ee4ac96f06b90b0a3b31cab937465dbe875::admin_cap::AdminCap, arg1: &mut 0x2::tx_context::TxContext) : OperatorCap {
        OperatorCap{id: 0x2::object::new(arg1)}
    }

    public fun destroy_operator_cap(arg0: &0xaba77bbf3c9444f74eb285276d0e8ee4ac96f06b90b0a3b31cab937465dbe875::admin_cap::AdminCap, arg1: OperatorCap) {
        let OperatorCap { id: v0 } = arg1;
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OperatorCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<OperatorCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

