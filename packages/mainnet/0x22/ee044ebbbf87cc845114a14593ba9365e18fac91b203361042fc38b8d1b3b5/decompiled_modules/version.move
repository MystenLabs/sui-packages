module 0x3c3d68b045e8fa92c653e86c3364dfad6ffdfd19777b3d31bfb501a24a902afd::version {
    struct Version has store, key {
        id: 0x2::object::UID,
        version: u64,
    }

    entry fun admin_freeze(arg0: &0x3c3d68b045e8fa92c653e86c3364dfad6ffdfd19777b3d31bfb501a24a902afd::role::AdminCap, arg1: &mut Version) {
        arg1.version = 0;
    }

    public fun get_version(arg0: &Version) : u64 {
        arg0.version
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Version{
            id      : 0x2::object::new(arg0),
            version : 2,
        };
        0x2::transfer::share_object<Version>(v0);
    }

    entry fun migrate(arg0: &0x3c3d68b045e8fa92c653e86c3364dfad6ffdfd19777b3d31bfb501a24a902afd::role::AdminCap, arg1: &mut Version, arg2: u64) {
        assert!(arg2 > arg1.version, 1004);
        arg1.version = arg2;
    }

    public fun validate_version(arg0: &Version) {
        assert!(2 == arg0.version, 1004);
    }

    // decompiled from Move bytecode v6
}

