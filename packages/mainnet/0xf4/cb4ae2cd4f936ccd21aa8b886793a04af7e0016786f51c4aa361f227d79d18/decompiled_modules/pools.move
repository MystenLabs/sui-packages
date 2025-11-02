module 0xf4cb4ae2cd4f936ccd21aa8b886793a04af7e0016786f51c4aa361f227d79d18::pools {
    struct InvestmentCap has store, key {
        id: 0x2::object::UID,
    }

    struct InvestmentPool has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>,
    }

    struct BuyEvent has copy, drop {
        buyer: address,
        amount: u64,
    }

    struct WithdrawalEvent has copy, drop {
        to: address,
        amount: u64,
    }

    struct POOLS has drop {
        dummy_field: bool,
    }

    public fun buy(arg0: &mut InvestmentPool, arg1: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 1);
        assert!(0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg1) >= arg2, 2);
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.balance, 0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::coin::balance_mut<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg1), arg2));
        0x2::coin::destroy_zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1);
        let v0 = BuyEvent{
            buyer  : 0x2::tx_context::sender(arg3),
            amount : arg2,
        };
        0x2::event::emit<BuyEvent>(v0);
    }

    fun init(arg0: POOLS, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<POOLS>(arg0, arg1);
        let v0 = InvestmentCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<InvestmentCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = InvestmentPool{
            id      : 0x2::object::new(arg1),
            balance : 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(),
        };
        0x2::transfer::share_object<InvestmentPool>(v1);
    }

    public fun payout(arg0: &mut InvestmentCap, arg1: &mut InvestmentPool, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0, 1);
        assert!(0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg1.balance) >= arg3, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::take<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg1.balance, arg3, arg4), arg2);
        let v0 = WithdrawalEvent{
            to     : arg2,
            amount : arg3,
        };
        0x2::event::emit<WithdrawalEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

