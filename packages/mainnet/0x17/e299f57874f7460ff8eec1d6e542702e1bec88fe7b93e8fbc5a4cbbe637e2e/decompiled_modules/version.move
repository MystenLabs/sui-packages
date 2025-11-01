module 0x17e299f57874f7460ff8eec1d6e542702e1bec88fe7b93e8fbc5a4cbbe637e2e::version {
    struct Version has store, key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct VersionCap has store, key {
        id: 0x2::object::UID,
    }

    public fun assert_supported_version(arg0: &Version) {
        assert!(1 >= arg0.version, 100);
    }

    public(friend) fun create(arg0: &mut 0x2::tx_context::TxContext) : Version {
        Version{
            id      : 0x2::object::new(arg0),
            version : 1,
        }
    }

    public fun current_version() : u64 {
        1
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = VersionCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<VersionCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public(friend) fun set_version(arg0: &mut Version, arg1: &VersionCap, arg2: u64) {
        assert!(arg2 > arg0.version, 101);
        arg0.version = arg2;
    }

    public(friend) fun upgrade(arg0: &mut Version, arg1: &VersionCap) {
        arg0.version = arg0.version + 1;
    }

    public fun value(arg0: &Version) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v6
}

