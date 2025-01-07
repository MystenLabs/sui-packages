module 0xfb291ca86dacabc86fb3f7f2bbe882a8aa5c5cb7b332346e791a9f3f51cb8ab2::yield {
    struct Vault<phantom T0> has key {
        id: 0x2::object::UID,
        spool_account: 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::SpoolAccount<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>,
        rewards: 0x2::balance::Balance<T0>,
    }

    public fun create_scallop_vault<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::user::new_spool_account<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(arg2, arg4, arg5);
        0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::user::stake<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(arg2, &mut v0, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<T0>(arg0, arg1, arg3, arg4, arg5), arg4, arg5);
        new_shared_vault<T0>(v0, arg5);
    }

    public entry fun deposit_from_treasury_into_scallop(arg0: &mut 0xfb291ca86dacabc86fb3f7f2bbe882a8aa5c5cb7b332346e791a9f3f51cb8ab2::testury::TesturyAdminCap, arg1: &mut 0xfb291ca86dacabc86fb3f7f2bbe882a8aa5c5cb7b332346e791a9f3f51cb8ab2::testury::Testury, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xfb291ca86dacabc86fb3f7f2bbe882a8aa5c5cb7b332346e791a9f3f51cb8ab2::testury::take_from_sui_balance(arg0, arg1, arg5, arg7);
        create_scallop_vault<0x2::sui::SUI>(arg2, arg3, arg4, v0, arg6, arg7);
    }

    fun new_shared_vault<T0>(arg0: 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::SpoolAccount<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault<T0>{
            id            : 0x2::object::new(arg1),
            spool_account : arg0,
            rewards       : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<Vault<T0>>(v0);
    }

    public fun scrape_rewards<T0>(arg0: &mut Vault<T0>, arg1: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg2: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::rewards_pool::RewardsPool<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg0.rewards, 0x2::coin::into_balance<T0>(0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::user::redeem_rewards<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>, T0>(arg1, arg2, &mut arg0.spool_account, arg3, arg4)));
    }

    public entry fun unstake_from_scallop_into_treasury(arg0: &mut 0xfb291ca86dacabc86fb3f7f2bbe882a8aa5c5cb7b332346e791a9f3f51cb8ab2::testury::TesturyAdminCap, arg1: &mut 0xfb291ca86dacabc86fb3f7f2bbe882a8aa5c5cb7b332346e791a9f3f51cb8ab2::testury::Testury, arg2: &mut Vault<0x2::sui::SUI>, arg3: u64, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg6: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xfb291ca86dacabc86fb3f7f2bbe882a8aa5c5cb7b332346e791a9f3f51cb8ab2::testury::receive_sui_balance(arg1, unstake_from_vault<0x2::sui::SUI>(arg2, arg0, arg3, arg4, arg5, arg6, arg7, arg8));
    }

    public fun unstake_from_vault<T0>(arg0: &mut Vault<T0>, arg1: &0xfb291ca86dacabc86fb3f7f2bbe882a8aa5c5cb7b332346e791a9f3f51cb8ab2::testury::TesturyAdminCap, arg2: u64, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::stake_amount<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&arg0.spool_account) >= arg2, 1);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T0>(arg3, arg4, 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::user::unstake<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(arg5, &mut arg0.spool_account, arg2, arg6, arg7), arg6, arg7)
    }

    // decompiled from Move bytecode v6
}

