module 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::version {
    struct Version has store, key {
        id: 0x2::object::UID,
        allowed_versions: 0x2::vec_set::VecSet<u64>,
    }

    public fun add_version(arg0: &mut Version, arg1: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::admin::AdminCap, arg2: u64) {
        if (!0x2::vec_set::contains<u64>(&arg0.allowed_versions, &arg2)) {
            0x2::vec_set::insert<u64>(&mut arg0.allowed_versions, arg2);
        };
    }

    public fun check_version(arg0: &Version) {
        let v0 = 1;
        if (!0x2::vec_set::contains<u64>(&arg0.allowed_versions, &v0)) {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_wrong_version();
        };
    }

    public fun current() : u64 {
        1
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::vec_set::empty<u64>();
        0x2::vec_set::insert<u64>(&mut v0, 1);
        let v1 = Version{
            id               : 0x2::object::new(arg0),
            allowed_versions : v0,
        };
        0x2::transfer::share_object<Version>(v1);
    }

    public fun remove_version(arg0: &mut Version, arg1: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::admin::AdminCap, arg2: u64) {
        if (0x2::vec_set::contains<u64>(&arg0.allowed_versions, &arg2)) {
            0x2::vec_set::remove<u64>(&mut arg0.allowed_versions, &arg2);
        };
    }

    // decompiled from Move bytecode v6
}

