module 0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::version {
    struct Version has store, key {
        id: 0x2::object::UID,
        major_version: u64,
        minor_version: u64,
    }

    struct VersionCap has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : Version {
        Version{
            id            : 0x2::object::new(arg0),
            major_version : 0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::current_version::current_major_version(),
            minor_version : 0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::current_version::current_minor_version(),
        }
    }

    public fun assert_v(arg0: &Version) {
        assert!(is_supported_major_version(arg0) && is_supported_minor_version(arg0), 69);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = VersionCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<VersionCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun is_supported_major_version(arg0: &Version) : bool {
        arg0.major_version == 0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::current_version::current_major_version()
    }

    public fun is_supported_minor_version(arg0: &Version) : bool {
        0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::current_version::current_minor_version() >= arg0.minor_version
    }

    public fun set_version(arg0: &mut Version, arg1: &VersionCap, arg2: u64, arg3: u64) {
        arg0.major_version = arg2;
        arg0.minor_version = arg3;
    }

    public fun upgrade_major(arg0: &mut Version, arg1: &VersionCap) {
        arg0.major_version = 0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::current_version::current_major_version() + 1;
    }

    public fun upgrade_minor(arg0: &mut Version, arg1: u64, arg2: &VersionCap) {
        arg0.minor_version = arg1;
    }

    public fun value_major(arg0: &Version) : u64 {
        arg0.major_version
    }

    public fun value_minor(arg0: &Version) : u64 {
        arg0.minor_version
    }

    // decompiled from Move bytecode v6
}

