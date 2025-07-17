module 0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::gateway {
    public entry fun close_position<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::config::GlobalConfig, arg2: &mut 0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::pool::Pool<T0, T1>, arg3: 0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::position::Position, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun collect_fee<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::config::GlobalConfig, arg2: &mut 0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::pool::Pool<T0, T1>, arg3: &mut 0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::position::Position, arg4: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun collect_reward<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::config::GlobalConfig, arg2: &mut 0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::pool::Pool<T0, T1>, arg3: &mut 0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::position::Position, arg4: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun create_pool<T0, T1>(arg0: &0x2::clock::Clock, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u8, arg5: vector<u8>, arg6: vector<u8>, arg7: u8, arg8: vector<u8>, arg9: u32, arg10: u64, arg11: u128, arg12: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun create_pool_v2<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::config::GlobalConfig, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u8, arg6: vector<u8>, arg7: vector<u8>, arg8: u8, arg9: vector<u8>, arg10: u32, arg11: u64, arg12: u128, arg13: 0x2::coin::Coin<T2>, arg14: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun flash_swap<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::config::GlobalConfig, arg2: &mut 0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: bool, arg6: bool, arg7: u64, arg8: u64, arg9: u128, arg10: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun provide_liquidity<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::config::GlobalConfig, arg2: &mut 0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::pool::Pool<T0, T1>, arg3: &mut 0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::position::Position, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: u64, arg8: u128, arg9: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun provide_liquidity_with_fixed_amount<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::config::GlobalConfig, arg2: &mut 0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::pool::Pool<T0, T1>, arg3: &mut 0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::position::Position, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: u64, arg8: u64, arg9: bool, arg10: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun remove_liquidity<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::config::GlobalConfig, arg2: &mut 0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::pool::Pool<T0, T1>, arg3: &mut 0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::position::Position, arg4: u128, arg5: u64, arg6: u64, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun route_swap<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::config::GlobalConfig, arg2: &mut 0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: bool, arg6: bool, arg7: bool, arg8: u64, arg9: u64, arg10: u128, arg11: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        abort 0
    }

    public entry fun swap_assets<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::config::GlobalConfig, arg2: &mut 0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: bool, arg6: bool, arg7: u64, arg8: u64, arg9: u128, arg10: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    // decompiled from Move bytecode v6
}

