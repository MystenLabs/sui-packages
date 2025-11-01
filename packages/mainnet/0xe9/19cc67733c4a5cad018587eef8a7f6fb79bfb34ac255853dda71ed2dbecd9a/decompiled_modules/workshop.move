module 0xe919cc67733c4a5cad018587eef8a7f6fb79bfb34ac255853dda71ed2dbecd9a::workshop {
    struct Marker has key {
        id: 0x2::object::UID,
        color: 0x1::string::String,
        brand: 0x1::string::String,
    }

    public fun create_marker(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) : Marker {
        Marker{
            id    : 0x2::object::new(arg2),
            color : arg0,
            brand : arg1,
        }
    }

    // decompiled from Move bytecode v6
}

