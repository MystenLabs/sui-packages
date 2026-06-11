module 0xf3e012521c4180154d452665826ca96f8b38b167d5e3d4d8af605f0528dc84f3::machine {
    struct Machine has store, key {
        id: 0x2::object::UID,
        owner: address,
        current_blob_id: u256,
        manifest_hash: vector<u8>,
        provenance_head: vector<u8>,
        checkpoint_count: u64,
        parent: 0x1::option::Option<0x2::object::ID>,
        policy_id: 0x2::object::ID,
        created_at_epoch: u32,
    }

    struct MachineCreated has copy, drop {
        machine_id: 0x2::object::ID,
        owner: address,
        policy_id: 0x2::object::ID,
        created_at_epoch: u32,
    }

    struct CheckpointRegistered has copy, drop {
        machine_id: 0x2::object::ID,
        seq: u64,
        blob_id: u256,
        manifest_hash: vector<u8>,
        payload_hash: vector<u8>,
        prev_head: vector<u8>,
        new_head: vector<u8>,
        timestamp_ms: u64,
    }

    struct MachineForked has copy, drop {
        child_id: 0x2::object::ID,
        parent_id: 0x2::object::ID,
        owner: address,
        blob_id: u256,
        parent_head: vector<u8>,
        child_head: vector<u8>,
    }

    struct MachineRetired has copy, drop {
        machine_id: 0x2::object::ID,
        owner: address,
        seq: u64,
        blob_id: u256,
        manifest_hash: vector<u8>,
        payload_hash: vector<u8>,
        prev_head: vector<u8>,
        new_head: vector<u8>,
        timestamp_ms: u64,
    }

    fun append_head_entry(arg0: &mut Machine, arg1: u8, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : (u64, vector<u8>, vector<u8>, u64) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg4), 0);
        let v0 = arg0.checkpoint_count;
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = arg0.provenance_head;
        let v3 = b"";
        let v4 = compute_entry_hash(&v2, arg1, v0, 0, &v3, &arg2, v1);
        arg0.provenance_head = v4;
        (v0, v2, v4, v1)
    }

    public fun checkpoint_count(arg0: &Machine) : u64 {
        arg0.checkpoint_count
    }

    fun compute_entry_hash(arg0: &vector<u8>, arg1: u8, arg2: u64, arg3: u256, arg4: &vector<u8>, arg5: &vector<u8>, arg6: u64) : vector<u8> {
        let v0 = *arg0;
        0x1::vector::push_back<u8>(&mut v0, arg1);
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u256>(&arg3));
        0x1::vector::append<u8>(&mut v0, *arg4);
        0x1::vector::append<u8>(&mut v0, *arg5);
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg6));
        0x2::hash::blake2b256(&v0)
    }

    fun compute_fork_genesis(arg0: &vector<u8>, arg1: vector<u8>) : vector<u8> {
        let v0 = *arg0;
        0x1::vector::push_back<u8>(&mut v0, 4);
        0x1::vector::append<u8>(&mut v0, arg1);
        0x2::hash::blake2b256(&v0)
    }

    public fun create(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : Machine {
        let v0 = 0x2::object::new(arg1);
        let v1 = 0x2::object::uid_to_bytes(&v0);
        let v2 = 0x2::tx_context::sender(arg1);
        let v3 = (0x2::tx_context::epoch(arg1) as u32);
        let v4 = Machine{
            id               : v0,
            owner            : v2,
            current_blob_id  : 0,
            manifest_hash    : b"",
            provenance_head  : 0x2::hash::blake2b256(&v1),
            checkpoint_count : 0,
            parent           : 0x1::option::none<0x2::object::ID>(),
            policy_id        : arg0,
            created_at_epoch : v3,
        };
        let v5 = MachineCreated{
            machine_id       : 0x2::object::id<Machine>(&v4),
            owner            : v2,
            policy_id        : arg0,
            created_at_epoch : v3,
        };
        0x2::event::emit<MachineCreated>(v5);
        v4
    }

    entry fun create_owned(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create(arg0, arg1);
        0x2::transfer::transfer<Machine>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun created_at_epoch(arg0: &Machine) : u32 {
        arg0.created_at_epoch
    }

    public fun current_blob_id(arg0: &Machine) : u256 {
        arg0.current_blob_id
    }

    public fun fork(arg0: &Machine, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : Machine {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        let v0 = 0x2::object::new(arg2);
        let v1 = arg0.provenance_head;
        let v2 = compute_fork_genesis(&v1, 0x2::object::uid_to_bytes(&v0));
        let v3 = 0x2::tx_context::sender(arg2);
        let v4 = 0x2::object::id<Machine>(arg0);
        let v5 = Machine{
            id               : v0,
            owner            : v3,
            current_blob_id  : arg0.current_blob_id,
            manifest_hash    : arg0.manifest_hash,
            provenance_head  : v2,
            checkpoint_count : 0,
            parent           : 0x1::option::some<0x2::object::ID>(v4),
            policy_id        : arg1,
            created_at_epoch : (0x2::tx_context::epoch(arg2) as u32),
        };
        let v6 = MachineForked{
            child_id    : 0x2::object::id<Machine>(&v5),
            parent_id   : v4,
            owner       : v3,
            blob_id     : v5.current_blob_id,
            parent_head : v1,
            child_head  : v2,
        };
        0x2::event::emit<MachineForked>(v6);
        v5
    }

    entry fun fork_owned(arg0: &Machine, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = fork(arg0, arg1, arg2);
        0x2::transfer::transfer<Machine>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun id_bytes(arg0: &Machine) : vector<u8> {
        0x2::object::uid_to_bytes(&arg0.id)
    }

    public fun manifest_hash(arg0: &Machine) : vector<u8> {
        arg0.manifest_hash
    }

    public fun owner(arg0: &Machine) : address {
        arg0.owner
    }

    public fun parent(arg0: &Machine) : 0x1::option::Option<0x2::object::ID> {
        arg0.parent
    }

    public fun policy_id(arg0: &Machine) : 0x2::object::ID {
        arg0.policy_id
    }

    public fun provenance_head(arg0: &Machine) : vector<u8> {
        arg0.provenance_head
    }

    public fun register_checkpoint(arg0: &mut Machine, arg1: u256, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg5), 0);
        let v0 = arg0.checkpoint_count;
        let v1 = 0x2::clock::timestamp_ms(arg4);
        let v2 = arg0.provenance_head;
        let v3 = compute_entry_hash(&v2, 0, v0, arg1, &arg2, &arg3, v1);
        arg0.current_blob_id = arg1;
        arg0.provenance_head = v3;
        arg0.manifest_hash = arg2;
        arg0.checkpoint_count = v0 + 1;
        let v4 = CheckpointRegistered{
            machine_id    : 0x2::object::id<Machine>(arg0),
            seq           : v0,
            blob_id       : arg1,
            manifest_hash : arg0.manifest_hash,
            payload_hash  : arg3,
            prev_head     : v2,
            new_head      : v3,
            timestamp_ms  : v1,
        };
        0x2::event::emit<CheckpointRegistered>(v4);
    }

    public(friend) fun register_grant(arg0: &mut Machine, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) : (u64, vector<u8>, vector<u8>, u64) {
        append_head_entry(arg0, 2, arg1, arg2, arg3)
    }

    public(friend) fun register_revoke(arg0: &mut Machine, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) : (u64, vector<u8>, vector<u8>, u64) {
        append_head_entry(arg0, 3, arg1, arg2, arg3)
    }

    public fun retire(arg0: &mut Machine, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x1::bcs::to_bytes<address>(&arg0.owner);
        let v1 = 0x2::hash::blake2b256(&v0);
        let (v2, v3, v4, v5) = append_head_entry(arg0, 5, v1, arg1, arg2);
        let v6 = MachineRetired{
            machine_id    : 0x2::object::id<Machine>(arg0),
            owner         : arg0.owner,
            seq           : v2,
            blob_id       : 0,
            manifest_hash : b"",
            payload_hash  : v1,
            prev_head     : v3,
            new_head      : v4,
            timestamp_ms  : v5,
        };
        0x2::event::emit<MachineRetired>(v6);
    }

    // decompiled from Move bytecode v7
}

