module 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::vault {
    struct Vault<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        versions: 0x2::vec_set::VecSet<u64>,
        assets: Asset,
        supply: 0x2::balance::Supply<T1>,
        fee_rate: 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::float::Float,
    }

    struct VaultCap<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Asset has store {
        f_asset: 0x2::bag::Bag,
        nf_asset: 0x2::bag::Bag,
    }

    struct VAULT has drop {
        dummy_field: bool,
    }

    struct TakeAssetRequest<phantom T0: store> {
        dummy_field: bool,
    }

    public fun new<T0, T1>(arg0: 0x2::coin::TreasuryCap<T1>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg1 >= (0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::constants::max_following_fee() as u64)) {
            (0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::constants::max_following_fee() as u64)
        } else {
            arg1
        };
        let (v1, v2) = new_<T0, T1>(arg0, v0, arg3);
        0x2::transfer::share_object<Vault<T0, T1>>(v1);
        0x2::transfer::public_transfer<VaultCap<T0, T1>>(v2, arg2);
    }

    fun add_f_asset<T0, T1, T2>(arg0: &mut Vault<T0, T1>, arg1: 0x2::balance::Balance<T2>) {
        let v0 = 0x1::type_name::get<0x2::balance::Balance<T2>>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.assets.f_asset, v0)) {
            0x2::balance::join<T2>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.assets.f_asset, v0), arg1);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.assets.f_asset, v0, arg1);
        };
    }

    fun add_nf_asset<T0, T1, T2: store>(arg0: &mut Vault<T0, T1>, arg1: T2) {
        let v0 = 0x1::type_name::get<T2>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.assets.nf_asset, v0)) {
            err_nf_asset_existed();
        };
        0x2::bag::add<0x1::type_name::TypeName, T2>(&mut arg0.assets.nf_asset, v0, arg1);
    }

    fun add_partner_record<T0, T1, T2: drop + store>(arg0: &mut Vault<T0, T1>) {
        if (is_bucket<T2>()) {
            add_record<T0, T1>(arg0, b"bucket_protocol");
        } else if (is_scallop<T2>()) {
            add_record<T0, T1>(arg0, b"scallop_protocol");
        } else if (is_suilend<T2>()) {
            add_record<T0, T1>(arg0, b"suilend_protocol");
        } else if (is_navi<T2>()) {
            add_record<T0, T1>(arg0, b"navi_protocol");
        } else if (is_momentum<T2>()) {
            add_record<T0, T1>(arg0, b"momentum_protocol");
        } else if (is_steamm<T2>()) {
            add_record<T0, T1>(arg0, b"steamm_protocol");
        } else if (is_typus<T2>()) {
            add_record<T0, T1>(arg0, b"typus_finance");
        } else {
            err_protocol_not_supported();
        };
    }

    fun add_record<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: vector<u8>) {
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, arg1)) {
            0x2::dynamic_field::add<vector<u8>, 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>>(&mut arg0.id, arg1, 0x2::vec_map::empty<0x1::type_name::TypeName, u64>());
        };
    }

    public fun add_version<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64) {
        if (!0x2::vec_set::contains<u64>(&arg0.versions, &arg1)) {
            0x2::vec_set::insert<u64>(&mut arg0.versions, arg1);
        } else {
            err_version_already_existed();
        };
    }

    fun assert_if_version_not_allowed<T0, T1>(arg0: &Vault<T0, T1>) {
        let v0 = 1;
        if (!0x2::vec_set::contains<u64>(&arg0.versions, &v0)) {
            err_version_not_allowed();
        };
    }

    fun calculate_share_amount<T0, T1>(arg0: &Vault<T0, T1>, arg1: u64) : u64 {
        0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::float::floor(0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::float::mul_div(0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::float::from(arg1), 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::float::from(0x2::balance::supply_value<T1>(&arg0.supply)), 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::float::from(calculate_total_value<T0, T1>(arg0))))
    }

    fun calculate_total_value<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        inner_value<T0, T1>(arg0) + fetch_scallop_value<T0, T1>(arg0) + fetch_suilend_value<T0, T1>(arg0) + fetch_navi_value<T0, T1>(arg0) + fetch_typus_value<T0, T1>(arg0) + fetch_bucket_value<T0, T1>(arg0) + fetch_momentum_value<T0, T1>(arg0) + fetch_steamm_value<T0, T1>(arg0)
    }

    public fun create_bucket_borrow_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::bucket_adapter::BucketProtocolBorrowRequest {
        0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::bucket_adapter::new_borrow_request()
    }

    public fun create_bucket_claim_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::bucket_adapter::BucketProtocolClaimRequest {
        0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::bucket_adapter::new_claim_request()
    }

    public fun create_bucket_deposit_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::bucket_adapter::BucketProtocolDepositRequest {
        0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::bucket_adapter::new_deposit_request()
    }

    public fun create_bucket_repay_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::bucket_adapter::BucketProtocolRepayRequest {
        0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::bucket_adapter::new_repay_request()
    }

    public fun create_bucket_withdraw_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::bucket_adapter::BucketProtocolWithdrawRequest {
        0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::bucket_adapter::new_withdraw_request()
    }

    public fun create_momentum_add_liquidity_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::momentum_adapter::MomentumProtocolAddLiquidityRequest {
        0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::momentum_adapter::new_add_liquidity_request()
    }

    public fun create_momentum_claim_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::momentum_adapter::MomentumProtocolClaimRequest {
        0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::momentum_adapter::new_claim_request()
    }

    public fun create_momentum_remove_liquidity_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::momentum_adapter::MomentumProtocolRemoveLiquidityRequest {
        0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::momentum_adapter::new_remove_liquidity_request()
    }

    public fun create_momentum_swap_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::momentum_adapter::MomentumProtocolSwapRequest {
        0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::momentum_adapter::new_swap_request()
    }

    public fun create_navi_borrow_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::navi_adapter::NaviProtocolBorrowRequest {
        0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::navi_adapter::new_borrow_request()
    }

    public fun create_navi_claim_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::navi_adapter::NaviProtocolClaimRequest {
        0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::navi_adapter::new_claim_request()
    }

    public fun create_navi_create_account_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::navi_adapter::NaviProtocolCreateAccountRequest {
        0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::navi_adapter::new_create_account_request()
    }

    public fun create_navi_repay_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::navi_adapter::NaviProtocolRepayRequest {
        0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::navi_adapter::new_repay_request()
    }

    public fun create_navi_supply_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::navi_adapter::NaviProtocolSupplyRequest {
        0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::navi_adapter::new_supply_request()
    }

    public fun create_navi_withdraw_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::navi_adapter::NaviProtocolWithdrawRequest {
        0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::navi_adapter::new_withdraw_request()
    }

    public fun create_scallop_borrow_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::scallop_adapter::ScallopProtocolBorrowRequest {
        0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::scallop_adapter::new_borrow_request()
    }

    public fun create_scallop_claim_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::scallop_adapter::ScallopProtocolClaimRequest {
        0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::scallop_adapter::new_claim_request()
    }

    public fun create_scallop_collateral_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::scallop_adapter::ScallopProtocolCollateralRequest {
        0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::scallop_adapter::new_collateral_request()
    }

    public fun create_scallop_open_obligation_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::scallop_adapter::ScallopProtocolOpenObligationRequest {
        0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::scallop_adapter::new_open_obligation_request()
    }

    public fun create_scallop_repay_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::scallop_adapter::ScallopProtocolRepayRequest {
        0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::scallop_adapter::new_repay_request()
    }

    public fun create_scallop_supply_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::scallop_adapter::ScallopProtocolSupplyRequest {
        0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::scallop_adapter::new_supply_request()
    }

    public fun create_scallop_withdraw_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::scallop_adapter::ScallopProtocolWithdrawRequest {
        0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::scallop_adapter::new_withdraw_request()
    }

    public fun create_steamm_add_liquidity_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::steamm_adapter::SteammProtocolAddLiquidityRequest {
        0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::steamm_adapter::new_add_liquidity_request()
    }

    public fun create_steamm_claim_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::steamm_adapter::SteammProtocolClaimRequest {
        0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::steamm_adapter::new_claim_request()
    }

    public fun create_steamm_remove_liquidity_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::steamm_adapter::SteammProtocolRemoveLiquidityRequest {
        0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::steamm_adapter::new_remove_liquidity_request()
    }

    public fun create_steamm_swap_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::steamm_adapter::SteammProtocolSwapRequest {
        0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::steamm_adapter::new_swap_request()
    }

    public fun create_suilend_borrow_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::suilend_adapter::SuilendProtocolBorrowRequest {
        0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::suilend_adapter::new_borrow_request()
    }

    public fun create_suilend_claim_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::suilend_adapter::SuilendProtocolClaimRequest {
        0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::suilend_adapter::new_claim_request()
    }

    public fun create_suilend_create_obligation_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::suilend_adapter::SuilendProtocolCreateObligationRequest {
        0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::suilend_adapter::new_create_obligation_request()
    }

    public fun create_suilend_repay_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::suilend_adapter::SuilendProtocolRepayRequest {
        0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::suilend_adapter::new_repay_request()
    }

    public fun create_suilend_supply_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::suilend_adapter::SuilendProtocolSupplyRequest {
        0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::suilend_adapter::new_supply_request()
    }

    public fun create_suilend_withdraw_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::suilend_adapter::SuilendProtocolWithdrawRequest {
        0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::suilend_adapter::new_withdraw_request()
    }

    public fun create_typus_buy_long_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::typus_adapter::TypusFinanceBuyLongRequest {
        0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::typus_adapter::new_buy_long_request()
    }

    public fun create_typus_buy_short_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::typus_adapter::TypusFinanceBuyShortRequest {
        0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::typus_adapter::new_buy_short_request()
    }

    public fun create_typus_sell_long_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::typus_adapter::TypusFinanceSellLongRequest {
        0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::typus_adapter::new_sell_long_request()
    }

    public fun create_typus_sell_short_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::typus_adapter::TypusFinanceSellShortRequest {
        0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::typus_adapter::new_sell_short_request()
    }

    public fun deposit<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::coin::Coin<T0>) : 0x2::balance::Balance<T1> {
        assert_if_version_not_allowed<T0, T1>(arg0);
        let v0 = 0x2::balance::increase_supply<T1>(&mut arg0.supply, calculate_share_amount<T0, T1>(arg0, 0x2::coin::value<T0>(&arg1)));
        deposit_<T0, T1>(arg0, 0x2::coin::into_balance<T0>(arg1));
        v0
    }

    fun deposit_<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0x1::type_name::get<0x2::balance::Balance<T0>>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.assets.f_asset, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.assets.f_asset, v0), arg1);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.assets.f_asset, v0, arg1);
        };
    }

    fun err_asset_not_enough() {
        abort 10005
    }

    fun err_asset_not_in_vault() : u64 {
        abort 10004
    }

    fun err_nf_asset_existed() {
        abort 10007
    }

    fun err_protocol_not_supported() {
        abort 10003
    }

    fun err_vault_id_not_matched() {
        abort 10006
    }

    fun err_version_already_existed() {
        abort 10000
    }

    fun err_version_not_allowed() {
        abort 10002
    }

    fun err_version_not_existed() {
        abort 10001
    }

    public fun fee_rate<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::float::floor(arg0.fee_rate)
    }

    fun fetch_bucket_value<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        0
    }

    fun fetch_f_value<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        0
    }

    fun fetch_momentum_value<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        0
    }

    fun fetch_navi_value<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        0
    }

    fun fetch_nf_value<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        0
    }

    fun fetch_scallop_value<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        0
    }

    fun fetch_steamm_value<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        0
    }

    fun fetch_suilend_value<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        0
    }

    fun fetch_typus_value<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        0
    }

    fun init(arg0: VAULT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<VAULT>(arg0, arg1);
    }

    fun inner_value<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        fetch_f_value<T0, T1>(arg0) + fetch_nf_value<T0, T1>(arg0)
    }

    fun is_bucket<T0: drop + store>() : bool {
        let v0 = 0x1::type_name::get<T0>();
        if (v0 == 0x1::type_name::get<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::bucket_adapter::BucketProtocolBorrowRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::bucket_adapter::BucketProtocolRepayRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::bucket_adapter::BucketProtocolWithdrawRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::bucket_adapter::BucketProtocolClaimRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::bucket_adapter::BucketProtocolDepositRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::bucket_adapter::BucketProtocolBorrowReceipt>()) {
            true
        } else if (v0 == 0x1::type_name::get<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::bucket_adapter::BucketProtocolRepayReceipt>()) {
            true
        } else if (v0 == 0x1::type_name::get<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::bucket_adapter::BucketProtocolWithdrawReceipt>()) {
            true
        } else if (v0 == 0x1::type_name::get<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::bucket_adapter::BucketProtocolClaimReceipt>()) {
            true
        } else {
            v0 == 0x1::type_name::get<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::bucket_adapter::BucketProtocolDepositReceipt>()
        }
    }

    fun is_momentum<T0: drop + store>() : bool {
        let v0 = 0x1::type_name::get<T0>();
        if (v0 == 0x1::type_name::get<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::momentum_adapter::MomentumProtocolSwapRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::momentum_adapter::MomentumProtocolOpenPositionRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::momentum_adapter::MomentumProtocolClosePositionRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::momentum_adapter::MomentumProtocolAddLiquidityRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::momentum_adapter::MomentumProtocolRemoveLiquidityRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::momentum_adapter::MomentumProtocolClaimRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::momentum_adapter::MomentumProtocolSwapReceipt>()) {
            true
        } else if (v0 == 0x1::type_name::get<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::momentum_adapter::MomentumProtocolAddLiquidityReceipt>()) {
            true
        } else if (v0 == 0x1::type_name::get<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::momentum_adapter::MomentumProtocolRemoveLiquidityReceipt>()) {
            true
        } else if (v0 == 0x1::type_name::get<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::momentum_adapter::MomentumProtocolOpenPositionReceipt>()) {
            true
        } else if (v0 == 0x1::type_name::get<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::momentum_adapter::MomentumProtocolClosePositionReceipt>()) {
            true
        } else {
            v0 == 0x1::type_name::get<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::momentum_adapter::MomentumProtocolClaimReceipt>()
        }
    }

    fun is_navi<T0: drop + store>() : bool {
        let v0 = 0x1::type_name::get<T0>();
        if (v0 == 0x1::type_name::get<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::navi_adapter::NaviProtocolBorrowRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::navi_adapter::NaviProtocolSupplyRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::navi_adapter::NaviProtocolRepayRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::navi_adapter::NaviProtocolClaimRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::navi_adapter::NaviProtocolWithdrawRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::navi_adapter::NaviProtocolCreateAccountRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::navi_adapter::NaviProtocolBorrowReceipt>()) {
            true
        } else if (v0 == 0x1::type_name::get<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::navi_adapter::NaviProtocolSupplyReceipt>()) {
            true
        } else if (v0 == 0x1::type_name::get<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::navi_adapter::NaviProtocolRepayReceipt>()) {
            true
        } else if (v0 == 0x1::type_name::get<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::navi_adapter::NaviProtocolClaimReceipt>()) {
            true
        } else if (v0 == 0x1::type_name::get<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::navi_adapter::NaviProtocolWithdrawReceipt>()) {
            true
        } else {
            v0 == 0x1::type_name::get<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::navi_adapter::NaviProtocolCreateAccountReceipt>()
        }
    }

    fun is_scallop<T0: drop + store>() : bool {
        let v0 = 0x1::type_name::get<T0>();
        if (v0 == 0x1::type_name::get<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::scallop_adapter::ScallopProtocolBorrowRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::scallop_adapter::ScallopProtocolSupplyRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::scallop_adapter::ScallopProtocolRepayRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::scallop_adapter::ScallopProtocolWithdrawRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::scallop_adapter::ScallopProtocolClaimRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::scallop_adapter::ScallopProtocolOpenObligationRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::scallop_adapter::ScallopProtocolCollateralRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::scallop_adapter::ScallopProtocolBorrowReceipt>()) {
            true
        } else if (v0 == 0x1::type_name::get<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::scallop_adapter::ScallopProtocolSupplyReceipt>()) {
            true
        } else if (v0 == 0x1::type_name::get<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::scallop_adapter::ScallopProtocolRepayReceipt>()) {
            true
        } else if (v0 == 0x1::type_name::get<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::scallop_adapter::ScallopProtocolWithdrawReceipt>()) {
            true
        } else if (v0 == 0x1::type_name::get<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::scallop_adapter::ScallopProtocolClaimReceipt>()) {
            true
        } else if (v0 == 0x1::type_name::get<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::scallop_adapter::ScallopProtocolOpenObligationReceipt>()) {
            true
        } else {
            v0 == 0x1::type_name::get<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::scallop_adapter::ScallopProtocolCollateralReceipt>()
        }
    }

    fun is_steamm<T0: drop + store>() : bool {
        let v0 = 0x1::type_name::get<T0>();
        if (v0 == 0x1::type_name::get<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::steamm_adapter::SteammProtocolSwapRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::steamm_adapter::SteammProtocolAddLiquidityRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::steamm_adapter::SteammProtocolRemoveLiquidityRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::steamm_adapter::SteammProtocolClaimRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::steamm_adapter::SteammProtocolSwapReceipt>()) {
            true
        } else if (v0 == 0x1::type_name::get<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::steamm_adapter::SteammProtocolAddLiquidityReceipt>()) {
            true
        } else if (v0 == 0x1::type_name::get<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::steamm_adapter::SteammProtocolRemoveLiquidityReceipt>()) {
            true
        } else {
            v0 == 0x1::type_name::get<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::steamm_adapter::SteammProtocolClaimReceipt>()
        }
    }

    fun is_suilend<T0: drop + store>() : bool {
        let v0 = 0x1::type_name::get<T0>();
        if (v0 == 0x1::type_name::get<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::suilend_adapter::SuilendProtocolBorrowRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::suilend_adapter::SuilendProtocolSupplyRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::suilend_adapter::SuilendProtocolRepayRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::suilend_adapter::SuilendProtocolWithdrawRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::suilend_adapter::SuilendProtocolClaimRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::suilend_adapter::SuilendProtocolCreateObligationRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::suilend_adapter::SuilendProtocolBorrowReceipt>()) {
            true
        } else if (v0 == 0x1::type_name::get<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::suilend_adapter::SuilendProtocolSupplyReceipt>()) {
            true
        } else if (v0 == 0x1::type_name::get<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::suilend_adapter::SuilendProtocolRepayReceipt>()) {
            true
        } else if (v0 == 0x1::type_name::get<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::suilend_adapter::SuilendProtocolWithdrawReceipt>()) {
            true
        } else if (v0 == 0x1::type_name::get<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::suilend_adapter::SuilendProtocolClaimReceipt>()) {
            true
        } else {
            v0 == 0x1::type_name::get<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::suilend_adapter::SuilendProtocolCreateObligationReceipt>()
        }
    }

    fun is_typus<T0: drop + store>() : bool {
        let v0 = 0x1::type_name::get<T0>();
        if (v0 == 0x1::type_name::get<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::typus_adapter::TypusFinanceBuyLongRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::typus_adapter::TypusFinanceBuyShortRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::typus_adapter::TypusFinanceSellLongRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::typus_adapter::TypusFinanceSellShortRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::typus_adapter::TypusFinanceBuyLongReceipt>()) {
            true
        } else if (v0 == 0x1::type_name::get<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::typus_adapter::TypusFinanceBuyShortReceipt>()) {
            true
        } else if (v0 == 0x1::type_name::get<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::typus_adapter::TypusFinanceSellLongReceipt>()) {
            true
        } else {
            v0 == 0x1::type_name::get<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::typus_adapter::TypusFinanceSellShortReceipt>()
        }
    }

    fun new_<T0, T1>(arg0: 0x2::coin::TreasuryCap<T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (Vault<T0, T1>, VaultCap<T0, T1>) {
        let v0 = Asset{
            f_asset  : 0x2::bag::new(arg2),
            nf_asset : 0x2::bag::new(arg2),
        };
        let v1 = Vault<T0, T1>{
            id       : 0x2::object::new(arg2),
            versions : 0x2::vec_set::singleton<u64>(1),
            assets   : v0,
            supply   : 0x2::coin::treasury_into_supply<T1>(arg0),
            fee_rate : 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::float::from_bps(arg1),
        };
        let v2 = VaultCap<T0, T1>{
            id       : 0x2::object::new(arg2),
            vault_id : 0x2::object::id<Vault<T0, T1>>(&v1),
        };
        (v1, v2)
    }

    public fun new_vault_for_partner<T0, T1, T2: drop>(arg0: 0x2::coin::TreasuryCap<T1>, arg1: u64, arg2: address, arg3: T2, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg1 >= (0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::constants::max_following_fee() as u64)) {
            (0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::constants::partner_max_following_fee() as u64)
        } else {
            arg1
        };
        let (v1, v2) = new_<T0, T1>(arg0, v0, arg4);
        0x2::transfer::share_object<Vault<T0, T1>>(v1);
        0x2::transfer::public_transfer<VaultCap<T0, T1>>(v2, arg2);
    }

    public fun put_account_cap_from_navi<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::Collector, arg2: 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::navi_adapter::NaviProtocolCreateAccountReceipt) {
        if (0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::vault_id(arg1) != 0x2::object::id<Vault<T0, T1>>(arg0)) {
            err_vault_id_not_matched();
        };
        0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::navi_adapter::drop_create_account_receipt(arg2);
        add_nf_asset<T0, T1, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(arg0, 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::navi_adapter::extract_account_cap<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::navi_adapter::NaviProtocolCreateAccountReceipt>(arg1, &arg2, true));
    }

    public fun put_asset_after_adding_liquidity_from_momentum<T0, T1, T2, T3>(arg0: &mut Vault<T0, T1>, arg1: &mut 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::Collector, arg2: 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::momentum_adapter::MomentumProtocolAddLiquidityReceipt) {
        if (0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::vault_id(arg1) != 0x2::object::id<Vault<T0, T1>>(arg0)) {
            err_vault_id_not_matched();
        };
        0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::momentum_adapter::drop_add_liquidity_receipt(arg2);
        add_nf_asset<T0, T1, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(arg0, 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::momentum_adapter::extract_position<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::momentum_adapter::MomentumProtocolAddLiquidityReceipt>(arg1, &arg2, false));
        add_f_asset<T0, T1, T2>(arg0, 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::momentum_adapter::extract_balance<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::momentum_adapter::MomentumProtocolAddLiquidityReceipt, T2>(arg1, &arg2, false));
        add_f_asset<T0, T1, T3>(arg0, 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::momentum_adapter::extract_balance<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::momentum_adapter::MomentumProtocolAddLiquidityReceipt, T3>(arg1, &arg2, true));
    }

    public fun put_asset_after_collateral_from_scallop<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::Collector, arg2: 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::scallop_adapter::ScallopProtocolCollateralReceipt) {
        if (0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::vault_id(arg1) != 0x2::object::id<Vault<T0, T1>>(arg0)) {
            err_vault_id_not_matched();
        };
        0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::scallop_adapter::extract_and_drop_no_asset_proof<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::scallop_adapter::ScallopProtocolCollateralReceipt>(arg1, &arg2);
        0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::scallop_adapter::drop_collateral_receipt(arg2);
    }

    public fun put_asset_after_depositing_from_bucket<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::Collector, arg2: 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::bucket_adapter::BucketProtocolDepositReceipt) {
        if (0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::vault_id(arg1) != 0x2::object::id<Vault<T0, T1>>(arg0)) {
            err_vault_id_not_matched();
        };
        0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::bucket_adapter::drop_deposit_receipt(arg2);
        add_nf_asset<T0, T1, 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(arg0, 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::bucket_adapter::extract_stake_proof<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::bucket_adapter::BucketProtocolDepositReceipt>(arg1, &arg2, true));
    }

    public fun put_asset_after_removing_liquidity_from_momentum<T0, T1, T2, T3>(arg0: &mut Vault<T0, T1>, arg1: &mut 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::Collector, arg2: 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::momentum_adapter::MomentumProtocolRemoveLiquidityReceipt) {
        if (0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::vault_id(arg1) != 0x2::object::id<Vault<T0, T1>>(arg0)) {
            err_vault_id_not_matched();
        };
        0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::momentum_adapter::drop_remove_liquidity_receipt(arg2);
        add_nf_asset<T0, T1, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(arg0, 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::momentum_adapter::extract_position<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::momentum_adapter::MomentumProtocolRemoveLiquidityReceipt>(arg1, &arg2, false));
        add_f_asset<T0, T1, T2>(arg0, 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::momentum_adapter::extract_balance<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::momentum_adapter::MomentumProtocolRemoveLiquidityReceipt, T2>(arg1, &arg2, false));
        add_f_asset<T0, T1, T3>(arg0, 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::momentum_adapter::extract_balance<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::momentum_adapter::MomentumProtocolRemoveLiquidityReceipt, T3>(arg1, &arg2, true));
    }

    public fun put_asset_after_repaying_from_bucket<T0, T1, T2>(arg0: &mut Vault<T0, T1>, arg1: &mut 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::Collector, arg2: 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::bucket_adapter::BucketProtocolRepayReceipt) {
        if (0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::vault_id(arg1) != 0x2::object::id<Vault<T0, T1>>(arg0)) {
            err_vault_id_not_matched();
        };
        0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::bucket_adapter::drop_repay_receipt(arg2);
        add_f_asset<T0, T1, T2>(arg0, 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::bucket_adapter::extract_balance<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::bucket_adapter::BucketProtocolRepayReceipt, T2>(arg1, &arg2, true));
    }

    public fun put_asset_after_repaying_from_navi<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::Collector, arg2: 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::navi_adapter::NaviProtocolRepayReceipt) {
        if (0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::vault_id(arg1) != 0x2::object::id<Vault<T0, T1>>(arg0)) {
            err_vault_id_not_matched();
        };
        0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::navi_adapter::drop_repay_receipt(arg2);
        add_nf_asset<T0, T1, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(arg0, 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::navi_adapter::extract_account_cap<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::navi_adapter::NaviProtocolRepayReceipt>(arg1, &arg2, true));
    }

    public fun put_asset_after_repaying_from_scallop<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::Collector, arg2: 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::scallop_adapter::ScallopProtocolRepayReceipt) {
        if (0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::vault_id(arg1) != 0x2::object::id<Vault<T0, T1>>(arg0)) {
            err_vault_id_not_matched();
        };
        0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::scallop_adapter::extract_and_drop_no_asset_proof<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::scallop_adapter::ScallopProtocolRepayReceipt>(arg1, &arg2);
        0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::scallop_adapter::drop_repay_receipt(arg2);
    }

    public fun put_asset_after_repaying_from_suilend<T0, T1, T2, T3>(arg0: &mut Vault<T0, T1>, arg1: &mut 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::Collector, arg2: 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::suilend_adapter::SuilendProtocolRepayReceipt) {
        if (0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::vault_id(arg1) != 0x2::object::id<Vault<T0, T1>>(arg0)) {
            err_vault_id_not_matched();
        };
        0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::suilend_adapter::drop_repay_receipt(arg2);
        add_nf_asset<T0, T1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T2>>(arg0, 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::suilend_adapter::extract_obligation_owner_cap<T2, 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::suilend_adapter::SuilendProtocolRepayReceipt>(arg1, &arg2, false));
        add_f_asset<T0, T1, T3>(arg0, 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::suilend_adapter::extract_balance<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::suilend_adapter::SuilendProtocolRepayReceipt, T3>(arg1, &arg2, true));
    }

    public fun put_asset_after_supplying_from_navi<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::Collector, arg2: 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::navi_adapter::NaviProtocolSupplyReceipt) {
        if (0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::vault_id(arg1) != 0x2::object::id<Vault<T0, T1>>(arg0)) {
            err_vault_id_not_matched();
        };
        0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::navi_adapter::drop_supply_receipt(arg2);
        add_nf_asset<T0, T1, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(arg0, 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::navi_adapter::extract_account_cap<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::navi_adapter::NaviProtocolSupplyReceipt>(arg1, &arg2, true));
    }

    public fun put_asset_after_supplying_from_scallop<T0, T1, T2>(arg0: &mut Vault<T0, T1>, arg1: &mut 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::Collector, arg2: 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::scallop_adapter::ScallopProtocolSupplyReceipt) {
        if (0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::vault_id(arg1) != 0x2::object::id<Vault<T0, T1>>(arg0)) {
            err_vault_id_not_matched();
        };
        0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::scallop_adapter::drop_supply_receipt(arg2);
        add_f_asset<T0, T1, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T2>>(arg0, 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::scallop_adapter::extract_balance<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::scallop_adapter::ScallopProtocolSupplyReceipt, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T2>>(arg1, &arg2, true));
    }

    public fun put_asset_after_supplying_from_suilend<T0, T1, T2>(arg0: &mut Vault<T0, T1>, arg1: &mut 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::Collector, arg2: 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::suilend_adapter::SuilendProtocolSupplyReceipt) {
        if (0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::vault_id(arg1) != 0x2::object::id<Vault<T0, T1>>(arg0)) {
            err_vault_id_not_matched();
        };
        0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::suilend_adapter::drop_supply_receipt(arg2);
        add_nf_asset<T0, T1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T2>>(arg0, 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::suilend_adapter::extract_obligation_owner_cap<T2, 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::suilend_adapter::SuilendProtocolSupplyReceipt>(arg1, &arg2, true));
    }

    public fun put_asset_after_swapping_from_momentum<T0, T1, T2, T3>(arg0: &mut Vault<T0, T1>, arg1: &mut 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::Collector, arg2: 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::momentum_adapter::MomentumProtocolSwapReceipt) {
        if (0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::vault_id(arg1) != 0x2::object::id<Vault<T0, T1>>(arg0)) {
            err_vault_id_not_matched();
        };
        0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::momentum_adapter::drop_swap_receipt(arg2);
        add_f_asset<T0, T1, T2>(arg0, 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::momentum_adapter::extract_balance<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::momentum_adapter::MomentumProtocolSwapReceipt, T2>(arg1, &arg2, false));
        add_f_asset<T0, T1, T3>(arg0, 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::momentum_adapter::extract_balance<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::momentum_adapter::MomentumProtocolSwapReceipt, T3>(arg1, &arg2, true));
    }

    public fun put_borrowed_asset_from_bucket<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::Collector, arg2: 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::bucket_adapter::BucketProtocolBorrowReceipt) {
        if (0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::vault_id(arg1) != 0x2::object::id<Vault<T0, T1>>(arg0)) {
            err_vault_id_not_matched();
        };
        0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::bucket_adapter::drop_borrow_receipt(arg2);
        add_f_asset<T0, T1, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(arg0, 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::bucket_adapter::extract_balance<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::bucket_adapter::BucketProtocolBorrowReceipt, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(arg1, &arg2, true));
    }

    public fun put_borrowed_asset_from_navi<T0, T1, T2>(arg0: &mut Vault<T0, T1>, arg1: &mut 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::Collector, arg2: 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::navi_adapter::NaviProtocolBorrowReceipt) {
        if (0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::vault_id(arg1) != 0x2::object::id<Vault<T0, T1>>(arg0)) {
            err_vault_id_not_matched();
        };
        0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::navi_adapter::drop_borrow_receipt(arg2);
        add_nf_asset<T0, T1, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(arg0, 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::navi_adapter::extract_account_cap<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::navi_adapter::NaviProtocolBorrowReceipt>(arg1, &arg2, false));
        add_f_asset<T0, T1, T2>(arg0, 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::navi_adapter::extract_balance<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::navi_adapter::NaviProtocolBorrowReceipt, T2>(arg1, &arg2, true));
    }

    public fun put_borrowed_asset_from_scallop<T0, T1, T2>(arg0: &mut Vault<T0, T1>, arg1: &mut 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::Collector, arg2: 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::scallop_adapter::ScallopProtocolBorrowReceipt) {
        if (0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::vault_id(arg1) != 0x2::object::id<Vault<T0, T1>>(arg0)) {
            err_vault_id_not_matched();
        };
        0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::scallop_adapter::drop_borrow_receipt(arg2);
        add_nf_asset<T0, T1, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey>(arg0, 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::scallop_adapter::extract_obligation_key<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::scallop_adapter::ScallopProtocolBorrowReceipt>(arg1, &arg2, false));
        add_f_asset<T0, T1, T2>(arg0, 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::scallop_adapter::extract_balance<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::scallop_adapter::ScallopProtocolBorrowReceipt, T2>(arg1, &arg2, true));
    }

    public fun put_borrowed_asset_from_suilend<T0, T1, T2, T3>(arg0: &mut Vault<T0, T1>, arg1: &mut 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::Collector, arg2: 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::suilend_adapter::SuilendProtocolBorrowReceipt) {
        if (0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::vault_id(arg1) != 0x2::object::id<Vault<T0, T1>>(arg0)) {
            err_vault_id_not_matched();
        };
        0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::suilend_adapter::drop_borrow_receipt(arg2);
        add_nf_asset<T0, T1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T2>>(arg0, 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::suilend_adapter::extract_obligation_owner_cap<T2, 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::suilend_adapter::SuilendProtocolBorrowReceipt>(arg1, &arg2, false));
        add_f_asset<T0, T1, T3>(arg0, 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::suilend_adapter::extract_balance<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::suilend_adapter::SuilendProtocolBorrowReceipt, T3>(arg1, &arg2, true));
    }

    public fun put_claimed_asset_from_bucket<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::Collector, arg2: 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::bucket_adapter::BucketProtocolClaimReceipt) {
        if (0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::vault_id(arg1) != 0x2::object::id<Vault<T0, T1>>(arg0)) {
            err_vault_id_not_matched();
        };
        0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::bucket_adapter::drop_claim_receipt(arg2);
        add_nf_asset<T0, T1, 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(arg0, 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::bucket_adapter::extract_stake_proof<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::bucket_adapter::BucketProtocolClaimReceipt>(arg1, &arg2, false));
        add_f_asset<T0, T1, 0x2::sui::SUI>(arg0, 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::bucket_adapter::extract_balance<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::bucket_adapter::BucketProtocolClaimReceipt, 0x2::sui::SUI>(arg1, &arg2, true));
    }

    public fun put_claimed_asset_from_momentum<T0, T1, T2>(arg0: &mut Vault<T0, T1>, arg1: &mut 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::Collector, arg2: 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::momentum_adapter::MomentumProtocolClaimReceipt) {
        if (0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::vault_id(arg1) != 0x2::object::id<Vault<T0, T1>>(arg0)) {
            err_vault_id_not_matched();
        };
        0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::momentum_adapter::drop_claim_receipt(arg2);
        add_nf_asset<T0, T1, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(arg0, 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::momentum_adapter::extract_position<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::momentum_adapter::MomentumProtocolClaimReceipt>(arg1, &arg2, false));
        add_f_asset<T0, T1, T2>(arg0, 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::momentum_adapter::extract_balance<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::momentum_adapter::MomentumProtocolClaimReceipt, T2>(arg1, &arg2, true));
    }

    public fun put_claimed_asset_from_navi<T0, T1, T2>(arg0: &mut Vault<T0, T1>, arg1: &mut 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::Collector, arg2: 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::navi_adapter::NaviProtocolClaimReceipt) {
        if (0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::vault_id(arg1) != 0x2::object::id<Vault<T0, T1>>(arg0)) {
            err_vault_id_not_matched();
        };
        0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::navi_adapter::drop_claim_receipt(arg2);
        add_nf_asset<T0, T1, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(arg0, 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::navi_adapter::extract_account_cap<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::navi_adapter::NaviProtocolClaimReceipt>(arg1, &arg2, false));
        add_f_asset<T0, T1, T2>(arg0, 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::navi_adapter::extract_balance<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::navi_adapter::NaviProtocolClaimReceipt, T2>(arg1, &arg2, true));
    }

    public fun put_claimed_asset_from_scallop<T0, T1, T2>(arg0: &mut Vault<T0, T1>, arg1: &mut 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::Collector, arg2: 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::scallop_adapter::ScallopProtocolClaimReceipt) {
        if (0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::vault_id(arg1) != 0x2::object::id<Vault<T0, T1>>(arg0)) {
            err_vault_id_not_matched();
        };
        0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::scallop_adapter::drop_claim_receipt(arg2);
        add_nf_asset<T0, T1, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey>(arg0, 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::scallop_adapter::extract_obligation_key<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::scallop_adapter::ScallopProtocolClaimReceipt>(arg1, &arg2, false));
        add_f_asset<T0, T1, T2>(arg0, 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::scallop_adapter::extract_balance<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::scallop_adapter::ScallopProtocolClaimReceipt, T2>(arg1, &arg2, true));
    }

    public fun put_claimed_asset_from_suilend<T0, T1, T2, T3>(arg0: &mut Vault<T0, T1>, arg1: &mut 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::Collector, arg2: 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::suilend_adapter::SuilendProtocolClaimReceipt) {
        if (0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::vault_id(arg1) != 0x2::object::id<Vault<T0, T1>>(arg0)) {
            err_vault_id_not_matched();
        };
        0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::suilend_adapter::drop_claim_receipt(arg2);
        add_nf_asset<T0, T1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T2>>(arg0, 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::suilend_adapter::extract_obligation_owner_cap<T2, 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::suilend_adapter::SuilendProtocolClaimReceipt>(arg1, &arg2, false));
        add_f_asset<T0, T1, T3>(arg0, 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::suilend_adapter::extract_balance<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::suilend_adapter::SuilendProtocolClaimReceipt, T3>(arg1, &arg2, true));
    }

    public fun put_obligation_key_from_scallop<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::Collector, arg2: 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::scallop_adapter::ScallopProtocolOpenObligationReceipt) {
        if (0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::vault_id(arg1) != 0x2::object::id<Vault<T0, T1>>(arg0)) {
            err_vault_id_not_matched();
        };
        0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::scallop_adapter::drop_create_account_receipt(arg2);
        add_nf_asset<T0, T1, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey>(arg0, 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::scallop_adapter::extract_obligation_key<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::scallop_adapter::ScallopProtocolOpenObligationReceipt>(arg1, &arg2, true));
    }

    public fun put_obligation_owner_cap_from_suilend<T0, T1, T2>(arg0: &mut Vault<T0, T1>, arg1: &mut 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::Collector, arg2: 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::suilend_adapter::SuilendProtocolCreateObligationReceipt) {
        if (0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::vault_id(arg1) != 0x2::object::id<Vault<T0, T1>>(arg0)) {
            err_vault_id_not_matched();
        };
        0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::suilend_adapter::drop_create_obligation_receipt(arg2);
        add_nf_asset<T0, T1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T2>>(arg0, 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::suilend_adapter::extract_obligation_owner_cap<T2, 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::suilend_adapter::SuilendProtocolCreateObligationReceipt>(arg1, &arg2, true));
    }

    public fun put_position_from_momentum<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::Collector, arg2: 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::momentum_adapter::MomentumProtocolOpenPositionReceipt) {
        if (0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::vault_id(arg1) != 0x2::object::id<Vault<T0, T1>>(arg0)) {
            err_vault_id_not_matched();
        };
        0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::momentum_adapter::drop_open_position_receipt(arg2);
        add_nf_asset<T0, T1, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(arg0, 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::momentum_adapter::extract_position<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::momentum_adapter::MomentumProtocolOpenPositionReceipt>(arg1, &arg2, true));
    }

    public fun put_withdrawn_asset_from_bucket<T0, T1, T2, T3>(arg0: &mut Vault<T0, T1>, arg1: &mut 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::Collector, arg2: 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::bucket_adapter::BucketProtocolWithdrawReceipt) {
        if (0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::vault_id(arg1) != 0x2::object::id<Vault<T0, T1>>(arg0)) {
            err_vault_id_not_matched();
        };
        0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::bucket_adapter::drop_withdraw_receipt(arg2);
        add_f_asset<T0, T1, T2>(arg0, 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::bucket_adapter::extract_balance<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::bucket_adapter::BucketProtocolWithdrawReceipt, T2>(arg1, &arg2, false));
        add_f_asset<T0, T1, T3>(arg0, 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::bucket_adapter::extract_balance<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::bucket_adapter::BucketProtocolWithdrawReceipt, T3>(arg1, &arg2, true));
    }

    public fun put_withdrawn_asset_from_navi<T0, T1, T2>(arg0: &mut Vault<T0, T1>, arg1: &mut 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::Collector, arg2: 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::navi_adapter::NaviProtocolWithdrawReceipt) {
        if (0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::vault_id(arg1) != 0x2::object::id<Vault<T0, T1>>(arg0)) {
            err_vault_id_not_matched();
        };
        0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::navi_adapter::drop_withdraw_receipt(arg2);
        add_nf_asset<T0, T1, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(arg0, 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::navi_adapter::extract_account_cap<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::navi_adapter::NaviProtocolWithdrawReceipt>(arg1, &arg2, false));
        add_f_asset<T0, T1, T2>(arg0, 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::navi_adapter::extract_balance<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::navi_adapter::NaviProtocolWithdrawReceipt, T2>(arg1, &arg2, true));
    }

    public fun put_withdrawn_asset_from_scallop<T0, T1, T2>(arg0: &mut Vault<T0, T1>, arg1: &mut 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::Collector, arg2: 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::scallop_adapter::ScallopProtocolWithdrawReceipt) {
        if (0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::vault_id(arg1) != 0x2::object::id<Vault<T0, T1>>(arg0)) {
            err_vault_id_not_matched();
        };
        0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::scallop_adapter::drop_withdraw_receipt(arg2);
        add_f_asset<T0, T1, T2>(arg0, 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::scallop_adapter::extract_balance<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::scallop_adapter::ScallopProtocolWithdrawReceipt, T2>(arg1, &arg2, true));
    }

    public fun put_withdrawn_asset_from_suilend<T0, T1, T2, T3>(arg0: &mut Vault<T0, T1>, arg1: &mut 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::Collector, arg2: 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::suilend_adapter::SuilendProtocolWithdrawReceipt) {
        if (0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::vault_id(arg1) != 0x2::object::id<Vault<T0, T1>>(arg0)) {
            err_vault_id_not_matched();
        };
        0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::suilend_adapter::drop_withdraw_receipt(arg2);
        add_nf_asset<T0, T1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T2>>(arg0, 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::suilend_adapter::extract_obligation_owner_cap<T2, 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::suilend_adapter::SuilendProtocolWithdrawReceipt>(arg1, &arg2, false));
        add_f_asset<T0, T1, T3>(arg0, 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::suilend_adapter::extract_balance<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::suilend_adapter::SuilendProtocolWithdrawReceipt, T3>(arg1, &arg2, true));
    }

    public fun remove_version<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64) {
        if (0x2::vec_set::contains<u64>(&arg0.versions, &arg1)) {
            0x2::vec_set::remove<u64>(&mut arg0.versions, &arg1);
        } else {
            err_version_not_existed();
        };
    }

    public fun take_f_asset<T0, T1, T2, T3: drop + store>(arg0: &mut Vault<T0, T1>, arg1: 0x1::option::Option<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::Collector>, arg2: &VaultCap<T0, T1>, arg3: &T3, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::Collector, TakeAssetRequest<0x2::balance::Balance<T2>>) {
        let v0 = 0x1::type_name::get<0x2::balance::Balance<T2>>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.assets.f_asset, v0)) {
            err_asset_not_in_vault();
        };
        if (0x2::balance::value<T2>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&arg0.assets.f_asset, v0)) < arg4) {
            err_asset_not_enough();
        };
        add_partner_record<T0, T1, T3>(arg0);
        let v1 = if (0x1::option::is_some<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::Collector>(&arg1)) {
            let v2 = 0x1::option::destroy_some<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::Collector>(arg1);
            0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::collect_asset<0x2::balance::Balance<T2>, T3>(&mut v2, arg3, 0x2::balance::split<T2>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.assets.f_asset, v0), arg4), arg5);
            v2
        } else {
            0x1::option::destroy_none<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::Collector>(arg1);
            let v3 = 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::new(0x2::object::id<Vault<T0, T1>>(arg0));
            0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::collect_asset<0x2::balance::Balance<T2>, T3>(&mut v3, arg3, 0x2::balance::split<T2>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.assets.f_asset, v0), arg4), arg5);
            v3
        };
        let v4 = TakeAssetRequest<0x2::balance::Balance<T2>>{dummy_field: false};
        (v1, v4)
    }

    public fun take_nf_asset<T0, T1, T2: store, T3: drop + store>(arg0: &mut Vault<T0, T1>, arg1: 0x1::option::Option<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::Collector>, arg2: &VaultCap<T0, T1>, arg3: &T3, arg4: &mut 0x2::tx_context::TxContext) : (0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::Collector, TakeAssetRequest<T2>) {
        let v0 = 0x1::type_name::get<T2>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.assets.f_asset, v0)) {
            err_asset_not_in_vault();
        };
        add_partner_record<T0, T1, T3>(arg0);
        let v1 = if (0x1::option::is_some<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::Collector>(&arg1)) {
            let v2 = 0x1::option::destroy_some<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::Collector>(arg1);
            0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::collect_asset<T2, T3>(&mut v2, arg3, 0x2::bag::remove<0x1::type_name::TypeName, T2>(&mut arg0.assets.nf_asset, v0), arg4);
            v2
        } else {
            0x1::option::destroy_none<0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::Collector>(arg1);
            let v3 = 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::new(0x2::object::id<Vault<T0, T1>>(arg0));
            0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::collector::collect_asset<T2, T3>(&mut v3, arg3, 0x2::bag::remove<0x1::type_name::TypeName, T2>(&mut arg0.assets.nf_asset, v0), arg4);
            v3
        };
        let v4 = TakeAssetRequest<T2>{dummy_field: false};
        (v1, v4)
    }

    // decompiled from Move bytecode v6
}

