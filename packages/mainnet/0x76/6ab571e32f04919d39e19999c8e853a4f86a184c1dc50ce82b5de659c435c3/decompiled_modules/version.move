module 0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::version {
    struct VersionRegistry has store, key {
        id: 0x2::object::UID,
        current_version: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun check_version(arg0: &VersionRegistry) {
        assert!(arg0.current_version == 1, 0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::error::eversion_mismatch());
    }

    public fun get_version(arg0: &VersionRegistry) : u64 {
        arg0.current_version
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = VersionRegistry{
            id              : 0x2::object::new(arg0),
            current_version : 1,
        };
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<VersionRegistry>(v0);
    }

    public fun update_version(arg0: &AdminCap, arg1: &mut VersionRegistry, arg2: u64) {
        assert!(arg2 > 0, 0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::error::einvalid_version());
        arg1.current_version = arg2;
    }

    // decompiled from Move bytecode v6
}

