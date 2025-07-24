module 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::event_blob {
    struct EventBlobAttestation has copy, drop, store {
        checkpoint_sequence_num: u64,
        epoch: u32,
    }

    struct EventBlob has copy, drop, store {
        blob_id: u256,
        ending_checkpoint_sequence_number: u64,
    }

    struct EventBlobCertificationState has store {
        latest_certified_blob: 0x1::option::Option<EventBlob>,
        aggregate_weight_per_blob: 0x2::vec_map::VecMap<EventBlob, u16>,
    }

    public(friend) fun blob_id(arg0: &EventBlob) : u256 {
        arg0.blob_id
    }

    public(friend) fun create_with_empty_state() : EventBlobCertificationState {
        EventBlobCertificationState{
            latest_certified_blob     : 0x1::option::none<EventBlob>(),
            aggregate_weight_per_blob : 0x2::vec_map::empty<EventBlob, u16>(),
        }
    }

    public(friend) fun ending_checkpoint_sequence_number(arg0: &EventBlob) : u64 {
        arg0.ending_checkpoint_sequence_number
    }

    public(friend) fun get_latest_certified_blob_id(arg0: &EventBlobCertificationState) : 0x1::option::Option<u256> {
        let v0 = arg0.latest_certified_blob;
        if (0x1::option::is_some<EventBlob>(&v0)) {
            let v2 = 0x1::option::destroy_some<EventBlob>(v0);
            0x1::option::some<u256>(blob_id(&v2))
        } else {
            0x1::option::destroy_none<EventBlob>(v0);
            0x1::option::none<u256>()
        }
    }

    public(friend) fun get_latest_certified_checkpoint_sequence_number(arg0: &EventBlobCertificationState) : 0x1::option::Option<u64> {
        let v0 = arg0.latest_certified_blob;
        if (0x1::option::is_some<EventBlob>(&v0)) {
            let v2 = 0x1::option::destroy_some<EventBlob>(v0);
            0x1::option::some<u64>(ending_checkpoint_sequence_number(&v2))
        } else {
            0x1::option::destroy_none<EventBlob>(v0);
            0x1::option::none<u64>()
        }
    }

    public(friend) fun get_num_tracked_blobs(arg0: &EventBlobCertificationState) : u64 {
        0x2::vec_map::size<EventBlob, u16>(&arg0.aggregate_weight_per_blob)
    }

    public(friend) fun is_blob_already_certified(arg0: &EventBlobCertificationState, arg1: u64) : bool {
        let v0 = get_latest_certified_checkpoint_sequence_number(arg0);
        let v1 = if (0x1::option::is_some<u64>(&v0)) {
            0x1::option::some<bool>(0x1::option::destroy_some<u64>(v0) >= arg1)
        } else {
            0x1::option::destroy_none<u64>(v0);
            0x1::option::none<bool>()
        };
        let v2 = v1;
        if (0x1::option::is_some<bool>(&v2)) {
            0x1::option::destroy_some<bool>(v2)
        } else {
            0x1::option::destroy_none<bool>(v2);
            false
        }
    }

    public(friend) fun last_attested_event_blob_checkpoint_seq_num(arg0: &EventBlobAttestation) : u64 {
        arg0.checkpoint_sequence_num
    }

    public(friend) fun last_attested_event_blob_epoch(arg0: &EventBlobAttestation) : u32 {
        arg0.epoch
    }

    public(friend) fun new_attestation(arg0: u64, arg1: u32) : EventBlobAttestation {
        EventBlobAttestation{
            checkpoint_sequence_num : arg0,
            epoch                   : arg1,
        }
    }

    public(friend) fun new_event_blob(arg0: u64, arg1: u256) : EventBlob {
        EventBlob{
            blob_id                           : arg1,
            ending_checkpoint_sequence_number : arg0,
        }
    }

    public(friend) fun reset(arg0: &mut EventBlobCertificationState) {
        arg0.aggregate_weight_per_blob = 0x2::vec_map::empty<EventBlob, u16>();
    }

    public(friend) fun start_tracking_blob(arg0: &mut EventBlobCertificationState, arg1: u256, arg2: u64) {
        let v0 = new_event_blob(arg2, arg1);
        if (!0x2::vec_map::contains<EventBlob, u16>(&arg0.aggregate_weight_per_blob, &v0)) {
            0x2::vec_map::insert<EventBlob, u16>(&mut arg0.aggregate_weight_per_blob, v0, 0);
        };
    }

    public(friend) fun update_aggregate_weight(arg0: &mut EventBlobCertificationState, arg1: u256, arg2: u64, arg3: u16) : u16 {
        let v0 = new_event_blob(arg2, arg1);
        let v1 = 0x2::vec_map::get_mut<EventBlob, u16>(&mut arg0.aggregate_weight_per_blob, &v0);
        *v1 = *v1 + arg3;
        *v1
    }

    public(friend) fun update_latest_certified_event_blob(arg0: &mut EventBlobCertificationState, arg1: u64, arg2: u256) {
        let v0 = get_latest_certified_checkpoint_sequence_number(arg0);
        if (0x1::option::is_some<u64>(&v0)) {
            assert!(arg1 > 0x1::option::destroy_some<u64>(v0), 0);
        } else {
            0x1::option::destroy_none<u64>(v0);
        };
        arg0.latest_certified_blob = 0x1::option::some<EventBlob>(new_event_blob(arg1, arg2));
    }

    // decompiled from Move bytecode v6
}

