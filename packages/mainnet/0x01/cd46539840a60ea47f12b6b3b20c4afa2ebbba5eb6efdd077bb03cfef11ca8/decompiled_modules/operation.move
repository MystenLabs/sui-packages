module 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::operation {
    struct OperationStarted has copy, drop {
        vault_id: address,
        defi_asset_ids: vector<u8>,
        defi_asset_types: vector<0x1::type_name::TypeName>,
        principal_coin_type: 0x1::type_name::TypeName,
        principal_amount: u64,
        coin_type_asset_type: 0x1::type_name::TypeName,
        coin_type_asset_amount: u64,
        total_usd_value: u256,
    }

    struct OperationEnded has copy, drop {
        vault_id: address,
        defi_asset_ids: vector<u8>,
        defi_asset_types: vector<0x1::type_name::TypeName>,
        principal_coin_type: 0x1::type_name::TypeName,
        principal_amount: u64,
        coin_type_asset_type: 0x1::type_name::TypeName,
        coin_type_asset_amount: u64,
    }

    struct OperationValueUpdateChecked has copy, drop {
        vault_id: address,
        total_usd_value_before: u256,
        total_usd_value_after: u256,
        loss: u256,
    }

    struct TxBag {
        vault_id: address,
        defi_asset_ids: vector<u8>,
        defi_asset_types: vector<0x1::type_name::TypeName>,
    }

    struct TxBagForCheckValueUpdate {
        vault_id: address,
        defi_asset_ids: vector<u8>,
        defi_asset_types: vector<0x1::type_name::TypeName>,
        total_usd_value: u256,
        total_shares: u256,
    }

    public fun add_new_coin_type_asset<T0, T1>(arg0: &0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::Operation, arg1: &0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::OperatorCap, arg2: &mut 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::Vault<T0>) {
        0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::assert_operator_not_freezed(arg0, arg1);
        0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::assert_single_vault_operator_paired(arg0, 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::vault_id<T0>(arg2), arg1);
        0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::add_new_coin_type_asset<T0, T1>(arg2);
    }

    public fun add_new_defi_asset<T0, T1: store + key>(arg0: &0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::Operation, arg1: &0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::OperatorCap, arg2: &mut 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::Vault<T0>, arg3: u8, arg4: T1) {
        0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::assert_operator_not_freezed(arg0, arg1);
        0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::assert_single_vault_operator_paired(arg0, 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::vault_id<T0>(arg2), arg1);
        0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::add_new_defi_asset<T0, T1>(arg2, arg3, arg4);
    }

    public fun batch_execute_deposit<T0>(arg0: &0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::Operation, arg1: &0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::OperatorCap, arg2: &mut 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::Vault<T0>, arg3: &mut 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::reward_manager::RewardManager<T0>, arg4: &0x2::clock::Clock, arg5: &0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault_oracle::OracleConfig, arg6: vector<u64>, arg7: vector<u256>) {
        0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::assert_operator_not_freezed(arg0, arg1);
        0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::assert_single_vault_operator_paired(arg0, 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::vault_id<T0>(arg2), arg1);
        0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::reward_manager::update_reward_buffers<T0>(arg3, arg2, arg4);
        0x1::vector::reverse<u64>(&mut arg6);
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg6)) {
            let v1 = 0x1::vector::pop_back<u64>(&mut arg6);
            0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::reward_manager::update_receipt_reward<T0>(arg3, arg2, 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::deposit_request::receipt_id(0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::deposit_request<T0>(arg2, v1)));
            let (_, v3) = 0x1::vector::index_of<u64>(&arg6, &v1);
            0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::execute_deposit<T0>(arg2, arg4, arg5, v1, *0x1::vector::borrow<u256>(&arg7, v3));
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<u64>(arg6);
    }

    public fun batch_execute_withdraw<T0>(arg0: &0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::Operation, arg1: &0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::OperatorCap, arg2: &mut 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::Vault<T0>, arg3: &mut 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::reward_manager::RewardManager<T0>, arg4: &0x2::clock::Clock, arg5: &0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault_oracle::OracleConfig, arg6: vector<u64>, arg7: vector<u64>, arg8: &mut 0x2::tx_context::TxContext) {
        0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::assert_operator_not_freezed(arg0, arg1);
        0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::assert_single_vault_operator_paired(arg0, 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::vault_id<T0>(arg2), arg1);
        0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::reward_manager::update_reward_buffers<T0>(arg3, arg2, arg4);
        0x1::vector::reverse<u64>(&mut arg6);
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg6)) {
            let v1 = 0x1::vector::pop_back<u64>(&mut arg6);
            0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::reward_manager::update_receipt_reward<T0>(arg3, arg2, 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::withdraw_request::receipt_id(0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::withdraw_request<T0>(arg2, v1)));
            let (_, v3) = 0x1::vector::index_of<u64>(&arg6, &v1);
            let (v4, v5) = 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::execute_withdraw<T0>(arg2, arg4, arg5, v1, *0x1::vector::borrow<u64>(&arg7, v3));
            if (v5 != 0x2::address::from_u256(0)) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v4, arg8), v5);
            } else {
                0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::add_claimable_principal<T0>(arg2, v4);
            };
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<u64>(arg6);
    }

    public fun cancel_user_deposit<T0>(arg0: &0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::Operation, arg1: &0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::OperatorCap, arg2: &mut 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::Vault<T0>, arg3: u64, arg4: address, arg5: address, arg6: &0x2::clock::Clock) {
        0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::assert_operator_not_freezed(arg0, arg1);
        0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::assert_single_vault_operator_paired(arg0, 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::vault_id<T0>(arg2), arg1);
        0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::receipt_cancellation::assert_receipt_can_be_cancelled_from_vault<T0>(arg2, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::cancel_deposit<T0>(arg2, arg6, arg3, arg4, arg5), arg5);
    }

    public fun cancel_user_withdraw<T0>(arg0: &0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::Operation, arg1: &0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::OperatorCap, arg2: &mut 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::Vault<T0>, arg3: u64, arg4: address, arg5: address, arg6: &0x2::clock::Clock) : u256 {
        0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::assert_operator_not_freezed(arg0, arg1);
        0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::assert_single_vault_operator_paired(arg0, 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::vault_id<T0>(arg2), arg1);
        0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::cancel_withdraw<T0>(arg2, arg6, arg3, arg4, arg5)
    }

    public fun deposit_by_operator<T0>(arg0: &0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::Operation, arg1: &0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::OperatorCap, arg2: &mut 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::Vault<T0>, arg3: &0x2::clock::Clock, arg4: &0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault_oracle::OracleConfig, arg5: 0x2::coin::Coin<T0>) {
        0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::assert_operator_not_freezed(arg0, arg1);
        0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::assert_single_vault_operator_paired(arg0, 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::vault_id<T0>(arg2), arg1);
        0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::deposit_by_operator<T0>(arg2, arg3, arg4, arg5);
    }

    public fun end_op_value_update_with_bag<T0, T1: store + key>(arg0: &mut 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::Vault<T0>, arg1: &0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::Operation, arg2: &0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::OperatorCap, arg3: &0x2::clock::Clock, arg4: TxBagForCheckValueUpdate) {
        0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::assert_operator_not_freezed(arg1, arg2);
        0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::assert_single_vault_operator_paired(arg1, 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::vault_id<T0>(arg0), arg2);
        0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::assert_during_operation<T0>(arg0);
        let TxBagForCheckValueUpdate {
            vault_id         : v0,
            defi_asset_ids   : v1,
            defi_asset_types : v2,
            total_usd_value  : v3,
            total_shares     : v4,
        } = arg4;
        let v5 = v2;
        let v6 = v1;
        assert!(0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::vault_id<T0>(arg0) == v0, 1004);
        let v7 = 0;
        while (v7 < 0x1::vector::length<u8>(&v6)) {
            assert!(*0x1::vector::borrow<0x1::type_name::TypeName>(&v5, v7) == 0x1::type_name::get<T1>(), 1005);
            assert!(0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::contains_asset_type<T0>(arg0, 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault_utils::parse_key<T1>(*0x1::vector::borrow<u8>(&v6, v7))), 1003);
            v7 = v7 + 1;
        };
        0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::check_op_value_update_record<T0>(arg0);
        let v8 = 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::get_total_usd_value<T0>(arg0, arg3);
        let v9 = 0;
        if (v8 < v3) {
            let v10 = v3 - v8;
            v9 = v10;
            0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::update_tolerance<T0>(arg0, v10);
        };
        assert!(0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::total_shares<T0>(arg0) == v4, 1001);
        let v11 = OperationValueUpdateChecked{
            vault_id               : 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::vault_id<T0>(arg0),
            total_usd_value_before : v3,
            total_usd_value_after  : v8,
            loss                   : v9,
        };
        0x2::event::emit<OperationValueUpdateChecked>(v11);
        0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::set_status<T0>(arg0, 0);
        0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::clear_op_value_update_record<T0>(arg0);
    }

    public fun end_op_with_bag<T0, T1, T2: store + key>(arg0: &mut 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::Vault<T0>, arg1: &0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::Operation, arg2: &0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::OperatorCap, arg3: 0x2::bag::Bag, arg4: TxBag, arg5: 0x2::balance::Balance<T0>, arg6: 0x2::balance::Balance<T1>) {
        0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::assert_operator_not_freezed(arg1, arg2);
        0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::assert_single_vault_operator_paired(arg1, 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::vault_id<T0>(arg0), arg2);
        0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::assert_during_operation<T0>(arg0);
        let TxBag {
            vault_id         : v0,
            defi_asset_ids   : v1,
            defi_asset_types : v2,
        } = arg4;
        let v3 = v2;
        let v4 = v1;
        assert!(0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::vault_id<T0>(arg0) == v0, 1004);
        let v5 = 0;
        while (v5 < 0x1::vector::length<u8>(&v4)) {
            let v6 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v3, v5);
            assert!(v6 == 0x1::type_name::get<T2>(), 1005);
            let v7 = 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault_utils::parse_key<T2>(*0x1::vector::borrow<u8>(&v4, v5));
            if (v6 == 0x1::type_name::get<0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::receipt::Receipt>()) {
                let v8 = 0x2::bag::remove<0x1::ascii::String, 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::receipt::Receipt>(&mut arg3, v7);
                0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::receipt_cancellation::assert_receipt_can_not_be_cancelled(&v8);
                0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::return_defi_asset<T0, 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::receipt::Receipt>(arg0, v7, v8);
            } else {
                0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::return_defi_asset<T0, T2>(arg0, v7, 0x2::bag::remove<0x1::ascii::String, T2>(&mut arg3, v7));
            };
            v5 = v5 + 1;
        };
        let v9 = OperationEnded{
            vault_id               : 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::vault_id<T0>(arg0),
            defi_asset_ids         : v4,
            defi_asset_types       : v3,
            principal_coin_type    : 0x1::type_name::get<T0>(),
            principal_amount       : 0x2::balance::value<T0>(&arg5),
            coin_type_asset_type   : 0x1::type_name::get<T1>(),
            coin_type_asset_amount : 0x2::balance::value<T1>(&arg6),
        };
        0x2::event::emit<OperationEnded>(v9);
        0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::return_free_principal<T0>(arg0, arg5);
        if (0x2::balance::value<T1>(&arg6) > 0) {
            0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::return_coin_type_asset<T0, T1>(arg0, arg6);
        } else {
            0x2::balance::destroy_zero<T1>(arg6);
        };
        0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::enable_op_value_update<T0>(arg0);
        0x2::bag::destroy_empty(arg3);
    }

    public fun execute_deposit<T0>(arg0: &0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::Operation, arg1: &0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::OperatorCap, arg2: &mut 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::Vault<T0>, arg3: &mut 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::reward_manager::RewardManager<T0>, arg4: &0x2::clock::Clock, arg5: &0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault_oracle::OracleConfig, arg6: u64, arg7: u256) {
        0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::assert_operator_not_freezed(arg0, arg1);
        0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::assert_single_vault_operator_paired(arg0, 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::vault_id<T0>(arg2), arg1);
        0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::reward_manager::update_reward_buffers<T0>(arg3, arg2, arg4);
        0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::reward_manager::update_receipt_reward<T0>(arg3, arg2, 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::deposit_request::receipt_id(0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::deposit_request<T0>(arg2, arg6)));
        0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::execute_deposit<T0>(arg2, arg4, arg5, arg6, arg7);
    }

    public fun execute_withdraw<T0>(arg0: &0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::Operation, arg1: &0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::OperatorCap, arg2: &mut 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::Vault<T0>, arg3: &mut 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::reward_manager::RewardManager<T0>, arg4: &0x2::clock::Clock, arg5: &0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault_oracle::OracleConfig, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::assert_operator_not_freezed(arg0, arg1);
        0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::assert_single_vault_operator_paired(arg0, 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::vault_id<T0>(arg2), arg1);
        0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::reward_manager::update_reward_buffers<T0>(arg3, arg2, arg4);
        0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::reward_manager::update_receipt_reward<T0>(arg3, arg2, 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::withdraw_request::receipt_id(0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::withdraw_request<T0>(arg2, arg6)));
        let (v0, v1) = 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::execute_withdraw<T0>(arg2, arg4, arg5, arg6, arg7);
        if (v1 != 0x2::address::from_u256(0)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg8), v1);
        } else {
            0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::add_claimable_principal<T0>(arg2, v0);
        };
    }

    public(friend) fun pre_vault_check<T0>(arg0: &mut 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::Vault<T0>, arg1: &0x2::tx_context::TxContext) {
        0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::assert_normal<T0>(arg0);
        0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::set_status<T0>(arg0, 1);
        0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::try_reset_tolerance<T0>(arg0, false, arg1);
    }

    public fun remove_coin_type_asset<T0, T1>(arg0: &0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::Operation, arg1: &0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::OperatorCap, arg2: &mut 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::Vault<T0>) {
        0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::assert_operator_not_freezed(arg0, arg1);
        0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::assert_single_vault_operator_paired(arg0, 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::vault_id<T0>(arg2), arg1);
        0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::remove_coin_type_asset<T0, T1>(arg2);
    }

    public fun remove_defi_asset_support<T0, T1: store + key>(arg0: &0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::Operation, arg1: &0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::OperatorCap, arg2: &mut 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::Vault<T0>, arg3: u8) : T1 {
        0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::assert_operator_not_freezed(arg0, arg1);
        0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::assert_single_vault_operator_paired(arg0, 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::vault_id<T0>(arg2), arg1);
        0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::remove_defi_asset_support<T0, T1>(arg2, arg3)
    }

    public fun start_op_with_bag<T0, T1, T2: store + key>(arg0: &mut 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::Vault<T0>, arg1: &0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::Operation, arg2: &0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::OperatorCap, arg3: &0x2::clock::Clock, arg4: vector<u8>, arg5: vector<0x1::type_name::TypeName>, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : (0x2::bag::Bag, TxBag, TxBagForCheckValueUpdate, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::assert_operator_not_freezed(arg1, arg2);
        0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::assert_single_vault_operator_paired(arg1, 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::vault_id<T0>(arg0), arg2);
        pre_vault_check<T0>(arg0, arg8);
        let v0 = 0x2::bag::new(arg8);
        let v1 = 0x1::vector::length<u8>(&arg4);
        assert!(v1 == 0x1::vector::length<0x1::type_name::TypeName>(&arg5), 1002);
        let v2 = 0;
        while (v2 < v1) {
            assert!(*0x1::vector::borrow<0x1::type_name::TypeName>(&arg5, v2) == 0x1::type_name::get<T2>(), 1005);
            let v3 = 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault_utils::parse_key<T2>(*0x1::vector::borrow<u8>(&arg4, v2));
            0x2::bag::add<0x1::ascii::String, T2>(&mut v0, v3, 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::borrow_defi_asset<T0, T2>(arg0, v3));
            v2 = v2 + 1;
        };
        let v4 = if (arg6 > 0) {
            0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::borrow_free_principal<T0>(arg0, arg6)
        } else {
            0x2::balance::zero<T0>()
        };
        let v5 = if (arg7 > 0) {
            0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::borrow_coin_type_asset<T0, T1>(arg0, arg7)
        } else {
            0x2::balance::zero<T1>()
        };
        let v6 = 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::get_total_usd_value<T0>(arg0, arg3);
        let v7 = TxBag{
            vault_id         : 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::vault_id<T0>(arg0),
            defi_asset_ids   : arg4,
            defi_asset_types : arg5,
        };
        let v8 = TxBagForCheckValueUpdate{
            vault_id         : 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::vault_id<T0>(arg0),
            defi_asset_ids   : arg4,
            defi_asset_types : arg5,
            total_usd_value  : v6,
            total_shares     : 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::total_shares<T0>(arg0),
        };
        let v9 = OperationStarted{
            vault_id               : 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::vault_id<T0>(arg0),
            defi_asset_ids         : arg4,
            defi_asset_types       : arg5,
            principal_coin_type    : 0x1::type_name::get<T0>(),
            principal_amount       : arg6,
            coin_type_asset_type   : 0x1::type_name::get<T1>(),
            coin_type_asset_amount : arg7,
            total_usd_value        : v6,
        };
        0x2::event::emit<OperationStarted>(v9);
        (v0, v7, v8, v4, v5)
    }

    // decompiled from Move bytecode v6
}

