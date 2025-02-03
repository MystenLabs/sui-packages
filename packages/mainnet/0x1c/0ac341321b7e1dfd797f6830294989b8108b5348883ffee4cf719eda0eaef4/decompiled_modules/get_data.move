module 0x1c0ac341321b7e1dfd797f6830294989b8108b5348883ffee4cf719eda0eaef4::get_data {
    public fun get_funds_info(arg0: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg1: address) : (address, u8, 0x1::type_name::TypeName) {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::get_funds_info(arg0, arg1)
    }

    public fun get_pool_length(arg0: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive) : u64 {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::get_pool_length(arg0)
    }

    // decompiled from Move bytecode v6
}

