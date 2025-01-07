module 0x72d4735b2387fb48520bba873f8132a658343c9f4612bb4684c3f99ddda3f824::attributes {
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

