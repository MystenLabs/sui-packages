module 0xc385a6b2989786403d9f8a303b645ca7d1de2199035e4f892b917db3fe4cdc43::task {
    struct CheckInEvent has copy, drop {
        user_id: u64,
        sender: address,
    }

    public entry fun check_in(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 != 0, 1);
        let v0 = CheckInEvent{
            user_id : arg0,
            sender  : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<CheckInEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

