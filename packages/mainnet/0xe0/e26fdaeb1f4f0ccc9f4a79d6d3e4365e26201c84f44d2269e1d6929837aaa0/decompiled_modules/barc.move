module 0x5d5f4dbf37cbf5e4dedde55632af69b676112ffe4c5a6e1f29a5c434090c6aa4::barc {
    struct Botter has store, key {
        id: 0x2::object::UID,
        number: u64,
        image: 0x1::string::String,
        attributes: 0x5d5f4dbf37cbf5e4dedde55632af69b676112ffe4c5a6e1f29a5c434090c6aa4::attributes::Attributes,
    }

    struct Data has copy, drop, store {
        number: u64,
        image: 0x1::string::String,
        attributes: 0x5d5f4dbf37cbf5e4dedde55632af69b676112ffe4c5a6e1f29a5c434090c6aa4::attributes::Attributes,
    }

    public(friend) fun create_data(arg0: u64, arg1: 0x1::string::String, arg2: &mut vector<0x1::string::String>, arg3: &mut vector<0x1::string::String>) : Data {
        Data{
            number     : arg0,
            image      : arg1,
            attributes : 0x5d5f4dbf37cbf5e4dedde55632af69b676112ffe4c5a6e1f29a5c434090c6aa4::attributes::from_vec(arg2, arg3),
        }
    }

    public(friend) fun mint(arg0: Data, arg1: &mut 0x2::tx_context::TxContext) : Botter {
        let v0 = Botter{
            id         : 0x2::object::new(arg1),
            number     : arg0.number,
            image      : arg0.image,
            attributes : arg0.attributes,
        };
        0x5d5f4dbf37cbf5e4dedde55632af69b676112ffe4c5a6e1f29a5c434090c6aa4::events::mint(0x2::object::id<Botter>(&v0), arg0.number, arg0.image, arg0.attributes);
        v0
    }

    // decompiled from Move bytecode v6
}

