module 0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::barc {
    struct Botter has store, key {
        id: 0x2::object::UID,
        number: u64,
        image: 0x1::string::String,
        attributes: 0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::attributes::Attributes,
    }

    struct Data has copy, drop, store {
        number: u64,
        image: 0x1::string::String,
        attributes: 0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::attributes::Attributes,
    }

    public(friend) fun create_data(arg0: u64, arg1: 0x1::string::String, arg2: &mut vector<0x1::string::String>, arg3: &mut vector<0x1::string::String>) : Data {
        Data{
            number     : arg0,
            image      : arg1,
            attributes : 0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::attributes::from_vec(arg2, arg3),
        }
    }

    public(friend) fun mint(arg0: Data, arg1: &mut 0x2::tx_context::TxContext) : Botter {
        let v0 = Botter{
            id         : 0x2::object::new(arg1),
            number     : arg0.number,
            image      : arg0.image,
            attributes : arg0.attributes,
        };
        0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::events::mint(0x2::object::id<Botter>(&v0), arg0.number, arg0.image, arg0.attributes);
        v0
    }

    // decompiled from Move bytecode v6
}

