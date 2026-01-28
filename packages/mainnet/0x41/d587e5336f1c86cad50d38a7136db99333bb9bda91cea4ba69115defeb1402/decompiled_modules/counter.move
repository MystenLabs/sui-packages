module 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::counter {
    struct Counter has copy, drop, store {
        duration_ms: u64,
        sequence_number: u64,
        minted: u64,
        redeemed: u64,
    }

    public(friend) fun add_mint(arg0: &mut Counter, arg1: u64) {
        arg0.minted = arg0.minted + arg1;
    }

    public(friend) fun add_redeem(arg0: &mut Counter, arg1: u64) {
        arg0.redeemed = arg0.redeemed + arg1;
    }

    fun current_sequence_number(arg0: &Counter, arg1: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg1) / arg0.duration_ms
    }

    public fun default() : Counter {
        Counter{
            duration_ms     : 0,
            sequence_number : 0,
            minted          : 0,
            redeemed        : 0,
        }
    }

    public(friend) fun duration_ms(arg0: &Counter) : u64 {
        arg0.duration_ms
    }

    public(friend) fun minted(arg0: &Counter) : u64 {
        arg0.minted
    }

    public(friend) fun redeemed(arg0: &Counter) : u64 {
        arg0.redeemed
    }

    public(friend) fun rollover_if_needed(arg0: &mut Counter, arg1: &0x2::clock::Clock, arg2: u64) {
        let v0 = arg0.duration_ms != arg2;
        if (v0) {
            arg0.duration_ms = arg2;
        };
        let v1 = current_sequence_number(arg0, arg1);
        if (v1 != arg0.sequence_number || v0) {
            arg0.sequence_number = v1;
            arg0.minted = 0;
            arg0.redeemed = 0;
        };
    }

    public(friend) fun sequence_number(arg0: &Counter) : u64 {
        arg0.sequence_number
    }

    // decompiled from Move bytecode v6
}

