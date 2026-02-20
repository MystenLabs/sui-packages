module 0xe6a6db859f37164239ee615845d33eb2ed5bcda176c911de7db9898ed0413c35::position_vault_flow {
    public fun withdraw_remove_and_send_by_id<T0, T1>(arg0: &0xe6a6db859f37164239ee615845d33eb2ed5bcda176c911de7db9898ed0413c35::admin_guard_pkg::AdminCap, arg1: &mut 0xe6a6db859f37164239ee615845d33eb2ed5bcda176c911de7db9898ed0413c35::position_vault::PositionVault, arg2: address, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg7: u128, arg8: u64, arg9: u64, arg10: address, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xe6a6db859f37164239ee615845d33eb2ed5bcda176c911de7db9898ed0413c35::position_vault::withdraw_by_id(arg0, arg1, arg2, arg3);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::gateway::remove_liquidity<T0, T1>(arg4, arg5, arg6, &mut v0, arg7, arg8, arg9, arg10, arg11);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v0, 0x2::tx_context::sender(arg11));
    }

    public fun withdraw_remove_and_send_first<T0, T1>(arg0: &0xe6a6db859f37164239ee615845d33eb2ed5bcda176c911de7db9898ed0413c35::admin_guard_pkg::AdminCap, arg1: &mut 0xe6a6db859f37164239ee615845d33eb2ed5bcda176c911de7db9898ed0413c35::position_vault::PositionVault, arg2: address, arg3: &0x2::clock::Clock, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg6: u128, arg7: u64, arg8: u64, arg9: address, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xe6a6db859f37164239ee615845d33eb2ed5bcda176c911de7db9898ed0413c35::position_vault::withdraw_first(arg0, arg1, arg2);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::gateway::remove_liquidity<T0, T1>(arg3, arg4, arg5, &mut v0, arg6, arg7, arg8, arg9, arg10);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v0, 0x2::tx_context::sender(arg10));
    }

    // decompiled from Move bytecode v6
}

