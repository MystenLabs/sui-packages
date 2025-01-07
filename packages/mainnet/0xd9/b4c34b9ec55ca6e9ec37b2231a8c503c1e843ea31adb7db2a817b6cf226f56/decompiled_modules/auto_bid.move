module 0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::auto_bid {
    struct StrategyPoolV2 has store, key {
        id: 0x2::object::UID,
        strategies: 0x2::vec_map::VecMap<u64, 0x2::vec_map::VecMap<u64, 0x2::table_vec::TableVec<StrategyV2>>>,
        authority: vector<address>,
    }

    struct StrategyV2 has store, key {
        id: 0x2::object::UID,
        vault_index: u64,
        signal_index: u64,
        user: address,
        price_percentage: u64,
        size: u64,
        max_times: u64,
        target_rounds: vector<u64>,
        receipts: vector<0x342ef9f26e4e9c13c7b0031b2bd323455e7b2fc6de6fa366c6ce5fe76c4c7cb1::vault::TypusBidReceipt>,
        active: bool,
        u64_padding: vector<u64>,
        bid_times: u64,
        bid_round: u64,
        bid_ts_ms: u64,
        bid_rounds: vector<u64>,
        accumulated_profit: u64,
    }

    struct NewStrategyPoolEvent has copy, drop {
        id: 0x2::object::ID,
        signer: address,
    }

    struct AddAuthorutyEvent has copy, drop {
        new_authority: address,
        signer: address,
    }

    struct NewStrategyVaultEvent has copy, drop {
        id: 0x2::object::ID,
        vault_index: u64,
        signer: address,
    }

    struct NewStrategySignalEvent has copy, drop {
        id: 0x2::object::ID,
        vault_index: u64,
        signal_index: u64,
        signer: address,
    }

    struct NewStrategyEventV2 has copy, drop {
        vault_index: u64,
        signal_index: u64,
        user: address,
        price_percentage: u64,
        size: u64,
        max_times: u64,
        target_rounds: vector<u64>,
        deposit_amount: u64,
    }

    struct UpdateStrategyEvent has copy, drop {
        vault_index: u64,
        signal_index: u64,
        strategy_index: u64,
        user: address,
        price_percentage: u64,
        size: u64,
        max_times: u64,
        target_rounds: vector<u64>,
        deposit_amount: u64,
    }

    struct CloseStrategyEventV2 has copy, drop {
        vault_index: u64,
        signal_index: u64,
        user: address,
        price_percentage: u64,
        size: u64,
        max_times: u64,
        target_rounds: vector<u64>,
        u64_padding: vector<u64>,
        bid_times: u64,
        bid_round: u64,
        bid_ts_ms: u64,
        bid_rounds: vector<u64>,
        accumulated_profit: u64,
    }

    struct WithdrawProfitEvent has copy, drop {
        vault_index: u64,
        signal_index: u64,
        strategy_index: u64,
        user: address,
        profit: u64,
    }

    struct Strategy has store, key {
        id: 0x2::object::UID,
        vault_index: u64,
        signal_index: u64,
        user: address,
        price_percentage: u64,
        size: u64,
        max_times: u64,
        target_rounds: vector<u64>,
        receipts: vector<0x342ef9f26e4e9c13c7b0031b2bd323455e7b2fc6de6fa366c6ce5fe76c4c7cb1::vault::TypusBidReceipt>,
        active: bool,
        u64_padding: vector<u64>,
        bid_times: u64,
        bid_round: u64,
        bid_ts_ms: u64,
    }

    struct StrategyPool has store, key {
        id: 0x2::object::UID,
        strategies: 0x2::vec_map::VecMap<u64, 0x2::vec_map::VecMap<u64, 0x2::table_vec::TableVec<Strategy>>>,
        authority: vector<address>,
    }

    struct CloseStrategyEvent has copy, drop {
        vault_index: u64,
        signal_index: u64,
        user: address,
        price_percentage: u64,
        size: u64,
        max_times: u64,
        target_rounds: vector<u64>,
        u64_padding: vector<u64>,
        bid_times: u64,
        bid_round: u64,
        bid_ts_ms: u64,
    }

    struct NewStrategyEvent has copy, drop {
        vault_index: u64,
        signal_index: u64,
        user: address,
        price_percentage: u64,
        size: u64,
        max_times: u64,
        target_rounds: vector<u64>,
    }

    struct AutoBidEvent has copy, drop {
        dummy_field: bool,
    }

    entry fun add_authority(arg0: &mut StrategyPoolV2, arg1: address, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        0x1::vector::contains<address>(&arg0.authority, &v0);
        0x1::vector::push_back<address>(&mut arg0.authority, arg1);
        let v1 = AddAuthorutyEvent{
            new_authority : arg1,
            signer        : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<AddAuthorutyEvent>(v1);
    }

    public fun close_strategy<T0, T1>(arg0: &0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::Registry, arg1: &mut StrategyPoolV2, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::version_check(arg0);
        0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::operation_check(arg0);
        0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::portfolio_vault_token_check<T0, T1>(arg0, arg2);
        let v0 = 0x2::vec_map::get_mut<u64, 0x2::table_vec::TableVec<StrategyV2>>(0x2::vec_map::get_mut<u64, 0x2::vec_map::VecMap<u64, 0x2::table_vec::TableVec<StrategyV2>>>(&mut arg1.strategies, &arg2), &arg3);
        let (v1, v2, v3) = close_strategy_<T0, T1>(v0, arg4, arg5);
        assert!(v3 == 0x2::tx_context::sender(arg5), 0);
        assert!(0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::tails_staking::get_staked_level(arg0, v3) > 0, 1);
        (v1, v2)
    }

    fun close_strategy_<T0, T1>(arg0: &mut 0x2::table_vec::TableVec<StrategyV2>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, address) {
        let v0 = 0x2::table_vec::swap_remove<StrategyV2>(arg0, arg1);
        let v1 = &mut v0;
        update_u64_padding<T0, T1>(v1);
        let StrategyV2 {
            id                 : v2,
            vault_index        : v3,
            signal_index       : v4,
            user               : v5,
            price_percentage   : v6,
            size               : v7,
            max_times          : v8,
            target_rounds      : v9,
            receipts           : v10,
            active             : _,
            u64_padding        : v12,
            bid_times          : v13,
            bid_round          : v14,
            bid_ts_ms          : v15,
            bid_rounds         : v16,
            accumulated_profit : v17,
        } = v0;
        let v18 = v10;
        while (!0x1::vector::is_empty<0x342ef9f26e4e9c13c7b0031b2bd323455e7b2fc6de6fa366c6ce5fe76c4c7cb1::vault::TypusBidReceipt>(&v18)) {
            0x2::transfer::public_transfer<0x342ef9f26e4e9c13c7b0031b2bd323455e7b2fc6de6fa366c6ce5fe76c4c7cb1::vault::TypusBidReceipt>(0x1::vector::pop_back<0x342ef9f26e4e9c13c7b0031b2bd323455e7b2fc6de6fa366c6ce5fe76c4c7cb1::vault::TypusBidReceipt>(&mut v18), v5);
        };
        0x1::vector::destroy_empty<0x342ef9f26e4e9c13c7b0031b2bd323455e7b2fc6de6fa366c6ce5fe76c4c7cb1::vault::TypusBidReceipt>(v18);
        0x2::object::delete(v2);
        let v19 = CloseStrategyEventV2{
            vault_index        : v3,
            signal_index       : v4,
            user               : v5,
            price_percentage   : v6,
            size               : v7,
            max_times          : v8,
            target_rounds      : v9,
            u64_padding        : v12,
            bid_times          : v13,
            bid_round          : v14,
            bid_ts_ms          : v15,
            bid_rounds         : v16,
            accumulated_profit : v17,
        };
        0x2::event::emit<CloseStrategyEventV2>(v19);
        (0x2::coin::from_balance<T0>(0x2::dynamic_field::remove<0x1::string::String, 0x2::balance::Balance<T0>>(&mut v0.id, 0x1::string::utf8(b"profit")), arg2), 0x2::coin::from_balance<T1>(0x2::dynamic_field::remove<0x1::string::String, 0x2::balance::Balance<T1>>(&mut v0.id, 0x1::string::utf8(b"balance")), arg2), v5)
    }

    entry fun close_strategy_vault<T0, T1>(arg0: &0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::Registry, arg1: &mut StrategyPoolV2, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        0x1::vector::contains<address>(&arg1.authority, &v0);
        0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::version_check(arg0);
        0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::operation_check(arg0);
        0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::portfolio_vault_token_check<T0, T1>(arg0, arg2);
        let (_, v2) = 0x2::vec_map::remove<u64, 0x2::vec_map::VecMap<u64, 0x2::table_vec::TableVec<StrategyV2>>>(&mut arg1.strategies, &arg2);
        let v3 = v2;
        let v4 = 0x2::vec_map::keys<u64, 0x2::table_vec::TableVec<StrategyV2>>(&v3);
        while (!0x1::vector::is_empty<u64>(&v4)) {
            let v5 = 0x1::vector::pop_back<u64>(&mut v4);
            let (_, v7) = 0x2::vec_map::remove<u64, 0x2::table_vec::TableVec<StrategyV2>>(&mut v3, &v5);
            let v8 = v7;
            let v9 = 0;
            while (v9 < 0x2::table_vec::length<StrategyV2>(&v8)) {
                let v10 = &mut v8;
                let (v11, v12, v13) = close_strategy_<T0, T1>(v10, v9, arg3);
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v11, v13);
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v12, v13);
                v9 = v9 + 1;
            };
            0x2::table_vec::destroy_empty<StrategyV2>(v8);
        };
        0x2::vec_map::destroy_empty<u64, 0x2::table_vec::TableVec<StrategyV2>>(v3);
    }

    entry fun exercise<T0, T1>(arg0: &mut 0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::Registry, arg1: &mut StrategyPoolV2, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        0x1::vector::contains<address>(&arg1.authority, &v0);
        0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::version_check(arg0);
        0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::operation_check(arg0);
        0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::portfolio_vault_token_check<T0, T1>(arg0, arg2);
        let (_, _, _, _, v5, _, _, v8, _, _, _, _) = 0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::get_mut_registry_inner(arg0);
        let v13 = 0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::get_portfolio_vault(v5, arg2);
        let v14 = 0x2::vec_map::get_mut<u64, 0x2::table_vec::TableVec<StrategyV2>>(0x2::vec_map::get_mut<u64, 0x2::vec_map::VecMap<u64, 0x2::table_vec::TableVec<StrategyV2>>>(&mut arg1.strategies, &arg2), &arg3);
        let v15 = 0x2::table_vec::length<StrategyV2>(v14);
        let v16 = 0x2::object::id<0x342ef9f26e4e9c13c7b0031b2bd323455e7b2fc6de6fa366c6ce5fe76c4c7cb1::vault::BidVault>(0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::get_bid_vault(v8, arg2));
        let v17 = v16;
        let v18 = 0;
        while (v18 < v15) {
            let v19 = 0x2::table_vec::borrow<StrategyV2>(v14, v18);
            if (!0x1::vector::is_empty<0x342ef9f26e4e9c13c7b0031b2bd323455e7b2fc6de6fa366c6ce5fe76c4c7cb1::vault::TypusBidReceipt>(&v19.receipts)) {
                let v20 = 0;
                while (v20 < 0x1::vector::length<0x342ef9f26e4e9c13c7b0031b2bd323455e7b2fc6de6fa366c6ce5fe76c4c7cb1::vault::TypusBidReceipt>(&v19.receipts)) {
                    let v21 = 0x342ef9f26e4e9c13c7b0031b2bd323455e7b2fc6de6fa366c6ce5fe76c4c7cb1::vault::get_bid_receipt_vid(0x1::vector::borrow<0x342ef9f26e4e9c13c7b0031b2bd323455e7b2fc6de6fa366c6ce5fe76c4c7cb1::vault::TypusBidReceipt>(&v19.receipts, v20));
                    if (v21 != v16) {
                        v17 = v21;
                        break
                    };
                    v20 = v20 + 1;
                };
                if (v17 != v16) {
                    break
                };
            };
            v18 = v18 + 1;
        };
        let v22 = 0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::get_mut_bid_vault_by_id(v8, &v17);
        let v23 = 0;
        while (v23 < v15) {
            let v24 = 0x2::table_vec::borrow_mut<StrategyV2>(v14, v23);
            if (!0x1::vector::is_empty<0x342ef9f26e4e9c13c7b0031b2bd323455e7b2fc6de6fa366c6ce5fe76c4c7cb1::vault::TypusBidReceipt>(&v24.receipts)) {
                let v25 = 0x1::vector::empty<0x342ef9f26e4e9c13c7b0031b2bd323455e7b2fc6de6fa366c6ce5fe76c4c7cb1::vault::TypusBidReceipt>();
                let v26 = 0;
                while (v26 < 0x1::vector::length<0x342ef9f26e4e9c13c7b0031b2bd323455e7b2fc6de6fa366c6ce5fe76c4c7cb1::vault::TypusBidReceipt>(&v24.receipts)) {
                    if (v17 == 0x342ef9f26e4e9c13c7b0031b2bd323455e7b2fc6de6fa366c6ce5fe76c4c7cb1::vault::get_bid_receipt_vid(0x1::vector::borrow<0x342ef9f26e4e9c13c7b0031b2bd323455e7b2fc6de6fa366c6ce5fe76c4c7cb1::vault::TypusBidReceipt>(&v24.receipts, v26))) {
                        0x1::vector::push_back<0x342ef9f26e4e9c13c7b0031b2bd323455e7b2fc6de6fa366c6ce5fe76c4c7cb1::vault::TypusBidReceipt>(&mut v25, 0x1::vector::remove<0x342ef9f26e4e9c13c7b0031b2bd323455e7b2fc6de6fa366c6ce5fe76c4c7cb1::vault::TypusBidReceipt>(&mut v24.receipts, v26));
                        break
                    };
                    v26 = v26 + 1;
                };
                if (!0x1::vector::is_empty<0x342ef9f26e4e9c13c7b0031b2bd323455e7b2fc6de6fa366c6ce5fe76c4c7cb1::vault::TypusBidReceipt>(&v25)) {
                    let (v27, v28, v29) = 0x342ef9f26e4e9c13c7b0031b2bd323455e7b2fc6de6fa366c6ce5fe76c4c7cb1::vault::delegate_exercise<T0>(v22, v25);
                    if (!0x2::dynamic_field::exists_<0x1::string::String>(&v24.id, 0x1::string::utf8(b"profit"))) {
                        0x2::dynamic_field::add<0x1::string::String, 0x2::balance::Balance<T0>>(&mut v24.id, 0x1::string::utf8(b"profit"), 0x2::balance::zero<T0>());
                    };
                    0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::balance::Balance<T0>>(&mut v24.id, 0x1::string::utf8(b"profit")), v29);
                    v24.accumulated_profit = v24.accumulated_profit + v27;
                    0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::emit_exercise_event(v13, v27, v28, 0x1::option::none<0x1::type_name::TypeName>(), 0, v24.user);
                    update_u64_padding<T0, T1>(v24);
                    let v30 = 0x1::vector::borrow_mut<u64>(&mut v24.u64_padding, 2);
                    *v30 = *v30 + (((0x342ef9f26e4e9c13c7b0031b2bd323455e7b2fc6de6fa366c6ce5fe76c4c7cb1::vault::get_bid_vault_u64_padding_value(v22, 1) as u128) * (v28 as u128) / (0x342ef9f26e4e9c13c7b0031b2bd323455e7b2fc6de6fa366c6ce5fe76c4c7cb1::utils::multiplier(0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::get_o_token_decimal(v13)) as u128)) as u64) * 11000 / 10000 * (10000 - 0x342ef9f26e4e9c13c7b0031b2bd323455e7b2fc6de6fa366c6ce5fe76c4c7cb1::vault::get_bid_vault_u64_padding_value(v22, 2)) / 10000;
                } else {
                    0x1::vector::destroy_empty<0x342ef9f26e4e9c13c7b0031b2bd323455e7b2fc6de6fa366c6ce5fe76c4c7cb1::vault::TypusBidReceipt>(v25);
                };
            };
            v23 = v23 + 1;
        };
    }

    entry fun exercise_single<T0, T1>(arg0: &mut 0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::Registry, arg1: &mut StrategyPoolV2, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        0x1::vector::contains<address>(&arg1.authority, &v0);
        0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::version_check(arg0);
        0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::operation_check(arg0);
        0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::portfolio_vault_token_check<T0, T1>(arg0, arg2);
        let (_, _, _, _, v5, _, _, v8, _, _, _, _) = 0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::get_mut_registry_inner(arg0);
        let v13 = 0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::get_portfolio_vault(v5, arg2);
        let v14 = 0x2::table_vec::borrow_mut<StrategyV2>(0x2::vec_map::get_mut<u64, 0x2::table_vec::TableVec<StrategyV2>>(0x2::vec_map::get_mut<u64, 0x2::vec_map::VecMap<u64, 0x2::table_vec::TableVec<StrategyV2>>>(&mut arg1.strategies, &arg2), &arg3), arg4);
        if (!0x1::vector::is_empty<0x342ef9f26e4e9c13c7b0031b2bd323455e7b2fc6de6fa366c6ce5fe76c4c7cb1::vault::TypusBidReceipt>(&v14.receipts)) {
            let v15 = 0;
            let v16 = 0x1::vector::length<0x342ef9f26e4e9c13c7b0031b2bd323455e7b2fc6de6fa366c6ce5fe76c4c7cb1::vault::TypusBidReceipt>(&v14.receipts);
            while (v15 < v16) {
                let v17 = 0x342ef9f26e4e9c13c7b0031b2bd323455e7b2fc6de6fa366c6ce5fe76c4c7cb1::vault::get_bid_receipt_vid(0x1::vector::borrow<0x342ef9f26e4e9c13c7b0031b2bd323455e7b2fc6de6fa366c6ce5fe76c4c7cb1::vault::TypusBidReceipt>(&v14.receipts, v15));
                if (v17 != 0x2::object::id<0x342ef9f26e4e9c13c7b0031b2bd323455e7b2fc6de6fa366c6ce5fe76c4c7cb1::vault::BidVault>(0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::get_bid_vault(v8, arg2))) {
                    let v18 = 0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::get_mut_bid_vault_by_id(v8, &v17);
                    let v19 = 0x1::vector::empty<0x342ef9f26e4e9c13c7b0031b2bd323455e7b2fc6de6fa366c6ce5fe76c4c7cb1::vault::TypusBidReceipt>();
                    0x1::vector::push_back<0x342ef9f26e4e9c13c7b0031b2bd323455e7b2fc6de6fa366c6ce5fe76c4c7cb1::vault::TypusBidReceipt>(&mut v19, 0x1::vector::remove<0x342ef9f26e4e9c13c7b0031b2bd323455e7b2fc6de6fa366c6ce5fe76c4c7cb1::vault::TypusBidReceipt>(&mut v14.receipts, v15));
                    let (v20, v21, v22) = 0x342ef9f26e4e9c13c7b0031b2bd323455e7b2fc6de6fa366c6ce5fe76c4c7cb1::vault::delegate_exercise<T0>(v18, v19);
                    if (!0x2::dynamic_field::exists_<0x1::string::String>(&v14.id, 0x1::string::utf8(b"profit"))) {
                        0x2::dynamic_field::add<0x1::string::String, 0x2::balance::Balance<T0>>(&mut v14.id, 0x1::string::utf8(b"profit"), 0x2::balance::zero<T0>());
                    };
                    0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::balance::Balance<T0>>(&mut v14.id, 0x1::string::utf8(b"profit")), v22);
                    v14.accumulated_profit = v14.accumulated_profit + v20;
                    0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::emit_exercise_event(v13, v20, v21, 0x1::option::none<0x1::type_name::TypeName>(), 0, v14.user);
                    update_u64_padding<T0, T1>(v14);
                    let v23 = 0x1::vector::borrow_mut<u64>(&mut v14.u64_padding, 2);
                    *v23 = *v23 + (((0x342ef9f26e4e9c13c7b0031b2bd323455e7b2fc6de6fa366c6ce5fe76c4c7cb1::vault::get_bid_vault_u64_padding_value(v18, 1) as u128) * (v21 as u128) / (0x342ef9f26e4e9c13c7b0031b2bd323455e7b2fc6de6fa366c6ce5fe76c4c7cb1::utils::multiplier(0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::get_o_token_decimal(v13)) as u128)) as u64) * 11000 / 10000 * (10000 - 0x342ef9f26e4e9c13c7b0031b2bd323455e7b2fc6de6fa366c6ce5fe76c4c7cb1::vault::get_bid_vault_u64_padding_value(v18, 2)) / 10000;
                    v16 = v16 - 1;
                    continue
                };
                v15 = v15 + 1;
            };
        };
    }

    entry fun new_bid<T0, T1>(arg0: &0x8bba3d8e3449349116c569543b5ded374615e9f11cbd2ba97b7a6bc5f45b12fe::ecosystem::Version, arg1: &mut 0x8bba3d8e3449349116c569543b5ded374615e9f11cbd2ba97b7a6bc5f45b12fe::user::TypusUserRegistry, arg2: &mut 0x8bba3d8e3449349116c569543b5ded374615e9f11cbd2ba97b7a6bc5f45b12fe::tgld::TgldRegistry, arg3: &mut 0x8bba3d8e3449349116c569543b5ded374615e9f11cbd2ba97b7a6bc5f45b12fe::leaderboard::TypusLeaderboardRegistry, arg4: &mut 0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::Registry, arg5: &mut StrategyPoolV2, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg9);
        0x1::vector::contains<address>(&arg5.authority, &v0);
        0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::version_check(arg4);
        0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::operation_check(arg4);
        0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::portfolio_vault_token_check<T0, T1>(arg4, arg6);
        let (v1, _, _, _, v5, _, v7, v8, v9, _, _, _) = 0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::get_mut_registry_inner(arg4);
        let v13 = 0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::get_mut_portfolio_vault(v5, arg6);
        let v14 = 0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::get_mut_bid_vault(v8, arg6);
        let v15 = 0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::get_mut_auction(v7, arg6);
        let v16 = 0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::get_mut_refund_vault<T1>(v9);
        let v17 = 0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::get_round(v13);
        let v18 = 0;
        let v19 = 0x342ef9f26e4e9c13c7b0031b2bd323455e7b2fc6de6fa366c6ce5fe76c4c7cb1::dutch::size(v15);
        let (v20, v21) = 0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::get_auction_ts(v13);
        let v22 = 0x2::vec_map::get_mut<u64, 0x2::table_vec::TableVec<StrategyV2>>(0x2::vec_map::get_mut<u64, 0x2::vec_map::VecMap<u64, 0x2::table_vec::TableVec<StrategyV2>>>(&mut arg5.strategies, &arg6), &arg7);
        let v23 = 0;
        while (v23 < 0x2::table_vec::length<StrategyV2>(v22)) {
            let v24 = 0x2::table_vec::borrow_mut<StrategyV2>(v22, v23);
            if ((0x1::vector::contains<u64>(&v24.target_rounds, &v17) || 0x1::vector::length<u64>(&v24.target_rounds) == 0) && v24.bid_times < v24.max_times && v24.bid_round < v17 && 100 - (0x2::clock::timestamp_ms(arg8) - v20) * 100 / v21 <= v24.price_percentage && v24.active) {
                let v25 = v24.user;
                let v26 = v24.size;
                let v27 = 0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::balance::Balance<T1>>(&mut v24.id, 0x1::string::utf8(b"balance"));
                0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::validate_bid(v13, v15, v26);
                let v28 = 0x342ef9f26e4e9c13c7b0031b2bd323455e7b2fc6de6fa366c6ce5fe76c4c7cb1::dutch::total_bid_size(v15);
                let v29 = if (v28 + v26 > v19) {
                    v19 - v28
                } else {
                    v26
                };
                let (v30, v31) = 0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::get_new_bid_incentive_balance_value<T1>(v1, v13, v15, v29, v18, arg8);
                if (0x2::balance::value<T1>(v27) >= v31) {
                    if (v29 > 0) {
                        let v32 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
                        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v32, 0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(v27), arg9));
                        let (v33, v34, v35, v36, v37, v38, _, v40) = 0x342ef9f26e4e9c13c7b0031b2bd323455e7b2fc6de6fa366c6ce5fe76c4c7cb1::dutch::public_new_bid_v2<T1>(v16, v15, v25, v29, v32, 0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::get_new_bid_incentive_balance<T1>(v1, v13, v30), v18, arg8, arg9);
                        0x2::balance::join<T1>(v27, 0x2::coin::into_balance<T1>(v40));
                        if (0x2::balance::value<T1>(v27) < v31) {
                            v24.active = false;
                        };
                        0x1::vector::push_back<0x342ef9f26e4e9c13c7b0031b2bd323455e7b2fc6de6fa366c6ce5fe76c4c7cb1::vault::TypusBidReceipt>(&mut v24.receipts, 0x342ef9f26e4e9c13c7b0031b2bd323455e7b2fc6de6fa366c6ce5fe76c4c7cb1::vault::public_new_bid(v14, v35, arg9));
                        0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::emit_new_bid_event(v13, v33, v34, v35, v36, v37, v38, v25);
                        let v41 = 0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::calculate_in_usd<T1>(v13, v36, false);
                        let (v42, v43) = 0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::tails_staking::mut_nft_table(v1);
                        if (0x2::object_table::contains<address, 0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::Tails>(v42, v24.user)) {
                            let v44 = 0x2::object_table::borrow_mut<address, 0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::Tails>(v42, v24.user);
                            0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::first_bid(v43, v44);
                            0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::nft_exp_up(v43, v44, v41 * 200);
                        };
                        0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::add_accumulated_tgld_amount(v1, arg0, arg1, arg2, v24.user, v41 * 200, arg9);
                        0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::add_leaderboard_score(v1, arg0, arg3, 0x1::ascii::string(b"bidding_leaderboard"), v24.user, v41 * 200, arg8, arg9);
                        v24.bid_times = v24.bid_times + 1;
                        v24.bid_round = v17;
                        v24.bid_ts_ms = v38;
                        0x1::vector::push_back<u64>(&mut v24.bid_rounds, v17);
                        update_u64_padding<T0, T1>(v24);
                    } else {
                        break
                    };
                } else {
                    v24.active = false;
                };
            };
            v23 = v23 + 1;
        };
    }

    public fun new_strategy<T0, T1>(arg0: &0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::Registry, arg1: &mut StrategyPoolV2, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: vector<u64>, arg8: 0x2::coin::Coin<T1>, arg9: &mut 0x2::tx_context::TxContext) {
        0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::version_check(arg0);
        0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::operation_check(arg0);
        0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::portfolio_vault_token_check<T0, T1>(arg0, arg2);
        let v0 = 0x2::tx_context::sender(arg9);
        assert!(0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::tails_staking::get_staked_level(arg0, v0) > 0, 1);
        let (_, _, _, _, v5, _, _, _, _, _, _, _) = 0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::get_registry_inner(arg0);
        0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::validate_bid_amount(0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::get_portfolio_vault(v5, arg2), arg4);
        let v13 = 0x2::coin::value<T1>(&arg8);
        let v14 = 0x1::vector::empty<u64>();
        let v15 = &mut v14;
        0x1::vector::push_back<u64>(v15, v13);
        0x1::vector::push_back<u64>(v15, 0);
        0x1::vector::push_back<u64>(v15, 0);
        let v16 = StrategyV2{
            id                 : 0x2::object::new(arg9),
            vault_index        : arg2,
            signal_index       : arg3,
            user               : v0,
            price_percentage   : arg5,
            size               : arg4,
            max_times          : arg6,
            target_rounds      : arg7,
            receipts           : 0x1::vector::empty<0x342ef9f26e4e9c13c7b0031b2bd323455e7b2fc6de6fa366c6ce5fe76c4c7cb1::vault::TypusBidReceipt>(),
            active             : true,
            u64_padding        : v14,
            bid_times          : 0,
            bid_round          : 0,
            bid_ts_ms          : 0,
            bid_rounds         : 0x1::vector::empty<u64>(),
            accumulated_profit : 0,
        };
        0x2::dynamic_field::add<0x1::string::String, 0x2::balance::Balance<T1>>(&mut v16.id, 0x1::string::utf8(b"balance"), 0x2::coin::into_balance<T1>(arg8));
        0x2::dynamic_field::add<0x1::string::String, 0x2::balance::Balance<T0>>(&mut v16.id, 0x1::string::utf8(b"profit"), 0x2::balance::zero<T0>());
        0x2::table_vec::push_back<StrategyV2>(0x2::vec_map::get_mut<u64, 0x2::table_vec::TableVec<StrategyV2>>(0x2::vec_map::get_mut<u64, 0x2::vec_map::VecMap<u64, 0x2::table_vec::TableVec<StrategyV2>>>(&mut arg1.strategies, &arg2), &arg3), v16);
        let v17 = NewStrategyEventV2{
            vault_index      : arg2,
            signal_index     : arg3,
            user             : v0,
            price_percentage : arg5,
            size             : arg4,
            max_times        : arg6,
            target_rounds    : arg7,
            deposit_amount   : v13,
        };
        0x2::event::emit<NewStrategyEventV2>(v17);
    }

    entry fun new_strategy_pool(arg0: &0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::Registry, arg1: &mut 0x2::tx_context::TxContext) {
        0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::version_check(arg0);
        0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::operation_check(arg0);
        let v0 = StrategyPoolV2{
            id         : 0x2::object::new(arg1),
            strategies : 0x2::vec_map::empty<u64, 0x2::vec_map::VecMap<u64, 0x2::table_vec::TableVec<StrategyV2>>>(),
            authority  : 0x1::vector::singleton<address>(0x2::tx_context::sender(arg1)),
        };
        let v1 = NewStrategyPoolEvent{
            id     : 0x2::object::id<StrategyPoolV2>(&v0),
            signer : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<NewStrategyPoolEvent>(v1);
        0x2::transfer::public_share_object<StrategyPoolV2>(v0);
    }

    entry fun new_strategy_signal(arg0: &mut StrategyPoolV2, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        0x1::vector::contains<address>(&arg0.authority, &v0);
        0x2::vec_map::insert<u64, 0x2::table_vec::TableVec<StrategyV2>>(0x2::vec_map::get_mut<u64, 0x2::vec_map::VecMap<u64, 0x2::table_vec::TableVec<StrategyV2>>>(&mut arg0.strategies, &arg1), arg2, 0x2::table_vec::empty<StrategyV2>(arg3));
        let v1 = NewStrategySignalEvent{
            id           : 0x2::object::id<StrategyPoolV2>(arg0),
            vault_index  : arg1,
            signal_index : arg2,
            signer       : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<NewStrategySignalEvent>(v1);
    }

    entry fun new_strategy_vault(arg0: &mut StrategyPoolV2, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        0x1::vector::contains<address>(&arg0.authority, &v0);
        0x2::vec_map::insert<u64, 0x2::vec_map::VecMap<u64, 0x2::table_vec::TableVec<StrategyV2>>>(&mut arg0.strategies, arg1, 0x2::vec_map::empty<u64, 0x2::table_vec::TableVec<StrategyV2>>());
        let v1 = NewStrategyVaultEvent{
            id          : 0x2::object::id<StrategyPoolV2>(arg0),
            vault_index : arg1,
            signer      : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<NewStrategyVaultEvent>(v1);
    }

    public fun update_strategy<T0, T1>(arg0: &0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::Registry, arg1: &mut StrategyPoolV2, arg2: u64, arg3: u64, arg4: u64, arg5: 0x1::option::Option<u64>, arg6: 0x1::option::Option<u64>, arg7: 0x1::option::Option<u64>, arg8: vector<u64>, arg9: vector<0x2::coin::Coin<T1>>, arg10: &0x2::tx_context::TxContext) {
        0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::version_check(arg0);
        0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::operation_check(arg0);
        0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::portfolio_vault_token_check<T0, T1>(arg0, arg2);
        let v0 = 0x2::table_vec::borrow_mut<StrategyV2>(0x2::vec_map::get_mut<u64, 0x2::table_vec::TableVec<StrategyV2>>(0x2::vec_map::get_mut<u64, 0x2::vec_map::VecMap<u64, 0x2::table_vec::TableVec<StrategyV2>>>(&mut arg1.strategies, &arg2), &arg3), arg4);
        let v1 = 0x2::tx_context::sender(arg10);
        assert!(v0.user == v1, 0);
        assert!(0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::tails_staking::get_staked_level(arg0, v1) > 0, 1);
        if (0x1::option::is_some<u64>(&arg5)) {
            let (_, _, _, _, v6, _, _, _, _, _, _, _) = 0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::get_registry_inner(arg0);
            let v14 = 0x1::option::destroy_some<u64>(arg5);
            0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::validate_bid_amount(0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::get_portfolio_vault(v6, arg2), v14);
            v0.size = v14;
        };
        if (0x1::option::is_some<u64>(&arg6)) {
            v0.price_percentage = 0x1::option::destroy_some<u64>(arg6);
        };
        if (0x1::option::is_some<u64>(&arg7)) {
            v0.max_times = 0x1::option::destroy_some<u64>(arg7);
        };
        v0.target_rounds = arg8;
        v0.active = true;
        let v15 = 0x2::coin::into_balance<T1>(0x342ef9f26e4e9c13c7b0031b2bd323455e7b2fc6de6fa366c6ce5fe76c4c7cb1::utils::merge_coins<T1>(arg9));
        0x2::balance::join<T1>(0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::balance::Balance<T1>>(&mut v0.id, 0x1::string::utf8(b"balance")), v15);
        update_u64_padding<T0, T1>(v0);
        let v16 = UpdateStrategyEvent{
            vault_index      : arg2,
            signal_index     : arg3,
            strategy_index   : arg4,
            user             : v0.user,
            price_percentage : v0.price_percentage,
            size             : v0.size,
            max_times        : v0.max_times,
            target_rounds    : v0.target_rounds,
            deposit_amount   : 0x2::balance::value<T1>(&v15),
        };
        0x2::event::emit<UpdateStrategyEvent>(v16);
    }

    fun update_u64_padding<T0, T1>(arg0: &mut StrategyV2) {
        let v0 = 0;
        if (0x1::vector::length<u64>(&arg0.u64_padding) > 2) {
            v0 = *0x1::vector::borrow<u64>(&arg0.u64_padding, 2);
        };
        let v1 = 0x1::vector::empty<u64>();
        let v2 = &mut v1;
        0x1::vector::push_back<u64>(v2, 0x2::balance::value<T1>(0x2::dynamic_field::borrow<0x1::string::String, 0x2::balance::Balance<T1>>(&arg0.id, 0x1::string::utf8(b"balance"))));
        0x1::vector::push_back<u64>(v2, 0x2::balance::value<T0>(0x2::dynamic_field::borrow<0x1::string::String, 0x2::balance::Balance<T0>>(&arg0.id, 0x1::string::utf8(b"profit"))));
        0x1::vector::push_back<u64>(v2, v0);
        arg0.u64_padding = v1;
    }

    public(friend) fun view_user_strategies(arg0: &0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::Registry, arg1: &mut StrategyPoolV2, arg2: address) : vector<vector<u8>> {
        let v0 = 0x1::vector::empty<vector<u8>>();
        let v1 = 0x2::vec_map::keys<u64, 0x2::vec_map::VecMap<u64, 0x2::table_vec::TableVec<StrategyV2>>>(&arg1.strategies);
        while (!0x1::vector::is_empty<u64>(&v1)) {
            let v2 = 0x1::vector::pop_back<u64>(&mut v1);
            let v3 = 0x2::vec_map::get_mut<u64, 0x2::vec_map::VecMap<u64, 0x2::table_vec::TableVec<StrategyV2>>>(&mut arg1.strategies, &v2);
            let v4 = 0x2::vec_map::keys<u64, 0x2::table_vec::TableVec<StrategyV2>>(v3);
            while (!0x1::vector::is_empty<u64>(&v4)) {
                let v5 = 0x1::vector::pop_back<u64>(&mut v4);
                let v6 = 0x2::vec_map::get_mut<u64, 0x2::table_vec::TableVec<StrategyV2>>(v3, &v5);
                let v7 = 0;
                while (v7 < 0x2::table_vec::length<StrategyV2>(v6)) {
                    let v8 = 0x2::table_vec::borrow_mut<StrategyV2>(v6, v7);
                    if (v8.user == arg2) {
                        let v9 = 0x1::bcs::to_bytes<StrategyV2>(v8);
                        0x1::vector::append<u8>(&mut v9, 0x1::bcs::to_bytes<u64>(&v7));
                        let v10 = 0x1::vector::empty<0x342ef9f26e4e9c13c7b0031b2bd323455e7b2fc6de6fa366c6ce5fe76c4c7cb1::vault::TypusBidReceipt>();
                        while (!0x1::vector::is_empty<0x342ef9f26e4e9c13c7b0031b2bd323455e7b2fc6de6fa366c6ce5fe76c4c7cb1::vault::TypusBidReceipt>(&v8.receipts)) {
                            0x1::vector::push_back<0x342ef9f26e4e9c13c7b0031b2bd323455e7b2fc6de6fa366c6ce5fe76c4c7cb1::vault::TypusBidReceipt>(&mut v10, 0x1::vector::pop_back<0x342ef9f26e4e9c13c7b0031b2bd323455e7b2fc6de6fa366c6ce5fe76c4c7cb1::vault::TypusBidReceipt>(&mut v8.receipts));
                        };
                        let v11 = 0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::tds_view_function::get_my_bids_bcs(arg0, v10);
                        0x1::vector::append<u8>(&mut v9, 0x1::bcs::to_bytes<vector<vector<u8>>>(&v11));
                        0x1::vector::push_back<vector<u8>>(&mut v0, v9);
                    };
                    v7 = v7 + 1;
                };
            };
            0x1::vector::destroy_empty<u64>(v4);
        };
        0x1::vector::destroy_empty<u64>(v1);
        v0
    }

    public fun withdraw_profit<T0, T1>(arg0: &0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::Registry, arg1: &mut StrategyPoolV2, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::version_check(arg0);
        0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::operation_check(arg0);
        0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::portfolio_vault_token_check<T0, T1>(arg0, arg2);
        let v0 = 0x2::table_vec::borrow_mut<StrategyV2>(0x2::vec_map::get_mut<u64, 0x2::table_vec::TableVec<StrategyV2>>(0x2::vec_map::get_mut<u64, 0x2::vec_map::VecMap<u64, 0x2::table_vec::TableVec<StrategyV2>>>(&mut arg1.strategies, &arg2), &arg3), arg4);
        let v1 = 0x2::tx_context::sender(arg5);
        assert!(v0.user == v1, 0);
        assert!(0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::tails_staking::get_staked_level(arg0, v1) > 0, 1);
        let v2 = 0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::balance::Balance<T0>>(&mut v0.id, 0x1::string::utf8(b"profit"));
        let v3 = 0x2::balance::value<T0>(v2);
        let v4 = 0x2::coin::take<T0>(v2, v3, arg5);
        update_u64_padding<T0, T1>(v0);
        let v5 = WithdrawProfitEvent{
            vault_index    : arg2,
            signal_index   : arg3,
            strategy_index : arg4,
            user           : v0.user,
            profit         : v3,
        };
        0x2::event::emit<WithdrawProfitEvent>(v5);
        v4
    }

    // decompiled from Move bytecode v6
}

