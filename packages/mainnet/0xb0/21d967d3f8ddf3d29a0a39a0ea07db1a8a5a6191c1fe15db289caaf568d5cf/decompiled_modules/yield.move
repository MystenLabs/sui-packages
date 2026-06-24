module 0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::yield {
    struct YieldPool has key {
        id: 0x2::object::UID,
        launch_id: 0x2::object::ID,
        creator: address,
        total_fees_received: u64,
        creator_fees_claimed: u64,
        nft_fees_distributed: u64,
    }

    struct FeeBalanceKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct PassClaimedKey has copy, drop, store {
        pass_id: 0x2::object::ID,
    }

    public fun launch_id(arg0: &YieldPool) : 0x2::object::ID {
        arg0.launch_id
    }

    public entry fun claim_creator_yield<T0>(arg0: &mut YieldPool, arg1: &0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::launch::LaunchCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::launch::cap_launch_id(arg1) == arg0.launch_id, 1);
        let v0 = FeeBalanceKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<FeeBalanceKey<T0>>(&arg0.id, v0), 2);
        let v1 = (((arg0.total_fees_received as u128) * (0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::config::creator_swap_bps() as u128) / (0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::config::bps_denominator() as u128)) as u64);
        let v2 = if (v1 > arg0.creator_fees_claimed) {
            v1 - arg0.creator_fees_claimed
        } else {
            0
        };
        assert!(v2 > 0, 2);
        assert!(v2 <= 0x2::balance::value<T0>(0x2::dynamic_field::borrow<FeeBalanceKey<T0>, 0x2::balance::Balance<T0>>(&arg0.id, v0)), 2);
        arg0.creator_fees_claimed = arg0.creator_fees_claimed + v2;
        let v3 = arg0.creator;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<FeeBalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v0), v2), arg2), v3);
        0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::events::emit_yield_claimed(arg0.launch_id, 0x2::object::id_from_address(@0x0), v3, v2, true);
    }

    public entry fun claim_nft_yield<T0>(arg0: &mut YieldPool, arg1: &0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::backer::BackerPass, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::backer::launch_id(arg1) == arg0.launch_id, 0);
        let v0 = 0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::backer::pass_id(arg1);
        let v1 = 0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::config::bps_denominator();
        let v2 = ((((((arg0.total_fees_received as u128) * (0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::config::nft_holder_swap_bps() as u128) / (v1 as u128)) as u64) as u128) * (0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::backer::yield_share_bps(arg1) as u128) / (v1 as u128)) as u64);
        let v3 = PassClaimedKey{pass_id: v0};
        let v4 = if (0x2::dynamic_field::exists_<PassClaimedKey>(&arg0.id, v3)) {
            *0x2::dynamic_field::borrow<PassClaimedKey, u64>(&arg0.id, v3)
        } else {
            0
        };
        let v5 = if (v2 > v4) {
            v2 - v4
        } else {
            0
        };
        assert!(v5 > 0, 2);
        let v6 = FeeBalanceKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<FeeBalanceKey<T0>>(&arg0.id, v6), 2);
        let v7 = 0x2::dynamic_field::borrow_mut<FeeBalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v6);
        assert!(0x2::balance::value<T0>(v7) >= v5, 2);
        if (0x2::dynamic_field::exists_<PassClaimedKey>(&arg0.id, v3)) {
            let v8 = 0x2::dynamic_field::borrow_mut<PassClaimedKey, u64>(&mut arg0.id, v3);
            *v8 = *v8 + v5;
        } else {
            0x2::dynamic_field::add<PassClaimedKey, u64>(&mut arg0.id, v3, v5);
        };
        arg0.nft_fees_distributed = arg0.nft_fees_distributed + v5;
        let v9 = 0x2::tx_context::sender(arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v7, v5), arg2), v9);
        0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::events::emit_yield_claimed(arg0.launch_id, v0, v9, v5, false);
    }

    public entry fun create_yield_pool(arg0: &0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::launch::VaultLaunch, arg1: &0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::launch::LaunchCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::launch::cap_launch_id(arg1) == 0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::launch::id(arg0), 1);
        let v0 = YieldPool{
            id                   : 0x2::object::new(arg2),
            launch_id            : 0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::launch::id(arg0),
            creator              : 0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::launch::creator(arg0),
            total_fees_received  : 0,
            creator_fees_claimed : 0,
            nft_fees_distributed : 0,
        };
        0x2::transfer::share_object<YieldPool>(v0);
    }

    public fun creator_fees_claimed(arg0: &YieldPool) : u64 {
        arg0.creator_fees_claimed
    }

    public entry fun deposit_fees<T0>(arg0: &mut YieldPool, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.total_fees_received = arg0.total_fees_received + 0x2::coin::value<T0>(&arg1);
        let v0 = FeeBalanceKey<T0>{dummy_field: false};
        if (0x2::dynamic_field::exists_<FeeBalanceKey<T0>>(&arg0.id, v0)) {
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<FeeBalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v0), 0x2::coin::into_balance<T0>(arg1));
        } else {
            0x2::dynamic_field::add<FeeBalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v0, 0x2::coin::into_balance<T0>(arg1));
        };
    }

    public fun total_fees_received(arg0: &YieldPool) : u64 {
        arg0.total_fees_received
    }

    // decompiled from Move bytecode v7
}

