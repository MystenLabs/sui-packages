module 0x8d5e0d608b60e3d928f36f4da75d2f50e0ae4446fc70c6346470d0edcb84f005::version {
    struct Version has store, key {
        id: 0x2::object::UID,
        value: u64,
    }

    struct VersionCap has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun assert_current_version(arg0: &Version) {
        assert!(is_current_version(arg0), 1);
    }

    public fun block(arg0: &mut Version, arg1: &VersionCap) {
        arg0.value = 0;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Version{
            id    : 0x2::object::new(arg0),
            value : 0x8d5e0d608b60e3d928f36f4da75d2f50e0ae4446fc70c6346470d0edcb84f005::current_version::current_version(),
        };
        let v1 = VersionCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<Version>(v0);
        0x2::transfer::transfer<VersionCap>(v1, 0x2::tx_context::sender(arg0));
    }

    fun is_current_version(arg0: &Version) : bool {
        arg0.value == 0x8d5e0d608b60e3d928f36f4da75d2f50e0ae4446fc70c6346470d0edcb84f005::current_version::current_version()
    }

    public fun update(arg0: &mut Version, arg1: &VersionCap) {
        assert!(arg0.value < 0x8d5e0d608b60e3d928f36f4da75d2f50e0ae4446fc70c6346470d0edcb84f005::current_version::current_version(), 1);
        arg0.value = 0x8d5e0d608b60e3d928f36f4da75d2f50e0ae4446fc70c6346470d0edcb84f005::current_version::current_version();
    }

    public fun value(arg0: &Version) : u64 {
        arg0.value
    }

    // decompiled from Move bytecode v6
}

