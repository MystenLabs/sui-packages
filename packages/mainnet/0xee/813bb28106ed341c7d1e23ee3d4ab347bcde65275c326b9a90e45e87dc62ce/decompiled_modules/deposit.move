module 0xee813bb28106ed341c7d1e23ee3d4ab347bcde65275c326b9a90e45e87dc62ce::deposit {
    public entry fun add_request_as_object<T0, T1, T2, T3: key>(arg0: &mut 0xee813bb28106ed341c7d1e23ee3d4ab347bcde65275c326b9a90e45e87dc62ce::vault::Vault<T0, T1, T2>, arg1: 0x2::coin::Coin<T1>, arg2: &0xee813bb28106ed341c7d1e23ee3d4ab347bcde65275c326b9a90e45e87dc62ce::version::Version, arg3: &T3) {
        0xee813bb28106ed341c7d1e23ee3d4ab347bcde65275c326b9a90e45e87dc62ce::version::assert_current_version(arg2);
        let v0 = 0x2::object::id<T3>(arg3);
        0xee813bb28106ed341c7d1e23ee3d4ab347bcde65275c326b9a90e45e87dc62ce::vault::add_deposit_request<T0, T1, T2>(arg0, 0x2::coin::into_balance<T1>(arg1), 0x2::object::id_to_address(&v0), 0xee813bb28106ed341c7d1e23ee3d4ab347bcde65275c326b9a90e45e87dc62ce::constants::request_from_object());
    }

    public entry fun add_request_as_user<T0, T1, T2>(arg0: &mut 0xee813bb28106ed341c7d1e23ee3d4ab347bcde65275c326b9a90e45e87dc62ce::vault::Vault<T0, T1, T2>, arg1: 0x2::coin::Coin<T1>, arg2: &0xee813bb28106ed341c7d1e23ee3d4ab347bcde65275c326b9a90e45e87dc62ce::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0xee813bb28106ed341c7d1e23ee3d4ab347bcde65275c326b9a90e45e87dc62ce::version::assert_current_version(arg2);
        0xee813bb28106ed341c7d1e23ee3d4ab347bcde65275c326b9a90e45e87dc62ce::vault::add_deposit_request<T0, T1, T2>(arg0, 0x2::coin::into_balance<T1>(arg1), 0x2::tx_context::sender(arg3), 0xee813bb28106ed341c7d1e23ee3d4ab347bcde65275c326b9a90e45e87dc62ce::constants::request_from_user());
    }

    public fun consume_receipt_and_deposit_assets<T0, T1, T2>(arg0: &mut 0xee813bb28106ed341c7d1e23ee3d4ab347bcde65275c326b9a90e45e87dc62ce::vault::Vault<T0, T1, T2>, arg1: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg2: 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt, arg3: &0xee813bb28106ed341c7d1e23ee3d4ab347bcde65275c326b9a90e45e87dc62ce::vault_acl::VaultAcl, arg4: &mut 0x2::tx_context::TxContext) {
        0xee813bb28106ed341c7d1e23ee3d4ab347bcde65275c326b9a90e45e87dc62ce::vault::consume_receipt_and_deposit_assets<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4);
    }

    public fun process_deposited_balance<T0, T1, T2>(arg0: &mut 0xee813bb28106ed341c7d1e23ee3d4ab347bcde65275c326b9a90e45e87dc62ce::vault::Vault<T0, T1, T2>, arg1: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg2: &0xee813bb28106ed341c7d1e23ee3d4ab347bcde65275c326b9a90e45e87dc62ce::vault_acl::VaultAcl, arg3: &0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::acl::RouterAcl, arg4: &mut 0x2::tx_context::TxContext) : 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt {
        0xee813bb28106ed341c7d1e23ee3d4ab347bcde65275c326b9a90e45e87dc62ce::vault::process_deposited_balance<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4)
    }

    public entry fun process_queue<T0, T1, T2>(arg0: &mut 0xee813bb28106ed341c7d1e23ee3d4ab347bcde65275c326b9a90e45e87dc62ce::vault::Vault<T0, T1, T2>, arg1: &0xee813bb28106ed341c7d1e23ee3d4ab347bcde65275c326b9a90e45e87dc62ce::version::Version, arg2: &0xee813bb28106ed341c7d1e23ee3d4ab347bcde65275c326b9a90e45e87dc62ce::vault_acl::VaultAcl, arg3: &0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::acl::RouterAcl, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0xee813bb28106ed341c7d1e23ee3d4ab347bcde65275c326b9a90e45e87dc62ce::version::assert_current_version(arg1);
        0xee813bb28106ed341c7d1e23ee3d4ab347bcde65275c326b9a90e45e87dc62ce::vault::process_undistributed_lp_tokens<T0, T1, T2>(arg0, arg2, arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

