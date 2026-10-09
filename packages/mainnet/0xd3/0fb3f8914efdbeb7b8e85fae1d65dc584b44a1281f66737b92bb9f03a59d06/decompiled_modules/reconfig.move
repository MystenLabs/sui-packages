module 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::reconfig {
    struct ReconfigCompletionMessage has copy, drop, store {
        epoch: u64,
        mpc_public_key: vector<u8>,
    }

    struct CommitteeTransitionRequest has copy, drop, store {
        new_committee: 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::Committee,
    }

    struct ReconfigStarted has copy, drop {
        epoch: u64,
    }

    struct ReconfigEnded has copy, drop {
        from_epoch: u64,
        epoch: u64,
        mpc_public_key: vector<u8>,
    }

    struct ReconfigAborted has copy, drop {
        epoch: u64,
    }

    entry fun abort_reconfig(arg0: &mut 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::Hashi, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::versioning::assert_version_enabled(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::versioning(arg0));
        assert!(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee_set::is_reconfiguring(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::committee_set(arg0)), 13906835170775793665);
        assert!(0x1::option::destroy_some<u64>(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee_set::pending_epoch_change(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::committee_set(arg0))) == arg1, 13906835183661088775);
        let v0 = ReconfigAborted{epoch: 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee_set::abort_reconfig(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::committee_set_mut(arg0), arg2)};
        0x2::event::emit<ReconfigAborted>(v0);
    }

    entry fun end_reconfig(arg0: &mut 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::Hashi, arg1: vector<u8>, arg2: 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::CommitteeSignature, arg3: &0x2::tx_context::TxContext) {
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::versioning::assert_version_enabled(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::versioning(arg0));
        let v0 = 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::signature_epoch(&arg2);
        let v1 = if (0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee_set::pending_epoch_change(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::committee_set(arg0)) != 0x1::option::some<u64>(v0)) {
            if (0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee_set::epoch(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::committee_set(arg0)) == v0) {
                0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee_set::has_committee(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::committee_set(arg0), v0)
            } else {
                false
            }
        } else {
            false
        };
        assert!(!v1, 13906834732689260547);
        assert!(pending_epoch_in_window(arg0, arg3) == v0, 13906834745574424583);
        let v2 = 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee_set::epoch(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::committee_set(arg0));
        let v3 = ReconfigCompletionMessage{
            epoch          : v0,
            mpc_public_key : arg1,
        };
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::verify_with_committee<ReconfigCompletionMessage>(arg0, 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee_set::get_committee(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::committee_set(arg0), v0), 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::intent::reconfig_completion(), v3, arg2);
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::reset_presig_allocator(arg0);
        let (v4, v5) = 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee_set::end_reconfig(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::committee_set_mut(arg0), arg1, arg3);
        if (0x1::vector::is_empty<u8>(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee_set::mpc_public_key(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::committee_set(arg0)))) {
            0x1::option::destroy_none<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::CommitteeSignature>(v5);
        } else {
            0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee_set::insert_committee_handoff(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::committee_set_mut(arg0), v2, v4, 0x1::option::destroy_some<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::CommitteeSignature>(v5));
        };
        let v6 = ReconfigEnded{
            from_epoch     : v2,
            epoch          : v4,
            mpc_public_key : arg1,
        };
        0x2::event::emit<ReconfigEnded>(v6);
    }

    entry fun start_reconfig(arg0: &mut 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::Hashi, arg1: &0x3::sui_system::SuiSystemState, arg2: &0x2::tx_context::TxContext) {
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::versioning::assert_version_enabled(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::versioning(arg0));
        assert_reconfig_not_held(arg0);
        assert!(!0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee_set::is_reconfiguring(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::committee_set(arg0)), 13906834578070306815);
        assert_genesis_launch_authorized(arg0);
        let v0 = ReconfigStarted{epoch: 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee_set::start_reconfig(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::committee_set_mut(arg0), arg1, *0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::epoch_config(arg0), arg2)};
        0x2::event::emit<ReconfigStarted>(v0);
    }

    public(friend) fun assert_genesis_launch_authorized(arg0: &0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::Hashi) {
        if (0x1::vector::is_empty<u8>(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee_set::mpc_public_key(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::committee_set(arg0)))) {
            assert!(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::versioning::has_upgrade_cap(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::versioning(arg0)), 13906835303920435211);
        };
    }

    public(friend) fun assert_reconfig_not_held(arg0: &0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::Hashi) {
        assert!(!0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config::reconfig_hold(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::config(arg0)), 13906835252380958733);
    }

    fun pending_epoch_in_window(arg0: &0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::Hashi, arg1: &0x2::tx_context::TxContext) : u64 {
        assert!(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee_set::is_reconfiguring(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::committee_set(arg0)), 13906835372639256577);
        let v0 = 0x1::option::destroy_some<u64>(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee_set::pending_epoch_change(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::committee_set(arg0)));
        assert!(v0 == 0x2::tx_context::epoch(arg1), 13906835381229453317);
        v0
    }

    entry fun submit_committee_handoff(arg0: &mut 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::Hashi, arg1: u64, arg2: 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::CommitteeSignature, arg3: &0x2::tx_context::TxContext) {
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::versioning::assert_version_enabled(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::versioning(arg0));
        let v0 = 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::signature_epoch(&arg2);
        let v1 = 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee_set::has_committee_handoff(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::committee_set(arg0), v0) && 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee_set::committee_handoff_next_epoch(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::committee_set(arg0), v0) == arg1;
        assert!(!v1, 13906835016157102083);
        assert!(pending_epoch_in_window(arg0, arg3) == arg1, 13906835029042266119);
        assert!(!0x1::vector::is_empty<u8>(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee_set::mpc_public_key(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::committee_set(arg0))), 13906835033337364489);
        let v2 = CommitteeTransitionRequest{new_committee: *0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee_set::get_committee(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::committee_set(arg0), arg1)};
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::verify_with_committee<CommitteeTransitionRequest>(arg0, 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::current_committee(arg0), 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::intent::committee_transition(), v2, arg2);
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee_set::set_pending_committee_handoff_cert(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::committee_set_mut(arg0), arg2);
    }

    // decompiled from Move bytecode v7
}

