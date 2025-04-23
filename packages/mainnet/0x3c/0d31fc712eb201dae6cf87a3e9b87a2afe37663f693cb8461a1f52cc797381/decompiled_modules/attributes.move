module 0x3c0d31fc712eb201dae6cf87a3e9b87a2afe37663f693cb8461a1f52cc797381::attributes {
    struct Attributes has store, key {
        id: 0x2::object::UID,
        fields: 0x3c0d31fc712eb201dae6cf87a3e9b87a2afe37663f693cb8461a1f52cc797381::trait::VecMap<0x1::string::String, 0x1::string::String>,
    }

    public(friend) fun admin_new(arg0: vector<0x1::string::String>, arg1: vector<0x1::string::String>, arg2: &mut 0x2::tx_context::TxContext) : Attributes {
        Attributes{
            id     : 0x2::object::new(arg2),
            fields : 0x3c0d31fc712eb201dae6cf87a3e9b87a2afe37663f693cb8461a1f52cc797381::trait::from_trait_types_values<0x1::string::String, 0x1::string::String>(arg0, arg1),
        }
    }

    // decompiled from Move bytecode v6
}

