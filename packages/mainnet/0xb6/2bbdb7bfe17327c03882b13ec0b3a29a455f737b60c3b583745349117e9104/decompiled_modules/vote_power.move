module 0xb62bbdb7bfe17327c03882b13ec0b3a29a455f737b60c3b583745349117e9104::vote_power {
    struct VotePowerConfig has store, key {
        id: 0x2::object::UID,
        max_bond_epochs: u64,
    }

    public(friend) fun create(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : VotePowerConfig {
        VotePowerConfig{
            id              : 0x2::object::new(arg1),
            max_bond_epochs : arg0,
        }
    }

    public fun max_bond_epochs(arg0: &VotePowerConfig) : u64 {
        arg0.max_bond_epochs
    }

    public fun max_bond_ms(arg0: &VotePowerConfig, arg1: &0xb62bbdb7bfe17327c03882b13ec0b3a29a455f737b60c3b583745349117e9104::epoch::EpochConfig) : u64 {
        0xb62bbdb7bfe17327c03882b13ec0b3a29a455f737b60c3b583745349117e9104::epoch::epoch_interval_ms(arg1) * arg0.max_bond_epochs
    }

    public fun vote_power_for_epoch_id(arg0: &VotePowerConfig, arg1: &0xb62bbdb7bfe17327c03882b13ec0b3a29a455f737b60c3b583745349117e9104::epoch::EpochConfig, arg2: u64, arg3: u64, arg4: u64) : u64 {
        let v0 = 0xb62bbdb7bfe17327c03882b13ec0b3a29a455f737b60c3b583745349117e9104::epoch::epoch_id(arg1, arg4);
        if (v0 <= arg3) {
            return 0
        };
        let v1 = v0 - arg3;
        assert!(v1 <= arg0.max_bond_epochs, 0xb62bbdb7bfe17327c03882b13ec0b3a29a455f737b60c3b583745349117e9104::error::e_invalid_bond_range());
        0xb62bbdb7bfe17327c03882b13ec0b3a29a455f737b60c3b583745349117e9104::math_u64::mul_div_floor(arg2, v1, arg0.max_bond_epochs)
    }

    public fun vote_power_for_epoch_id_ceil(arg0: &VotePowerConfig, arg1: &0xb62bbdb7bfe17327c03882b13ec0b3a29a455f737b60c3b583745349117e9104::epoch::EpochConfig, arg2: u64, arg3: u64, arg4: u64) : u64 {
        let v0 = 0xb62bbdb7bfe17327c03882b13ec0b3a29a455f737b60c3b583745349117e9104::epoch::epoch_id(arg1, arg4);
        if (v0 <= arg3) {
            return 0
        };
        let v1 = v0 - arg3;
        assert!(v1 <= arg0.max_bond_epochs, 0xb62bbdb7bfe17327c03882b13ec0b3a29a455f737b60c3b583745349117e9104::error::e_invalid_bond_range());
        0xb62bbdb7bfe17327c03882b13ec0b3a29a455f737b60c3b583745349117e9104::math_u64::mul_div_ceil(arg2, v1, arg0.max_bond_epochs)
    }

    public fun vote_power_for_max_bond(arg0: u64) : u64 {
        arg0
    }

    public fun vote_power_for_range(arg0: &VotePowerConfig, arg1: &0xb62bbdb7bfe17327c03882b13ec0b3a29a455f737b60c3b583745349117e9104::epoch::EpochConfig, arg2: u64, arg3: u64, arg4: u64) : u64 {
        vote_power_for_epoch_id(arg0, arg1, arg2, 0xb62bbdb7bfe17327c03882b13ec0b3a29a455f737b60c3b583745349117e9104::epoch::epoch_id(arg1, arg3), arg4)
    }

    public fun vote_power_for_range_ceil(arg0: &VotePowerConfig, arg1: &0xb62bbdb7bfe17327c03882b13ec0b3a29a455f737b60c3b583745349117e9104::epoch::EpochConfig, arg2: u64, arg3: u64, arg4: u64) : u64 {
        vote_power_for_epoch_id_ceil(arg0, arg1, arg2, 0xb62bbdb7bfe17327c03882b13ec0b3a29a455f737b60c3b583745349117e9104::epoch::epoch_id(arg1, arg3), arg4)
    }

    // decompiled from Move bytecode v6
}

