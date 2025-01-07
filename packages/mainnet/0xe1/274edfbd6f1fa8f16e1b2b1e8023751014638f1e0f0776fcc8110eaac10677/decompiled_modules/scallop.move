module 0xe1274edfbd6f1fa8f16e1b2b1e8023751014638f1e0f0776fcc8110eaac10677::scallop {
    struct ScallopSpoolAccountKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    public(friend) fun borrow_spool_account<T0>(arg0: &0xe1274edfbd6f1fa8f16e1b2b1e8023751014638f1e0f0776fcc8110eaac10677::vault::Vault) : &0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::SpoolAccount<T0> {
        let v0 = ScallopSpoolAccountKey<T0>{dummy_field: false};
        0xe1274edfbd6f1fa8f16e1b2b1e8023751014638f1e0f0776fcc8110eaac10677::vault::borrow_object<ScallopSpoolAccountKey<T0>, 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::SpoolAccount<T0>>(arg0, v0)
    }

    public(friend) fun mint_market<T0>(arg0: &mut 0xe1274edfbd6f1fa8f16e1b2b1e8023751014638f1e0f0776fcc8110eaac10677::vault::Vault, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<T0>(arg1, arg2, 0x2::coin::from_balance<T0>(0xe1274edfbd6f1fa8f16e1b2b1e8023751014638f1e0f0776fcc8110eaac10677::vault::take_balance<T0>(arg0, arg3), arg5), arg4, arg5);
        0xe1274edfbd6f1fa8f16e1b2b1e8023751014638f1e0f0776fcc8110eaac10677::vault::put_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(arg0, 0x2::coin::into_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(v0), arg5);
        0x2::coin::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&v0)
    }

    fun put_spool_account<T0>(arg0: &mut 0xe1274edfbd6f1fa8f16e1b2b1e8023751014638f1e0f0776fcc8110eaac10677::vault::Vault, arg1: 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::SpoolAccount<T0>) {
        let v0 = ScallopSpoolAccountKey<T0>{dummy_field: false};
        0xe1274edfbd6f1fa8f16e1b2b1e8023751014638f1e0f0776fcc8110eaac10677::vault::put_object<ScallopSpoolAccountKey<T0>, 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::SpoolAccount<T0>>(arg0, v0, arg1);
    }

    public(friend) fun redeem_market<T0>(arg0: &mut 0xe1274edfbd6f1fa8f16e1b2b1e8023751014638f1e0f0776fcc8110eaac10677::vault::Vault, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T0>(arg1, arg2, 0x2::coin::from_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(0xe1274edfbd6f1fa8f16e1b2b1e8023751014638f1e0f0776fcc8110eaac10677::vault::take_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(arg0, arg3), arg5), arg4, arg5);
        0xe1274edfbd6f1fa8f16e1b2b1e8023751014638f1e0f0776fcc8110eaac10677::vault::put_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v0), arg5);
        0x2::coin::value<T0>(&v0)
    }

    public(friend) fun redeem_rewards_spool<T0, T1>(arg0: &mut 0xe1274edfbd6f1fa8f16e1b2b1e8023751014638f1e0f0776fcc8110eaac10677::vault::Vault, arg1: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::rewards_pool::RewardsPool<T1>, arg2: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = take_spool_account<T0>(arg0);
        let v1 = 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::user::redeem_rewards<T0, T1>(arg2, arg1, &mut v0, arg3, arg4);
        0xe1274edfbd6f1fa8f16e1b2b1e8023751014638f1e0f0776fcc8110eaac10677::vault::put_balance<T1>(arg0, 0x2::coin::into_balance<T1>(v1), arg4);
        put_spool_account<T0>(arg0, v0);
        0x2::coin::value<T1>(&v1)
    }

    public(friend) fun setup<T0>(arg0: &mut 0xe1274edfbd6f1fa8f16e1b2b1e8023751014638f1e0f0776fcc8110eaac10677::vault::Vault, arg1: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = ScallopSpoolAccountKey<T0>{dummy_field: false};
        0xe1274edfbd6f1fa8f16e1b2b1e8023751014638f1e0f0776fcc8110eaac10677::vault::put_object<ScallopSpoolAccountKey<T0>, 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::SpoolAccount<T0>>(arg0, v0, 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::user::new_spool_account<T0>(arg1, arg2, arg3));
    }

    public(friend) fun stake_spool<T0>(arg0: &mut 0xe1274edfbd6f1fa8f16e1b2b1e8023751014638f1e0f0776fcc8110eaac10677::vault::Vault, arg1: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = take_spool_account<T0>(arg0);
        0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::user::stake<T0>(arg1, &mut v0, 0x2::coin::from_balance<T0>(0xe1274edfbd6f1fa8f16e1b2b1e8023751014638f1e0f0776fcc8110eaac10677::vault::take_balance<T0>(arg0, arg2), arg4), arg3, arg4);
        put_spool_account<T0>(arg0, v0);
    }

    fun take_spool_account<T0>(arg0: &mut 0xe1274edfbd6f1fa8f16e1b2b1e8023751014638f1e0f0776fcc8110eaac10677::vault::Vault) : 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::SpoolAccount<T0> {
        let v0 = ScallopSpoolAccountKey<T0>{dummy_field: false};
        0xe1274edfbd6f1fa8f16e1b2b1e8023751014638f1e0f0776fcc8110eaac10677::vault::take_object<ScallopSpoolAccountKey<T0>, 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::SpoolAccount<T0>>(arg0, v0)
    }

    public(friend) fun unstake_spool<T0>(arg0: &mut 0xe1274edfbd6f1fa8f16e1b2b1e8023751014638f1e0f0776fcc8110eaac10677::vault::Vault, arg1: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = take_spool_account<T0>(arg0);
        let v1 = 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::user::unstake<T0>(arg1, &mut v0, arg2, arg3, arg4);
        0xe1274edfbd6f1fa8f16e1b2b1e8023751014638f1e0f0776fcc8110eaac10677::vault::put_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v1), arg4);
        put_spool_account<T0>(arg0, v0);
        0x2::coin::value<T0>(&v1)
    }

    // decompiled from Move bytecode v6
}

