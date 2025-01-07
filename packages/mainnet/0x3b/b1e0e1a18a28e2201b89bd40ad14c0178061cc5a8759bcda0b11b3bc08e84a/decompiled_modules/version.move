module 0x3bb1e0e1a18a28e2201b89bd40ad14c0178061cc5a8759bcda0b11b3bc08e84a::version {
    struct Version has store, key {
        id: 0x2::object::UID,
        value: u64,
    }

    public fun version(arg0: &Version) : u64 {
        arg0.value
    }

    public fun assert_current_version(arg0: &Version) {
        assert!(is_current_version(arg0), 405);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Version{
            id    : 0x2::object::new(arg0),
            value : 0,
        };
        0x2::transfer::share_object<Version>(v0);
    }

    public fun is_current_version(arg0: &Version) : bool {
        arg0.value == 0
    }

    public(friend) fun upgrade(arg0: &mut Version) {
        arg0.value = arg0.value + 1;
    }

    // decompiled from Move bytecode v6
}

