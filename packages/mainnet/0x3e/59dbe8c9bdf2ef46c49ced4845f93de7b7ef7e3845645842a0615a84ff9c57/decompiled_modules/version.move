module 0x3e59dbe8c9bdf2ef46c49ced4845f93de7b7ef7e3845645842a0615a84ff9c57::version {
    struct Version has store, key {
        id: 0x2::object::UID,
        value: u64,
    }

    struct VersionAdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun assert_current_version(arg0: &Version) {
        assert!(arg0.value == 1, 403);
    }

    public fun get_version(arg0: &Version) : u64 {
        arg0.value
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Version{
            id    : 0x2::object::new(arg0),
            value : 1,
        };
        let v1 = VersionAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<Version>(v0);
        0x2::transfer::transfer<VersionAdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun migrate(arg0: &VersionAdminCap, arg1: &mut Version, arg2: u64) {
        assert!(arg2 > arg1.value, 403);
        arg1.value = arg2;
    }

    // decompiled from Move bytecode v6
}

