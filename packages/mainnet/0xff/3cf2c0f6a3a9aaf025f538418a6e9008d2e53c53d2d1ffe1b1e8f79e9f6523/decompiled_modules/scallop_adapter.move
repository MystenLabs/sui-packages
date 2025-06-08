module 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::scallop_adapter {
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
        dummy_field: bool,
    }

    struct ScallopProtocolBorrowReceipt {
        dummy_field: bool,
    }

    struct ScallopProtocolSupplyReceipt {
        dummy_field: bool,
    }

    struct ScallopProtocolRepayReceipt {
        dummy_field: bool,
    }

    struct ScallopProtocolCollateralReceipt {
        dummy_field: bool,
    }

    struct ScallopProtocolWithdrawReceipt {
        dummy_field: bool,
    }

    struct ScallopProtocolClaimReceipt {
        dummy_field: bool,
    }

    public fun borrow<T0>(arg0: &mut 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::Collector, arg1: ScallopProtocolBorrowRequest, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg5: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg6: u64, arg7: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::Collector, ScallopProtocolBorrowReceipt) {
        let v0 = 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::vault_id(arg0);
        let v1 = extract_obligation_key<ScallopProtocolBorrowRequest>(arg0, &arg1, true);
        drop_borrow_request(arg1);
        let v2 = 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::new(v0);
        let v3 = new_borrow_receipt();
        0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::collect_asset<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey, ScallopProtocolBorrowReceipt>(&mut v2, &v3, v1, arg9);
        0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::collect_asset<0x2::balance::Balance<T0>, ScallopProtocolBorrowReceipt>(&mut v2, &v3, 0x2::coin::into_balance<T0>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::borrow::borrow<T0>(arg2, arg4, &v1, arg3, arg5, arg6, arg7, arg8, arg9)), arg9);
        (v2, v3)
    }

    public fun open_obligation(arg0: &mut 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::Collector, arg1: ScallopProtocolOpenObligationRequest, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0x2::tx_context::TxContext) : (0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::Collector, ScallopProtocolOpenObligationReceipt) {
        let v0 = 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::vault_id(arg0);
        drop_empty<ScallopProtocolOpenObligationRequest>(arg0, &arg1, true);
        drop_open_obligation_request(arg1);
        let (v1, v2, v3) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::open_obligation::open_obligation(arg2, arg3);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::open_obligation::return_obligation(arg2, v1, v3);
        let v4 = 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::new(v0);
        let v5 = new_open_obligation_receipt();
        0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::collect_asset<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey, ScallopProtocolOpenObligationReceipt>(&mut v4, &v5, v2, arg3);
        (v4, v5)
    }

    public fun repay<T0>(arg0: &mut 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::Collector, arg1: ScallopProtocolRepayRequest, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::Collector, ScallopProtocolRepayReceipt) {
        let v0 = 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::vault_id(arg0);
        drop_repay_request(arg1);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::repay::repay<T0>(arg2, arg3, arg4, 0x2::coin::from_balance<T0>(extract_balance<ScallopProtocolRepayRequest, T0>(arg0, &arg1, true), arg6), arg5, arg6);
        let v1 = 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::new(v0);
        let v2 = new_repay_receipt();
        0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::collect_asset<NoAssetProof, ScallopProtocolRepayReceipt>(&mut v1, &v2, new_no_asset_proof(), arg6);
        (v1, v2)
    }

    public fun claim<T0>(arg0: &mut 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::Collector, arg1: ScallopProtocolClaimRequest, arg2: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg3: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg4: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg5: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::Collector, ScallopProtocolClaimReceipt) {
        let v0 = 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::vault_id(arg0);
        let v1 = extract_obligation_key<ScallopProtocolClaimRequest>(arg0, &arg1, true);
        drop_claim_request(arg1);
        let v2 = 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::new(v0);
        let v3 = new_claim_receipt();
        0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::collect_asset<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey, ScallopProtocolClaimReceipt>(&mut v2, &v3, v1, arg7);
        0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::collect_asset<0x2::balance::Balance<T0>, ScallopProtocolClaimReceipt>(&mut v2, &v3, 0x2::coin::into_balance<T0>(0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::redeem_rewards<T0>(arg2, arg3, arg4, &v1, arg5, arg6, arg7)), arg7);
        (v2, v3)
    }

    public fun collateralize<T0>(arg0: &mut 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::Collector, arg1: ScallopProtocolCollateralRequest, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg5: &mut 0x2::tx_context::TxContext) : (0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::Collector, ScallopProtocolCollateralReceipt) {
        let v0 = 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::vault_id(arg0);
        drop_coollateral_request(arg1);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::deposit_collateral::deposit_collateral<T0>(arg2, arg4, arg3, 0x2::coin::from_balance<T0>(extract_balance<ScallopProtocolCollateralRequest, T0>(arg0, &arg1, true), arg5), arg5);
        let v1 = 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::new(v0);
        let v2 = new_collateral_receipt();
        0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::collect_asset<NoAssetProof, ScallopProtocolCollateralReceipt>(&mut v1, &v2, new_no_asset_proof(), arg5);
        (v1, v2)
    }

    public(friend) fun drop_borrow_receipt(arg0: ScallopProtocolBorrowReceipt) {
        let ScallopProtocolBorrowReceipt {  } = arg0;
    }

    public(friend) fun drop_borrow_request(arg0: ScallopProtocolBorrowRequest) {
        let ScallopProtocolBorrowRequest {  } = arg0;
    }

    public(friend) fun drop_claim_receipt(arg0: ScallopProtocolClaimReceipt) {
        let ScallopProtocolClaimReceipt {  } = arg0;
    }

    public(friend) fun drop_claim_request(arg0: ScallopProtocolClaimRequest) {
        let ScallopProtocolClaimRequest {  } = arg0;
    }

    public(friend) fun drop_collateral_receipt(arg0: ScallopProtocolCollateralReceipt) {
        let ScallopProtocolCollateralReceipt {  } = arg0;
    }

    public(friend) fun drop_coollateral_request(arg0: ScallopProtocolCollateralRequest) {
        let ScallopProtocolCollateralRequest {  } = arg0;
    }

    public(friend) fun drop_create_account_receipt(arg0: ScallopProtocolOpenObligationReceipt) {
        let ScallopProtocolOpenObligationReceipt {  } = arg0;
    }

    public(friend) fun drop_empty<T0>(arg0: &mut 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::Collector, arg1: &T0, arg2: bool) {
        let v0 = 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::extract_asset_map_mut<T0>(arg0, arg1);
        let v1 = 0x1::type_name::get<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::Empty>();
        let (_, v3) = 0x2::vec_map::remove<0x1::type_name::TypeName, 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::Item>(v0, &v1);
        0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::drop_empty_item(v3);
        if (arg2) {
            let v4 = 0x2::vec_map::keys<0x1::type_name::TypeName, 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::Item>(v0);
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
        let ScallopProtocolRepayReceipt {  } = arg0;
    }

    public(friend) fun drop_repay_request(arg0: ScallopProtocolRepayRequest) {
        let ScallopProtocolRepayRequest {  } = arg0;
    }

    public(friend) fun drop_supply_receipt(arg0: ScallopProtocolSupplyReceipt) {
        let ScallopProtocolSupplyReceipt {  } = arg0;
    }

    public(friend) fun drop_supply_request(arg0: ScallopProtocolSupplyRequest) {
        let ScallopProtocolSupplyRequest {  } = arg0;
    }

    public(friend) fun drop_withdraw_receipt(arg0: ScallopProtocolWithdrawReceipt) {
        let ScallopProtocolWithdrawReceipt {  } = arg0;
    }

    public(friend) fun drop_withdraw_request(arg0: ScallopProtocolWithdrawRequest) {
        let ScallopProtocolWithdrawRequest {  } = arg0;
    }

    fun err_remaining_unused_asset() {
        abort 1000
    }

    public(friend) fun extract_and_drop_no_asset_proof<T0>(arg0: &mut 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::Collector, arg1: &T0) {
        let v0 = 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::extract_asset_map_mut<T0>(arg0, arg1);
        let v1 = 0x1::type_name::get<NoAssetProof>();
        let (_, v3) = 0x2::vec_map::remove<0x1::type_name::TypeName, 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::Item>(v0, &v1);
        let v4 = 0x2::vec_map::keys<0x1::type_name::TypeName, 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::Item>(v0);
        if (0x1::vector::length<0x1::type_name::TypeName>(&v4) > 0) {
            err_remaining_unused_asset();
        };
        drop_no_asset_proof(0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::extract_inner_asset<NoAssetProof>(v3));
    }

    public(friend) fun extract_balance<T0, T1>(arg0: &mut 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::Collector, arg1: &T0, arg2: bool) : 0x2::balance::Balance<T1> {
        let v0 = 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::extract_asset_map_mut<T0>(arg0, arg1);
        let v1 = 0x1::type_name::get<0x2::balance::Balance<T1>>();
        let (_, v3) = 0x2::vec_map::remove<0x1::type_name::TypeName, 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::Item>(v0, &v1);
        if (arg2) {
            let v4 = 0x2::vec_map::keys<0x1::type_name::TypeName, 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::Item>(v0);
            if (0x1::vector::length<0x1::type_name::TypeName>(&v4) > 0) {
                err_remaining_unused_asset();
            };
        };
        0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::extract_inner_asset<0x2::balance::Balance<T1>>(v3)
    }

    public(friend) fun extract_obligation_key<T0>(arg0: &mut 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::Collector, arg1: &T0, arg2: bool) : 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey {
        let v0 = 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::extract_asset_map_mut<T0>(arg0, arg1);
        let v1 = 0x1::type_name::get<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey>();
        let (_, v3) = 0x2::vec_map::remove<0x1::type_name::TypeName, 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::Item>(v0, &v1);
        if (arg2) {
            let v4 = 0x2::vec_map::keys<0x1::type_name::TypeName, 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::Item>(v0);
            if (0x1::vector::length<0x1::type_name::TypeName>(&v4) > 0) {
                err_remaining_unused_asset();
            };
        };
        0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::extract_inner_asset<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey>(v3)
    }

    public(friend) fun new_borrow_receipt() : ScallopProtocolBorrowReceipt {
        ScallopProtocolBorrowReceipt{dummy_field: false}
    }

    public(friend) fun new_borrow_request() : ScallopProtocolBorrowRequest {
        ScallopProtocolBorrowRequest{dummy_field: false}
    }

    public(friend) fun new_claim_receipt() : ScallopProtocolClaimReceipt {
        ScallopProtocolClaimReceipt{dummy_field: false}
    }

    public(friend) fun new_claim_request() : ScallopProtocolClaimRequest {
        ScallopProtocolClaimRequest{dummy_field: false}
    }

    public(friend) fun new_collateral_receipt() : ScallopProtocolCollateralReceipt {
        ScallopProtocolCollateralReceipt{dummy_field: false}
    }

    public(friend) fun new_collateral_request() : ScallopProtocolCollateralRequest {
        ScallopProtocolCollateralRequest{dummy_field: false}
    }

    public(friend) fun new_no_asset_proof() : NoAssetProof {
        NoAssetProof{dummy_field: false}
    }

    public(friend) fun new_open_obligation_receipt() : ScallopProtocolOpenObligationReceipt {
        ScallopProtocolOpenObligationReceipt{dummy_field: false}
    }

    public(friend) fun new_open_obligation_request() : ScallopProtocolOpenObligationRequest {
        ScallopProtocolOpenObligationRequest{dummy_field: false}
    }

    public(friend) fun new_repay_receipt() : ScallopProtocolRepayReceipt {
        ScallopProtocolRepayReceipt{dummy_field: false}
    }

    public(friend) fun new_repay_request() : ScallopProtocolRepayRequest {
        ScallopProtocolRepayRequest{dummy_field: false}
    }

    public(friend) fun new_supply_receipt() : ScallopProtocolSupplyReceipt {
        ScallopProtocolSupplyReceipt{dummy_field: false}
    }

    public(friend) fun new_supply_request() : ScallopProtocolSupplyRequest {
        ScallopProtocolSupplyRequest{dummy_field: false}
    }

    public(friend) fun new_withdraw_receipt() : ScallopProtocolWithdrawReceipt {
        ScallopProtocolWithdrawReceipt{dummy_field: false}
    }

    public(friend) fun new_withdraw_request() : ScallopProtocolWithdrawRequest {
        ScallopProtocolWithdrawRequest{dummy_field: false}
    }

    public fun supply<T0>(arg0: &mut 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::Collector, arg1: ScallopProtocolSupplyRequest, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::Collector, ScallopProtocolSupplyReceipt) {
        let v0 = 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::vault_id(arg0);
        drop_supply_request(arg1);
        let v1 = 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::new(v0);
        let v2 = new_supply_receipt();
        0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::collect_asset<0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>, ScallopProtocolSupplyReceipt>(&mut v1, &v2, 0x2::coin::into_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<T0>(arg2, arg3, 0x2::coin::from_balance<T0>(extract_balance<ScallopProtocolSupplyRequest, T0>(arg0, &arg1, true), arg5), arg4, arg5)), arg5);
        (v1, v2)
    }

    public fun withdraw<T0>(arg0: &mut 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::Collector, arg1: ScallopProtocolWithdrawRequest, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::Collector, ScallopProtocolWithdrawReceipt) {
        let v0 = 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::vault_id(arg0);
        drop_withdraw_request(arg1);
        let v1 = 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::new(v0);
        let v2 = new_withdraw_receipt();
        0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::collect_asset<0x2::balance::Balance<T0>, ScallopProtocolWithdrawReceipt>(&mut v1, &v2, 0x2::coin::into_balance<T0>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T0>(arg2, arg3, 0x2::coin::from_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(extract_balance<ScallopProtocolWithdrawRequest, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(arg0, &arg1, true), arg5), arg4, arg5)), arg5);
        (v1, v2)
    }

    // decompiled from Move bytecode v6
}

