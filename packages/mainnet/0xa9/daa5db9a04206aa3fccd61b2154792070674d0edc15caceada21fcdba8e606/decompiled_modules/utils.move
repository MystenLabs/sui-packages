module 0xa9daa5db9a04206aa3fccd61b2154792070674d0edc15caceada21fcdba8e606::utils {
    public fun get_type_name<T0>() : vector<u8> {
        0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>()))
    }

    public fun max_u_128() : u256 {
        1340282366920938463463374607431768211455
    }

    public fun max_u_64() : u64 {
        18446744073709551615
    }

    // decompiled from Move bytecode v6
}

