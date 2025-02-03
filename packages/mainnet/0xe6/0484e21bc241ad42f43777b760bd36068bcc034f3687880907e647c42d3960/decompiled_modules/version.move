module 0xe60484e21bc241ad42f43777b760bd36068bcc034f3687880907e647c42d3960::version {
    struct Version has store, key {
        id: 0x2::object::UID,
        value: u64,
    }

    struct VersionCap has store, key {
        id: 0x2::object::UID,
    }

    public fun assert_current_version(arg0: &Version) {
        assert!(is_current_version(arg0), 0xe60484e21bc241ad42f43777b760bd36068bcc034f3687880907e647c42d3960::error::version_mismatch_error());
    }

    public fun block(arg0: &mut Version, arg1: &VersionCap) {
        arg0.value = 0;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Version{
            id    : 0x2::object::new(arg0),
            value : 0xe60484e21bc241ad42f43777b760bd36068bcc034f3687880907e647c42d3960::current_version::current_version(),
        };
        let v1 = VersionCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<Version>(v0);
        0x2::transfer::transfer<VersionCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_current_version(arg0: &Version) : bool {
        arg0.value == 0xe60484e21bc241ad42f43777b760bd36068bcc034f3687880907e647c42d3960::current_version::current_version()
    }

    public fun update(arg0: &mut Version, arg1: &VersionCap) {
        assert!(arg0.value < 0xe60484e21bc241ad42f43777b760bd36068bcc034f3687880907e647c42d3960::current_version::current_version(), 0xe60484e21bc241ad42f43777b760bd36068bcc034f3687880907e647c42d3960::error::version_mismatch_error());
        arg0.value = 0xe60484e21bc241ad42f43777b760bd36068bcc034f3687880907e647c42d3960::current_version::current_version();
    }

    public fun value(arg0: &Version) : u64 {
        arg0.value
    }

    // decompiled from Move bytecode v6
}

