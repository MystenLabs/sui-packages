module 0xa515122dd351f8acf9e4a307fc713e7c21b076d0192c49d3674684a583354a85::version {
    struct Version has store, key {
        id: 0x2::object::UID,
        major_version: u64,
        minor_version: u64,
    }

    struct VersionCap has store, key {
        id: 0x2::object::UID,
    }

    public fun assert_current_version(arg0: &Version) {
        assert!(is_supported_major_version(arg0) && is_supported_minor_version(arg0), 69);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Version{
            id            : 0x2::object::new(arg0),
            major_version : 0xa515122dd351f8acf9e4a307fc713e7c21b076d0192c49d3674684a583354a85::current_version::current_major_version(),
            minor_version : 0xa515122dd351f8acf9e4a307fc713e7c21b076d0192c49d3674684a583354a85::current_version::current_minor_version(),
        };
        let v1 = VersionCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<Version>(v0);
        0x2::transfer::transfer<VersionCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_supported_major_version(arg0: &Version) : bool {
        arg0.major_version == 0xa515122dd351f8acf9e4a307fc713e7c21b076d0192c49d3674684a583354a85::current_version::current_major_version()
    }

    public fun is_supported_minor_version(arg0: &Version) : bool {
        arg0.minor_version > 0xa515122dd351f8acf9e4a307fc713e7c21b076d0192c49d3674684a583354a85::current_version::minimum_supported_minor_version()
    }

    public fun upgrade_major(arg0: &mut Version, arg1: &VersionCap) {
        arg0.major_version = 0xa515122dd351f8acf9e4a307fc713e7c21b076d0192c49d3674684a583354a85::current_version::current_major_version() + 1;
    }

    public fun upgrade_minor(arg0: &mut Version, arg1: &VersionCap) {
        arg0.minor_version = 0xa515122dd351f8acf9e4a307fc713e7c21b076d0192c49d3674684a583354a85::current_version::current_minor_version() + 1;
    }

    public fun value_major(arg0: &Version) : u64 {
        arg0.major_version
    }

    public fun value_minor(arg0: &Version) : u64 {
        arg0.minor_version
    }

    // decompiled from Move bytecode v6
}

