module 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::snapshot_blob {
    struct SnapshotBlob has copy, drop, store {
        epoch: u32,
        blob_id: u256,
        end_epoch: u32,
    }

    struct SnapshotBlobCertificationState has store {
        certified: vector<SnapshotBlob>,
        tally_epoch: u32,
        aggregate_weight_per_blob: 0x2::vec_map::VecMap<u256, u16>,
        attested_nodes: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    public(friend) fun add_aggregate_weight(arg0: &mut SnapshotBlobCertificationState, arg1: u256, arg2: u16) : u16 {
        if (!0x2::vec_map::contains<u256, u16>(&arg0.aggregate_weight_per_blob, &arg1)) {
            0x2::vec_map::insert<u256, u16>(&mut arg0.aggregate_weight_per_blob, arg1, 0);
        };
        let v0 = 0x2::vec_map::get_mut<u256, u16>(&mut arg0.aggregate_weight_per_blob, &arg1);
        *v0 = *v0 + arg2;
        *v0
    }

    public(friend) fun advance_tally_epoch(arg0: &mut SnapshotBlobCertificationState, arg1: u32) {
        if (arg0.tally_epoch != arg1) {
            arg0.tally_epoch = arg1;
            arg0.aggregate_weight_per_blob = 0x2::vec_map::empty<u256, u16>();
            arg0.attested_nodes = 0x2::vec_set::empty<0x2::object::ID>();
        };
    }

    public(friend) fun blob_id(arg0: &SnapshotBlob) : u256 {
        arg0.blob_id
    }

    public(friend) fun certified_for_epoch(arg0: &SnapshotBlobCertificationState, arg1: u32) : 0x1::option::Option<SnapshotBlob> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<SnapshotBlob>(&arg0.certified)) {
            if (0x1::vector::borrow<SnapshotBlob>(&arg0.certified, v0).epoch == arg1) {
                return 0x1::option::some<SnapshotBlob>(*0x1::vector::borrow<SnapshotBlob>(&arg0.certified, v0))
            };
            v0 = v0 + 1;
        };
        0x1::option::none<SnapshotBlob>()
    }

    public(friend) fun certified_history(arg0: &SnapshotBlobCertificationState) : &vector<SnapshotBlob> {
        &arg0.certified
    }

    public(friend) fun certify(arg0: &mut SnapshotBlobCertificationState, arg1: u32, arg2: u256, arg3: u32) {
        let v0 = get_latest_certified_epoch(arg0);
        if (0x1::option::is_some<u32>(&v0)) {
            assert!(arg1 > 0x1::option::destroy_some<u32>(v0), 0);
        } else {
            0x1::option::destroy_none<u32>(v0);
        };
        let v1 = 0x1::vector::length<SnapshotBlob>(&arg0.certified);
        let v2 = 0x1::vector::empty<SnapshotBlob>();
        let v3 = 0;
        while (v3 < v1) {
            let v4 = *0x1::vector::borrow<SnapshotBlob>(&arg0.certified, v3);
            if (v4.end_epoch > arg1 || v3 + 1 == v1) {
                0x1::vector::push_back<SnapshotBlob>(&mut v2, v4);
            };
            v3 = v3 + 1;
        };
        let v5 = SnapshotBlob{
            epoch     : arg1,
            blob_id   : arg2,
            end_epoch : arg3,
        };
        0x1::vector::push_back<SnapshotBlob>(&mut v2, v5);
        arg0.certified = v2;
        arg0.aggregate_weight_per_blob = 0x2::vec_map::empty<u256, u16>();
        arg0.attested_nodes = 0x2::vec_set::empty<0x2::object::ID>();
    }

    public(friend) fun create_with_empty_state() : SnapshotBlobCertificationState {
        SnapshotBlobCertificationState{
            certified                 : 0x1::vector::empty<SnapshotBlob>(),
            tally_epoch               : 0,
            aggregate_weight_per_blob : 0x2::vec_map::empty<u256, u16>(),
            attested_nodes            : 0x2::vec_set::empty<0x2::object::ID>(),
        }
    }

    public(friend) fun end_epoch(arg0: &SnapshotBlob) : u32 {
        arg0.end_epoch
    }

    public(friend) fun epoch(arg0: &SnapshotBlob) : u32 {
        arg0.epoch
    }

    public(friend) fun get_latest_certified_blob_id(arg0: &SnapshotBlobCertificationState) : 0x1::option::Option<u256> {
        let v0 = latest_certified(arg0);
        if (0x1::option::is_some<SnapshotBlob>(&v0)) {
            let v2 = 0x1::option::destroy_some<SnapshotBlob>(v0);
            0x1::option::some<u256>(blob_id(&v2))
        } else {
            0x1::option::destroy_none<SnapshotBlob>(v0);
            0x1::option::none<u256>()
        }
    }

    public(friend) fun get_latest_certified_epoch(arg0: &SnapshotBlobCertificationState) : 0x1::option::Option<u32> {
        let v0 = latest_certified(arg0);
        if (0x1::option::is_some<SnapshotBlob>(&v0)) {
            let v2 = 0x1::option::destroy_some<SnapshotBlob>(v0);
            0x1::option::some<u32>(epoch(&v2))
        } else {
            0x1::option::destroy_none<SnapshotBlob>(v0);
            0x1::option::none<u32>()
        }
    }

    public(friend) fun get_num_tracked_blobs(arg0: &SnapshotBlobCertificationState) : u64 {
        0x2::vec_map::length<u256, u16>(&arg0.aggregate_weight_per_blob)
    }

    public(friend) fun has_attested(arg0: &SnapshotBlobCertificationState, arg1: &0x2::object::ID) : bool {
        0x2::vec_set::contains<0x2::object::ID>(&arg0.attested_nodes, arg1)
    }

    public(friend) fun is_epoch_certified(arg0: &SnapshotBlobCertificationState, arg1: u32) : bool {
        let v0 = latest_certified(arg0);
        let v1 = if (0x1::option::is_some<SnapshotBlob>(&v0)) {
            let v2 = 0x1::option::destroy_some<SnapshotBlob>(v0);
            0x1::option::some<bool>(epoch(&v2) >= arg1)
        } else {
            0x1::option::destroy_none<SnapshotBlob>(v0);
            0x1::option::none<bool>()
        };
        let v3 = v1;
        if (0x1::option::is_some<bool>(&v3)) {
            0x1::option::destroy_some<bool>(v3)
        } else {
            0x1::option::destroy_none<bool>(v3);
            false
        }
    }

    public(friend) fun latest_certified(arg0: &SnapshotBlobCertificationState) : 0x1::option::Option<SnapshotBlob> {
        let v0 = 0x1::vector::length<SnapshotBlob>(&arg0.certified);
        if (v0 == 0) {
            0x1::option::none<SnapshotBlob>()
        } else {
            0x1::option::some<SnapshotBlob>(*0x1::vector::borrow<SnapshotBlob>(&arg0.certified, v0 - 1))
        }
    }

    public(friend) fun record_attestation(arg0: &mut SnapshotBlobCertificationState, arg1: 0x2::object::ID) {
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.attested_nodes, arg1);
    }

    // decompiled from Move bytecode v7
}

