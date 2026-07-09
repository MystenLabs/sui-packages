module 0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::versioning {
    struct ProtocolVersion has key {
        id: 0x2::object::UID,
        version: u64,
        migration_finalized: bool,
    }

    public fun active(arg0: &ProtocolVersion) : u64 {
        arg0.version
    }

    public(friend) fun assert_current(arg0: &ProtocolVersion, arg1: &0x2::object::UID) {
        assert!(2 == arg0.version, 1);
        assert!(stored(arg1) == 2, 0);
    }

    public(friend) fun assert_migration_open(arg0: &ProtocolVersion) {
        assert!(!arg0.migration_finalized, 3);
    }

    public fun current() : u64 {
        2
    }

    public(friend) fun finalize_migration(arg0: &mut ProtocolVersion) {
        assert!(!arg0.migration_finalized, 4);
        arg0.migration_finalized = true;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ProtocolVersion{
            id                  : 0x2::object::new(arg0),
            version             : 2,
            migration_finalized : false,
        };
        0x2::transfer::share_object<ProtocolVersion>(v0);
    }

    public(friend) fun is_current(arg0: &0x2::object::UID) : bool {
        stored(arg0) == 2
    }

    public fun is_migration_finalized(arg0: &ProtocolVersion) : bool {
        arg0.migration_finalized
    }

    fun set(arg0: &mut 0x2::object::UID, arg1: u64) {
        if (0x2::dynamic_field::exists_with_type<vector<u8>, u64>(arg0, b"version")) {
            *0x2::dynamic_field::borrow_mut<vector<u8>, u64>(arg0, b"version") = arg1;
        } else {
            0x2::dynamic_field::add<vector<u8>, u64>(arg0, b"version", arg1);
        };
    }

    public(friend) fun stamp(arg0: &mut 0x2::object::UID) {
        set(arg0, 2);
    }

    public(friend) fun stored(arg0: &0x2::object::UID) : u64 {
        if (0x2::dynamic_field::exists_with_type<vector<u8>, u64>(arg0, b"version")) {
            *0x2::dynamic_field::borrow<vector<u8>, u64>(arg0, b"version")
        } else {
            1
        }
    }

    public(friend) fun upgrade_protocol(arg0: &mut ProtocolVersion) {
        assert!(arg0.version < 2, 2);
        arg0.version = 2;
    }

    public fun version_df_key() : vector<u8> {
        b"version"
    }

    // decompiled from Move bytecode v7
}

