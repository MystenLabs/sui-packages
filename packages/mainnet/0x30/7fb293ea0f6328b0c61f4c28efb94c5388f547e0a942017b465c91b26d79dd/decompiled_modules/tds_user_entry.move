module 0x4e845c2c18602edd9f7f0251b467a301ad653e38d9fdbfc06cbc670a4d79166e::tds_user_entry {
    public fun merge_deposit_receipts(arg0: &mut 0x4e845c2c18602edd9f7f0251b467a301ad653e38d9fdbfc06cbc670a4d79166e::typus_dov_single::Registry, arg1: u64, arg2: vector<0x8b3ec6814a0613c96fd35931dad7f6bc380e5de89e7a66691852fe8f10b9387::vault::TypusDepositReceipt>, arg3: &mut 0x2::tx_context::TxContext) : (0x8b3ec6814a0613c96fd35931dad7f6bc380e5de89e7a66691852fe8f10b9387::vault::TypusDepositReceipt, vector<u64>) {
        let (_, _, _, _, _, v5, _, _, _, _, _, _) = 0x4e845c2c18602edd9f7f0251b467a301ad653e38d9fdbfc06cbc670a4d79166e::typus_dov_single::get_mut_registry_inner(arg0);
        let (v12, v13) = 0x8b3ec6814a0613c96fd35931dad7f6bc380e5de89e7a66691852fe8f10b9387::vault::merge_deposit_receipts(0x4e845c2c18602edd9f7f0251b467a301ad653e38d9fdbfc06cbc670a4d79166e::typus_dov_single::get_mut_deposit_vault(v5, arg1), arg2, arg3);
        (0x1::option::destroy_some<0x8b3ec6814a0613c96fd35931dad7f6bc380e5de89e7a66691852fe8f10b9387::vault::TypusDepositReceipt>(v12), v13)
    }

    public fun split_bid_receipt<T0, T1>(arg0: &mut 0x4e845c2c18602edd9f7f0251b467a301ad653e38d9fdbfc06cbc670a4d79166e::typus_dov_single::Registry, arg1: u64, arg2: vector<0x8b3ec6814a0613c96fd35931dad7f6bc380e5de89e7a66691852fe8f10b9387::vault::TypusBidReceipt>, arg3: 0x1::option::Option<u64>, arg4: &mut 0x2::tx_context::TxContext) : (u64, 0x1::option::Option<0x8b3ec6814a0613c96fd35931dad7f6bc380e5de89e7a66691852fe8f10b9387::vault::TypusBidReceipt>, 0x1::option::Option<0x8b3ec6814a0613c96fd35931dad7f6bc380e5de89e7a66691852fe8f10b9387::vault::TypusBidReceipt>) {
        abort 999
    }

    public fun split_deposit_receipt(arg0: &mut 0x4e845c2c18602edd9f7f0251b467a301ad653e38d9fdbfc06cbc670a4d79166e::typus_dov_single::Registry, arg1: u64, arg2: 0x8b3ec6814a0613c96fd35931dad7f6bc380e5de89e7a66691852fe8f10b9387::vault::TypusDepositReceipt, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0x8b3ec6814a0613c96fd35931dad7f6bc380e5de89e7a66691852fe8f10b9387::vault::TypusDepositReceipt, 0x8b3ec6814a0613c96fd35931dad7f6bc380e5de89e7a66691852fe8f10b9387::vault::TypusDepositReceipt) {
        abort 999
    }

    public fun claim<T0, T1>(arg0: &mut 0x4e845c2c18602edd9f7f0251b467a301ad653e38d9fdbfc06cbc670a4d79166e::typus_dov_single::Registry, arg1: u64, arg2: vector<0x8b3ec6814a0613c96fd35931dad7f6bc380e5de89e7a66691852fe8f10b9387::vault::TypusDepositReceipt>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x1::option::Option<0x8b3ec6814a0613c96fd35931dad7f6bc380e5de89e7a66691852fe8f10b9387::vault::TypusDepositReceipt>, vector<u64>) {
        abort 999
    }

    public fun exercise<T0, T1>(arg0: &mut 0x4e845c2c18602edd9f7f0251b467a301ad653e38d9fdbfc06cbc670a4d79166e::typus_dov_single::Registry, arg1: u64, arg2: vector<0x8b3ec6814a0613c96fd35931dad7f6bc380e5de89e7a66691852fe8f10b9387::vault::TypusBidReceipt>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, vector<u64>) {
        safety_check<T0, T1>(arg0, arg1);
        let (_, _, _, _, v4, _, _, v7, _, _, _, _) = 0x4e845c2c18602edd9f7f0251b467a301ad653e38d9fdbfc06cbc670a4d79166e::typus_dov_single::get_mut_registry_inner(arg0);
        let v12 = 0x8b3ec6814a0613c96fd35931dad7f6bc380e5de89e7a66691852fe8f10b9387::vault::get_bid_receipt_vid(0x1::vector::borrow<0x8b3ec6814a0613c96fd35931dad7f6bc380e5de89e7a66691852fe8f10b9387::vault::TypusBidReceipt>(&arg2, 0));
        let (v13, v14) = 0x8b3ec6814a0613c96fd35931dad7f6bc380e5de89e7a66691852fe8f10b9387::vault::public_exercise<T0>(0x4e845c2c18602edd9f7f0251b467a301ad653e38d9fdbfc06cbc670a4d79166e::typus_dov_single::get_mut_bid_vault_by_id(v7, &v12), arg2);
        let v15 = v14;
        0x4e845c2c18602edd9f7f0251b467a301ad653e38d9fdbfc06cbc670a4d79166e::typus_dov_single::emit_exercise_event(0x4e845c2c18602edd9f7f0251b467a301ad653e38d9fdbfc06cbc670a4d79166e::typus_dov_single::get_portfolio_vault(v4, arg1), *0x1::vector::borrow<u64>(&v15, 0), *0x1::vector::borrow<u64>(&v15, 1), 0x1::option::none<0x1::type_name::TypeName>(), 0, 0x2::tx_context::sender(arg3));
        (v13, v15)
    }

    public fun harvest<T0, T1>(arg0: &mut 0x4e845c2c18602edd9f7f0251b467a301ad653e38d9fdbfc06cbc670a4d79166e::typus_dov_single::Registry, arg1: u64, arg2: vector<0x8b3ec6814a0613c96fd35931dad7f6bc380e5de89e7a66691852fe8f10b9387::vault::TypusDepositReceipt>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x1::option::Option<0x8b3ec6814a0613c96fd35931dad7f6bc380e5de89e7a66691852fe8f10b9387::vault::TypusDepositReceipt>, vector<u64>) {
        abort 999
    }

    public fun public_bid<T0, T1>(arg0: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg1: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::user::TypusUserRegistry, arg2: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::tgld::TgldRegistry, arg3: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::leaderboard::TypusLeaderboardRegistry, arg4: &mut 0x4e845c2c18602edd9f7f0251b467a301ad653e38d9fdbfc06cbc670a4d79166e::typus_dov_single::Registry, arg5: u64, arg6: vector<0x2::coin::Coin<T1>>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x8b3ec6814a0613c96fd35931dad7f6bc380e5de89e7a66691852fe8f10b9387::vault::TypusBidReceipt, 0x2::coin::Coin<T1>, vector<u64>) {
        safety_check<T0, T1>(arg4, arg5);
        let v0 = 0x2::tx_context::sender(arg9);
        let (v1, _, _, _, v5, _, v7, v8, v9, _, _, _) = 0x4e845c2c18602edd9f7f0251b467a301ad653e38d9fdbfc06cbc670a4d79166e::typus_dov_single::get_mut_registry_inner(arg4);
        let v13 = 0x4e845c2c18602edd9f7f0251b467a301ad653e38d9fdbfc06cbc670a4d79166e::typus_dov_single::get_mut_portfolio_vault(v5, arg5);
        let v14 = 0x4e845c2c18602edd9f7f0251b467a301ad653e38d9fdbfc06cbc670a4d79166e::typus_dov_single::get_mut_auction(v7, arg5);
        0x4e845c2c18602edd9f7f0251b467a301ad653e38d9fdbfc06cbc670a4d79166e::typus_dov_single::validate_bid(v13, v14, arg7);
        let v15 = 0x8b3ec6814a0613c96fd35931dad7f6bc380e5de89e7a66691852fe8f10b9387::dutch::size(v14);
        let v16 = 0x8b3ec6814a0613c96fd35931dad7f6bc380e5de89e7a66691852fe8f10b9387::dutch::total_bid_size(v14);
        let v17 = if (v16 + arg7 > v15) {
            v15 - v16
        } else {
            arg7
        };
        let v18 = 0;
        let (v19, _) = 0x4e845c2c18602edd9f7f0251b467a301ad653e38d9fdbfc06cbc670a4d79166e::typus_dov_single::get_new_bid_incentive_balance_value<T1>(v1, v13, v14, v17, v18, arg8);
        let (v21, v22, v23, v24, v25, v26, _, v28) = 0x8b3ec6814a0613c96fd35931dad7f6bc380e5de89e7a66691852fe8f10b9387::dutch::public_new_bid_v2<T1>(0x4e845c2c18602edd9f7f0251b467a301ad653e38d9fdbfc06cbc670a4d79166e::typus_dov_single::get_mut_refund_vault<T1>(v9), v14, 0x2::tx_context::sender(arg9), v17, arg6, 0x4e845c2c18602edd9f7f0251b467a301ad653e38d9fdbfc06cbc670a4d79166e::typus_dov_single::get_new_bid_incentive_balance<T1>(v1, v13, v19), v18, arg8, arg9);
        let v29 = 0x4e845c2c18602edd9f7f0251b467a301ad653e38d9fdbfc06cbc670a4d79166e::typus_dov_single::calculate_in_usd<T1>(v13, v24, false) * 200;
        0x4e845c2c18602edd9f7f0251b467a301ad653e38d9fdbfc06cbc670a4d79166e::typus_dov_single::emit_new_bid_event(v13, v21, v22, v23, v24, v25, v26, 0x2::tx_context::sender(arg9));
        0x4e845c2c18602edd9f7f0251b467a301ad653e38d9fdbfc06cbc670a4d79166e::typus_dov_single::add_accumulated_tgld_amount(v1, arg0, arg1, arg2, v0, v29, arg9);
        0x4e845c2c18602edd9f7f0251b467a301ad653e38d9fdbfc06cbc670a4d79166e::typus_dov_single::add_leaderboard_score(v1, arg0, arg3, 0x1::ascii::string(b"bidding_leaderboard"), v0, 0x4e845c2c18602edd9f7f0251b467a301ad653e38d9fdbfc06cbc670a4d79166e::typus_dov_single::calculate_in_usd_with_decimal<T1>(v13, v24) * 15 / 10, arg8, arg9);
        0x4e845c2c18602edd9f7f0251b467a301ad653e38d9fdbfc06cbc670a4d79166e::typus_dov_single::add_user_tails_exp_amount(v1, arg0, arg1, v0, v29);
        (0x8b3ec6814a0613c96fd35931dad7f6bc380e5de89e7a66691852fe8f10b9387::vault::public_new_bid(0x4e845c2c18602edd9f7f0251b467a301ad653e38d9fdbfc06cbc670a4d79166e::typus_dov_single::get_mut_bid_vault(v8, arg5), v23, arg9), v28, vector[])
    }

    public fun public_raise_fund<T0, T1>(arg0: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg1: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::user::TypusUserRegistry, arg2: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::leaderboard::TypusLeaderboardRegistry, arg3: &mut 0x4e845c2c18602edd9f7f0251b467a301ad653e38d9fdbfc06cbc670a4d79166e::typus_dov_single::Registry, arg4: u64, arg5: vector<0x8b3ec6814a0613c96fd35931dad7f6bc380e5de89e7a66691852fe8f10b9387::vault::TypusDepositReceipt>, arg6: 0x2::balance::Balance<T0>, arg7: bool, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x8b3ec6814a0613c96fd35931dad7f6bc380e5de89e7a66691852fe8f10b9387::vault::TypusDepositReceipt, vector<u64>) {
        safety_check<T0, T1>(arg3, arg4);
        let (_, _, _, v3, v4, v5, _, _, _, _, _, _) = 0x4e845c2c18602edd9f7f0251b467a301ad653e38d9fdbfc06cbc670a4d79166e::typus_dov_single::get_mut_registry_inner(arg3);
        let v12 = 0x4e845c2c18602edd9f7f0251b467a301ad653e38d9fdbfc06cbc670a4d79166e::typus_dov_single::get_portfolio_vault(v4, arg4);
        let (v13, v14) = 0x8b3ec6814a0613c96fd35931dad7f6bc380e5de89e7a66691852fe8f10b9387::vault::raise_fund<T0>(v3, 0x4e845c2c18602edd9f7f0251b467a301ad653e38d9fdbfc06cbc670a4d79166e::typus_dov_single::get_mut_deposit_vault(v5, arg4), arg5, arg6, arg7, arg8, arg10);
        let v15 = v14;
        let v16 = *0x1::vector::borrow<u64>(&v15, 0);
        let v17 = *0x1::vector::borrow<u64>(&v15, 1);
        let v18 = *0x1::vector::borrow<u64>(&v15, 4);
        0x4e845c2c18602edd9f7f0251b467a301ad653e38d9fdbfc06cbc670a4d79166e::typus_dov_single::validate_amount(v16 + v17 + v18);
        0x4e845c2c18602edd9f7f0251b467a301ad653e38d9fdbfc06cbc670a4d79166e::typus_dov_single::validate_capacity(arg3, arg4);
        0x4e845c2c18602edd9f7f0251b467a301ad653e38d9fdbfc06cbc670a4d79166e::typus_dov_single::emit_raise_fund_event(v12, v16, v17, *0x1::vector::borrow<u64>(&v15, 2), *0x1::vector::borrow<u64>(&v15, 3), v18, arg10);
        0x4e845c2c18602edd9f7f0251b467a301ad653e38d9fdbfc06cbc670a4d79166e::typus_dov_single::update_deposit_snapshot(arg0, arg1, arg2, arg3, arg4, 0x2::tx_context::sender(arg10), 0x4e845c2c18602edd9f7f0251b467a301ad653e38d9fdbfc06cbc670a4d79166e::typus_dov_single::calculate_in_usd<T0>(v12, *0x1::vector::borrow<u64>(&v15, 5), false), arg9, arg10);
        (v13, v15)
    }

    public fun public_reduce_fund<T0, T1, T2>(arg0: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg1: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::user::TypusUserRegistry, arg2: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::leaderboard::TypusLeaderboardRegistry, arg3: &mut 0x4e845c2c18602edd9f7f0251b467a301ad653e38d9fdbfc06cbc670a4d79166e::typus_dov_single::Registry, arg4: u64, arg5: vector<0x8b3ec6814a0613c96fd35931dad7f6bc380e5de89e7a66691852fe8f10b9387::vault::TypusDepositReceipt>, arg6: u64, arg7: u64, arg8: bool, arg9: bool, arg10: bool, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : (0x1::option::Option<0x8b3ec6814a0613c96fd35931dad7f6bc380e5de89e7a66691852fe8f10b9387::vault::TypusDepositReceipt>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>, vector<u64>) {
        safety_check<T0, T1>(arg3, arg4);
        let (_, _, _, v3, v4, v5, _, _, _, _, _, _) = 0x4e845c2c18602edd9f7f0251b467a301ad653e38d9fdbfc06cbc670a4d79166e::typus_dov_single::get_mut_registry_inner(arg3);
        let v12 = 0x4e845c2c18602edd9f7f0251b467a301ad653e38d9fdbfc06cbc670a4d79166e::typus_dov_single::get_portfolio_vault(v4, arg4);
        let (v13, v14, v15, v16, v17) = 0x8b3ec6814a0613c96fd35931dad7f6bc380e5de89e7a66691852fe8f10b9387::vault::reduce_fund<T0, T1, T2>(v3, 0x4e845c2c18602edd9f7f0251b467a301ad653e38d9fdbfc06cbc670a4d79166e::typus_dov_single::get_mut_deposit_vault(v5, arg4), arg5, arg6, arg7, arg8, arg9, arg10, arg12);
        let v18 = v17;
        0x4e845c2c18602edd9f7f0251b467a301ad653e38d9fdbfc06cbc670a4d79166e::typus_dov_single::emit_reduce_fund_event(v12, 0x1::type_name::get<T0>(), 0x1::type_name::get<T1>(), 0x1::type_name::get<T2>(), *0x1::vector::borrow<u64>(&v18, 0), *0x1::vector::borrow<u64>(&v18, 1), *0x1::vector::borrow<u64>(&v18, 2), *0x1::vector::borrow<u64>(&v18, 3), *0x1::vector::borrow<u64>(&v18, 4), *0x1::vector::borrow<u64>(&v18, 5), *0x1::vector::borrow<u64>(&v18, 6), *0x1::vector::borrow<u64>(&v18, 7), *0x1::vector::borrow<u64>(&v18, 8), arg12);
        0x4e845c2c18602edd9f7f0251b467a301ad653e38d9fdbfc06cbc670a4d79166e::typus_dov_single::update_deposit_snapshot(arg0, arg1, arg2, arg3, arg4, 0x2::tx_context::sender(arg12), 0x4e845c2c18602edd9f7f0251b467a301ad653e38d9fdbfc06cbc670a4d79166e::typus_dov_single::calculate_in_usd<T0>(v12, *0x1::vector::borrow<u64>(&v18, 9), false), arg11, arg12);
        (v13, v14, v15, v16, v18)
    }

    public fun public_refresh_deposit_snapshot<T0, T1>(arg0: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg1: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::user::TypusUserRegistry, arg2: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::leaderboard::TypusLeaderboardRegistry, arg3: &mut 0x4e845c2c18602edd9f7f0251b467a301ad653e38d9fdbfc06cbc670a4d79166e::typus_dov_single::Registry, arg4: u64, arg5: vector<0x8b3ec6814a0613c96fd35931dad7f6bc380e5de89e7a66691852fe8f10b9387::vault::TypusDepositReceipt>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x8b3ec6814a0613c96fd35931dad7f6bc380e5de89e7a66691852fe8f10b9387::vault::TypusDepositReceipt, vector<u64>) {
        safety_check<T0, T1>(arg3, arg4);
        let (_, _, _, v3, v4, v5, _, _, _, _, _, _) = 0x4e845c2c18602edd9f7f0251b467a301ad653e38d9fdbfc06cbc670a4d79166e::typus_dov_single::get_mut_registry_inner(arg3);
        let v12 = 0x4e845c2c18602edd9f7f0251b467a301ad653e38d9fdbfc06cbc670a4d79166e::typus_dov_single::get_portfolio_vault(v4, arg4);
        let (v13, v14) = 0x8b3ec6814a0613c96fd35931dad7f6bc380e5de89e7a66691852fe8f10b9387::vault::raise_fund<T0>(v3, 0x4e845c2c18602edd9f7f0251b467a301ad653e38d9fdbfc06cbc670a4d79166e::typus_dov_single::get_mut_deposit_vault(v5, arg4), arg5, 0x2::balance::zero<T0>(), false, false, arg7);
        let v15 = v14;
        let v16 = 0x4e845c2c18602edd9f7f0251b467a301ad653e38d9fdbfc06cbc670a4d79166e::typus_dov_single::calculate_in_usd<T0>(v12, *0x1::vector::borrow<u64>(&v15, 5), false);
        0x4e845c2c18602edd9f7f0251b467a301ad653e38d9fdbfc06cbc670a4d79166e::typus_dov_single::emit_refresh_deposit_snapshot_event(v12, v16, arg7);
        0x4e845c2c18602edd9f7f0251b467a301ad653e38d9fdbfc06cbc670a4d79166e::typus_dov_single::update_deposit_snapshot(arg0, arg1, arg2, arg3, arg4, 0x2::tx_context::sender(arg7), v16, arg6, arg7);
        (v13, v15)
    }

    public fun public_transfer_bid_receipt<T0, T1>(arg0: &mut 0x4e845c2c18602edd9f7f0251b467a301ad653e38d9fdbfc06cbc670a4d79166e::typus_dov_single::Registry, arg1: u64, arg2: vector<0x8b3ec6814a0613c96fd35931dad7f6bc380e5de89e7a66691852fe8f10b9387::vault::TypusBidReceipt>, arg3: 0x1::option::Option<u64>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) : (0x1::option::Option<0x8b3ec6814a0613c96fd35931dad7f6bc380e5de89e7a66691852fe8f10b9387::vault::TypusBidReceipt>, vector<u64>) {
        safety_check<T0, T1>(arg0, arg1);
        let (v0, v1, v2) = simple_split_bid_receipt(arg0, arg1, arg2, arg3, arg5);
        let v3 = v2;
        0x2::transfer::public_transfer<0x8b3ec6814a0613c96fd35931dad7f6bc380e5de89e7a66691852fe8f10b9387::vault::TypusBidReceipt>(0x1::option::destroy_some<0x8b3ec6814a0613c96fd35931dad7f6bc380e5de89e7a66691852fe8f10b9387::vault::TypusBidReceipt>(v0), arg4);
        let (_, _, _, _, v8, _, _, _, _, _, _, _) = 0x4e845c2c18602edd9f7f0251b467a301ad653e38d9fdbfc06cbc670a4d79166e::typus_dov_single::get_mut_registry_inner(arg0);
        0x4e845c2c18602edd9f7f0251b467a301ad653e38d9fdbfc06cbc670a4d79166e::typus_dov_single::emit_transfer_bid_receipt_event(0x4e845c2c18602edd9f7f0251b467a301ad653e38d9fdbfc06cbc670a4d79166e::typus_dov_single::get_portfolio_vault(v8, arg1), *0x1::vector::borrow<u64>(&v3, 0), arg4, arg5);
        (v1, v3)
    }

    public fun rebate<T0>(arg0: &mut 0x4e845c2c18602edd9f7f0251b467a301ad653e38d9fdbfc06cbc670a4d79166e::typus_dov_single::Registry, arg1: &mut 0x2::tx_context::TxContext) : (0x1::option::Option<0x2::balance::Balance<T0>>, vector<u64>) {
        0x4e845c2c18602edd9f7f0251b467a301ad653e38d9fdbfc06cbc670a4d79166e::typus_dov_single::version_check(arg0);
        0x4e845c2c18602edd9f7f0251b467a301ad653e38d9fdbfc06cbc670a4d79166e::typus_dov_single::operation_check(arg0);
        let (_, _, _, _, _, _, _, _, v8, _, _, _) = 0x4e845c2c18602edd9f7f0251b467a301ad653e38d9fdbfc06cbc670a4d79166e::typus_dov_single::get_mut_registry_inner(arg0);
        let (v12, v13) = 0x8b3ec6814a0613c96fd35931dad7f6bc380e5de89e7a66691852fe8f10b9387::vault::public_rebate<T0>(0x4e845c2c18602edd9f7f0251b467a301ad653e38d9fdbfc06cbc670a4d79166e::typus_dov_single::get_mut_refund_vault<T0>(v8), 0x2::tx_context::sender(arg1));
        let v14 = v13;
        let v15 = *0x1::vector::borrow<u64>(&v14, 0);
        0x4e845c2c18602edd9f7f0251b467a301ad653e38d9fdbfc06cbc670a4d79166e::typus_dov_single::validate_amount(v15);
        0x4e845c2c18602edd9f7f0251b467a301ad653e38d9fdbfc06cbc670a4d79166e::typus_dov_single::emit_refund_event(0x1::type_name::get<T0>(), v15, 0x2::tx_context::sender(arg1));
        (v12, v14)
    }

    public fun redeem<T0, T1, T2>(arg0: &mut 0x4e845c2c18602edd9f7f0251b467a301ad653e38d9fdbfc06cbc670a4d79166e::typus_dov_single::Registry, arg1: u64, arg2: vector<0x8b3ec6814a0613c96fd35931dad7f6bc380e5de89e7a66691852fe8f10b9387::vault::TypusDepositReceipt>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T2>, 0x1::option::Option<0x8b3ec6814a0613c96fd35931dad7f6bc380e5de89e7a66691852fe8f10b9387::vault::TypusDepositReceipt>, vector<u64>) {
        abort 999
    }

    fun safety_check<T0, T1>(arg0: &0x4e845c2c18602edd9f7f0251b467a301ad653e38d9fdbfc06cbc670a4d79166e::typus_dov_single::Registry, arg1: u64) {
        0x4e845c2c18602edd9f7f0251b467a301ad653e38d9fdbfc06cbc670a4d79166e::typus_dov_single::version_check(arg0);
        0x4e845c2c18602edd9f7f0251b467a301ad653e38d9fdbfc06cbc670a4d79166e::typus_dov_single::operation_check(arg0);
        0x4e845c2c18602edd9f7f0251b467a301ad653e38d9fdbfc06cbc670a4d79166e::typus_dov_single::portfolio_vault_token_check<T0, T1>(arg0, arg1);
    }

    public fun simple_split_bid_receipt(arg0: &mut 0x4e845c2c18602edd9f7f0251b467a301ad653e38d9fdbfc06cbc670a4d79166e::typus_dov_single::Registry, arg1: u64, arg2: vector<0x8b3ec6814a0613c96fd35931dad7f6bc380e5de89e7a66691852fe8f10b9387::vault::TypusBidReceipt>, arg3: 0x1::option::Option<u64>, arg4: &mut 0x2::tx_context::TxContext) : (0x1::option::Option<0x8b3ec6814a0613c96fd35931dad7f6bc380e5de89e7a66691852fe8f10b9387::vault::TypusBidReceipt>, 0x1::option::Option<0x8b3ec6814a0613c96fd35931dad7f6bc380e5de89e7a66691852fe8f10b9387::vault::TypusBidReceipt>, vector<u64>) {
        0x4e845c2c18602edd9f7f0251b467a301ad653e38d9fdbfc06cbc670a4d79166e::typus_dov_single::version_check(arg0);
        0x4e845c2c18602edd9f7f0251b467a301ad653e38d9fdbfc06cbc670a4d79166e::typus_dov_single::operation_check(arg0);
        let (_, _, _, _, _, _, _, v7, _, _, _, _) = 0x4e845c2c18602edd9f7f0251b467a301ad653e38d9fdbfc06cbc670a4d79166e::typus_dov_single::get_mut_registry_inner(arg0);
        let v12 = 0x8b3ec6814a0613c96fd35931dad7f6bc380e5de89e7a66691852fe8f10b9387::vault::get_bid_receipt_vid(0x1::vector::borrow<0x8b3ec6814a0613c96fd35931dad7f6bc380e5de89e7a66691852fe8f10b9387::vault::TypusBidReceipt>(&arg2, 0));
        let (v13, v14, v15) = 0x8b3ec6814a0613c96fd35931dad7f6bc380e5de89e7a66691852fe8f10b9387::vault::split_bid_receipt(0x4e845c2c18602edd9f7f0251b467a301ad653e38d9fdbfc06cbc670a4d79166e::typus_dov_single::get_mut_bid_vault_by_id_or_index(v7, &v12, arg1), arg2, arg3, arg4);
        0x4e845c2c18602edd9f7f0251b467a301ad653e38d9fdbfc06cbc670a4d79166e::typus_dov_single::validate_amount(v13);
        let v16 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v16, v13);
        (v14, v15, v16)
    }

    public fun split_deposit_receipt_v2(arg0: &mut 0x4e845c2c18602edd9f7f0251b467a301ad653e38d9fdbfc06cbc670a4d79166e::typus_dov_single::Registry, arg1: u64, arg2: 0x8b3ec6814a0613c96fd35931dad7f6bc380e5de89e7a66691852fe8f10b9387::vault::TypusDepositReceipt, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0x1::option::Option<0x8b3ec6814a0613c96fd35931dad7f6bc380e5de89e7a66691852fe8f10b9387::vault::TypusDepositReceipt>, 0x1::option::Option<0x8b3ec6814a0613c96fd35931dad7f6bc380e5de89e7a66691852fe8f10b9387::vault::TypusDepositReceipt>) {
        let (_, _, _, _, v4, v5, _, _, _, _, _, _) = 0x4e845c2c18602edd9f7f0251b467a301ad653e38d9fdbfc06cbc670a4d79166e::typus_dov_single::get_mut_registry_inner(arg0);
        0x4e845c2c18602edd9f7f0251b467a301ad653e38d9fdbfc06cbc670a4d79166e::typus_dov_single::validate_min_deposit_size(0x4e845c2c18602edd9f7f0251b467a301ad653e38d9fdbfc06cbc670a4d79166e::typus_dov_single::get_portfolio_vault(v4, arg1), arg3 + arg4);
        0x8b3ec6814a0613c96fd35931dad7f6bc380e5de89e7a66691852fe8f10b9387::vault::split_deposit_receipt(0x4e845c2c18602edd9f7f0251b467a301ad653e38d9fdbfc06cbc670a4d79166e::typus_dov_single::get_mut_deposit_vault(v5, arg1), arg2, arg3, arg4, arg5)
    }

    public(friend) entry fun transfer_bid_receipt<T0, T1>(arg0: &mut 0x4e845c2c18602edd9f7f0251b467a301ad653e38d9fdbfc06cbc670a4d79166e::typus_dov_single::Registry, arg1: u64, arg2: vector<0x8b3ec6814a0613c96fd35931dad7f6bc380e5de89e7a66691852fe8f10b9387::vault::TypusBidReceipt>, arg3: 0x1::option::Option<u64>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        safety_check<T0, T1>(arg0, arg1);
        let (_, _, _, _, v4, _, _, v7, _, _, _, _) = 0x4e845c2c18602edd9f7f0251b467a301ad653e38d9fdbfc06cbc670a4d79166e::typus_dov_single::get_mut_registry_inner(arg0);
        let (v12, v13, v14) = 0x8b3ec6814a0613c96fd35931dad7f6bc380e5de89e7a66691852fe8f10b9387::vault::split_bid_receipt(0x4e845c2c18602edd9f7f0251b467a301ad653e38d9fdbfc06cbc670a4d79166e::typus_dov_single::get_mut_bid_vault(v7, arg1), arg2, arg3, arg5);
        let v15 = v14;
        0x4e845c2c18602edd9f7f0251b467a301ad653e38d9fdbfc06cbc670a4d79166e::typus_dov_single::validate_amount(v12);
        0x2::transfer::public_transfer<0x8b3ec6814a0613c96fd35931dad7f6bc380e5de89e7a66691852fe8f10b9387::vault::TypusBidReceipt>(0x1::option::destroy_some<0x8b3ec6814a0613c96fd35931dad7f6bc380e5de89e7a66691852fe8f10b9387::vault::TypusBidReceipt>(v13), arg4);
        if (0x1::option::is_some<0x8b3ec6814a0613c96fd35931dad7f6bc380e5de89e7a66691852fe8f10b9387::vault::TypusBidReceipt>(&v15)) {
            0x2::transfer::public_transfer<0x8b3ec6814a0613c96fd35931dad7f6bc380e5de89e7a66691852fe8f10b9387::vault::TypusBidReceipt>(0x1::option::destroy_some<0x8b3ec6814a0613c96fd35931dad7f6bc380e5de89e7a66691852fe8f10b9387::vault::TypusBidReceipt>(v15), 0x2::tx_context::sender(arg5));
        } else {
            0x1::option::destroy_none<0x8b3ec6814a0613c96fd35931dad7f6bc380e5de89e7a66691852fe8f10b9387::vault::TypusBidReceipt>(v15);
        };
        0x4e845c2c18602edd9f7f0251b467a301ad653e38d9fdbfc06cbc670a4d79166e::typus_dov_single::emit_transfer_bid_receipt_event(0x4e845c2c18602edd9f7f0251b467a301ad653e38d9fdbfc06cbc670a4d79166e::typus_dov_single::get_portfolio_vault(v4, arg1), v12, arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

