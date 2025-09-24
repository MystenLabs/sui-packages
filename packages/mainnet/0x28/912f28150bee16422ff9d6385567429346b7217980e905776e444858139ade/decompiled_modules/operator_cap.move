module 0x28912f28150bee16422ff9d6385567429346b7217980e905776e444858139ade::operator_cap {
    struct OperatorCap has store, key {
        id: 0x2::object::UID,
    }

    public fun create_operator_cap(arg0: &0x28912f28150bee16422ff9d6385567429346b7217980e905776e444858139ade::admin_cap::AdminCap, arg1: &mut 0x2::tx_context::TxContext) : OperatorCap {
        OperatorCap{id: 0x2::object::new(arg1)}
    }

    public fun destroy_operator_cap(arg0: &0x28912f28150bee16422ff9d6385567429346b7217980e905776e444858139ade::admin_cap::AdminCap, arg1: OperatorCap) {
        let OperatorCap { id: v0 } = arg1;
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OperatorCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<OperatorCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

