module 0x65d19c6734f4ba897ecaa45f5f5a0f8b81b68d572a7f21b512c45af964d5c44d::config {
    struct FeeTier has copy, drop, store {
        tick_spacing: u32,
        fee_rate: u64,
    }

    struct GlobalConfig has store, key {
        id: 0x2::object::UID,
        protocol_fee_rate: u64,
        fee_tiers: 0x2::vec_map::VecMap<u32, FeeTier>,
        acl: 0x65d19c6734f4ba897ecaa45f5f5a0f8b81b68d572a7f21b512c45af964d5c44d::acl::ACL,
        package_version: u64,
    }

    // decompiled from Move bytecode v6
}

