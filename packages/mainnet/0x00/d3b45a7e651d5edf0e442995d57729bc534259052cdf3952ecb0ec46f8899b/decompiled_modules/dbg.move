module 0xd3b45a7e651d5edf0e442995d57729bc534259052cdf3952ecb0ec46f8899b::dbg {
    struct DBG has copy, drop {
        e: u64,
    }

    public fun ec(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = DBG{e: arg0};
        0x2::event::emit<DBG>(v0);
    }

    // decompiled from Move bytecode v6
}

