module 0x612eefcf1d6ed9eb5531bbcf1f932c1d56bdafdaf5367fbc07470b93223dd58f::free_token {
    struct FREE has drop {
        dummy_field: bool,
    }

    struct ExchangePool has key {
        id: 0x2::object::UID,
        rps_reserve: 0x2::balance::Balance<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>,
        ft_reserve: 0x2::balance::Balance<FREE>,
        exchange_rate: u64,
    }

    public fun add_rps(arg0: &mut ExchangePool, arg1: 0x2::coin::Coin<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>) {
        0x2::balance::join<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>(&mut arg0.rps_reserve, 0x2::coin::into_balance<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>(arg1));
    }

    public fun create_exchange_pool(arg0: 0x2::coin::Coin<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : ExchangePool {
        ExchangePool{
            id            : 0x2::object::new(arg2),
            rps_reserve   : 0x2::coin::into_balance<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>(arg0),
            ft_reserve    : 0x2::balance::zero<FREE>(),
            exchange_rate : arg1,
        }
    }

    public fun exchange(arg0: &mut ExchangePool, arg1: 0x2::coin::Coin<FREE>, arg2: &mut 0x2::coin::TreasuryCap<FREE>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN> {
        let v0 = 0x2::coin::value<FREE>(&arg1) * arg0.exchange_rate;
        assert!(0x2::balance::value<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>(&arg0.rps_reserve) >= v0, 0);
        0x2::coin::burn<FREE>(arg2, arg1);
        0x2::coin::from_balance<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>(0x2::balance::split<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>(&mut arg0.rps_reserve, v0), arg3)
    }

    public fun mint_ft(arg0: &mut 0x2::coin::TreasuryCap<FREE>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<FREE> {
        0x2::coin::mint<FREE>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

