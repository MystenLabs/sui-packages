module 0xee813bb28106ed341c7d1e23ee3d4ab347bcde65275c326b9a90e45e87dc62ce::withdraw {
    public entry fun add_request_as_object<T0, T1, T2, T3: key>(arg0: &mut 0xee813bb28106ed341c7d1e23ee3d4ab347bcde65275c326b9a90e45e87dc62ce::vault::Vault<T0, T1, T2>, arg1: 0x2::coin::Coin<T2>, arg2: &0xee813bb28106ed341c7d1e23ee3d4ab347bcde65275c326b9a90e45e87dc62ce::version::Version, arg3: &T3) {
        0xee813bb28106ed341c7d1e23ee3d4ab347bcde65275c326b9a90e45e87dc62ce::version::assert_current_version(arg2);
        let v0 = 0x2::object::id<T3>(arg3);
        0xee813bb28106ed341c7d1e23ee3d4ab347bcde65275c326b9a90e45e87dc62ce::vault::add_withdraw_request<T0, T1, T2>(arg0, arg1, 0x2::object::id_to_address(&v0), 0xee813bb28106ed341c7d1e23ee3d4ab347bcde65275c326b9a90e45e87dc62ce::constants::request_from_object());
    }

    public entry fun add_request_as_user<T0, T1, T2>(arg0: &mut 0xee813bb28106ed341c7d1e23ee3d4ab347bcde65275c326b9a90e45e87dc62ce::vault::Vault<T0, T1, T2>, arg1: 0x2::coin::Coin<T2>, arg2: &0xee813bb28106ed341c7d1e23ee3d4ab347bcde65275c326b9a90e45e87dc62ce::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0xee813bb28106ed341c7d1e23ee3d4ab347bcde65275c326b9a90e45e87dc62ce::version::assert_current_version(arg2);
        0xee813bb28106ed341c7d1e23ee3d4ab347bcde65275c326b9a90e45e87dc62ce::vault::add_withdraw_request<T0, T1, T2>(arg0, arg1, 0x2::tx_context::sender(arg3), 0xee813bb28106ed341c7d1e23ee3d4ab347bcde65275c326b9a90e45e87dc62ce::constants::request_from_user());
    }

    public entry fun claim_as_object<T0, T1, T2, T3: key>(arg0: &mut 0xee813bb28106ed341c7d1e23ee3d4ab347bcde65275c326b9a90e45e87dc62ce::vault::Vault<T0, T1, T2>, arg1: &T3, arg2: &0xee813bb28106ed341c7d1e23ee3d4ab347bcde65275c326b9a90e45e87dc62ce::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0xee813bb28106ed341c7d1e23ee3d4ab347bcde65275c326b9a90e45e87dc62ce::version::assert_current_version(arg2);
        let v0 = 0x2::object::id<T3>(arg1);
        let v1 = 0x2::object::id_to_address(&v0);
        let (v2, v3) = 0xee813bb28106ed341c7d1e23ee3d4ab347bcde65275c326b9a90e45e87dc62ce::vault::claim_withdrawal<T0, T1, T2>(arg0, v1, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v3, v1);
    }

    public entry fun claim_as_user<T0, T1, T2>(arg0: &mut 0xee813bb28106ed341c7d1e23ee3d4ab347bcde65275c326b9a90e45e87dc62ce::vault::Vault<T0, T1, T2>, arg1: &0xee813bb28106ed341c7d1e23ee3d4ab347bcde65275c326b9a90e45e87dc62ce::version::Version, arg2: &mut 0x2::tx_context::TxContext) {
        0xee813bb28106ed341c7d1e23ee3d4ab347bcde65275c326b9a90e45e87dc62ce::version::assert_current_version(arg1);
        let v0 = 0x2::tx_context::sender(arg2);
        let (v1, v2) = 0xee813bb28106ed341c7d1e23ee3d4ab347bcde65275c326b9a90e45e87dc62ce::vault::claim_withdrawal<T0, T1, T2>(arg0, v0, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, v0);
    }

    public entry fun process_queue<T0, T1, T2>(arg0: &mut 0xee813bb28106ed341c7d1e23ee3d4ab347bcde65275c326b9a90e45e87dc62ce::vault::Vault<T0, T1, T2>, arg1: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg2: &0xee813bb28106ed341c7d1e23ee3d4ab347bcde65275c326b9a90e45e87dc62ce::version::Version, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0xee813bb28106ed341c7d1e23ee3d4ab347bcde65275c326b9a90e45e87dc62ce::version::assert_current_version(arg2);
        0xee813bb28106ed341c7d1e23ee3d4ab347bcde65275c326b9a90e45e87dc62ce::vault::process_withdrawals<T0, T1, T2>(arg0, arg1, arg4, arg3, arg5);
    }

    // decompiled from Move bytecode v6
}

