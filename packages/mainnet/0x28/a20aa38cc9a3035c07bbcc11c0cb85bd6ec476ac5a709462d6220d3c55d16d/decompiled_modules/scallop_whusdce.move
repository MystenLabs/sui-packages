module 0x28a20aa38cc9a3035c07bbcc11c0cb85bd6ec476ac5a709462d6220d3c55d16d::scallop_whusdce {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Strategy has key {
        id: 0x2::object::UID,
        admin_cap_id: 0x2::object::ID,
        vault_access: 0x1::option::Option<0x28a20aa38cc9a3035c07bbcc11c0cb85bd6ec476ac5a709462d6220d3c55d16d::vault::VaultAccess>,
        scallop_pool_acc: 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::SpoolAccount<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>>,
        underlying_nominal_value_usdc: u64,
        collected_profit_usdc: 0x2::balance::Balance<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>,
        collected_profit_sui: 0x2::balance::Balance<0x2::sui::SUI>,
        version: u64,
    }

    public(friend) entry fun new(arg0: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert_scallop_pool(arg0);
        let v0 = AdminCap{id: 0x2::object::new(arg2)};
        let v1 = Strategy{
            id                            : 0x2::object::new(arg2),
            admin_cap_id                  : 0x2::object::id<AdminCap>(&v0),
            vault_access                  : 0x1::option::none<0x28a20aa38cc9a3035c07bbcc11c0cb85bd6ec476ac5a709462d6220d3c55d16d::vault::VaultAccess>(),
            scallop_pool_acc              : 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::user::new_spool_account<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>>(arg0, arg1, arg2),
            underlying_nominal_value_usdc : 0,
            collected_profit_usdc         : 0x2::balance::zero<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(),
            collected_profit_sui          : 0x2::balance::zero<0x2::sui::SUI>(),
            version                       : 1,
        };
        0x2::transfer::share_object<Strategy>(v1);
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg2));
    }

    fun assert_admin(arg0: &AdminCap, arg1: &Strategy) {
        assert!(0x2::object::id<AdminCap>(arg0) == arg1.admin_cap_id, 0);
    }

    fun assert_scallop_market(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market) {
        assert!(0x2::object::id_address<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market>(arg0) == @0xa757975255146dc9686aa823b7838b507f315d704f428cbadad2f4ea061939d9, 2);
    }

    fun assert_scallop_pool(arg0: &0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool) {
        assert!(0x2::object::id_address<0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool>(arg0) == @0x4ace6648ddc64e646ba47a957c562c32c9599b3bba8f5ac1aadb2ae23a2f8ca0, 1);
    }

    fun assert_scallop_rewards_pool(arg0: &0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::rewards_pool::RewardsPool<0x2::sui::SUI>) {
        assert!(0x2::object::id_address<0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::rewards_pool::RewardsPool<0x2::sui::SUI>>(arg0) == @0xf4268cc9b9413b9bfe09e8966b8de650494c9e5784bf0930759cfef4904daff8, 2);
    }

    fun assert_version(arg0: &Strategy) {
        assert!(arg0.version == 1, 4);
    }

    public fun deposit_sold_profits(arg0: &AdminCap, arg1: &mut Strategy, arg2: &mut 0x28a20aa38cc9a3035c07bbcc11c0cb85bd6ec476ac5a709462d6220d3c55d16d::vault::Vault<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0x28a20aa38cc9a3035c07bbcc11c0cb85bd6ec476ac5a709462d6220d3c55d16d::ywhusdce::YWHUSDCE>, arg3: 0x2::balance::Balance<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>, arg4: &0x2::clock::Clock) {
        assert_admin(arg0, arg1);
        assert_version(arg1);
        0x2::balance::join<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&mut arg3, 0x2::balance::withdraw_all<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&mut arg1.collected_profit_usdc));
        0x28a20aa38cc9a3035c07bbcc11c0cb85bd6ec476ac5a709462d6220d3c55d16d::vault::strategy_hand_over_profit<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0x28a20aa38cc9a3035c07bbcc11c0cb85bd6ec476ac5a709462d6220d3c55d16d::ywhusdce::YWHUSDCE>(arg2, 0x1::option::borrow<0x28a20aa38cc9a3035c07bbcc11c0cb85bd6ec476ac5a709462d6220d3c55d16d::vault::VaultAccess>(&arg1.vault_access), arg3, arg4);
    }

    entry fun join_vault(arg0: &0x28a20aa38cc9a3035c07bbcc11c0cb85bd6ec476ac5a709462d6220d3c55d16d::vault::AdminCap<0x28a20aa38cc9a3035c07bbcc11c0cb85bd6ec476ac5a709462d6220d3c55d16d::ywhusdce::YWHUSDCE>, arg1: &mut 0x28a20aa38cc9a3035c07bbcc11c0cb85bd6ec476ac5a709462d6220d3c55d16d::vault::Vault<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0x28a20aa38cc9a3035c07bbcc11c0cb85bd6ec476ac5a709462d6220d3c55d16d::ywhusdce::YWHUSDCE>, arg2: &AdminCap, arg3: &mut Strategy, arg4: &mut 0x2::tx_context::TxContext) {
        assert_version(arg3);
        assert_admin(arg2, arg3);
        0x1::option::fill<0x28a20aa38cc9a3035c07bbcc11c0cb85bd6ec476ac5a709462d6220d3c55d16d::vault::VaultAccess>(&mut arg3.vault_access, 0x28a20aa38cc9a3035c07bbcc11c0cb85bd6ec476ac5a709462d6220d3c55d16d::vault::add_strategy<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0x28a20aa38cc9a3035c07bbcc11c0cb85bd6ec476ac5a709462d6220d3c55d16d::ywhusdce::YWHUSDCE>(arg0, arg1, arg4));
    }

    entry fun migrate(arg0: &AdminCap, arg1: &mut Strategy) {
        assert_admin(arg0, arg1);
        assert!(arg1.version < 1, 5);
        arg1.version = 1;
    }

    public fun rebalance(arg0: &AdminCap, arg1: &mut Strategy, arg2: &mut 0x28a20aa38cc9a3035c07bbcc11c0cb85bd6ec476ac5a709462d6220d3c55d16d::vault::Vault<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0x28a20aa38cc9a3035c07bbcc11c0cb85bd6ec476ac5a709462d6220d3c55d16d::ywhusdce::YWHUSDCE>, arg3: &0x28a20aa38cc9a3035c07bbcc11c0cb85bd6ec476ac5a709462d6220d3c55d16d::vault::RebalanceAmounts, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg6: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1);
        assert_version(arg1);
        assert_scallop_market(arg5);
        assert_scallop_pool(arg6);
        let v0 = 0x1::option::borrow<0x28a20aa38cc9a3035c07bbcc11c0cb85bd6ec476ac5a709462d6220d3c55d16d::vault::VaultAccess>(&arg1.vault_access);
        let (v1, v2) = 0x28a20aa38cc9a3035c07bbcc11c0cb85bd6ec476ac5a709462d6220d3c55d16d::vault::rebalance_amounts_get(arg3, v0);
        if (v2 > 0) {
            let v3 = 0x2::coin::into_balance<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(arg4, arg5, 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::user::unstake<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>>(arg6, &mut arg1.scallop_pool_acc, 0x28a20aa38cc9a3035c07bbcc11c0cb85bd6ec476ac5a709462d6220d3c55d16d::util::muldiv(0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::stake_amount<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>>(&arg1.scallop_pool_acc), v2, arg1.underlying_nominal_value_usdc), arg7, arg8), arg7, arg8));
            if (0x2::balance::value<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&v3) > v2) {
                0x2::balance::join<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&mut arg1.collected_profit_usdc, 0x2::balance::split<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&mut v3, 0x2::balance::value<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&v3) - v2));
            };
            0x28a20aa38cc9a3035c07bbcc11c0cb85bd6ec476ac5a709462d6220d3c55d16d::vault::strategy_repay<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0x28a20aa38cc9a3035c07bbcc11c0cb85bd6ec476ac5a709462d6220d3c55d16d::ywhusdce::YWHUSDCE>(arg2, v0, v3);
            arg1.underlying_nominal_value_usdc = arg1.underlying_nominal_value_usdc - 0x2::balance::value<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&v3);
        } else if (v1 > 0) {
            let v4 = 0x2::math::min(v1, 0x28a20aa38cc9a3035c07bbcc11c0cb85bd6ec476ac5a709462d6220d3c55d16d::vault::free_balance<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0x28a20aa38cc9a3035c07bbcc11c0cb85bd6ec476ac5a709462d6220d3c55d16d::ywhusdce::YWHUSDCE>(arg2));
            0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::user::stake<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>>(arg6, &mut arg1.scallop_pool_acc, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(arg4, arg5, 0x2::coin::from_balance<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(0x28a20aa38cc9a3035c07bbcc11c0cb85bd6ec476ac5a709462d6220d3c55d16d::vault::strategy_borrow<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0x28a20aa38cc9a3035c07bbcc11c0cb85bd6ec476ac5a709462d6220d3c55d16d::ywhusdce::YWHUSDCE>(arg2, v0, v4), arg8), arg7, arg8), arg7, arg8);
            arg1.underlying_nominal_value_usdc = arg1.underlying_nominal_value_usdc + v4;
        };
    }

    public fun remove_from_vault(arg0: &AdminCap, arg1: &mut Strategy, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg5: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::rewards_pool::RewardsPool<0x2::sui::SUI>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x28a20aa38cc9a3035c07bbcc11c0cb85bd6ec476ac5a709462d6220d3c55d16d::vault::StrategyRemovalTicket<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0x28a20aa38cc9a3035c07bbcc11c0cb85bd6ec476ac5a709462d6220d3c55d16d::ywhusdce::YWHUSDCE> {
        assert_admin(arg0, arg1);
        assert_version(arg1);
        assert_scallop_market(arg3);
        assert_scallop_pool(arg4);
        assert_scallop_rewards_pool(arg5);
        let v0 = 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::user::redeem_rewards<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>, 0x2::sui::SUI>(arg4, arg5, &mut arg1.scallop_pool_acc, arg6, arg7);
        assert!(0x2::coin::value<0x2::sui::SUI>(&v0) == 0, 3);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.collected_profit_sui) == 0, 3);
        0x2::coin::destroy_zero<0x2::sui::SUI>(v0);
        let v1 = 0x2::coin::into_balance<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(arg2, arg3, 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::user::unstake<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>>(arg4, &mut arg1.scallop_pool_acc, 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::stake_amount<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>>(&arg1.scallop_pool_acc), arg6, arg7), arg6, arg7));
        0x2::balance::join<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&mut v1, 0x2::balance::withdraw_all<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&mut arg1.collected_profit_usdc));
        arg1.underlying_nominal_value_usdc = 0;
        0x28a20aa38cc9a3035c07bbcc11c0cb85bd6ec476ac5a709462d6220d3c55d16d::vault::new_strategy_removal_ticket<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0x28a20aa38cc9a3035c07bbcc11c0cb85bd6ec476ac5a709462d6220d3c55d16d::ywhusdce::YWHUSDCE>(0x1::option::extract<0x28a20aa38cc9a3035c07bbcc11c0cb85bd6ec476ac5a709462d6220d3c55d16d::vault::VaultAccess>(&mut arg1.vault_access), v1)
    }

    public fun skim_base_profits(arg0: &AdminCap, arg1: &mut Strategy, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1);
        assert_version(arg1);
        assert_scallop_market(arg3);
        assert_scallop_pool(arg4);
        let v0 = 0x2::coin::into_balance<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(arg2, arg3, 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::user::unstake<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>>(arg4, &mut arg1.scallop_pool_acc, 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::stake_amount<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>>(&arg1.scallop_pool_acc), arg5, arg6), arg5, arg6));
        if (0x2::balance::value<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&v0) > arg1.underlying_nominal_value_usdc) {
            0x2::balance::join<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&mut arg1.collected_profit_usdc, 0x2::balance::split<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&mut v0, 0x2::balance::value<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&v0) - arg1.underlying_nominal_value_usdc));
        };
        0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::user::stake<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>>(arg4, &mut arg1.scallop_pool_acc, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(arg2, arg3, 0x2::coin::from_balance<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(v0, arg6), arg5, arg6), arg5, arg6);
    }

    public fun take_profits_for_selling(arg0: &AdminCap, arg1: &mut Strategy, arg2: 0x1::option::Option<u64>, arg3: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg4: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::rewards_pool::RewardsPool<0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        assert_admin(arg0, arg1);
        assert_version(arg1);
        assert_scallop_pool(arg3);
        assert_scallop_rewards_pool(arg4);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.collected_profit_sui, 0x2::coin::into_balance<0x2::sui::SUI>(0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::user::redeem_rewards<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>, 0x2::sui::SUI>(arg3, arg4, &mut arg1.scallop_pool_acc, arg5, arg6)));
        if (0x1::option::is_some<u64>(&arg2)) {
            0x2::balance::split<0x2::sui::SUI>(&mut arg1.collected_profit_sui, *0x1::option::borrow<u64>(&arg2))
        } else {
            0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.collected_profit_sui)
        }
    }

    public fun withdraw(arg0: &mut Strategy, arg1: &mut 0x28a20aa38cc9a3035c07bbcc11c0cb85bd6ec476ac5a709462d6220d3c55d16d::vault::WithdrawTicket<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0x28a20aa38cc9a3035c07bbcc11c0cb85bd6ec476ac5a709462d6220d3c55d16d::ywhusdce::YWHUSDCE>, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_scallop_market(arg3);
        assert_scallop_pool(arg4);
        let v0 = 0x1::option::borrow<0x28a20aa38cc9a3035c07bbcc11c0cb85bd6ec476ac5a709462d6220d3c55d16d::vault::VaultAccess>(&arg0.vault_access);
        let v1 = 0x28a20aa38cc9a3035c07bbcc11c0cb85bd6ec476ac5a709462d6220d3c55d16d::vault::withdraw_ticket_to_withdraw<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0x28a20aa38cc9a3035c07bbcc11c0cb85bd6ec476ac5a709462d6220d3c55d16d::ywhusdce::YWHUSDCE>(arg1, v0);
        if (v1 == 0) {
            return
        };
        let v2 = 0x2::coin::into_balance<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(arg2, arg3, 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::user::unstake<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>>(arg4, &mut arg0.scallop_pool_acc, 0x28a20aa38cc9a3035c07bbcc11c0cb85bd6ec476ac5a709462d6220d3c55d16d::util::muldiv(0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::stake_amount<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>>(&arg0.scallop_pool_acc), v1, arg0.underlying_nominal_value_usdc), arg5, arg6), arg5, arg6));
        if (0x2::balance::value<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&v2) > v1) {
            0x2::balance::join<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&mut arg0.collected_profit_usdc, 0x2::balance::split<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&mut v2, 0x2::balance::value<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&v2) - v1));
        };
        0x28a20aa38cc9a3035c07bbcc11c0cb85bd6ec476ac5a709462d6220d3c55d16d::vault::strategy_withdraw_to_ticket<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0x28a20aa38cc9a3035c07bbcc11c0cb85bd6ec476ac5a709462d6220d3c55d16d::ywhusdce::YWHUSDCE>(arg1, v0, v2);
        arg0.underlying_nominal_value_usdc = arg0.underlying_nominal_value_usdc - v1;
    }

    // decompiled from Move bytecode v6
}

