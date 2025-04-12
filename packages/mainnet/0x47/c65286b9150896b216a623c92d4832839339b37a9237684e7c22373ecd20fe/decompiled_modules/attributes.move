module 0x47c65286b9150896b216a623c92d4832839339b37a9237684e7c22373ecd20fe::attributes {
    struct Attributes has store, key {
        id: 0x2::object::UID,
        fields: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    public(friend) fun admin_new(arg0: vector<0x1::string::String>, arg1: vector<0x1::string::String>, arg2: &mut 0x2::tx_context::TxContext) : Attributes {
        Attributes{
            id     : 0x2::object::new(arg2),
            fields : 0x2::vec_map::from_keys_values<0x1::string::String, 0x1::string::String>(arg0, arg1),
        }
    }

    // decompiled from Move bytecode v6
}

