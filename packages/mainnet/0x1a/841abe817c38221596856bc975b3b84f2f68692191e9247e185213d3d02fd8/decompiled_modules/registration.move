module 0x1a841abe817c38221596856bc975b3b84f2f68692191e9247e185213d3d02fd8::registration {
    struct Registration has drop {
        dummy_field: bool,
    }

    public fun register(arg0: &mut 0x1a841abe817c38221596856bc975b3b84f2f68692191e9247e185213d3d02fd8::name_registry::NameRegistry, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x1a841abe817c38221596856bc975b3b84f2f68692191e9247e185213d3d02fd8::dot_move::DotMove {
        let v0 = Registration{dummy_field: false};
        0x1a841abe817c38221596856bc975b3b84f2f68692191e9247e185213d3d02fd8::name_registry::add_record<Registration>(arg0, v0, arg1, 0x2::clock::timestamp_ms(arg2) + 31536000000, arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

