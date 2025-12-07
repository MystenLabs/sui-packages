module 0x68ca6013f2bf3f0744acb5222206048c4a5cd86374c508e74a7b102c244dfdc8::attributes {
    struct Attributes has store, key {
        id: 0x2::object::UID,
        fields: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    public(friend) fun new(arg0: vector<0x1::string::String>, arg1: vector<0x1::string::String>, arg2: &mut 0x2::tx_context::TxContext) : Attributes {
        Attributes{
            id     : 0x2::object::new(arg2),
            fields : 0x2::vec_map::from_keys_values<0x1::string::String, 0x1::string::String>(arg0, arg1),
        }
    }

    public(friend) fun destroy(arg0: Attributes) {
        let Attributes {
            id     : v0,
            fields : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    // decompiled from Move bytecode v6
}

