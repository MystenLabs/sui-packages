module 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::yield_router {
    struct YieldRouter has key {
        id: 0x2::object::UID,
        auto_yield_default_off: bool,
        protocol_yield_skim_bps: u64,
        paused: bool,
    }

    struct DepositPlanned has copy, drop {
        owner: address,
        adapter_id: vector<u8>,
        amount_micros: u64,
        fee_micros: u64,
    }

    struct WithdrawPlanned has copy, drop {
        owner: address,
        adapter_id: vector<u8>,
        amount_micros: u64,
        fee_micros: u64,
    }

    struct HarvestSkimmed has copy, drop {
        owner: address,
        adapter_id: vector<u8>,
        gross_yield_micros: u64,
        protocol_skim_micros: u64,
        net_yield_micros: u64,
        fee_bps: u64,
    }

    public fun auto_yield_default_off(arg0: &YieldRouter) : bool {
        arg0.auto_yield_default_off
    }

    public fun create(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = YieldRouter{
            id                      : 0x2::object::new(arg0),
            auto_yield_default_off  : true,
            protocol_yield_skim_bps : 500,
            paused                  : false,
        };
        0x2::transfer::share_object<YieldRouter>(v0);
    }

    public fun plan_deposit(arg0: &YieldRouter, arg1: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::AdapterRegistry, arg2: vector<u8>, arg3: u64, arg4: address, arg5: bool) {
        assert!(!arg0.paused, 1);
        assert!(arg3 > 0, 2);
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::assert_active(arg1, arg2);
        let v0 = DepositPlanned{
            owner         : arg4,
            adapter_id    : arg2,
            amount_micros : arg3,
            fee_micros    : 0,
        };
        0x2::event::emit<DepositPlanned>(v0);
    }

    public fun plan_harvest_skim(arg0: &YieldRouter, arg1: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::AdapterRegistry, arg2: vector<u8>, arg3: u64, arg4: address) {
        assert!(!arg0.paused, 1);
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::assert_active(arg1, arg2);
        let (v0, v1) = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::day::skim_yield(arg3, arg0.protocol_yield_skim_bps);
        let v2 = HarvestSkimmed{
            owner                : arg4,
            adapter_id           : arg2,
            gross_yield_micros   : arg3,
            protocol_skim_micros : v0,
            net_yield_micros     : v1,
            fee_bps              : arg0.protocol_yield_skim_bps,
        };
        0x2::event::emit<HarvestSkimmed>(v2);
    }

    public fun plan_withdraw(arg0: &YieldRouter, arg1: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::AdapterRegistry, arg2: vector<u8>, arg3: u64, arg4: address) {
        assert!(!arg0.paused, 1);
        assert!(arg3 > 0, 2);
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::assert_active(arg1, arg2);
        let v0 = WithdrawPlanned{
            owner         : arg4,
            adapter_id    : arg2,
            amount_micros : arg3,
            fee_micros    : 0,
        };
        0x2::event::emit<WithdrawPlanned>(v0);
    }

    public fun protocol_yield_skim_bps(arg0: &YieldRouter) : u64 {
        arg0.protocol_yield_skim_bps
    }

    // decompiled from Move bytecode v7
}

