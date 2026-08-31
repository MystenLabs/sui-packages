module 0x4a6237edc7f7e1766317a4ee731e85975f7b3b87fe8d7616f3023722b0991085::stats_object_claims {
    struct ClaimableStatsObject has key {
        id: 0x2::object::UID,
        object: 0x4a6237edc7f7e1766317a4ee731e85975f7b3b87fe8d7616f3023722b0991085::stats_objects::StatsObject,
        secret_hash: vector<u8>,
        recipient: 0x1::option::Option<address>,
        creator: address,
        expires_at_ms: u64,
    }

    struct ClaimableStatsObjectCreated has copy, drop {
        claimable_id: 0x2::object::ID,
        stats_object_id: 0x2::object::ID,
        creator: address,
        recipient: 0x1::option::Option<address>,
        expires_at_ms: u64,
        secret_hash: vector<u8>,
    }

    struct ClaimableStatsObjectClaimed has copy, drop {
        claimable_id: 0x2::object::ID,
        stats_object_id: 0x2::object::ID,
        recipient: address,
    }

    struct ClaimableStatsObjectCancelled has copy, drop {
        claimable_id: 0x2::object::ID,
        stats_object_id: 0x2::object::ID,
        creator: address,
    }

    fun assert_valid_recipient(arg0: &0x1::option::Option<address>) {
        if (0x1::option::is_some<address>(arg0)) {
            assert!(*0x1::option::borrow<address>(arg0) != @0x0, 3);
        };
    }

    public fun cancel(arg0: ClaimableStatsObject, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x4a6237edc7f7e1766317a4ee731e85975f7b3b87fe8d7616f3023722b0991085::stats_objects::StatsObject>(cancel_internal(arg0, v0), v0);
    }

    fun cancel_internal(arg0: ClaimableStatsObject, arg1: address) : 0x4a6237edc7f7e1766317a4ee731e85975f7b3b87fe8d7616f3023722b0991085::stats_objects::StatsObject {
        assert!(arg0.creator == arg1, 7);
        let ClaimableStatsObject {
            id            : v0,
            object        : v1,
            secret_hash   : _,
            recipient     : _,
            creator       : _,
            expires_at_ms : _,
        } = arg0;
        let v6 = v1;
        let v7 = v0;
        0x2::object::delete(v7);
        let v8 = ClaimableStatsObjectCancelled{
            claimable_id    : 0x2::object::uid_to_inner(&v7),
            stats_object_id : 0x2::object::id<0x4a6237edc7f7e1766317a4ee731e85975f7b3b87fe8d7616f3023722b0991085::stats_objects::StatsObject>(&v6),
            creator         : arg1,
        };
        0x2::event::emit<ClaimableStatsObjectCancelled>(v8);
        v6
    }

    public fun claim(arg0: ClaimableStatsObject, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        0x2::transfer::public_transfer<0x4a6237edc7f7e1766317a4ee731e85975f7b3b87fe8d7616f3023722b0991085::stats_objects::StatsObject>(claim_internal(arg0, arg1, v0, arg2), v0);
    }

    fun claim_internal(arg0: ClaimableStatsObject, arg1: vector<u8>, arg2: address, arg3: &0x2::clock::Clock) : 0x4a6237edc7f7e1766317a4ee731e85975f7b3b87fe8d7616f3023722b0991085::stats_objects::StatsObject {
        assert!(0x2::clock::timestamp_ms(arg3) < arg0.expires_at_ms, 4);
        assert!(0x2::hash::blake2b256(&arg1) == arg0.secret_hash, 5);
        if (0x1::option::is_some<address>(&arg0.recipient)) {
            assert!(*0x1::option::borrow<address>(&arg0.recipient) == arg2, 6);
        };
        let ClaimableStatsObject {
            id            : v0,
            object        : v1,
            secret_hash   : _,
            recipient     : _,
            creator       : _,
            expires_at_ms : _,
        } = arg0;
        let v6 = v1;
        let v7 = v0;
        0x2::object::delete(v7);
        let v8 = ClaimableStatsObjectClaimed{
            claimable_id    : 0x2::object::uid_to_inner(&v7),
            stats_object_id : 0x2::object::id<0x4a6237edc7f7e1766317a4ee731e85975f7b3b87fe8d7616f3023722b0991085::stats_objects::StatsObject>(&v6),
            recipient       : arg2,
        };
        0x2::event::emit<ClaimableStatsObjectClaimed>(v8);
        v6
    }

    fun clone_bytes(arg0: &vector<u8>) : vector<u8> {
        let v0 = b"";
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(arg0)) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, v1));
            v1 = v1 + 1;
        };
        v0
    }

    public fun create_claimable_gift(arg0: 0x4a6237edc7f7e1766317a4ee731e85975f7b3b87fe8d7616f3023722b0991085::stats_objects::StatsObject, arg1: vector<u8>, arg2: 0x1::option::Option<address>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = new_claimable(arg0, arg1, arg2, arg3, v0, arg4, arg5);
        emit_created(&v1);
        0x2::transfer::share_object<ClaimableStatsObject>(v1);
    }

    fun emit_created(arg0: &ClaimableStatsObject) {
        let v0 = ClaimableStatsObjectCreated{
            claimable_id    : 0x2::object::uid_to_inner(&arg0.id),
            stats_object_id : 0x2::object::id<0x4a6237edc7f7e1766317a4ee731e85975f7b3b87fe8d7616f3023722b0991085::stats_objects::StatsObject>(&arg0.object),
            creator         : arg0.creator,
            recipient       : arg0.recipient,
            expires_at_ms   : arg0.expires_at_ms,
            secret_hash     : clone_bytes(&arg0.secret_hash),
        };
        0x2::event::emit<ClaimableStatsObjectCreated>(v0);
    }

    fun new_claimable(arg0: 0x4a6237edc7f7e1766317a4ee731e85975f7b3b87fe8d7616f3023722b0991085::stats_objects::StatsObject, arg1: vector<u8>, arg2: 0x1::option::Option<address>, arg3: u64, arg4: address, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : ClaimableStatsObject {
        assert!(0x1::vector::length<u8>(&arg1) == 32, 1);
        assert!(arg3 > 0x2::clock::timestamp_ms(arg5), 2);
        assert_valid_recipient(&arg2);
        ClaimableStatsObject{
            id            : 0x2::object::new(arg6),
            object        : arg0,
            secret_hash   : arg1,
            recipient     : arg2,
            creator       : arg4,
            expires_at_ms : arg3,
        }
    }

    // decompiled from Move bytecode v7
}

