module 0xc10f1c6276fe397bfda2200ffbbe174ebbf2aa95ec2d92aa0906c66345e0cde6::group_storm {
    struct GroupStorm has store, key {
        id: 0x2::object::UID,
        creator: address,
        participants: 0x2::vec_set::VecSet<address>,
        name: 0x1::string::String,
        ek_compressed: vector<u8>,
        committee_ref: vector<u8>,
        ell_max: u64,
        epoch_padding: u64,
        current_epoch: u64,
        version: u64,
    }

    struct GroupStormEpoch has store, key {
        id: 0x2::object::UID,
        storm: 0x2::object::ID,
        epoch_no: u64,
        cts: vector<vector<u8>>,
        aead_payloads: vector<vector<u8>>,
        senders: vector<address>,
        walrus_blob_ids: vector<vector<u8>>,
        bad_ct_indices: 0x2::vec_set::VecSet<u64>,
        sbk: vector<u8>,
        sealed_at_ms: u64,
        sealed_by: vector<u8>,
    }

    struct GroupStormOpened has copy, drop {
        storm: 0x2::object::ID,
        creator: address,
        n_participants: u64,
        ell_max: u64,
    }

    struct GroupThunderPosted has copy, drop {
        epoch: 0x2::object::ID,
        storm: 0x2::object::ID,
        epoch_no: u64,
        slot: u64,
        sender: address,
    }

    struct GroupEpochSealed has copy, drop {
        epoch: 0x2::object::ID,
        storm: 0x2::object::ID,
        epoch_no: u64,
        sealed_by: address,
        sealed_at_ms: u64,
        n_messages: u64,
    }

    struct GroupEpochRotated has copy, drop {
        storm: 0x2::object::ID,
        prev_epoch: 0x2::object::ID,
        new_epoch: 0x2::object::ID,
        new_epoch_no: u64,
    }

    public fun add_participant(arg0: &mut GroupStorm, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 0);
        if (!0x2::vec_set::contains<address>(&arg0.participants, &arg1)) {
            0x2::vec_set::insert<address>(&mut arg0.participants, arg1);
        };
    }

    public fun creator(arg0: &GroupStorm) : address {
        arg0.creator
    }

    public fun ek(arg0: &GroupStorm) : &vector<u8> {
        &arg0.ek_compressed
    }

    public fun epoch_cts(arg0: &GroupStormEpoch) : &vector<vector<u8>> {
        &arg0.cts
    }

    public fun epoch_is_sealed(arg0: &GroupStormEpoch) : bool {
        arg0.sealed_at_ms != 0
    }

    public fun epoch_no(arg0: &GroupStormEpoch) : u64 {
        arg0.epoch_no
    }

    public fun epoch_payloads(arg0: &GroupStormEpoch) : &vector<vector<u8>> {
        &arg0.aead_payloads
    }

    public fun epoch_sbk(arg0: &GroupStormEpoch) : &vector<u8> {
        &arg0.sbk
    }

    public fun epoch_storm(arg0: &GroupStormEpoch) : 0x2::object::ID {
        arg0.storm
    }

    public fun is_participant(arg0: &GroupStorm, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.participants, &arg1)
    }

    fun is_power_of_two(arg0: u64) : bool {
        arg0 > 0 && arg0 & arg0 - 1 == 0
    }

    public fun leave(arg0: &mut GroupStorm, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::vec_set::contains<address>(&arg0.participants, &v0), 0);
        0x2::vec_set::remove<address>(&mut arg0.participants, &v0);
    }

    public fun mark_bad_ct(arg0: &mut GroupStormEpoch, arg1: &GroupStorm, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.storm == 0x2::object::id<GroupStorm>(arg1), 0);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::vec_set::contains<address>(&arg1.participants, &v0), 0);
        assert!(arg0.sealed_at_ms == 0, 9);
        assert!(arg2 < 0x1::vector::length<vector<u8>>(&arg0.cts), 7);
        0x2::vec_set::insert<u64>(&mut arg0.bad_ct_indices, arg2);
    }

    fun new_epoch(arg0: &GroupStorm, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : GroupStormEpoch {
        GroupStormEpoch{
            id              : 0x2::object::new(arg2),
            storm           : 0x2::object::id<GroupStorm>(arg0),
            epoch_no        : arg1,
            cts             : vector[],
            aead_payloads   : vector[],
            senders         : vector[],
            walrus_blob_ids : vector[],
            bad_ct_indices  : 0x2::vec_set::empty<u64>(),
            sbk             : b"",
            sealed_at_ms    : 0,
            sealed_by       : b"",
        }
    }

    public fun open(arg0: 0x1::string::String, arg1: vector<address>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : GroupStorm {
        assert!(0x1::vector::length<u8>(&arg2) == 576, 2);
        assert!(is_power_of_two(arg4), 4);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::vec_set::empty<address>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&arg1)) {
            let v3 = *0x1::vector::borrow<address>(&arg1, v2);
            if (!0x2::vec_set::contains<address>(&v1, &v3)) {
                0x2::vec_set::insert<address>(&mut v1, v3);
            };
            v2 = v2 + 1;
        };
        if (!0x2::vec_set::contains<address>(&v1, &v0)) {
            0x2::vec_set::insert<address>(&mut v1, v0);
        };
        let v4 = GroupStorm{
            id            : 0x2::object::new(arg6),
            creator       : v0,
            participants  : v1,
            name          : arg0,
            ek_compressed : arg2,
            committee_ref : arg3,
            ell_max       : arg4,
            epoch_padding : arg5,
            current_epoch : 0,
            version       : 1,
        };
        let v5 = GroupStormOpened{
            storm          : 0x2::object::id<GroupStorm>(&v4),
            creator        : v0,
            n_participants : 0x2::vec_set::length<address>(&v4.participants),
            ell_max        : arg4,
        };
        0x2::event::emit<GroupStormOpened>(v5);
        v4
    }

    public fun participants(arg0: &GroupStorm) : &0x2::vec_set::VecSet<address> {
        &arg0.participants
    }

    public fun post_thunder(arg0: &mut GroupStormEpoch, arg1: &GroupStorm, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::tx_context::TxContext) {
        assert!(arg0.storm == 0x2::object::id<GroupStorm>(arg1), 0);
        assert!(arg0.sealed_at_ms == 0, 6);
        assert!(0x1::vector::length<u8>(&arg2) == 704, 1);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0x2::vec_set::contains<address>(&arg1.participants, &v0), 0);
        let v1 = 0x1::vector::length<vector<u8>>(&arg0.cts);
        assert!(v1 < arg1.ell_max, 5);
        0x1::vector::push_back<vector<u8>>(&mut arg0.cts, arg2);
        0x1::vector::push_back<vector<u8>>(&mut arg0.aead_payloads, arg3);
        0x1::vector::push_back<address>(&mut arg0.senders, v0);
        0x1::vector::push_back<vector<u8>>(&mut arg0.walrus_blob_ids, arg4);
        let v2 = GroupThunderPosted{
            epoch    : 0x2::object::id<GroupStormEpoch>(arg0),
            storm    : 0x2::object::id<GroupStorm>(arg1),
            epoch_no : arg0.epoch_no,
            slot     : v1,
            sender   : v0,
        };
        0x2::event::emit<GroupThunderPosted>(v2);
    }

    public fun rotate_epoch(arg0: &mut GroupStorm, arg1: &GroupStormEpoch, arg2: &mut 0x2::tx_context::TxContext) : GroupStormEpoch {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::vec_set::contains<address>(&arg0.participants, &v0), 0);
        assert!(arg1.storm == 0x2::object::id<GroupStorm>(arg0), 0);
        assert!(arg1.sealed_at_ms != 0, 8);
        arg0.current_epoch = arg0.current_epoch + 1;
        let v1 = new_epoch(arg0, arg0.current_epoch, arg2);
        let v2 = GroupEpochRotated{
            storm        : 0x2::object::id<GroupStorm>(arg0),
            prev_epoch   : 0x2::object::id<GroupStormEpoch>(arg1),
            new_epoch    : 0x2::object::id<GroupStormEpoch>(&v1),
            new_epoch_no : arg0.current_epoch,
        };
        0x2::event::emit<GroupEpochRotated>(v2);
        v1
    }

    public fun seal_epoch(arg0: &mut GroupStormEpoch, arg1: &GroupStorm, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg0.storm == 0x2::object::id<GroupStorm>(arg1), 0);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::vec_set::contains<address>(&arg1.participants, &v0), 0);
        assert!(arg0.sealed_at_ms == 0, 6);
        assert!(0x1::vector::length<u8>(&arg2) == 48, 3);
        arg0.sbk = arg2;
        arg0.sealed_at_ms = 0x2::clock::timestamp_ms(arg3);
        arg0.sealed_by = 0x2::address::to_bytes(v0);
        let v1 = GroupEpochSealed{
            epoch        : 0x2::object::id<GroupStormEpoch>(arg0),
            storm        : 0x2::object::id<GroupStorm>(arg1),
            epoch_no     : arg0.epoch_no,
            sealed_by    : v0,
            sealed_at_ms : arg0.sealed_at_ms,
            n_messages   : 0x1::vector::length<vector<u8>>(&arg0.cts),
        };
        0x2::event::emit<GroupEpochSealed>(v1);
    }

    // decompiled from Move bytecode v7
}

