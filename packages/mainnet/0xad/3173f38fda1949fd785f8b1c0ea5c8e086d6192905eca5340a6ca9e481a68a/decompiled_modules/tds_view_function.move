module 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::tds_view_function {
    struct DepositShare has drop {
        index: u64,
        active_share: u64,
        deactivating_share: u64,
        inactive_share: u64,
        warmup_share: u64,
        premium_share: u64,
        incentive_share: u64,
    }

    public(friend) fun get_auction_bcs(arg0: &0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: vector<u64>) : vector<vector<u8>> {
        let (_, v1, _, _, _, _, v6, _, _, _, _, _) = 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::get_registry_inner(arg0);
        let v12 = 0x1::vector::empty<vector<u8>>();
        if (0x1::vector::is_empty<u64>(&arg1)) {
            let v13 = 0;
            while (v13 < *v1) {
                if (0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::auction_exists(v6, v13)) {
                    0x1::vector::push_back<vector<u8>>(&mut v12, 0x1::bcs::to_bytes<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::dutch::Auction>(0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::get_auction(v6, v13)));
                };
                v13 = v13 + 1;
            };
        } else {
            while (!0x1::vector::is_empty<u64>(&arg1)) {
                let v14 = 0x1::vector::pop_back<u64>(&mut arg1);
                if (0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::auction_exists(v6, v14)) {
                    0x1::vector::push_back<vector<u8>>(&mut v12, 0x1::bcs::to_bytes<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::dutch::Auction>(0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::get_auction(v6, v14)));
                };
            };
        };
        v12
    }

    public(friend) fun get_auction_bids_bcs(arg0: &0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: u64) : vector<vector<u8>> {
        let (_, _, _, _, _, _, v6, _, _, _, _, _) = 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::get_registry_inner(arg0);
        let v12 = 0x1::vector::empty<vector<u8>>();
        if (0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::auction_exists(v6, arg1)) {
            let v13 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::dutch::bids(0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::get_auction(v6, arg1));
            let v14 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::length<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::dutch::Bid>(v13);
            let v15 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::slice_size<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::dutch::Bid>(v13);
            let v16 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::borrow_slice<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::dutch::Bid>(v13, 1);
            let v17 = 0;
            while (v17 < v14) {
                0x1::vector::push_back<vector<u8>>(&mut v12, 0x1::bcs::to_bytes<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::dutch::Bid>(0x1::vector::borrow<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::dutch::Bid>(v16, v17 % v15)));
                if (v17 + 1 < v14 && (v17 + 1) % v15 == 0) {
                    v16 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::borrow_slice<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::dutch::Bid>(v13, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::slice_id<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::dutch::Bid>(v13, v17 + 1));
                };
                v17 = v17 + 1;
            };
        };
        v12
    }

    public(friend) fun get_deposit_shares_bcs(arg0: &0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: vector<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusDepositReceipt>, arg2: address) : vector<vector<u8>> {
        let (_, _, _, _, _, v5, _, _, _, v9, _, _) = 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::get_registry_inner(arg0);
        let v12 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v12, 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::get_deposit_snapshot_bcs(v9, arg2));
        while (!0x1::vector::is_empty<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusDepositReceipt>(&arg1)) {
            let v13 = 0x1::vector::empty<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusDepositReceipt>();
            let v14 = 0x1::vector::pop_back<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusDepositReceipt>(&mut arg1);
            let v15 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::get_deposit_receipt_index(&v14);
            0x1::vector::push_back<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusDepositReceipt>(&mut v13, v14);
            while (!0x1::vector::is_empty<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusDepositReceipt>(&arg1)) {
                if (0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::get_deposit_receipt_index(0x1::vector::borrow<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusDepositReceipt>(&arg1, 0x1::vector::length<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusDepositReceipt>(&arg1) - 1)) != v15) {
                    break
                };
                0x1::vector::push_back<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusDepositReceipt>(&mut v13, 0x1::vector::pop_back<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusDepositReceipt>(&mut arg1));
            };
            let (v16, v17, v18, v19, v20, v21) = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::summarize_deposit_shares(0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::get_deposit_vault(v5, v15), v13);
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
        0x1::vector::destroy_empty<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusDepositReceipt>(arg1);
        v12
    }

    public(friend) fun get_my_bids_bcs(arg0: &0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: vector<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>) : vector<vector<u8>> {
        let (_, _, _, _, _, _, _, v7, _, _, _, _) = 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::get_registry_inner(arg0);
        let v12 = 0x1::vector::empty<vector<u8>>();
        while (!0x1::vector::is_empty<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>(&arg1)) {
            let v13 = 0x1::vector::empty<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>();
            let v14 = 0x1::vector::pop_back<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>(&mut arg1);
            let (v15, v16, _) = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::get_bid_receipt_info(&v14);
            let v18 = v15;
            0x1::vector::push_back<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>(&mut v13, v14);
            while (!0x1::vector::is_empty<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>(&arg1)) {
                let (v19, v20, _) = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::get_bid_receipt_info(0x1::vector::borrow<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>(&arg1, 0x1::vector::length<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>(&arg1) - 1));
                if (v19 != v18 || v20 != v16) {
                    break
                };
                0x1::vector::push_back<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>(&mut v13, 0x1::vector::pop_back<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>(&mut arg1));
            };
            let v22 = 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::get_bid_vault_by_id_or_index(v7, &v18, v16);
            let v23 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::summarize_bid_shares(v22, v13);
            let v24 = 0x1::bcs::to_bytes<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::BidVault>(v22);
            0x1::vector::append<u8>(&mut v24, 0x1::bcs::to_bytes<u64>(&v23));
            0x1::vector::push_back<vector<u8>>(&mut v12, v24);
        };
        0x1::vector::destroy_empty<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>(arg1);
        v12
    }

    public(friend) fun get_refund_shares_bcs<T0>(arg0: &0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: &0x2::tx_context::TxContext) : vector<u8> {
        let (_, _, _, _, _, _, _, _, v8, _, _, _) = 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::get_registry_inner(arg0);
        let v12 = 0x1::type_name::get<T0>();
        let v13 = 0x1::bcs::to_bytes<0x1::type_name::TypeName>(&v12);
        let v14 = if (0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::refund_vault_exists<T0>(v8)) {
            0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::get_refund_share(0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::get_refund_vault<T0>(v8), 0x2::tx_context::sender(arg1))
        } else {
            0
        };
        let v15 = v14;
        0x1::vector::append<u8>(&mut v13, 0x1::bcs::to_bytes<u64>(&v15));
        v13
    }

    public(friend) fun get_scallop_withdrawal_bcs<T0, T1>(arg0: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: u64, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg5: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::rewards_pool::RewardsPool<T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : vector<vector<u8>> {
        let v0 = 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::get_mut_scallop_spool_account<T0>(arg0, arg1);
        let v1 = 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::user::redeem_rewards<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>, T1>(arg4, arg5, v0, arg6, arg7);
        let v2 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T0>(arg2, arg3, 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::user::unstake<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(arg4, v0, 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::stake_amount<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(v0), arg6, arg7), arg6, arg7);
        let v3 = 0x1::vector::empty<vector<u8>>();
        let v4 = &mut v3;
        0x1::vector::push_back<vector<u8>>(v4, 0x1::bcs::to_bytes<0x2::coin::Coin<T0>>(&v2));
        0x1::vector::push_back<vector<u8>>(v4, 0x1::bcs::to_bytes<0x2::coin::Coin<T1>>(&v1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, @0xb90d6bddf3df46fc5590d412d062c00145dfae1d31446c0f206c61edf02ef5ba);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, @0xb90d6bddf3df46fc5590d412d062c00145dfae1d31446c0f206c61edf02ef5ba);
        v3
    }

    public(friend) fun get_vault_data_bcs(arg0: &0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: vector<u64>) : vector<vector<u8>> {
        let (_, v1, _, _, v4, v5, _, _, _, _, _, _) = 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::get_registry_inner(arg0);
        let v12 = 0x1::vector::empty<vector<u8>>();
        if (0x1::vector::is_empty<u64>(&arg1)) {
            let v13 = 0;
            while (v13 < *v1) {
                if (0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::portfolio_vault_exists(v4, v13)) {
                    let v14 = 0x1::vector::empty<u8>();
                    0x1::vector::append<u8>(&mut v14, 0x1::bcs::to_bytes<0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::PortfolioVault>(0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::get_portfolio_vault(v4, v13)));
                    0x1::vector::append<u8>(&mut v14, 0x1::bcs::to_bytes<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::DepositVault>(0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::get_deposit_vault(v5, v13)));
                    0x1::vector::push_back<vector<u8>>(&mut v12, v14);
                };
                v13 = v13 + 1;
            };
        } else {
            while (!0x1::vector::is_empty<u64>(&arg1)) {
                let v15 = 0x1::vector::pop_back<u64>(&mut arg1);
                if (0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::portfolio_vault_exists(v4, v15)) {
                    let v16 = 0x1::vector::empty<u8>();
                    0x1::vector::append<u8>(&mut v16, 0x1::bcs::to_bytes<0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::PortfolioVault>(0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::get_portfolio_vault(v4, v15)));
                    0x1::vector::append<u8>(&mut v16, 0x1::bcs::to_bytes<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::DepositVault>(0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::get_deposit_vault(v5, v15)));
                    0x1::vector::push_back<vector<u8>>(&mut v12, v16);
                };
            };
        };
        v12
    }

    // decompiled from Move bytecode v6
}

