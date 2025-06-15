module 0x2560e4e75a3dd4bdbd4841bbb25197fb3695b59c8ee4aa9dfef14a0d02cbef24::dex_turbos {
    struct TurbosSwapExecuted has copy, drop {
        pool: address,
        amount_in: u64,
        amount_out: u64,
        a2b: bool,
    }

    public fun swap<T0, T1>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 602);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg5));
        let v1 = TurbosSwapExecuted{
            pool       : arg0,
            amount_in  : v0,
            amount_out : 0,
            a2b        : arg4,
        };
        0x2::event::emit<TurbosSwapExecuted>(v1);
        0x2::coin::from_balance<T1>(0x2::balance::zero<T1>(), arg5)
    }

    public fun get_package() : address {
        @0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1
    }

    public fun get_sui_usdt_pool() : address {
        @0x5eb2dfcdd1b15d2021328258f6d5ec081e9a0cdcfa9e13a0eaeb9b5f7505ca78
    }

    // decompiled from Move bytecode v6
}

