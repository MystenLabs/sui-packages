module 0xe2fc77f415d70dc40b9160cc6ebf8b6a87d89ac3ad5425e88acd11f7b222dcc4::version {
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

