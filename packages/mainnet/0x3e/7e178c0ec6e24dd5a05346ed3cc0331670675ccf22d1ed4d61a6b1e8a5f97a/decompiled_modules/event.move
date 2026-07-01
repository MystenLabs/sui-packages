module 0x3e7e178c0ec6e24dd5a05346ed3cc0331670675ccf22d1ed4d61a6b1e8a5f97a::event {
    struct CollectRewards has copy, drop {
        usdl_amount: u64,
    }

    struct Deposit has copy, drop {
        usdl_amount: u64,
        susdl_share: u64,
    }

    struct Burn has copy, drop {
        susdl_share: u64,
        usdl_amount: u64,
    }

    public fun burn(arg0: u64, arg1: u64) {
        let v0 = Burn{
            susdl_share : arg0,
            usdl_amount : arg1,
        };
        0x2::event::emit<Burn>(v0);
    }

    public fun collect_rewards(arg0: u64) {
        let v0 = CollectRewards{usdl_amount: arg0};
        0x2::event::emit<CollectRewards>(v0);
    }

    public fun deposit(arg0: u64, arg1: u64) {
        let v0 = Deposit{
            usdl_amount : arg0,
            susdl_share : arg1,
        };
        0x2::event::emit<Deposit>(v0);
    }

    // decompiled from Move bytecode v7
}

