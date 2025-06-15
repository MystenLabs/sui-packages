module 0x2560e4e75a3dd4bdbd4841bbb25197fb3695b59c8ee4aa9dfef14a0d02cbef24::dex_deepbook {
    struct DeepBookSwapExecuted has copy, drop {
        pool: address,
        amount_in: u64,
        amount_out: u64,
        is_bid: bool,
    }

    public fun swap<T0, T1>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 702);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg3));
        let v1 = DeepBookSwapExecuted{
            pool       : arg0,
            amount_in  : v0,
            amount_out : 0,
            is_bid     : true,
        };
        0x2::event::emit<DeepBookSwapExecuted>(v1);
        0x2::coin::from_balance<T1>(0x2::balance::zero<T1>(), arg3)
    }

    public fun get_package() : address {
        @0xdee9
    }

    public fun get_sui_usdt_pool() : address {
        @0x4405b50d791fd3346754e8171aaab6bc2ed26c2c46efdd033c14b30ae507ac33
    }

    public fun place_market_order<T0, T1>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: bool, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 702);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg5));
        let v1 = DeepBookSwapExecuted{
            pool       : arg0,
            amount_in  : v0,
            amount_out : 0,
            is_bid     : arg2,
        };
        0x2::event::emit<DeepBookSwapExecuted>(v1);
        0x2::coin::from_balance<T1>(0x2::balance::zero<T1>(), arg5)
    }

    // decompiled from Move bytecode v6
}

