module 0x9b256004aad11b0dc4aa15086aa756a8bc6b897633de24ee49a1bf694a666999::sentio_test_2 {
    struct Counter has key {
        id: 0x2::object::UID,
        count: u64,
    }

    public fun add(arg0: &mut Counter) {
        arg0.count = arg0.count + 1;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Counter{
            id    : 0x2::object::new(arg0),
            count : 0,
        };
        0x2::transfer::share_object<Counter>(v0);
    }

    public fun sub(arg0: &mut Counter) {
        arg0.count = arg0.count - 1;
    }

    // decompiled from Move bytecode v6
}

