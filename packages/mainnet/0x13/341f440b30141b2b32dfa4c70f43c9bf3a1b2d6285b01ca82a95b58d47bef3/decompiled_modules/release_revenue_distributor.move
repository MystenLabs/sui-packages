module 0x13341f440b30141b2b32dfa4c70f43c9bf3a1b2d6285b01ca82a95b58d47bef3::release_revenue_distributor {
    struct ReleaseRevenueDistributedEvent<phantom T0> has copy, drop {
        release_id: 0x2::object::ID,
        disc_idx: u64,
        track_idx: u64,
        recording_id: 0x2::object::ID,
        recording_split_value: u64,
    }

    struct ReleaseRevenueDistributionSummaryEvent<phantom T0> has copy, drop {
        release_id: 0x2::object::ID,
        total_input_value: u64,
        total_distributed_value: u64,
        remainder_value: u64,
    }

    public fun distribute_revenue<T0>(arg0: &0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::release::Release, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0x2::balance::value<T0>(&arg1);
        let v1 = 0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::release::id(arg0);
        let v2 = 0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::release::discs(arg0);
        let v3 = 0;
        let v4 = 0;
        while (v4 < 0x1::vector::length<0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::disc::Disc>(v2)) {
            let v5 = 0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::disc::tracks(0x1::vector::borrow<0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::disc::Disc>(v2, v4));
            let v6 = 0;
            while (v6 < 0x1::vector::length<0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::track::Track>(v5)) {
                let v7 = 0x1::vector::borrow<0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::track::Track>(v5, v6);
                let v8 = 0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::track::split_bps(v7);
                if (0xdb58d86a55daa5bc436f0f6056a651c9859da1b4f5785f9688b4c3e72ae1cfe0::bps::value(v8) > 0) {
                    let v9 = 0xdb58d86a55daa5bc436f0f6056a651c9859da1b4f5785f9688b4c3e72ae1cfe0::bps::apply(v8, v0);
                    let v10 = 0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::track::recording_id(v7);
                    v3 = v3 + v9;
                    let v11 = ReleaseRevenueDistributedEvent<T0>{
                        release_id            : v1,
                        disc_idx              : v4,
                        track_idx             : v6,
                        recording_id          : v10,
                        recording_split_value : v9,
                    };
                    0x2::event::emit<ReleaseRevenueDistributedEvent<T0>>(v11);
                    0x2::balance::send_funds<T0>(0x2::balance::split<T0>(&mut arg1, v9), 0x2::object::id_to_address(&v10));
                };
                v6 = v6 + 1;
            };
            v4 = v4 + 1;
        };
        let v12 = 0x2::balance::value<T0>(&arg1);
        let v13 = ReleaseRevenueDistributionSummaryEvent<T0>{
            release_id              : v1,
            total_input_value       : v0,
            total_distributed_value : v3,
            remainder_value         : v12,
        };
        0x2::event::emit<ReleaseRevenueDistributionSummaryEvent<T0>>(v13);
        if (v12 > 0) {
            0x2::balance::send_funds<T0>(arg1, 0x2::object::id_to_address(&v1));
        } else {
            0x2::balance::destroy_zero<T0>(arg1);
        };
    }

    public fun receive_and_distribute_revenue<T0>(arg0: &mut 0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::release::Release, arg1: &0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::release::ReleaseAdminCap, arg2: vector<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>, arg3: &mut 0x2::tx_context::TxContext) {
        distribute_revenue<T0>(arg0, 0x2::coin::into_balance<T0>(0xda970ab921b4edaabee40a04c3c73204e3eab88a14bfc310e79220a4506eb6b8::hikida::receive_coin<T0>(0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::release::uid_mut(arg0, arg1), arg2, arg3)));
    }

    public fun redeem_and_distribute_revenue<T0>(arg0: &mut 0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::release::Release, arg1: &0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::release::ReleaseAdminCap, arg2: u64) {
        distribute_revenue<T0>(arg0, 0xda970ab921b4edaabee40a04c3c73204e3eab88a14bfc310e79220a4506eb6b8::hikida::redeem_balance<T0>(0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::release::uid_mut(arg0, arg1), arg2));
    }

    // decompiled from Move bytecode v7
}

