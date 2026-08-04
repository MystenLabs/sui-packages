module 0xf3ade246100d76d8fb8d9634882526b0ec10c2b443ec0db82def8af132230729::composition_recording_stake {
    struct ExtensionKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    fun assert_pool_for_recording<T0, T1>(arg0: &0xe36d2eead5e0085524a04b07a7a8c23667f358174c13d4ddfcba7cf4afcf5b12::pool::RoyaltyPool<T0, T1>, arg1: 0x2::object::ID) {
        let v0 = 0xe36d2eead5e0085524a04b07a7a8c23667f358174c13d4ddfcba7cf4afcf5b12::pool::id<T0, T1>(arg0);
        assert!(0x2::object::id_to_address(&v0) == 0xe36d2eead5e0085524a04b07a7a8c23667f358174c13d4ddfcba7cf4afcf5b12::pool::derived_address<T1>(arg1), 2);
    }

    public fun claim<T0, T1, T2>(arg0: &mut 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::composition::Composition<T1>, arg1: &0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::composition::CompositionAdminCap<T1>, arg2: &mut 0xe36d2eead5e0085524a04b07a7a8c23667f358174c13d4ddfcba7cf4afcf5b12::pool::RoyaltyPool<T0, T2>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let v0 = 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::composition::uid_mut<T1>(arg0, arg1);
        let v1 = ExtensionKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists<ExtensionKey<T0>>(v0, v1), 1);
        let v2 = ExtensionKey<T0>{dummy_field: false};
        0x2::coin::from_balance<T2>(0xe36d2eead5e0085524a04b07a7a8c23667f358174c13d4ddfcba7cf4afcf5b12::pool::claim_rewards<T0, T2>(arg2, 0x2::dynamic_field::borrow_mut<ExtensionKey<T0>, 0xe36d2eead5e0085524a04b07a7a8c23667f358174c13d4ddfcba7cf4afcf5b12::stake::Stake<T0>>(v0, v2)), arg3)
    }

    public fun create_stake<T0, T1>(arg0: &mut 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::composition::Composition<T1>, arg1: &0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::composition::CompositionAdminCap<T1>, arg2: &0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::recording::Recording<T0, T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::composition::uid_mut<T1>(arg0, arg1);
        let v1 = ExtensionKey<T0>{dummy_field: false};
        assert!(!0x2::dynamic_field::exists<ExtensionKey<T0>>(v0, v1), 0);
        let v2 = ExtensionKey<T0>{dummy_field: false};
        0x2::dynamic_field::add<ExtensionKey<T0>, 0xe36d2eead5e0085524a04b07a7a8c23667f358174c13d4ddfcba7cf4afcf5b12::stake::Stake<T0>>(v0, v2, 0xe36d2eead5e0085524a04b07a7a8c23667f358174c13d4ddfcba7cf4afcf5b12::stake::new<T0>(0xda970ab921b4edaabee40a04c3c73204e3eab88a14bfc310e79220a4506eb6b8::hikida::redeem_balance<T0>(v0, arg3), arg4));
    }

    public fun has_stake<T0, T1>(arg0: &0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::composition::Composition<T1>) : bool {
        let v0 = ExtensionKey<T0>{dummy_field: false};
        0x2::dynamic_field::exists<ExtensionKey<T0>>(0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::composition::uid<T1>(arg0), v0)
    }

    public fun register<T0, T1, T2>(arg0: &mut 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::composition::Composition<T1>, arg1: &0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::composition::CompositionAdminCap<T1>, arg2: &0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::recording::Recording<T0, T1>, arg3: &mut 0xe36d2eead5e0085524a04b07a7a8c23667f358174c13d4ddfcba7cf4afcf5b12::pool::RoyaltyPool<T0, T2>) {
        assert_pool_for_recording<T0, T2>(arg3, 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::recording::id<T0, T1>(arg2));
        let v0 = 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::composition::uid_mut<T1>(arg0, arg1);
        let v1 = ExtensionKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists<ExtensionKey<T0>>(v0, v1), 1);
        let v2 = ExtensionKey<T0>{dummy_field: false};
        0xe36d2eead5e0085524a04b07a7a8c23667f358174c13d4ddfcba7cf4afcf5b12::pool::register_stake<T0, T2>(arg3, 0x2::dynamic_field::borrow_mut<ExtensionKey<T0>, 0xe36d2eead5e0085524a04b07a7a8c23667f358174c13d4ddfcba7cf4afcf5b12::stake::Stake<T0>>(v0, v2));
    }

    public fun unregister<T0, T1, T2>(arg0: &mut 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::composition::Composition<T1>, arg1: &0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::composition::CompositionAdminCap<T1>, arg2: &mut 0xe36d2eead5e0085524a04b07a7a8c23667f358174c13d4ddfcba7cf4afcf5b12::pool::RoyaltyPool<T0, T2>) {
        let v0 = 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::composition::uid_mut<T1>(arg0, arg1);
        let v1 = ExtensionKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists<ExtensionKey<T0>>(v0, v1), 1);
        let v2 = ExtensionKey<T0>{dummy_field: false};
        0xe36d2eead5e0085524a04b07a7a8c23667f358174c13d4ddfcba7cf4afcf5b12::pool::unregister_stake<T0, T2>(arg2, 0x2::dynamic_field::borrow_mut<ExtensionKey<T0>, 0xe36d2eead5e0085524a04b07a7a8c23667f358174c13d4ddfcba7cf4afcf5b12::stake::Stake<T0>>(v0, v2));
    }

    public fun unstake<T0, T1>(arg0: &mut 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::composition::Composition<T1>, arg1: &0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::composition::CompositionAdminCap<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::composition::uid_mut<T1>(arg0, arg1);
        let v1 = ExtensionKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists<ExtensionKey<T0>>(v0, v1), 1);
        let v2 = ExtensionKey<T0>{dummy_field: false};
        0x2::coin::from_balance<T0>(0xe36d2eead5e0085524a04b07a7a8c23667f358174c13d4ddfcba7cf4afcf5b12::stake::destroy<T0>(0x2::dynamic_field::remove<ExtensionKey<T0>, 0xe36d2eead5e0085524a04b07a7a8c23667f358174c13d4ddfcba7cf4afcf5b12::stake::Stake<T0>>(v0, v2)), arg2)
    }

    // decompiled from Move bytecode v7
}

