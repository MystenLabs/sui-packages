module 0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::global_config {
    struct GlobalConfig has store, key {
        id: 0x2::object::UID,
        fee_amount_tick_spacing: 0x2::table::Table<u64, u32>,
    }

    public fun contains_fee_rate(arg0: &GlobalConfig, arg1: u64) : bool {
        0x2::table::contains<u64, u32>(&arg0.fee_amount_tick_spacing, arg1)
    }

    public fun enable_fee_rate(arg0: &0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::app::AdminCap, arg1: &mut GlobalConfig, arg2: u64, arg3: u32, arg4: &0x2::tx_context::TxContext) {
        assert!(arg2 < 1000000, 0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::error::invalid_fee_rate());
        assert!(arg3 > 0 && arg3 < 4194304, 0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::error::invalid_tick_spacing());
        assert!(!contains_fee_rate(arg1, arg2), 0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::error::fee_rate_already_configured());
        enable_fee_rate_internal(arg1, arg2, arg3, arg4);
    }

    fun enable_fee_rate_internal(arg0: &mut GlobalConfig, arg1: u64, arg2: u32, arg3: &0x2::tx_context::TxContext) {
        0x2::table::add<u64, u32>(&mut arg0.fee_amount_tick_spacing, arg1, arg2);
    }

    public fun get_tick_spacing(arg0: &GlobalConfig, arg1: u64) : u32 {
        assert!(contains_fee_rate(arg0, arg1), 0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::error::invalid_create_pool_configs());
        *0x2::table::borrow<u64, u32>(&arg0.fee_amount_tick_spacing, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GlobalConfig{
            id                      : 0x2::object::new(arg0),
            fee_amount_tick_spacing : 0x2::table::new<u64, u32>(arg0),
        };
        let v1 = &mut v0;
        enable_fee_rate_internal(v1, 100, 2, arg0);
        let v2 = &mut v0;
        enable_fee_rate_internal(v2, 500, 10, arg0);
        let v3 = &mut v0;
        enable_fee_rate_internal(v3, 3000, 60, arg0);
        let v4 = &mut v0;
        enable_fee_rate_internal(v4, 10000, 200, arg0);
        0x2::transfer::share_object<GlobalConfig>(v0);
    }

    // decompiled from Move bytecode v6
}

