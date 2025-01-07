module 0x8a5035307ff2fe64b94790c7901de6d8c376751b35d4694a640922a69acc19ab::type {
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

