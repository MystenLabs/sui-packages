module 0x58b3206258ff1c2b3990dd061655a73b24c18c58f8d3d88dde8c0f990274dc06::release_revenue_distributor {
    struct ReleaseRevenueDistributedEvent<phantom T0> has copy, drop {
        release_id: 0x2::object::ID,
        track_index: u64,
        recording_id: 0x2::object::ID,
        recording_split_value: u64,
    }

    struct ReleaseRevenueDistributionSummaryEvent<phantom T0> has copy, drop {
        release_id: 0x2::object::ID,
        total_input_value: u64,
        total_distributed_value: u64,
        remainder_value: u64,
    }

    public fun distribute_revenue<T0>(arg0: &0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::Release, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0x2::balance::value<T0>(&arg1);
        let v1 = 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::id(arg0);
        let v2 = 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::tracks(arg0);
        let v3 = 0;
        let v4 = 0;
        while (v4 < 0x1::vector::length<0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::track::Track>(v2)) {
            let v5 = 0x1::vector::borrow<0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::track::Track>(v2, v4);
            let v6 = 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::track::split_bps(v5);
            if (0xdb58d86a55daa5bc436f0f6056a651c9859da1b4f5785f9688b4c3e72ae1cfe0::bps::value(v6) > 0) {
                let v7 = 0xdb58d86a55daa5bc436f0f6056a651c9859da1b4f5785f9688b4c3e72ae1cfe0::bps::apply(v6, v0);
                let v8 = 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::track::recording_id(v5);
                v3 = v3 + v7;
                let v9 = ReleaseRevenueDistributedEvent<T0>{
                    release_id            : v1,
                    track_index           : v4,
                    recording_id          : v8,
                    recording_split_value : v7,
                };
                0x2::event::emit<ReleaseRevenueDistributedEvent<T0>>(v9);
                0x2::balance::send_funds<T0>(0x2::balance::split<T0>(&mut arg1, v7), 0x2::object::id_to_address(&v8));
            };
            v4 = v4 + 1;
        };
        let v10 = 0x2::balance::value<T0>(&arg1);
        let v11 = ReleaseRevenueDistributionSummaryEvent<T0>{
            release_id              : v1,
            total_input_value       : v0,
            total_distributed_value : v3,
            remainder_value         : v10,
        };
        0x2::event::emit<ReleaseRevenueDistributionSummaryEvent<T0>>(v11);
        if (v10 > 0) {
            0x2::balance::send_funds<T0>(arg1, 0x2::object::id_to_address(&v1));
        } else {
            0x2::balance::destroy_zero<T0>(arg1);
        };
    }

    public fun receive_and_distribute_revenue<T0>(arg0: &mut 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::Release, arg1: &0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::ReleaseAdminCap, arg2: vector<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>, arg3: &mut 0x2::tx_context::TxContext) {
        distribute_revenue<T0>(arg0, 0x2::coin::into_balance<T0>(0xda970ab921b4edaabee40a04c3c73204e3eab88a14bfc310e79220a4506eb6b8::hikida::receive_coin<T0>(0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::uid_mut(arg0, arg1), arg2, arg3)));
    }

    public fun redeem_and_distribute_revenue<T0>(arg0: &mut 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::Release, arg1: &0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::ReleaseAdminCap, arg2: u64) {
        distribute_revenue<T0>(arg0, 0xda970ab921b4edaabee40a04c3c73204e3eab88a14bfc310e79220a4506eb6b8::hikida::redeem_balance<T0>(0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::uid_mut(arg0, arg1), arg2));
    }

    // decompiled from Move bytecode v7
}

