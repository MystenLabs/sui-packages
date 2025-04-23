module 0x88f56c1f602a29641698e8d8a5ebbdf544e70558fac3474d01adf8fa96a8aa16::attributes {
    struct Attributes has store, key {
        id: 0x2::object::UID,
        fields: 0x88f56c1f602a29641698e8d8a5ebbdf544e70558fac3474d01adf8fa96a8aa16::trait::VecMap<0x1::string::String, 0x1::string::String>,
    }

    public(friend) fun admin_new(arg0: vector<0x1::string::String>, arg1: vector<0x1::string::String>, arg2: &mut 0x2::tx_context::TxContext) : Attributes {
        Attributes{
            id     : 0x2::object::new(arg2),
            fields : 0x88f56c1f602a29641698e8d8a5ebbdf544e70558fac3474d01adf8fa96a8aa16::trait::from_trait_types_values<0x1::string::String, 0x1::string::String>(arg0, arg1),
        }
    }

    // decompiled from Move bytecode v6
}

