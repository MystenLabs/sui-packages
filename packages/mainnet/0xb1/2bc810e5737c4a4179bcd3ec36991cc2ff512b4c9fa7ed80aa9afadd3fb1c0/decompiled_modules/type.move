module 0xb12bc810e5737c4a4179bcd3ec36991cc2ff512b4c9fa7ed80aa9afadd3fb1c0::type {
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

