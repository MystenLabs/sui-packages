module 0x1808f89344c8372ab484168a90f9316e3646c16fbcfbb16e54c0a708d6ac28fa::jackson_sharkz {
    struct JacksonSharkzEgg has store, key {
        id: 0x2::object::UID,
        base_name: 0x1::string::String,
        description: 0x1::string::String,
        image_stem: 0x1::string::String,
        image_serial: u64,
        serial: u64,
        is_og: bool,
        attributes: 0x1::option::Option<0x1808f89344c8372ab484168a90f9316e3646c16fbcfbb16e54c0a708d6ac28fa::attributes::Attributes>,
    }

    public(friend) fun new_egg(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: bool, arg6: 0x1::option::Option<0x1808f89344c8372ab484168a90f9316e3646c16fbcfbb16e54c0a708d6ac28fa::attributes::Attributes>, arg7: &mut 0x2::tx_context::TxContext) : JacksonSharkzEgg {
        JacksonSharkzEgg{
            id           : 0x2::object::new(arg7),
            base_name    : arg0,
            description  : arg1,
            image_stem   : arg2,
            image_serial : arg3,
            serial       : arg4,
            is_og        : arg5,
            attributes   : arg6,
        }
    }

    // decompiled from Move bytecode v7
}

