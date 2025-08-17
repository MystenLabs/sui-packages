module 0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::vote_power {
    struct VotePowerConfig has store, key {
        id: 0x2::object::UID,
        max_bond_epochs: u64,
        max_bond_bonus: u64,
    }

    public(friend) fun create(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : VotePowerConfig {
        assert!(arg1 <= 1000000000, 1);
        VotePowerConfig{
            id              : 0x2::object::new(arg2),
            max_bond_epochs : arg0,
            max_bond_bonus  : arg1,
        }
    }

    public fun effective_amount(arg0: u64, arg1: u64) : u64 {
        0x38747d8471b55cfdd72ba8331877392bdb5416e241d3103f1836409faa1301ba::full_math_u64::mul_div_floor(arg0, arg1, 1000000)
    }

    public fun effective_vote_power(arg0: u64, arg1: u64) : u64 {
        0x38747d8471b55cfdd72ba8331877392bdb5416e241d3103f1836409faa1301ba::full_math_u64::mul_div_floor(arg0, arg1, 1000000)
    }

    public fun max_bond_bonus(arg0: &VotePowerConfig) : u64 {
        arg0.max_bond_bonus
    }

    public fun max_bond_epochs(arg0: &VotePowerConfig) : u64 {
        arg0.max_bond_epochs
    }

    public fun max_bond_ms(arg0: &VotePowerConfig, arg1: &0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::epoch::EpochConfig) : u64 {
        0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::epoch::epoch_interval_ms(arg1) * arg0.max_bond_epochs
    }

    public fun vote_power_for_epoch_id(arg0: &VotePowerConfig, arg1: &0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::epoch::EpochConfig, arg2: u64, arg3: u64, arg4: u64) : u64 {
        let v0 = 0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::epoch::epoch_id(arg1, arg4);
        if (v0 <= arg3) {
            return 0
        };
        let v1 = v0 - arg3;
        assert!(v1 <= arg0.max_bond_epochs, 0);
        0x38747d8471b55cfdd72ba8331877392bdb5416e241d3103f1836409faa1301ba::full_math_u64::mul_div_floor(arg2, v1, arg0.max_bond_epochs)
    }

    public fun vote_power_for_max_bond(arg0: &VotePowerConfig, arg1: u64) : u64 {
        0x38747d8471b55cfdd72ba8331877392bdb5416e241d3103f1836409faa1301ba::full_math_u64::mul_div_floor(arg1, arg0.max_bond_bonus + 1000000, 1000000)
    }

    public fun vote_power_for_range(arg0: &VotePowerConfig, arg1: &0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::epoch::EpochConfig, arg2: u64, arg3: u64, arg4: u64) : u64 {
        vote_power_for_epoch_id(arg0, arg1, arg2, 0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::epoch::epoch_id(arg1, arg3), arg4)
    }

    public fun vote_weight_denom() : u64 {
        1000000
    }

    // decompiled from Move bytecode v6
}

