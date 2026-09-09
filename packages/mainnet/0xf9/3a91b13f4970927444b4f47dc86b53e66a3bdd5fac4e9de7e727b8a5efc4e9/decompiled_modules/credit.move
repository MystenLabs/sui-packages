module 0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::credit {
    struct CreditDeposited has copy, drop {
        account: address,
        amount: u64,
        balance: u64,
    }

    struct CreditWithdrawn has copy, drop {
        account: address,
        amount: u64,
        balance: u64,
    }

    public(friend) fun deposit_balance(arg0: &mut 0x2::table::Table<address, u64>, arg1: address, arg2: u64) {
        if (!0x2::table::contains<address, u64>(arg0, arg1)) {
            0x2::table::add<address, u64>(arg0, arg1, 0);
        };
        let v0 = 0x2::table::borrow_mut<address, u64>(arg0, arg1);
        *v0 = *v0 + arg2;
        let v1 = CreditDeposited{
            account : arg1,
            amount  : arg2,
            balance : *v0,
        };
        0x2::event::emit<CreditDeposited>(v1);
    }

    public(friend) fun withdraw_balance(arg0: &mut 0x2::table::Table<address, u64>, arg1: address, arg2: u64) {
        assert!(0x2::table::contains<address, u64>(arg0, arg1), 1);
        let v0 = 0x2::table::borrow_mut<address, u64>(arg0, arg1);
        assert!(*v0 >= arg2, 1);
        *v0 = *v0 - arg2;
        let v1 = CreditWithdrawn{
            account : arg1,
            amount  : arg2,
            balance : *v0,
        };
        0x2::event::emit<CreditWithdrawn>(v1);
    }

    // decompiled from Move bytecode v7
}

