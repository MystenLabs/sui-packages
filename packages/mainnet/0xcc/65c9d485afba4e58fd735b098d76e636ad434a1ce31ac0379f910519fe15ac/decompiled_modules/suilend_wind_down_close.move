module 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_wind_down_close {
    struct PositionClosedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        debt_repaid: u64,
        collateral_withdrawn: u64,
        flash_swap_repayment: u64,
        final_assets: u64,
    }

    struct PositionCloseChunkEvent has copy, drop {
        vault_id: 0x2::object::ID,
        debt_repaid: u64,
        debt_remaining: u64,
        collateral_withdrawn: u64,
        flash_swap_repayment: u64,
        final_assets: u64,
    }

    struct RewardCollateralStoredEvent has copy, drop {
        vault_id: 0x2::object::ID,
        reward_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    public fun close_zero_debt_position_v2<T0, T1, T2, T3>(arg0: &0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::version::VersionCap, arg1: &mut 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::Vault<T0, T1, T2, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::SuilendConfig<T0, T1, T3>>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T3>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::migration_assert_unwinding_v2<T0, T1, T2, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::SuilendConfig<T0, T1, T3>>(arg0, arg1);
        let v0 = 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::migration_protocol_config_owner_v2<T0, T1, T2, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::SuilendConfig<T0, T1, T3>>(arg0, arg1);
        0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::migration_compound_borrow_interest_v2<T0, T1, T3>(arg0, v0, arg2, arg3);
        assert!(0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::borrowed_ceil<T0, T1, T3>(v0, arg2) == 0, 208);
        let v1 = 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::deposited_ctoken_amount<T0, T1, T3>(v0, arg2);
        let v2 = if (v1 == 0) {
            0x2::balance::zero<T0>()
        } else {
            0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::migration_withdraw_v2<T0, T1, T3>(arg0, v0, v1, arg2, arg3, arg4)
        };
        let v3 = v2;
        assert!(0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::deposited_ctoken_amount<T0, T1, T3>(v0, arg2) == 0, 203);
        0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::migration_join_final_assets_v2<T0, T1, T2, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::SuilendConfig<T0, T1, T3>>(arg0, arg1, v3);
        let v4 = PositionClosedEvent{
            vault_id             : 0x2::object::id<0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::Vault<T0, T1, T2, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::SuilendConfig<T0, T1, T3>>>(arg1),
            debt_repaid          : 0,
            collateral_withdrawn : 0x2::balance::value<T0>(&v3),
            flash_swap_repayment : 0,
            final_assets         : 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::final_assets_v2<T0, T1, T2, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::SuilendConfig<T0, T1, T3>>(arg1),
        };
        0x2::event::emit<PositionClosedEvent>(v4);
    }

    public fun issue_close_receipt_v2<T0, T1, T2, T3>(arg0: &0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::version::VersionCap, arg1: &mut 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::Vault<T0, T1, T2, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::SuilendConfig<T0, T1, T3>>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T3>, arg3: u128, arg4: u128, arg5: &0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::acl::Acl, arg6: &0x8139c475c58f2ec95163b91d41d9969729b75176b166d53c9ee415acff32449a::acl::AggregatorAcl, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt {
        0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::migration_assert_unwinding_v2<T0, T1, T2, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::SuilendConfig<T0, T1, T3>>(arg0, arg1);
        let v0 = 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::migration_protocol_config_owner_v2<T0, T1, T2, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::SuilendConfig<T0, T1, T3>>(arg0, arg1);
        0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::migration_compound_borrow_interest_v2<T0, T1, T3>(arg0, v0, arg2, arg7);
        let v1 = 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::borrowed_ceil<T0, T1, T3>(v0, arg2);
        assert!(v1 > 0, 206);
        0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::acl::issue_migration_generic_close_receipt<T0, T1, T2, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::SuilendConfig<T0, T1, T3>>(arg5, arg0, arg1, v1, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::migration_pool_id_v2<T0, T1, T3>(arg0, v0), arg3, arg4, arg6, arg8)
    }

    public fun issue_spring_close_receipt_v2<T0, T1, T2, T3>(arg0: &0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::version::VersionCap, arg1: &mut 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::Vault<T0, T1, T2, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::SuilendConfig<T0, T1, T3>>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T3>, arg3: &0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::acl::Acl, arg4: &0x8139c475c58f2ec95163b91d41d9969729b75176b166d53c9ee415acff32449a::acl::AggregatorAcl, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt {
        0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::migration_assert_unwinding_v2<T0, T1, T2, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::SuilendConfig<T0, T1, T3>>(arg0, arg1);
        let v0 = 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::migration_protocol_config_owner_v2<T0, T1, T2, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::SuilendConfig<T0, T1, T3>>(arg0, arg1);
        0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::migration_compound_borrow_interest_v2<T0, T1, T3>(arg0, v0, arg2, arg5);
        let v1 = 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::borrowed_ceil<T0, T1, T3>(v0, arg2);
        assert!(v1 > 0, 206);
        0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::acl::issue_migration_spring_close_receipt<T0, T1, T2, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::SuilendConfig<T0, T1, T3>>(arg3, arg0, arg1, v1, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::migration_pool_id_v2<T0, T1, T3>(arg0, v0), arg4, arg6)
    }

    public fun issue_spring_partial_close_receipt_v2<T0, T1, T2, T3>(arg0: &0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::version::VersionCap, arg1: &mut 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::Vault<T0, T1, T2, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::SuilendConfig<T0, T1, T3>>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T3>, arg3: u64, arg4: &0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::acl::Acl, arg5: &0x8139c475c58f2ec95163b91d41d9969729b75176b166d53c9ee415acff32449a::acl::AggregatorAcl, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt {
        assert!(arg3 > 0, 210);
        0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::migration_assert_unwinding_v2<T0, T1, T2, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::SuilendConfig<T0, T1, T3>>(arg0, arg1);
        let v0 = 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::migration_protocol_config_owner_v2<T0, T1, T2, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::SuilendConfig<T0, T1, T3>>(arg0, arg1);
        0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::migration_compound_borrow_interest_v2<T0, T1, T3>(arg0, v0, arg2, arg6);
        let v1 = 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::borrowed_ceil<T0, T1, T3>(v0, arg2);
        assert!(v1 > 0, 206);
        0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::acl::issue_migration_spring_close_receipt<T0, T1, T2, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::SuilendConfig<T0, T1, T3>>(arg4, arg0, arg1, 0x1::u64::min(v1, arg3), 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::migration_pool_id_v2<T0, T1, T3>(arg0, v0), arg5, arg7)
    }

    public fun process_close_receipt_v2<T0, T1, T2, T3>(arg0: &0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::version::VersionCap, arg1: &mut 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::Vault<T0, T1, T2, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::SuilendConfig<T0, T1, T3>>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T3>, arg3: &mut 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt, arg4: &0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::acl::Acl, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::migration_assert_unwinding_v2<T0, T1, T2, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::SuilendConfig<T0, T1, T3>>(arg0, arg1);
        let (v0, v1, v2) = 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::acl::take_migration_close_inputs<T0, T1, T2, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::SuilendConfig<T0, T1, T3>>(arg4, arg0, arg1, arg3);
        let v3 = 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::migration_protocol_config_owner_v2<T0, T1, T2, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::SuilendConfig<T0, T1, T3>>(arg0, arg1);
        let v4 = 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::deposited_ctoken_amount<T0, T1, T3>(v3, arg2);
        let v5 = if (v4 == 0) {
            0x2::balance::zero<T0>()
        } else {
            0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::migration_withdraw_v2<T0, T1, T3>(arg0, v3, v4, arg2, arg5, arg6)
        };
        let v6 = v5;
        0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::migration_store_reward_v2<T0, T1, T2, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::SuilendConfig<T0, T1, T3>, T1>(arg1, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::migration_repay_all_v2<T0, T1, T3>(arg0, v3, v1, arg2, arg5, arg6), arg6);
        assert!(0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::borrowed_ceil<T0, T1, T3>(v3, arg2) == 0 && 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::deposited_ctoken_amount<T0, T1, T3>(v3, arg2) == 0, 203);
        let v7 = 0x2::balance::value<T0>(&v6);
        assert!(v7 >= v2, 204);
        0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::acl::put_migration_close_repayment<T0, T1, T2, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::SuilendConfig<T0, T1, T3>>(arg4, arg0, arg1, arg3, 0x2::balance::split<T0>(&mut v6, v2));
        0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::migration_join_final_assets_v2<T0, T1, T2, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::SuilendConfig<T0, T1, T3>>(arg0, arg1, v6);
        let v8 = PositionClosedEvent{
            vault_id             : 0x2::object::id<0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::Vault<T0, T1, T2, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::SuilendConfig<T0, T1, T3>>>(arg1),
            debt_repaid          : v0,
            collateral_withdrawn : v7,
            flash_swap_repayment : v2,
            final_assets         : 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::final_assets_v2<T0, T1, T2, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::SuilendConfig<T0, T1, T3>>(arg1),
        };
        0x2::event::emit<PositionClosedEvent>(v8);
    }

    public fun process_close_receipt_with_reward_v2<T0, T1, T2, T3, T4>(arg0: &0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::version::VersionCap, arg1: &mut 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::Vault<T0, T1, T2, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::SuilendConfig<T0, T1, T3>>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T3>, arg3: &mut 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt, arg4: u64, arg5: &0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::acl::Acl, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::migration_assert_unwinding_v2<T0, T1, T2, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::SuilendConfig<T0, T1, T3>>(arg0, arg1);
        let v0 = 0x2::object::id<0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::Vault<T0, T1, T2, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::SuilendConfig<T0, T1, T3>>>(arg1);
        let (v1, v2, v3) = 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::acl::take_migration_close_inputs<T0, T1, T2, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::SuilendConfig<T0, T1, T3>>(arg5, arg0, arg1, arg3);
        let v4 = 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::migration_protocol_config_owner_v2<T0, T1, T2, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::SuilendConfig<T0, T1, T3>>(arg0, arg1);
        let v5 = 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::deposited_ctoken_amount<T0, T1, T3>(v4, arg2);
        let v6 = if (v5 == 0) {
            0x2::balance::zero<T0>()
        } else {
            0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::migration_withdraw_v2<T0, T1, T3>(arg0, v4, v5, arg2, arg6, arg7)
        };
        let v7 = if (0x1::type_name::get<T4>() == 0x1::type_name::get<T0>()) {
            0x2::balance::zero<T4>()
        } else {
            0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::migration_withdraw_cranked_reward_v2<T0, T1, T3, T4>(arg0, v4, arg4, arg2, arg6, arg7)
        };
        let v8 = v7;
        let v9 = v6;
        0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::migration_store_reward_v2<T0, T1, T2, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::SuilendConfig<T0, T1, T3>, T1>(arg1, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::migration_repay_all_v2<T0, T1, T3>(arg0, v4, v2, arg2, arg6, arg7), arg7);
        0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::migration_store_reward_v2<T0, T1, T2, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::SuilendConfig<T0, T1, T3>, T4>(arg1, v8, arg7);
        let v10 = if (0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::borrowed_ceil<T0, T1, T3>(v4, arg2) == 0) {
            if (0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::deposited_ctoken_amount<T0, T1, T3>(v4, arg2) == 0) {
                0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::cranked_reward_ctoken_amount<T0, T1, T3, T4>(v4, arg2) == 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v10, 203);
        let v11 = 0x2::balance::value<T0>(&v9);
        assert!(v11 >= v3, 204);
        0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::acl::put_migration_close_repayment<T0, T1, T2, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::SuilendConfig<T0, T1, T3>>(arg5, arg0, arg1, arg3, 0x2::balance::split<T0>(&mut v9, v3));
        0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::migration_join_final_assets_v2<T0, T1, T2, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::SuilendConfig<T0, T1, T3>>(arg0, arg1, v9);
        let v12 = RewardCollateralStoredEvent{
            vault_id    : v0,
            reward_type : 0x1::type_name::get<T4>(),
            amount      : 0x2::balance::value<T4>(&v8),
        };
        0x2::event::emit<RewardCollateralStoredEvent>(v12);
        let v13 = PositionClosedEvent{
            vault_id             : v0,
            debt_repaid          : v1,
            collateral_withdrawn : v11,
            flash_swap_repayment : v3,
            final_assets         : 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::final_assets_v2<T0, T1, T2, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::SuilendConfig<T0, T1, T3>>(arg1),
        };
        0x2::event::emit<PositionClosedEvent>(v13);
    }

    public fun process_partial_close_receipt_v2<T0, T1, T2, T3>(arg0: &0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::version::VersionCap, arg1: &mut 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::Vault<T0, T1, T2, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::SuilendConfig<T0, T1, T3>>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T3>, arg3: &mut 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt, arg4: &0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::acl::Acl, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::migration_assert_unwinding_v2<T0, T1, T2, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::SuilendConfig<T0, T1, T3>>(arg0, arg1);
        let (v0, v1, v2) = 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::acl::take_migration_close_inputs<T0, T1, T2, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::SuilendConfig<T0, T1, T3>>(arg4, arg0, arg1, arg3);
        let v3 = 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::migration_protocol_config_owner_v2<T0, T1, T2, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::SuilendConfig<T0, T1, T3>>(arg0, arg1);
        let v4 = 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::borrowed_ceil<T0, T1, T3>(v3, arg2);
        assert!(v0 > 0 && v0 <= v4, 210);
        let v5 = 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::migration_repay_all_v2<T0, T1, T3>(arg0, v3, v1, arg2, arg5, arg6);
        let v6 = 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::borrowed_ceil<T0, T1, T3>(v3, arg2);
        assert!(v6 < v4, 210);
        let v7 = 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::ctoken_amount_for_liquidity_ceil<T0, T1, T3>(v3, v2, arg2);
        assert!(v7 <= 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::deposited_ctoken_amount<T0, T1, T3>(v3, arg2), 204);
        let v8 = 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::migration_withdraw_v2<T0, T1, T3>(arg0, v3, v7, arg2, arg5, arg6);
        0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::migration_store_reward_v2<T0, T1, T2, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::SuilendConfig<T0, T1, T3>, T1>(arg1, v5, arg6);
        let v9 = 0x2::balance::value<T0>(&v8);
        assert!(v9 >= v2, 204);
        0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::acl::put_migration_close_repayment<T0, T1, T2, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::SuilendConfig<T0, T1, T3>>(arg4, arg0, arg1, arg3, 0x2::balance::split<T0>(&mut v8, v2));
        0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::migration_join_final_assets_v2<T0, T1, T2, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::SuilendConfig<T0, T1, T3>>(arg0, arg1, v8);
        let v10 = PositionCloseChunkEvent{
            vault_id             : 0x2::object::id<0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::Vault<T0, T1, T2, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::SuilendConfig<T0, T1, T3>>>(arg1),
            debt_repaid          : v4 - v6,
            debt_remaining       : v6,
            collateral_withdrawn : v9,
            flash_swap_repayment : v2,
            final_assets         : 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::final_assets_v2<T0, T1, T2, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::SuilendConfig<T0, T1, T3>>(arg1),
        };
        0x2::event::emit<PositionCloseChunkEvent>(v10);
    }

    // decompiled from Move bytecode v7
}

