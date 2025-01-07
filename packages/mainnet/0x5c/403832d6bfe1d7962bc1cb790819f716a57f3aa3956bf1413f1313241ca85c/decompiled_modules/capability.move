module 0x5c403832d6bfe1d7962bc1cb790819f716a57f3aa3956bf1413f1313241ca85c::capability {
    struct OrderOpsCap has key {
        id: 0x2::object::UID,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : OrderOpsCap {
        OrderOpsCap{id: 0x2::object::new(arg0)}
    }

    // decompiled from Move bytecode v6
}

