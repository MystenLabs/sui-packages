module 0xcf5807fb9e73d5b9d31637db6583132fd5ccfd5bc030e7337ff09049b8b91100::type {
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

