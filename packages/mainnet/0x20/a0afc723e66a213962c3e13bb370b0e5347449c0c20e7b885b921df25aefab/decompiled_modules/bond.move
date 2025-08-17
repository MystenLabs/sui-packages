module 0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::bond {
    public fun add_bond_balance(arg0: &mut 0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::ve_mmt::VeMMT, arg1: &mut 0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::voting_escrow::VotingEscrow, arg2: 0x2::balance::Balance<0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::mmt::MMT>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::ve_mmt::assert_supported_version(arg0);
        0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::gauge_globals::assert_not_paused(0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::ve_mmt::gauge_globals(arg0));
        let v0 = 0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::voting_escrow::user_votes(arg1);
        if (0x1::vector::length<0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::voting_escrow::UserVote>(&v0) == 0) {
            0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::voting_escrow::deposit(arg1, arg2);
            return
        };
        let (v1, v2, v3, _) = 0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::ve_mmt::gauge_fields(arg0);
        0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::assert::assert_vote_allowed_for_user(v3, v2, arg3, arg4);
        let v5 = 0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::epoch::epoch_id(v2, 0x2::clock::timestamp_ms(arg3));
        0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::assert::assert_ve_all_claimed(v3, arg1, v5);
        let v6 = 0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::vote::remove_votes(v3, v1, v2, arg1, v5);
        0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::voting_escrow::deposit(arg1, arg2);
        0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::vote::add_votes(v3, v1, v2, arg1, v5, &v6);
    }

    public fun create_bond(arg0: &0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::ve_mmt::VeMMT, arg1: 0x2::balance::Balance<0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::mmt::MMT>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::voting_escrow::VotingEscrow {
        0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::ve_mmt::assert_supported_version(arg0);
        0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::gauge_globals::assert_not_paused(0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::ve_mmt::gauge_globals(arg0));
        assert!(0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::epoch::is_epoch_start(0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::ve_mmt::ep_config(arg0), arg2), 0);
        assert!(arg2 > 0x2::clock::timestamp_ms(arg3), 0);
        0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::voting_escrow::create_normal(arg1, arg2, arg3, arg4)
    }

    public fun create_max_bond(arg0: &0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::ve_mmt::VeMMT, arg1: 0x2::balance::Balance<0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::mmt::MMT>, arg2: &mut 0x2::tx_context::TxContext) : 0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::voting_escrow::VotingEscrow {
        0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::ve_mmt::assert_supported_version(arg0);
        0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::gauge_globals::assert_not_paused(0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::ve_mmt::gauge_globals(arg0));
        0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::voting_escrow::create_max_bond(arg1, arg2)
    }

    public fun extend(arg0: &mut 0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::ve_mmt::VeMMT, arg1: &mut 0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::voting_escrow::VotingEscrow, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::ve_mmt::assert_supported_version(arg0);
        0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::gauge_globals::assert_not_paused(0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::ve_mmt::gauge_globals(arg0));
        let (v0, v1, v2, _) = 0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::ve_mmt::gauge_fields(arg0);
        assert!(0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::epoch::is_epoch_start(v1, arg2), 0);
        let v4 = 0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::voting_escrow::user_votes(arg1);
        if (0x1::vector::length<0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::voting_escrow::UserVote>(&v4) == 0) {
            0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::voting_escrow::extend(arg1, arg2);
        };
        0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::assert::assert_vote_allowed_for_user(v2, v1, arg3, arg4);
        let v5 = 0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::epoch::epoch_id(v1, 0x2::clock::timestamp_ms(arg3));
        0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::assert::assert_ve_all_claimed(v2, arg1, v5);
        let v6 = 0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::vote::remove_votes(v2, v0, v1, arg1, v5);
        0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::voting_escrow::extend(arg1, arg2);
        0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::vote::add_votes(v2, v0, v1, arg1, v5, &v6);
    }

    public fun merge(arg0: &mut 0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::ve_mmt::VeMMT, arg1: &mut 0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::voting_escrow::VotingEscrow, arg2: 0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::voting_escrow::VotingEscrow, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::ve_mmt::assert_supported_version(arg0);
        0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::gauge_globals::assert_not_paused(0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::ve_mmt::gauge_globals(arg0));
        let v0 = 0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::voting_escrow::user_votes(&arg2);
        assert!(0x1::vector::length<0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::voting_escrow::UserVote>(&v0) == 0, 2);
        let v1 = 0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::voting_escrow::user_votes(arg1);
        if (0x1::vector::length<0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::voting_escrow::UserVote>(&v1) == 0) {
            0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::voting_escrow::merge(arg1, arg2);
            return
        };
        let (v2, v3, v4, _) = 0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::ve_mmt::gauge_fields(arg0);
        0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::assert::assert_vote_allowed_for_user(v4, v3, arg3, arg4);
        let v6 = 0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::epoch::epoch_id(v3, 0x2::clock::timestamp_ms(arg3));
        0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::assert::assert_ve_all_claimed(v4, arg1, v6);
        let v7 = 0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::vote::remove_votes(v4, v2, v3, arg1, v6);
        0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::voting_escrow::merge(arg1, arg2);
        0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::vote::add_votes(v4, v2, v3, arg1, v6, &v7);
    }

    public fun set_max_bond(arg0: &mut 0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::ve_mmt::VeMMT, arg1: &mut 0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::voting_escrow::VotingEscrow, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::ve_mmt::assert_supported_version(arg0);
        0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::gauge_globals::assert_not_paused(0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::ve_mmt::gauge_globals(arg0));
        let (_, v1, _) = 0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::voting_escrow::bond_info(arg1);
        assert!(v1 == 0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::voting_escrow::bond_mode_max_bond(), 1);
        let v3 = 0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::voting_escrow::user_votes(arg1);
        if (0x1::vector::length<0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::voting_escrow::UserVote>(&v3) == 0) {
            0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::voting_escrow::set_max_bond(arg1);
        };
        let (v4, v5, v6, _) = 0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::ve_mmt::gauge_fields(arg0);
        0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::assert::assert_vote_allowed_for_user(v6, v5, arg2, arg3);
        let v8 = 0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::epoch::epoch_id(v5, 0x2::clock::timestamp_ms(arg2));
        0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::assert::assert_ve_all_claimed(v6, arg1, v8);
        let v9 = 0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::vote::remove_votes(v6, v4, v5, arg1, v8);
        0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::voting_escrow::set_max_bond(arg1);
        0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::vote::add_votes(v6, v4, v5, arg1, v8, &v9);
    }

    public fun set_normal(arg0: &mut 0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::ve_mmt::VeMMT, arg1: &mut 0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::voting_escrow::VotingEscrow, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::ve_mmt::assert_supported_version(arg0);
        0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::gauge_globals::assert_not_paused(0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::ve_mmt::gauge_globals(arg0));
        let (_, v1, _) = 0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::voting_escrow::bond_info(arg1);
        assert!(v1 == 0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::voting_escrow::bond_mode_normal(), 1);
        let (v3, v4, v5, _) = 0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::ve_mmt::gauge_fields(arg0);
        assert!(0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::epoch::is_epoch_start(v4, arg2), 0);
        let v7 = 0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::voting_escrow::user_votes(arg1);
        if (0x1::vector::length<0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::voting_escrow::UserVote>(&v7) == 0) {
            0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::voting_escrow::set_normal(arg1, arg2);
        };
        0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::assert::assert_vote_allowed_for_user(v5, v4, arg3, arg4);
        let v8 = 0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::epoch::epoch_id(v4, 0x2::clock::timestamp_ms(arg3));
        0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::assert::assert_ve_all_claimed(v5, arg1, v8);
        let v9 = 0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::vote::remove_votes(v5, v3, v4, arg1, v8);
        0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::voting_escrow::set_normal(arg1, arg2);
        0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::vote::add_votes(v5, v3, v4, arg1, v8, &v9);
    }

    public fun unbond(arg0: &mut 0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::ve_mmt::VeMMT, arg1: 0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::voting_escrow::VotingEscrow, arg2: &0x2::clock::Clock) : 0x2::balance::Balance<0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::mmt::MMT> {
        0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::ve_mmt::assert_supported_version(arg0);
        0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::gauge_globals::assert_not_paused(0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::ve_mmt::gauge_globals(arg0));
        let v0 = 0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::voting_escrow::user_votes(&arg1);
        assert!(0x1::vector::length<0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::voting_escrow::UserVote>(&v0) == 0, 2);
        0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::voting_escrow::unbond(arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

