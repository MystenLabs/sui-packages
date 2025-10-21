module 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::vote_power {
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

    public fun vote_power_for_epoch_id(arg0: &VotePowerConfig, arg1: &0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::epoch::EpochConfig, arg2: u64, arg3: u64, arg4: u64) : u128 {
        let v0 = 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::epoch::epoch_id(arg1, arg4);
        if (v0 <= arg3) {
            return 0
        };
        let v1 = v0 - arg3;
        assert!(v1 <= arg0.max_bond_epochs, 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::error::e_invalid_bond_range());
        0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::math_u128::mul_div_floor((arg2 as u128), (v1 as u128), (arg0.max_bond_epochs as u128))
    }

    public fun vote_power_for_epoch_id_ceil(arg0: &VotePowerConfig, arg1: &0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::epoch::EpochConfig, arg2: u64, arg3: u64, arg4: u64) : u128 {
        let v0 = 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::epoch::epoch_id(arg1, arg4);
        if (v0 <= arg3) {
            return 0
        };
        let v1 = v0 - arg3;
        assert!(v1 <= arg0.max_bond_epochs, 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::error::e_invalid_bond_range());
        0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::math_u128::mul_div_ceil((arg2 as u128), (v1 as u128), (arg0.max_bond_epochs as u128))
    }

    public fun vote_power_for_range(arg0: &VotePowerConfig, arg1: &0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::epoch::EpochConfig, arg2: u64, arg3: u64, arg4: u64) : u128 {
        vote_power_for_epoch_id(arg0, arg1, arg2, 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::epoch::epoch_id(arg1, arg3), arg4)
    }

    public fun vote_power_for_range_ceil(arg0: &VotePowerConfig, arg1: &0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::epoch::EpochConfig, arg2: u64, arg3: u64, arg4: u64) : u128 {
        vote_power_for_epoch_id_ceil(arg0, arg1, arg2, 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::epoch::epoch_id(arg1, arg3), arg4)
    }

    // decompiled from Move bytecode v6
}

