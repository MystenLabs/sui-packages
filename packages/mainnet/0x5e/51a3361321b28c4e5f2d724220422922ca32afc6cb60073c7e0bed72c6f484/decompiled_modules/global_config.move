module 0x5e51a3361321b28c4e5f2d724220422922ca32afc6cb60073c7e0bed72c6f484::global_config {
    struct EnableFeeRateEvent has copy, drop, store {
        sender: address,
        fee_rate: u64,
        tick_spacing: u32,
    }

    struct GlobalConfig has store, key {
        id: 0x2::object::UID,
        fee_amount_tick_spacing: 0x2::table::Table<u64, u32>,
    }

    public fun contains_fee_rate(arg0: &GlobalConfig, arg1: u64) : bool {
        0x2::table::contains<u64, u32>(&arg0.fee_amount_tick_spacing, arg1)
    }

    public fun enable_fee_rate(arg0: &0x5e51a3361321b28c4e5f2d724220422922ca32afc6cb60073c7e0bed72c6f484::app::AdminCap, arg1: &mut GlobalConfig, arg2: u64, arg3: u32, arg4: &0x2::tx_context::TxContext) {
        assert!(arg2 < 1000000, 0x5e51a3361321b28c4e5f2d724220422922ca32afc6cb60073c7e0bed72c6f484::error::invalid_fee_rate());
        assert!(arg3 > 0 && arg3 < 10000, 0x5e51a3361321b28c4e5f2d724220422922ca32afc6cb60073c7e0bed72c6f484::error::invalid_tick_spacing());
        assert!(!contains_fee_rate(arg1, arg2), 0x5e51a3361321b28c4e5f2d724220422922ca32afc6cb60073c7e0bed72c6f484::error::fee_rate_already_configured());
        enable_fee_rate_internal(arg1, arg2, arg3, arg4);
    }

    fun enable_fee_rate_internal(arg0: &mut GlobalConfig, arg1: u64, arg2: u32, arg3: &0x2::tx_context::TxContext) {
        0x2::table::add<u64, u32>(&mut arg0.fee_amount_tick_spacing, arg1, arg2);
        let v0 = EnableFeeRateEvent{
            sender       : 0x2::tx_context::sender(arg3),
            fee_rate     : arg1,
            tick_spacing : arg2,
        };
        0x2::event::emit<EnableFeeRateEvent>(v0);
    }

    public fun get_tick_spacing(arg0: &GlobalConfig, arg1: u64) : u32 {
        assert!(contains_fee_rate(arg0, arg1), 0x5e51a3361321b28c4e5f2d724220422922ca32afc6cb60073c7e0bed72c6f484::error::invalid_create_pool_configs());
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

