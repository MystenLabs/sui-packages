module 0x3632b7316e7c45525f51206aac0bb5e2650507b6e7eb9ca2fdea7e6534b634e4::event {
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

