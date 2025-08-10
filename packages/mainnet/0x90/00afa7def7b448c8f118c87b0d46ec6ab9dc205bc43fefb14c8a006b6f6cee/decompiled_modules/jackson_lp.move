module 0x9000afa7def7b448c8f118c87b0d46ec6ab9dc205bc43fefb14c8a006b6f6cee::jackson_lp {
    struct JacksonLPv2 has store, key {
        id: 0x2::object::UID,
        distributor_id: 0x2::object::ID,
        lp_name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::option::Option<0x1::string::String>,
        number: u64,
        features: 0x9000afa7def7b448c8f118c87b0d46ec6ab9dc205bc43fefb14c8a006b6f6cee::features::Features,
    }

    public(friend) fun new(arg0: 0x2::object::ID, arg1: u64, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::option::Option<0x1::string::String>, arg5: 0x9000afa7def7b448c8f118c87b0d46ec6ab9dc205bc43fefb14c8a006b6f6cee::features::Features, arg6: &mut 0x2::tx_context::TxContext) : JacksonLPv2 {
        JacksonLPv2{
            id             : 0x2::object::new(arg6),
            distributor_id : arg0,
            lp_name        : arg2,
            description    : arg3,
            image_url      : arg4,
            number         : arg1,
            features       : arg5,
        }
    }

    public fun features(arg0: &JacksonLPv2) : &0x9000afa7def7b448c8f118c87b0d46ec6ab9dc205bc43fefb14c8a006b6f6cee::features::Features {
        &arg0.features
    }

    public(friend) fun destroy(arg0: JacksonLPv2) {
        let JacksonLPv2 {
            id             : v0,
            distributor_id : _,
            lp_name        : _,
            description    : _,
            image_url      : _,
            number         : _,
            features       : v6,
        } = arg0;
        0x2::object::delete(v0);
        0x9000afa7def7b448c8f118c87b0d46ec6ab9dc205bc43fefb14c8a006b6f6cee::features::destroy(v6);
    }

    public fun distributor_id(arg0: &JacksonLPv2) : 0x2::object::ID {
        arg0.distributor_id
    }

    public fun number(arg0: &JacksonLPv2) : u64 {
        arg0.number
    }

    public(friend) fun set_image_url(arg0: &mut JacksonLPv2, arg1: 0x1::string::String) {
        0x1::option::swap_or_fill<0x1::string::String>(&mut arg0.image_url, arg1);
    }

    // decompiled from Move bytecode v6
}

