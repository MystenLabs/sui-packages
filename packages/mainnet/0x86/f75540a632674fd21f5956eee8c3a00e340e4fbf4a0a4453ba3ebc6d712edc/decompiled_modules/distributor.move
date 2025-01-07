module 0x86f75540a632674fd21f5956eee8c3a00e340e4fbf4a0a4453ba3ebc6d712edc::distributor {
    struct Distributor has store, key {
        id: 0x2::object::UID,
        last_update_timestamp: u64,
        start_timestamp: u64,
        next_halving_timestamp: u64,
        target: u64,
        pool_allocator: 0x86f75540a632674fd21f5956eee8c3a00e340e4fbf4a0a4453ba3ebc6d712edc::allocator::Allocator,
        treasury: 0x2::coin::TreasuryCap<0x86f75540a632674fd21f5956eee8c3a00e340e4fbf4a0a4453ba3ebc6d712edc::alpha::ALPHA>,
        fee_wallet: address,
        airdrop_wallet: address,
        team_wallet_address: address,
        team_wallet_balance: 0x2::balance::Balance<0x86f75540a632674fd21f5956eee8c3a00e340e4fbf4a0a4453ba3ebc6d712edc::alpha::ALPHA>,
        unlock_per_second: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
    }

    // decompiled from Move bytecode v6
}

