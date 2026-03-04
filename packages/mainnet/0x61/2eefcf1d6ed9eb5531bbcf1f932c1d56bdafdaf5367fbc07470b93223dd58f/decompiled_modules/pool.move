module 0x612eefcf1d6ed9eb5531bbcf1f932c1d56bdafdaf5367fbc07470b93223dd58f::pool {
    struct Pool<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>,
        fee_rate_bps: u64,
        owner: address,
    }

    public fun balance<T0>(arg0: &Pool<T0>) : u64 {
        0x2::balance::value<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>(&arg0.balance)
    }

    public fun create_pool<T0>(arg0: address, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : Pool<T0> {
        Pool<T0>{
            id           : 0x2::object::new(arg2),
            balance      : 0x2::balance::zero<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>(),
            fee_rate_bps : arg1,
            owner        : arg0,
        }
    }

    public fun deposit<T0>(arg0: &mut Pool<T0>, arg1: 0x2::coin::Coin<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>) {
        0x2::balance::join<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>(&mut arg0.balance, 0x2::coin::into_balance<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>(arg1));
    }

    public fun fee_rate_bps<T0>(arg0: &Pool<T0>) : u64 {
        arg0.fee_rate_bps
    }

    public fun set_fee_rate<T0>(arg0: &mut Pool<T0>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        arg0.fee_rate_bps = arg1;
    }

    public fun withdraw<T0>(arg0: &mut Pool<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN> {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        0x2::coin::from_balance<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>(0x2::balance::split<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>(&mut arg0.balance, arg1), arg2)
    }

    // decompiled from Move bytecode v6
}

