module 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry {
    struct MarketInfo<phantom T0> has store {
        base_storage_id: u32,
        base_source_id: u16,
        collateral_storage_id: u32,
        collateral_source_id: u16,
        scaling_factor: u256,
    }

    struct CollateralInfo<phantom T0> has store {
        collateral_storage_id: u32,
        collateral_source_id: u16,
        scaling_factor: u256,
    }

    struct IntegratorRegistration has store {
        integrator_address: address,
    }

    struct Config has store {
        stop_order_geunhwa_cost: u64,
        max_abs_maker_fee: u256,
        max_abs_taker_fee: u256,
        max_liquidation_fee: u256,
        max_insurance_fund_fee: u256,
        min_funding_frequency_ms: u64,
        min_funding_period_ms: u64,
        max_funding_period_ms: u64,
        min_premium_twap_frequency_ms: u64,
        min_premium_twap_period_ms: u64,
        min_spread_twap_frequency_ms: u64,
        min_spread_twap_period_ms: u64,
        min_proposal_delay_ms: u64,
        max_proposal_delay_ms: u64,
        low_min_order_usd_value: u256,
        up_min_order_usd_value: u256,
        insurance_open_interest_fraction: u256,
        min_oracle_tolerance: u64,
        max_book_index_spread: u256,
        max_index_twap_divergence: u256,
        up_max_pending_orders: u64,
        max_assistants_per_account: u64,
        extra_fields: 0x2::bag::Bag,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        version: u64,
        next_account_id: u64,
        next_integrator_id: u32,
    }

    struct ConfigUpdate has copy, drop {
        stop_order_geunhwa_cost: 0x1::option::Option<u64>,
        max_abs_maker_fee: 0x1::option::Option<u256>,
        max_abs_taker_fee: 0x1::option::Option<u256>,
        max_liquidation_fee: 0x1::option::Option<u256>,
        max_insurance_fund_fee: 0x1::option::Option<u256>,
        min_funding_frequency_ms: 0x1::option::Option<u64>,
        min_funding_period_ms: 0x1::option::Option<u64>,
        max_funding_period_ms: 0x1::option::Option<u64>,
        min_premium_twap_frequency_ms: 0x1::option::Option<u64>,
        min_premium_twap_period_ms: 0x1::option::Option<u64>,
        min_spread_twap_frequency_ms: 0x1::option::Option<u64>,
        min_spread_twap_period_ms: 0x1::option::Option<u64>,
        min_proposal_delay_ms: 0x1::option::Option<u64>,
        max_proposal_delay_ms: 0x1::option::Option<u64>,
        low_min_order_usd_value: 0x1::option::Option<u256>,
        up_min_order_usd_value: 0x1::option::Option<u256>,
        insurance_open_interest_fraction: 0x1::option::Option<u256>,
        min_oracle_tolerance: 0x1::option::Option<u64>,
        max_book_index_spread: 0x1::option::Option<u256>,
        max_index_twap_divergence: 0x1::option::Option<u256>,
        up_max_pending_orders: 0x1::option::Option<u64>,
        max_assistants_per_account: 0x1::option::Option<u64>,
    }

    public fun create_package_adl_cap(arg0: &mut Registry, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::PACKAGE, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>, arg2: &mut 0x2::tx_context::TxContext) : 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::PACKAGE, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::ADL> {
        assert_package_version(arg0);
        let v0 = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::create_package_adl_cap(&mut arg0.id, arg2);
        authorize_authority_cap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::PACKAGE, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::ADL>(arg0, &v0);
        v0
    }

    public fun create_package_assistant_cap(arg0: &mut Registry, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::PACKAGE, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>, arg2: &mut 0x2::tx_context::TxContext) : 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::PACKAGE, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ASSISTANT> {
        assert_package_version(arg0);
        let v0 = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::create_package_assistant_cap(&mut arg0.id, arg2);
        authorize_authority_cap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::PACKAGE, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ASSISTANT>(arg0, &v0);
        v0
    }

    public fun create_package_freeze_guardian_cap(arg0: &mut Registry, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::PACKAGE, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>, arg2: &mut 0x2::tx_context::TxContext) : 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::PACKAGE, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::FREEZE_GUARDIAN> {
        assert_package_version(arg0);
        let v0 = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::create_package_freeze_guardian_cap(&mut arg0.id, arg2);
        authorize_authority_cap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::PACKAGE, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::FREEZE_GUARDIAN>(arg0, &v0);
        v0
    }

    public fun create_package_pause_guardian_cap(arg0: &mut Registry, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::PACKAGE, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>, arg2: &mut 0x2::tx_context::TxContext) : 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::PACKAGE, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::PAUSE_GUARDIAN> {
        assert_package_version(arg0);
        let v0 = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::create_package_pause_guardian_cap(&mut arg0.id, arg2);
        authorize_authority_cap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::PACKAGE, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::PAUSE_GUARDIAN>(arg0, &v0);
        v0
    }

    public fun create_package_revoke_vendor_guardian_cap(arg0: &mut Registry, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::PACKAGE, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>, arg2: &mut 0x2::tx_context::TxContext) : 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::PACKAGE, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::REVOKE_VENDOR_GUARDIAN> {
        assert_package_version(arg0);
        let v0 = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::create_package_revoke_vendor_guardian_cap(&mut arg0.id, arg2);
        authorize_authority_cap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::PACKAGE, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::REVOKE_VENDOR_GUARDIAN>(arg0, &v0);
        v0
    }

    public fun create_vendor_assistant_cap<T0>(arg0: &mut Registry, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::VENDOR<T0>, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>, arg2: &mut 0x2::tx_context::TxContext) : 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::VENDOR<T0>, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ASSISTANT> {
        assert_package_version(arg0);
        assert_admin_authority_cap_is_active<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::VENDOR<T0>, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>(arg0, arg1);
        let v0 = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::create_vendor_assistant_cap<T0>(&mut arg0.id, arg2);
        authorize_authority_cap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::VENDOR<T0>, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ASSISTANT>(arg0, &v0);
        v0
    }

    public fun create_vendor_maintenance_cap<T0>(arg0: &mut Registry, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::VENDOR<T0>, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>, arg2: &mut 0x2::tx_context::TxContext) : 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::VENDOR<T0>, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::MAINTENANCE> {
        assert_package_version(arg0);
        assert_admin_authority_cap_is_active<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::VENDOR<T0>, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>(arg0, arg1);
        let v0 = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::create_vendor_maintenance_cap<T0>(&mut arg0.id, arg2);
        authorize_authority_cap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::VENDOR<T0>, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::MAINTENANCE>(arg0, &v0);
        v0
    }

    public fun create_vendor_pause_guardian_cap<T0>(arg0: &mut Registry, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::VENDOR<T0>, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>, arg2: &mut 0x2::tx_context::TxContext) : 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::VENDOR<T0>, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::PAUSE_GUARDIAN> {
        assert_package_version(arg0);
        assert_admin_authority_cap_is_active<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::VENDOR<T0>, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>(arg0, arg1);
        let v0 = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::create_vendor_pause_guardian_cap<T0>(&mut arg0.id, arg2);
        authorize_authority_cap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::VENDOR<T0>, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::PAUSE_GUARDIAN>(arg0, &v0);
        v0
    }

    public fun create_vendor_treasury_cap<T0>(arg0: &mut Registry, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::VENDOR<T0>, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>, arg2: &mut 0x2::tx_context::TxContext) : 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::VENDOR<T0>, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::TREASURY> {
        assert_package_version(arg0);
        assert_admin_authority_cap_is_active<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::VENDOR<T0>, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>(arg0, arg1);
        let v0 = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::create_vendor_treasury_cap<T0>(&mut arg0.id, arg2);
        authorize_authority_cap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::VENDOR<T0>, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::TREASURY>(arg0, &v0);
        v0
    }

    public fun apply_config_update<T0>(arg0: &mut Registry, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::PACKAGE, T0>, arg2: ConfigUpdate) {
        assert_package_version(arg0);
        assert_admin_or_authorized_assistant_authority_cap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::PACKAGE, T0>(arg0, arg1);
        let v0 = config(arg0);
        let v1 = option_u64_or(&arg2.stop_order_geunhwa_cost, v0.stop_order_geunhwa_cost);
        let v2 = option_u256_or(&arg2.max_abs_maker_fee, v0.max_abs_maker_fee);
        let v3 = option_u256_or(&arg2.max_abs_taker_fee, v0.max_abs_taker_fee);
        let v4 = option_u256_or(&arg2.max_liquidation_fee, v0.max_liquidation_fee);
        let v5 = option_u256_or(&arg2.max_insurance_fund_fee, v0.max_insurance_fund_fee);
        let v6 = option_u64_or(&arg2.min_funding_frequency_ms, v0.min_funding_frequency_ms);
        let v7 = option_u64_or(&arg2.min_funding_period_ms, v0.min_funding_period_ms);
        let v8 = option_u64_or(&arg2.max_funding_period_ms, v0.max_funding_period_ms);
        let v9 = option_u64_or(&arg2.min_premium_twap_frequency_ms, v0.min_premium_twap_frequency_ms);
        let v10 = option_u64_or(&arg2.min_premium_twap_period_ms, v0.min_premium_twap_period_ms);
        let v11 = option_u64_or(&arg2.min_spread_twap_frequency_ms, v0.min_spread_twap_frequency_ms);
        let v12 = option_u64_or(&arg2.min_spread_twap_period_ms, v0.min_spread_twap_period_ms);
        let v13 = option_u64_or(&arg2.min_proposal_delay_ms, v0.min_proposal_delay_ms);
        let v14 = option_u64_or(&arg2.max_proposal_delay_ms, v0.max_proposal_delay_ms);
        let v15 = option_u256_or(&arg2.low_min_order_usd_value, v0.low_min_order_usd_value);
        let v16 = option_u256_or(&arg2.up_min_order_usd_value, v0.up_min_order_usd_value);
        let v17 = option_u256_or(&arg2.insurance_open_interest_fraction, v0.insurance_open_interest_fraction);
        let v18 = option_u64_or(&arg2.min_oracle_tolerance, v0.min_oracle_tolerance);
        let v19 = option_u256_or(&arg2.max_book_index_spread, v0.max_book_index_spread);
        let v20 = option_u256_or(&arg2.max_index_twap_divergence, v0.max_index_twap_divergence);
        let v21 = option_u64_or(&arg2.up_max_pending_orders, v0.up_max_pending_orders);
        let v22 = option_u64_or(&arg2.max_assistants_per_account, v0.max_assistants_per_account);
        assert!(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::greater_than_eq(v2, 0) && 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::less_than_eq(v2, 1000000000000000000), 5019);
        assert!(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::greater_than_eq(v3, 0) && 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::less_than_eq(v3, 1000000000000000000), 5020);
        assert!(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::greater_than_eq(v4, 0) && 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::less_than_eq(v4, 1000000000000000000), 5021);
        assert!(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::greater_than_eq(v5, 0) && 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::less_than_eq(v5, 1000000000000000000), 5022);
        let v23 = if (v6 > 0) {
            if (v6 < v7) {
                v7 < v8
            } else {
                false
            }
        } else {
            false
        };
        assert!(v23, 5008);
        assert!(v9 > 0 && v10 >= v9, 5009);
        assert!(v11 > 0 && v12 >= v11, 5010);
        assert!(v13 > 0 && v13 <= v14, 5011);
        assert!(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::greater_than_eq(v15, 0) && 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::less_than_eq(v15, v16), 5012);
        assert!(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::greater_than_eq(v17, 0) && 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::less_than_eq(v17, 1000000000000000000), 5013);
        assert!(v18 > 0, 5014);
        assert!(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::greater_than_eq(v19, 0) && 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::less_than_eq(v19, 1000000000000000000), 5015);
        assert!(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::greater_than_eq(v20, 0) && 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::less_than_eq(v20, 1000000000000000000), 5016);
        assert!(v21 > 0, 5017);
        assert!(v22 > 0, 5018);
        let v24 = config_mut(arg0);
        v24.stop_order_geunhwa_cost = v1;
        v24.max_abs_maker_fee = v2;
        v24.max_abs_taker_fee = v3;
        v24.max_liquidation_fee = v4;
        v24.max_insurance_fund_fee = v5;
        v24.min_funding_frequency_ms = v6;
        v24.min_funding_period_ms = v7;
        v24.max_funding_period_ms = v8;
        v24.min_premium_twap_frequency_ms = v9;
        v24.min_premium_twap_period_ms = v10;
        v24.min_spread_twap_frequency_ms = v11;
        v24.min_spread_twap_period_ms = v12;
        v24.min_proposal_delay_ms = v13;
        v24.max_proposal_delay_ms = v14;
        v24.low_min_order_usd_value = v15;
        v24.up_min_order_usd_value = v16;
        v24.insurance_open_interest_fraction = v17;
        v24.min_oracle_tolerance = v18;
        v24.max_book_index_spread = v19;
        v24.max_index_twap_divergence = v20;
        v24.up_max_pending_orders = v21;
        v24.max_assistants_per_account = v22;
    }

    public(friend) fun assert_admin_authority_cap_is_active<T0, T1>(arg0: &Registry, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<T0, T1>) {
        if (0x1::type_name::with_defining_ids<T0>() != 0x1::type_name::with_defining_ids<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::PACKAGE>()) {
            assert_authority_cap_is_authorized<T0, T1>(arg0, arg1);
        };
    }

    public(friend) fun assert_admin_or_authorized_assistant_authority_cap<T0, T1>(arg0: &Registry, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<T0, T1>) {
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::assert_is_admin_or_assistant<T1>();
        if (0x1::type_name::with_defining_ids<T1>() == 0x1::type_name::with_defining_ids<0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ASSISTANT>()) {
            assert_authority_cap_is_authorized<T0, T1>(arg0, arg1);
        } else {
            assert_admin_authority_cap_is_active<T0, T1>(arg0, arg1);
        };
    }

    public(friend) fun assert_admin_or_authorized_assistant_or_maintenance_authority_cap<T0, T1>(arg0: &Registry, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<T0, T1>) {
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::assert_is_admin_or_assistant_or_maintenance<T1>();
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        if (v0 == 0x1::type_name::with_defining_ids<0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ASSISTANT>() || v0 == 0x1::type_name::with_defining_ids<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::MAINTENANCE>()) {
            assert_authority_cap_is_authorized<T0, T1>(arg0, arg1);
        } else {
            assert_admin_authority_cap_is_active<T0, T1>(arg0, arg1);
        };
    }

    fun assert_authority_cap_id_is_authorized<T0, T1>(arg0: &Registry, arg1: 0x2::object::ID) {
        assert!(is_authority_cap_authorized<T0, T1>(arg0, arg1), 5007);
    }

    public(friend) fun assert_authority_cap_is_authorized<T0, T1>(arg0: &Registry, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<T0, T1>) {
        assert_authority_cap_id_is_authorized<T0, T1>(arg0, 0x2::object::id<0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<T0, T1>>(arg1));
    }

    public fun assert_extension_authorized<T0>(arg0: &Registry) {
        assert!(is_extension_authorized<T0>(arg0), 5028);
    }

    public(friend) fun assert_integrator_id_is_valid(arg0: &Registry, arg1: u32) {
        assert!(is_integrator_id_registered(arg0, arg1), 5004);
    }

    public fun assert_package_version(arg0: &Registry) {
        assert!(arg0.version <= 1, 5000);
    }

    public(friend) fun assert_vendor_has_ownership_over_clearing_house<T0, T1>(arg0: &Registry, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::VENDOR<T0>, T1>, arg2: &0x2::object::ID) {
        let v0 = 0x2::dynamic_field::borrow<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::VendorClearingHouseKey<T0>, vector<0x2::object::ID>>(&arg0.id, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::vendor_clearing_house_key<T0>());
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<0x2::object::ID>(v0)) {
            if (0x1::vector::borrow<0x2::object::ID>(v0, v1) == arg2) {
                v2 = 0x1::option::some<u64>(v1);
                /* label 6 */
                assert!(0x1::option::is_some<u64>(&v2), 5006);
                return
            };
            v1 = v1 + 1;
        };
        v2 = 0x1::option::none<u64>();
        /* goto 6 */
    }

    public(friend) fun authorize_authority_cap<T0, T1>(arg0: &mut Registry, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<T0, T1>) {
        0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::authorize_cap<T0, T1>(&mut arg0.id, arg1);
    }

    public fun authorize_extension<T0>(arg0: &mut Registry, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::PACKAGE, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>) {
        assert_package_version(arg0);
        0x2::dynamic_field::add<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::AuthorizedExtensionKey<T0>, bool>(&mut arg0.id, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::authorized_extension<T0>(), true);
    }

    public(friend) fun borrow_mut_id(arg0: &mut Registry) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun collateral_info<T0>(arg0: &Registry) : (u32, u16, u256) {
        let v0 = 0x2::dynamic_field::borrow<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::RegistryCollateralInfoKey<T0>, CollateralInfo<T0>>(&arg0.id, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::registry_collateral_info<T0>());
        (v0.collateral_storage_id, v0.collateral_source_id, v0.scaling_factor)
    }

    public(friend) fun config(arg0: &Registry) : &Config {
        0x2::dynamic_field::borrow<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::RegistryConfigKey, Config>(&arg0.id, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::registry_config())
    }

    fun config_mut(arg0: &mut Registry) : &mut Config {
        0x2::dynamic_field::borrow_mut<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::RegistryConfigKey, Config>(&mut arg0.id, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::registry_config())
    }

    public(friend) fun create_registry<T0: drop>(arg0: &T0, arg1: &mut 0x2::tx_context::TxContext) : Registry {
        assert!(0x2::types::is_one_time_witness<T0>(arg0), 66);
        let v0 = Registry{
            id                 : 0x2::object::new(arg1),
            version            : 1,
            next_account_id    : 0,
            next_integrator_id : 0,
        };
        let v1 = Config{
            stop_order_geunhwa_cost          : 1000000,
            max_abs_maker_fee                : 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::from_u64fraction(500, 10000),
            max_abs_taker_fee                : 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::from_u64fraction(500, 10000),
            max_liquidation_fee              : 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::from_u64fraction(500, 10000),
            max_insurance_fund_fee           : 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::from_u64fraction(500, 10000),
            min_funding_frequency_ms         : 60000,
            min_funding_period_ms            : 21600000,
            max_funding_period_ms            : 864000000,
            min_premium_twap_frequency_ms    : 1000,
            min_premium_twap_period_ms       : 60000,
            min_spread_twap_frequency_ms     : 1000,
            min_spread_twap_period_ms        : 60000,
            min_proposal_delay_ms            : 86400000,
            max_proposal_delay_ms            : 259200000,
            low_min_order_usd_value          : 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::from_u64fraction(50, 100),
            up_min_order_usd_value           : 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::from_u64fraction(100000, 100),
            insurance_open_interest_fraction : 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::from_u64fraction(500, 10000),
            min_oracle_tolerance             : 500,
            max_book_index_spread            : 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::from_u64fraction(20, 100),
            max_index_twap_divergence        : 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::from_u64fraction(2000, 10000),
            up_max_pending_orders            : 100,
            max_assistants_per_account       : 10,
            extra_fields                     : 0x2::bag::new(arg1),
        };
        0x2::dynamic_field::add<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::RegistryConfigKey, Config>(&mut v0.id, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::registry_config(), v1);
        v0
    }

    public fun deauthorize_authority_cap<T0, T1>(arg0: &mut Registry, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<T0, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>, arg2: 0x2::object::ID) {
        assert_package_version(arg0);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::assert_is_not_admin<T1>();
        assert_admin_authority_cap_is_active<T0, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>(arg0, arg1);
        deauthorize_authority_cap_<T0, T1>(arg0, arg2);
    }

    public(friend) fun deauthorize_authority_cap_<T0, T1>(arg0: &mut Registry, arg1: 0x2::object::ID) {
        assert_authority_cap_id_is_authorized<T0, T1>(arg0, arg1);
        0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::deauthorize_cap<T0, T1>(&mut arg0.id, arg1);
    }

    public fun deauthorize_extension<T0>(arg0: &mut Registry, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::PACKAGE, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>) {
        assert_package_version(arg0);
        0x2::dynamic_field::remove<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::AuthorizedExtensionKey<T0>, bool>(&mut arg0.id, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::authorized_extension<T0>());
    }

    public fun freeze_package(arg0: &mut Registry, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::PACKAGE, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::FREEZE_GUARDIAN>) {
        assert_package_version(arg0);
        assert_authority_cap_is_authorized<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::PACKAGE, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::FREEZE_GUARDIAN>(arg0, arg1);
        let v0 = arg0.version;
        0x2::dynamic_field::add<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::FrozenVersionKey, u64>(&mut arg0.id, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::frozen_version(), v0);
        arg0.version = 18446744073709551615;
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::events::froze(0x2::object::uid_to_inner(&arg0.id), v0, 0x2::object::id<0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::PACKAGE, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::FREEZE_GUARDIAN>>(arg1));
    }

    public fun guardian_deauthorize_authority_cap<T0, T1>(arg0: &mut Registry, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::PACKAGE, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::REVOKE_VENDOR_GUARDIAN>, arg2: 0x2::object::ID) {
        assert_package_version(arg0);
        assert_authority_cap_is_authorized<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::PACKAGE, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::REVOKE_VENDOR_GUARDIAN>(arg0, arg1);
        deauthorize_authority_cap_<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::VENDOR<T0>, T1>(arg0, arg2);
    }

    public(friend) fun inc_account_id(arg0: &mut Registry) : u64 {
        let v0 = arg0.next_account_id;
        arg0.next_account_id = v0 + 1;
        v0
    }

    fun inc_integrator_id(arg0: &mut Registry) : u32 {
        let v0 = arg0.next_integrator_id;
        arg0.next_integrator_id = v0 + 1;
        v0
    }

    public fun insurance_open_interest_fraction(arg0: &Config) : u256 {
        arg0.insurance_open_interest_fraction
    }

    public fun integrator_address(arg0: &Registry, arg1: u32) : address {
        0x2::dynamic_field::borrow<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::IntegratorRegistrationKey, IntegratorRegistration>(&arg0.id, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::integrator_registration(arg1)).integrator_address
    }

    public fun is_account_assistant_cap_registered(arg0: &Registry, arg1: 0x2::object::ID) : bool {
        0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::is_cap_authorized<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::ACCOUNT, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ASSISTANT>(&arg0.id, arg1)
    }

    public fun is_authority_cap_authorized<T0, T1>(arg0: &Registry, arg1: 0x2::object::ID) : bool {
        0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::is_cap_authorized<T0, T1>(&arg0.id, arg1)
    }

    public fun is_collateral_registered<T0>(arg0: &Registry) : bool {
        0x2::dynamic_field::exists<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::RegistryCollateralInfoKey<T0>>(&arg0.id, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::registry_collateral_info<T0>())
    }

    public fun is_extension_authorized<T0>(arg0: &Registry) : bool {
        0x2::dynamic_field::exists<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::AuthorizedExtensionKey<T0>>(&arg0.id, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::authorized_extension<T0>())
    }

    public fun is_frozen(arg0: &Registry) : bool {
        0x2::dynamic_field::exists_with_type<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::FrozenVersionKey, u64>(&arg0.id, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::frozen_version())
    }

    public fun is_integrator_id_registered(arg0: &Registry, arg1: u32) : bool {
        arg1 < arg0.next_integrator_id
    }

    public fun is_market_registered(arg0: &Registry, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_field::exists<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::RegistryMarketInfoKey>(&arg0.id, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::registry_market_info(arg1))
    }

    public fun is_vendor_registration_open(arg0: &Registry) : bool {
        let v0 = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::vendor_registration_open();
        0x2::dynamic_field::exists_with_type<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::VendorRegistrationOpenKey, bool>(&arg0.id, v0) && *0x2::dynamic_field::borrow<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::VendorRegistrationOpenKey, bool>(&arg0.id, v0)
    }

    public fun low_min_order_usd_value(arg0: &Config) : u256 {
        arg0.low_min_order_usd_value
    }

    public fun market_info<T0>(arg0: &Registry, arg1: 0x2::object::ID) : (u32, u16, u32, u16, u256) {
        let v0 = 0x2::dynamic_field::borrow<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::RegistryMarketInfoKey, MarketInfo<T0>>(&arg0.id, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::registry_market_info(arg1));
        (v0.base_storage_id, v0.base_source_id, v0.collateral_storage_id, v0.collateral_source_id, v0.scaling_factor)
    }

    public fun max_abs_maker_fee(arg0: &Config) : u256 {
        arg0.max_abs_maker_fee
    }

    public fun max_abs_taker_fee(arg0: &Config) : u256 {
        arg0.max_abs_taker_fee
    }

    public fun max_assistants_per_account(arg0: &Config) : u64 {
        arg0.max_assistants_per_account
    }

    public fun max_book_index_spread(arg0: &Config) : u256 {
        arg0.max_book_index_spread
    }

    public fun max_funding_period_ms(arg0: &Config) : u64 {
        arg0.max_funding_period_ms
    }

    public fun max_index_twap_divergence(arg0: &Config) : u256 {
        arg0.max_index_twap_divergence
    }

    public fun max_insurance_fund_fee(arg0: &Config) : u256 {
        arg0.max_insurance_fund_fee
    }

    public fun max_liquidation_fee(arg0: &Config) : u256 {
        arg0.max_liquidation_fee
    }

    public fun max_proposal_delay_ms(arg0: &Config) : u64 {
        arg0.max_proposal_delay_ms
    }

    public fun min_funding_frequency_ms(arg0: &Config) : u64 {
        arg0.min_funding_frequency_ms
    }

    public fun min_funding_period_ms(arg0: &Config) : u64 {
        arg0.min_funding_period_ms
    }

    public fun min_oracle_tolerance(arg0: &Config) : u64 {
        arg0.min_oracle_tolerance
    }

    public fun min_premium_twap_frequency_ms(arg0: &Config) : u64 {
        arg0.min_premium_twap_frequency_ms
    }

    public fun min_premium_twap_period_ms(arg0: &Config) : u64 {
        arg0.min_premium_twap_period_ms
    }

    public fun min_proposal_delay_ms(arg0: &Config) : u64 {
        arg0.min_proposal_delay_ms
    }

    public fun min_spread_twap_frequency_ms(arg0: &Config) : u64 {
        arg0.min_spread_twap_frequency_ms
    }

    public fun min_spread_twap_period_ms(arg0: &Config) : u64 {
        arg0.min_spread_twap_period_ms
    }

    public fun new_config_update() : ConfigUpdate {
        ConfigUpdate{
            stop_order_geunhwa_cost          : 0x1::option::none<u64>(),
            max_abs_maker_fee                : 0x1::option::none<u256>(),
            max_abs_taker_fee                : 0x1::option::none<u256>(),
            max_liquidation_fee              : 0x1::option::none<u256>(),
            max_insurance_fund_fee           : 0x1::option::none<u256>(),
            min_funding_frequency_ms         : 0x1::option::none<u64>(),
            min_funding_period_ms            : 0x1::option::none<u64>(),
            max_funding_period_ms            : 0x1::option::none<u64>(),
            min_premium_twap_frequency_ms    : 0x1::option::none<u64>(),
            min_premium_twap_period_ms       : 0x1::option::none<u64>(),
            min_spread_twap_frequency_ms     : 0x1::option::none<u64>(),
            min_spread_twap_period_ms        : 0x1::option::none<u64>(),
            min_proposal_delay_ms            : 0x1::option::none<u64>(),
            max_proposal_delay_ms            : 0x1::option::none<u64>(),
            low_min_order_usd_value          : 0x1::option::none<u256>(),
            up_min_order_usd_value           : 0x1::option::none<u256>(),
            insurance_open_interest_fraction : 0x1::option::none<u256>(),
            min_oracle_tolerance             : 0x1::option::none<u64>(),
            max_book_index_spread            : 0x1::option::none<u256>(),
            max_index_twap_divergence        : 0x1::option::none<u256>(),
            up_max_pending_orders            : 0x1::option::none<u64>(),
            max_assistants_per_account       : 0x1::option::none<u64>(),
        }
    }

    fun option_u256_or(arg0: &0x1::option::Option<u256>, arg1: u256) : u256 {
        if (0x1::option::is_some<u256>(arg0)) {
            *0x1::option::borrow<u256>(arg0)
        } else {
            arg1
        }
    }

    fun option_u64_or(arg0: &0x1::option::Option<u64>, arg1: u64) : u64 {
        if (0x1::option::is_some<u64>(arg0)) {
            *0x1::option::borrow<u64>(arg0)
        } else {
            arg1
        }
    }

    public fun reauthorize_vendor_admin_cap<T0>(arg0: &mut Registry, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::PACKAGE, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>) {
        assert_package_version(arg0);
        assert!(0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::exists<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::VENDOR<T0>, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>(&arg0.id), 5025);
        let v0 = 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::derived_cap_id<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::VENDOR<T0>, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>(&arg0.id);
        assert!(!is_authority_cap_authorized<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::VENDOR<T0>, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>(arg0, v0), 5024);
        0x2::dynamic_field::add<0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorizedAuthorityCapKey<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::VENDOR<T0>, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>, bool>(&mut arg0.id, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::authorized_authority_cap_key<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::VENDOR<T0>, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>(v0), true);
    }

    public(friend) fun register_account_assistant_cap(arg0: &mut Registry, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::ACCOUNT, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ASSISTANT>) {
        0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::authorize_cap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::ACCOUNT, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ASSISTANT>(&mut arg0.id, arg1);
    }

    public fun register_integrator(arg0: &mut Registry, arg1: &mut 0x2::tx_context::TxContext) : u32 {
        assert_package_version(arg0);
        let v0 = inc_integrator_id(arg0);
        let v1 = IntegratorRegistration{integrator_address: 0x2::tx_context::sender(arg1)};
        0x2::dynamic_field::add<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::IntegratorRegistrationKey, IntegratorRegistration>(&mut arg0.id, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::integrator_registration(v0), v1);
        v0
    }

    public(friend) fun register_market<T0>(arg0: &mut Registry, arg1: u32, arg2: u16, arg3: u32, arg4: u16, arg5: u256, arg6: 0x2::object::ID) {
        assert_package_version(arg0);
        assert!(!is_market_registered(arg0, arg6), 5001);
        let v0 = MarketInfo<T0>{
            base_storage_id       : arg1,
            base_source_id        : arg2,
            collateral_storage_id : arg3,
            collateral_source_id  : arg4,
            scaling_factor        : arg5,
        };
        0x2::dynamic_field::add<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::RegistryMarketInfoKey, MarketInfo<T0>>(&mut arg0.id, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::registry_market_info(arg6), v0);
        if (!is_collateral_registered<T0>(arg0)) {
            let v1 = CollateralInfo<T0>{
                collateral_storage_id : arg3,
                collateral_source_id  : arg4,
                scaling_factor        : arg5,
            };
            0x2::dynamic_field::add<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::RegistryCollateralInfoKey<T0>, CollateralInfo<T0>>(&mut arg0.id, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::registry_collateral_info<T0>(), v1);
            0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::events::registered_collateral_info<T0>(arg3, arg4, arg5);
        };
    }

    public fun register_vendor<T0, T1>(arg0: &mut Registry, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xe2a2f69e6818cc578b7fe506ac965c4c9aebee1984bde24a1d29b2484eb38f9f::authority::VENDOR<T0>, T1>, arg2: &0xe2a2f69e6818cc578b7fe506ac965c4c9aebee1984bde24a1d29b2484eb38f9f::config::Config, arg3: &mut 0xe2a2f69e6818cc578b7fe506ac965c4c9aebee1984bde24a1d29b2484eb38f9f::metadata::VendorMetadata<T0>) : 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::VENDOR<T0>, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN> {
        assert_package_version(arg0);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::assert_is_admin_or_assistant<T1>();
        0xe2a2f69e6818cc578b7fe506ac965c4c9aebee1984bde24a1d29b2484eb38f9f::config::assert_has_active_vendor_authority<T0, T1>(arg2, arg1);
        assert!(is_vendor_registration_open(arg0) || 0xe2a2f69e6818cc578b7fe506ac965c4c9aebee1984bde24a1d29b2484eb38f9f::metadata::is_domain_registration_approved<T0, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::PACKAGE>(arg3), 5023);
        0x2::dynamic_field::add<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::VendorClearingHouseKey<T0>, vector<0x2::object::ID>>(&mut arg0.id, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::vendor_clearing_house_key<T0>(), 0x1::vector::empty<0x2::object::ID>());
        let v0 = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::create_vendor_admin_cap<T0>(&mut arg0.id);
        authorize_authority_cap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::VENDOR<T0>, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>(arg0, &v0);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::events::registered_vendor(0x1::type_name::with_defining_ids<T0>(), 0x2::object::id<0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::VENDOR<T0>, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>>(&v0));
        v0
    }

    public(friend) fun remove_registered_market<T0>(arg0: &mut Registry, arg1: 0x2::object::ID) {
        assert_package_version(arg0);
        assert!(is_market_registered(arg0, arg1), 5002);
        let MarketInfo {
            base_storage_id       : _,
            base_source_id        : _,
            collateral_storage_id : _,
            collateral_source_id  : _,
            scaling_factor        : _,
        } = 0x2::dynamic_field::remove<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::RegistryMarketInfoKey, MarketInfo<T0>>(&mut arg0.id, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::registry_market_info(arg1));
    }

    public fun set_account_limits(arg0: &mut ConfigUpdate, arg1: u64, arg2: u64, arg3: u64) {
        arg0.stop_order_geunhwa_cost = 0x1::option::some<u64>(arg1);
        arg0.up_max_pending_orders = 0x1::option::some<u64>(arg2);
        arg0.max_assistants_per_account = 0x1::option::some<u64>(arg3);
    }

    public(friend) fun set_base_oracle_params_<T0>(arg0: &mut Registry, arg1: 0x2::object::ID, arg2: u32, arg3: u16) {
        assert_package_version(arg0);
        let v0 = 0x2::dynamic_field::borrow_mut<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::RegistryMarketInfoKey, MarketInfo<T0>>(&mut arg0.id, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::registry_market_info(arg1));
        v0.base_storage_id = arg2;
        v0.base_source_id = arg3;
    }

    public fun set_collateral_info<T0, T1>(arg0: &mut Registry, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::PACKAGE, T1>, arg2: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::PriceFeedStorage, arg3: u16) {
        assert_package_version(arg0);
        assert_admin_or_authorized_assistant_authority_cap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::PACKAGE, T1>(arg0, arg1);
        let v0 = 0x2::dynamic_field::borrow_mut<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::RegistryCollateralInfoKey<T0>, CollateralInfo<T0>>(&mut arg0.id, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::registry_collateral_info<T0>());
        v0.collateral_storage_id = 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::storage_id(arg2);
        v0.collateral_source_id = arg3;
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::events::registered_collateral_info<T0>(v0.collateral_storage_id, v0.collateral_source_id, v0.scaling_factor);
    }

    public(friend) fun set_collateral_oracle_params_<T0>(arg0: &mut Registry, arg1: 0x2::object::ID, arg2: u32, arg3: u16) {
        assert_package_version(arg0);
        let v0 = 0x2::dynamic_field::borrow_mut<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::RegistryMarketInfoKey, MarketInfo<T0>>(&mut arg0.id, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::registry_market_info(arg1));
        v0.collateral_storage_id = arg2;
        v0.collateral_source_id = arg3;
    }

    public fun set_fee_caps(arg0: &mut ConfigUpdate, arg1: u256, arg2: u256, arg3: u256, arg4: u256) {
        arg0.max_abs_maker_fee = 0x1::option::some<u256>(arg1);
        arg0.max_abs_taker_fee = 0x1::option::some<u256>(arg2);
        arg0.max_liquidation_fee = 0x1::option::some<u256>(arg3);
        arg0.max_insurance_fund_fee = 0x1::option::some<u256>(arg4);
    }

    public fun set_integrator_address(arg0: &mut Registry, arg1: u32, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert_package_version(arg0);
        assert!(is_integrator_id_registered(arg0, arg1), 5003);
        assert!(0x2::dynamic_field::borrow<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::IntegratorRegistrationKey, IntegratorRegistration>(&arg0.id, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::integrator_registration(arg1)).integrator_address == 0x2::tx_context::sender(arg3), 5003);
        set_integrator_address_(arg0, arg1, arg2);
    }

    fun set_integrator_address_(arg0: &mut Registry, arg1: u32, arg2: address) {
        let v0 = 0x2::dynamic_field::borrow_mut<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::IntegratorRegistrationKey, IntegratorRegistration>(&mut arg0.id, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::integrator_registration(arg1));
        v0.integrator_address = arg2;
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::events::updated_integrator_address(arg1, v0.integrator_address, arg2);
    }

    public fun set_integrator_address_with_cap<T0>(arg0: &mut Registry, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::PACKAGE, T0>, arg2: u32, arg3: address) {
        assert_package_version(arg0);
        assert_admin_or_authorized_assistant_authority_cap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::PACKAGE, T0>(arg0, arg1);
        assert!(is_integrator_id_registered(arg0, arg2), 5003);
        set_integrator_address_(arg0, arg2, arg3);
    }

    public fun set_proposal_and_order_value_bounds(arg0: &mut ConfigUpdate, arg1: u64, arg2: u64, arg3: u256, arg4: u256) {
        arg0.min_proposal_delay_ms = 0x1::option::some<u64>(arg1);
        arg0.max_proposal_delay_ms = 0x1::option::some<u64>(arg2);
        arg0.low_min_order_usd_value = 0x1::option::some<u256>(arg3);
        arg0.up_min_order_usd_value = 0x1::option::some<u256>(arg4);
    }

    public fun set_risk_caps(arg0: &mut ConfigUpdate, arg1: u256, arg2: u64, arg3: u256, arg4: u256) {
        arg0.insurance_open_interest_fraction = 0x1::option::some<u256>(arg1);
        arg0.min_oracle_tolerance = 0x1::option::some<u64>(arg2);
        arg0.max_book_index_spread = 0x1::option::some<u256>(arg3);
        arg0.max_index_twap_divergence = 0x1::option::some<u256>(arg4);
    }

    public fun set_timing_bounds(arg0: &mut ConfigUpdate, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        arg0.min_funding_frequency_ms = 0x1::option::some<u64>(arg1);
        arg0.min_funding_period_ms = 0x1::option::some<u64>(arg2);
        arg0.max_funding_period_ms = 0x1::option::some<u64>(arg3);
        arg0.min_premium_twap_frequency_ms = 0x1::option::some<u64>(arg4);
        arg0.min_premium_twap_period_ms = 0x1::option::some<u64>(arg5);
        arg0.min_spread_twap_frequency_ms = 0x1::option::some<u64>(arg6);
        arg0.min_spread_twap_period_ms = 0x1::option::some<u64>(arg7);
    }

    entry fun set_vendor_registration(arg0: &mut Registry, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::PACKAGE, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>, arg2: bool) {
        assert_package_version(arg0);
        let v0 = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::vendor_registration_open();
        if (0x2::dynamic_field::exists<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::VendorRegistrationOpenKey>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow_mut<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::VendorRegistrationOpenKey, bool>(&mut arg0.id, v0) = arg2;
        } else {
            0x2::dynamic_field::add<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::VendorRegistrationOpenKey, bool>(&mut arg0.id, v0, arg2);
        };
    }

    public fun share(arg0: Registry) {
        0x2::transfer::share_object<Registry>(arg0);
    }

    public fun stop_order_geunhwa_cost(arg0: &Registry) : u64 {
        config(arg0).stop_order_geunhwa_cost
    }

    public fun unfreeze_package(arg0: &mut Registry, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::PACKAGE, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>) {
        assert!(is_frozen(arg0), 5026);
        let v0 = 0x2::dynamic_field::remove<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::FrozenVersionKey, u64>(&mut arg0.id, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::frozen_version());
        assert!(v0 <= 1, 5027);
        arg0.version = v0;
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::events::unfroze(0x2::object::uid_to_inner(&arg0.id), v0);
    }

    public(friend) fun unregister_account_assistant_cap_if_registered(arg0: &mut Registry, arg1: 0x2::object::ID) {
        if (!is_account_assistant_cap_registered(arg0, arg1)) {
            return
        };
        0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::deauthorize_cap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::ACCOUNT, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ASSISTANT>(&mut arg0.id, arg1);
    }

    public fun up_max_pending_orders(arg0: &Config) : u64 {
        arg0.up_max_pending_orders
    }

    public fun up_min_order_usd_value(arg0: &Config) : u256 {
        arg0.up_min_order_usd_value
    }

    entry fun upgrade_version<T0>(arg0: &mut Registry, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::PACKAGE, T0>) {
        assert_admin_or_authorized_assistant_authority_cap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::PACKAGE, T0>(arg0, arg1);
        assert!(arg0.version < 1, 5005);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::events::upgraded_version(0x2::object::uid_to_inner(&arg0.id), 1);
        arg0.version = 1;
    }

    public fun version(arg0: &Registry) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

