module 0x4edc40f8e74195d7a72c9b6a4d0d2ff87605ab43fd661d152f441c2583804ecb::balance {
    struct TransferMarker has key {
        id: 0x2::object::UID,
        amount_argument: u64,
    }

    public fun send_funds(arg0: address, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = TransferMarker{
            id              : 0x2::object::new(arg2),
            amount_argument : arg1,
        };
        0x2::transfer::transfer<TransferMarker>(v0, arg0);
    }

    // decompiled from Move bytecode v7
}

