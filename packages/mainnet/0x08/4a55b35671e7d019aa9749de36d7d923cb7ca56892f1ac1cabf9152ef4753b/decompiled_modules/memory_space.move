module 0x84a55b35671e7d019aa9749de36d7d923cb7ca56892f1ac1cabf9152ef4753b::memory_space {
    struct Space has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        entries: 0x2::table_vec::TableVec<Entry>,
        passes: 0x2::table::Table<address, u64>,
    }

    struct OwnerCap has store, key {
        id: 0x2::object::UID,
        space_id: 0x2::object::ID,
    }

    struct Entry has copy, drop, store {
        agent: 0x1::string::String,
        blob_id: 0x1::string::String,
        sha256: vector<u8>,
        timestamp_ms: u64,
    }

    struct SpaceCreated has copy, drop {
        space_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
    }

    struct EntryAppended has copy, drop {
        space_id: 0x2::object::ID,
        index: u64,
        agent: 0x1::string::String,
        blob_id: 0x1::string::String,
    }

    struct PassGranted has copy, drop {
        space_id: 0x2::object::ID,
        grantee: address,
        expires_ms: u64,
    }

    struct PassRevoked has copy, drop {
        space_id: 0x2::object::ID,
        grantee: address,
    }

    public fun length(arg0: &Space) : u64 {
        0x2::table_vec::length<Entry>(&arg0.entries)
    }

    public fun append(arg0: &OwnerCap, arg1: &mut Space, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<u8>, arg5: &0x2::clock::Clock) {
        assert_owner(arg0, arg1);
        assert!(0x1::string::length(&arg2) > 0, 5);
        assert!(0x1::string::length(&arg3) >= 32 && 0x1::string::length(&arg3) <= 64, 3);
        assert!(0x1::vector::length<u8>(&arg4) == 32, 4);
        let v0 = Entry{
            agent        : arg2,
            blob_id      : arg3,
            sha256       : arg4,
            timestamp_ms : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::table_vec::push_back<Entry>(&mut arg1.entries, v0);
        let v1 = EntryAppended{
            space_id : 0x2::object::id<Space>(arg1),
            index    : 0x2::table_vec::length<Entry>(&arg1.entries),
            agent    : arg2,
            blob_id  : arg3,
        };
        0x2::event::emit<EntryAppended>(v1);
    }

    fun assert_owner(arg0: &OwnerCap, arg1: &Space) {
        assert!(arg0.space_id == 0x2::object::id<Space>(arg1), 1);
    }

    public fun cap_space_id(arg0: &OwnerCap) : 0x2::object::ID {
        arg0.space_id
    }

    public fun create(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) : OwnerCap {
        let v0 = Space{
            id      : 0x2::object::new(arg1),
            name    : arg0,
            entries : 0x2::table_vec::empty<Entry>(arg1),
            passes  : 0x2::table::new<address, u64>(arg1),
        };
        let v1 = 0x2::object::id<Space>(&v0);
        let v2 = OwnerCap{
            id       : 0x2::object::new(arg1),
            space_id : v1,
        };
        let v3 = SpaceCreated{
            space_id : v1,
            cap_id   : 0x2::object::id<OwnerCap>(&v2),
        };
        0x2::event::emit<SpaceCreated>(v3);
        0x2::transfer::share_object<Space>(v0);
        v2
    }

    entry fun create_space(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create(arg0, arg1);
        0x2::transfer::transfer<OwnerCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun entry_agent(arg0: &Entry) : 0x1::string::String {
        arg0.agent
    }

    public fun entry_at(arg0: &Space, arg1: u64) : Entry {
        *0x2::table_vec::borrow<Entry>(&arg0.entries, arg1)
    }

    public fun entry_blob_id(arg0: &Entry) : 0x1::string::String {
        arg0.blob_id
    }

    public fun grant_pass(arg0: &OwnerCap, arg1: &mut Space, arg2: address, arg3: u64) {
        assert_owner(arg0, arg1);
        if (0x2::table::contains<address, u64>(&arg1.passes, arg2)) {
            *0x2::table::borrow_mut<address, u64>(&mut arg1.passes, arg2) = arg3;
        } else {
            0x2::table::add<address, u64>(&mut arg1.passes, arg2, arg3);
        };
        let v0 = PassGranted{
            space_id   : 0x2::object::id<Space>(arg1),
            grantee    : arg2,
            expires_ms : arg3,
        };
        0x2::event::emit<PassGranted>(v0);
    }

    public fun has_pass(arg0: &Space, arg1: address, arg2: &0x2::clock::Clock) : bool {
        0x2::table::contains<address, u64>(&arg0.passes, arg1) && *0x2::table::borrow<address, u64>(&arg0.passes, arg1) > 0x2::clock::timestamp_ms(arg2)
    }

    fun prefixed(arg0: &Space, arg1: &vector<u8>) : bool {
        let v0 = 0x2::object::id<Space>(arg0);
        let v1 = 0x2::object::id_to_bytes(&v0);
        if (0x1::vector::length<u8>(arg1) < 0x1::vector::length<u8>(&v1)) {
            return false
        };
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(&v1)) {
            if (*0x1::vector::borrow<u8>(&v1, v2) != *0x1::vector::borrow<u8>(arg1, v2)) {
                return false
            };
            v2 = v2 + 1;
        };
        true
    }

    public fun revoke_pass(arg0: &OwnerCap, arg1: &mut Space, arg2: address) {
        assert_owner(arg0, arg1);
        if (0x2::table::contains<address, u64>(&arg1.passes, arg2)) {
            0x2::table::remove<address, u64>(&mut arg1.passes, arg2);
        };
        let v0 = PassRevoked{
            space_id : 0x2::object::id<Space>(arg1),
            grantee  : arg2,
        };
        0x2::event::emit<PassRevoked>(v0);
    }

    entry fun seal_approve_owner(arg0: vector<u8>, arg1: &OwnerCap, arg2: &Space) {
        assert!(arg1.space_id == 0x2::object::id<Space>(arg2) && prefixed(arg2, &arg0), 2);
    }

    entry fun seal_approve_pass(arg0: vector<u8>, arg1: &Space, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(prefixed(arg1, &arg0) && has_pass(arg1, 0x2::tx_context::sender(arg3), arg2), 2);
    }

    // decompiled from Move bytecode v7
}

