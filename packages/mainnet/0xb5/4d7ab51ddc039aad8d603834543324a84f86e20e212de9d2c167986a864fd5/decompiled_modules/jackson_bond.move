module 0xb54d7ab51ddc039aad8d603834543324a84f86e20e212de9d2c167986a864fd5::jackson_bond {
    struct JacksonBond has store, key {
        id: 0x2::object::UID,
        distributor_id: 0x2::object::ID,
        bond_name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::option::Option<0x1::string::String>,
        number: u64,
        features: 0xb54d7ab51ddc039aad8d603834543324a84f86e20e212de9d2c167986a864fd5::features::Features,
    }

    public(friend) fun new(arg0: 0x2::object::ID, arg1: u64, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::option::Option<0x1::string::String>, arg5: 0xb54d7ab51ddc039aad8d603834543324a84f86e20e212de9d2c167986a864fd5::features::Features, arg6: &mut 0x2::tx_context::TxContext) : JacksonBond {
        JacksonBond{
            id             : 0x2::object::new(arg6),
            distributor_id : arg0,
            bond_name      : arg2,
            description    : arg3,
            image_url      : arg4,
            number         : arg1,
            features       : arg5,
        }
    }

    public fun features(arg0: &JacksonBond) : &0xb54d7ab51ddc039aad8d603834543324a84f86e20e212de9d2c167986a864fd5::features::Features {
        &arg0.features
    }

    public(friend) fun destroy(arg0: JacksonBond) {
        let JacksonBond {
            id             : v0,
            distributor_id : _,
            bond_name      : _,
            description    : _,
            image_url      : _,
            number         : _,
            features       : v6,
        } = arg0;
        0x2::object::delete(v0);
        0xb54d7ab51ddc039aad8d603834543324a84f86e20e212de9d2c167986a864fd5::features::destroy(v6);
    }

    public fun distributor_id(arg0: &JacksonBond) : 0x2::object::ID {
        arg0.distributor_id
    }

    public fun number(arg0: &JacksonBond) : u64 {
        arg0.number
    }

    public(friend) fun set_image_url(arg0: &mut JacksonBond, arg1: 0x1::string::String) {
        0x1::option::swap_or_fill<0x1::string::String>(&mut arg0.image_url, arg1);
    }

    // decompiled from Move bytecode v6
}

