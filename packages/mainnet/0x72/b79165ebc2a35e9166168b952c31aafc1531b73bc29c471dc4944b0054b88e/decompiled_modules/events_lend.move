module 0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::events_lend {
    struct LendEvent has copy, drop {
        sender: address,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct BorrowEvent has copy, drop {
        sender: address,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct RepayEvent has copy, drop {
        sender: address,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct WithdrawEvent has copy, drop {
        sender: address,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    public(friend) fun emit_borrow_event(arg0: address, arg1: 0x1::type_name::TypeName, arg2: u64) {
        let v0 = BorrowEvent{
            sender    : arg0,
            coin_type : arg1,
            amount    : arg2,
        };
        0x2::event::emit<BorrowEvent>(v0);
    }

    public(friend) fun emit_lend_event(arg0: address, arg1: 0x1::type_name::TypeName, arg2: u64) {
        let v0 = LendEvent{
            sender    : arg0,
            coin_type : arg1,
            amount    : arg2,
        };
        0x2::event::emit<LendEvent>(v0);
    }

    public(friend) fun emit_repay_event(arg0: address, arg1: 0x1::type_name::TypeName, arg2: u64) {
        let v0 = RepayEvent{
            sender    : arg0,
            coin_type : arg1,
            amount    : arg2,
        };
        0x2::event::emit<RepayEvent>(v0);
    }

    public(friend) fun emit_withdraw_event(arg0: address, arg1: 0x1::type_name::TypeName, arg2: u64) {
        let v0 = WithdrawEvent{
            sender    : arg0,
            coin_type : arg1,
            amount    : arg2,
        };
        0x2::event::emit<WithdrawEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

