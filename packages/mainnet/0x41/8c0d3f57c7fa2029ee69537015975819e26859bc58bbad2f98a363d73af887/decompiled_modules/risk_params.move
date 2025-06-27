module 0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::risk_params {
    struct RiskParams has key {
        id: 0x2::object::UID,
        ltv: 0x2::table::Table<0x1::type_name::TypeName, 0x1::uq32_32::UQ32_32>,
        liquidation_threshold: 0x2::table::Table<0x1::type_name::TypeName, 0x1::uq32_32::UQ32_32>,
        common_unit: 0x1::type_name::TypeName,
        debt_snapshot_frequency_ms: u64,
        debt_repayment_period_ms: u64,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : RiskParams {
        RiskParams{
            id                         : 0x2::object::new(arg0),
            ltv                        : 0x2::table::new<0x1::type_name::TypeName, 0x1::uq32_32::UQ32_32>(arg0),
            liquidation_threshold      : 0x2::table::new<0x1::type_name::TypeName, 0x1::uq32_32::UQ32_32>(arg0),
            common_unit                : 0x1::type_name::get<0x2::sui::SUI>(),
            debt_snapshot_frequency_ms : 28800000,
            debt_repayment_period_ms   : 3600000,
        }
    }

    public(friend) fun share_object(arg0: RiskParams) {
        0x2::transfer::share_object<RiskParams>(arg0);
    }

    public fun common_unit(arg0: &RiskParams) : 0x1::type_name::TypeName {
        arg0.common_unit
    }

    public fun debt_repayment_period_ms(arg0: &RiskParams) : u64 {
        arg0.debt_repayment_period_ms
    }

    public fun debt_snapshot_frequency_ms(arg0: &RiskParams) : u64 {
        arg0.debt_snapshot_frequency_ms
    }

    fun internal_set_asset_param(arg0: &mut RiskParams, arg1: 0x1::type_name::TypeName, arg2: 0x1::uq32_32::UQ32_32, arg3: 0x1::uq32_32::UQ32_32) {
        assert!(0x1::uq32_32::le(arg2, arg3), 0);
        let v0 = 0x1::uq32_32::from_int(1);
        assert!(0x1::uq32_32::le(arg2, v0), 1);
        assert!(0x1::uq32_32::le(arg3, v0), 2);
        if (0x2::table::contains<0x1::type_name::TypeName, 0x1::uq32_32::UQ32_32>(&arg0.ltv, arg1)) {
            *0x2::table::borrow_mut<0x1::type_name::TypeName, 0x1::uq32_32::UQ32_32>(&mut arg0.ltv, arg1) = arg2;
            *0x2::table::borrow_mut<0x1::type_name::TypeName, 0x1::uq32_32::UQ32_32>(&mut arg0.liquidation_threshold, arg1) = arg3;
        } else {
            0x2::table::add<0x1::type_name::TypeName, 0x1::uq32_32::UQ32_32>(&mut arg0.ltv, arg1, arg2);
            0x2::table::add<0x1::type_name::TypeName, 0x1::uq32_32::UQ32_32>(&mut arg0.liquidation_threshold, arg1, arg3);
        };
    }

    public fun is_allowed_collateral<T0>(arg0: &RiskParams) : bool {
        0x2::table::contains<0x1::type_name::TypeName, 0x1::uq32_32::UQ32_32>(&arg0.ltv, 0x1::type_name::get<T0>())
    }

    public fun liquidation_table(arg0: &RiskParams) : &0x2::table::Table<0x1::type_name::TypeName, 0x1::uq32_32::UQ32_32> {
        &arg0.liquidation_threshold
    }

    public fun ltv_table(arg0: &RiskParams) : &0x2::table::Table<0x1::type_name::TypeName, 0x1::uq32_32::UQ32_32> {
        &arg0.ltv
    }

    public fun set_asset_param<T0>(arg0: &mut RiskParams, arg1: 0x1::uq32_32::UQ32_32, arg2: 0x1::uq32_32::UQ32_32, arg3: &0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::admin::AdminCap) {
        internal_set_asset_param(arg0, 0x1::type_name::get<T0>(), arg1, arg2);
    }

    public fun set_common_unit<T0>(arg0: &mut RiskParams, arg1: &0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::admin::AdminCap) {
        arg0.common_unit = 0x1::type_name::get<T0>();
    }

    public fun set_debt_repayment_period_ms(arg0: &mut RiskParams, arg1: u64, arg2: &0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::admin::AdminCap) {
        arg0.debt_repayment_period_ms = arg1;
    }

    public fun set_debt_snapshot_frequency_ms(arg0: &mut RiskParams, arg1: u64, arg2: &0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::admin::AdminCap) {
        arg0.debt_snapshot_frequency_ms = arg1;
    }

    // decompiled from Move bytecode v6
}

