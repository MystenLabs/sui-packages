module 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::vault {
    struct Vault<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        versions: 0x2::vec_set::VecSet<u64>,
        assets: Asset,
        supply: 0x2::balance::Supply<T1>,
        fee_rate: 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::float::Float,
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
        let v0 = if (arg1 >= (0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::constants::max_following_fee() as u64)) {
            (0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::constants::max_following_fee() as u64)
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
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::float::floor(0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::float::mul_div(0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::float::from(arg1), 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::float::from(0x2::balance::supply_value<T1>(&arg0.supply)), 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::float::from(calculate_total_value<T0, T1>(arg0))))
    }

    fun calculate_total_value<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        inner_value<T0, T1>(arg0) + fetch_scallop_value<T0, T1>(arg0) + fetch_suilend_value<T0, T1>(arg0) + fetch_navi_value<T0, T1>(arg0) + fetch_typus_value<T0, T1>(arg0) + fetch_bucket_value<T0, T1>(arg0) + fetch_aftermath_value<T0, T1>(arg0) + fetch_stem_value<T0, T1>(arg0)
    }

    public fun create_aftermath_add_liquidity_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::aftermath_adapter::AftermathProtocolAddLiquidityRequest {
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::aftermath_adapter::new_add_liquidity_request()
    }

    public fun create_aftermath_claim_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::aftermath_adapter::AftermathProtocolClaimRequest {
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::aftermath_adapter::new_claim_request()
    }

    public fun create_aftermath_remove_liquidity_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::aftermath_adapter::AftermathProtocolRemoveLiquidityRequest {
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::aftermath_adapter::new_remove_liquidity_request()
    }

    public fun create_aftermath_swap_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::aftermath_adapter::AftermathProtocolSwapRequest {
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::aftermath_adapter::new_swap_request()
    }

    public fun create_bucket_borrow_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::bucket_adapter::BucketProtocolBorrowRequest {
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::bucket_adapter::new_borrow_request()
    }

    public fun create_bucket_claim_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::bucket_adapter::BucketProtocolClaimRequest {
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::bucket_adapter::new_claim_request()
    }

    public fun create_bucket_deposit_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::bucket_adapter::BucketProtocolDepositRequest {
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::bucket_adapter::new_deposit_request()
    }

    public fun create_bucket_repay_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::bucket_adapter::BucketProtocolRepayRequest {
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::bucket_adapter::new_repay_request()
    }

    public fun create_bucket_withdraw_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::bucket_adapter::BucketProtocolWithdrawRequest {
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::bucket_adapter::new_withdraw_request()
    }

    public fun create_navi_borrow_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::navi_adapter::NaviProtocolBorrowRequest {
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::navi_adapter::new_borrow_request()
    }

    public fun create_navi_claim_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::navi_adapter::NaviProtocolClaimRequest {
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::navi_adapter::new_claim_request()
    }

    public fun create_navi_repay_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::navi_adapter::NaviProtocolRepayRequest {
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::navi_adapter::new_repay_request()
    }

    public fun create_navi_supply_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::navi_adapter::NaviProtocolSupplyRequest {
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::navi_adapter::new_supply_request()
    }

    public fun create_navi_withdraw_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::navi_adapter::NaviProtocolWithdrawRequest {
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::navi_adapter::new_withdraw_request()
    }

    public fun create_scallop_borrow_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::scallop_adapter::ScallopProtocolBorrowRequest {
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::scallop_adapter::new_borrow_request()
    }

    public fun create_scallop_claim_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::scallop_adapter::ScallopProtocolClaimRequest {
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::scallop_adapter::new_claim_request()
    }

    public fun create_scallop_repay_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::scallop_adapter::ScallopProtocolRepayRequest {
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::scallop_adapter::new_repay_request()
    }

    public fun create_scallop_supply_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::scallop_adapter::ScallopProtocolSupplyRequest {
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::scallop_adapter::new_supply_request()
    }

    public fun create_scallop_withdraw_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::scallop_adapter::ScallopProtocolWithdrawRequest {
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::scallop_adapter::new_withdraw_request()
    }

    public fun create_stem_add_liquidity_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::stem_adapter::StemProtocolAddLiquidityRequest {
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::stem_adapter::new_add_liquidity_request()
    }

    public fun create_stem_claim_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::stem_adapter::StemProtocolClaimRequest {
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::stem_adapter::new_claim_request()
    }

    public fun create_stem_remove_liquidity_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::stem_adapter::StemProtocolRemoveLiquidityRequest {
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::stem_adapter::new_remove_liquidity_request()
    }

    public fun create_stem_swap_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::stem_adapter::StemProtocolSwapRequest {
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::stem_adapter::new_swap_request()
    }

    public fun create_suilend_borrow_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::suilend_adapter::SuilendProtocolBorrowRequest {
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::suilend_adapter::new_borrow_request()
    }

    public fun create_suilend_claim_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::suilend_adapter::SuilendProtocolClaimRequest {
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::suilend_adapter::new_claim_request()
    }

    public fun create_suilend_repay_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::suilend_adapter::SuilendProtocolRepayRequest {
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::suilend_adapter::new_repay_request()
    }

    public fun create_suilend_supply_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::suilend_adapter::SuilendProtocolSupplyRequest {
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::suilend_adapter::new_supply_request()
    }

    public fun create_suilend_withdraw_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::suilend_adapter::SuilendProtocolWithdrawRequest {
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::suilend_adapter::new_withdraw_request()
    }

    public fun create_typus_buy_long_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::typus_adapter::TypusFinanceBuyLongRequest {
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::typus_adapter::new_buy_long_request()
    }

    public fun create_typus_buy_short_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::typus_adapter::TypusFinanceBuyShortRequest {
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::typus_adapter::new_buy_short_request()
    }

    public fun create_typus_sell_long_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::typus_adapter::TypusFinanceSellLongRequest {
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::typus_adapter::new_sell_long_request()
    }

    public fun create_typus_sell_short_request<T0, T1>(arg0: &VaultCap<T0, T1>) : 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::typus_adapter::TypusFinanceSellShortRequest {
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::typus_adapter::new_sell_short_request()
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

    fun err_protocol_not_supported() {
        abort 10003
    }

    fun err_remaining_unused_asset() {
        abort 10008
    }

    fun err_vault_id_not_matched() {
        abort 10009
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
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::float::floor(arg0.fee_rate)
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
        if (v0 == 0x1::type_name::get<0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::aftermath_adapter::AftermathProtocolSwapRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::aftermath_adapter::AftermathProtocolAddLiquidityRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::aftermath_adapter::AftermathProtocolRemoveLiquidityRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::aftermath_adapter::AftermathProtocolClaimRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::aftermath_adapter::AftermathProtocolSwapReceipt>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::aftermath_adapter::AftermathProtocolAddLiquidityReceipt>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::aftermath_adapter::AftermathProtocolRemoveLiquidityReceipt>()) {
            true
        } else {
            v0 == 0x1::type_name::get<0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::aftermath_adapter::AftermathProtocolClaimReceipt>()
        }
    }

    fun is_bucket<T0: drop + store>() : bool {
        let v0 = 0x1::type_name::get<T0>();
        if (v0 == 0x1::type_name::get<0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::bucket_adapter::BucketProtocolBorrowRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::bucket_adapter::BucketProtocolRepayRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::bucket_adapter::BucketProtocolWithdrawRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::bucket_adapter::BucketProtocolClaimRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::bucket_adapter::BucketProtocolDepositRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::bucket_adapter::BucketProtocolBorrowReceipt>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::bucket_adapter::BucketProtocolRepayReceipt>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::bucket_adapter::BucketProtocolWithdrawReceipt>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::bucket_adapter::BucketProtocolClaimReceipt>()) {
            true
        } else {
            v0 == 0x1::type_name::get<0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::bucket_adapter::BucketProtocolDepositReceipt>()
        }
    }

    fun is_navi<T0: drop + store>() : bool {
        let v0 = 0x1::type_name::get<T0>();
        if (v0 == 0x1::type_name::get<0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::navi_adapter::NaviProtocolBorrowRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::navi_adapter::NaviProtocolSupplyRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::navi_adapter::NaviProtocolRepayRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::navi_adapter::NaviProtocolClaimRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::navi_adapter::NaviProtocolWithdrawRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::navi_adapter::NaviProtocolBorrowReceipt>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::navi_adapter::NaviProtocolSupplyReceipt>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::navi_adapter::NaviProtocolRepayReceipt>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::navi_adapter::NaviProtocolClaimReceipt>()) {
            true
        } else {
            v0 == 0x1::type_name::get<0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::navi_adapter::NaviProtocolWithdrawReceipt>()
        }
    }

    fun is_scallop<T0: drop + store>() : bool {
        let v0 = 0x1::type_name::get<T0>();
        if (v0 == 0x1::type_name::get<0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::scallop_adapter::ScallopProtocolBorrowRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::scallop_adapter::ScallopProtocolSupplyRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::scallop_adapter::ScallopProtocolRepayRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::scallop_adapter::ScallopProtocolWithdrawRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::scallop_adapter::ScallopProtocolClaimRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::scallop_adapter::ScallopProtocolBorrowReceipt>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::scallop_adapter::ScallopProtocolSupplyReceipt>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::scallop_adapter::ScallopProtocolRepayReceipt>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::scallop_adapter::ScallopProtocolWithdrawReceipt>()) {
            true
        } else {
            v0 == 0x1::type_name::get<0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::scallop_adapter::ScallopProtocolClaimReceipt>()
        }
    }

    fun is_stem<T0: drop + store>() : bool {
        let v0 = 0x1::type_name::get<T0>();
        if (v0 == 0x1::type_name::get<0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::stem_adapter::StemProtocolSwapRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::stem_adapter::StemProtocolAddLiquidityRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::stem_adapter::StemProtocolRemoveLiquidityRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::stem_adapter::StemProtocolClaimRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::stem_adapter::StemProtocolSwapReceipt>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::stem_adapter::StemProtocolAddLiquidityReceipt>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::stem_adapter::StemProtocolRemoveLiquidityReceipt>()) {
            true
        } else {
            v0 == 0x1::type_name::get<0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::stem_adapter::StemProtocolClaimReceipt>()
        }
    }

    fun is_suilend<T0: drop + store>() : bool {
        let v0 = 0x1::type_name::get<T0>();
        if (v0 == 0x1::type_name::get<0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::suilend_adapter::SuilendProtocolBorrowRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::suilend_adapter::SuilendProtocolSupplyRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::suilend_adapter::SuilendProtocolRepayRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::suilend_adapter::SuilendProtocolWithdrawRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::suilend_adapter::SuilendProtocolClaimRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::suilend_adapter::SuilendProtocolBorrowReceipt>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::suilend_adapter::SuilendProtocolSupplyReceipt>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::suilend_adapter::SuilendProtocolRepayReceipt>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::suilend_adapter::SuilendProtocolWithdrawReceipt>()) {
            true
        } else {
            v0 == 0x1::type_name::get<0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::suilend_adapter::SuilendProtocolClaimReceipt>()
        }
    }

    fun is_typus<T0: drop + store>() : bool {
        let v0 = 0x1::type_name::get<T0>();
        if (v0 == 0x1::type_name::get<0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::typus_adapter::TypusFinanceBuyLongRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::typus_adapter::TypusFinanceBuyShortRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::typus_adapter::TypusFinanceSellLongRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::typus_adapter::TypusFinanceSellShortRequest>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::typus_adapter::TypusFinanceBuyLongReceipt>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::typus_adapter::TypusFinanceBuyShortReceipt>()) {
            true
        } else if (v0 == 0x1::type_name::get<0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::typus_adapter::TypusFinanceSellLongReceipt>()) {
            true
        } else {
            v0 == 0x1::type_name::get<0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::typus_adapter::TypusFinanceSellShortReceipt>()
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
            fee_rate : 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::float::from_bps(arg1),
        };
        let v2 = VaultCap<T0, T1>{
            id       : 0x2::object::new(arg2),
            vault_id : 0x2::object::id<Vault<T0, T1>>(&v1),
        };
        (v1, v2)
    }

    public fun new_vault_for_partner<T0, T1, T2: drop>(arg0: 0x2::coin::TreasuryCap<T1>, arg1: u64, arg2: address, arg3: T2, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg1 >= (0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::constants::max_following_fee() as u64)) {
            (0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::constants::partner_max_following_fee() as u64)
        } else {
            arg1
        };
        let (v1, v2) = new_<T0, T1>(arg0, v0, arg4);
        0x2::transfer::share_object<Vault<T0, T1>>(v1);
        0x2::transfer::public_transfer<VaultCap<T0, T1>>(v2, arg2);
    }

    public fun put_borrowed_asset_from_bucket<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::Collector, arg2: 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::bucket_adapter::BucketProtocolBorrowReceipt) {
        if (0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::bucket_adapter::borrow_receipt_vault_id(&arg2) != 0x2::object::id<Vault<T0, T1>>(arg0)) {
            err_vault_id_not_matched();
        };
        let v0 = 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::extract_asset_map_mut<0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::bucket_adapter::BucketProtocolBorrowReceipt>(arg1, &arg2);
        let v1 = 0x1::type_name::get<0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>>();
        let (_, v3) = 0x2::vec_map::remove<0x1::type_name::TypeName, 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::Item>(v0, &v1);
        let v4 = 0x2::vec_map::keys<0x1::type_name::TypeName, 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::Item>(v0);
        if (0x1::vector::length<0x1::type_name::TypeName>(&v4) > 0) {
            err_remaining_unused_asset();
        };
        let v5 = 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::extract_inner_asset<0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>>(v3);
        if (0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::bucket_adapter::borrow_receipt_amount(&arg2) != 0x2::balance::value<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&v5)) {
            err_amount_not_matched();
        };
        if (0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::bucket_adapter::borrow_receipt_asset_type(&arg2) != 0x1::type_name::get<0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>>()) {
            err_asset_type_not_matched();
        };
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::bucket_adapter::drop_borrow_receipt(arg2);
        add_f_asset<T0, T1, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(arg0, v5);
    }

    public fun put_claim_asset_from_bucket<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::Collector, arg2: 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::bucket_adapter::BucketProtocolClaimReceipt) {
        if (0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::bucket_adapter::claim_receipt_vault_id(&arg2) != 0x2::object::id<Vault<T0, T1>>(arg0)) {
            err_vault_id_not_matched();
        };
        let v0 = 0x1::type_name::get<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>();
        let v1 = 0x1::type_name::get<0x2::balance::Balance<0x2::sui::SUI>>();
        let v2 = 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::extract_asset_map_mut<0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::bucket_adapter::BucketProtocolClaimReceipt>(arg1, &arg2);
        let (_, v4) = 0x2::vec_map::remove<0x1::type_name::TypeName, 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::Item>(v2, &v0);
        let (_, v6) = 0x2::vec_map::remove<0x1::type_name::TypeName, 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::Item>(v2, &v1);
        let v7 = 0x2::vec_map::keys<0x1::type_name::TypeName, 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::Item>(v2);
        if (0x1::vector::length<0x1::type_name::TypeName>(&v7) > 0) {
            err_remaining_unused_asset();
        };
        let v8 = 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::extract_inner_asset<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(v4);
        let v9 = 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::extract_inner_asset<0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>>(v6);
        let v10 = 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::bucket_adapter::claim_receipt_amounts(&arg2);
        let v11 = 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::bucket_adapter::claim_receipt_amounts(&arg2);
        let v12 = 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::bucket_adapter::claim_receipt_asset_types(&arg2);
        let v13 = 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::bucket_adapter::claim_receipt_asset_types(&arg2);
        if (0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v13) != v0 || 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v12) != v1) {
            err_asset_type_not_matched();
        };
        if (0x1::vector::pop_back<u64>(&mut v11) != 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::get_proof_stake_amount<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>(&v8) || 0x1::vector::pop_back<u64>(&mut v10) != 0x2::balance::value<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&v9)) {
            err_amount_not_matched();
        };
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::bucket_adapter::drop_claim_receipt(arg2);
        0x2::bag::add<0x1::type_name::TypeName, 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(&mut arg0.assets.nf_asset, v0, v8);
        add_f_asset<T0, T1, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(arg0, v9);
    }

    public fun put_deposited_asset_from_bucket<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::Collector, arg2: 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::bucket_adapter::BucketProtocolDepositReceipt) {
        if (0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::bucket_adapter::deposit_receipt_vault_id(&arg2) != 0x2::object::id<Vault<T0, T1>>(arg0)) {
            err_vault_id_not_matched();
        };
        let v0 = 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::extract_asset_map_mut<0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::bucket_adapter::BucketProtocolDepositReceipt>(arg1, &arg2);
        let v1 = 0x1::type_name::get<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>();
        let (_, v3) = 0x2::vec_map::remove<0x1::type_name::TypeName, 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::Item>(v0, &v1);
        let v4 = 0x2::vec_map::keys<0x1::type_name::TypeName, 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::Item>(v0);
        if (0x1::vector::length<0x1::type_name::TypeName>(&v4) > 0) {
            err_remaining_unused_asset();
        };
        let v5 = 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::extract_inner_asset<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(v3);
        if (0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::bucket_adapter::deposit_receipt_amount(&arg2) != 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::get_proof_stake_amount<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>(&v5)) {
            err_amount_not_matched();
        };
        if (0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::bucket_adapter::deposit_receipt_asset_type(&arg2) != 0x1::type_name::get<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>()) {
            err_asset_type_not_matched();
        };
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::bucket_adapter::drop_deposit_receipt(arg2);
        0x2::bag::add<0x1::type_name::TypeName, 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(&mut arg0.assets.nf_asset, 0x1::type_name::get<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(), v5);
    }

    public fun put_repaid_asset_from_bucket<T0, T1, T2>(arg0: &mut Vault<T0, T1>, arg1: &mut 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::Collector, arg2: 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::bucket_adapter::BucketProtocolRepayReceipt) {
        if (0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::bucket_adapter::repay_receipt_vault_id(&arg2) != 0x2::object::id<Vault<T0, T1>>(arg0)) {
            err_vault_id_not_matched();
        };
        let v0 = 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::extract_asset_map_mut<0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::bucket_adapter::BucketProtocolRepayReceipt>(arg1, &arg2);
        let v1 = 0x1::type_name::get<0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>>();
        let (_, v3) = 0x2::vec_map::remove<0x1::type_name::TypeName, 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::Item>(v0, &v1);
        let v4 = 0x2::vec_map::keys<0x1::type_name::TypeName, 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::Item>(v0);
        if (0x1::vector::length<0x1::type_name::TypeName>(&v4) > 0) {
            err_remaining_unused_asset();
        };
        let v5 = 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::extract_inner_asset<0x2::balance::Balance<T2>>(v3);
        if (0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::bucket_adapter::repay_receipt_amount(&arg2) != 0x2::balance::value<T2>(&v5)) {
            err_amount_not_matched();
        };
        if (0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::bucket_adapter::repay_receipt_asset_type(&arg2) != 0x1::type_name::get<0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>>()) {
            err_asset_type_not_matched();
        };
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::bucket_adapter::drop_repay_receipt(arg2);
        add_f_asset<T0, T1, T2>(arg0, v5);
    }

    public fun put_withdraw_asset_from_bucket<T0, T1, T2, T3>(arg0: &mut Vault<T0, T1>, arg1: &mut 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::Collector, arg2: 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::bucket_adapter::BucketProtocolWithdrawReceipt) {
        if (0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::bucket_adapter::withdraw_receipt_vault_id(&arg2) != 0x2::object::id<Vault<T0, T1>>(arg0)) {
            err_vault_id_not_matched();
        };
        let v0 = 0x1::type_name::get<0x2::balance::Balance<T2>>();
        let v1 = 0x1::type_name::get<0x2::balance::Balance<T3>>();
        let v2 = 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::extract_asset_map_mut<0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::bucket_adapter::BucketProtocolWithdrawReceipt>(arg1, &arg2);
        let (_, v4) = 0x2::vec_map::remove<0x1::type_name::TypeName, 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::Item>(v2, &v0);
        let (_, v6) = 0x2::vec_map::remove<0x1::type_name::TypeName, 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::Item>(v2, &v1);
        let v7 = 0x2::vec_map::keys<0x1::type_name::TypeName, 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::Item>(v2);
        if (0x1::vector::length<0x1::type_name::TypeName>(&v7) > 0) {
            err_remaining_unused_asset();
        };
        let v8 = 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::extract_inner_asset<0x2::balance::Balance<T2>>(v4);
        let v9 = 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::extract_inner_asset<0x2::balance::Balance<T3>>(v6);
        let v10 = 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::bucket_adapter::withdraw_receipt_amounts(&arg2);
        let v11 = 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::bucket_adapter::withdraw_receipt_amounts(&arg2);
        let v12 = 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::bucket_adapter::withdraw_receipt_asset_types(&arg2);
        let v13 = 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v12);
        let v14 = 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::bucket_adapter::withdraw_receipt_asset_types(&arg2);
        let v15 = 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v14);
        if (v15 != v0 && v15 != v1 || v13 != v0 && v13 != v1) {
            err_asset_type_not_matched();
        };
        let (v16, v17) = if (v15 == v0) {
            (0x1::vector::pop_back<u64>(&mut v10), 0x1::vector::pop_back<u64>(&mut v11))
        } else {
            (0x1::vector::pop_back<u64>(&mut v11), 0x1::vector::pop_back<u64>(&mut v10))
        };
        if (v17 != 0x2::balance::value<T2>(&v8) || v16 != 0x2::balance::value<T3>(&v9)) {
            err_amount_not_matched();
        };
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::bucket_adapter::drop_withdraw_receipt(arg2);
        add_f_asset<T0, T1, T2>(arg0, v8);
        add_f_asset<T0, T1, T3>(arg0, v9);
    }

    public fun remove_version<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64) {
        if (0x2::vec_set::contains<u64>(&arg0.versions, &arg1)) {
            0x2::vec_set::remove<u64>(&mut arg0.versions, &arg1);
        } else {
            err_version_not_existed();
        };
    }

    public fun take_f_asset<T0, T1, T2, T3: drop + store>(arg0: &mut Vault<T0, T1>, arg1: 0x1::option::Option<0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::Collector>, arg2: &VaultCap<T0, T1>, arg3: &T3, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::Collector, TakeAssetRequest<0x2::balance::Balance<T2>>) {
        let v0 = 0x1::type_name::get<0x2::balance::Balance<T2>>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.assets.f_asset, v0)) {
            err_asset_not_in_vault();
        };
        if (0x2::balance::value<T2>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&arg0.assets.f_asset, v0)) < arg4) {
            err_asset_not_enough();
        };
        add_partner_record<T0, T1, T3>(arg0);
        let v1 = if (0x1::option::is_some<0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::Collector>(&arg1)) {
            let v2 = 0x1::option::destroy_some<0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::Collector>(arg1);
            0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::collect_asset<0x2::balance::Balance<T2>, T3>(&mut v2, arg3, 0x2::balance::split<T2>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.assets.f_asset, v0), arg4), arg5);
            v2
        } else {
            0x1::option::destroy_none<0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::Collector>(arg1);
            let v3 = 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::new(0x2::object::id<Vault<T0, T1>>(arg0));
            0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::collect_asset<0x2::balance::Balance<T2>, T3>(&mut v3, arg3, 0x2::balance::split<T2>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.assets.f_asset, v0), arg4), arg5);
            v3
        };
        let v4 = TakeAssetRequest<0x2::balance::Balance<T2>>{dummy_field: false};
        (v1, v4)
    }

    public fun take_nf_asset<T0, T1, T2: store, T3: drop + store>(arg0: &mut Vault<T0, T1>, arg1: 0x1::option::Option<0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::Collector>, arg2: &VaultCap<T0, T1>, arg3: &T3, arg4: &mut 0x2::tx_context::TxContext) : (0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::Collector, TakeAssetRequest<T2>) {
        let v0 = 0x1::type_name::get<T2>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.assets.f_asset, v0)) {
            err_asset_not_in_vault();
        };
        add_partner_record<T0, T1, T3>(arg0);
        let v1 = if (0x1::option::is_some<0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::Collector>(&arg1)) {
            let v2 = 0x1::option::destroy_some<0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::Collector>(arg1);
            0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::collect_asset<T2, T3>(&mut v2, arg3, 0x2::bag::remove<0x1::type_name::TypeName, T2>(&mut arg0.assets.nf_asset, v0), arg4);
            v2
        } else {
            0x1::option::destroy_none<0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::Collector>(arg1);
            let v3 = 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::new(0x2::object::id<Vault<T0, T1>>(arg0));
            0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::collect_asset<T2, T3>(&mut v3, arg3, 0x2::bag::remove<0x1::type_name::TypeName, T2>(&mut arg0.assets.nf_asset, v0), arg4);
            v3
        };
        let v4 = TakeAssetRequest<T2>{dummy_field: false};
        (v1, v4)
    }

    // decompiled from Move bytecode v6
}

