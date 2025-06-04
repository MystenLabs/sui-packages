module 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::scallop_adapter {
    struct NoAssetProof has store {
        dummy_field: bool,
    }

    struct ScallopProtocolOpenObligationRequest {
        dummy_field: bool,
    }

    struct ScallopProtocolBorrowRequest {
        dummy_field: bool,
    }

    struct ScallopProtocolCollateralRequest {
        dummy_field: bool,
    }

    struct ScallopProtocolSupplyRequest {
        dummy_field: bool,
    }

    struct ScallopProtocolRepayRequest {
        dummy_field: bool,
    }

    struct ScallopProtocolWithdrawRequest {
        dummy_field: bool,
    }

    struct ScallopProtocolClaimRequest {
        dummy_field: bool,
    }

    struct ScallopProtocolOpenObligationReceipt {
        info: 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::SingleAssetReceipt,
    }

    struct ScallopProtocolBorrowReceipt {
        info: 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::MultiAssetReceipt,
    }

    struct ScallopProtocolSupplyReceipt {
        info: 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::SingleAssetReceipt,
    }

    struct ScallopProtocolRepayReceipt {
        info: 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::EmptyReceipt,
    }

    struct ScallopProtocolCollateralReceipt {
        info: 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::EmptyReceipt,
    }

    struct ScallopProtocolWithdrawReceipt {
        info: 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::SingleAssetReceipt,
    }

    struct ScallopProtocolClaimReceipt {
        info: 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::MultiAssetReceipt,
    }

    public fun borrow<T0>(arg0: &mut 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::Collector, arg1: ScallopProtocolBorrowRequest, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg5: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg6: u64, arg7: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::Collector, ScallopProtocolBorrowReceipt) {
        let v0 = 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::vault_id(arg0);
        let v1 = extract_obligation_key<ScallopProtocolBorrowRequest>(arg0, &arg1, true);
        drop_borrow_request(arg1);
        let v2 = 0x2::coin::into_balance<T0>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::borrow::borrow<T0>(arg2, arg4, &v1, arg3, arg5, arg6, arg7, arg8, arg9));
        let v3 = 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::new(v0);
        let v4 = new_borrow_receipt(v0);
        let v5 = &mut v4;
        fill_borrow_receipt<T0>(v5, &v1, &v2);
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::collect_asset<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey, ScallopProtocolBorrowReceipt>(&mut v3, &v4, v1, arg9);
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::collect_asset<0x2::balance::Balance<T0>, ScallopProtocolBorrowReceipt>(&mut v3, &v4, v2, arg9);
        (v3, v4)
    }

    public fun borrow_receipt_amounts(arg0: &ScallopProtocolBorrowReceipt) : vector<u64> {
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::multiple_asset_receipt_amounts(arg0.info)
    }

    public fun borrow_receipt_asset_types(arg0: &ScallopProtocolBorrowReceipt) : vector<0x1::type_name::TypeName> {
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::multiple_asset_receipt_asset_type(arg0.info)
    }

    public fun borrow_receipt_vault_id(arg0: &ScallopProtocolBorrowReceipt) : 0x2::object::ID {
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::multiple_asset_receipt_vault_id(arg0.info)
    }

    public fun claim<T0>(arg0: &mut 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::Collector, arg1: ScallopProtocolClaimRequest, arg2: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg3: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg4: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg5: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::Collector, ScallopProtocolClaimReceipt) {
        let v0 = 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::vault_id(arg0);
        let v1 = extract_obligation_key<ScallopProtocolClaimRequest>(arg0, &arg1, true);
        drop_claim_request(arg1);
        let v2 = 0x2::coin::into_balance<T0>(0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::redeem_rewards<T0>(arg2, arg3, arg4, &v1, arg5, arg6, arg7));
        let v3 = 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::new(v0);
        let v4 = new_claim_receipt(v0);
        let v5 = &mut v4;
        fill_claim_receipt<T0>(v5, &v1, &v2);
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::collect_asset<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey, ScallopProtocolClaimReceipt>(&mut v3, &v4, v1, arg7);
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::collect_asset<0x2::balance::Balance<T0>, ScallopProtocolClaimReceipt>(&mut v3, &v4, v2, arg7);
        (v3, v4)
    }

    public fun claim_receipt_amounts(arg0: &ScallopProtocolClaimReceipt) : vector<u64> {
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::multiple_asset_receipt_amounts(arg0.info)
    }

    public fun claim_receipt_asset_types(arg0: &ScallopProtocolClaimReceipt) : vector<0x1::type_name::TypeName> {
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::multiple_asset_receipt_asset_type(arg0.info)
    }

    public fun claim_receipt_vault_id(arg0: &ScallopProtocolClaimReceipt) : 0x2::object::ID {
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::multiple_asset_receipt_vault_id(arg0.info)
    }

    public fun collateral_receipt_vault_id(arg0: &ScallopProtocolCollateralReceipt) : 0x2::object::ID {
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::empty_receipt_vault_id(arg0.info)
    }

    public fun collateralize<T0>(arg0: &mut 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::Collector, arg1: ScallopProtocolCollateralRequest, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg5: &mut 0x2::tx_context::TxContext) : (0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::Collector, ScallopProtocolCollateralReceipt) {
        let v0 = 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::vault_id(arg0);
        drop_coollateral_request(arg1);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::deposit_collateral::deposit_collateral<T0>(arg2, arg4, arg3, 0x2::coin::from_balance<T0>(extract_balance<ScallopProtocolCollateralRequest, T0>(arg0, &arg1, true), arg5), arg5);
        let v1 = 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::new(v0);
        let v2 = new_collateral_receipt(v0);
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::collect_asset<NoAssetProof, ScallopProtocolCollateralReceipt>(&mut v1, &v2, new_no_asset_proof(), arg5);
        (v1, v2)
    }

    public(friend) fun drop_borrow_receipt(arg0: ScallopProtocolBorrowReceipt) {
        let ScallopProtocolBorrowReceipt { info: v0 } = arg0;
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::drop_multiple_receipt(v0);
    }

    public(friend) fun drop_borrow_request(arg0: ScallopProtocolBorrowRequest) {
        let ScallopProtocolBorrowRequest {  } = arg0;
    }

    public(friend) fun drop_claim_receipt(arg0: ScallopProtocolClaimReceipt) {
        let ScallopProtocolClaimReceipt { info: v0 } = arg0;
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::drop_multiple_receipt(v0);
    }

    public(friend) fun drop_claim_request(arg0: ScallopProtocolClaimRequest) {
        let ScallopProtocolClaimRequest {  } = arg0;
    }

    public(friend) fun drop_collateral_receipt(arg0: ScallopProtocolCollateralReceipt) {
        let ScallopProtocolCollateralReceipt { info: v0 } = arg0;
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::drop_empty_receipt(v0);
    }

    public(friend) fun drop_coollateral_request(arg0: ScallopProtocolCollateralRequest) {
        let ScallopProtocolCollateralRequest {  } = arg0;
    }

    public(friend) fun drop_create_account_receipt(arg0: ScallopProtocolOpenObligationReceipt) {
        let ScallopProtocolOpenObligationReceipt { info: v0 } = arg0;
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::drop_single_receipt(v0);
    }

    public(friend) fun drop_empty<T0>(arg0: &mut 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::Collector, arg1: &T0, arg2: bool) {
        let v0 = 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::extract_asset_map_mut<T0>(arg0, arg1);
        let v1 = 0x1::type_name::get<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::Empty>();
        let (_, v3) = 0x2::vec_map::remove<0x1::type_name::TypeName, 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::Item>(v0, &v1);
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::drop_empty_item(v3);
        if (arg2) {
            let v4 = 0x2::vec_map::keys<0x1::type_name::TypeName, 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::Item>(v0);
            if (0x1::vector::length<0x1::type_name::TypeName>(&v4) > 0) {
                err_remaining_unused_asset();
            };
        };
    }

    public(friend) fun drop_no_asset_proof(arg0: NoAssetProof) {
        let NoAssetProof {  } = arg0;
    }

    public(friend) fun drop_open_obligation_request(arg0: ScallopProtocolOpenObligationRequest) {
        let ScallopProtocolOpenObligationRequest {  } = arg0;
    }

    public(friend) fun drop_repay_receipt(arg0: ScallopProtocolRepayReceipt) {
        let ScallopProtocolRepayReceipt { info: v0 } = arg0;
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::drop_empty_receipt(v0);
    }

    public(friend) fun drop_repay_request(arg0: ScallopProtocolRepayRequest) {
        let ScallopProtocolRepayRequest {  } = arg0;
    }

    public(friend) fun drop_supply_receipt(arg0: ScallopProtocolSupplyReceipt) {
        let ScallopProtocolSupplyReceipt { info: v0 } = arg0;
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::drop_single_receipt(v0);
    }

    public(friend) fun drop_supply_request(arg0: ScallopProtocolSupplyRequest) {
        let ScallopProtocolSupplyRequest {  } = arg0;
    }

    public(friend) fun drop_withdraw_receipt(arg0: ScallopProtocolWithdrawReceipt) {
        let ScallopProtocolWithdrawReceipt { info: v0 } = arg0;
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::drop_single_receipt(v0);
    }

    public(friend) fun drop_withdraw_request(arg0: ScallopProtocolWithdrawRequest) {
        let ScallopProtocolWithdrawRequest {  } = arg0;
    }

    fun err_remaining_unused_asset() {
        abort 1000
    }

    public(friend) fun extract_and_drop_no_asset_proof<T0>(arg0: &mut 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::Collector, arg1: &T0) {
        let v0 = 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::extract_asset_map_mut<T0>(arg0, arg1);
        let v1 = 0x1::type_name::get<NoAssetProof>();
        let (_, v3) = 0x2::vec_map::remove<0x1::type_name::TypeName, 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::Item>(v0, &v1);
        let v4 = 0x2::vec_map::keys<0x1::type_name::TypeName, 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::Item>(v0);
        if (0x1::vector::length<0x1::type_name::TypeName>(&v4) > 0) {
            err_remaining_unused_asset();
        };
        drop_no_asset_proof(0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::extract_inner_asset<NoAssetProof>(v3));
    }

    public(friend) fun extract_balance<T0, T1>(arg0: &mut 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::Collector, arg1: &T0, arg2: bool) : 0x2::balance::Balance<T1> {
        let v0 = 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::extract_asset_map_mut<T0>(arg0, arg1);
        let v1 = 0x1::type_name::get<0x2::balance::Balance<T1>>();
        let (_, v3) = 0x2::vec_map::remove<0x1::type_name::TypeName, 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::Item>(v0, &v1);
        if (arg2) {
            let v4 = 0x2::vec_map::keys<0x1::type_name::TypeName, 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::Item>(v0);
            if (0x1::vector::length<0x1::type_name::TypeName>(&v4) > 0) {
                err_remaining_unused_asset();
            };
        };
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::extract_inner_asset<0x2::balance::Balance<T1>>(v3)
    }

    public(friend) fun extract_obligation_key<T0>(arg0: &mut 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::Collector, arg1: &T0, arg2: bool) : 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey {
        let v0 = 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::extract_asset_map_mut<T0>(arg0, arg1);
        let v1 = 0x1::type_name::get<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey>();
        let (_, v3) = 0x2::vec_map::remove<0x1::type_name::TypeName, 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::Item>(v0, &v1);
        if (arg2) {
            let v4 = 0x2::vec_map::keys<0x1::type_name::TypeName, 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::Item>(v0);
            if (0x1::vector::length<0x1::type_name::TypeName>(&v4) > 0) {
                err_remaining_unused_asset();
            };
        };
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::extract_inner_asset<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey>(v3)
    }

    public(friend) fun fill_borrow_receipt<T0>(arg0: &mut ScallopProtocolBorrowReceipt, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey, arg2: &0x2::balance::Balance<T0>) {
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::add_multiple_receipt_amount(&mut arg0.info, 1);
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::add_multiple_receipt_amount(&mut arg0.info, 0x2::balance::value<T0>(arg2));
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::add_multiple_receipt_asset_type(&mut arg0.info, 0x1::type_name::get<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey>());
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::add_multiple_receipt_asset_type(&mut arg0.info, 0x1::type_name::get<0x2::balance::Balance<T0>>());
    }

    public(friend) fun fill_claim_receipt<T0>(arg0: &mut ScallopProtocolClaimReceipt, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey, arg2: &0x2::balance::Balance<T0>) {
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::add_multiple_receipt_amount(&mut arg0.info, 1);
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::add_multiple_receipt_amount(&mut arg0.info, 0x2::balance::value<T0>(arg2));
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::add_multiple_receipt_asset_type(&mut arg0.info, 0x1::type_name::get<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey>());
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::add_multiple_receipt_asset_type(&mut arg0.info, 0x1::type_name::get<0x2::balance::Balance<T0>>());
    }

    public(friend) fun fill_open_obligation_receipt(arg0: &mut ScallopProtocolOpenObligationReceipt, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey) {
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::set_single_receipt_amount(&mut arg0.info, 1);
    }

    public(friend) fun fill_supply_receipt<T0>(arg0: &mut ScallopProtocolSupplyReceipt, arg1: &0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>) {
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::set_single_receipt_amount(&mut arg0.info, 0x2::balance::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(arg1));
    }

    public(friend) fun fill_withdraw_receipt<T0>(arg0: &mut ScallopProtocolWithdrawReceipt, arg1: &0x2::balance::Balance<T0>) {
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::set_single_receipt_amount(&mut arg0.info, 0x2::balance::value<T0>(arg1));
    }

    public(friend) fun new_borrow_receipt(arg0: 0x2::object::ID) : ScallopProtocolBorrowReceipt {
        ScallopProtocolBorrowReceipt{info: 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::new_multiple_asset_receipt(arg0, 0x1::option::none<vector<0x1::type_name::TypeName>>(), 0x1::option::none<vector<u64>>())}
    }

    public(friend) fun new_borrow_request() : ScallopProtocolBorrowRequest {
        ScallopProtocolBorrowRequest{dummy_field: false}
    }

    public(friend) fun new_claim_receipt(arg0: 0x2::object::ID) : ScallopProtocolClaimReceipt {
        ScallopProtocolClaimReceipt{info: 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::new_multiple_asset_receipt(arg0, 0x1::option::none<vector<0x1::type_name::TypeName>>(), 0x1::option::none<vector<u64>>())}
    }

    public(friend) fun new_claim_request() : ScallopProtocolClaimRequest {
        ScallopProtocolClaimRequest{dummy_field: false}
    }

    public(friend) fun new_collateral_receipt(arg0: 0x2::object::ID) : ScallopProtocolCollateralReceipt {
        ScallopProtocolCollateralReceipt{info: 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::new_empty_receipt(arg0)}
    }

    public(friend) fun new_collateral_request() : ScallopProtocolCollateralRequest {
        ScallopProtocolCollateralRequest{dummy_field: false}
    }

    public(friend) fun new_no_asset_proof() : NoAssetProof {
        NoAssetProof{dummy_field: false}
    }

    public(friend) fun new_open_obligation_receipt(arg0: 0x2::object::ID) : ScallopProtocolOpenObligationReceipt {
        ScallopProtocolOpenObligationReceipt{info: 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::new_single_asset_receipt(arg0, 0x1::type_name::get<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey>(), 0x1::option::none<u64>())}
    }

    public(friend) fun new_open_obligation_request() : ScallopProtocolOpenObligationRequest {
        ScallopProtocolOpenObligationRequest{dummy_field: false}
    }

    public(friend) fun new_repay_receipt(arg0: 0x2::object::ID) : ScallopProtocolRepayReceipt {
        ScallopProtocolRepayReceipt{info: 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::new_empty_receipt(arg0)}
    }

    public(friend) fun new_repay_request() : ScallopProtocolRepayRequest {
        ScallopProtocolRepayRequest{dummy_field: false}
    }

    public(friend) fun new_supply_receipt<T0>(arg0: 0x2::object::ID) : ScallopProtocolSupplyReceipt {
        ScallopProtocolSupplyReceipt{info: 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::new_single_asset_receipt(arg0, 0x1::type_name::get<0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(), 0x1::option::none<u64>())}
    }

    public(friend) fun new_supply_request() : ScallopProtocolSupplyRequest {
        ScallopProtocolSupplyRequest{dummy_field: false}
    }

    public(friend) fun new_withdraw_receipt<T0>(arg0: 0x2::object::ID) : ScallopProtocolWithdrawReceipt {
        ScallopProtocolWithdrawReceipt{info: 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::new_single_asset_receipt(arg0, 0x1::type_name::get<0x2::balance::Balance<T0>>(), 0x1::option::none<u64>())}
    }

    public(friend) fun new_withdraw_request() : ScallopProtocolWithdrawRequest {
        ScallopProtocolWithdrawRequest{dummy_field: false}
    }

    public fun open_obligation(arg0: &mut 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::Collector, arg1: ScallopProtocolOpenObligationRequest, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0x2::tx_context::TxContext) : (0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::Collector, ScallopProtocolOpenObligationReceipt) {
        let v0 = 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::vault_id(arg0);
        drop_empty<ScallopProtocolOpenObligationRequest>(arg0, &arg1, true);
        drop_open_obligation_request(arg1);
        let (v1, v2, v3) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::open_obligation::open_obligation(arg2, arg3);
        let v4 = v2;
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::open_obligation::return_obligation(arg2, v1, v3);
        let v5 = 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::new(v0);
        let v6 = new_open_obligation_receipt(v0);
        let v7 = &mut v6;
        fill_open_obligation_receipt(v7, &v4);
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::collect_asset<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey, ScallopProtocolOpenObligationReceipt>(&mut v5, &v6, v4, arg3);
        (v5, v6)
    }

    public fun open_obligation_receipt_amount(arg0: &ScallopProtocolOpenObligationReceipt) : u64 {
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::single_asset_receipt_amount(arg0.info)
    }

    public fun open_obligation_receipt_asset_type(arg0: &ScallopProtocolOpenObligationReceipt) : 0x1::type_name::TypeName {
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::single_asset_receipt_asset_type(arg0.info)
    }

    public fun open_obligation_receipt_vault_id(arg0: &ScallopProtocolOpenObligationReceipt) : 0x2::object::ID {
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::single_asset_receipt_vault_id(arg0.info)
    }

    public fun repay<T0>(arg0: &mut 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::Collector, arg1: ScallopProtocolRepayRequest, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::Collector, ScallopProtocolRepayReceipt) {
        let v0 = 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::vault_id(arg0);
        drop_repay_request(arg1);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::repay::repay<T0>(arg2, arg3, arg4, 0x2::coin::from_balance<T0>(extract_balance<ScallopProtocolRepayRequest, T0>(arg0, &arg1, true), arg6), arg5, arg6);
        let v1 = 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::new(v0);
        let v2 = new_repay_receipt(v0);
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::collect_asset<NoAssetProof, ScallopProtocolRepayReceipt>(&mut v1, &v2, new_no_asset_proof(), arg6);
        (v1, v2)
    }

    public fun repay_receipt_vault_id(arg0: &ScallopProtocolRepayReceipt) : 0x2::object::ID {
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::empty_receipt_vault_id(arg0.info)
    }

    public fun supply<T0>(arg0: &mut 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::Collector, arg1: ScallopProtocolSupplyRequest, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::Collector, ScallopProtocolSupplyReceipt) {
        let v0 = 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::vault_id(arg0);
        drop_supply_request(arg1);
        let v1 = 0x2::coin::into_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<T0>(arg2, arg3, 0x2::coin::from_balance<T0>(extract_balance<ScallopProtocolSupplyRequest, T0>(arg0, &arg1, true), arg5), arg4, arg5));
        let v2 = 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::new(v0);
        let v3 = new_supply_receipt<T0>(v0);
        let v4 = &mut v3;
        fill_supply_receipt<T0>(v4, &v1);
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::collect_asset<0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>, ScallopProtocolSupplyReceipt>(&mut v2, &v3, v1, arg5);
        (v2, v3)
    }

    public fun supply_receipt_amount(arg0: &ScallopProtocolSupplyReceipt) : u64 {
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::single_asset_receipt_amount(arg0.info)
    }

    public fun supply_receipt_asset_type(arg0: &ScallopProtocolSupplyReceipt) : 0x1::type_name::TypeName {
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::single_asset_receipt_asset_type(arg0.info)
    }

    public fun supply_receipt_vault_id(arg0: &ScallopProtocolSupplyReceipt) : 0x2::object::ID {
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::single_asset_receipt_vault_id(arg0.info)
    }

    public fun withdraw<T0>(arg0: &mut 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::Collector, arg1: ScallopProtocolWithdrawRequest, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::Collector, ScallopProtocolWithdrawReceipt) {
        let v0 = 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::vault_id(arg0);
        drop_withdraw_request(arg1);
        let v1 = 0x2::coin::into_balance<T0>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T0>(arg2, arg3, 0x2::coin::from_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(extract_balance<ScallopProtocolWithdrawRequest, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(arg0, &arg1, true), arg5), arg4, arg5));
        let v2 = 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::new(v0);
        let v3 = new_withdraw_receipt<T0>(v0);
        let v4 = &mut v3;
        fill_withdraw_receipt<T0>(v4, &v1);
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::collect_asset<0x2::balance::Balance<T0>, ScallopProtocolWithdrawReceipt>(&mut v2, &v3, v1, arg5);
        (v2, v3)
    }

    public fun withdraw_receipt_amount(arg0: &ScallopProtocolWithdrawReceipt) : u64 {
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::single_asset_receipt_amount(arg0.info)
    }

    public fun withdraw_receipt_asset_type(arg0: &ScallopProtocolWithdrawReceipt) : 0x1::type_name::TypeName {
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::single_asset_receipt_asset_type(arg0.info)
    }

    public fun withdraw_receipt_vault_id(arg0: &ScallopProtocolWithdrawReceipt) : 0x2::object::ID {
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::single_asset_receipt_vault_id(arg0.info)
    }

    // decompiled from Move bytecode v6
}

