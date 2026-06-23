module 0xbf20b98512702dbfa82f491262768fc5947edeec279e8a16ddffe2dc6e60881a::spoof_events {
    struct Transfer has copy, drop {
        from: address,
        to: address,
        amount: u64,
    }

    struct EvmTransfer has copy, drop {
        from: address,
        to: address,
        value: u64,
    }

    public entry fun emit_evm_transfer(arg0: address, arg1: address, arg2: u64) {
        let v0 = EvmTransfer{
            from  : arg0,
            to    : arg1,
            value : arg2,
        };
        0x2::event::emit<EvmTransfer>(v0);
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

