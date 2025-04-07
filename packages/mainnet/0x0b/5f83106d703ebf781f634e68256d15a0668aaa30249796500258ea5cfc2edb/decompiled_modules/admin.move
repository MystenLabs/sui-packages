module 0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::admin {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct StakeHandlerCap has store, key {
        id: 0x2::object::UID,
    }

    struct HandlerCap has store, key {
        id: 0x2::object::UID,
    }

    struct WithdrawCap has store, key {
        id: 0x2::object::UID,
    }

    public fun create_handler_cap(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) : HandlerCap {
        HandlerCap{id: 0x2::object::new(arg1)}
    }

    public fun create_stake_handler_cap(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) : StakeHandlerCap {
        StakeHandlerCap{id: 0x2::object::new(arg1)}
    }

    public fun create_withdraw_cap(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) : WithdrawCap {
        WithdrawCap{id: 0x2::object::new(arg1)}
    }

    public fun del_handler_cap(arg0: &AdminCap, arg1: HandlerCap) {
        let HandlerCap { id: v0 } = arg1;
        0x2::object::delete(v0);
    }

    public fun del_stake_handler_cap(arg0: &AdminCap, arg1: StakeHandlerCap) {
        let StakeHandlerCap { id: v0 } = arg1;
        0x2::object::delete(v0);
    }

    public fun del_withdraw_cap(arg0: &AdminCap, arg1: WithdrawCap) {
        let WithdrawCap { id: v0 } = arg1;
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

