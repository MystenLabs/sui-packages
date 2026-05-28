module 0x71db9b6589be7de8fcd8d2a983b93051c2b755f5a88be2e5474f2abe9a77f381::spoof_events {
    struct Transfer has copy, drop {
        from: address,
        to: address,
        amount: u64,
    }

    public entry fun emit_fake_transfer(arg0: address, arg1: address, arg2: u64) {
        let v0 = Transfer{
            from   : arg0,
            to     : arg1,
            amount : arg2,
        };
        0x2::event::emit<Transfer>(v0);
    }

    // decompiled from Move bytecode v7
}

