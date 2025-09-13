module 0x76ed79441a5e8f2f5ce1cfa81ac9fd5be81085e9792ff5da1c0b2bd2e270af85::helper {
    struct CoinTrack {
        value: u64,
    }

    struct Tracked has copy, drop {
        init: u64,
        tracked: u64,
    }

    public fun abt() {
        abort 0
    }

    public fun begin(arg0: u64) : CoinTrack {
        CoinTrack{value: arg0}
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

