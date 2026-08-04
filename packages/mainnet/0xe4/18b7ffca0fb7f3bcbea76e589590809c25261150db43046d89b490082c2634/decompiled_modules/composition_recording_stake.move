module 0xe418b7ffca0fb7f3bcbea76e589590809c25261150db43046d89b490082c2634::composition_recording_stake {
    struct ExtensionKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    fun assert_pool_for_recording<T0, T1>(arg0: &0xe36d2eead5e0085524a04b07a7a8c23667f358174c13d4ddfcba7cf4afcf5b12::pool::RoyaltyPool<T0, T1>, arg1: 0x2::object::ID) {
        let v0 = 0xe36d2eead5e0085524a04b07a7a8c23667f358174c13d4ddfcba7cf4afcf5b12::pool::id<T0, T1>(arg0);
        assert!(0x2::object::id_to_address(&v0) == 0xe36d2eead5e0085524a04b07a7a8c23667f358174c13d4ddfcba7cf4afcf5b12::pool::derived_address<T1>(arg1), 2);
    }

    public fun claim<T0, T1, T2>(arg0: &mut 0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::composition::Composition<T1>, arg1: &0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::composition::CompositionAdminCap<T1>, arg2: &mut 0xe36d2eead5e0085524a04b07a7a8c23667f358174c13d4ddfcba7cf4afcf5b12::pool::RoyaltyPool<T0, T2>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let v0 = 0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::composition::uid_mut<T1>(arg0, arg1);
        let v1 = ExtensionKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists<ExtensionKey<T0>>(v0, v1), 1);
        let v2 = ExtensionKey<T0>{dummy_field: false};
        0x2::coin::from_balance<T2>(0xe36d2eead5e0085524a04b07a7a8c23667f358174c13d4ddfcba7cf4afcf5b12::pool::claim_rewards<T0, T2>(arg2, 0x2::dynamic_field::borrow_mut<ExtensionKey<T0>, 0xe36d2eead5e0085524a04b07a7a8c23667f358174c13d4ddfcba7cf4afcf5b12::stake::Stake<T0>>(v0, v2)), arg3)
    }

    public fun create_stake<T0, T1>(arg0: &mut 0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::composition::Composition<T1>, arg1: &0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::composition::CompositionAdminCap<T1>, arg2: &0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::recording::Recording<T0, T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::composition::uid_mut<T1>(arg0, arg1);
        let v1 = ExtensionKey<T0>{dummy_field: false};
        assert!(!0x2::dynamic_field::exists<ExtensionKey<T0>>(v0, v1), 0);
        let v2 = ExtensionKey<T0>{dummy_field: false};
        0x2::dynamic_field::add<ExtensionKey<T0>, 0xe36d2eead5e0085524a04b07a7a8c23667f358174c13d4ddfcba7cf4afcf5b12::stake::Stake<T0>>(v0, v2, 0xe36d2eead5e0085524a04b07a7a8c23667f358174c13d4ddfcba7cf4afcf5b12::stake::new<T0>(0xda970ab921b4edaabee40a04c3c73204e3eab88a14bfc310e79220a4506eb6b8::hikida::redeem_balance<T0>(v0, arg3), arg4));
    }

    public fun has_stake<T0, T1>(arg0: &0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::composition::Composition<T1>) : bool {
        let v0 = ExtensionKey<T0>{dummy_field: false};
        0x2::dynamic_field::exists<ExtensionKey<T0>>(0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::composition::uid<T1>(arg0), v0)
    }

    public fun register<T0, T1, T2>(arg0: &mut 0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::composition::Composition<T1>, arg1: &0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::composition::CompositionAdminCap<T1>, arg2: &0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::recording::Recording<T0, T1>, arg3: &mut 0xe36d2eead5e0085524a04b07a7a8c23667f358174c13d4ddfcba7cf4afcf5b12::pool::RoyaltyPool<T0, T2>) {
        assert_pool_for_recording<T0, T2>(arg3, 0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::recording::id<T0, T1>(arg2));
        let v0 = 0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::composition::uid_mut<T1>(arg0, arg1);
        let v1 = ExtensionKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists<ExtensionKey<T0>>(v0, v1), 1);
        let v2 = ExtensionKey<T0>{dummy_field: false};
        0xe36d2eead5e0085524a04b07a7a8c23667f358174c13d4ddfcba7cf4afcf5b12::pool::register_stake<T0, T2>(arg3, 0x2::dynamic_field::borrow_mut<ExtensionKey<T0>, 0xe36d2eead5e0085524a04b07a7a8c23667f358174c13d4ddfcba7cf4afcf5b12::stake::Stake<T0>>(v0, v2));
    }

    public fun unregister<T0, T1, T2>(arg0: &mut 0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::composition::Composition<T1>, arg1: &0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::composition::CompositionAdminCap<T1>, arg2: &mut 0xe36d2eead5e0085524a04b07a7a8c23667f358174c13d4ddfcba7cf4afcf5b12::pool::RoyaltyPool<T0, T2>) {
        let v0 = 0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::composition::uid_mut<T1>(arg0, arg1);
        let v1 = ExtensionKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists<ExtensionKey<T0>>(v0, v1), 1);
        let v2 = ExtensionKey<T0>{dummy_field: false};
        0xe36d2eead5e0085524a04b07a7a8c23667f358174c13d4ddfcba7cf4afcf5b12::pool::unregister_stake<T0, T2>(arg2, 0x2::dynamic_field::borrow_mut<ExtensionKey<T0>, 0xe36d2eead5e0085524a04b07a7a8c23667f358174c13d4ddfcba7cf4afcf5b12::stake::Stake<T0>>(v0, v2));
    }

    public fun unstake<T0, T1>(arg0: &mut 0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::composition::Composition<T1>, arg1: &0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::composition::CompositionAdminCap<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::composition::uid_mut<T1>(arg0, arg1);
        let v1 = ExtensionKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists<ExtensionKey<T0>>(v0, v1), 1);
        let v2 = ExtensionKey<T0>{dummy_field: false};
        0x2::coin::from_balance<T0>(0xe36d2eead5e0085524a04b07a7a8c23667f358174c13d4ddfcba7cf4afcf5b12::stake::destroy<T0>(0x2::dynamic_field::remove<ExtensionKey<T0>, 0xe36d2eead5e0085524a04b07a7a8c23667f358174c13d4ddfcba7cf4afcf5b12::stake::Stake<T0>>(v0, v2)), arg2)
    }

    // decompiled from Move bytecode v7
}

