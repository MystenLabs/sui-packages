module 0x5ccc4f8e12c2014f0246d35cc7ee5993f2fdfc86161478ff135e59fad9ef4cfa::distributor {
    struct Distributor has store, key {
        id: 0x2::object::UID,
        last_update_timestamp: u64,
        start_timestamp: u64,
        next_halving_timestamp: u64,
        target: u64,
        pool_allocator: 0x5ccc4f8e12c2014f0246d35cc7ee5993f2fdfc86161478ff135e59fad9ef4cfa::allocator::Allocator,
        treasury: 0x2::coin::TreasuryCap<0x5ccc4f8e12c2014f0246d35cc7ee5993f2fdfc86161478ff135e59fad9ef4cfa::alpha::ALPHA>,
        fee_wallet: address,
        airdrop_wallet: address,
        team_wallet_address: address,
        team_wallet_balance: 0x2::balance::Balance<0x5ccc4f8e12c2014f0246d35cc7ee5993f2fdfc86161478ff135e59fad9ef4cfa::alpha::ALPHA>,
        unlock_per_second: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
    }

    // decompiled from Move bytecode v6
}

