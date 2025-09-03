module 0x2eb946cf7336809f96c6ca8e188295bd8d2a619fa6d2ec42c002edde4c828728::helper {
    struct CoinTrack {
        value: u64,
    }

    struct Tracked has copy, drop {
        init: u64,
        tracked: u64,
    }

    public fun begin_balance<T0>(arg0: &0x2::balance::Balance<T0>) : CoinTrack {
        CoinTrack{value: 0x2::balance::value<T0>(arg0)}
    }

    public fun begin_coin<T0>(arg0: &0x2::coin::Coin<T0>) : CoinTrack {
        CoinTrack{value: 0x2::coin::value<T0>(arg0)}
    }

    public fun end_balance<T0>(arg0: CoinTrack, arg1: &0x2::balance::Balance<T0>) {
        let v0 = 0x2::balance::value<T0>(arg1);
        let CoinTrack { value: v1 } = arg0;
        assert!(v0 >= v1, v1 - v0);
        let v2 = Tracked{
            init    : v0,
            tracked : v1,
        };
        0x2::event::emit<Tracked>(v2);
    }

    public fun end_coin<T0>(arg0: CoinTrack, arg1: &0x2::coin::Coin<T0>) {
        let v0 = 0x2::coin::value<T0>(arg1);
        let CoinTrack { value: v1 } = arg0;
        assert!(v0 >= v1, v1 - v0);
        let v2 = Tracked{
            init    : v0,
            tracked : v1,
        };
        0x2::event::emit<Tracked>(v2);
    }

    // decompiled from Move bytecode v6
}

