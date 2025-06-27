module 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::vault {
    struct Vault<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        versions: 0x2::vec_set::VecSet<u64>,
        assets: Asset,
        supply: 0x2::balance::Supply<T1>,
        fee_rate: 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::float::Float,
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
        let v0 = if (arg1 >= (0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::constants::max_following_fee() as u64)) {
            (0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::constants::max_following_fee() as u64)
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
        } else if (is_aftermath<T2>()) {
            add_record<T0, T1>(arg0, b"aftermath_protocol");
        } else if (is_stem<T2>()) {
            add_record<T0, T1>(arg0, b"stem_protocol");
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
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::float::floor(0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::float::mul_div(0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::float::from(arg1), 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::float::from(0x2::balance::supply_value<T1>(&arg0.supply)), 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::float::from(calculate_total_value<T0, T1>(arg0))))
    }

    fun calculate_total_value<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        inner_value<T0, T1>(arg0) + fetch_scallop_value<T0, T1>(arg0) + fetch_suilend_value<T0, T1>(arg0) + fetch_navi_value<T0, T1>(arg0) + fetch_typus_value<T0, T1>(arg0) + fetch_bucket_value<T0, T1>(arg0) + fetch_aftermath_value<T0, T1>(arg0) + fetch_stem_value<T0, T1>(arg0)
    }

    public fun create_aftermath_add_liquidity_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::aftermath_adapter::AftermathProtocolAddLiquidityRequest {
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::aftermath_adapter::new_add_liquidity_request()
    }

    public fun create_aftermath_claim_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::aftermath_adapter::AftermathProtocolClaimRequest {
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::aftermath_adapter::new_claim_request()
    }

    public fun create_aftermath_remove_liquidity_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::aftermath_adapter::AftermathProtocolRemoveLiquidityRequest {
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::aftermath_adapter::new_remove_liquidity_request()
    }

    public fun create_aftermath_swap_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::aftermath_adapter::AftermathProtocolSwapRequest {
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::aftermath_adapter::new_swap_request()
    }

    public fun create_bucket_borrow_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::bucket_adapter::BucketProtocolBorrowRequest {
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::bucket_adapter::new_borrow_request()
    }

    public fun create_bucket_claim_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::bucket_adapter::BucketProtocolClaimRequest {
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::bucket_adapter::new_claim_request()
    }

    public fun create_bucket_deposit_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::bucket_adapter::BucketProtocolDepositRequest {
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::bucket_adapter::new_deposit_request()
    }

    public fun create_bucket_repay_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::bucket_adapter::BucketProtocolRepayRequest {
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::bucket_adapter::new_repay_request()
    }

    public fun create_bucket_withdraw_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::bucket_adapter::BucketProtocolWithdrawRequest {
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::bucket_adapter::new_withdraw_request()
    }

    public fun create_navi_borrow_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::navi_adapter::NaviProtocolBorrowRequest {
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::navi_adapter::new_borrow_request()
    }

    public fun create_navi_claim_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::navi_adapter::NaviProtocolClaimRequest {
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::navi_adapter::new_claim_request()
    }

    public fun create_navi_repay_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::navi_adapter::NaviProtocolRepayRequest {
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::navi_adapter::new_repay_request()
    }

    public fun create_navi_supply_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::navi_adapter::NaviProtocolSupplyRequest {
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::navi_adapter::new_supply_request()
    }

    public fun create_navi_withdraw_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::navi_adapter::NaviProtocolWithdrawRequest {
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::navi_adapter::new_withdraw_request()
    }

    public fun create_scallop_borrow_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::scallop_adapter::ScallopProtocolBorrowRequest {
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::scallop_adapter::new_borrow_request()
    }

    public fun create_scallop_claim_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::scallop_adapter::ScallopProtocolClaimRequest {
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::scallop_adapter::new_claim_request()
    }

    public fun create_scallop_repay_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::scallop_adapter::ScallopProtocolRepayRequest {
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::scallop_adapter::new_repay_request()
    }

    public fun create_scallop_supply_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::scallop_adapter::ScallopProtocolSupplyRequest {
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::scallop_adapter::new_supply_request()
    }

    public fun create_scallop_withdraw_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::scallop_adapter::ScallopProtocolWithdrawRequest {
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::scallop_adapter::new_withdraw_request()
    }

    public fun create_stem_add_liquidity_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::stem_adapter::StemProtocolAddLiquidityRequest {
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::stem_adapter::new_add_liquidity_request()
    }

    public fun create_stem_claim_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::stem_adapter::StemProtocolClaimRequest {
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::stem_adapter::new_claim_request()
    }

    public fun create_stem_remove_liquidity_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::stem_adapter::StemProtocolRemoveLiquidityRequest {
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::stem_adapter::new_remove_liquidity_request()
    }

    public fun create_stem_swap_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::stem_adapter::StemProtocolSwapRequest {
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::stem_adapter::new_swap_request()
    }

    public fun create_suilend_borrow_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::suilend_adapter::SuilendProtocolBorrowRequest {
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::suilend_adapter::new_borrow_request()
    }

    public fun create_suilend_claim_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::suilend_adapter::SuilendProtocolClaimRequest {
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::suilend_adapter::new_claim_request()
    }

    public fun create_suilend_repay_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::suilend_adapter::SuilendProtocolRepayRequest {
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::suilend_adapter::new_repay_request()
    }

    public fun create_suilend_supply_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::suilend_adapter::SuilendProtocolSupplyRequest {
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::suilend_adapter::new_supply_request()
    }

    public fun create_suilend_withdraw_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::suilend_adapter::SuilendProtocolWithdrawRequest {
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::suilend_adapter::new_withdraw_request()
    }

    public fun create_typus_buy_long_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::typus_adapter::TypusFinanceBuyLongRequest {
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::typus_adapter::new_buy_long_request()
    }

    public fun create_typus_buy_short_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::typus_adapter::TypusFinanceBuyShortRequest {
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::typus_adapter::new_buy_short_request()
    }

    public fun create_typus_sell_long_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::typus_adapter::TypusFinanceSellLongRequest {
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::typus_adapter::new_sell_long_request()
    }

    public fun create_typus_sell_short_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::typus_adapter::TypusFinanceSellShortRequest {
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::typus_adapter::new_sell_short_request()
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

    fun err_amount_not_matched() {
        abort 10006
    }

    fun err_asset_not_enough() {
        abort 10005
    }

    fun err_asset_not_in_vault() : u64 {
        abort 10004
    }

    fun err_asset_type_not_matched() {
        abort 10007
    }

    fun err_nf_asset_existed() {
        abort 100
    }

    fun err_protocol_not_supported() {
        abort 10003
    }

    fun err_vault_id_not_matched() {
        abort 10008
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
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::float::floor(arg0.fee_rate)
    }

    fun fetch_aftermath_value<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        0
    }

    fun fetch_bucket_value<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        0
    }

    fun fetch_f_value<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
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

    fun fetch_stem_value<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
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

    fun is_aftermath<T0: drop + store>() : bool {
        let v0 = 0x1::type_name::get<T0>();
        if (v0 == 0x1::type_name::get<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::aftermath_adapter::AftermathProtocolSwapRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::aftermath_adapter::AftermathProtocolAddLiquidityRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::aftermath_adapter::AftermathProtocolRemoveLiquidityRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::aftermath_adapter::AftermathProtocolClaimRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::aftermath_adapter::AftermathProtocolSwapReceipt>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::aftermath_adapter::AftermathProtocolAddLiquidityReceipt>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::aftermath_adapter::AftermathProtocolRemoveLiquidityReceipt>()) {
            true
        } else {
            v0 == 0x1::type_name::get<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::aftermath_adapter::AftermathProtocolClaimReceipt>()
        }
    }

    fun is_bucket<T0: drop + store>() : bool {
        let v0 = 0x1::type_name::get<T0>();
        if (v0 == 0x1::type_name::get<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::bucket_adapter::BucketProtocolBorrowRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::bucket_adapter::BucketProtocolRepayRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::bucket_adapter::BucketProtocolWithdrawRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::bucket_adapter::BucketProtocolClaimRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::bucket_adapter::BucketProtocolDepositRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::bucket_adapter::BucketProtocolBorrowReceipt>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::bucket_adapter::BucketProtocolRepayReceipt>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::bucket_adapter::BucketProtocolWithdrawReceipt>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::bucket_adapter::BucketProtocolClaimReceipt>()) {
            true
        } else {
            v0 == 0x1::type_name::get<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::bucket_adapter::BucketProtocolDepositReceipt>()
        }
    }

    fun is_navi<T0: drop + store>() : bool {
        let v0 = 0x1::type_name::get<T0>();
        if (v0 == 0x1::type_name::get<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::navi_adapter::NaviProtocolBorrowRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::navi_adapter::NaviProtocolSupplyRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::navi_adapter::NaviProtocolRepayRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::navi_adapter::NaviProtocolClaimRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::navi_adapter::NaviProtocolWithdrawRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::navi_adapter::NaviProtocolCreateAccountRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::navi_adapter::NaviProtocolBorrowReceipt>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::navi_adapter::NaviProtocolSupplyReceipt>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::navi_adapter::NaviProtocolRepayReceipt>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::navi_adapter::NaviProtocolClaimReceipt>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::navi_adapter::NaviProtocolWithdrawReceipt>()) {
            true
        } else {
            v0 == 0x1::type_name::get<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::navi_adapter::NaviProtocolCreateAccountReceipt>()
        }
    }

    fun is_scallop<T0: drop + store>() : bool {
        let v0 = 0x1::type_name::get<T0>();
        if (v0 == 0x1::type_name::get<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::scallop_adapter::ScallopProtocolBorrowRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::scallop_adapter::ScallopProtocolSupplyRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::scallop_adapter::ScallopProtocolRepayRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::scallop_adapter::ScallopProtocolWithdrawRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::scallop_adapter::ScallopProtocolClaimRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::scallop_adapter::ScallopProtocolOpenObligationRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::scallop_adapter::ScallopProtocolCollateralRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::scallop_adapter::ScallopProtocolBorrowReceipt>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::scallop_adapter::ScallopProtocolSupplyReceipt>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::scallop_adapter::ScallopProtocolRepayReceipt>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::scallop_adapter::ScallopProtocolWithdrawReceipt>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::scallop_adapter::ScallopProtocolClaimReceipt>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::scallop_adapter::ScallopProtocolOpenObligationReceipt>()) {
            true
        } else {
            v0 == 0x1::type_name::get<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::scallop_adapter::ScallopProtocolCollateralReceipt>()
        }
    }

    fun is_stem<T0: drop + store>() : bool {
        let v0 = 0x1::type_name::get<T0>();
        if (v0 == 0x1::type_name::get<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::stem_adapter::StemProtocolSwapRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::stem_adapter::StemProtocolAddLiquidityRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::stem_adapter::StemProtocolRemoveLiquidityRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::stem_adapter::StemProtocolClaimRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::stem_adapter::StemProtocolSwapReceipt>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::stem_adapter::StemProtocolAddLiquidityReceipt>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::stem_adapter::StemProtocolRemoveLiquidityReceipt>()) {
            true
        } else {
            v0 == 0x1::type_name::get<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::stem_adapter::StemProtocolClaimReceipt>()
        }
    }

    fun is_suilend<T0: drop + store>() : bool {
        let v0 = 0x1::type_name::get<T0>();
        if (v0 == 0x1::type_name::get<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::suilend_adapter::SuilendProtocolBorrowRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::suilend_adapter::SuilendProtocolSupplyRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::suilend_adapter::SuilendProtocolRepayRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::suilend_adapter::SuilendProtocolWithdrawRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::suilend_adapter::SuilendProtocolClaimRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::suilend_adapter::SuilendProtocolBorrowReceipt>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::suilend_adapter::SuilendProtocolSupplyReceipt>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::suilend_adapter::SuilendProtocolRepayReceipt>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::suilend_adapter::SuilendProtocolWithdrawReceipt>()) {
            true
        } else {
            v0 == 0x1::type_name::get<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::suilend_adapter::SuilendProtocolClaimReceipt>()
        }
    }

    fun is_typus<T0: drop + store>() : bool {
        let v0 = 0x1::type_name::get<T0>();
        if (v0 == 0x1::type_name::get<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::typus_adapter::TypusFinanceBuyLongRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::typus_adapter::TypusFinanceBuyShortRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::typus_adapter::TypusFinanceSellLongRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::typus_adapter::TypusFinanceSellShortRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::typus_adapter::TypusFinanceBuyLongReceipt>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::typus_adapter::TypusFinanceBuyShortReceipt>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::typus_adapter::TypusFinanceSellLongReceipt>()) {
            true
        } else {
            v0 == 0x1::type_name::get<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::typus_adapter::TypusFinanceSellShortReceipt>()
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
            fee_rate : 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::float::from_bps(arg1),
        };
        let v2 = VaultCap<T0, T1>{
            id       : 0x2::object::new(arg2),
            vault_id : 0x2::object::id<Vault<T0, T1>>(&v1),
        };
        (v1, v2)
    }

    public fun new_vault_for_partner<T0, T1, T2: drop>(arg0: 0x2::coin::TreasuryCap<T1>, arg1: u64, arg2: address, arg3: T2, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg1 >= (0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::constants::max_following_fee() as u64)) {
            (0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::constants::partner_max_following_fee() as u64)
        } else {
            arg1
        };
        let (v1, v2) = new_<T0, T1>(arg0, v0, arg4);
        0x2::transfer::share_object<Vault<T0, T1>>(v1);
        0x2::transfer::public_transfer<VaultCap<T0, T1>>(v2, arg2);
    }

    public fun put_account_cap_from_navi<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::Collector, arg2: 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::navi_adapter::NaviProtocolCreateAccountReceipt) {
        if (0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::navi_adapter::create_account_receipt_vault_id(&arg2) != 0x2::object::id<Vault<T0, T1>>(arg0)) {
            err_vault_id_not_matched();
        };
        if (0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::navi_adapter::create_account_receipt_amount(&arg2) != 1) {
            err_amount_not_matched();
        };
        if (0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::navi_adapter::create_account_receipt_asset_type(&arg2) != 0x1::type_name::get<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>()) {
            err_asset_type_not_matched();
        };
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::navi_adapter::drop_create_account_receipt(arg2);
        add_nf_asset<T0, T1, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(arg0, 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::navi_adapter::extract_account_cap<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::navi_adapter::NaviProtocolCreateAccountReceipt>(arg1, &arg2, true));
    }

    public fun put_borrowed_asset_from_bucket<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::Collector, arg2: 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::bucket_adapter::BucketProtocolBorrowReceipt) {
        if (0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::bucket_adapter::borrow_receipt_vault_id(&arg2) != 0x2::object::id<Vault<T0, T1>>(arg0)) {
            err_vault_id_not_matched();
        };
        let v0 = 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::bucket_adapter::extract_balance<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::bucket_adapter::BucketProtocolBorrowReceipt, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(arg1, &arg2, true);
        if (0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::bucket_adapter::borrow_receipt_amount(&arg2) != 0x2::balance::value<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&v0)) {
            err_amount_not_matched();
        };
        if (0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::bucket_adapter::borrow_receipt_asset_type(&arg2) != 0x1::type_name::get<0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>>()) {
            err_asset_type_not_matched();
        };
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::bucket_adapter::drop_borrow_receipt(arg2);
        add_f_asset<T0, T1, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(arg0, v0);
    }

    public fun put_borrowed_asset_from_navi<T0, T1, T2>(arg0: &mut Vault<T0, T1>, arg1: &mut 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::Collector, arg2: 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::navi_adapter::NaviProtocolBorrowReceipt) {
        if (0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::navi_adapter::borrow_receipt_vault_id(&arg2) != 0x2::object::id<Vault<T0, T1>>(arg0)) {
            err_vault_id_not_matched();
        };
        let v0 = 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::navi_adapter::extract_balance<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::navi_adapter::NaviProtocolBorrowReceipt, T2>(arg1, &arg2, true);
        let v1 = 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::navi_adapter::borrow_receipt_amounts(&arg2);
        let v2 = 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::navi_adapter::borrow_receipt_amounts(&arg2);
        let v3 = 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::navi_adapter::borrow_receipt_asset_types(&arg2);
        let v4 = 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::navi_adapter::borrow_receipt_asset_types(&arg2);
        if (0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v4) != 0x1::type_name::get<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>() || 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v3) != 0x1::type_name::get<0x2::balance::Balance<T2>>()) {
            err_asset_type_not_matched();
        };
        if (0x1::vector::pop_back<u64>(&mut v2) != 1 || 0x1::vector::pop_back<u64>(&mut v1) != 0x2::balance::value<T2>(&v0)) {
            err_amount_not_matched();
        };
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::navi_adapter::drop_borrow_receipt(arg2);
        add_nf_asset<T0, T1, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(arg0, 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::navi_adapter::extract_account_cap<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::navi_adapter::NaviProtocolBorrowReceipt>(arg1, &arg2, false));
        add_f_asset<T0, T1, T2>(arg0, v0);
    }

    public fun put_borrowed_from_scallop<T0, T1, T2>(arg0: &mut Vault<T0, T1>, arg1: &mut 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::Collector, arg2: 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::scallop_adapter::ScallopProtocolBorrowReceipt) {
        if (0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::scallop_adapter::borrow_receipt_vault_id(&arg2) != 0x2::object::id<Vault<T0, T1>>(arg0)) {
            err_vault_id_not_matched();
        };
        let v0 = 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::scallop_adapter::extract_balance<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::scallop_adapter::ScallopProtocolBorrowReceipt, 0x2::balance::Balance<T2>>(arg1, &arg2, true);
        let v1 = 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::scallop_adapter::borrow_receipt_amounts(&arg2);
        let v2 = 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::scallop_adapter::borrow_receipt_amounts(&arg2);
        let v3 = 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::scallop_adapter::borrow_receipt_asset_types(&arg2);
        let v4 = 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::scallop_adapter::borrow_receipt_asset_types(&arg2);
        if (0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v4) != 0x1::type_name::get<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey>() || 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v3) != 0x1::type_name::get<0x2::balance::Balance<T2>>()) {
            err_asset_type_not_matched();
        };
        if (0x1::vector::pop_back<u64>(&mut v2) != 1 || 0x1::vector::pop_back<u64>(&mut v1) != 0x2::balance::value<0x2::balance::Balance<T2>>(&v0)) {
            err_amount_not_matched();
        };
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::scallop_adapter::drop_borrow_receipt(arg2);
        add_nf_asset<T0, T1, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey>(arg0, 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::scallop_adapter::extract_obligation_key<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::scallop_adapter::ScallopProtocolBorrowReceipt>(arg1, &arg2, false));
        add_f_asset<T0, T1, 0x2::balance::Balance<T2>>(arg0, v0);
    }

    public fun put_claimed_asset_from_bucket<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::Collector, arg2: 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::bucket_adapter::BucketProtocolClaimReceipt) {
        if (0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::bucket_adapter::claim_receipt_vault_id(&arg2) != 0x2::object::id<Vault<T0, T1>>(arg0)) {
            err_vault_id_not_matched();
        };
        let v0 = 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::bucket_adapter::extract_stake_proof<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::bucket_adapter::BucketProtocolClaimReceipt>(arg1, &arg2, false);
        let v1 = 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::bucket_adapter::extract_balance<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::bucket_adapter::BucketProtocolClaimReceipt, 0x2::sui::SUI>(arg1, &arg2, true);
        let v2 = 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::bucket_adapter::claim_receipt_amounts(&arg2);
        let v3 = 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::bucket_adapter::claim_receipt_amounts(&arg2);
        let v4 = 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::bucket_adapter::claim_receipt_asset_types(&arg2);
        let v5 = 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::bucket_adapter::claim_receipt_asset_types(&arg2);
        if (0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v5) != 0x1::type_name::get<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>() || 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v4) != 0x1::type_name::get<0x2::balance::Balance<0x2::sui::SUI>>()) {
            err_asset_type_not_matched();
        };
        if (0x1::vector::pop_back<u64>(&mut v3) != 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::get_proof_stake_amount<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>(&v0) || 0x1::vector::pop_back<u64>(&mut v2) != 0x2::balance::value<0x2::sui::SUI>(&v1)) {
            err_amount_not_matched();
        };
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::bucket_adapter::drop_claim_receipt(arg2);
        add_nf_asset<T0, T1, 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(arg0, v0);
        add_f_asset<T0, T1, 0x2::sui::SUI>(arg0, v1);
    }

    public fun put_claimed_asset_from_navi<T0, T1, T2>(arg0: &mut Vault<T0, T1>, arg1: &mut 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::Collector, arg2: 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::navi_adapter::NaviProtocolClaimReceipt) {
        if (0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::navi_adapter::claim_receipt_vault_id(&arg2) != 0x2::object::id<Vault<T0, T1>>(arg0)) {
            err_vault_id_not_matched();
        };
        let v0 = 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::navi_adapter::extract_balance<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::navi_adapter::NaviProtocolClaimReceipt, T2>(arg1, &arg2, true);
        let v1 = 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::navi_adapter::claim_receipt_amounts(&arg2);
        let v2 = 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::navi_adapter::claim_receipt_amounts(&arg2);
        let v3 = 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::navi_adapter::claim_receipt_asset_types(&arg2);
        let v4 = 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::navi_adapter::claim_receipt_asset_types(&arg2);
        if (0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v4) != 0x1::type_name::get<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>() || 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v3) != 0x1::type_name::get<0x2::balance::Balance<T2>>()) {
            err_asset_type_not_matched();
        };
        if (0x1::vector::pop_back<u64>(&mut v2) != 1 || 0x1::vector::pop_back<u64>(&mut v1) != 0x2::balance::value<T2>(&v0)) {
            err_amount_not_matched();
        };
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::navi_adapter::drop_claim_receipt(arg2);
        add_nf_asset<T0, T1, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(arg0, 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::navi_adapter::extract_account_cap<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::navi_adapter::NaviProtocolClaimReceipt>(arg1, &arg2, false));
        add_f_asset<T0, T1, T2>(arg0, v0);
    }

    public fun put_claimed_from_scallop<T0, T1, T2>(arg0: &mut Vault<T0, T1>, arg1: &mut 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::Collector, arg2: 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::scallop_adapter::ScallopProtocolClaimReceipt) {
        if (0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::scallop_adapter::claim_receipt_vault_id(&arg2) != 0x2::object::id<Vault<T0, T1>>(arg0)) {
            err_vault_id_not_matched();
        };
        let v0 = 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::scallop_adapter::extract_balance<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::scallop_adapter::ScallopProtocolClaimReceipt, 0x2::balance::Balance<T2>>(arg1, &arg2, true);
        let v1 = 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::scallop_adapter::claim_receipt_amounts(&arg2);
        let v2 = 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::scallop_adapter::claim_receipt_amounts(&arg2);
        let v3 = 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::scallop_adapter::claim_receipt_asset_types(&arg2);
        let v4 = 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::scallop_adapter::claim_receipt_asset_types(&arg2);
        if (0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v4) != 0x1::type_name::get<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey>() || 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v3) != 0x1::type_name::get<0x2::balance::Balance<T2>>()) {
            err_asset_type_not_matched();
        };
        if (0x1::vector::pop_back<u64>(&mut v2) != 1 || 0x1::vector::pop_back<u64>(&mut v1) != 0x2::balance::value<0x2::balance::Balance<T2>>(&v0)) {
            err_amount_not_matched();
        };
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::scallop_adapter::drop_claim_receipt(arg2);
        add_nf_asset<T0, T1, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey>(arg0, 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::scallop_adapter::extract_obligation_key<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::scallop_adapter::ScallopProtocolClaimReceipt>(arg1, &arg2, false));
        add_f_asset<T0, T1, 0x2::balance::Balance<T2>>(arg0, v0);
    }

    public fun put_collateral_from_scallop<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::Collector, arg2: 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::scallop_adapter::ScallopProtocolCollateralReceipt) {
        if (0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::scallop_adapter::collateral_receipt_vault_id(&arg2) != 0x2::object::id<Vault<T0, T1>>(arg0)) {
            err_vault_id_not_matched();
        };
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::scallop_adapter::extract_and_drop_no_asset_proof<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::scallop_adapter::ScallopProtocolCollateralReceipt>(arg1, &arg2);
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::scallop_adapter::drop_collateral_receipt(arg2);
    }

    public fun put_deposited_asset_from_bucket<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::Collector, arg2: 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::bucket_adapter::BucketProtocolDepositReceipt) {
        if (0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::bucket_adapter::deposit_receipt_vault_id(&arg2) != 0x2::object::id<Vault<T0, T1>>(arg0)) {
            err_vault_id_not_matched();
        };
        let v0 = 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::bucket_adapter::extract_stake_proof<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::bucket_adapter::BucketProtocolDepositReceipt>(arg1, &arg2, true);
        if (0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::bucket_adapter::deposit_receipt_amount(&arg2) != 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::get_proof_stake_amount<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>(&v0)) {
            err_amount_not_matched();
        };
        if (0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::bucket_adapter::deposit_receipt_asset_type(&arg2) != 0x1::type_name::get<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>()) {
            err_asset_type_not_matched();
        };
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::bucket_adapter::drop_deposit_receipt(arg2);
        add_nf_asset<T0, T1, 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(arg0, v0);
    }

    public fun put_obligation_key_from_scallop<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::Collector, arg2: 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::scallop_adapter::ScallopProtocolOpenObligationReceipt) {
        if (0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::scallop_adapter::open_obligation_receipt_vault_id(&arg2) != 0x2::object::id<Vault<T0, T1>>(arg0)) {
            err_vault_id_not_matched();
        };
        if (0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::scallop_adapter::open_obligation_receipt_amount(&arg2) != 1) {
            err_amount_not_matched();
        };
        if (0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::scallop_adapter::open_obligation_receipt_asset_type(&arg2) != 0x1::type_name::get<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey>()) {
            err_asset_type_not_matched();
        };
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::scallop_adapter::drop_create_account_receipt(arg2);
        add_nf_asset<T0, T1, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey>(arg0, 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::scallop_adapter::extract_obligation_key<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::scallop_adapter::ScallopProtocolOpenObligationReceipt>(arg1, &arg2, true));
    }

    public fun put_repaid_asset_from_bucket<T0, T1, T2>(arg0: &mut Vault<T0, T1>, arg1: &mut 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::Collector, arg2: 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::bucket_adapter::BucketProtocolRepayReceipt) {
        if (0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::bucket_adapter::repay_receipt_vault_id(&arg2) != 0x2::object::id<Vault<T0, T1>>(arg0)) {
            err_vault_id_not_matched();
        };
        let v0 = 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::bucket_adapter::extract_balance<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::bucket_adapter::BucketProtocolRepayReceipt, T2>(arg1, &arg2, true);
        if (0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::bucket_adapter::repay_receipt_amount(&arg2) != 0x2::balance::value<T2>(&v0)) {
            err_amount_not_matched();
        };
        if (0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::bucket_adapter::repay_receipt_asset_type(&arg2) != 0x1::type_name::get<0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>>()) {
            err_asset_type_not_matched();
        };
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::bucket_adapter::drop_repay_receipt(arg2);
        add_f_asset<T0, T1, T2>(arg0, v0);
    }

    public fun put_repaid_asset_from_navi<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::Collector, arg2: 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::navi_adapter::NaviProtocolRepayReceipt) {
        if (0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::navi_adapter::repay_receipt_vault_id(&arg2) != 0x2::object::id<Vault<T0, T1>>(arg0)) {
            err_vault_id_not_matched();
        };
        if (0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::navi_adapter::repay_receipt_amount(&arg2) != 1) {
            err_amount_not_matched();
        };
        if (0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::navi_adapter::repay_receipt_asset_type(&arg2) != 0x1::type_name::get<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>()) {
            err_asset_type_not_matched();
        };
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::navi_adapter::drop_repay_receipt(arg2);
        add_nf_asset<T0, T1, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(arg0, 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::navi_adapter::extract_account_cap<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::navi_adapter::NaviProtocolRepayReceipt>(arg1, &arg2, true));
    }

    public fun put_repaid_from_scallop<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::Collector, arg2: 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::scallop_adapter::ScallopProtocolRepayReceipt) {
        if (0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::scallop_adapter::repay_receipt_vault_id(&arg2) != 0x2::object::id<Vault<T0, T1>>(arg0)) {
            err_vault_id_not_matched();
        };
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::scallop_adapter::extract_and_drop_no_asset_proof<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::scallop_adapter::ScallopProtocolRepayReceipt>(arg1, &arg2);
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::scallop_adapter::drop_repay_receipt(arg2);
    }

    public fun put_supplied_asset_from_navi<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::Collector, arg2: 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::navi_adapter::NaviProtocolSupplyReceipt) {
        if (0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::navi_adapter::supply_receipt_vault_id(&arg2) != 0x2::object::id<Vault<T0, T1>>(arg0)) {
            err_vault_id_not_matched();
        };
        if (0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::navi_adapter::supply_receipt_amount(&arg2) != 1) {
            err_amount_not_matched();
        };
        if (0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::navi_adapter::supply_receipt_asset_type(&arg2) != 0x1::type_name::get<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>()) {
            err_asset_type_not_matched();
        };
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::navi_adapter::drop_supply_receipt(arg2);
        add_nf_asset<T0, T1, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(arg0, 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::navi_adapter::extract_account_cap<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::navi_adapter::NaviProtocolSupplyReceipt>(arg1, &arg2, true));
    }

    public fun put_supplied_from_scallop<T0, T1, T2>(arg0: &mut Vault<T0, T1>, arg1: &mut 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::Collector, arg2: 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::scallop_adapter::ScallopProtocolSupplyReceipt) {
        if (0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::scallop_adapter::supply_receipt_vault_id(&arg2) != 0x2::object::id<Vault<T0, T1>>(arg0)) {
            err_vault_id_not_matched();
        };
        let v0 = 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::scallop_adapter::extract_balance<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::scallop_adapter::ScallopProtocolSupplyReceipt, 0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T2>>>(arg1, &arg2, true);
        if (0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::scallop_adapter::supply_receipt_amount(&arg2) != 0x2::balance::value<0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T2>>>(&v0)) {
            err_amount_not_matched();
        };
        if (0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::scallop_adapter::supply_receipt_asset_type(&arg2) != 0x1::type_name::get<0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T2>>>()) {
            err_asset_type_not_matched();
        };
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::scallop_adapter::drop_supply_receipt(arg2);
        add_f_asset<T0, T1, 0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T2>>>(arg0, v0);
    }

    public fun put_withdrawn_asset_from_bucket<T0, T1, T2, T3>(arg0: &mut Vault<T0, T1>, arg1: &mut 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::Collector, arg2: 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::bucket_adapter::BucketProtocolWithdrawReceipt) {
        if (0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::bucket_adapter::withdraw_receipt_vault_id(&arg2) != 0x2::object::id<Vault<T0, T1>>(arg0)) {
            err_vault_id_not_matched();
        };
        let v0 = 0x1::type_name::get<0x2::balance::Balance<T2>>();
        let v1 = 0x1::type_name::get<0x2::balance::Balance<T3>>();
        let v2 = 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::bucket_adapter::extract_balance<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::bucket_adapter::BucketProtocolWithdrawReceipt, T2>(arg1, &arg2, false);
        let v3 = 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::bucket_adapter::extract_balance<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::bucket_adapter::BucketProtocolWithdrawReceipt, T3>(arg1, &arg2, true);
        let v4 = 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::bucket_adapter::withdraw_receipt_amounts(&arg2);
        let v5 = 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::bucket_adapter::withdraw_receipt_amounts(&arg2);
        let v6 = 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::bucket_adapter::withdraw_receipt_asset_types(&arg2);
        let v7 = 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v6);
        let v8 = 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::bucket_adapter::withdraw_receipt_asset_types(&arg2);
        let v9 = 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v8);
        if (v9 != v0 && v9 != v1 || v7 != v0 && v7 != v1) {
            err_asset_type_not_matched();
        };
        let (v10, v11) = if (v9 == v0) {
            (0x1::vector::pop_back<u64>(&mut v5), 0x1::vector::pop_back<u64>(&mut v4))
        } else {
            (0x1::vector::pop_back<u64>(&mut v4), 0x1::vector::pop_back<u64>(&mut v5))
        };
        if (v10 != 0x2::balance::value<T2>(&v2) || v11 != 0x2::balance::value<T3>(&v3)) {
            err_amount_not_matched();
        };
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::bucket_adapter::drop_withdraw_receipt(arg2);
        add_f_asset<T0, T1, T2>(arg0, v2);
        add_f_asset<T0, T1, T3>(arg0, v3);
    }

    public fun put_withdrawn_asset_from_navi<T0, T1, T2>(arg0: &mut Vault<T0, T1>, arg1: &mut 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::Collector, arg2: 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::navi_adapter::NaviProtocolWithdrawReceipt) {
        if (0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::navi_adapter::withdraw_receipt_vault_id(&arg2) != 0x2::object::id<Vault<T0, T1>>(arg0)) {
            err_vault_id_not_matched();
        };
        let v0 = 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::navi_adapter::extract_balance<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::navi_adapter::NaviProtocolWithdrawReceipt, T2>(arg1, &arg2, true);
        let v1 = 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::navi_adapter::withdraw_receipt_amounts(&arg2);
        let v2 = 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::navi_adapter::withdraw_receipt_amounts(&arg2);
        let v3 = 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::navi_adapter::withdraw_receipt_asset_types(&arg2);
        let v4 = 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::navi_adapter::withdraw_receipt_asset_types(&arg2);
        if (0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v4) != 0x1::type_name::get<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>() || 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v3) != 0x1::type_name::get<0x2::balance::Balance<T2>>()) {
            err_asset_type_not_matched();
        };
        if (0x1::vector::pop_back<u64>(&mut v2) != 1 || 0x1::vector::pop_back<u64>(&mut v1) != 0x2::balance::value<T2>(&v0)) {
            err_amount_not_matched();
        };
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::navi_adapter::drop_withdraw_receipt(arg2);
        add_nf_asset<T0, T1, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(arg0, 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::navi_adapter::extract_account_cap<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::navi_adapter::NaviProtocolWithdrawReceipt>(arg1, &arg2, false));
        add_f_asset<T0, T1, T2>(arg0, v0);
    }

    public fun put_withdrawn_from_scallop<T0, T1, T2>(arg0: &mut Vault<T0, T1>, arg1: &mut 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::Collector, arg2: 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::scallop_adapter::ScallopProtocolWithdrawReceipt) {
        if (0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::scallop_adapter::withdraw_receipt_vault_id(&arg2) != 0x2::object::id<Vault<T0, T1>>(arg0)) {
            err_vault_id_not_matched();
        };
        let v0 = 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::scallop_adapter::extract_balance<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::scallop_adapter::ScallopProtocolWithdrawReceipt, 0x2::balance::Balance<T2>>(arg1, &arg2, true);
        if (0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::scallop_adapter::withdraw_receipt_amount(&arg2) != 0x2::balance::value<0x2::balance::Balance<T2>>(&v0)) {
            err_amount_not_matched();
        };
        if (0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::scallop_adapter::withdraw_receipt_asset_type(&arg2) != 0x1::type_name::get<0x2::balance::Balance<T2>>()) {
            err_asset_type_not_matched();
        };
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::scallop_adapter::drop_withdraw_receipt(arg2);
        add_f_asset<T0, T1, 0x2::balance::Balance<T2>>(arg0, v0);
    }

    public fun remove_version<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64) {
        if (0x2::vec_set::contains<u64>(&arg0.versions, &arg1)) {
            0x2::vec_set::remove<u64>(&mut arg0.versions, &arg1);
        } else {
            err_version_not_existed();
        };
    }

    public fun take_f_asset<T0, T1, T2, T3: drop + store>(arg0: &mut Vault<T0, T1>, arg1: 0x1::option::Option<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::Collector>, arg2: &VaultCap<T0, T1>, arg3: &T3, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::Collector, TakeAssetRequest<0x2::balance::Balance<T2>>) {
        let v0 = 0x1::type_name::get<0x2::balance::Balance<T2>>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.assets.f_asset, v0)) {
            err_asset_not_in_vault();
        };
        if (0x2::balance::value<T2>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&arg0.assets.f_asset, v0)) < arg4) {
            err_asset_not_enough();
        };
        add_partner_record<T0, T1, T3>(arg0);
        let v1 = if (0x1::option::is_some<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::Collector>(&arg1)) {
            let v2 = 0x1::option::destroy_some<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::Collector>(arg1);
            0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::collect_asset<0x2::balance::Balance<T2>, T3>(&mut v2, arg3, 0x2::balance::split<T2>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.assets.f_asset, v0), arg4), arg5);
            v2
        } else {
            0x1::option::destroy_none<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::Collector>(arg1);
            let v3 = 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::new(0x2::object::id<Vault<T0, T1>>(arg0));
            0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::collect_asset<0x2::balance::Balance<T2>, T3>(&mut v3, arg3, 0x2::balance::split<T2>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.assets.f_asset, v0), arg4), arg5);
            v3
        };
        let v4 = TakeAssetRequest<0x2::balance::Balance<T2>>{dummy_field: false};
        (v1, v4)
    }

    public fun take_nf_asset<T0, T1, T2: store, T3: drop + store>(arg0: &mut Vault<T0, T1>, arg1: 0x1::option::Option<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::Collector>, arg2: &VaultCap<T0, T1>, arg3: &T3, arg4: &mut 0x2::tx_context::TxContext) : (0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::Collector, TakeAssetRequest<T2>) {
        let v0 = 0x1::type_name::get<T2>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.assets.f_asset, v0)) {
            err_asset_not_in_vault();
        };
        add_partner_record<T0, T1, T3>(arg0);
        let v1 = if (0x1::option::is_some<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::Collector>(&arg1)) {
            let v2 = 0x1::option::destroy_some<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::Collector>(arg1);
            0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::collect_asset<T2, T3>(&mut v2, arg3, 0x2::bag::remove<0x1::type_name::TypeName, T2>(&mut arg0.assets.nf_asset, v0), arg4);
            v2
        } else {
            0x1::option::destroy_none<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::Collector>(arg1);
            let v3 = 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::new(0x2::object::id<Vault<T0, T1>>(arg0));
            0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::collect_asset<T2, T3>(&mut v3, arg3, 0x2::bag::remove<0x1::type_name::TypeName, T2>(&mut arg0.assets.nf_asset, v0), arg4);
            v3
        };
        let v4 = TakeAssetRequest<T2>{dummy_field: false};
        (v1, v4)
    }

    // decompiled from Move bytecode v6
}

