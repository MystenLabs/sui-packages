module 0xb3f692d732e131bcb8b5b81e2db0545e155afcb136cbb3d459e924c41ce4ef6a::operator_cap {
    struct OperatorCap has store, key {
        id: 0x2::object::UID,
    }

    public fun create_operator_cap(arg0: &0xb3f692d732e131bcb8b5b81e2db0545e155afcb136cbb3d459e924c41ce4ef6a::admin_cap::AdminCap, arg1: &mut 0x2::tx_context::TxContext) : OperatorCap {
        OperatorCap{id: 0x2::object::new(arg1)}
    }

    public fun destroy_operator_cap(arg0: &0xb3f692d732e131bcb8b5b81e2db0545e155afcb136cbb3d459e924c41ce4ef6a::admin_cap::AdminCap, arg1: OperatorCap) {
        let OperatorCap { id: v0 } = arg1;
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OperatorCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<OperatorCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

