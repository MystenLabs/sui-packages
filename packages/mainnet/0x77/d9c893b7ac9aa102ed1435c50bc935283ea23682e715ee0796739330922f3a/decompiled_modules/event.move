module 0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::event {
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

