module 0x7fe41a98f3de9885d62b96aa8046bf65f22fe67fcaf53c6b2a305c9cb1b6c90f::version {
    struct Version has store, key {
        id: 0x2::object::UID,
        value: u64,
    }

    struct VersionCap has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun assert_current_version(arg0: &Version) {
        assert!(is_current_version(arg0), 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::error::version_mismatch_error());
    }

    public fun block(arg0: &mut Version, arg1: &VersionCap) {
        arg0.value = 0;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Version{
            id    : 0x2::object::new(arg0),
            value : 0x7fe41a98f3de9885d62b96aa8046bf65f22fe67fcaf53c6b2a305c9cb1b6c90f::current_version::current_version(),
        };
        let v1 = VersionCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<Version>(v0);
        0x2::transfer::transfer<VersionCap>(v1, 0x2::tx_context::sender(arg0));
    }

    fun is_current_version(arg0: &Version) : bool {
        arg0.value == 0x7fe41a98f3de9885d62b96aa8046bf65f22fe67fcaf53c6b2a305c9cb1b6c90f::current_version::current_version()
    }

    public fun update(arg0: &mut Version, arg1: &VersionCap) {
        assert!(arg0.value < 0x7fe41a98f3de9885d62b96aa8046bf65f22fe67fcaf53c6b2a305c9cb1b6c90f::current_version::current_version(), 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::error::version_mismatch_error());
        arg0.value = 0x7fe41a98f3de9885d62b96aa8046bf65f22fe67fcaf53c6b2a305c9cb1b6c90f::current_version::current_version();
    }

    public fun value(arg0: &Version) : u64 {
        arg0.value
    }

    // decompiled from Move bytecode v6
}

