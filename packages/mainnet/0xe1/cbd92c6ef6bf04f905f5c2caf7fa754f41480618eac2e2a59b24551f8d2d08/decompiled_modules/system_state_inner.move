module 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::system_state_inner {
    struct SystemStateInnerV1 has store {
        committee: 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::bls_aggregate::BlsCommittee,
        total_capacity_size: u64,
        used_capacity_size: u64,
        storage_price_per_unit_size: u64,
        write_price_per_unit_size: u64,
        future_accounting: 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::storage_accounting::FutureAccountingRingBuffer,
        event_blob_certification_state: 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::event_blob::EventBlobCertificationState,
        deny_list_sizes: 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::extended_field::ExtendedField<0x2::vec_map::VecMap<0x2::object::ID, u64>>,
    }

    public(friend) fun epoch(arg0: &SystemStateInnerV1) : u32 {
        0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::bls_aggregate::epoch(&arg0.committee)
    }

    public(friend) fun n_shards(arg0: &SystemStateInnerV1) : u16 {
        0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::bls_aggregate::n_shards(&arg0.committee)
    }

    public(friend) fun write_price(arg0: &SystemStateInnerV1, arg1: u64) : u64 {
        arg0.write_price_per_unit_size * 0x1::u64::divide_and_round_up(arg1, 1048576)
    }

    public(friend) fun add_per_epoch_subsidies(arg0: &mut SystemStateInnerV1, arg1: vector<0x2::balance::Balance<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>>) {
        assert!(0x1::vector::length<0x2::balance::Balance<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>>(&arg1) <= (0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::storage_accounting::max_epochs_ahead(&arg0.future_accounting) as u64), 2);
        let v0 = 0;
        0x1::vector::reverse<0x2::balance::Balance<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>>(&mut arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::balance::Balance<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>>(&arg1)) {
            0x2::balance::join<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>(0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::storage_accounting::rewards_balance(0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::storage_accounting::ring_lookup_mut(&mut arg0.future_accounting, v0)), 0x1::vector::pop_back<0x2::balance::Balance<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>>(&mut arg1));
            v0 = v0 + 1;
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0x2::balance::Balance<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>>(arg1);
    }

    public(friend) fun add_subsidy(arg0: &mut SystemStateInnerV1, arg1: 0x2::coin::Coin<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>, arg2: u32) {
        assert!(arg2 > 0, 2);
        assert!(arg2 <= 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::storage_accounting::max_epochs_ahead(&arg0.future_accounting), 2);
        let v0 = 0x2::coin::into_balance<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>(arg1);
        let v1 = 0;
        while (v1 < arg2) {
            0x2::balance::join<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>(0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::storage_accounting::rewards_balance(0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::storage_accounting::ring_lookup_mut(&mut arg0.future_accounting, v1)), 0x2::balance::split<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>(&mut v0, 0x2::balance::value<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>(&v0) / (arg2 as u64)));
            v1 = v1 + 1;
        };
        0x2::balance::join<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>(0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::storage_accounting::rewards_balance(0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::storage_accounting::ring_lookup_mut(&mut arg0.future_accounting, 0)), v0);
    }

    public(friend) fun advance_epoch(arg0: &mut SystemStateInnerV1, arg1: 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::bls_aggregate::BlsCommittee, arg2: &0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::epoch_parameters::EpochParams) : 0x2::vec_map::VecMap<0x2::object::ID, 0x2::balance::Balance<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>> {
        let v0 = epoch(arg0);
        let v1 = arg0.committee;
        assert!(0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::bls_aggregate::epoch(&arg1) == v0 + 1, 4);
        arg0.committee = arg1;
        let v2 = 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::storage_accounting::ring_pop_expand(&mut arg0.future_accounting);
        assert!(0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::storage_accounting::epoch(&v2) == v0, 5);
        0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::event_blob::reset(&mut arg0.event_blob_certification_state);
        let v3 = 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::storage_accounting::used_capacity(&v2);
        arg0.used_capacity_size = 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::storage_accounting::used_capacity(0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::storage_accounting::ring_lookup_mut(&mut arg0.future_accounting, 0));
        arg0.total_capacity_size = 0x1::u64::max(0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::epoch_parameters::capacity(arg2), arg0.used_capacity_size);
        arg0.storage_price_per_unit_size = 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::epoch_parameters::storage_price(arg2);
        arg0.write_price_per_unit_size = 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::epoch_parameters::write_price(arg2);
        let v4 = 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::storage_accounting::unwrap_balance(v2);
        let v5 = 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::extended_field::borrow<0x2::vec_map::VecMap<0x2::object::ID, u64>>(&arg0.deny_list_sizes);
        let (v6, v7) = 0x2::vec_map::into_keys_values<0x2::object::ID, u16>(0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::bls_aggregate::to_vec_map(&v1));
        let v8 = vector[];
        let v9 = 0;
        let v10 = v6;
        let v11 = v7;
        0x1::vector::reverse<u16>(&mut v11);
        assert!(0x1::vector::length<0x2::object::ID>(&v10) == 0x1::vector::length<u16>(&v11), 13906834895897886719);
        0x1::vector::reverse<0x2::object::ID>(&mut v10);
        let v12 = 0;
        while (v12 < 0x1::vector::length<0x2::object::ID>(&v10)) {
            let v13 = 0x1::vector::pop_back<0x2::object::ID>(&mut v10);
            let v14 = 0x2::vec_map::try_get<0x2::object::ID, u64>(v5, &v13);
            let v15 = if (0x1::option::is_some<u64>(&v14)) {
                0x1::option::destroy_some<u64>(v14)
            } else {
                0x1::option::destroy_none<u64>(v14);
                0
            };
            let v16 = (0x1::vector::pop_back<u16>(&mut v11) as u128) * ((v3 - 0x1::u64::min(v15, v3)) as u128);
            v9 = v9 + v16;
            0x1::vector::push_back<u128>(&mut v8, v16);
            v12 = v12 + 1;
        };
        0x1::vector::destroy_empty<0x2::object::ID>(v10);
        0x1::vector::destroy_empty<u16>(v11);
        let v17 = 0x1::vector::empty<0x2::balance::Balance<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>>();
        0x1::vector::reverse<u128>(&mut v8);
        let v18 = 0;
        while (v18 < 0x1::vector::length<u128>(&v8)) {
            0x1::vector::push_back<0x2::balance::Balance<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>>(&mut v17, 0x2::balance::split<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>(&mut v4, ((0x1::vector::pop_back<u128>(&mut v8) * (0x2::balance::value<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>(&v4) as u128) / 0x1::u128::max(v9, 1)) as u64)));
            v18 = v18 + 1;
        };
        0x1::vector::destroy_empty<u128>(v8);
        0x2::balance::join<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>(0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::storage_accounting::rewards_balance(0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::storage_accounting::ring_lookup_mut(&mut arg0.future_accounting, 0)), v4);
        0x2::vec_map::from_keys_values<0x2::object::ID, 0x2::balance::Balance<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>>(v6, v17)
    }

    public(friend) fun certify_blob(arg0: &SystemStateInnerV1, arg1: &mut 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::blob::Blob, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>) {
        let v0 = 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::bls_aggregate::verify_quorum_in_epoch(committee(arg0), arg2, arg3, arg4);
        assert!(0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::messages::cert_epoch(&v0) == epoch(arg0), 3);
        0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::blob::certify_with_certified_msg(arg1, epoch(arg0), 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::messages::certify_blob_message(v0));
    }

    public(friend) fun certify_event_blob(arg0: &mut SystemStateInnerV1, arg1: &mut 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::storage_node::StorageNodeCap, arg2: u256, arg3: u256, arg4: u64, arg5: u8, arg6: u64, arg7: u32, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::storage_node::node_id(arg1);
        assert!(0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::bls_aggregate::contains(committee(arg0), &v0), 8);
        assert!(arg7 == epoch(arg0), 3);
        let v1 = 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::storage_node::last_event_blob_attestation(arg1);
        if (0x1::option::is_some<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::event_blob::EventBlobAttestation>(&v1)) {
            let v2 = 0x1::option::destroy_some<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::event_blob::EventBlobAttestation>(v1);
            assert!(0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::event_blob::last_attested_event_blob_epoch(&v2) < epoch(arg0) || arg6 > 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::event_blob::last_attested_event_blob_checkpoint_seq_num(&v2), 7);
            let v3 = 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::event_blob::get_latest_certified_checkpoint_sequence_number(&arg0.event_blob_certification_state);
            if (0x1::option::is_some<u64>(&v3)) {
                assert!(0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::event_blob::last_attested_event_blob_epoch(&v2) < epoch(arg0) || 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::event_blob::last_attested_event_blob_checkpoint_seq_num(&v2) <= 0x1::option::destroy_some<u64>(v3), 6);
            } else {
                assert!(0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::event_blob::last_attested_event_blob_epoch(&v2) < epoch(arg0), 6);
            };
        } else {
            0x1::option::destroy_none<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::event_blob::EventBlobAttestation>(v1);
        };
        0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::storage_node::set_last_event_blob_attestation(arg1, 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::event_blob::new_attestation(arg6, arg7));
        if (0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::event_blob::is_blob_already_certified(&arg0.event_blob_certification_state, arg6)) {
            return
        };
        0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::event_blob::start_tracking_blob(&mut arg0.event_blob_certification_state, arg2, arg6);
        let v4 = 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::storage_node::node_id(arg1);
        if (!0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::bls_aggregate::is_quorum(committee(arg0), 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::event_blob::update_aggregate_weight(&mut arg0.event_blob_certification_state, arg2, arg6, 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::bls_aggregate::get_member_weight(committee(arg0), &v4)))) {
            return
        };
        let v5 = 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::storage_accounting::max_epochs_ahead(&arg0.future_accounting);
        let v6 = 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::encoding::encoded_blob_length(arg4, arg5, n_shards(arg0));
        let v7 = reserve_space_without_payment(arg0, v6, 0, v5, false, arg8);
        let v8 = 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::blob::new(v7, arg2, arg3, arg4, arg5, false, epoch(arg0), n_shards(arg0), arg8);
        0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::blob::certify_with_certified_msg(&mut v8, epoch(arg0), 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::messages::certified_event_blob_message(arg2));
        0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::event_blob::update_latest_certified_event_blob(&mut arg0.event_blob_certification_state, arg6, arg2);
        0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::event_blob::reset(&mut arg0.event_blob_certification_state);
        0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::blob::burn(v8);
    }

    public(friend) fun committee(arg0: &SystemStateInnerV1) : &0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::bls_aggregate::BlsCommittee {
        &arg0.committee
    }

    public(friend) fun create_empty(arg0: u32, arg1: &mut 0x2::tx_context::TxContext) : SystemStateInnerV1 {
        assert!(arg0 <= 1000, 0);
        SystemStateInnerV1{
            committee                      : 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::bls_aggregate::new_bls_committee(0, 0x1::vector::empty<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::bls_aggregate::BlsCommitteeMember>()),
            total_capacity_size            : 0,
            used_capacity_size             : 0,
            storage_price_per_unit_size    : 0,
            write_price_per_unit_size      : 0,
            future_accounting              : 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::storage_accounting::ring_new(arg0),
            event_blob_certification_state : 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::event_blob::create_with_empty_state(),
            deny_list_sizes                : 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::extended_field::new<0x2::vec_map::VecMap<0x2::object::ID, u64>>(0x2::vec_map::empty<0x2::object::ID, u64>(), arg1),
        }
    }

    public(friend) fun delete_blob(arg0: &SystemStateInnerV1, arg1: 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::blob::Blob) : 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::storage_resource::Storage {
        0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::blob::delete(arg1, epoch(arg0))
    }

    public(friend) fun delete_deny_listed_blob(arg0: &SystemStateInnerV1, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>) {
        let v0 = 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::bls_aggregate::verify_one_correct_node_in_epoch(&arg0.committee, arg1, arg2, arg3);
        let v1 = 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::messages::cert_epoch(&v0);
        let v2 = 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::messages::deny_list_blob_deleted_message(v0);
        assert!(v1 == epoch(arg0), 3);
        0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::events::emit_deny_listed_blob_deleted(v1, 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::messages::blob_id(&v2));
    }

    public(friend) fun extend_blob(arg0: &mut SystemStateInnerV1, arg1: &mut 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::blob::Blob, arg2: u32, arg3: &mut 0x2::coin::Coin<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>) {
        0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::blob::assert_certified_not_expired(arg1, epoch(arg0));
        let v0 = 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::storage_resource::end_epoch(0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::blob::storage(arg1)) - epoch(arg0);
        let v1 = v0 + arg2;
        assert!(arg2 > 0, 2);
        assert!(v1 <= 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::storage_accounting::max_epochs_ahead(&arg0.future_accounting), 2);
        let v2 = 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::storage_resource::size(0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::blob::storage(arg1));
        process_storage_payments(arg0, v2, v0, v1, arg3);
        while (v0 < v1) {
            assert!(0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::storage_accounting::increase_used_capacity(0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::storage_accounting::ring_lookup_mut(&mut arg0.future_accounting, v0), v2) <= arg0.total_capacity_size, 1);
            v0 = v0 + 1;
        };
        0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::storage_resource::extend_end_epoch(0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::blob::storage_mut(arg1), arg2);
        0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::blob::emit_certified(arg1, true);
    }

    public(friend) fun extend_blob_with_resource(arg0: &SystemStateInnerV1, arg1: &mut 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::blob::Blob, arg2: 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::storage_resource::Storage) {
        0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::blob::extend_with_resource(arg1, arg2, epoch(arg0));
    }

    public(friend) fun future_accounting(arg0: &SystemStateInnerV1) : &0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::storage_accounting::FutureAccountingRingBuffer {
        &arg0.future_accounting
    }

    public(friend) fun invalidate_blob_id(arg0: &SystemStateInnerV1, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>) : u256 {
        let v0 = 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::bls_aggregate::verify_one_correct_node_in_epoch(&arg0.committee, arg1, arg2, arg3);
        let v1 = 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::messages::cert_epoch(&v0);
        let v2 = 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::messages::invalid_blob_id_message(v0);
        let v3 = 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::messages::invalid_blob_id(&v2);
        assert!(v1 == epoch(arg0), 3);
        0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::events::emit_invalid_blob_id(v1, v3);
        v3
    }

    fun process_storage_payments(arg0: &mut SystemStateInnerV1, arg1: u64, arg2: u32, arg3: u32, arg4: &mut 0x2::coin::Coin<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>) {
        let v0 = 0x2::coin::balance_mut<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>(arg4);
        while (arg2 < arg3) {
            0x2::balance::join<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>(0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::storage_accounting::rewards_balance(0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::storage_accounting::ring_lookup_mut(&mut arg0.future_accounting, arg2)), 0x2::balance::split<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>(v0, arg0.storage_price_per_unit_size * 0x1::u64::divide_and_round_up(arg1, 1048576)));
            arg2 = arg2 + 1;
        };
    }

    public(friend) fun register_blob(arg0: &mut SystemStateInnerV1, arg1: 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::storage_resource::Storage, arg2: u256, arg3: u256, arg4: u64, arg5: u8, arg6: bool, arg7: &mut 0x2::coin::Coin<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>, arg8: &mut 0x2::tx_context::TxContext) : 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::blob::Blob {
        let v0 = 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::blob::new(arg1, arg2, arg3, arg4, arg5, arg6, epoch(arg0), n_shards(arg0), arg8);
        0x2::balance::join<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>(0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::storage_accounting::rewards_balance(0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::storage_accounting::ring_lookup_mut(&mut arg0.future_accounting, 0)), 0x2::balance::split<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>(0x2::coin::balance_mut<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>(arg7), write_price(arg0, 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::blob::encoded_size(&v0, n_shards(arg0)))));
        v0
    }

    public(friend) fun register_deny_list_update(arg0: &SystemStateInnerV1, arg1: &0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::storage_node::StorageNodeCap, arg2: u256, arg3: u64) {
        let v0 = 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::storage_node::node_id(arg1);
        assert!(0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::bls_aggregate::contains(committee(arg0), &v0), 8);
        assert!(arg3 > 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::storage_node::deny_list_sequence(arg1), 9);
        0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::events::emit_register_deny_list_update(epoch(arg0), arg2, arg3, 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::storage_node::node_id(arg1));
    }

    public(friend) fun reserve_space(arg0: &mut SystemStateInnerV1, arg1: u64, arg2: u32, arg3: &mut 0x2::coin::Coin<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>, arg4: &mut 0x2::tx_context::TxContext) : 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::storage_resource::Storage {
        assert!(arg2 > 0, 2);
        assert!(arg2 <= 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::storage_accounting::max_epochs_ahead(&arg0.future_accounting), 2);
        let v0 = epoch(arg0);
        reserve_space_for_epochs(arg0, arg1, v0, v0 + arg2, arg3, arg4)
    }

    public(friend) fun reserve_space_for_epochs(arg0: &mut SystemStateInnerV1, arg1: u64, arg2: u32, arg3: u32, arg4: &mut 0x2::coin::Coin<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>, arg5: &mut 0x2::tx_context::TxContext) : 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::storage_resource::Storage {
        let v0 = epoch(arg0);
        let v1 = 0x1::u32::max(arg2, v0);
        let v2 = v1 - v0;
        assert!(arg3 > v1, 2);
        let v3 = arg3 - v0;
        assert!(v3 <= 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::storage_accounting::max_epochs_ahead(&arg0.future_accounting), 2);
        process_storage_payments(arg0, arg1, v2, v3, arg4);
        reserve_space_without_payment(arg0, arg1, v2, v3, true, arg5)
    }

    fun reserve_space_without_payment(arg0: &mut SystemStateInnerV1, arg1: u64, arg2: u32, arg3: u32, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) : 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::storage_resource::Storage {
        assert!(arg3 - arg2 > 0, 2);
        assert!(arg3 <= 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::storage_accounting::max_epochs_ahead(&arg0.future_accounting), 2);
        assert!(arg1 > 0, 11);
        while (arg2 < arg3) {
            let v0 = 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::storage_accounting::increase_used_capacity(0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::storage_accounting::ring_lookup_mut(&mut arg0.future_accounting, arg2), arg1);
            if (arg2 == 0) {
                arg0.used_capacity_size = v0;
            };
            assert!(!arg4 || v0 <= arg0.total_capacity_size, 1);
            arg2 = arg2 + 1;
        };
        let v1 = epoch(arg0);
        0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::storage_resource::create_storage(v1 + arg2, v1 + arg3, arg1, arg5)
    }

    public(friend) fun total_capacity_size(arg0: &SystemStateInnerV1) : u64 {
        arg0.total_capacity_size
    }

    public(friend) fun update_deny_list(arg0: &mut SystemStateInnerV1, arg1: &mut 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::storage_node::StorageNodeCap, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>) {
        let v0 = 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::storage_node::node_id(arg1);
        assert!(0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::bls_aggregate::contains(committee(arg0), &v0), 8);
        let v1 = 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::bls_aggregate::verify_quorum_in_epoch(&arg0.committee, arg2, arg3, arg4);
        let v2 = 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::messages::deny_list_update_message(v1);
        let v3 = 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::messages::storage_node_id(&v2);
        assert!(0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::messages::cert_epoch(&v1) == epoch(arg0), 3);
        assert!(v3 == 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::storage_node::node_id(arg1), 10);
        assert!(0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::storage_node::deny_list_sequence(arg1) < 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::messages::sequence_number(&v2), 9);
        let v4 = 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::messages::root(&v2);
        let v5 = 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::messages::sequence_number(&v2);
        0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::storage_node::set_deny_list_properties(arg1, v4, v5, 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::messages::size(&v2));
        let v6 = 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::extended_field::borrow_mut<0x2::vec_map::VecMap<0x2::object::ID, u64>>(&mut arg0.deny_list_sizes);
        if (0x2::vec_map::contains<0x2::object::ID, u64>(v6, &v3)) {
            *0x2::vec_map::get_mut<0x2::object::ID, u64>(v6, &v3) = 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::messages::size(&v2);
        } else {
            0x2::vec_map::insert<0x2::object::ID, u64>(v6, v3, 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::messages::size(&v2));
        };
        0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::events::emit_deny_list_update(epoch(arg0), v4, v5, 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::storage_node::node_id(arg1));
    }

    public(friend) fun update_protocol_version(arg0: &SystemStateInnerV1, arg1: &0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::storage_node::StorageNodeCap, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>) {
        let v0 = 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::storage_node::node_id(arg1);
        assert!(0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::bls_aggregate::contains(committee(arg0), &v0), 8);
        let v1 = 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::bls_aggregate::verify_quorum_in_epoch(&arg0.committee, arg2, arg3, arg4);
        let v2 = 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::messages::cert_epoch(&v1);
        let v3 = 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::messages::protocol_version_message(v1);
        assert!(v2 == epoch(arg0), 3);
        assert!(0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::messages::start_epoch(&v3) >= epoch(arg0), 12);
        0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::events::emit_protocol_version(v2, 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::messages::start_epoch(&v3), 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::messages::protocol_version(&v3));
    }

    public(friend) fun used_capacity_size(arg0: &SystemStateInnerV1) : u64 {
        arg0.used_capacity_size
    }

    // decompiled from Move bytecode v6
}

