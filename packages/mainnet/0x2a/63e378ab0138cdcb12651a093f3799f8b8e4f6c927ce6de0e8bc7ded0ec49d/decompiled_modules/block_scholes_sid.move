module 0x2a63e378ab0138cdcb12651a093f3799f8b8e4f6c927ce6de0e8bc7ded0ec49d::block_scholes_sid {
    public(friend) fun forward(arg0: &0x1::string::String, arg1: u64) : u256 {
        0xdacaf624c4802c9ff7b8c72447207f5078b78be246f78e143d63e6cd89b4f63d::sid::mark_px(oracle_package_id(), 0x1::string::utf8(b"future"), 0x1::string::utf8(b"composite"), *arg0, 0x1::option::some<0xdacaf624c4802c9ff7b8c72447207f5078b78be246f78e143d63e6cd89b4f63d::sid::Expiry>(0xdacaf624c4802c9ff7b8c72447207f5078b78be246f78e143d63e6cd89b4f63d::sid::expiry_at(arg1)), 9, 0x1::string::utf8(b"ms"))
    }

    fun oracle_package_id() : address {
        0x1::type_name::original_id<0xa408bcdeb8e7607b1cbb92c088147d61664a6255a3ea5696a8fef44711e113d8::verify::PackageMarker>()
    }

    public(friend) fun spot(arg0: &0x1::string::String) : u256 {
        0xdacaf624c4802c9ff7b8c72447207f5078b78be246f78e143d63e6cd89b4f63d::sid::index_px(oracle_package_id(), 0x1::string::utf8(b"spot"), *arg0, 0x1::option::none<0xdacaf624c4802c9ff7b8c72447207f5078b78be246f78e143d63e6cd89b4f63d::sid::Expiry>(), 9, 0x1::string::utf8(b"ms"))
    }

    public(friend) fun svi(arg0: &0x1::string::String, arg1: u64) : u256 {
        0xdacaf624c4802c9ff7b8c72447207f5078b78be246f78e143d63e6cd89b4f63d::sid::model_params(oracle_package_id(), 0x1::string::utf8(b"option"), *arg0, 0x1::string::utf8(b"SVI"), 0xdacaf624c4802c9ff7b8c72447207f5078b78be246f78e143d63e6cd89b4f63d::sid::expiry_at(arg1), 9, 0x1::string::utf8(b"ms"))
    }

    // decompiled from Move bytecode v7
}

