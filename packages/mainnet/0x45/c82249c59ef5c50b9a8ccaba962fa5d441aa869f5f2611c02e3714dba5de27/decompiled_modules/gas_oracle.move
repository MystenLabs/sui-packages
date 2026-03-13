module 0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::gas_oracle {
    struct GasOracle has key {
        id: 0x2::object::UID,
        base_fee_mist: u64,
        last_updated_ms: u64,
        ema_weight_bps: u64,
        governance: address,
    }

    struct GasOracleCreated has copy, drop {
        oracle_id: 0x2::object::ID,
        initial_base_fee: u64,
    }

    struct BaseFeeUpdated has copy, drop {
        oracle_id: 0x2::object::ID,
        old_fee: u64,
        new_fee: u64,
        sample: u64,
    }

    struct EmaWeightUpdated has copy, drop {
        oracle_id: 0x2::object::ID,
        old_weight: u64,
        new_weight: u64,
    }

    public fun base_fee_mist(arg0: &GasOracle) : u64 {
        arg0.base_fee_mist
    }

    public fun effective_keeper_fee(arg0: &GasOracle, arg1: u64, arg2: u64) : u64 {
        let v0 = (((arg0.base_fee_mist as u128) * (arg2 as u128) / 10000) as u64);
        if (arg1 > v0) {
            arg1
        } else {
            v0
        }
    }

    public fun ema_weight_bps(arg0: &GasOracle) : u64 {
        arg0.ema_weight_bps
    }

    public fun governance(arg0: &GasOracle) : address {
        arg0.governance
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg0);
        let v1 = GasOracle{
            id              : v0,
            base_fee_mist   : 5000000,
            last_updated_ms : 0,
            ema_weight_bps  : 2000,
            governance      : 0x2::tx_context::sender(arg0),
        };
        let v2 = GasOracleCreated{
            oracle_id        : 0x2::object::uid_to_inner(&v0),
            initial_base_fee : 5000000,
        };
        0x2::event::emit<GasOracleCreated>(v2);
        0x2::transfer::share_object<GasOracle>(v1);
    }

    public fun last_updated_ms(arg0: &GasOracle) : u64 {
        arg0.last_updated_ms
    }

    public fun update_base_fee(arg0: &mut GasOracle, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 >= arg0.last_updated_ms + 60000, 301);
        assert!(arg1 > 0, 302);
        assert!(arg1 <= 100000000, 302);
        let v1 = arg0.base_fee_mist;
        let v2 = arg0.ema_weight_bps;
        let v3 = (((v1 as u128) * ((10000 - v2) as u128) / 10000 + (arg1 as u128) * (v2 as u128) / 10000) as u64);
        arg0.base_fee_mist = v3;
        arg0.last_updated_ms = v0;
        let v4 = BaseFeeUpdated{
            oracle_id : 0x2::object::uid_to_inner(&arg0.id),
            old_fee   : v1,
            new_fee   : v3,
            sample    : arg1,
        };
        0x2::event::emit<BaseFeeUpdated>(v4);
    }

    public fun update_ema_weight(arg0: &mut GasOracle, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.governance, 300);
        assert!(arg1 > 0 && arg1 <= 10000, 303);
        arg0.ema_weight_bps = arg1;
        let v0 = EmaWeightUpdated{
            oracle_id  : 0x2::object::uid_to_inner(&arg0.id),
            old_weight : arg0.ema_weight_bps,
            new_weight : arg1,
        };
        0x2::event::emit<EmaWeightUpdated>(v0);
    }

    public fun update_governance(arg0: &mut GasOracle, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.governance, 300);
        assert!(arg1 != @0x0, 300);
        arg0.governance = arg1;
    }

    // decompiled from Move bytecode v6
}

