module 0x389b58171d057852dd4b071d47474a2a97a6e4489cc2094a527a57d57d58063f::staking_policy {
    struct StakingPolicy has drop, store {
        validators: vector<address>,
        per_stake: u64,
        daily: u64,
        meter: 0x389b58171d057852dd4b071d47474a2a97a6e4489cc2094a527a57d57d58063f::meter::Meter,
    }

    struct Staked has copy, drop {
        controller: 0x2::object::ID,
        validator: address,
        amount: u64,
    }

    public fun new(arg0: vector<address>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) : StakingPolicy {
        assert!(arg1 > 0 && arg2 >= arg1, 3);
        StakingPolicy{
            validators : arg0,
            per_stake  : arg1,
            daily      : arg2,
            meter      : 0x389b58171d057852dd4b071d47474a2a97a6e4489cc2094a527a57d57d58063f::meter::new(arg3),
        }
    }

    public fun used_today(arg0: &StakingPolicy, arg1: &0x2::clock::Clock) : u64 {
        0x389b58171d057852dd4b071d47474a2a97a6e4489cc2094a527a57d57d58063f::meter::used_today(&arg0.meter, arg1)
    }

    public(friend) fun authorize(arg0: &mut StakingPolicy, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: &0x2::clock::Clock) {
        assert!(0x1::vector::is_empty<address>(&arg0.validators) || 0x1::vector::contains<address>(&arg0.validators, &arg2), 0);
        assert!(arg3 > 0, 2);
        assert!(arg3 <= arg0.per_stake, 1);
        0x389b58171d057852dd4b071d47474a2a97a6e4489cc2094a527a57d57d58063f::meter::charge(&mut arg0.meter, arg3, arg0.daily, arg4);
        let v0 = Staked{
            controller : arg1,
            validator  : arg2,
            amount     : arg3,
        };
        0x2::event::emit<Staked>(v0);
    }

    public fun daily(arg0: &StakingPolicy) : u64 {
        arg0.daily
    }

    public fun per_stake(arg0: &StakingPolicy) : u64 {
        arg0.per_stake
    }

    public fun validators(arg0: &StakingPolicy) : &vector<address> {
        &arg0.validators
    }

    // decompiled from Move bytecode v7
}

