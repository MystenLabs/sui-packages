module 0xa224b61f06b588c68a8c222d0449b918ee2afe8d8fcb05090dda71f1e8da3df::config {
    struct FeeTier has copy, drop, store {
        tick_spacing: u32,
        fee_rate: u64,
    }

    struct GlobalConfig has store, key {
        id: 0x2::object::UID,
        protocol_fee_rate: u64,
        fee_tiers: 0x2::vec_map::VecMap<u32, FeeTier>,
        acl: 0xa224b61f06b588c68a8c222d0449b918ee2afe8d8fcb05090dda71f1e8da3df::acl::ACL,
        package_version: u64,
    }

    // decompiled from Move bytecode v6
}

