module 0x9c506177ca20dd4d438273d96fcaef80f388627b3bfb3803428c0e9db9de161e::event {
    struct AirdropEvent has copy, drop {
        user: address,
        amount: u64,
    }

    struct RefEvent has copy, drop {
        user: address,
        invitee: address,
        amount: u64,
    }

    struct BurnEvent has copy, drop {
        remain_amount: u64,
        burn_amount: u64,
    }

    public(friend) fun airdrop_event(arg0: address, arg1: u64) {
        let v0 = AirdropEvent{
            user   : arg0,
            amount : arg1,
        };
        0x2::event::emit<AirdropEvent>(v0);
    }

    public(friend) fun burn_event(arg0: u64, arg1: u64) {
        let v0 = BurnEvent{
            remain_amount : arg0,
            burn_amount   : arg1,
        };
        0x2::event::emit<BurnEvent>(v0);
    }

    public(friend) fun ref_event(arg0: address, arg1: address, arg2: u64) {
        let v0 = RefEvent{
            user    : arg0,
            invitee : arg1,
            amount  : arg2,
        };
        0x2::event::emit<RefEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

