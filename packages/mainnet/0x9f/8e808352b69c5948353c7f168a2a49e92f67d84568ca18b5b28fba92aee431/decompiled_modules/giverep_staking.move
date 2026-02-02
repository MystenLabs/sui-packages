module 0x9f8e808352b69c5948353c7f168a2a49e92f67d84568ca18b5b28fba92aee431::giverep_staking {
    struct StakedCoin<phantom T0> has key {
        id: 0x2::object::UID,
        coin: 0x2::coin::Coin<T0>,
    }

    public fun coin<T0>(arg0: &StakedCoin<T0>) : &0x2::coin::Coin<T0> {
        &arg0.coin
    }

    public fun value<T0>(arg0: &StakedCoin<T0>) : u64 {
        0x2::coin::value<T0>(&arg0.coin)
    }

    public fun stake<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = StakedCoin<T0>{
            id   : 0x2::object::new(arg1),
            coin : arg0,
        };
        0x2::transfer::transfer<StakedCoin<T0>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun unstake<T0>(arg0: StakedCoin<T0>) : 0x2::coin::Coin<T0> {
        let StakedCoin {
            id   : v0,
            coin : v1,
        } = arg0;
        0x2::object::delete(v0);
        v1
    }

    // decompiled from Move bytecode v6
}

