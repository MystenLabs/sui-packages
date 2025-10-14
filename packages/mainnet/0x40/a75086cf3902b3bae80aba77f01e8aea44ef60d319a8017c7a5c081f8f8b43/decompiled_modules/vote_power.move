module 0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::vote_power {
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

    public fun vote_power_for_epoch_id(arg0: &VotePowerConfig, arg1: &0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::epoch::EpochConfig, arg2: u64, arg3: u64, arg4: u64) : u128 {
        let v0 = 0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::epoch::epoch_id(arg1, arg4);
        if (v0 <= arg3) {
            return 0
        };
        let v1 = v0 - arg3;
        assert!(v1 <= arg0.max_bond_epochs, 0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::error::e_invalid_bond_range());
        0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::math_u128::mul_div_floor((arg2 as u128), (v1 as u128), (arg0.max_bond_epochs as u128))
    }

    public fun vote_power_for_epoch_id_ceil(arg0: &VotePowerConfig, arg1: &0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::epoch::EpochConfig, arg2: u64, arg3: u64, arg4: u64) : u128 {
        let v0 = 0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::epoch::epoch_id(arg1, arg4);
        if (v0 <= arg3) {
            return 0
        };
        let v1 = v0 - arg3;
        assert!(v1 <= arg0.max_bond_epochs, 0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::error::e_invalid_bond_range());
        0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::math_u128::mul_div_ceil((arg2 as u128), (v1 as u128), (arg0.max_bond_epochs as u128))
    }

    public fun vote_power_for_range(arg0: &VotePowerConfig, arg1: &0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::epoch::EpochConfig, arg2: u64, arg3: u64, arg4: u64) : u128 {
        vote_power_for_epoch_id(arg0, arg1, arg2, 0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::epoch::epoch_id(arg1, arg3), arg4)
    }

    public fun vote_power_for_range_ceil(arg0: &VotePowerConfig, arg1: &0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::epoch::EpochConfig, arg2: u64, arg3: u64, arg4: u64) : u128 {
        vote_power_for_epoch_id_ceil(arg0, arg1, arg2, 0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::epoch::epoch_id(arg1, arg3), arg4)
    }

    // decompiled from Move bytecode v6
}

