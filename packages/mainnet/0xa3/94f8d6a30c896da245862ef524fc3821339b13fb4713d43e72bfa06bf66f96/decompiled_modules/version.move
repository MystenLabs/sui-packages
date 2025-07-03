module 0xa394f8d6a30c896da245862ef524fc3821339b13fb4713d43e72bfa06bf66f96::version {
    struct Version has store {
        major_version: u64,
        minor_version: u64,
    }

    public fun assert_current_version(arg0: &Version) {
        assert!(is_supported_major_version(arg0) && is_supported_minor_version(arg0), 69);
    }

    public(friend) fun initialize() : Version {
        Version{
            major_version : 0xa394f8d6a30c896da245862ef524fc3821339b13fb4713d43e72bfa06bf66f96::current_version::current_major_version(),
            minor_version : 0xa394f8d6a30c896da245862ef524fc3821339b13fb4713d43e72bfa06bf66f96::current_version::current_minor_version(),
        }
    }

    public fun is_supported_major_version(arg0: &Version) : bool {
        arg0.major_version == 0xa394f8d6a30c896da245862ef524fc3821339b13fb4713d43e72bfa06bf66f96::current_version::current_major_version()
    }

    public fun is_supported_minor_version(arg0: &Version) : bool {
        arg0.minor_version > 0xa394f8d6a30c896da245862ef524fc3821339b13fb4713d43e72bfa06bf66f96::current_version::minimum_supported_minor_version()
    }

    public(friend) fun upgrade_major(arg0: &mut Version) {
        arg0.major_version = 0xa394f8d6a30c896da245862ef524fc3821339b13fb4713d43e72bfa06bf66f96::current_version::current_major_version() + 1;
    }

    public(friend) fun upgrade_minor(arg0: &mut Version) {
        arg0.minor_version = 0xa394f8d6a30c896da245862ef524fc3821339b13fb4713d43e72bfa06bf66f96::current_version::current_minor_version() + 1;
    }

    public fun value_major(arg0: &Version) : u64 {
        arg0.major_version
    }

    public fun value_minor(arg0: &Version) : u64 {
        arg0.minor_version
    }

    // decompiled from Move bytecode v6
}

