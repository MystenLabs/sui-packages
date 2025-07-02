module 0x3b60f11856b5faed2fd78f000846d974e860b6794b30a54282fc742b415fb1d::nonce_manager {
    struct NonceManager has store {
        nonces: 0x2::table::Table<address, u64>,
    }

    public(friend) fun increment_nonce(arg0: &mut NonceManager, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        if (0x2::table::contains<address, u64>(&arg0.nonces, 0x2::tx_context::sender(arg2))) {
            let v0 = 0x2::table::borrow_mut<address, u64>(&mut arg0.nonces, 0x2::tx_context::sender(arg2));
            assert!(arg1 > *v0, 0x3b60f11856b5faed2fd78f000846d974e860b6794b30a54282fc742b415fb1d::errors::err_invalid_nonce());
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

