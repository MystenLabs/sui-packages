module 0x1b4f035dea5174306b438f63e6d3a9e60a33eea28bb40d9f5ad01dea42037da1::version {
    struct Version has store, key {
        id: 0x2::object::UID,
        value: u64,
    }

    public fun assert_current_version(arg0: &Version) {
        assert!(is_current_version(arg0), 9223372225833336833);
    }

    public fun create_version(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Version{
            id    : 0x2::object::new(arg0),
            value : 0x1b4f035dea5174306b438f63e6d3a9e60a33eea28bb40d9f5ad01dea42037da1::current_version::current_version(),
        };
        0x2::transfer::share_object<Version>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        create_version(arg0);
    }

    public fun is_current_version(arg0: &Version) : bool {
        arg0.value == 0x1b4f035dea5174306b438f63e6d3a9e60a33eea28bb40d9f5ad01dea42037da1::current_version::current_version()
    }

    public fun upgrade(arg0: &mut Version, arg1: &0x58e1e537fb40c9e8fba75714cd06338ae43a86d1b00a29272dcbcd2ac5742dd1::admin::AdminCap) {
        assert!(arg0.value == 0x1b4f035dea5174306b438f63e6d3a9e60a33eea28bb40d9f5ad01dea42037da1::current_version::current_version() - 1, 9223372187178631169);
        arg0.value = 0x1b4f035dea5174306b438f63e6d3a9e60a33eea28bb40d9f5ad01dea42037da1::current_version::current_version();
    }

    public fun value(arg0: &Version) : u64 {
        arg0.value
    }

    // decompiled from Move bytecode v6
}

