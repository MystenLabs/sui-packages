module 0xd79c3ea41fb568f0ce8a8a67041c21a83a0e6aed09caee5e8b07bfd829fe0b1b::helper {
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

    public fun destory_balance_or_transfer<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
        };
    }

    public fun destory_coin_or_transfer<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        };
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

