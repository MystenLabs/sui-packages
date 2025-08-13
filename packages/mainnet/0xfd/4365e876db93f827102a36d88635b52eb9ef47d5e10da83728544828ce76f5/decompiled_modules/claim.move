module 0xfd4365e876db93f827102a36d88635b52eb9ef47d5e10da83728544828ce76f5::claim {
    public fun claim_fee_for_gauge<T0, T1>(arg0: &mut 0xfd4365e876db93f827102a36d88635b52eb9ef47d5e10da83728544828ce76f5::ve_mmt::VeMMT, arg1: &mut 0xfd4365e876db93f827102a36d88635b52eb9ef47d5e10da83728544828ce76f5::voting_escrow::VotingEscrow, arg2: address, arg3: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0xfd4365e876db93f827102a36d88635b52eb9ef47d5e10da83728544828ce76f5::ve_mmt::assert_supported_version(arg0);
        0xfd4365e876db93f827102a36d88635b52eb9ef47d5e10da83728544828ce76f5::gauge_globals::assert_not_paused(0xfd4365e876db93f827102a36d88635b52eb9ef47d5e10da83728544828ce76f5::ve_mmt::gauge_globals(arg0));
        let (_, v1, _) = 0xfd4365e876db93f827102a36d88635b52eb9ef47d5e10da83728544828ce76f5::voting_escrow::bond_info(arg1);
        let (v3, v4, v5, _) = 0xfd4365e876db93f827102a36d88635b52eb9ef47d5e10da83728544828ce76f5::ve_mmt::gauge_fields(arg0);
        let v7 = 0xfd4365e876db93f827102a36d88635b52eb9ef47d5e10da83728544828ce76f5::gauge_globals::get_gauge_not_paused(v5, &arg2);
        if (v1 == 0xfd4365e876db93f827102a36d88635b52eb9ef47d5e10da83728544828ce76f5::voting_escrow::bond_mode_max_bond()) {
            0xfd4365e876db93f827102a36d88635b52eb9ef47d5e10da83728544828ce76f5::voting_escrow::claim_fees_for_gauge_max_bond<T0, T1>(arg1, v7, v3, arg3)
        } else {
            assert!(v1 == 0xfd4365e876db93f827102a36d88635b52eb9ef47d5e10da83728544828ce76f5::voting_escrow::bond_mode_normal(), 0);
            0xfd4365e876db93f827102a36d88635b52eb9ef47d5e10da83728544828ce76f5::voting_escrow::claim_fees_for_gauge_normal<T0, T1>(arg1, v7, v3, v4, arg3)
        }
    }

    public fun claim_incentive_for_gauge<T0>(arg0: &mut 0xfd4365e876db93f827102a36d88635b52eb9ef47d5e10da83728544828ce76f5::ve_mmt::VeMMT, arg1: &mut 0xfd4365e876db93f827102a36d88635b52eb9ef47d5e10da83728544828ce76f5::voting_escrow::VotingEscrow, arg2: address, arg3: u64) : 0x2::balance::Balance<T0> {
        0xfd4365e876db93f827102a36d88635b52eb9ef47d5e10da83728544828ce76f5::ve_mmt::assert_supported_version(arg0);
        0xfd4365e876db93f827102a36d88635b52eb9ef47d5e10da83728544828ce76f5::gauge_globals::assert_not_paused(0xfd4365e876db93f827102a36d88635b52eb9ef47d5e10da83728544828ce76f5::ve_mmt::gauge_globals(arg0));
        let (_, v1, _) = 0xfd4365e876db93f827102a36d88635b52eb9ef47d5e10da83728544828ce76f5::voting_escrow::bond_info(arg1);
        let (v3, v4, v5, _) = 0xfd4365e876db93f827102a36d88635b52eb9ef47d5e10da83728544828ce76f5::ve_mmt::gauge_fields(arg0);
        let v7 = 0xfd4365e876db93f827102a36d88635b52eb9ef47d5e10da83728544828ce76f5::gauge_globals::get_gauge_not_paused(v5, &arg2);
        if (v1 == 0xfd4365e876db93f827102a36d88635b52eb9ef47d5e10da83728544828ce76f5::voting_escrow::bond_mode_max_bond()) {
            0xfd4365e876db93f827102a36d88635b52eb9ef47d5e10da83728544828ce76f5::voting_escrow::claim_incentive_for_gauge_max_bond<T0>(arg1, v7, v3, arg3)
        } else {
            assert!(v1 == 0xfd4365e876db93f827102a36d88635b52eb9ef47d5e10da83728544828ce76f5::voting_escrow::bond_mode_normal(), 0);
            0xfd4365e876db93f827102a36d88635b52eb9ef47d5e10da83728544828ce76f5::voting_escrow::claim_incentive_for_gauge_normal<T0>(arg1, v7, v3, v4, arg3)
        }
    }

    // decompiled from Move bytecode v6
}

