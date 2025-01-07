module 0xf9feb2c06ccff7885e75cb5bff91b9a8788833f14e40af8062e24bd956dd338e::scallop_whusdce {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Strategy has key {
        id: 0x2::object::UID,
        admin_cap_id: 0x2::object::ID,
        vault_access: 0x1::option::Option<0xf9feb2c06ccff7885e75cb5bff91b9a8788833f14e40af8062e24bd956dd338e::vault::VaultAccess>,
        scallop_pool_acc: 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::SpoolAccount<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>>,
        staked_amount_usdc: u64,
        collected_profit_usdc: 0x2::balance::Balance<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>,
    }

    struct EventStrategyState has copy, drop, store {
        strategy_id: 0x2::object::ID,
        vault_access: 0x1::option::Option<0x2::object::ID>,
        scallop_account_stake_amount: u64,
        staked_amount_usdc: u64,
        collected_profit_usdc: u64,
    }

    struct EventRebalanceInit has copy, drop, store {
        strategy: EventStrategyState,
        can_borrow: u64,
        to_repay: u64,
    }

    struct EventRebalanceRepayResult has copy, drop, store {
        strategy: EventStrategyState,
        redeemed_amt_usdc: u64,
    }

    struct EventRebalanceBorrowResult has copy, drop, store {
        strategy: EventStrategyState,
        borrow_amt: u64,
    }

    struct EventWithdrawInit has copy, drop, store {
        strategy: EventStrategyState,
        to_withdraw: u64,
    }

    struct EventWithdrawResult has copy, drop, store {
        strategy: EventStrategyState,
        unstake_susdc_amt: u64,
        redeemed_amt_usdc: u64,
    }

    struct EventTakeProfits has copy, drop, store {
        profit_sui: u64,
    }

    struct EventDepositSoldProfits has copy, drop, store {
        strategy: EventStrategyState,
        profit_usdc: u64,
    }

    public(friend) entry fun new(arg0: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert_scallop_pool(arg0);
        let v0 = AdminCap{id: 0x2::object::new(arg2)};
        let v1 = Strategy{
            id                    : 0x2::object::new(arg2),
            admin_cap_id          : 0x2::object::id<AdminCap>(&v0),
            vault_access          : 0x1::option::none<0xf9feb2c06ccff7885e75cb5bff91b9a8788833f14e40af8062e24bd956dd338e::vault::VaultAccess>(),
            scallop_pool_acc      : 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::user::new_spool_account<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>>(arg0, arg1, arg2),
            staked_amount_usdc    : 0,
            collected_profit_usdc : 0x2::balance::zero<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(),
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

    public fun deposit_sold_profits(arg0: &AdminCap, arg1: &mut Strategy, arg2: &mut 0xf9feb2c06ccff7885e75cb5bff91b9a8788833f14e40af8062e24bd956dd338e::vault::Vault<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0xf9feb2c06ccff7885e75cb5bff91b9a8788833f14e40af8062e24bd956dd338e::ywhusdce::YWHUSDCE>, arg3: 0x2::balance::Balance<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>, arg4: &0x2::clock::Clock) {
        assert_admin(arg0, arg1);
        0x2::balance::join<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&mut arg3, 0x2::balance::withdraw_all<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&mut arg1.collected_profit_usdc));
        let v0 = EventDepositSoldProfits{
            strategy    : event_get_strategy_state(arg1),
            profit_usdc : 0x2::balance::value<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&arg3),
        };
        0x2::event::emit<EventDepositSoldProfits>(v0);
        0xf9feb2c06ccff7885e75cb5bff91b9a8788833f14e40af8062e24bd956dd338e::vault::strategy_hand_over_profit<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0xf9feb2c06ccff7885e75cb5bff91b9a8788833f14e40af8062e24bd956dd338e::ywhusdce::YWHUSDCE>(arg2, 0x1::option::borrow<0xf9feb2c06ccff7885e75cb5bff91b9a8788833f14e40af8062e24bd956dd338e::vault::VaultAccess>(&arg1.vault_access), arg3, arg4);
    }

    fun event_get_strategy_state(arg0: &Strategy) : EventStrategyState {
        let v0 = if (0x1::option::is_some<0xf9feb2c06ccff7885e75cb5bff91b9a8788833f14e40af8062e24bd956dd338e::vault::VaultAccess>(&arg0.vault_access)) {
            0x1::option::some<0x2::object::ID>(0xf9feb2c06ccff7885e75cb5bff91b9a8788833f14e40af8062e24bd956dd338e::vault::vault_access_id(0x1::option::borrow<0xf9feb2c06ccff7885e75cb5bff91b9a8788833f14e40af8062e24bd956dd338e::vault::VaultAccess>(&arg0.vault_access)))
        } else {
            0x1::option::none<0x2::object::ID>()
        };
        EventStrategyState{
            strategy_id                  : 0x2::object::id<Strategy>(arg0),
            vault_access                 : v0,
            scallop_account_stake_amount : 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::stake_amount<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>>(&arg0.scallop_pool_acc),
            staked_amount_usdc           : arg0.staked_amount_usdc,
            collected_profit_usdc        : 0x2::balance::value<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&arg0.collected_profit_usdc),
        }
    }

    public(friend) entry fun join_vault(arg0: &0xf9feb2c06ccff7885e75cb5bff91b9a8788833f14e40af8062e24bd956dd338e::vault::AdminCap<0xf9feb2c06ccff7885e75cb5bff91b9a8788833f14e40af8062e24bd956dd338e::ywhusdce::YWHUSDCE>, arg1: &mut 0xf9feb2c06ccff7885e75cb5bff91b9a8788833f14e40af8062e24bd956dd338e::vault::Vault<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0xf9feb2c06ccff7885e75cb5bff91b9a8788833f14e40af8062e24bd956dd338e::ywhusdce::YWHUSDCE>, arg2: &AdminCap, arg3: &mut Strategy, arg4: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg2, arg3);
        0x1::option::fill<0xf9feb2c06ccff7885e75cb5bff91b9a8788833f14e40af8062e24bd956dd338e::vault::VaultAccess>(&mut arg3.vault_access, 0xf9feb2c06ccff7885e75cb5bff91b9a8788833f14e40af8062e24bd956dd338e::vault::add_strategy<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0xf9feb2c06ccff7885e75cb5bff91b9a8788833f14e40af8062e24bd956dd338e::ywhusdce::YWHUSDCE>(arg0, arg1, arg4));
    }

    public fun rebalance(arg0: &AdminCap, arg1: &mut Strategy, arg2: &mut 0xf9feb2c06ccff7885e75cb5bff91b9a8788833f14e40af8062e24bd956dd338e::vault::Vault<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0xf9feb2c06ccff7885e75cb5bff91b9a8788833f14e40af8062e24bd956dd338e::ywhusdce::YWHUSDCE>, arg3: &0xf9feb2c06ccff7885e75cb5bff91b9a8788833f14e40af8062e24bd956dd338e::vault::RebalanceAmounts, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg6: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1);
        assert_scallop_market(arg5);
        assert_scallop_pool(arg6);
        let v0 = 0x1::option::borrow<0xf9feb2c06ccff7885e75cb5bff91b9a8788833f14e40af8062e24bd956dd338e::vault::VaultAccess>(&arg1.vault_access);
        let (v1, v2) = 0xf9feb2c06ccff7885e75cb5bff91b9a8788833f14e40af8062e24bd956dd338e::vault::rebalance_amounts_get(arg3, v0);
        let v3 = EventRebalanceInit{
            strategy   : event_get_strategy_state(arg1),
            can_borrow : v1,
            to_repay   : v2,
        };
        0x2::event::emit<EventRebalanceInit>(v3);
        if (v2 > 0) {
            let v4 = 0x2::coin::into_balance<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(arg4, arg5, 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::user::unstake<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>>(arg6, &mut arg1.scallop_pool_acc, 0xf9feb2c06ccff7885e75cb5bff91b9a8788833f14e40af8062e24bd956dd338e::util::muldiv(0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::stake_amount<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>>(&arg1.scallop_pool_acc), v2, arg1.staked_amount_usdc), arg7, arg8), arg7, arg8));
            let v5 = 0x2::balance::value<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&v4);
            0xf9feb2c06ccff7885e75cb5bff91b9a8788833f14e40af8062e24bd956dd338e::vault::strategy_repay<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0xf9feb2c06ccff7885e75cb5bff91b9a8788833f14e40af8062e24bd956dd338e::ywhusdce::YWHUSDCE>(arg2, v0, v4);
            arg1.staked_amount_usdc = arg1.staked_amount_usdc - v5;
            let v6 = EventRebalanceRepayResult{
                strategy          : event_get_strategy_state(arg1),
                redeemed_amt_usdc : v5,
            };
            0x2::event::emit<EventRebalanceRepayResult>(v6);
        } else if (v1 > 0) {
            let v7 = 0x2::math::min(v1, 0xf9feb2c06ccff7885e75cb5bff91b9a8788833f14e40af8062e24bd956dd338e::vault::free_balance<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0xf9feb2c06ccff7885e75cb5bff91b9a8788833f14e40af8062e24bd956dd338e::ywhusdce::YWHUSDCE>(arg2));
            0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::user::stake<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>>(arg6, &mut arg1.scallop_pool_acc, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(arg4, arg5, 0x2::coin::from_balance<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(0xf9feb2c06ccff7885e75cb5bff91b9a8788833f14e40af8062e24bd956dd338e::vault::strategy_borrow<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0xf9feb2c06ccff7885e75cb5bff91b9a8788833f14e40af8062e24bd956dd338e::ywhusdce::YWHUSDCE>(arg2, v0, v7), arg8), arg7, arg8), arg7, arg8);
            arg1.staked_amount_usdc = arg1.staked_amount_usdc + v7;
            let v8 = EventRebalanceBorrowResult{
                strategy   : event_get_strategy_state(arg1),
                borrow_amt : v7,
            };
            0x2::event::emit<EventRebalanceBorrowResult>(v8);
        };
    }

    public fun take_profits_for_selling(arg0: &AdminCap, arg1: &mut Strategy, arg2: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg3: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::rewards_pool::RewardsPool<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        assert_admin(arg0, arg1);
        assert_scallop_pool(arg2);
        assert_scallop_rewards_pool(arg3);
        let v0 = 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::user::redeem_rewards<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>, 0x2::sui::SUI>(arg2, arg3, &mut arg1.scallop_pool_acc, arg4, arg5);
        let v1 = EventTakeProfits{profit_sui: 0x2::coin::value<0x2::sui::SUI>(&v0)};
        0x2::event::emit<EventTakeProfits>(v1);
        0x2::coin::into_balance<0x2::sui::SUI>(v0)
    }

    public fun withdraw(arg0: &mut Strategy, arg1: &mut 0xf9feb2c06ccff7885e75cb5bff91b9a8788833f14e40af8062e24bd956dd338e::vault::WithdrawTicket<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0xf9feb2c06ccff7885e75cb5bff91b9a8788833f14e40af8062e24bd956dd338e::ywhusdce::YWHUSDCE>, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_scallop_market(arg3);
        assert_scallop_pool(arg4);
        let v0 = 0x1::option::borrow<0xf9feb2c06ccff7885e75cb5bff91b9a8788833f14e40af8062e24bd956dd338e::vault::VaultAccess>(&arg0.vault_access);
        let v1 = 0xf9feb2c06ccff7885e75cb5bff91b9a8788833f14e40af8062e24bd956dd338e::vault::withdraw_ticket_to_withdraw<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0xf9feb2c06ccff7885e75cb5bff91b9a8788833f14e40af8062e24bd956dd338e::ywhusdce::YWHUSDCE>(arg1, v0);
        let v2 = EventWithdrawInit{
            strategy    : event_get_strategy_state(arg0),
            to_withdraw : v1,
        };
        0x2::event::emit<EventWithdrawInit>(v2);
        if (v1 == 0) {
            return
        };
        let v3 = 0xf9feb2c06ccff7885e75cb5bff91b9a8788833f14e40af8062e24bd956dd338e::util::muldiv(0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::stake_amount<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>>(&arg0.scallop_pool_acc), v1, arg0.staked_amount_usdc);
        let v4 = 0x2::coin::into_balance<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(arg2, arg3, 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::user::unstake<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>>(arg4, &mut arg0.scallop_pool_acc, v3, arg5, arg6), arg5, arg6));
        if (0x2::balance::value<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&v4) > v1) {
            0x2::balance::join<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&mut arg0.collected_profit_usdc, 0x2::balance::split<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&mut v4, 0x2::balance::value<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&v4) - v1));
        };
        0xf9feb2c06ccff7885e75cb5bff91b9a8788833f14e40af8062e24bd956dd338e::vault::strategy_withdraw_to_ticket<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0xf9feb2c06ccff7885e75cb5bff91b9a8788833f14e40af8062e24bd956dd338e::ywhusdce::YWHUSDCE>(arg1, v0, v4);
        arg0.staked_amount_usdc = arg0.staked_amount_usdc - v1;
        let v5 = EventWithdrawResult{
            strategy          : event_get_strategy_state(arg0),
            unstake_susdc_amt : v3,
            redeemed_amt_usdc : 0x2::balance::value<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&v4),
        };
        0x2::event::emit<EventWithdrawResult>(v5);
    }

    // decompiled from Move bytecode v6
}

