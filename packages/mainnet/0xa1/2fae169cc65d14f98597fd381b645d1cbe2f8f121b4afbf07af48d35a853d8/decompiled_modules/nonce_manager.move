module 0xa12fae169cc65d14f98597fd381b645d1cbe2f8f121b4afbf07af48d35a853d8::nonce_manager {
    struct NonceManager has store {
        nonces: 0x2::table::Table<address, u64>,
    }

    public(friend) fun increment_nonce(arg0: &mut NonceManager, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        if (0x2::table::contains<address, u64>(&arg0.nonces, 0x2::tx_context::sender(arg2))) {
            let v0 = 0x2::table::borrow_mut<address, u64>(&mut arg0.nonces, 0x2::tx_context::sender(arg2));
            assert!(arg1 > *v0, 13906834264537694209);
            *v0 = arg1;
        } else {
            0x2::table::add<address, u64>(&mut arg0.nonces, 0x2::tx_context::sender(arg2), arg1);
        };
    }

    public(friend) fun new_nonce_manager(arg0: &mut 0x2::tx_context::TxContext) : NonceManager {
        NonceManager{nonces: 0x2::table::new<address, u64>(arg0)}
    }

    // decompiled from Move bytecode v6
}

