module 0x28178af32eeebf5eacd3e0fc162c4e646702b8f1e28e5c9c7e60d88f5458ddc2::versioning {
    struct ProtocolVersion has key {
        id: 0x2::object::UID,
        version: u64,
    }

    public fun active(arg0: &ProtocolVersion) : u64 {
        arg0.version
    }

    public(friend) fun assert_current(arg0: &ProtocolVersion, arg1: &0x2::object::UID) {
        assert!(2 == arg0.version, 1);
        assert!(stored(arg1) == 2, 0);
    }

    public fun current() : u64 {
        2
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ProtocolVersion{
            id      : 0x2::object::new(arg0),
            version : 2,
        };
        0x2::transfer::share_object<ProtocolVersion>(v0);
    }

    public(friend) fun is_current(arg0: &0x2::object::UID) : bool {
        stored(arg0) == 2
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

