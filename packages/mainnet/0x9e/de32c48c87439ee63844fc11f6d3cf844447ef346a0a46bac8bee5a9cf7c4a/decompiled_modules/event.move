module 0x9ede32c48c87439ee63844fc11f6d3cf844447ef346a0a46bac8bee5a9cf7c4a::event {
    struct CollectRewards has copy, drop {
        buck_amount: u64,
    }

    struct Deposit has copy, drop {
        buck_amount: u64,
        sbuck_share: u64,
    }

    struct Burn has copy, drop {
        sbuck_share: u64,
        buck_amount: u64,
    }

    public fun burn(arg0: u64, arg1: u64) {
        let v0 = Burn{
            sbuck_share : arg0,
            buck_amount : arg1,
        };
        0x2::event::emit<Burn>(v0);
    }

    public fun collect_rewards(arg0: u64) {
        let v0 = CollectRewards{buck_amount: arg0};
        0x2::event::emit<CollectRewards>(v0);
    }

    public fun deposit(arg0: u64, arg1: u64) {
        let v0 = Deposit{
            buck_amount : arg0,
            sbuck_share : arg1,
        };
        0x2::event::emit<Deposit>(v0);
    }

    // decompiled from Move bytecode v6
}

