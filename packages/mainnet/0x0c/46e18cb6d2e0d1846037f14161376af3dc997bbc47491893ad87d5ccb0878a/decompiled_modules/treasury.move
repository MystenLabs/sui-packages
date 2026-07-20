module 0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::treasury {
    struct TreasuryCreated has copy, drop {
        treasury_id: 0x2::object::ID,
        admin: address,
    }

    struct SubscriptionFeeCollected has copy, drop {
        amount: u64,
        publication_id: 0x2::object::ID,
        subscriber: address,
    }

    struct PayPerArticleFeeCollected has copy, drop {
        amount: u64,
        article_id: 0x2::object::ID,
        reader: address,
    }

    struct TreasuryWithdrawal has copy, drop {
        amount: u64,
        recipient: address,
    }

    struct FeeRatesUpdated has copy, drop {
        new_subscription_fee_bps: u64,
        new_article_deposit_bps: u64,
    }

    struct Treasury has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>,
        subscription_fee_bps: u64,
        article_deposit_bps: u64,
        total_fees_collected: u64,
    }

    struct TreasuryCap has store, key {
        id: 0x2::object::UID,
    }

    public fun balance(arg0: &Treasury) : u64 {
        0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.balance)
    }

    public fun id(arg0: &Treasury) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun article_deposit_bps(arg0: &Treasury) : u64 {
        arg0.article_deposit_bps
    }

    fun calculate_fee(arg0: u64, arg1: u64) : u64 {
        arg0 * arg1 / 0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::constants::bps_denominator()
    }

    public(friend) fun collect_pay_per_article_fee(arg0: &mut Treasury, arg1: &mut 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: 0x2::object::ID, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1);
        let v1 = calculate_fee(v0, arg0.article_deposit_bps);
        if (v1 > 0) {
            0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.balance, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::coin::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, v1, arg4)));
            arg0.total_fees_collected = arg0.total_fees_collected + v1;
            let v2 = PayPerArticleFeeCollected{
                amount     : v1,
                article_id : arg2,
                reader     : arg3,
            };
            0x2::event::emit<PayPerArticleFeeCollected>(v2);
        };
        v0 - v1
    }

    public(friend) fun collect_subscription_fee(arg0: &mut Treasury, arg1: &mut 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: 0x2::object::ID, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1);
        let v1 = calculate_fee(v0, arg0.subscription_fee_bps);
        if (v1 > 0) {
            0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.balance, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::coin::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, v1, arg4)));
            arg0.total_fees_collected = arg0.total_fees_collected + v1;
            let v2 = SubscriptionFeeCollected{
                amount         : v1,
                publication_id : arg2,
                subscriber     : arg3,
            };
            0x2::event::emit<SubscriptionFeeCollected>(v2);
        };
        v0 - v1
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Treasury{
            id                   : 0x2::object::new(arg0),
            balance              : 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(),
            subscription_fee_bps : 100,
            article_deposit_bps  : 100,
            total_fees_collected : 0,
        };
        let v1 = TreasuryCreated{
            treasury_id : 0x2::object::id<Treasury>(&v0),
            admin       : 0x2::tx_context::sender(arg0),
        };
        0x2::event::emit<TreasuryCreated>(v1);
        0x2::transfer::share_object<Treasury>(v0);
        let v2 = TreasuryCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<TreasuryCap>(v2, 0x2::tx_context::sender(arg0));
    }

    public fun subscription_fee_bps(arg0: &Treasury) : u64 {
        arg0.subscription_fee_bps
    }

    public fun total_fees_collected(arg0: &Treasury) : u64 {
        arg0.total_fees_collected
    }

    public fun treasury_cap_id(arg0: &TreasuryCap) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun update_fee_rates(arg0: &mut Treasury, arg1: &TreasuryCap, arg2: u64, arg3: u64) {
        assert!(arg2 <= 1000, 2);
        assert!(arg3 <= 1000, 2);
        arg0.subscription_fee_bps = arg2;
        arg0.article_deposit_bps = arg3;
        let v0 = FeeRatesUpdated{
            new_subscription_fee_bps : arg2,
            new_article_deposit_bps  : arg3,
        };
        0x2::event::emit<FeeRatesUpdated>(v0);
    }

    public fun withdraw(arg0: &mut Treasury, arg1: &TreasuryCap, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.balance) >= arg2, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.balance, arg2), arg4), arg3);
        let v0 = TreasuryWithdrawal{
            amount    : arg2,
            recipient : arg3,
        };
        0x2::event::emit<TreasuryWithdrawal>(v0);
    }

    // decompiled from Move bytecode v7
}

