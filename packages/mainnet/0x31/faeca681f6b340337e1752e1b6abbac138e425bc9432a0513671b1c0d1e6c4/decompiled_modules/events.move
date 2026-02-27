module 0x31faeca681f6b340337e1752e1b6abbac138e425bc9432a0513671b1c0d1e6c4::events {
    struct ArbExecuted has copy, drop {
        strategy: vector<u8>,
        amount_in: u64,
        profit: u64,
    }

    public(friend) fun emit_arb_executed(arg0: vector<u8>, arg1: u64, arg2: u64) {
        let v0 = if (arg2 >= arg1) {
            arg2 - arg1
        } else {
            0
        };
        let v1 = ArbExecuted{
            strategy  : arg0,
            amount_in : arg1,
            profit    : v0,
        };
        0x2::event::emit<ArbExecuted>(v1);
    }

    // decompiled from Move bytecode v6
}

