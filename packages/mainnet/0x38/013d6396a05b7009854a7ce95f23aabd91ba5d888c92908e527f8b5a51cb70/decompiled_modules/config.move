module 0x38013d6396a05b7009854a7ce95f23aabd91ba5d888c92908e527f8b5a51cb70::config {
    struct FeeTier has copy, drop, store {
        tick_spacing: u32,
        fee_rate: u64,
    }

    struct GlobalConfig has store, key {
        id: 0x2::object::UID,
        protocol_fee_rate: u64,
        fee_tiers: 0x2::vec_map::VecMap<u32, FeeTier>,
        acl: 0x38013d6396a05b7009854a7ce95f23aabd91ba5d888c92908e527f8b5a51cb70::acl::ACL,
        package_version: u64,
    }

    // decompiled from Move bytecode v6
}

