module 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::day {
    struct ProtocolConfig has key {
        id: 0x2::object::UID,
        protocol_yield_skim_bps: u64,
        auto_yield_default_off: bool,
    }

    struct YieldHarvested has copy, drop {
        gross_yield_micros: u64,
        protocol_skim_micros: u64,
        net_yield_micros: u64,
        fee_bps: u64,
    }

    struct SurvivalUnstake has copy, drop {
        unstake_micros: u64,
        storage_bill_micros: u64,
        reason: vector<u8>,
    }

    struct TopUpRecorded has copy, drop {
        amount_micros: u64,
        fee_micros: u64,
    }

    public fun default_skim_bps() : u64 {
        500
    }

    public fun emit_survival_unstake(arg0: u64, arg1: u64) {
        let v0 = SurvivalUnstake{
            unstake_micros      : arg0,
            storage_bill_micros : arg1,
            reason              : b"survival_storage",
        };
        0x2::event::emit<SurvivalUnstake>(v0);
    }

    public fun get_skim_bps(arg0: &ProtocolConfig) : u64 {
        arg0.protocol_yield_skim_bps
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ProtocolConfig{
            id                      : 0x2::object::new(arg0),
            protocol_yield_skim_bps : 500,
            auto_yield_default_off  : true,
        };
        0x2::transfer::share_object<ProtocolConfig>(v0);
    }

    public fun is_auto_yield_default_off(arg0: &ProtocolConfig) : bool {
        arg0.auto_yield_default_off
    }

    public fun mul_bps(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 <= 10000, 2);
        (((arg0 as u128) * (arg1 as u128) / (10000 as u128)) as u64)
    }

    public fun record_harvest(arg0: &ProtocolConfig, arg1: u64, arg2: u64) {
        let (v0, v1) = skim_yield(arg1, arg0.protocol_yield_skim_bps);
        if (arg2 > 0 && v1 > 0) {
            assert!(arg2 <= v1, 1);
        };
        let v2 = YieldHarvested{
            gross_yield_micros   : arg1,
            protocol_skim_micros : v0,
            net_yield_micros     : v1,
            fee_bps              : arg0.protocol_yield_skim_bps,
        };
        0x2::event::emit<YieldHarvested>(v2);
    }

    public fun record_top_up(arg0: u64) {
        let v0 = TopUpRecorded{
            amount_micros : arg0,
            fee_micros    : 0,
        };
        0x2::event::emit<TopUpRecorded>(v0);
    }

    public fun skim_yield(arg0: u64, arg1: u64) : (u64, u64) {
        let v0 = mul_bps(arg0, arg1);
        (v0, arg0 - v0)
    }

    // decompiled from Move bytecode v7
}

