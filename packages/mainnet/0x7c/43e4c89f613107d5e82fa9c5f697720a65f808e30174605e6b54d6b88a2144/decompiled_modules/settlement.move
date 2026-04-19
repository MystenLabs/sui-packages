module 0x7c43e4c89f613107d5e82fa9c5f697720a65f808e30174605e6b54d6b88a2144::settlement {
    public fun claim_assets<T0, T1>(arg0: &mut 0x7c43e4c89f613107d5e82fa9c5f697720a65f808e30174605e6b54d6b88a2144::oracle_driven_pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<0x7c43e4c89f613107d5e82fa9c5f697720a65f808e30174605e6b54d6b88a2144::oracle_driven_pool::BasePoolLiquidityCoin<T0, T1>>, arg2: 0x2::coin::Coin<0x7c43e4c89f613107d5e82fa9c5f697720a65f808e30174605e6b54d6b88a2144::oracle_driven_pool::QuotePoolLiquidityCoin<T0, T1>>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x7c43e4c89f613107d5e82fa9c5f697720a65f808e30174605e6b54d6b88a2144::oracle_driven_pool::assert_version<T0, T1>(arg0);
        0x7c43e4c89f613107d5e82fa9c5f697720a65f808e30174605e6b54d6b88a2144::oracle_driven_pool::claim_assets<T0, T1>(arg0, arg1, arg2, arg3)
    }

    public entry fun final_settlement<T0, T1>(arg0: &0x7c43e4c89f613107d5e82fa9c5f697720a65f808e30174605e6b54d6b88a2144::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0x7c43e4c89f613107d5e82fa9c5f697720a65f808e30174605e6b54d6b88a2144::oracle_driven_pool::Pool<T0, T1>) {
        0x7c43e4c89f613107d5e82fa9c5f697720a65f808e30174605e6b54d6b88a2144::oracle_driven_pool::assert_version<T0, T1>(arg1);
        0x7c43e4c89f613107d5e82fa9c5f697720a65f808e30174605e6b54d6b88a2144::oracle_driven_pool::final_settlement<T0, T1>(arg1);
    }

    public fun claim_base<T0, T1>(arg0: &mut 0x7c43e4c89f613107d5e82fa9c5f697720a65f808e30174605e6b54d6b88a2144::oracle_driven_pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<0x7c43e4c89f613107d5e82fa9c5f697720a65f808e30174605e6b54d6b88a2144::oracle_driven_pool::BasePoolLiquidityCoin<T0, T1>>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x7c43e4c89f613107d5e82fa9c5f697720a65f808e30174605e6b54d6b88a2144::oracle_driven_pool::assert_version<T0, T1>(arg0);
        0x7c43e4c89f613107d5e82fa9c5f697720a65f808e30174605e6b54d6b88a2144::oracle_driven_pool::claim_assets<T0, T1>(arg0, arg1, 0x2::coin::from_balance<0x7c43e4c89f613107d5e82fa9c5f697720a65f808e30174605e6b54d6b88a2144::oracle_driven_pool::QuotePoolLiquidityCoin<T0, T1>>(0x2::balance::zero<0x7c43e4c89f613107d5e82fa9c5f697720a65f808e30174605e6b54d6b88a2144::oracle_driven_pool::QuotePoolLiquidityCoin<T0, T1>>(), arg2), arg2)
    }

    public fun claim_quote<T0, T1>(arg0: &mut 0x7c43e4c89f613107d5e82fa9c5f697720a65f808e30174605e6b54d6b88a2144::oracle_driven_pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<0x7c43e4c89f613107d5e82fa9c5f697720a65f808e30174605e6b54d6b88a2144::oracle_driven_pool::QuotePoolLiquidityCoin<T0, T1>>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x7c43e4c89f613107d5e82fa9c5f697720a65f808e30174605e6b54d6b88a2144::oracle_driven_pool::assert_version<T0, T1>(arg0);
        0x7c43e4c89f613107d5e82fa9c5f697720a65f808e30174605e6b54d6b88a2144::oracle_driven_pool::claim_assets<T0, T1>(arg0, 0x2::coin::from_balance<0x7c43e4c89f613107d5e82fa9c5f697720a65f808e30174605e6b54d6b88a2144::oracle_driven_pool::BasePoolLiquidityCoin<T0, T1>>(0x2::balance::zero<0x7c43e4c89f613107d5e82fa9c5f697720a65f808e30174605e6b54d6b88a2144::oracle_driven_pool::BasePoolLiquidityCoin<T0, T1>>(), arg2), arg1, arg2)
    }

    public entry fun entry_claim_assets<T0, T1>(arg0: &mut 0x7c43e4c89f613107d5e82fa9c5f697720a65f808e30174605e6b54d6b88a2144::oracle_driven_pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<0x7c43e4c89f613107d5e82fa9c5f697720a65f808e30174605e6b54d6b88a2144::oracle_driven_pool::BasePoolLiquidityCoin<T0, T1>>, arg2: 0x2::coin::Coin<0x7c43e4c89f613107d5e82fa9c5f697720a65f808e30174605e6b54d6b88a2144::oracle_driven_pool::QuotePoolLiquidityCoin<T0, T1>>, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = claim_assets<T0, T1>(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, 0x2::tx_context::sender(arg3));
    }

    public entry fun entry_claim_base<T0, T1>(arg0: &mut 0x7c43e4c89f613107d5e82fa9c5f697720a65f808e30174605e6b54d6b88a2144::oracle_driven_pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<0x7c43e4c89f613107d5e82fa9c5f697720a65f808e30174605e6b54d6b88a2144::oracle_driven_pool::BasePoolLiquidityCoin<T0, T1>>, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = claim_base<T0, T1>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, 0x2::tx_context::sender(arg2));
    }

    public entry fun entry_claim_quote<T0, T1>(arg0: &mut 0x7c43e4c89f613107d5e82fa9c5f697720a65f808e30174605e6b54d6b88a2144::oracle_driven_pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<0x7c43e4c89f613107d5e82fa9c5f697720a65f808e30174605e6b54d6b88a2144::oracle_driven_pool::QuotePoolLiquidityCoin<T0, T1>>, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = claim_quote<T0, T1>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v7
}

