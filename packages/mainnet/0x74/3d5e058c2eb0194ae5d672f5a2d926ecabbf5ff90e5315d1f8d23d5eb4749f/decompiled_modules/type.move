module 0x743d5e058c2eb0194ae5d672f5a2d926ecabbf5ff90e5315d1f8d23d5eb4749f::type {
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

