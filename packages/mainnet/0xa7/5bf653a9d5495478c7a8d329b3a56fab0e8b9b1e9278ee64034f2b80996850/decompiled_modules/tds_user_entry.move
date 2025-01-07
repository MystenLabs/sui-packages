module 0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::tds_user_entry {
    public fun claim<T0, T1>(arg0: &mut 0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::Registry, arg1: u64, arg2: vector<0xa2de2f04907b77ef03800a8969bb4f88c821737ee133aba4bc0485b267ad2118::vault::TypusDepositReceipt>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x1::option::Option<0xa2de2f04907b77ef03800a8969bb4f88c821737ee133aba4bc0485b267ad2118::vault::TypusDepositReceipt>, vector<u64>) {
        safety_check<T0, T1>(arg0, arg1);
        let (_, _, _, _, v4, v5, _, _, _, _, _, _) = 0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::get_mut_registry_inner(arg0);
        let (v12, v13, v14) = 0xa2de2f04907b77ef03800a8969bb4f88c821737ee133aba4bc0485b267ad2118::vault::public_claim<T0>(0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::get_mut_deposit_vault(v5, arg1), arg2, arg3);
        let v15 = v14;
        let v16 = *0x1::vector::borrow<u64>(&v15, 0);
        0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::validate_amount(v16);
        0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::emit_claim_event(0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::get_portfolio_vault(v4, arg1), v16, arg3);
        (0x1::option::destroy_some<0x2::balance::Balance<T0>>(v12), v13, v15)
    }

    public(friend) fun compound<T0, T1>(arg0: &mut 0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::Registry, arg1: u64, arg2: vector<0xa2de2f04907b77ef03800a8969bb4f88c821737ee133aba4bc0485b267ad2118::vault::TypusDepositReceipt>, arg3: &mut 0x2::tx_context::TxContext) : (0xa2de2f04907b77ef03800a8969bb4f88c821737ee133aba4bc0485b267ad2118::vault::TypusDepositReceipt, vector<u64>) {
        safety_check<T0, T1>(arg0, arg1);
        let (_, _, _, v3, v4, v5, _, _, _, _, _, _) = 0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::get_mut_registry_inner(arg0);
        let v12 = 0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::get_portfolio_vault(v4, arg1);
        let (v13, v14) = 0xa2de2f04907b77ef03800a8969bb4f88c821737ee133aba4bc0485b267ad2118::vault::public_compound<T0>(v3, 0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::get_mut_deposit_vault(v5, arg1), arg2, arg3);
        let v15 = v14;
        let v16 = *0x1::vector::borrow<u64>(&v15, 0);
        0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::validate_amount(v16);
        0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::validate_capacity(arg0, arg1);
        0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::emit_compound_event(v12, v16, *0x1::vector::borrow<u64>(&v15, 1), *0x1::vector::borrow<u64>(&v15, 2), arg3);
        0x1::vector::push_back<u64>(&mut v15, 0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::calculate_in_usd<T0>(v12, v16, false));
        (0x1::option::destroy_some<0xa2de2f04907b77ef03800a8969bb4f88c821737ee133aba4bc0485b267ad2118::vault::TypusDepositReceipt>(v13), v15)
    }

    public(friend) fun deposit<T0, T1>(arg0: &mut 0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::Registry, arg1: u64, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: vector<0xa2de2f04907b77ef03800a8969bb4f88c821737ee133aba4bc0485b267ad2118::vault::TypusDepositReceipt>, arg5: &mut 0x2::tx_context::TxContext) : (vector<0x2::coin::Coin<T0>>, 0xa2de2f04907b77ef03800a8969bb4f88c821737ee133aba4bc0485b267ad2118::vault::TypusDepositReceipt, vector<u64>) {
        safety_check<T0, T1>(arg0, arg1);
        let (_, _, _, _, v4, v5, _, _, _, _, _, _) = 0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::get_mut_registry_inner(arg0);
        let v12 = 0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::get_portfolio_vault(v4, arg1);
        0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::validate_deposit_amount(v12, arg3);
        let (v13, v14, v15) = 0xa2de2f04907b77ef03800a8969bb4f88c821737ee133aba4bc0485b267ad2118::vault::public_deposit<T0>(0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::get_mut_deposit_vault(v5, arg1), arg2, arg3, arg4, arg5);
        let v16 = v15;
        let v17 = *0x1::vector::borrow<u64>(&v16, 0);
        0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::validate_amount(v17);
        0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::validate_capacity(arg0, arg1);
        0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::emit_deposit_event(v12, v17, arg5);
        0x1::vector::push_back<u64>(&mut v16, 0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::calculate_in_usd<T0>(v12, v17, false));
        (v13, 0x1::option::destroy_some<0xa2de2f04907b77ef03800a8969bb4f88c821737ee133aba4bc0485b267ad2118::vault::TypusDepositReceipt>(v14), v16)
    }

    public fun exercise<T0, T1>(arg0: &mut 0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::Registry, arg1: u64, arg2: vector<0xa2de2f04907b77ef03800a8969bb4f88c821737ee133aba4bc0485b267ad2118::vault::TypusBidReceipt>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, vector<u64>) {
        safety_check<T0, T1>(arg0, arg1);
        let (_, _, _, _, v4, _, _, v7, _, _, _, _) = 0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::get_mut_registry_inner(arg0);
        let v12 = 0xa2de2f04907b77ef03800a8969bb4f88c821737ee133aba4bc0485b267ad2118::vault::get_bid_receipt_vid(0x1::vector::borrow<0xa2de2f04907b77ef03800a8969bb4f88c821737ee133aba4bc0485b267ad2118::vault::TypusBidReceipt>(&arg2, 0));
        let (v13, v14) = 0xa2de2f04907b77ef03800a8969bb4f88c821737ee133aba4bc0485b267ad2118::vault::public_exercise<T0>(0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::get_mut_bid_vault_by_id(v7, &v12), arg2);
        let v15 = v14;
        0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::emit_exercise_event(0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::get_portfolio_vault(v4, arg1), *0x1::vector::borrow<u64>(&v15, 0), *0x1::vector::borrow<u64>(&v15, 1), 0x1::option::none<0x1::type_name::TypeName>(), 0, arg3);
        (v13, v15)
    }

    public fun harvest<T0, T1>(arg0: &mut 0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::Registry, arg1: u64, arg2: vector<0xa2de2f04907b77ef03800a8969bb4f88c821737ee133aba4bc0485b267ad2118::vault::TypusDepositReceipt>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x1::option::Option<0xa2de2f04907b77ef03800a8969bb4f88c821737ee133aba4bc0485b267ad2118::vault::TypusDepositReceipt>, vector<u64>) {
        safety_check<T0, T1>(arg0, arg1);
        let (_, _, _, v3, v4, v5, _, _, _, _, _, _) = 0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::get_mut_registry_inner(arg0);
        let (v12, v13, v14) = 0xa2de2f04907b77ef03800a8969bb4f88c821737ee133aba4bc0485b267ad2118::vault::public_harvest<T1>(v3, 0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::get_mut_deposit_vault(v5, arg1), arg2, arg3);
        let v15 = v14;
        let v16 = *0x1::vector::borrow<u64>(&v15, 0);
        0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::validate_amount(v16);
        0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::emit_harvest_event(0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::get_portfolio_vault(v4, arg1), v16, *0x1::vector::borrow<u64>(&v15, 1), *0x1::vector::borrow<u64>(&v15, 2), arg3);
        (0x1::option::destroy_some<0x2::balance::Balance<T1>>(v12), v13, v15)
    }

    public(friend) fun new_bid<T0, T1>(arg0: &mut 0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::Registry, arg1: u64, arg2: vector<0x2::coin::Coin<T1>>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0xa2de2f04907b77ef03800a8969bb4f88c821737ee133aba4bc0485b267ad2118::vault::TypusBidReceipt, vector<u64>) {
        safety_check<T0, T1>(arg0, arg1);
        let (v0, _, _, _, v4, _, v6, v7, v8, _, _, _) = 0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::get_mut_registry_inner(arg0);
        let v12 = 0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::get_mut_portfolio_vault(v4, arg1);
        let v13 = 0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::get_mut_auction(v6, arg1);
        0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::validate_bid_amount(v12, v13, arg3);
        let v14 = 0xa2de2f04907b77ef03800a8969bb4f88c821737ee133aba4bc0485b267ad2118::dutch::size(v13);
        let v15 = 0xa2de2f04907b77ef03800a8969bb4f88c821737ee133aba4bc0485b267ad2118::dutch::total_bid_size(v13);
        let v16 = if (v15 + arg3 > v14) {
            v14 - v15
        } else {
            arg3
        };
        let v17 = 0;
        let (v18, v19, v20, v21, v22, v23, _) = 0xa2de2f04907b77ef03800a8969bb4f88c821737ee133aba4bc0485b267ad2118::dutch::new_bid_v2<T1>(0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::get_mut_refund_vault<T1>(v8), v13, v16, arg2, 0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::get_new_bid_incentive_balance<T1>(v0, v12, v13, v16, v17, arg4), v17, arg4, arg5);
        0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::emit_new_bid_event(v12, v18, v19, v20, v21, v22, v23, arg5);
        let v25 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v25, 0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::calculate_in_usd<T1>(v12, v21, false));
        (0xa2de2f04907b77ef03800a8969bb4f88c821737ee133aba4bc0485b267ad2118::vault::public_new_bid(0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::get_mut_bid_vault(v7, arg1), v20, arg5), v25)
    }

    public fun public_transfer_bid_receipt<T0, T1>(arg0: &mut 0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::Registry, arg1: u64, arg2: vector<0xa2de2f04907b77ef03800a8969bb4f88c821737ee133aba4bc0485b267ad2118::vault::TypusBidReceipt>, arg3: 0x1::option::Option<u64>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) : (0x1::option::Option<0xa2de2f04907b77ef03800a8969bb4f88c821737ee133aba4bc0485b267ad2118::vault::TypusBidReceipt>, vector<u64>) {
        safety_check<T0, T1>(arg0, arg1);
        let (_, _, _, _, v4, _, _, v7, _, _, _, _) = 0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::get_mut_registry_inner(arg0);
        let v12 = 0xa2de2f04907b77ef03800a8969bb4f88c821737ee133aba4bc0485b267ad2118::vault::get_bid_receipt_vid(0x1::vector::borrow<0xa2de2f04907b77ef03800a8969bb4f88c821737ee133aba4bc0485b267ad2118::vault::TypusBidReceipt>(&arg2, 0));
        let (v13, v14, v15) = 0xa2de2f04907b77ef03800a8969bb4f88c821737ee133aba4bc0485b267ad2118::vault::split_bid_receipt(0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::get_mut_bid_vault_by_id_or_index(v7, &v12, arg1), arg2, arg3, arg5);
        0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::validate_amount(v13);
        0x2::transfer::public_transfer<0xa2de2f04907b77ef03800a8969bb4f88c821737ee133aba4bc0485b267ad2118::vault::TypusBidReceipt>(0x1::option::destroy_some<0xa2de2f04907b77ef03800a8969bb4f88c821737ee133aba4bc0485b267ad2118::vault::TypusBidReceipt>(v14), arg4);
        0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::emit_transfer_bid_receipt_event(0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::get_portfolio_vault(v4, arg1), v13, arg4, arg5);
        let v16 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v16, v13);
        (v15, v16)
    }

    public fun rebate<T0>(arg0: &mut 0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::Registry, arg1: &mut 0x2::tx_context::TxContext) : (0x1::option::Option<0x2::balance::Balance<T0>>, vector<u64>) {
        0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::version_check(arg0);
        0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::operation_check(arg0);
        let (_, _, _, _, _, _, _, _, v8, _, _, _) = 0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::get_mut_registry_inner(arg0);
        let (v12, v13) = 0xa2de2f04907b77ef03800a8969bb4f88c821737ee133aba4bc0485b267ad2118::vault::public_rebate<T0>(0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::get_mut_refund_vault<T0>(v8), 0x2::tx_context::sender(arg1));
        let v14 = v13;
        let v15 = *0x1::vector::borrow<u64>(&v14, 0);
        0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::validate_amount(v15);
        0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::emit_refund_event(0x1::type_name::get<T0>(), v15, arg1);
        (v12, v14)
    }

    public fun redeem<T0, T1, T2>(arg0: &mut 0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::Registry, arg1: u64, arg2: vector<0xa2de2f04907b77ef03800a8969bb4f88c821737ee133aba4bc0485b267ad2118::vault::TypusDepositReceipt>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T2>, 0x1::option::Option<0xa2de2f04907b77ef03800a8969bb4f88c821737ee133aba4bc0485b267ad2118::vault::TypusDepositReceipt>, vector<u64>) {
        safety_check<T0, T1>(arg0, arg1);
        let (_, _, _, v3, v4, v5, _, _, _, _, _, _) = 0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::get_mut_registry_inner(arg0);
        let (v12, v13, v14) = 0xa2de2f04907b77ef03800a8969bb4f88c821737ee133aba4bc0485b267ad2118::vault::public_redeem<T2>(v3, 0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::get_mut_deposit_vault(v5, arg1), arg2, arg3);
        let v15 = v14;
        let v16 = *0x1::vector::borrow<u64>(&v15, 0);
        0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::validate_amount(v16);
        0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::emit_redeem_event(0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::get_portfolio_vault(v4, arg1), 0x1::type_name::get<T2>(), v16, *0x1::vector::borrow<u64>(&v15, 1), *0x1::vector::borrow<u64>(&v15, 2), arg3);
        (0x1::option::destroy_some<0x2::balance::Balance<T2>>(v12), v13, v15)
    }

    fun safety_check<T0, T1>(arg0: &0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::Registry, arg1: u64) {
        0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::version_check(arg0);
        0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::operation_check(arg0);
        0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::portfolio_vault_token_check<T0, T1>(arg0, arg1);
    }

    public fun split_bid_receipt<T0, T1>(arg0: &mut 0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::Registry, arg1: u64, arg2: vector<0xa2de2f04907b77ef03800a8969bb4f88c821737ee133aba4bc0485b267ad2118::vault::TypusBidReceipt>, arg3: 0x1::option::Option<u64>, arg4: &mut 0x2::tx_context::TxContext) : (u64, 0x1::option::Option<0xa2de2f04907b77ef03800a8969bb4f88c821737ee133aba4bc0485b267ad2118::vault::TypusBidReceipt>, 0x1::option::Option<0xa2de2f04907b77ef03800a8969bb4f88c821737ee133aba4bc0485b267ad2118::vault::TypusBidReceipt>) {
        abort 999
    }

    public(friend) entry fun transfer_bid_receipt<T0, T1>(arg0: &mut 0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::Registry, arg1: u64, arg2: vector<0xa2de2f04907b77ef03800a8969bb4f88c821737ee133aba4bc0485b267ad2118::vault::TypusBidReceipt>, arg3: 0x1::option::Option<u64>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        safety_check<T0, T1>(arg0, arg1);
        let (_, _, _, _, v4, _, _, v7, _, _, _, _) = 0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::get_mut_registry_inner(arg0);
        let (v12, v13, v14) = 0xa2de2f04907b77ef03800a8969bb4f88c821737ee133aba4bc0485b267ad2118::vault::split_bid_receipt(0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::get_mut_bid_vault(v7, arg1), arg2, arg3, arg5);
        let v15 = v14;
        0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::validate_amount(v12);
        0x2::transfer::public_transfer<0xa2de2f04907b77ef03800a8969bb4f88c821737ee133aba4bc0485b267ad2118::vault::TypusBidReceipt>(0x1::option::destroy_some<0xa2de2f04907b77ef03800a8969bb4f88c821737ee133aba4bc0485b267ad2118::vault::TypusBidReceipt>(v13), arg4);
        if (0x1::option::is_some<0xa2de2f04907b77ef03800a8969bb4f88c821737ee133aba4bc0485b267ad2118::vault::TypusBidReceipt>(&v15)) {
            0x2::transfer::public_transfer<0xa2de2f04907b77ef03800a8969bb4f88c821737ee133aba4bc0485b267ad2118::vault::TypusBidReceipt>(0x1::option::destroy_some<0xa2de2f04907b77ef03800a8969bb4f88c821737ee133aba4bc0485b267ad2118::vault::TypusBidReceipt>(v15), 0x2::tx_context::sender(arg5));
        } else {
            0x1::option::destroy_none<0xa2de2f04907b77ef03800a8969bb4f88c821737ee133aba4bc0485b267ad2118::vault::TypusBidReceipt>(v15);
        };
        0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::emit_transfer_bid_receipt_event(0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::get_portfolio_vault(v4, arg1), v12, arg4, arg5);
    }

    public(friend) fun unsubscribe<T0, T1>(arg0: &mut 0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::Registry, arg1: u64, arg2: vector<0xa2de2f04907b77ef03800a8969bb4f88c821737ee133aba4bc0485b267ad2118::vault::TypusDepositReceipt>, arg3: 0x1::option::Option<u64>, arg4: &mut 0x2::tx_context::TxContext) : (0xa2de2f04907b77ef03800a8969bb4f88c821737ee133aba4bc0485b267ad2118::vault::TypusDepositReceipt, vector<u64>) {
        safety_check<T0, T1>(arg0, arg1);
        let (_, _, _, _, v4, v5, _, _, _, _, _, _) = 0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::get_mut_registry_inner(arg0);
        let v12 = 0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::get_portfolio_vault(v4, arg1);
        let (v13, v14) = if (!(0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::get_scallop_deposit_amount<T0>(arg0, arg1) != 0)) {
            0xa2de2f04907b77ef03800a8969bb4f88c821737ee133aba4bc0485b267ad2118::vault::public_unsubscribe<T0>(0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::get_mut_deposit_vault(v5, arg1), arg2, arg3, arg4)
        } else {
            0xa2de2f04907b77ef03800a8969bb4f88c821737ee133aba4bc0485b267ad2118::vault::public_unsubscribe_share(0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::get_mut_deposit_vault(v5, arg1), arg2, arg3, arg4)
        };
        let v15 = v14;
        let v16 = *0x1::vector::borrow<u64>(&v15, 0);
        0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::validate_amount(v16);
        0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::emit_unsubscribe_event(v12, v16, arg4);
        0x1::vector::push_back<u64>(&mut v15, 0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::calculate_in_usd<T0>(v12, v16, true));
        (0x1::option::destroy_some<0xa2de2f04907b77ef03800a8969bb4f88c821737ee133aba4bc0485b267ad2118::vault::TypusDepositReceipt>(v13), v15)
    }

    public(friend) fun withdraw<T0, T1>(arg0: &mut 0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::Registry, arg1: u64, arg2: vector<0xa2de2f04907b77ef03800a8969bb4f88c821737ee133aba4bc0485b267ad2118::vault::TypusDepositReceipt>, arg3: 0x1::option::Option<u64>, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x1::option::Option<0xa2de2f04907b77ef03800a8969bb4f88c821737ee133aba4bc0485b267ad2118::vault::TypusDepositReceipt>, vector<u64>) {
        safety_check<T0, T1>(arg0, arg1);
        let (_, _, _, _, v4, v5, _, _, _, _, _, _) = 0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::get_mut_registry_inner(arg0);
        let v12 = 0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::get_portfolio_vault(v4, arg1);
        let (v13, v14, v15) = 0xa2de2f04907b77ef03800a8969bb4f88c821737ee133aba4bc0485b267ad2118::vault::public_withdraw<T0>(0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::get_mut_deposit_vault(v5, arg1), arg2, arg3, arg4);
        let v16 = v15;
        let v17 = *0x1::vector::borrow<u64>(&v16, 0);
        0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::validate_amount(v17);
        0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::emit_withdraw_event(v12, v17, arg4);
        0x1::vector::push_back<u64>(&mut v16, 0x6cddbfa30141e0332f8995a12453fc2cb07a2fa3dad52b342493780c7784f455::typus_dov_single::calculate_in_usd<T0>(v12, v17, true));
        (0x1::option::destroy_some<0x2::balance::Balance<T0>>(v13), v14, v16)
    }

    // decompiled from Move bytecode v6
}

