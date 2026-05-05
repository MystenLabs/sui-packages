module 0xcda87e2d3c710b92ef0cdf529eea933e03b9dd5af0508768eb1c43a2da0763c2::admin {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct OperatorCap has store, key {
        id: 0x2::object::UID,
    }

    public fun grant_operator_cap(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) : OperatorCap {
        OperatorCap{id: 0x2::object::new(arg1)}
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun revoke_operator_cap(arg0: &AdminCap, arg1: OperatorCap) {
        let OperatorCap { id: v0 } = arg1;
        0x2::object::delete(v0);
    }

    // decompiled from Move bytecode v6
}

