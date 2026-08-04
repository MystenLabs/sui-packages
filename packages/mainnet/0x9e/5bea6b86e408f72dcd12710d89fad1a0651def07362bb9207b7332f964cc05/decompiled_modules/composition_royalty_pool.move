module 0x9e5bea6b86e408f72dcd12710d89fad1a0651def07362bb9207b7332f964cc05::composition_royalty_pool {
    fun assert_pool_for_composition<T0, T1>(arg0: &0xe36d2eead5e0085524a04b07a7a8c23667f358174c13d4ddfcba7cf4afcf5b12::pool::RoyaltyPool<T0, T1>, arg1: 0x2::object::ID) {
        let v0 = 0xe36d2eead5e0085524a04b07a7a8c23667f358174c13d4ddfcba7cf4afcf5b12::pool::id<T0, T1>(arg0);
        assert!(0x2::object::id_to_address(&v0) == 0xe36d2eead5e0085524a04b07a7a8c23667f358174c13d4ddfcba7cf4afcf5b12::pool::derived_address<T1>(arg1), 0);
    }

    public fun initialize_pool<T0, T1>(arg0: &mut 0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::composition::Composition<T0>, arg1: &0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::composition::CompositionAdminCap<T0>) : 0xe36d2eead5e0085524a04b07a7a8c23667f358174c13d4ddfcba7cf4afcf5b12::pool::RoyaltyPool<T0, T1> {
        0xe36d2eead5e0085524a04b07a7a8c23667f358174c13d4ddfcba7cf4afcf5b12::pool::new<T0, T1>(0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::composition::uid_mut<T0>(arg0, arg1))
    }

    public fun receive_and_deposit<T0, T1>(arg0: &mut 0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::composition::Composition<T0>, arg1: &0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::composition::CompositionAdminCap<T0>, arg2: vector<0x2::transfer::Receiving<0x2::coin::Coin<T1>>>, arg3: &mut 0xe36d2eead5e0085524a04b07a7a8c23667f358174c13d4ddfcba7cf4afcf5b12::pool::RoyaltyPool<T0, T1>) {
        assert_pool_for_composition<T0, T1>(arg3, 0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::composition::id<T0>(arg0));
        0xe36d2eead5e0085524a04b07a7a8c23667f358174c13d4ddfcba7cf4afcf5b12::pool::deposit<T0, T1>(arg3, 0xda970ab921b4edaabee40a04c3c73204e3eab88a14bfc310e79220a4506eb6b8::hikida::receive_balance<T1>(0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::composition::uid_mut<T0>(arg0, arg1), arg2));
    }

    public fun redeem_and_deposit<T0, T1>(arg0: &mut 0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::composition::Composition<T0>, arg1: &0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::composition::CompositionAdminCap<T0>, arg2: u64, arg3: &mut 0xe36d2eead5e0085524a04b07a7a8c23667f358174c13d4ddfcba7cf4afcf5b12::pool::RoyaltyPool<T0, T1>) {
        assert_pool_for_composition<T0, T1>(arg3, 0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::composition::id<T0>(arg0));
        0xe36d2eead5e0085524a04b07a7a8c23667f358174c13d4ddfcba7cf4afcf5b12::pool::deposit<T0, T1>(arg3, 0xda970ab921b4edaabee40a04c3c73204e3eab88a14bfc310e79220a4506eb6b8::hikida::redeem_balance<T1>(0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::composition::uid_mut<T0>(arg0, arg1), arg2));
    }

    // decompiled from Move bytecode v7
}

