module 0x37930ead1f410aeea4bb934efdd48a1d6249f9814eda4a61dba04e04b8dc4799::mandate {
    struct Mandate has copy, drop, store {
        agent: address,
        actions: u64,
        max_fee_per_challenge: u64,
        max_fee_per_epoch: u64,
        opponent_band: u64,
        expires_at_ms: u64,
    }

    struct SpendMeter has copy, drop, store {
        epoch: u64,
        spent: u64,
    }

    public fun action_challenge() : u64 {
        1
    }

    public fun actions(arg0: &Mandate) : u64 {
        arg0.actions
    }

    public fun agent(arg0: &Mandate) : address {
        arg0.agent
    }

    public fun allows(arg0: &Mandate, arg1: u64) : bool {
        arg0.actions & arg1 == arg1
    }

    public(friend) fun charge(arg0: &mut SpendMeter, arg1: &Mandate, arg2: u64, arg3: u64) {
        if (arg2 > arg0.epoch) {
            arg0.epoch = arg2;
            arg0.spent = 0;
        };
        assert!(arg3 <= arg1.max_fee_per_challenge, 13906834762754555915);
        assert!(arg0.spent <= arg1.max_fee_per_epoch && arg3 <= arg1.max_fee_per_epoch - arg0.spent, 13906834775639588877);
        arg0.spent = arg0.spent + arg3;
    }

    public fun expires_at_ms(arg0: &Mandate) : u64 {
        arg0.expires_at_ms
    }

    public fun is_expired(arg0: &Mandate, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) >= arg0.expires_at_ms
    }

    public fun max_fee_per_challenge(arg0: &Mandate) : u64 {
        arg0.max_fee_per_challenge
    }

    public fun max_fee_per_epoch(arg0: &Mandate) : u64 {
        arg0.max_fee_per_epoch
    }

    public fun max_mandate_ms() : u64 {
        15552000000
    }

    public fun meter_epoch(arg0: &SpendMeter) : u64 {
        arg0.epoch
    }

    public fun meter_spent(arg0: &SpendMeter) : u64 {
        arg0.spent
    }

    public fun new(arg0: address, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock) : Mandate {
        assert!(arg0 != @0x0, 13906834505055993859);
        assert!(arg1 != 0 && arg1 | 1 == 1, 13906834509351092229);
        assert!(arg2 > 0 && arg2 <= arg3, 13906834522236125191);
        let v0 = 0x2::clock::timestamp_ms(arg6);
        assert!(arg5 > v0 && arg5 - v0 <= 15552000000, 13906834535121158153);
        Mandate{
            agent                 : arg0,
            actions               : arg1,
            max_fee_per_challenge : arg2,
            max_fee_per_epoch     : arg3,
            opponent_band         : arg4,
            expires_at_ms         : arg5,
        }
    }

    public(friend) fun new_meter() : SpendMeter {
        SpendMeter{
            epoch : 0,
            spent : 0,
        }
    }

    public fun opponent_band(arg0: &Mandate) : u64 {
        arg0.opponent_band
    }

    public(friend) fun reset(arg0: &mut SpendMeter) {
        arg0.epoch = 0;
        arg0.spent = 0;
    }

    public(friend) fun set_agent(arg0: &mut Mandate, arg1: address) {
        assert!(arg1 != @0x0, 13906834835768475651);
        arg0.agent = arg1;
    }

    // decompiled from Move bytecode v7
}

