module 0xc91707b865e19b2df539bd8e8548b37ffb88401c50caa6ca0bea3a19f1f98024::jackson_lp {
    struct JacksonLP has store, key {
        id: 0x2::object::UID,
        distributor_id: 0x2::object::ID,
        lp_name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::option::Option<0x1::string::String>,
        round: u64,
        number: u64,
        features: 0xc91707b865e19b2df539bd8e8548b37ffb88401c50caa6ca0bea3a19f1f98024::features::Features,
        attributes: 0x1::option::Option<0xc91707b865e19b2df539bd8e8548b37ffb88401c50caa6ca0bea3a19f1f98024::attributes::Attributes>,
    }

    public(friend) fun new(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::option::Option<0x1::string::String>, arg6: 0xc91707b865e19b2df539bd8e8548b37ffb88401c50caa6ca0bea3a19f1f98024::features::Features, arg7: 0x1::option::Option<0xc91707b865e19b2df539bd8e8548b37ffb88401c50caa6ca0bea3a19f1f98024::attributes::Attributes>, arg8: &mut 0x2::tx_context::TxContext) : JacksonLP {
        JacksonLP{
            id             : 0x2::object::new(arg8),
            distributor_id : arg0,
            lp_name        : arg3,
            description    : arg4,
            image_url      : arg5,
            round          : arg1,
            number         : arg2,
            features       : arg6,
            attributes     : arg7,
        }
    }

    public(friend) fun destroy(arg0: JacksonLP) {
        let JacksonLP {
            id             : v0,
            distributor_id : _,
            lp_name        : _,
            description    : _,
            image_url      : _,
            round          : _,
            number         : _,
            features       : v7,
            attributes     : v8,
        } = arg0;
        let v9 = v8;
        0x2::object::delete(v0);
        0xc91707b865e19b2df539bd8e8548b37ffb88401c50caa6ca0bea3a19f1f98024::features::destroy(v7);
        if (0x1::option::is_some<0xc91707b865e19b2df539bd8e8548b37ffb88401c50caa6ca0bea3a19f1f98024::attributes::Attributes>(&v9)) {
            0xc91707b865e19b2df539bd8e8548b37ffb88401c50caa6ca0bea3a19f1f98024::attributes::destroy(0x1::option::extract<0xc91707b865e19b2df539bd8e8548b37ffb88401c50caa6ca0bea3a19f1f98024::attributes::Attributes>(&mut v9));
        };
        0x1::option::destroy_none<0xc91707b865e19b2df539bd8e8548b37ffb88401c50caa6ca0bea3a19f1f98024::attributes::Attributes>(v9);
    }

    public fun features(arg0: &JacksonLP) : &0xc91707b865e19b2df539bd8e8548b37ffb88401c50caa6ca0bea3a19f1f98024::features::Features {
        &arg0.features
    }

    public fun distributor_id(arg0: &JacksonLP) : 0x2::object::ID {
        arg0.distributor_id
    }

    public fun number(arg0: &JacksonLP) : u64 {
        arg0.number
    }

    public fun round(arg0: &JacksonLP) : u64 {
        arg0.round
    }

    public(friend) fun set_image_url(arg0: &mut JacksonLP, arg1: 0x1::string::String) {
        0x1::option::swap_or_fill<0x1::string::String>(&mut arg0.image_url, arg1);
    }

    // decompiled from Move bytecode v6
}

