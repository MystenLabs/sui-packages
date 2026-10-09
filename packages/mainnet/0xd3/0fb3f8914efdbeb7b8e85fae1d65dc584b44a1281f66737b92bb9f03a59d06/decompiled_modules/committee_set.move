module 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee_set {
    struct CommitteeSet has store {
        members: 0x2::bag::Bag,
        tls_public_keys: 0x2::table::Table<vector<u8>, address>,
        epoch: u64,
        committees: 0x2::bag::Bag,
        pending_epoch_change: 0x1::option::Option<PendingEpochChange>,
        mpc_public_key: vector<u8>,
    }

    struct PendingEpochChange has copy, drop, store {
        epoch: u64,
        committee_handoff_cert: 0x1::option::Option<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::CommitteeSignature>,
    }

    struct CommitteeHandoffKey has copy, drop, store {
        epoch: u64,
    }

    struct CommitteeHandoff has store {
        next_epoch: u64,
        cert: 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::CommitteeSignature,
    }

    struct MemberInfo has store {
        validator_address: address,
        operator_address: address,
        next_epoch_public_key: 0x2::group_ops::Element<0x2::bls12381::UncompressedG1>,
        endpoint_url: 0x1::string::String,
        tls_public_key: vector<u8>,
        next_epoch_encryption_public_key: vector<u8>,
        ignored: bool,
        resigned: bool,
        extra_fields: 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config::Config,
    }

    public(friend) fun epoch(arg0: &CommitteeSet) : u64 {
        arg0.epoch
    }

    public(friend) fun has_member(arg0: &CommitteeSet, arg1: address) : bool {
        0x2::bag::contains_with_type<address, MemberInfo>(&arg0.members, arg1)
    }

    public(friend) fun abort_reconfig(arg0: &mut CommitteeSet, arg1: &0x2::tx_context::TxContext) : u64 {
        assert!(is_reconfiguring(arg0), 13906836442086113279);
        assert!(0x1::option::borrow<PendingEpochChange>(&arg0.pending_epoch_change).epoch != 0x2::tx_context::epoch(arg1), 13839000972700745758);
        let PendingEpochChange {
            epoch                  : v0,
            committee_handoff_cert : v1,
        } = 0x1::option::extract<PendingEpochChange>(&mut arg0.pending_epoch_change);
        let v2 = v1;
        if (0x1::option::is_some<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::CommitteeSignature>(&v2)) {
            0x1::option::destroy_some<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::CommitteeSignature>(v2);
        } else {
            0x1::option::destroy_none<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::CommitteeSignature>(v2);
        };
        remove_committee(arg0, v0);
        v0
    }

    fun assert_authorized(arg0: &MemberInfo, arg1: &0x2::tx_context::TxContext) {
        assert!(is_authorized(arg0, arg1), 13837876365578534934);
    }

    fun assert_not_last_active_member(arg0: &CommitteeSet, arg1: address) {
        if (!has_committee(arg0, epoch(arg0))) {
            return
        };
        let v0 = current_committee(arg0);
        if (!0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::has_member(v0, &arg1)) {
            return
        };
        let v1 = false;
        let v2 = 0;
        while (v2 < 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::n_members(v0)) {
            let v3 = 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::validator_address(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::get_idx(v0, v2));
            let v4 = if (v3 != arg1) {
                if (has_member(arg0, v3)) {
                    if (!is_resigned(member(arg0, v3))) {
                        !is_ignored(member(arg0, v3))
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            if (v4) {
                v1 = true;
                break
            };
            v2 = v2 + 1;
        };
        assert!(v1, 13835905941956395016);
    }

    public(friend) fun clear_resignation(arg0: &mut CommitteeSet, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(has_member(arg0, arg1), 13835059953657774082);
        let v0 = member(arg0, arg1);
        assert_authorized(v0, arg2);
        assert!(is_resigned(v0), 13835622916496359430);
        member_mut(arg0, arg1).resigned = false;
    }

    public(friend) fun committee_handoff_next_epoch(arg0: &CommitteeSet, arg1: u64) : u64 {
        let v0 = CommitteeHandoffKey{epoch: arg1};
        0x2::bag::borrow<CommitteeHandoffKey, CommitteeHandoff>(&arg0.committees, v0).next_epoch
    }

    public(friend) fun create(arg0: &mut 0x2::tx_context::TxContext) : CommitteeSet {
        CommitteeSet{
            members              : 0x2::bag::new(arg0),
            tls_public_keys      : 0x2::table::new<vector<u8>, address>(arg0),
            epoch                : 0,
            committees           : 0x2::bag::new(arg0),
            pending_epoch_change : 0x1::option::none<PendingEpochChange>(),
            mpc_public_key       : 0x1::vector::empty<u8>(),
        }
    }

    public(friend) fun current_committee(arg0: &CommitteeSet) : &0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::Committee {
        0x2::bag::borrow<u64, 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::Committee>(&arg0.committees, epoch(arg0))
    }

    public(friend) fun end_reconfig(arg0: &mut CommitteeSet, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) : (u64, 0x1::option::Option<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::CommitteeSignature>) {
        assert!(is_reconfiguring(arg0), 13906836244517617663);
        let PendingEpochChange {
            epoch                  : v0,
            committee_handoff_cert : v1,
        } = 0x1::option::extract<PendingEpochChange>(&mut arg0.pending_epoch_change);
        let v2 = v1;
        assert!(has_committee(arg0, v0), 13906836261697486847);
        assert!(0x1::vector::length<u8>(&arg1) == 33, 13839282280173862944);
        if (0x1::vector::is_empty<u8>(&arg0.mpc_public_key)) {
            arg0.mpc_public_key = arg1;
        } else {
            assert!(0x1::option::is_some<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::CommitteeSignature>(&v2), 13906836308942127103);
        };
        assert!(arg0.mpc_public_key == arg1, 13906836330416963583);
        arg0.epoch = v0;
        (v0, v2)
    }

    public(friend) fun get_committee(arg0: &CommitteeSet, arg1: u64) : &0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::Committee {
        0x2::bag::borrow<u64, 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::Committee>(&arg0.committees, arg1)
    }

    public(friend) fun has_committee(arg0: &CommitteeSet, arg1: u64) : bool {
        0x2::bag::contains_with_type<u64, 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::Committee>(&arg0.committees, arg1)
    }

    public(friend) fun has_committee_handoff(arg0: &CommitteeSet, arg1: u64) : bool {
        let v0 = CommitteeHandoffKey{epoch: arg1};
        0x2::bag::contains_with_type<CommitteeHandoffKey, CommitteeHandoff>(&arg0.committees, v0)
    }

    fun in_current_or_pending_committee(arg0: &CommitteeSet, arg1: address) : bool {
        if (has_committee(arg0, epoch(arg0)) && 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::has_member(current_committee(arg0), &arg1)) {
            return true
        };
        if (0x1::option::is_none<PendingEpochChange>(&arg0.pending_epoch_change)) {
            return false
        };
        let v0 = 0x1::option::borrow<PendingEpochChange>(&arg0.pending_epoch_change).epoch;
        has_committee(arg0, v0) && 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::has_member(get_committee(arg0, v0), &arg1)
    }

    fun insert_committee(arg0: &mut CommitteeSet, arg1: 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::Committee) {
        0x2::bag::add<u64, 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::Committee>(&mut arg0.committees, 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::epoch(&arg1), arg1);
    }

    public(friend) fun insert_committee_handoff(arg0: &mut CommitteeSet, arg1: u64, arg2: u64, arg3: 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::CommitteeSignature) {
        let v0 = CommitteeHandoffKey{epoch: arg1};
        assert!(!0x2::bag::contains_with_type<CommitteeHandoffKey, CommitteeHandoff>(&arg0.committees, v0), 13906836759913693183);
        let v1 = CommitteeHandoff{
            next_epoch : arg2,
            cert       : arg3,
        };
        0x2::bag::add<CommitteeHandoffKey, CommitteeHandoff>(&mut arg0.committees, v0, v1);
    }

    fun insert_member(arg0: &mut CommitteeSet, arg1: MemberInfo) {
        0x2::bag::add<address, MemberInfo>(&mut arg0.members, arg1.validator_address, arg1);
    }

    fun is_authorized(arg0: &MemberInfo, arg1: &0x2::tx_context::TxContext) : bool {
        let v0 = 0x2::tx_context::sender(arg1);
        v0 != @0x0 && (v0 == arg0.validator_address || v0 == arg0.operator_address)
    }

    public(friend) fun is_before_previous_committee(arg0: &CommitteeSet, arg1: u64) : bool {
        let v0 = arg0.epoch;
        while (v0 > arg1 + 1) {
            v0 = v0 - 1;
            if (has_committee(arg0, v0)) {
                return true
            };
        };
        false
    }

    fun is_ignored(arg0: &MemberInfo) : bool {
        arg0.ignored
    }

    public(friend) fun is_member_ignored(arg0: &CommitteeSet, arg1: address) : bool {
        assert!(has_member(arg0, arg1), 13835059670189932546);
        is_ignored(member(arg0, arg1))
    }

    public(friend) fun is_member_resigned(arg0: &CommitteeSet, arg1: address) : bool {
        assert!(has_member(arg0, arg1), 13835059700254703618);
        is_resigned(member(arg0, arg1))
    }

    public(friend) fun is_reconfiguring(arg0: &CommitteeSet) : bool {
        0x1::option::is_some<PendingEpochChange>(&arg0.pending_epoch_change)
    }

    fun is_resigned(arg0: &MemberInfo) : bool {
        arg0.resigned
    }

    fun member(arg0: &CommitteeSet, arg1: address) : &MemberInfo {
        0x2::bag::borrow<address, MemberInfo>(&arg0.members, arg1)
    }

    public(friend) fun member_authorized(arg0: &CommitteeSet, arg1: address, arg2: &0x2::tx_context::TxContext) : bool {
        has_member(arg0, arg1) && is_authorized(member(arg0, arg1), arg2)
    }

    fun member_mut(arg0: &mut CommitteeSet, arg1: address) : &mut MemberInfo {
        0x2::bag::borrow_mut<address, MemberInfo>(&mut arg0.members, arg1)
    }

    public(friend) fun mpc_public_key(arg0: &CommitteeSet) : &vector<u8> {
        &arg0.mpc_public_key
    }

    fun new_committee_from_voting_powers(arg0: &CommitteeSet, arg1: u64, arg2: 0x2::vec_map::VecMap<address, u64>, arg3: 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config::Config) : 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::Committee {
        let v0 = 0x2::bls12381::g1_identity();
        let v1 = 0x2::bls12381::g1_to_uncompressed_g1(&v0);
        let v2 = 0x1::vector::empty<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::CommitteeMember>();
        while (!0x2::vec_map::is_empty<address, u64>(&arg2)) {
            let (v3, v4) = 0x2::vec_map::pop<address, u64>(&mut arg2);
            if (!has_member(arg0, v3)) {
                continue
            };
            let v5 = member(arg0, v3);
            if (is_ignored(v5)) {
                continue
            };
            if (is_resigned(v5)) {
                continue
            };
            if (0x2::group_ops::equal<0x2::bls12381::UncompressedG1>(&v5.next_epoch_public_key, &v1)) {
                continue
            };
            if (0x1::vector::is_empty<u8>(&v5.next_epoch_encryption_public_key)) {
                continue
            };
            0x1::vector::push_back<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::CommitteeMember>(&mut v2, 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::new_committee_member(v3, v5.next_epoch_public_key, v5.next_epoch_encryption_public_key, v4));
        };
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::new_committee(arg1, v2, arg3)
    }

    public(friend) fun new_member(arg0: &mut CommitteeSet, arg1: &0x3::sui_system::SuiSystemState, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x3::sui_system::active_validator_addresses_ref(arg1);
        register_member(arg0, v0, 0x1::vector::contains<address>(&v1, &v0));
    }

    public(friend) fun pending_epoch_change(arg0: &CommitteeSet) : 0x1::option::Option<u64> {
        if (0x1::option::is_some<PendingEpochChange>(&arg0.pending_epoch_change)) {
            0x1::option::some<u64>(0x1::option::borrow<PendingEpochChange>(&arg0.pending_epoch_change).epoch)
        } else {
            0x1::option::none<u64>()
        }
    }

    fun register_member(arg0: &mut CommitteeSet, arg1: address, arg2: bool) {
        assert!(arg2, 13838155169085718552);
        assert!(!has_member(arg0, arg1), 13839562548264894498);
        let v0 = 0x2::bls12381::g1_identity();
        let v1 = MemberInfo{
            validator_address                : arg1,
            operator_address                 : arg1,
            next_epoch_public_key            : 0x2::bls12381::g1_to_uncompressed_g1(&v0),
            endpoint_url                     : 0x1::string::utf8(0x1::vector::empty<u8>()),
            tls_public_key                   : 0x1::vector::empty<u8>(),
            next_epoch_encryption_public_key : 0x1::vector::empty<u8>(),
            ignored                          : false,
            resigned                         : false,
            extra_fields                     : 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config::empty(),
        };
        insert_member(arg0, v1);
    }

    fun remove_committee(arg0: &mut CommitteeSet, arg1: u64) : 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::Committee {
        0x2::bag::remove<u64, 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::Committee>(&mut arg0.committees, arg1)
    }

    public(friend) fun remove_inactive_member(arg0: &mut CommitteeSet, arg1: address, arg2: bool) {
        assert!(has_member(arg0, arg1), 13835059884938297346);
        assert!(!in_current_or_pending_committee(arg0, arg1), 13836185789140631562);
        let v0 = member(arg0, arg1);
        assert!(!is_ignored(v0), 13836467272707407884);
        assert!(is_resigned(v0) || !arg2, 13836748751979216910);
        remove_member(arg0, arg1);
    }

    fun remove_member(arg0: &mut CommitteeSet, arg1: address) {
        let MemberInfo {
            validator_address                : _,
            operator_address                 : _,
            next_epoch_public_key            : _,
            endpoint_url                     : _,
            tls_public_key                   : v4,
            next_epoch_encryption_public_key : _,
            ignored                          : _,
            resigned                         : _,
            extra_fields                     : _,
        } = 0x2::bag::remove<address, MemberInfo>(&mut arg0.members, arg1);
        let v9 = v4;
        if (!0x1::vector::is_empty<u8>(&v9)) {
            0x2::table::remove<vector<u8>, address>(&mut arg0.tls_public_keys, v9);
        };
    }

    public(friend) fun request_resignation(arg0: &mut CommitteeSet, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(has_member(arg0, arg1), 13835059777564114946);
        let v0 = member(arg0, arg1);
        assert_authorized(v0, arg2);
        assert!(!is_resigned(v0), 13835341265425858564);
        if (in_current_or_pending_committee(arg0, arg1)) {
            assert_not_last_active_member(arg0, arg1);
        };
        member_mut(arg0, arg1).resigned = true;
    }

    public(friend) fun set_endpoint_url(arg0: &mut CommitteeSet, arg1: address, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        let v0 = member_mut(arg0, arg1);
        assert_authorized(v0, arg3);
        v0.endpoint_url = arg2;
    }

    public(friend) fun set_member_ignored(arg0: &mut CommitteeSet, arg1: address, arg2: bool) {
        assert!(has_member(arg0, arg1), 13835059640125161474);
        member_mut(arg0, arg1).ignored = arg2;
    }

    public(friend) fun set_next_epoch_encryption_public_key(arg0: &mut CommitteeSet, arg1: address, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg2) == 32, 13838437172343537690);
        let v0 = member_mut(arg0, arg1);
        assert_authorized(v0, arg3);
        v0.next_epoch_encryption_public_key = arg2;
    }

    public(friend) fun set_next_epoch_public_key(arg0: &mut CommitteeSet, arg1: address, arg2: address, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::tx_context::TxContext) {
        let v0 = member_mut(arg0, arg2);
        assert_authorized(v0, arg5);
        v0.next_epoch_public_key = verify_bls_public_key(arg1, 0x2::tx_context::epoch(arg5), arg2, arg3, arg4);
    }

    public(friend) fun set_operator_address(arg0: &mut CommitteeSet, arg1: address, arg2: address, arg3: &0x2::tx_context::TxContext) {
        let v0 = member_mut(arg0, arg1);
        assert_authorized(v0, arg3);
        v0.operator_address = arg2;
    }

    public(friend) fun set_pending_committee_handoff_cert(arg0: &mut CommitteeSet, arg1: 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::CommitteeSignature) {
        let v0 = 0x1::option::extract<PendingEpochChange>(&mut arg0.pending_epoch_change);
        assert!(0x1::option::is_none<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::CommitteeSignature>(&v0.committee_handoff_cert), 13906836201567944703);
        v0.committee_handoff_cert = 0x1::option::some<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::CommitteeSignature>(arg1);
        arg0.pending_epoch_change = 0x1::option::some<PendingEpochChange>(v0);
    }

    public(friend) fun set_tls_public_key(arg0: &mut CommitteeSet, arg1: address, arg2: address, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg3) == 32, 13837311092047544338);
        assert_authorized(member(arg0, arg2), arg5);
        assert!(verify_tls_proof_of_possession(arg1, &arg2, &arg3, &arg4), 13837592605679091732);
        write_tls_public_key(arg0, arg2, arg3);
    }

    public(friend) fun start_reconfig(arg0: &mut CommitteeSet, arg1: &0x3::sui_system::SuiSystemState, arg2: 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config::Config, arg3: &0x2::tx_context::TxContext) : u64 {
        start_reconfig_from_voting_powers(arg0, 0x3::sui_system::active_validator_voting_powers(arg1), arg2, arg3)
    }

    fun start_reconfig_from_voting_powers(arg0: &mut CommitteeSet, arg1: 0x2::vec_map::VecMap<address, u64>, arg2: 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config::Config, arg3: &0x2::tx_context::TxContext) : u64 {
        assert!(!is_reconfiguring(arg0), 13906836545165328383);
        assert!(!has_committee(arg0, 0x2::tx_context::epoch(arg3)), 13906836558050230271);
        assert!(arg0.epoch == 0 || arg0.epoch != 0x2::tx_context::epoch(arg3), 13906836570935132159);
        let v0 = new_committee_from_voting_powers(arg0, 0x2::tx_context::epoch(arg3), arg1, arg2);
        let v1 = 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::epoch(&v0);
        let v2 = PendingEpochChange{
            epoch                  : v1,
            committee_handoff_cert : 0x1::option::none<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::CommitteeSignature>(),
        };
        arg0.pending_epoch_change = 0x1::option::some<PendingEpochChange>(v2);
        insert_committee(arg0, v0);
        v1
    }

    fun verify_bls_public_key(arg0: address, arg1: u64, arg2: address, arg3: vector<u8>, arg4: vector<u8>) : 0x2::group_ops::Element<0x2::bls12381::UncompressedG1> {
        assert!(verify_proof_of_possession(arg0, arg1, &arg2, &arg3, &arg4), 13838720880703373340);
        let v0 = 0x2::bls12381::g1_from_bytes(&arg3);
        0x2::bls12381::g1_to_uncompressed_g1(&v0)
    }

    fun verify_proof_of_possession(arg0: address, arg1: u64, arg2: &address, arg3: &vector<u8>, arg4: &vector<u8>) : bool {
        let v0 = b"";
        let v1 = 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::intent::proof_of_possession();
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u16>(&v1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(arg2));
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(arg3)) {
            0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u8>(0x1::vector::borrow<u8>(arg3, v2)));
            v2 = v2 + 1;
        };
        0x2::bls12381::bls12381_min_pk_verify(arg4, arg3, &v0)
    }

    public(friend) fun verify_tls_proof_of_possession(arg0: address, arg1: &address, arg2: &vector<u8>, arg3: &vector<u8>) : bool {
        let v0 = b"";
        let v1 = 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::intent::tls_proof_of_possession();
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u16>(&v1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(arg1));
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(arg2)) {
            0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u8>(0x1::vector::borrow<u8>(arg2, v2)));
            v2 = v2 + 1;
        };
        0x2::ed25519::ed25519_verify(arg3, arg2, &v0)
    }

    fun write_tls_public_key(arg0: &mut CommitteeSet, arg1: address, arg2: vector<u8>) {
        assert!(0x1::vector::length<u8>(&arg2) == 32, 13837311177946890258);
        assert!(!0x2::table::contains<vector<u8>, address>(&arg0.tls_public_keys, arg2) || *0x2::table::borrow<vector<u8>, address>(&arg0.tls_public_keys, arg2) == arg1, 13837029720149917712);
        let v0 = member_mut(arg0, arg1);
        let v1 = v0.tls_public_key;
        v0.tls_public_key = arg2;
        if (!0x1::vector::is_empty<u8>(&v1)) {
            0x2::table::remove<vector<u8>, address>(&mut arg0.tls_public_keys, v1);
        };
        0x2::table::add<vector<u8>, address>(&mut arg0.tls_public_keys, arg2, arg1);
    }

    // decompiled from Move bytecode v7
}

