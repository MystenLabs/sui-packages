module 0x5ffa593f329dd0222a7bc2e87ebbc2b45a6bba3c49ce2586c718f518b89673e6::vote_power {
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

    public fun max_bond_ms(arg0: &VotePowerConfig, arg1: &0x5ffa593f329dd0222a7bc2e87ebbc2b45a6bba3c49ce2586c718f518b89673e6::epoch::EpochConfig) : u64 {
        0x5ffa593f329dd0222a7bc2e87ebbc2b45a6bba3c49ce2586c718f518b89673e6::epoch::epoch_interval_ms(arg1) * arg0.max_bond_epochs
    }

    public fun vote_power_for_epoch_id(arg0: &VotePowerConfig, arg1: &0x5ffa593f329dd0222a7bc2e87ebbc2b45a6bba3c49ce2586c718f518b89673e6::epoch::EpochConfig, arg2: u64, arg3: u64, arg4: u64) : u64 {
        let v0 = 0x5ffa593f329dd0222a7bc2e87ebbc2b45a6bba3c49ce2586c718f518b89673e6::epoch::epoch_id(arg1, arg4);
        if (v0 <= arg3) {
            return 0
        };
        let v1 = v0 - arg3;
        assert!(v1 <= arg0.max_bond_epochs, 0x5ffa593f329dd0222a7bc2e87ebbc2b45a6bba3c49ce2586c718f518b89673e6::error::e_invalid_bond_range());
        0x5ffa593f329dd0222a7bc2e87ebbc2b45a6bba3c49ce2586c718f518b89673e6::math_u64::mul_div_floor(arg2, v1, arg0.max_bond_epochs)
    }

    public fun vote_power_for_epoch_id_ceil(arg0: &VotePowerConfig, arg1: &0x5ffa593f329dd0222a7bc2e87ebbc2b45a6bba3c49ce2586c718f518b89673e6::epoch::EpochConfig, arg2: u64, arg3: u64, arg4: u64) : u64 {
        let v0 = 0x5ffa593f329dd0222a7bc2e87ebbc2b45a6bba3c49ce2586c718f518b89673e6::epoch::epoch_id(arg1, arg4);
        if (v0 <= arg3) {
            return 0
        };
        let v1 = v0 - arg3;
        assert!(v1 <= arg0.max_bond_epochs, 0x5ffa593f329dd0222a7bc2e87ebbc2b45a6bba3c49ce2586c718f518b89673e6::error::e_invalid_bond_range());
        0x5ffa593f329dd0222a7bc2e87ebbc2b45a6bba3c49ce2586c718f518b89673e6::math_u64::mul_div_ceil(arg2, v1, arg0.max_bond_epochs)
    }

    public fun vote_power_for_max_bond(arg0: u64) : u64 {
        arg0
    }

    public fun vote_power_for_range(arg0: &VotePowerConfig, arg1: &0x5ffa593f329dd0222a7bc2e87ebbc2b45a6bba3c49ce2586c718f518b89673e6::epoch::EpochConfig, arg2: u64, arg3: u64, arg4: u64) : u64 {
        vote_power_for_epoch_id(arg0, arg1, arg2, 0x5ffa593f329dd0222a7bc2e87ebbc2b45a6bba3c49ce2586c718f518b89673e6::epoch::epoch_id(arg1, arg3), arg4)
    }

    public fun vote_power_for_range_ceil(arg0: &VotePowerConfig, arg1: &0x5ffa593f329dd0222a7bc2e87ebbc2b45a6bba3c49ce2586c718f518b89673e6::epoch::EpochConfig, arg2: u64, arg3: u64, arg4: u64) : u64 {
        vote_power_for_epoch_id_ceil(arg0, arg1, arg2, 0x5ffa593f329dd0222a7bc2e87ebbc2b45a6bba3c49ce2586c718f518b89673e6::epoch::epoch_id(arg1, arg3), arg4)
    }

    // decompiled from Move bytecode v6
}

