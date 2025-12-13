module 0xcdd5f8d9382db835220772cc7213b4cec7f3edcc3a712271709cb9299b9857c::admin {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public fun create_and_transfer(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

