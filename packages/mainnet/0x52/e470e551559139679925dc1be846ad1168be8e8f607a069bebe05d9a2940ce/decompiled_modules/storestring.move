module 0x52e470e551559139679925dc1be846ad1168be8e8f607a069bebe05d9a2940ce::storestring {
    struct StringStore has key {
        id: 0x2::object::UID,
        value: 0x1::string::String,
        creator: address,
    }

    public fun create_string_store(arg0: 0x1::string::String, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::string::length(&arg0) <= 32768, 1);
        let v0 = StringStore{
            id      : 0x2::object::new(arg2),
            value   : arg0,
            creator : 0x2::tx_context::sender(arg2),
        };
        0x2::transfer::transfer<StringStore>(v0, arg1);
    }

    public fun creator(arg0: &StringStore) : address {
        arg0.creator
    }

    public fun value(arg0: &StringStore) : &0x1::string::String {
        &arg0.value
    }

    // decompiled from Move bytecode v7
}

