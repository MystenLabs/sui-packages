module 0xe64012786406e76306b3a56841772673a6ee9a9f69c70e431d1f051e39681b1e::seed_presale_contract_v2 {
    public entry fun mint_by_admin(arg0: &0xe64012786406e76306b3a56841772673a6ee9a9f69c70e431d1f051e39681b1e::seed_presale_contract::PresaleOwnerCap, arg1: &mut 0xe64012786406e76306b3a56841772673a6ee9a9f69c70e431d1f051e39681b1e::seed_presale_contract::Presale, arg2: u128, arg3: vector<u8>, arg4: vector<u8>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        0xe64012786406e76306b3a56841772673a6ee9a9f69c70e431d1f051e39681b1e::seed_presale_contract::add_funds_to_presale_callable(arg1, arg2);
        0xe64012786406e76306b3a56841772673a6ee9a9f69c70e431d1f051e39681b1e::alloc_nft_collection::mint_to(arg5, arg3, arg4, arg2, arg6);
    }

    public fun mint_from_migration(arg0: &mut 0xe64012786406e76306b3a56841772673a6ee9a9f69c70e431d1f051e39681b1e::seed_presale_contract::Presale, arg1: u128, arg2: &mut vector<0xe64012786406e76306b3a56841772673a6ee9a9f69c70e431d1f051e39681b1e::seed_presale_contract::Receipt>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: &0xe64012786406e76306b3a56841772673a6ee9a9f69c70e431d1f051e39681b1e::msm::PubKey, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0xe64012786406e76306b3a56841772673a6ee9a9f69c70e431d1f051e39681b1e::msm::verify_signature(arg6, arg1, arg3, arg4, arg5) == true, 3);
        0xe64012786406e76306b3a56841772673a6ee9a9f69c70e431d1f051e39681b1e::seed_presale_contract::add_funds_to_presale_callable(arg0, arg1);
        0xe64012786406e76306b3a56841772673a6ee9a9f69c70e431d1f051e39681b1e::alloc_nft_collection::mint_to(0x2::tx_context::sender(arg7), arg3, arg4, arg1, arg7);
        while (!0x1::vector::is_empty<0xe64012786406e76306b3a56841772673a6ee9a9f69c70e431d1f051e39681b1e::seed_presale_contract::Receipt>(arg2)) {
            0xe64012786406e76306b3a56841772673a6ee9a9f69c70e431d1f051e39681b1e::seed_presale_contract::burn_receipt_callable(0x1::vector::pop_back<0xe64012786406e76306b3a56841772673a6ee9a9f69c70e431d1f051e39681b1e::seed_presale_contract::Receipt>(arg2), arg7);
        };
    }

    public entry fun mint_with_sui(arg0: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg1: &mut 0xe64012786406e76306b3a56841772673a6ee9a9f69c70e431d1f051e39681b1e::seed_presale_contract::Presale, arg2: &mut 0xe64012786406e76306b3a56841772673a6ee9a9f69c70e431d1f051e39681b1e::seed_presale_contract::ReferralMap, arg3: 0x1::option::Option<address>, arg4: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg5: u64, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: &0xe64012786406e76306b3a56841772673a6ee9a9f69c70e431d1f051e39681b1e::msm::PubKey, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0xe64012786406e76306b3a56841772673a6ee9a9f69c70e431d1f051e39681b1e::msm::verify_signature(arg9, (arg5 as u128), arg6, arg7, arg8) == true, 3);
        if (0x1::option::is_some<address>(&arg3)) {
            0xe64012786406e76306b3a56841772673a6ee9a9f69c70e431d1f051e39681b1e::seed_presale_contract::handle_referrer_callable(arg2, *0x1::option::borrow<address>(&arg3));
        };
        0xe64012786406e76306b3a56841772673a6ee9a9f69c70e431d1f051e39681b1e::alloc_nft_collection::mint_to(0x2::tx_context::sender(arg10), arg6, arg7, 0xe64012786406e76306b3a56841772673a6ee9a9f69c70e431d1f051e39681b1e::seed_presale_contract::handle_sui_invest_callable(arg0, arg1, arg4, arg5, arg10), arg10);
    }

    public entry fun mint_with_usdc(arg0: &mut 0xe64012786406e76306b3a56841772673a6ee9a9f69c70e431d1f051e39681b1e::seed_presale_contract::Presale, arg1: &mut 0xe64012786406e76306b3a56841772673a6ee9a9f69c70e431d1f051e39681b1e::seed_presale_contract::ReferralMap, arg2: 0x1::option::Option<address>, arg3: &mut 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg4: u64, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: &0xe64012786406e76306b3a56841772673a6ee9a9f69c70e431d1f051e39681b1e::msm::PubKey, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0xe64012786406e76306b3a56841772673a6ee9a9f69c70e431d1f051e39681b1e::msm::verify_signature(arg8, (arg4 as u128), arg5, arg6, arg7) == true, 3);
        if (0x1::option::is_some<address>(&arg2)) {
            0xe64012786406e76306b3a56841772673a6ee9a9f69c70e431d1f051e39681b1e::seed_presale_contract::handle_referrer_callable(arg1, *0x1::option::borrow<address>(&arg2));
        };
        0xe64012786406e76306b3a56841772673a6ee9a9f69c70e431d1f051e39681b1e::alloc_nft_collection::mint_to(0x2::tx_context::sender(arg9), arg5, arg6, 0xe64012786406e76306b3a56841772673a6ee9a9f69c70e431d1f051e39681b1e::seed_presale_contract::handle_usdc_invest_callable(arg0, arg3, arg4, arg9), arg9);
    }

    public fun summon(arg0: &mut vector<0xe64012786406e76306b3a56841772673a6ee9a9f69c70e431d1f051e39681b1e::alloc_nft_collection::AllocationNFT>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0xe64012786406e76306b3a56841772673a6ee9a9f69c70e431d1f051e39681b1e::msm::PubKey, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (!0x1::vector::is_empty<0xe64012786406e76306b3a56841772673a6ee9a9f69c70e431d1f051e39681b1e::alloc_nft_collection::AllocationNFT>(arg0)) {
            let v1 = 0x1::vector::pop_back<0xe64012786406e76306b3a56841772673a6ee9a9f69c70e431d1f051e39681b1e::alloc_nft_collection::AllocationNFT>(arg0);
            v0 = v0 + 0xe64012786406e76306b3a56841772673a6ee9a9f69c70e431d1f051e39681b1e::alloc_nft_collection::amount_invested(&v1);
            0xe64012786406e76306b3a56841772673a6ee9a9f69c70e431d1f051e39681b1e::alloc_nft_collection::burn(v1, arg5);
        };
        assert!(0xe64012786406e76306b3a56841772673a6ee9a9f69c70e431d1f051e39681b1e::msm::verify_signature(arg4, v0, arg1, arg2, arg3) == true, 3);
        0xe64012786406e76306b3a56841772673a6ee9a9f69c70e431d1f051e39681b1e::alloc_nft_collection::mint_to(0x2::tx_context::sender(arg5), arg1, arg2, v0, arg5);
    }

    // decompiled from Move bytecode v6
}

