module 0xd8e1ecd9f3fd024c1a29db4d14fe24faa18463a928287ec0d3796cace61edbcf::version {
    struct Version has store, key {
        id: 0x2::object::UID,
        value: u64,
    }

    public fun assert_current_version(arg0: &Version) {
        assert!(is_current_version(arg0), 9223372204358500353);
    }

    public(friend) fun create_version(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Version{
            id    : 0x2::object::new(arg0),
            value : 0xd8e1ecd9f3fd024c1a29db4d14fe24faa18463a928287ec0d3796cace61edbcf::current_version::current_version(),
        };
        0x2::transfer::share_object<Version>(v0);
    }

    public fun is_current_version(arg0: &Version) : bool {
        arg0.value == 0xd8e1ecd9f3fd024c1a29db4d14fe24faa18463a928287ec0d3796cace61edbcf::current_version::current_version()
    }

    public fun upgrade(arg0: &mut Version, arg1: &0x7182b166c2461a4eda64f06b95dd69326bc9001656cc413b255eaa845ada8767::admin::AdminCap) {
        assert!(arg0.value == 0xd8e1ecd9f3fd024c1a29db4d14fe24faa18463a928287ec0d3796cace61edbcf::current_version::current_version() - 1, 9223372165703794689);
        arg0.value = 0xd8e1ecd9f3fd024c1a29db4d14fe24faa18463a928287ec0d3796cace61edbcf::current_version::current_version();
    }

    public fun value(arg0: &Version) : u64 {
        arg0.value
    }

    // decompiled from Move bytecode v6
}

