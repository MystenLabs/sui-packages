module 0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::staking_policy {
    struct StakingPolicy has drop, store {
        validators: vector<address>,
        per_stake: u64,
        daily: u64,
        meter: 0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::meter::Meter,
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
            meter      : 0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::meter::new(arg3),
        }
    }

    public fun used_today(arg0: &StakingPolicy, arg1: &0x2::clock::Clock) : u64 {
        0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::meter::used_today(&arg0.meter, arg1)
    }

    public fun add_validator(arg0: &mut StakingPolicy, arg1: address) {
        if (!0x1::vector::contains<address>(&arg0.validators, &arg1)) {
            0x1::vector::push_back<address>(&mut arg0.validators, arg1);
        };
    }

    public(friend) fun authorize(arg0: &mut StakingPolicy, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: &0x2::clock::Clock) {
        assert!(0x1::vector::is_empty<address>(&arg0.validators) || 0x1::vector::contains<address>(&arg0.validators, &arg2), 0);
        assert!(arg3 > 0, 2);
        assert!(arg3 <= arg0.per_stake, 1);
        0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::meter::charge(&mut arg0.meter, arg3, arg0.daily, arg4);
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

    public fun remove_validator(arg0: &mut StakingPolicy, arg1: address) {
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.validators, &arg1);
        assert!(v0, 0);
        0x1::vector::remove<address>(&mut arg0.validators, v1);
    }

    public fun set_limits(arg0: &mut StakingPolicy, arg1: u64, arg2: u64) {
        assert!(arg1 > 0 && arg2 >= arg1, 3);
        arg0.per_stake = arg1;
        arg0.daily = arg2;
    }

    public fun validators(arg0: &StakingPolicy) : &vector<address> {
        &arg0.validators
    }

    // decompiled from Move bytecode v7
}

