module 0x88f56c1f602a29641698e8d8a5ebbdf544e70558fac3474d01adf8fa96a8aa16::jackson_sharkz {
    struct JacksonSharkz has store, key {
        id: 0x2::object::UID,
        collection_name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::option::Option<0x1::string::String>,
        number: u64,
        attributes: 0x1::option::Option<0x88f56c1f602a29641698e8d8a5ebbdf544e70558fac3474d01adf8fa96a8aa16::attributes::Attributes>,
    }

    public(friend) fun new(arg0: u64, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::option::Option<0x1::string::String>, arg4: 0x1::option::Option<0x88f56c1f602a29641698e8d8a5ebbdf544e70558fac3474d01adf8fa96a8aa16::attributes::Attributes>, arg5: &mut 0x2::tx_context::TxContext) : JacksonSharkz {
        JacksonSharkz{
            id              : 0x2::object::new(arg5),
            collection_name : arg1,
            description     : arg2,
            image_url       : arg3,
            number          : arg0,
            attributes      : arg4,
        }
    }

    public fun number(arg0: &JacksonSharkz) : u64 {
        arg0.number
    }

    public(friend) fun set_attributes(arg0: &mut JacksonSharkz, arg1: 0x88f56c1f602a29641698e8d8a5ebbdf544e70558fac3474d01adf8fa96a8aa16::attributes::Attributes) {
        assert!(0x1::option::is_none<0x88f56c1f602a29641698e8d8a5ebbdf544e70558fac3474d01adf8fa96a8aa16::attributes::Attributes>(&arg0.attributes), 1);
        0x1::option::fill<0x88f56c1f602a29641698e8d8a5ebbdf544e70558fac3474d01adf8fa96a8aa16::attributes::Attributes>(&mut arg0.attributes, arg1);
    }

    public(friend) fun set_image_url(arg0: &mut JacksonSharkz, arg1: 0x1::string::String) {
        0x1::option::swap_or_fill<0x1::string::String>(&mut arg0.image_url, arg1);
    }

    // decompiled from Move bytecode v6
}

