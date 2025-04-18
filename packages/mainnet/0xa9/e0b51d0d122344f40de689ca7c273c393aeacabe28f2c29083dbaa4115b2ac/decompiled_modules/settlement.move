module 0xa9e0b51d0d122344f40de689ca7c273c393aeacabe28f2c29083dbaa4115b2ac::settlement {
    public entry fun claim_assets<T0, T1>(arg0: &mut 0xa9e0b51d0d122344f40de689ca7c273c393aeacabe28f2c29083dbaa4115b2ac::oracle_driven_pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<0xa9e0b51d0d122344f40de689ca7c273c393aeacabe28f2c29083dbaa4115b2ac::oracle_driven_pool::BasePoolLiquidityCoin<T0, T1>>, arg2: 0x2::coin::Coin<0xa9e0b51d0d122344f40de689ca7c273c393aeacabe28f2c29083dbaa4115b2ac::oracle_driven_pool::QuotePoolLiquidityCoin<T0, T1>>, arg3: &mut 0x2::tx_context::TxContext) {
        0xa9e0b51d0d122344f40de689ca7c273c393aeacabe28f2c29083dbaa4115b2ac::oracle_driven_pool::assert_version<T0, T1>(arg0);
        0xa9e0b51d0d122344f40de689ca7c273c393aeacabe28f2c29083dbaa4115b2ac::oracle_driven_pool::claim_assets<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public entry fun final_settlement<T0, T1>(arg0: &0xa9e0b51d0d122344f40de689ca7c273c393aeacabe28f2c29083dbaa4115b2ac::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0xa9e0b51d0d122344f40de689ca7c273c393aeacabe28f2c29083dbaa4115b2ac::oracle_driven_pool::Pool<T0, T1>) {
        0xa9e0b51d0d122344f40de689ca7c273c393aeacabe28f2c29083dbaa4115b2ac::oracle_driven_pool::assert_version<T0, T1>(arg1);
        0xa9e0b51d0d122344f40de689ca7c273c393aeacabe28f2c29083dbaa4115b2ac::oracle_driven_pool::final_settlement<T0, T1>(arg1);
    }

    public entry fun claim_base<T0, T1>(arg0: &mut 0xa9e0b51d0d122344f40de689ca7c273c393aeacabe28f2c29083dbaa4115b2ac::oracle_driven_pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<0xa9e0b51d0d122344f40de689ca7c273c393aeacabe28f2c29083dbaa4115b2ac::oracle_driven_pool::BasePoolLiquidityCoin<T0, T1>>, arg2: &mut 0x2::tx_context::TxContext) {
        0xa9e0b51d0d122344f40de689ca7c273c393aeacabe28f2c29083dbaa4115b2ac::oracle_driven_pool::assert_version<T0, T1>(arg0);
        0xa9e0b51d0d122344f40de689ca7c273c393aeacabe28f2c29083dbaa4115b2ac::oracle_driven_pool::claim_assets<T0, T1>(arg0, arg1, 0x2::coin::from_balance<0xa9e0b51d0d122344f40de689ca7c273c393aeacabe28f2c29083dbaa4115b2ac::oracle_driven_pool::QuotePoolLiquidityCoin<T0, T1>>(0x2::balance::zero<0xa9e0b51d0d122344f40de689ca7c273c393aeacabe28f2c29083dbaa4115b2ac::oracle_driven_pool::QuotePoolLiquidityCoin<T0, T1>>(), arg2), arg2);
    }

    public entry fun claim_quote<T0, T1>(arg0: &mut 0xa9e0b51d0d122344f40de689ca7c273c393aeacabe28f2c29083dbaa4115b2ac::oracle_driven_pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<0xa9e0b51d0d122344f40de689ca7c273c393aeacabe28f2c29083dbaa4115b2ac::oracle_driven_pool::QuotePoolLiquidityCoin<T0, T1>>, arg2: &mut 0x2::tx_context::TxContext) {
        0xa9e0b51d0d122344f40de689ca7c273c393aeacabe28f2c29083dbaa4115b2ac::oracle_driven_pool::assert_version<T0, T1>(arg0);
        0xa9e0b51d0d122344f40de689ca7c273c393aeacabe28f2c29083dbaa4115b2ac::oracle_driven_pool::claim_assets<T0, T1>(arg0, 0x2::coin::from_balance<0xa9e0b51d0d122344f40de689ca7c273c393aeacabe28f2c29083dbaa4115b2ac::oracle_driven_pool::BasePoolLiquidityCoin<T0, T1>>(0x2::balance::zero<0xa9e0b51d0d122344f40de689ca7c273c393aeacabe28f2c29083dbaa4115b2ac::oracle_driven_pool::BasePoolLiquidityCoin<T0, T1>>(), arg2), arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

