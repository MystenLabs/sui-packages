module 0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::router {
    public fun begin_direct<T0>(arg0: &0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::config::Config, arg1: 0x2::coin::Coin<T0>, arg2: u64) : 0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::plan::Plan<T0> {
        0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::config::assert_operational(arg0);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 <= 0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::config::max_principal(arg0), 1);
        assert!(arg2 >= 0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::config::min_profit_floor(arg0), 2);
        0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::plan::new_direct<T0>(0x2::coin::into_balance<T0>(arg1), v0 + arg2, v0)
    }

    public fun begin_with_coin<T0>(arg0: &0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::config::Config, arg1: 0x2::coin::Coin<T0>, arg2: u64) : 0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::plan::Plan<T0> {
        start<T0>(arg0, 0x2::coin::into_balance<T0>(arg1), 0x2::coin::value<T0>(&arg1), arg2)
    }

    public fun begin_with_coin_sized<T0>(arg0: &0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::config::Config, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64) : 0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::plan::Plan<T0> {
        start_sized<T0>(arg0, 0x2::coin::into_balance<T0>(arg1), 0x2::coin::value<T0>(&arg1), arg2, arg3)
    }

    public fun probe<T0>(arg0: 0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::plan::Plan<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::plan::abandon<T0>(arg0), arg1)
    }

    public fun settle<T0>(arg0: 0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::plan::Plan<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::plan::finish<T0>(arg0), arg1)
    }

    public fun settle_to_sender<T0>(arg0: 0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::plan::Plan<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = settle<T0>(arg0, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun start<T0>(arg0: &0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::config::Config, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: u64) : 0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::plan::Plan<T0> {
        start_sized<T0>(arg0, arg1, arg2, arg3, 0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::config::max_grid_size(arg0))
    }

    public(friend) fun start_sized<T0>(arg0: &0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::config::Config, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: u64, arg4: u64) : 0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::plan::Plan<T0> {
        0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::config::assert_operational(arg0);
        let v0 = 0x2::balance::value<T0>(&arg1);
        assert!(v0 <= 0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::config::max_principal(arg0), 1);
        assert!(arg3 >= 0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::config::min_profit_floor(arg0), 2);
        assert!(arg4 > 0 && arg4 <= 0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::config::max_grid_size(arg0), 3);
        0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::plan::new<T0>(arg1, arg2 + arg3, 0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::grid::geometric(v0, arg4))
    }

    public fun sweep<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
            return
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

