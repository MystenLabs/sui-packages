module 0x9ac9960933ef2266d1e19f275e5b8bd76033e704e8cc3faacf7ad69ba3e212cd::presale {
    struct ReferralMap has key {
        id: 0x2::object::UID,
        table: 0x2::table::Table<address, u64>,
    }

    struct Presale has key {
        id: 0x2::object::UID,
        open: bool,
        target_usd: u64,
        raised_amount_sui: 0x2::balance::Balance<0x2::sui::SUI>,
        raised_amount_usdc: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>,
        total_raised_amount_usd: u128,
    }

    struct PresaleOwnerCap has store, key {
        id: 0x2::object::UID,
        presale_id: 0x2::object::ID,
    }

    public entry fun end_presale(arg0: &PresaleOwnerCap, arg1: &mut Presale) {
        assert!(&arg0.presale_id == 0x2::object::uid_as_inner(&arg1.id), 0);
        arg1.open = false;
    }

    fun handle_invest_sui(arg0: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg1: &mut Presale, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : u128 {
        assert!(arg3 > 0, 2);
        assert!(arg1.open, 1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.raised_amount_sui, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg2, arg3, arg4)));
        let (v0, _, _, _) = 0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::get_price(arg0, 371);
        let v4 = (arg3 as u128) * v0 / 1000000000 / 1000000000;
        arg1.total_raised_amount_usd = arg1.total_raised_amount_usd + v4;
        if (arg1.total_raised_amount_usd >= (arg1.target_usd as u128) * 1000000000) {
            arg1.open = false;
        };
        v4
    }

    fun handle_invest_usdc(arg0: &mut Presale, arg1: &mut 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : u128 {
        assert!(arg2 > 0, 2);
        assert!(arg0.open, 1);
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.raised_amount_usdc, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::coin::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, arg2, arg3)));
        let v0 = (arg2 as u128) * 1000;
        arg0.total_raised_amount_usd = arg0.total_raised_amount_usd + v0;
        if (arg0.total_raised_amount_usd >= (arg0.target_usd as u128) * 1000000000) {
            arg0.open = false;
        };
        v0
    }

    fun handle_referrer(arg0: &mut ReferralMap, arg1: address) {
        if (!0x2::table::contains<address, u64>(&arg0.table, arg1)) {
            0x2::table::add<address, u64>(&mut arg0.table, arg1, 1);
        } else {
            let v0 = 0x2::table::borrow_mut<address, u64>(&mut arg0.table, arg1);
            *v0 = *v0 + 1;
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg0);
        let v1 = Presale{
            id                      : v0,
            open                    : true,
            target_usd              : 6000000,
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
        let v3 = ReferralMap{
            id    : 0x2::object::new(arg0),
            table : 0x2::table::new<address, u64>(arg0),
        };
        0x2::transfer::share_object<ReferralMap>(v3);
    }

    public entry fun init_presale(arg0: &PresaleOwnerCap, arg1: &mut Presale, arg2: &0xe64012786406e76306b3a56841772673a6ee9a9f69c70e431d1f051e39681b1e::seed_presale_contract::Presale) {
        arg1.total_raised_amount_usd = arg1.total_raised_amount_usd + 0xe64012786406e76306b3a56841772673a6ee9a9f69c70e431d1f051e39681b1e::seed_presale_contract::get_total_raised_amount_usd(arg2);
    }

    public entry fun mint_by_admin(arg0: &PresaleOwnerCap, arg1: &mut Presale, arg2: u128, arg3: vector<u8>, arg4: vector<u8>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        arg1.total_raised_amount_usd = arg1.total_raised_amount_usd + arg2;
        0x9ac9960933ef2266d1e19f275e5b8bd76033e704e8cc3faacf7ad69ba3e212cd::chest::mint_to(arg5, arg3, arg4, arg2, arg6);
    }

    public fun mint_from_migration(arg0: &mut Presale, arg1: u128, arg2: &mut vector<0xe64012786406e76306b3a56841772673a6ee9a9f69c70e431d1f051e39681b1e::seed_presale_contract::Receipt>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: &0x9ac9960933ef2266d1e19f275e5b8bd76033e704e8cc3faacf7ad69ba3e212cd::verifier::PubKey, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x9ac9960933ef2266d1e19f275e5b8bd76033e704e8cc3faacf7ad69ba3e212cd::verifier::verify_signature(arg6, arg1, arg3, arg4, arg5) == true, 3);
    }

    public entry fun mint_with_sui(arg0: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg1: &mut Presale, arg2: &mut ReferralMap, arg3: 0x1::option::Option<address>, arg4: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg5: u64, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: &0x9ac9960933ef2266d1e19f275e5b8bd76033e704e8cc3faacf7ad69ba3e212cd::verifier::PubKey, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x9ac9960933ef2266d1e19f275e5b8bd76033e704e8cc3faacf7ad69ba3e212cd::verifier::verify_signature(arg9, (arg5 as u128), arg6, arg7, arg8) == true, 3);
        if (0x1::option::is_some<address>(&arg3)) {
            handle_referrer(arg2, *0x1::option::borrow<address>(&arg3));
        };
        let v0 = handle_invest_sui(arg0, arg1, arg4, arg5, arg10);
        0x9ac9960933ef2266d1e19f275e5b8bd76033e704e8cc3faacf7ad69ba3e212cd::chest::mint_to(0x2::tx_context::sender(arg10), arg6, arg7, v0, arg10);
    }

    public entry fun mint_with_usdc(arg0: &mut Presale, arg1: &mut ReferralMap, arg2: 0x1::option::Option<address>, arg3: &mut 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg4: u64, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: &0x9ac9960933ef2266d1e19f275e5b8bd76033e704e8cc3faacf7ad69ba3e212cd::verifier::PubKey, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x9ac9960933ef2266d1e19f275e5b8bd76033e704e8cc3faacf7ad69ba3e212cd::verifier::verify_signature(arg8, (arg4 as u128), arg5, arg6, arg7) == true, 3);
        if (0x1::option::is_some<address>(&arg2)) {
            handle_referrer(arg1, *0x1::option::borrow<address>(&arg2));
        };
        let v0 = handle_invest_usdc(arg0, arg3, arg4, arg9);
        0x9ac9960933ef2266d1e19f275e5b8bd76033e704e8cc3faacf7ad69ba3e212cd::chest::mint_to(0x2::tx_context::sender(arg9), arg5, arg6, v0, arg9);
    }

    public fun summon(arg0: &mut vector<0x9ac9960933ef2266d1e19f275e5b8bd76033e704e8cc3faacf7ad69ba3e212cd::chest::AllocationNFT>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x9ac9960933ef2266d1e19f275e5b8bd76033e704e8cc3faacf7ad69ba3e212cd::verifier::PubKey, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (!0x1::vector::is_empty<0x9ac9960933ef2266d1e19f275e5b8bd76033e704e8cc3faacf7ad69ba3e212cd::chest::AllocationNFT>(arg0)) {
            let v1 = 0x1::vector::pop_back<0x9ac9960933ef2266d1e19f275e5b8bd76033e704e8cc3faacf7ad69ba3e212cd::chest::AllocationNFT>(arg0);
            v0 = v0 + 0x9ac9960933ef2266d1e19f275e5b8bd76033e704e8cc3faacf7ad69ba3e212cd::chest::invested_amount_of(&v1);
            0x9ac9960933ef2266d1e19f275e5b8bd76033e704e8cc3faacf7ad69ba3e212cd::chest::burn(v1, arg5);
        };
        assert!(0x9ac9960933ef2266d1e19f275e5b8bd76033e704e8cc3faacf7ad69ba3e212cd::verifier::verify_signature(arg4, v0, arg1, arg2, arg3) == true, 3);
        0x9ac9960933ef2266d1e19f275e5b8bd76033e704e8cc3faacf7ad69ba3e212cd::chest::mint_to(0x2::tx_context::sender(arg5), arg1, arg2, v0, arg5);
    }

    public fun validate_chest_uri(arg0: u128, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x9ac9960933ef2266d1e19f275e5b8bd76033e704e8cc3faacf7ad69ba3e212cd::verifier::PubKey, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x9ac9960933ef2266d1e19f275e5b8bd76033e704e8cc3faacf7ad69ba3e212cd::verifier::verify_signature(arg4, arg0, arg1, arg2, arg3) == true, 3);
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

