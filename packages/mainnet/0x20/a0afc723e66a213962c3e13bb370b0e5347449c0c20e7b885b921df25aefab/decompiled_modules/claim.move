module 0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::claim {
    public fun claim_fee_for_gauge<T0, T1>(arg0: &mut 0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::ve_mmt::VeMMT, arg1: &mut 0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::voting_escrow::VotingEscrow, arg2: address, arg3: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::ve_mmt::assert_supported_version(arg0);
        0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::gauge_globals::assert_not_paused(0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::ve_mmt::gauge_globals(arg0));
        let (_, v1, _) = 0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::voting_escrow::bond_info(arg1);
        let (v3, v4, v5, _) = 0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::ve_mmt::gauge_fields(arg0);
        let v7 = 0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::gauge_globals::get_gauge_not_paused(v5, &arg2);
        if (v1 == 0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::voting_escrow::bond_mode_max_bond()) {
            0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::voting_escrow::claim_fees_for_gauge_max_bond<T0, T1>(arg1, v7, v3, arg3)
        } else {
            assert!(v1 == 0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::voting_escrow::bond_mode_normal(), 0);
            0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::voting_escrow::claim_fees_for_gauge_normal<T0, T1>(arg1, v7, v3, v4, arg3)
        }
    }

    public fun claim_incentive_for_gauge<T0>(arg0: &mut 0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::ve_mmt::VeMMT, arg1: &mut 0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::voting_escrow::VotingEscrow, arg2: address, arg3: u64) : 0x2::balance::Balance<T0> {
        0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::ve_mmt::assert_supported_version(arg0);
        0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::gauge_globals::assert_not_paused(0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::ve_mmt::gauge_globals(arg0));
        let (_, v1, _) = 0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::voting_escrow::bond_info(arg1);
        let (v3, v4, v5, _) = 0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::ve_mmt::gauge_fields(arg0);
        let v7 = 0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::gauge_globals::get_gauge_not_paused(v5, &arg2);
        if (v1 == 0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::voting_escrow::bond_mode_max_bond()) {
            0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::voting_escrow::claim_incentive_for_gauge_max_bond<T0>(arg1, v7, v3, arg3)
        } else {
            assert!(v1 == 0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::voting_escrow::bond_mode_normal(), 0);
            0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::voting_escrow::claim_incentive_for_gauge_normal<T0>(arg1, v7, v3, v4, arg3)
        }
    }

    // decompiled from Move bytecode v6
}

