module 0x6ef20e184e16d91b8cc123b06e779cb89028dfa6b89d79ce7df3b3f7aca0217f::release_revenue_distributor {
    struct ReleaseCoinsReceivedEvent<phantom T0> has copy, drop {
        release_id: address,
        admin_cap_id: address,
        coin_count: u64,
        amount: u64,
    }

    struct ReleaseFundsRedeemedEvent<phantom T0> has copy, drop {
        release_id: address,
        admin_cap_id: address,
        amount: u64,
    }

    struct ReleaseTrackRevenueDistributedEvent<phantom T0> has copy, drop {
        release_id: address,
        track_index: u64,
        composition_id: address,
        recording_id: address,
        split_bps: u16,
        total_input: u64,
        amount: u64,
    }

    struct ReleaseRevenueDistributedEvent<phantom T0> has copy, drop {
        release_id: address,
        track_count: u64,
        total_input: u64,
        total_distributed: u64,
        remainder: u64,
    }

    fun distribute<T0>(arg0: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::Release, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::Release>(arg0);
        let v1 = 0x2::object::id_to_address(&v0);
        let v2 = 0x2::balance::value<T0>(&arg1);
        let v3 = 0;
        let v4 = 0;
        let v5 = 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::tracks(arg0);
        let v6 = 0;
        while (v6 < 0x1::vector::length<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::track::Track>(v5)) {
            let v7 = 0x1::vector::borrow<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::track::Track>(v5, v6);
            let v8 = 0xc470410a4790a5a4a5af09599e3ffb5b2ed47433e265ce6f19c7160ab9ebb266::bps::apply(0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::track::split_bps(v7), v2);
            v3 = v3 + v8;
            if (v8 > 0) {
                let v9 = 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::track::recording_id(v7);
                0x2::balance::send_funds<T0>(0x2::balance::split<T0>(&mut arg1, v8), 0x2::object::id_to_address(&v9));
            };
            if (v2 > 0) {
                let v10 = 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::track::composition_id(v7);
                let v11 = 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::track::recording_id(v7);
                let v12 = ReleaseTrackRevenueDistributedEvent<T0>{
                    release_id     : v1,
                    track_index    : v4,
                    composition_id : 0x2::object::id_to_address(&v10),
                    recording_id   : 0x2::object::id_to_address(&v11),
                    split_bps      : 0xc470410a4790a5a4a5af09599e3ffb5b2ed47433e265ce6f19c7160ab9ebb266::bps::value(0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::track::split_bps(v7)),
                    total_input    : v2,
                    amount         : v8,
                };
                0x2::event::emit<ReleaseTrackRevenueDistributedEvent<T0>>(v12);
            };
            v4 = v4 + 1;
            v6 = v6 + 1;
        };
        let v13 = 0x2::balance::value<T0>(&arg1);
        if (v13 > 0) {
            0x2::balance::send_funds<T0>(arg1, v1);
        } else {
            0x2::balance::destroy_zero<T0>(arg1);
        };
        if (v2 > 0) {
            let v14 = ReleaseRevenueDistributedEvent<T0>{
                release_id        : v1,
                track_count       : v4,
                total_input       : v2,
                total_distributed : v3,
                remainder         : v13,
            };
            0x2::event::emit<ReleaseRevenueDistributedEvent<T0>>(v14);
        };
    }

    public fun receive_and_distribute<T0>(arg0: &mut 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::Release, arg1: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::ReleaseAdminCap, arg2: vector<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>) {
        let v0 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::Release>(arg0);
        let v1 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::ReleaseAdminCap>(arg1);
        let v2 = 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::uid_mut(arg0, arg1);
        assert!(!0x1::vector::is_empty<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>(&arg2), 0);
        let v3 = 0x2ccb0ff53146ac5830f92c0c9f8e5260160705e1f15c7f6606340a1c94c2ab98::hikida::receive_coins_as_balance<T0>(v2, arg2);
        let v4 = ReleaseCoinsReceivedEvent<T0>{
            release_id   : 0x2::object::id_to_address(&v0),
            admin_cap_id : 0x2::object::id_to_address(&v1),
            coin_count   : 0x1::vector::length<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>(&arg2),
            amount       : 0x2::balance::value<T0>(&v3),
        };
        0x2::event::emit<ReleaseCoinsReceivedEvent<T0>>(v4);
        distribute<T0>(arg0, v3);
    }

    public fun redeem_all_and_distribute<T0>(arg0: &mut 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::Release, arg1: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::ReleaseAdminCap, arg2: &0x2::accumulator::AccumulatorRoot) {
        let v0 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::Release>(arg0);
        redeem_settled_value_and_distribute<T0>(arg0, arg1, 0x2::balance::settled_funds_value<T0>(arg2, 0x2::object::id_to_address(&v0)));
    }

    fun redeem_settled_value_and_distribute<T0>(arg0: &mut 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::Release, arg1: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::ReleaseAdminCap, arg2: u64) {
        0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::authorize(arg0, arg1);
        if (arg2 == 0) {
            return
        };
        let v0 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::Release>(arg0);
        let v1 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::ReleaseAdminCap>(arg1);
        let v2 = 0x2ccb0ff53146ac5830f92c0c9f8e5260160705e1f15c7f6606340a1c94c2ab98::hikida::redeem_balance<T0>(0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::uid_mut(arg0, arg1), arg2);
        let v3 = ReleaseFundsRedeemedEvent<T0>{
            release_id   : 0x2::object::id_to_address(&v0),
            admin_cap_id : 0x2::object::id_to_address(&v1),
            amount       : 0x2::balance::value<T0>(&v2),
        };
        0x2::event::emit<ReleaseFundsRedeemedEvent<T0>>(v3);
        distribute<T0>(arg0, v2);
    }

    // decompiled from Move bytecode v7
}

