module 0xcfa1f488b5c7067cb4925cb7bd62757ca93a6b8d38382f69d428475a72cde7c0::version {
    struct Version has store, key {
        id: 0x2::object::UID,
        major_version: u64,
        minor_version: u64,
    }

    struct VersionCap has store, key {
        id: 0x2::object::UID,
    }

    public fun assert_supported_version(arg0: &Version) {
        assert!(is_supported_major_version(arg0) && is_supported_minor_version(arg0), 0xcfa1f488b5c7067cb4925cb7bd62757ca93a6b8d38382f69d428475a72cde7c0::error::version_not_supported());
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Version{
            id            : 0x2::object::new(arg0),
            major_version : 0xcfa1f488b5c7067cb4925cb7bd62757ca93a6b8d38382f69d428475a72cde7c0::current_version::current_major_version(),
            minor_version : 0xcfa1f488b5c7067cb4925cb7bd62757ca93a6b8d38382f69d428475a72cde7c0::current_version::current_minor_version(),
        };
        let v1 = VersionCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<Version>(v0);
        0x2::transfer::transfer<VersionCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_supported_major_version(arg0: &Version) : bool {
        arg0.major_version == 0xcfa1f488b5c7067cb4925cb7bd62757ca93a6b8d38382f69d428475a72cde7c0::current_version::current_major_version()
    }

    public fun is_supported_minor_version(arg0: &Version) : bool {
        0xcfa1f488b5c7067cb4925cb7bd62757ca93a6b8d38382f69d428475a72cde7c0::current_version::current_minor_version() >= arg0.minor_version
    }

    public fun set_version(arg0: &mut Version, arg1: &VersionCap, arg2: u64, arg3: u64) {
        arg0.major_version = arg2;
        arg0.minor_version = arg3;
    }

    public fun upgrade_major(arg0: &mut Version, arg1: &VersionCap) {
        arg0.major_version = 0xcfa1f488b5c7067cb4925cb7bd62757ca93a6b8d38382f69d428475a72cde7c0::current_version::current_major_version() + 1;
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

