module 0x6d21260fba77de4aa6b7369f2f3aa2932018c5a0de157c0d78c1de05131396b8::seed_presale_contract {
    struct Presale has key {
        id: 0x2::object::UID,
        open: bool,
        target_usd: u64,
        raised_amount_sui: 0x2::balance::Balance<0x2::sui::SUI>,
        raised_amount_usdc: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>,
        total_raised_amount_usd: u128,
    }

    struct Receipt has key {
        id: 0x2::object::UID,
        amount_invested: u128,
    }

    struct PresaleOwnerCap has key {
        id: 0x2::object::UID,
        presale_id: 0x2::object::ID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg0);
        let v1 = Presale{
            id                      : v0,
            open                    : true,
            target_usd              : 145000,
            raised_amount_sui       : 0x2::balance::zero<0x2::sui::SUI>(),
            raised_amount_usdc      : 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(),
            total_raised_amount_usd : 0,
        };
        let v2 = PresaleOwnerCap{
            id         : 0x2::object::new(arg0),
            presale_id : 0x2::object::uid_to_inner(&v0),
        };
        0x2::transfer::transfer<PresaleOwnerCap>(v2, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<Presale>(v1);
    }

    public entry fun invest_sui(arg0: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg1: &mut Presale, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0, 0);
        assert!(arg1.open, 0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.raised_amount_sui, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg2, arg3, arg4)));
        let (v0, _, _, _) = 0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::get_price(arg0, 371);
        let v4 = (arg3 as u128) * v0 / 1000000000 / 1000000000;
        arg1.total_raised_amount_usd = arg1.total_raised_amount_usd + v4;
        if (arg1.total_raised_amount_usd >= (arg1.target_usd as u128) * 1000000000) {
            arg1.open = false;
        };
        let v5 = Receipt{
            id              : 0x2::object::new(arg4),
            amount_invested : v4,
        };
        0x2::transfer::transfer<Receipt>(v5, 0x2::tx_context::sender(arg4));
    }

    public entry fun invest_usdc(arg0: &mut Presale, arg1: &mut 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 0);
        assert!(arg0.open, 0);
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.raised_amount_usdc, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::coin::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, arg2, arg3)));
        let v0 = (arg2 as u128) * 1000;
        arg0.total_raised_amount_usd = arg0.total_raised_amount_usd + v0;
        if (arg0.total_raised_amount_usd >= (arg0.target_usd as u128) * 1000000000) {
            arg0.open = false;
        };
        let v1 = Receipt{
            id              : 0x2::object::new(arg3),
            amount_invested : v0,
        };
        0x2::transfer::transfer<Receipt>(v1, 0x2::tx_context::sender(arg3));
    }

    public entry fun withdraw_funds(arg0: &PresaleOwnerCap, arg1: &mut Presale, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(&arg0.presale_id == 0x2::object::uid_as_inner(&arg1.id), 0);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.raised_amount_sui);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.raised_amount_sui, v0, arg2), 0x2::tx_context::sender(arg2));
        };
        let v1 = 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg1.raised_amount_usdc);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::take<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg1.raised_amount_usdc, v1, arg2), 0x2::tx_context::sender(arg2));
        };
    }

    // decompiled from Move bytecode v6
}

