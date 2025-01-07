module 0x25b431ba77c6f3d75103a8a64cbfa70729bf5e0a9696f116d88fc98d09fb7e0f::test_vec {
    struct Data has store, key {
        id: 0x2::object::UID,
        contents: vector<0x1::string::String>,
    }

    public fun append_string_test(arg0: &mut Data, arg1: vector<0x1::string::String>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.contents = arg1;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Data{
            id       : 0x2::object::new(arg0),
            contents : 0x1::vector::empty<0x1::string::String>(),
        };
        0x2::transfer::public_share_object<Data>(v0);
    }

    // decompiled from Move bytecode v6
}

