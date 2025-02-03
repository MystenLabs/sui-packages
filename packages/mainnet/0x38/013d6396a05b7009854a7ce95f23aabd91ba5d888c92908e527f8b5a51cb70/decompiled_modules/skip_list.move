module 0x38013d6396a05b7009854a7ce95f23aabd91ba5d888c92908e527f8b5a51cb70::skip_list {
    struct SkipList<phantom T0: store> has store, key {
        id: 0x2::object::UID,
        head: vector<0x38013d6396a05b7009854a7ce95f23aabd91ba5d888c92908e527f8b5a51cb70::option_u64::OptionU64>,
        tail: 0x38013d6396a05b7009854a7ce95f23aabd91ba5d888c92908e527f8b5a51cb70::option_u64::OptionU64,
        level: u64,
        max_level: u64,
        list_p: u64,
        size: u64,
        random: 0x38013d6396a05b7009854a7ce95f23aabd91ba5d888c92908e527f8b5a51cb70::random::Random,
    }

    // decompiled from Move bytecode v6
}

