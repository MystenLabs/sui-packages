module 0xe59c9281c3d6fad99063c2517cd4e5dd54c998e0a67e7407c4291c97c634f8aa::type {
    struct FeeInfo has store, key {
        id: 0x2::object::UID,
        token_fee: u64,
        fixed_native_fee_amount: u64,
        dzap_token_share: u64,
        dzap_fixed_native_share: u64,
    }

    struct IntegratorInfo has store, key {
        id: 0x2::object::UID,
        status: bool,
        fee_info: 0x2::vec_map::VecMap<0x1::string::String, FeeInfo>,
    }

    // decompiled from Move bytecode v6
}

