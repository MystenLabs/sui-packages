module 0x7304347f70c18292d648d1d1f1cfd271179eb02010ade6a1dadf95c22ff4d6c1::data_anchor {
    struct DATA_ANCHOR has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        admin: address,
    }

    struct Registry has store, key {
        id: 0x2::object::UID,
        last_yyyymmdd: u64,
        total_snapshots: u64,
    }

    struct Snapshot has store, key {
        id: 0x2::object::UID,
        yyyymmdd: u64,
        schema_version: u64,
        dataset_hash: vector<u8>,
        merkle_root: vector<u8>,
        row_count: u64,
        scope_flags: vector<u8>,
        anchored_at_ms: u64,
    }

    struct SnapshotAnchored has copy, drop {
        registry_id: 0x2::object::ID,
        snapshot_id: 0x2::object::ID,
        yyyymmdd: u64,
        schema_version: u64,
        dataset_hash: vector<u8>,
        merkle_root: vector<u8>,
        row_count: u64,
        scope_flags: vector<u8>,
        anchored_at_ms: u64,
    }

    entry fun anchor_snapshot(arg0: &mut Registry, arg1: &AdminCap, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: vector<u8>, arg6: u64, arg7: vector<u8>, arg8: &mut 0x2::tx_context::TxContext) {
        assert_is_admin(arg1.admin, 0x2::tx_context::sender(arg8));
        assert_hash_length_32(&arg4);
        assert_hash_length_32(&arg5);
        let v0 = 0x2::tx_context::epoch_timestamp_ms(arg8);
        let v1 = Snapshot{
            id             : 0x2::object::new(arg8),
            yyyymmdd       : arg2,
            schema_version : arg3,
            dataset_hash   : arg4,
            merkle_root    : arg5,
            row_count      : arg6,
            scope_flags    : arg7,
            anchored_at_ms : v0,
        };
        if (arg2 > arg0.last_yyyymmdd) {
            arg0.last_yyyymmdd = arg2;
        };
        arg0.total_snapshots = arg0.total_snapshots + 1;
        let v2 = SnapshotAnchored{
            registry_id    : 0x2::object::id<Registry>(arg0),
            snapshot_id    : 0x2::object::id<Snapshot>(&v1),
            yyyymmdd       : arg2,
            schema_version : arg3,
            dataset_hash   : clone_bytes(&arg4),
            merkle_root    : clone_bytes(&arg5),
            row_count      : arg6,
            scope_flags    : clone_bytes(&arg7),
            anchored_at_ms : v0,
        };
        0x2::event::emit<SnapshotAnchored>(v2);
        0x2::transfer::share_object<Snapshot>(v1);
    }

    fun assert_hash_length_32(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) == 32, 2);
    }

    fun assert_is_admin(arg0: address, arg1: address) {
        assert!(arg0 == arg1, 1);
    }

    fun clone_bytes(arg0: &vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(arg0)) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, v1));
            v1 = v1 + 1;
        };
        v0
    }

    fun init(arg0: DATA_ANCHOR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = AdminCap{
            id    : 0x2::object::new(arg1),
            admin : v0,
        };
        0x2::transfer::transfer<AdminCap>(v1, v0);
        let v2 = Registry{
            id              : 0x2::object::new(arg1),
            last_yyyymmdd   : 0,
            total_snapshots : 0,
        };
        0x2::transfer::share_object<Registry>(v2);
    }

    // decompiled from Move bytecode v7
}

