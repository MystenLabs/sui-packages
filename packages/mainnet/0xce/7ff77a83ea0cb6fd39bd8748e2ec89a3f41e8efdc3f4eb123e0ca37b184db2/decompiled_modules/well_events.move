module 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::well_events {
    struct CollectFee has copy, drop {
        well_type: 0x1::ascii::String,
        fee_amount: u64,
    }

    struct Stake has copy, drop {
        well_type: 0x1::ascii::String,
        stake_amount: u64,
        stake_weight: u64,
        lock_time: u64,
    }

    struct Unstake has copy, drop {
        well_type: 0x1::ascii::String,
        unstake_amount: u64,
        unstake_weigth: u64,
        reward_amount: u64,
    }

    struct Claim has copy, drop {
        well_type: 0x1::ascii::String,
        reward_amount: u64,
    }

    struct Penalty has copy, drop {
        well_type: 0x1::ascii::String,
        penalty_amount: u64,
    }

    public(friend) fun emit_claim<T0>(arg0: u64) {
        let v0 = Claim{
            well_type     : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            reward_amount : arg0,
        };
        0x2::event::emit<Claim>(v0);
    }

    public(friend) fun emit_collect_fee<T0>(arg0: u64) {
        let v0 = CollectFee{
            well_type  : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            fee_amount : arg0,
        };
        0x2::event::emit<CollectFee>(v0);
    }

    public(friend) fun emit_penalty<T0>(arg0: u64) {
        let v0 = Penalty{
            well_type      : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            penalty_amount : arg0,
        };
        0x2::event::emit<Penalty>(v0);
    }

    public(friend) fun emit_stake<T0>(arg0: u64, arg1: u64, arg2: u64) {
        let v0 = Stake{
            well_type    : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            stake_amount : arg0,
            stake_weight : arg1,
            lock_time    : arg2,
        };
        0x2::event::emit<Stake>(v0);
    }

    public(friend) fun emit_unstake<T0>(arg0: u64, arg1: u64, arg2: u64) {
        let v0 = Unstake{
            well_type      : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            unstake_amount : arg0,
            unstake_weigth : arg1,
            reward_amount  : arg2,
        };
        0x2::event::emit<Unstake>(v0);
    }

    // decompiled from Move bytecode v6
}

