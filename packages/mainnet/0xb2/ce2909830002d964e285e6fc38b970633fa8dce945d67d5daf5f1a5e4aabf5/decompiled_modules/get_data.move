module 0xb2ce2909830002d964e285e6fc38b970633fa8dce945d67d5daf5f1a5e4aabf5::get_data {
    public entry fun get_funds_info(arg0: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg1: address) : (address, u8, 0x1::type_name::TypeName) {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::get_funds_info(arg0, arg1)
    }

    public entry fun get_pool_info(arg0: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg1: address) : (address, u64, address, u64, u64, u64, u64, u8, u8, u256, u64, u64, u256) {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::get_pool_info(arg0, arg1)
    }

    // decompiled from Move bytecode v6
}

