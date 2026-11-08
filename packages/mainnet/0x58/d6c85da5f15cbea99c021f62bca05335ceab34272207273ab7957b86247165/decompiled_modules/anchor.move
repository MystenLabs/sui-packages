module 0x58d6c85da5f15cbea99c021f62bca05335ceab34272207273ab7957b86247165::anchor {
    struct Checkpoint has copy, drop, store {
        charter_commitment: vector<u8>,
        opening_commitment: vector<u8>,
        package_digest: 0x1::option::Option<vector<u8>>,
        entries_root: vector<u8>,
        receipts_root: vector<u8>,
        grant_commitments_root: vector<u8>,
        revocations_root: vector<u8>,
        seq: u64,
        at: 0x1::string::String,
        close_path: 0x1::option::Option<0x1::string::String>,
        close_final_seq: 0x1::option::Option<u64>,
    }

    struct Anchor has key {
        id: 0x2::object::UID,
        room: vector<u8>,
        checkpoints: vector<Checkpoint>,
    }

    struct CheckpointEvent has copy, drop {
        anchor: 0x2::object::ID,
        index: u64,
        seq: u64,
        closed: bool,
    }

    public fun append(arg0: &mut Anchor, arg1: vector<u8>, arg2: vector<u8>, arg3: 0x1::option::Option<vector<u8>>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: u64, arg9: 0x1::string::String) {
        push(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, 0x1::option::none<0x1::string::String>(), 0x1::option::none<u64>());
    }

    public fun append_close(arg0: &mut Anchor, arg1: vector<u8>, arg2: vector<u8>, arg3: 0x1::option::Option<vector<u8>>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: u64, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: u64) {
        push(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, 0x1::option::some<0x1::string::String>(arg10), 0x1::option::some<u64>(arg11));
    }

    public fun count(arg0: &Anchor) : u64 {
        0x1::vector::length<Checkpoint>(&arg0.checkpoints)
    }

    public fun create(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg0) == 32, 3);
        let v0 = Anchor{
            id          : 0x2::object::new(arg1),
            room        : arg0,
            checkpoints : 0x1::vector::empty<Checkpoint>(),
        };
        0x2::transfer::transfer<Anchor>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun entries_root_at(arg0: &Anchor, arg1: u64) : vector<u8> {
        0x1::vector::borrow<Checkpoint>(&arg0.checkpoints, arg1).entries_root
    }

    public fun grant_commitments_root_at(arg0: &Anchor, arg1: u64) : vector<u8> {
        0x1::vector::borrow<Checkpoint>(&arg0.checkpoints, arg1).grant_commitments_root
    }

    public fun is_closed(arg0: &Anchor) : bool {
        let v0 = 0x1::vector::length<Checkpoint>(&arg0.checkpoints);
        v0 > 0 && 0x1::option::is_some<0x1::string::String>(&0x1::vector::borrow<Checkpoint>(&arg0.checkpoints, v0 - 1).close_path)
    }

    public fun package_digest_at(arg0: &Anchor, arg1: u64) : 0x1::option::Option<vector<u8>> {
        0x1::vector::borrow<Checkpoint>(&arg0.checkpoints, arg1).package_digest
    }

    fun push(arg0: &mut Anchor, arg1: vector<u8>, arg2: vector<u8>, arg3: 0x1::option::Option<vector<u8>>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: u64, arg9: 0x1::string::String, arg10: 0x1::option::Option<0x1::string::String>, arg11: 0x1::option::Option<u64>) {
        assert!(0x1::vector::length<u8>(&arg1) == 32, 3);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 3);
        assert!(0x1::option::is_none<vector<u8>>(&arg3) || 0x1::vector::length<u8>(0x1::option::borrow<vector<u8>>(&arg3)) == 32, 3);
        assert!(0x1::vector::length<u8>(&arg4) == 32, 3);
        assert!(0x1::vector::length<u8>(&arg5) == 32, 3);
        assert!(0x1::vector::length<u8>(&arg6) == 32, 3);
        assert!(0x1::vector::length<u8>(&arg7) == 32, 3);
        let v0 = 0x1::vector::length<Checkpoint>(&arg0.checkpoints);
        if (v0 > 0) {
            let v1 = 0x1::vector::borrow<Checkpoint>(&arg0.checkpoints, v0 - 1);
            assert!(0x1::option::is_none<0x1::string::String>(&v1.close_path), 2);
            assert!(arg8 >= v1.seq, 1);
        };
        let v2 = Checkpoint{
            charter_commitment     : arg1,
            opening_commitment     : arg2,
            package_digest         : arg3,
            entries_root           : arg4,
            receipts_root          : arg5,
            grant_commitments_root : arg6,
            revocations_root       : arg7,
            seq                    : arg8,
            at                     : arg9,
            close_path             : arg10,
            close_final_seq        : arg11,
        };
        0x1::vector::push_back<Checkpoint>(&mut arg0.checkpoints, v2);
        let v3 = CheckpointEvent{
            anchor : 0x2::object::id<Anchor>(arg0),
            index  : v0,
            seq    : arg8,
            closed : 0x1::option::is_some<0x1::string::String>(&arg10),
        };
        0x2::event::emit<CheckpointEvent>(v3);
    }

    public fun revocations_root_at(arg0: &Anchor, arg1: u64) : vector<u8> {
        0x1::vector::borrow<Checkpoint>(&arg0.checkpoints, arg1).revocations_root
    }

    public fun room(arg0: &Anchor) : vector<u8> {
        arg0.room
    }

    public fun seq_at(arg0: &Anchor, arg1: u64) : u64 {
        0x1::vector::borrow<Checkpoint>(&arg0.checkpoints, arg1).seq
    }

    // decompiled from Move bytecode v7
}

