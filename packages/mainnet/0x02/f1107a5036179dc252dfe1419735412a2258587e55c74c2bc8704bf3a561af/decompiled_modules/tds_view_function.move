module 0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::tds_view_function {
    struct DepositShare has drop {
        index: u64,
        active_share: u64,
        deactivating_share: u64,
        inactive_share: u64,
        warmup_share: u64,
        premium_share: u64,
        incentive_share: u64,
    }

    public(friend) fun get_auction_bcs(arg0: &0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::Registry, arg1: vector<u64>) : vector<vector<u8>> {
        let (_, v1, _, _, _, _, v6, _, _, _, _, _) = 0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::get_registry_inner(arg0);
        let v12 = 0x1::vector::empty<vector<u8>>();
        if (0x1::vector::is_empty<u64>(&arg1)) {
            let v13 = 0;
            while (v13 < *v1) {
                if (0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::auction_exists(v6, v13)) {
                    0x1::vector::push_back<vector<u8>>(&mut v12, 0x1::bcs::to_bytes<0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::dutch::Auction>(0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::get_auction(v6, v13)));
                };
                v13 = v13 + 1;
            };
        } else {
            while (!0x1::vector::is_empty<u64>(&arg1)) {
                let v14 = 0x1::vector::pop_back<u64>(&mut arg1);
                if (0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::auction_exists(v6, v14)) {
                    0x1::vector::push_back<vector<u8>>(&mut v12, 0x1::bcs::to_bytes<0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::dutch::Auction>(0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::get_auction(v6, v14)));
                };
            };
        };
        v12
    }

    public(friend) fun get_auction_bids_bcs(arg0: &0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::Registry, arg1: u64) : vector<vector<u8>> {
        let (_, _, _, _, _, _, v6, _, _, _, _, _) = 0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::get_registry_inner(arg0);
        let v12 = 0x1::vector::empty<vector<u8>>();
        if (0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::auction_exists(v6, arg1)) {
            let v13 = 0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::dutch::bids(0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::get_auction(v6, arg1));
            let v14 = 0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::big_vector::length<0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::dutch::Bid>(v13);
            let v15 = 0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::big_vector::slice_size<0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::dutch::Bid>(v13);
            let v16 = 0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::big_vector::borrow_slice<0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::dutch::Bid>(v13, 1);
            let v17 = 0;
            while (v17 < v14) {
                0x1::vector::push_back<vector<u8>>(&mut v12, 0x1::bcs::to_bytes<0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::dutch::Bid>(0x1::vector::borrow<0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::dutch::Bid>(v16, v17 % v15)));
                if (v17 + 1 < v14 && (v17 + 1) % v15 == 0) {
                    v16 = 0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::big_vector::borrow_slice<0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::dutch::Bid>(v13, 0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::big_vector::slice_id<0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::dutch::Bid>(v13, v17 + 1));
                };
                v17 = v17 + 1;
            };
        };
        v12
    }

    public(friend) fun get_deposit_shares_bcs(arg0: &0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::Registry, arg1: vector<0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::vault::TypusDepositReceipt>) : vector<vector<u8>> {
        let (_, _, _, _, _, v5, _, _, _, _, _, _) = 0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::get_registry_inner(arg0);
        let v12 = 0x1::vector::empty<vector<u8>>();
        while (!0x1::vector::is_empty<0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::vault::TypusDepositReceipt>(&arg1)) {
            let v13 = 0x1::vector::empty<0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::vault::TypusDepositReceipt>();
            let v14 = 0x1::vector::pop_back<0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::vault::TypusDepositReceipt>(&mut arg1);
            let v15 = 0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::vault::get_deposit_receipt_index(&v14);
            0x1::vector::push_back<0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::vault::TypusDepositReceipt>(&mut v13, v14);
            while (!0x1::vector::is_empty<0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::vault::TypusDepositReceipt>(&arg1)) {
                if (0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::vault::get_deposit_receipt_index(0x1::vector::borrow<0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::vault::TypusDepositReceipt>(&arg1, 0x1::vector::length<0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::vault::TypusDepositReceipt>(&arg1) - 1)) != v15) {
                    break
                };
                0x1::vector::push_back<0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::vault::TypusDepositReceipt>(&mut v13, 0x1::vector::pop_back<0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::vault::TypusDepositReceipt>(&mut arg1));
            };
            let (v16, v17, v18, v19, v20, v21) = 0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::vault::summarize_deposit_shares(0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::get_deposit_vault(v5, v15), v13);
            let v22 = DepositShare{
                index              : v15,
                active_share       : v16,
                deactivating_share : v17,
                inactive_share     : v18,
                warmup_share       : v19,
                premium_share      : v20,
                incentive_share    : v21,
            };
            0x1::vector::push_back<vector<u8>>(&mut v12, 0x1::bcs::to_bytes<DepositShare>(&v22));
        };
        0x1::vector::destroy_empty<0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::vault::TypusDepositReceipt>(arg1);
        v12
    }

    public(friend) fun get_my_bids_bcs(arg0: &0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::Registry, arg1: vector<0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::vault::TypusBidReceipt>) : vector<vector<u8>> {
        let (_, _, _, _, _, _, _, v7, _, _, _, _) = 0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::get_registry_inner(arg0);
        let v12 = 0x1::vector::empty<vector<u8>>();
        while (!0x1::vector::is_empty<0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::vault::TypusBidReceipt>(&arg1)) {
            let v13 = 0x1::vector::empty<0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::vault::TypusBidReceipt>();
            let v14 = 0x1::vector::pop_back<0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::vault::TypusBidReceipt>(&mut arg1);
            let (v15, v16, _) = 0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::vault::get_bid_receipt_info(&v14);
            let v18 = v15;
            0x1::vector::push_back<0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::vault::TypusBidReceipt>(&mut v13, v14);
            while (!0x1::vector::is_empty<0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::vault::TypusBidReceipt>(&arg1)) {
                let (v19, v20, _) = 0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::vault::get_bid_receipt_info(0x1::vector::borrow<0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::vault::TypusBidReceipt>(&arg1, 0x1::vector::length<0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::vault::TypusBidReceipt>(&arg1) - 1));
                if (v19 != v18 || v20 != v16) {
                    break
                };
                0x1::vector::push_back<0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::vault::TypusBidReceipt>(&mut v13, 0x1::vector::pop_back<0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::vault::TypusBidReceipt>(&mut arg1));
            };
            let v22 = 0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::get_bid_vault_by_id_or_index(v7, &v18, v16);
            let v23 = 0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::vault::summarize_bid_shares(v22, v13);
            let v24 = 0x1::bcs::to_bytes<0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::vault::BidVault>(v22);
            0x1::vector::append<u8>(&mut v24, 0x1::bcs::to_bytes<u64>(&v23));
            0x1::vector::push_back<vector<u8>>(&mut v12, v24);
        };
        0x1::vector::destroy_empty<0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::vault::TypusBidReceipt>(arg1);
        v12
    }

    public(friend) fun get_refund_shares_bcs<T0>(arg0: &0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::Registry, arg1: &0x2::tx_context::TxContext) : vector<u8> {
        let (_, _, _, _, _, _, _, _, v8, _, _, _) = 0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::get_registry_inner(arg0);
        let v12 = 0x1::type_name::get<T0>();
        let v13 = 0x1::bcs::to_bytes<0x1::type_name::TypeName>(&v12);
        let v14 = if (0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::refund_vault_exists<T0>(v8)) {
            0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::vault::get_refund_share(0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::get_refund_vault<T0>(v8), 0x2::tx_context::sender(arg1))
        } else {
            0
        };
        let v15 = v14;
        0x1::vector::append<u8>(&mut v13, 0x1::bcs::to_bytes<u64>(&v15));
        v13
    }

    public(friend) fun get_vault_data_bcs(arg0: &0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::Registry, arg1: vector<u64>) : vector<vector<u8>> {
        let (_, v1, _, _, v4, v5, _, _, _, _, _, _) = 0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::get_registry_inner(arg0);
        let v12 = 0x1::vector::empty<vector<u8>>();
        if (0x1::vector::is_empty<u64>(&arg1)) {
            let v13 = 0;
            while (v13 < *v1) {
                if (0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::portfolio_vault_exists(v4, v13)) {
                    let v14 = 0x1::vector::empty<u8>();
                    0x1::vector::append<u8>(&mut v14, 0x1::bcs::to_bytes<0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::PortfolioVault>(0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::get_portfolio_vault(v4, v13)));
                    0x1::vector::append<u8>(&mut v14, 0x1::bcs::to_bytes<0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::vault::DepositVault>(0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::get_deposit_vault(v5, v13)));
                    0x1::vector::push_back<vector<u8>>(&mut v12, v14);
                };
                v13 = v13 + 1;
            };
        } else {
            while (!0x1::vector::is_empty<u64>(&arg1)) {
                let v15 = 0x1::vector::pop_back<u64>(&mut arg1);
                if (0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::portfolio_vault_exists(v4, v15)) {
                    let v16 = 0x1::vector::empty<u8>();
                    0x1::vector::append<u8>(&mut v16, 0x1::bcs::to_bytes<0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::PortfolioVault>(0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::get_portfolio_vault(v4, v15)));
                    0x1::vector::append<u8>(&mut v16, 0x1::bcs::to_bytes<0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::vault::DepositVault>(0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::get_deposit_vault(v5, v15)));
                    0x1::vector::push_back<vector<u8>>(&mut v12, v16);
                };
            };
        };
        v12
    }

    // decompiled from Move bytecode v6
}

