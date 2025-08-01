module 0xc7bc15f4702e48239b877a50e789a86699a679c91a74a7bac667a3ae0aa43d87::settlement {
    public fun claim_assets<T0, T1>(arg0: &mut 0xc7bc15f4702e48239b877a50e789a86699a679c91a74a7bac667a3ae0aa43d87::oracle_driven_pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<0xc7bc15f4702e48239b877a50e789a86699a679c91a74a7bac667a3ae0aa43d87::oracle_driven_pool::BasePoolLiquidityCoin<T0, T1>>, arg2: 0x2::coin::Coin<0xc7bc15f4702e48239b877a50e789a86699a679c91a74a7bac667a3ae0aa43d87::oracle_driven_pool::QuotePoolLiquidityCoin<T0, T1>>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0xc7bc15f4702e48239b877a50e789a86699a679c91a74a7bac667a3ae0aa43d87::oracle_driven_pool::assert_version<T0, T1>(arg0);
        0xc7bc15f4702e48239b877a50e789a86699a679c91a74a7bac667a3ae0aa43d87::oracle_driven_pool::claim_assets<T0, T1>(arg0, arg1, arg2, arg3)
    }

    public entry fun final_settlement<T0, T1>(arg0: &0xc7bc15f4702e48239b877a50e789a86699a679c91a74a7bac667a3ae0aa43d87::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0xc7bc15f4702e48239b877a50e789a86699a679c91a74a7bac667a3ae0aa43d87::oracle_driven_pool::Pool<T0, T1>) {
        0xc7bc15f4702e48239b877a50e789a86699a679c91a74a7bac667a3ae0aa43d87::oracle_driven_pool::assert_version<T0, T1>(arg1);
        0xc7bc15f4702e48239b877a50e789a86699a679c91a74a7bac667a3ae0aa43d87::oracle_driven_pool::final_settlement<T0, T1>(arg1);
    }

    public fun claim_base<T0, T1>(arg0: &mut 0xc7bc15f4702e48239b877a50e789a86699a679c91a74a7bac667a3ae0aa43d87::oracle_driven_pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<0xc7bc15f4702e48239b877a50e789a86699a679c91a74a7bac667a3ae0aa43d87::oracle_driven_pool::BasePoolLiquidityCoin<T0, T1>>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0xc7bc15f4702e48239b877a50e789a86699a679c91a74a7bac667a3ae0aa43d87::oracle_driven_pool::assert_version<T0, T1>(arg0);
        0xc7bc15f4702e48239b877a50e789a86699a679c91a74a7bac667a3ae0aa43d87::oracle_driven_pool::claim_assets<T0, T1>(arg0, arg1, 0x2::coin::from_balance<0xc7bc15f4702e48239b877a50e789a86699a679c91a74a7bac667a3ae0aa43d87::oracle_driven_pool::QuotePoolLiquidityCoin<T0, T1>>(0x2::balance::zero<0xc7bc15f4702e48239b877a50e789a86699a679c91a74a7bac667a3ae0aa43d87::oracle_driven_pool::QuotePoolLiquidityCoin<T0, T1>>(), arg2), arg2)
    }

    public fun claim_quote<T0, T1>(arg0: &mut 0xc7bc15f4702e48239b877a50e789a86699a679c91a74a7bac667a3ae0aa43d87::oracle_driven_pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<0xc7bc15f4702e48239b877a50e789a86699a679c91a74a7bac667a3ae0aa43d87::oracle_driven_pool::QuotePoolLiquidityCoin<T0, T1>>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0xc7bc15f4702e48239b877a50e789a86699a679c91a74a7bac667a3ae0aa43d87::oracle_driven_pool::assert_version<T0, T1>(arg0);
        0xc7bc15f4702e48239b877a50e789a86699a679c91a74a7bac667a3ae0aa43d87::oracle_driven_pool::claim_assets<T0, T1>(arg0, 0x2::coin::from_balance<0xc7bc15f4702e48239b877a50e789a86699a679c91a74a7bac667a3ae0aa43d87::oracle_driven_pool::BasePoolLiquidityCoin<T0, T1>>(0x2::balance::zero<0xc7bc15f4702e48239b877a50e789a86699a679c91a74a7bac667a3ae0aa43d87::oracle_driven_pool::BasePoolLiquidityCoin<T0, T1>>(), arg2), arg1, arg2)
    }

    public entry fun entry_claim_assets<T0, T1>(arg0: &mut 0xc7bc15f4702e48239b877a50e789a86699a679c91a74a7bac667a3ae0aa43d87::oracle_driven_pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<0xc7bc15f4702e48239b877a50e789a86699a679c91a74a7bac667a3ae0aa43d87::oracle_driven_pool::BasePoolLiquidityCoin<T0, T1>>, arg2: 0x2::coin::Coin<0xc7bc15f4702e48239b877a50e789a86699a679c91a74a7bac667a3ae0aa43d87::oracle_driven_pool::QuotePoolLiquidityCoin<T0, T1>>, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = claim_assets<T0, T1>(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, 0x2::tx_context::sender(arg3));
    }

    public entry fun entry_claim_base<T0, T1>(arg0: &mut 0xc7bc15f4702e48239b877a50e789a86699a679c91a74a7bac667a3ae0aa43d87::oracle_driven_pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<0xc7bc15f4702e48239b877a50e789a86699a679c91a74a7bac667a3ae0aa43d87::oracle_driven_pool::BasePoolLiquidityCoin<T0, T1>>, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = claim_base<T0, T1>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, 0x2::tx_context::sender(arg2));
    }

    public entry fun entry_claim_quote<T0, T1>(arg0: &mut 0xc7bc15f4702e48239b877a50e789a86699a679c91a74a7bac667a3ae0aa43d87::oracle_driven_pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<0xc7bc15f4702e48239b877a50e789a86699a679c91a74a7bac667a3ae0aa43d87::oracle_driven_pool::QuotePoolLiquidityCoin<T0, T1>>, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = claim_quote<T0, T1>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

