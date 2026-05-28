module 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::events {
    struct FundsSent<phantom T0> has copy, drop {
        sender: address,
        recipient: address,
        amount: u64,
    }

    struct FundsClawback<phantom T0> has copy, drop {
        owner: address,
        amount: u64,
    }

    struct FundsUnlocked<phantom T0> has copy, drop {
        owner: address,
        amount: u64,
    }

    public(friend) fun emit_funds_clawback<T0>(arg0: address, arg1: u64) {
        let v0 = FundsClawback<T0>{
            owner  : arg0,
            amount : arg1,
        };
        0x2::event::emit<FundsClawback<T0>>(v0);
    }

    public(friend) fun emit_funds_sent<T0>(arg0: address, arg1: address, arg2: u64) {
        let v0 = FundsSent<T0>{
            sender    : arg0,
            recipient : arg1,
            amount    : arg2,
        };
        0x2::event::emit<FundsSent<T0>>(v0);
    }

    public(friend) fun emit_funds_unlocked<T0>(arg0: address, arg1: u64) {
        let v0 = FundsUnlocked<T0>{
            owner  : arg0,
            amount : arg1,
        };
        0x2::event::emit<FundsUnlocked<T0>>(v0);
    }

    // decompiled from Move bytecode v7
}

