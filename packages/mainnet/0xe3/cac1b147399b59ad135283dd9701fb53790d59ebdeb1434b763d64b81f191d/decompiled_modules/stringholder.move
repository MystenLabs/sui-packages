module 0xe3cac1b147399b59ad135283dd9701fb53790d59ebdeb1434b763d64b81f191d::stringholder {
    struct Counter has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
    }

    public fun create(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Counter{
            id   : 0x2::object::new(arg0),
            name : 0x1::string::utf8(b"Hello"),
        };
        0x2::transfer::share_object<Counter>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        create(arg0);
    }

    public fun set_value(arg0: &mut Counter, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        arg0.name = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

