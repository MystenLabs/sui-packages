module 0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::pool_creator {
    public fun create_pool_v2<T0, T1>(arg0: &0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::config::GlobalConfig, arg1: &mut 0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::factory::Pools, arg2: u32, arg3: u128, arg4: 0x1::string::String, arg5: u32, arg6: u32, arg7: 0x2::coin::Coin<T0>, arg8: 0x2::coin::Coin<T1>, arg9: &0x2::coin::CoinMetadata<T0>, arg10: &0x2::coin::CoinMetadata<T1>, arg11: bool, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : (0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::position::Position, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        abort 0
    }

    public fun create_pool_v2_by_creation_cap<T0, T1>(arg0: &0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::config::GlobalConfig, arg1: &mut 0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::factory::Pools, arg2: &0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::factory::PoolCreationCap, arg3: u32, arg4: u128, arg5: 0x1::string::String, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<T1>, arg8: &0x2::coin::CoinMetadata<T0>, arg9: &0x2::coin::CoinMetadata<T1>, arg10: bool, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : (0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::position::Position, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        abort 0
    }

    public fun create_pool_v2_with_creation_cap<T0, T1>(arg0: &0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::config::GlobalConfig, arg1: &mut 0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::factory::Pools, arg2: &0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::factory::PoolCreationCap, arg3: u32, arg4: u128, arg5: 0x1::string::String, arg6: u32, arg7: u32, arg8: 0x2::coin::Coin<T0>, arg9: 0x2::coin::Coin<T1>, arg10: &0x2::coin::CoinMetadata<T0>, arg11: &0x2::coin::CoinMetadata<T1>, arg12: bool, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : (0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::position::Position, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        abort 0
    }

    public fun full_range_tick_range(arg0: u32) : (u32, u32) {
        abort 0
    }

    // decompiled from Move bytecode v6
}

