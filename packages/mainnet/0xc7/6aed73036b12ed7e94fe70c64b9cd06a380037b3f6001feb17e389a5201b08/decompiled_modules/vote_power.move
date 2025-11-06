module 0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::vote_power {
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

    public fun max_bond_ms(arg0: &VotePowerConfig, arg1: &0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::epoch::EpochConfig) : u64 {
        0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::epoch::epoch_interval_ms(arg1) * arg0.max_bond_epochs
    }

    public fun vote_power_for_epoch_id(arg0: &VotePowerConfig, arg1: &0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::epoch::EpochConfig, arg2: u64, arg3: u64, arg4: u64) : u64 {
        let v0 = 0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::epoch::epoch_id(arg1, arg4);
        if (v0 <= arg3) {
            return 0
        };
        let v1 = v0 - arg3;
        assert!(v1 <= arg0.max_bond_epochs, 0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::error::e_invalid_bond_range());
        0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::math_u64::mul_div_floor(arg2, v1, arg0.max_bond_epochs)
    }

    public fun vote_power_for_epoch_id_ceil(arg0: &VotePowerConfig, arg1: &0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::epoch::EpochConfig, arg2: u64, arg3: u64, arg4: u64) : u64 {
        let v0 = 0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::epoch::epoch_id(arg1, arg4);
        if (v0 <= arg3) {
            return 0
        };
        let v1 = v0 - arg3;
        assert!(v1 <= arg0.max_bond_epochs, 0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::error::e_invalid_bond_range());
        0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::math_u64::mul_div_ceil(arg2, v1, arg0.max_bond_epochs)
    }

    public fun vote_power_for_max_bond(arg0: u64) : u64 {
        arg0
    }

    public fun vote_power_for_range(arg0: &VotePowerConfig, arg1: &0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::epoch::EpochConfig, arg2: u64, arg3: u64, arg4: u64) : u64 {
        vote_power_for_epoch_id(arg0, arg1, arg2, 0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::epoch::epoch_id(arg1, arg3), arg4)
    }

    public fun vote_power_for_range_ceil(arg0: &VotePowerConfig, arg1: &0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::epoch::EpochConfig, arg2: u64, arg3: u64, arg4: u64) : u64 {
        vote_power_for_epoch_id_ceil(arg0, arg1, arg2, 0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::epoch::epoch_id(arg1, arg3), arg4)
    }

    // decompiled from Move bytecode v6
}

