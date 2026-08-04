module 0xf06b9e3eb6d753269025ef50e32f87c7491f9b33afeafa251205ad0a3b9e4748::attribution {
    struct RecordingAttribution<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        source_recording_id: 0x2::object::ID,
        generative_recording_id: 0x2::object::ID,
        stake: 0xe36d2eead5e0085524a04b07a7a8c23667f358174c13d4ddfcba7cf4afcf5b12::stake::Stake<T1>,
    }

    struct ExtensionKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct RecordingAttributionCreatedEvent<phantom T0, phantom T1> has copy, drop {
        attribution_id: 0x2::object::ID,
        source_recording_id: 0x2::object::ID,
        generative_recording_id: 0x2::object::ID,
        staked_amount: u64,
    }

    struct AttributionRevenueRoutedEvent<phantom T0> has copy, drop {
        attribution_id: 0x2::object::ID,
        source_recording_id: 0x2::object::ID,
        value: u64,
    }

    public fun pending_rewards<T0, T1, T2>(arg0: &RecordingAttribution<T0, T1>, arg1: &0xe36d2eead5e0085524a04b07a7a8c23667f358174c13d4ddfcba7cf4afcf5b12::pool::RoyaltyPool<T1, T2>) : u64 {
        0xe36d2eead5e0085524a04b07a7a8c23667f358174c13d4ddfcba7cf4afcf5b12::pool::pending_rewards<T1, T2>(arg1, &arg0.stake)
    }

    public fun new<T0, T1, T2, T3>(arg0: &0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::recording::RecordingAdminCap<T2>, arg1: &mut 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::recording::Recording<T2, T3>, arg2: &0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::recording::Recording<T0, T1>, arg3: 0x2::balance::Balance<T2>, arg4: &mut 0x2::tx_context::TxContext) : RecordingAttribution<T0, T2> {
        let v0 = 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::recording::id<T0, T1>(arg2);
        let v1 = 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::recording::id<T2, T3>(arg1);
        assert!(v0 != v1, 0);
        assert!(0xf06b9e3eb6d753269025ef50e32f87c7491f9b33afeafa251205ad0a3b9e4748::license::is_attached<T0, T1>(arg2), 1);
        let v2 = ExtensionKey<T0>{dummy_field: false};
        let v3 = RecordingAttribution<T0, T2>{
            id                      : 0x2::derived_object::claim<ExtensionKey<T0>>(0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::recording::uid_mut<T2, T3>(arg1, arg0), v2),
            source_recording_id     : v0,
            generative_recording_id : v1,
            stake                   : 0xe36d2eead5e0085524a04b07a7a8c23667f358174c13d4ddfcba7cf4afcf5b12::stake::new<T2>(arg3, arg4),
        };
        let v4 = RecordingAttributionCreatedEvent<T0, T2>{
            attribution_id          : id<T0, T2>(&v3),
            source_recording_id     : v0,
            generative_recording_id : v1,
            staked_amount           : 0x2::balance::value<T2>(&arg3),
        };
        0x2::event::emit<RecordingAttributionCreatedEvent<T0, T2>>(v4);
        v3
    }

    public fun id<T0, T1>(arg0: &RecordingAttribution<T0, T1>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun derive_attribution_address<T0>(arg0: 0x2::object::ID) : address {
        let v0 = ExtensionKey<T0>{dummy_field: false};
        0x2::derived_object::derive_address<ExtensionKey<T0>>(arg0, v0)
    }

    public fun generative_recording_id<T0, T1>(arg0: &RecordingAttribution<T0, T1>) : 0x2::object::ID {
        arg0.generative_recording_id
    }

    public fun register<T0, T1, T2>(arg0: &mut RecordingAttribution<T0, T1>, arg1: &mut 0xe36d2eead5e0085524a04b07a7a8c23667f358174c13d4ddfcba7cf4afcf5b12::pool::RoyaltyPool<T1, T2>) {
        0xe36d2eead5e0085524a04b07a7a8c23667f358174c13d4ddfcba7cf4afcf5b12::pool::assert_derived_from<T1, T2>(arg1, arg0.generative_recording_id);
        0xe36d2eead5e0085524a04b07a7a8c23667f358174c13d4ddfcba7cf4afcf5b12::pool::register_stake<T1, T2>(arg1, &mut arg0.stake);
    }

    public fun route<T0, T1, T2>(arg0: &mut RecordingAttribution<T0, T1>, arg1: &mut 0xe36d2eead5e0085524a04b07a7a8c23667f358174c13d4ddfcba7cf4afcf5b12::pool::RoyaltyPool<T1, T2>, arg2: &mut 0xe36d2eead5e0085524a04b07a7a8c23667f358174c13d4ddfcba7cf4afcf5b12::pool::RoyaltyPool<T0, T2>) {
        0xe36d2eead5e0085524a04b07a7a8c23667f358174c13d4ddfcba7cf4afcf5b12::pool::assert_derived_from<T0, T2>(arg2, arg0.source_recording_id);
        let v0 = 0xe36d2eead5e0085524a04b07a7a8c23667f358174c13d4ddfcba7cf4afcf5b12::pool::claim_rewards<T1, T2>(arg1, &mut arg0.stake);
        let v1 = 0x2::balance::value<T2>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T2>(v0);
            return
        };
        let v2 = AttributionRevenueRoutedEvent<T2>{
            attribution_id      : id<T0, T1>(arg0),
            source_recording_id : arg0.source_recording_id,
            value               : v1,
        };
        0x2::event::emit<AttributionRevenueRoutedEvent<T2>>(v2);
        0xe36d2eead5e0085524a04b07a7a8c23667f358174c13d4ddfcba7cf4afcf5b12::pool::deposit<T0, T2>(arg2, v0);
    }

    public fun share<T0, T1>(arg0: RecordingAttribution<T0, T1>) {
        0x2::transfer::share_object<RecordingAttribution<T0, T1>>(arg0);
    }

    public fun source_recording_id<T0, T1>(arg0: &RecordingAttribution<T0, T1>) : 0x2::object::ID {
        arg0.source_recording_id
    }

    public fun staked_shares<T0, T1>(arg0: &RecordingAttribution<T0, T1>) : u64 {
        0xe36d2eead5e0085524a04b07a7a8c23667f358174c13d4ddfcba7cf4afcf5b12::stake::value<T1>(&arg0.stake)
    }

    // decompiled from Move bytecode v7
}

