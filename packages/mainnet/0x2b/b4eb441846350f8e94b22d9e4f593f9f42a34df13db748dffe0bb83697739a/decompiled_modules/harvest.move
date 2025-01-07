module 0x2bb4eb441846350f8e94b22d9e4f593f9f42a34df13db748dffe0bb83697739a::harvest {
    struct RewardsHarvestedEvent has copy, drop, store {
        vault_id: 0x2::object::ID,
        total_deposited_a: u64,
        total_borrowed_b: u64,
        aum_in_a: u64,
        total_lp_supply: u64,
    }

    public fun issue_harvest_receipt<T0, T1, T2, T3>(arg0: &mut 0x2bb4eb441846350f8e94b22d9e4f593f9f42a34df13db748dffe0bb83697739a::vault::Vault<T0, T1, T2>, arg1: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg2: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg3: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg5: &0x2bb4eb441846350f8e94b22d9e4f593f9f42a34df13db748dffe0bb83697739a::vault_acl::VaultAcl, arg6: &0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::acl::RouterAcl, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt {
        let v0 = 0x2bb4eb441846350f8e94b22d9e4f593f9f42a34df13db748dffe0bb83697739a::vault::get_swap_route<T0, T1, T2, T3>(arg0);
        let v1 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::issue<0x2bb4eb441846350f8e94b22d9e4f593f9f42a34df13db748dffe0bb83697739a::vault_acl::Access>(0x2bb4eb441846350f8e94b22d9e4f593f9f42a34df13db748dffe0bb83697739a::vault_acl::access(arg5), 0x1::option::some<0x2::object::ID>(0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::acl::access_id(arg6)), arg8);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x2::coin::Coin<T3>, 0x2bb4eb441846350f8e94b22d9e4f593f9f42a34df13db748dffe0bb83697739a::vault_acl::Access>(&mut v1, 0x2bb4eb441846350f8e94b22d9e4f593f9f42a34df13db748dffe0bb83697739a::vault_acl::access(arg5), b"funds", 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::redeem_rewards<T3>(arg1, arg2, arg3, 0x2bb4eb441846350f8e94b22d9e4f593f9f42a34df13db748dffe0bb83697739a::vault::obligation_key_mut<T0, T1, T2>(arg0), arg4, arg7, arg8));
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u8, 0x2bb4eb441846350f8e94b22d9e4f593f9f42a34df13db748dffe0bb83697739a::vault_acl::Access>(&mut v1, 0x2bb4eb441846350f8e94b22d9e4f593f9f42a34df13db748dffe0bb83697739a::vault_acl::access(arg5), b"current_index", 0);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u8, 0x2bb4eb441846350f8e94b22d9e4f593f9f42a34df13db748dffe0bb83697739a::vault_acl::Access>(&mut v1, 0x2bb4eb441846350f8e94b22d9e4f593f9f42a34df13db748dffe0bb83697739a::vault_acl::access(arg5), b"final_index", ((0x1::vector::length<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&v0) - 1) as u8));
        while (!0x1::vector::is_empty<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&v0)) {
            0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<u8, 0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value, 0x2bb4eb441846350f8e94b22d9e4f593f9f42a34df13db748dffe0bb83697739a::vault_acl::Access>(&mut v1, 0x2bb4eb441846350f8e94b22d9e4f593f9f42a34df13db748dffe0bb83697739a::vault_acl::access(arg5), (0x1::vector::length<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&v0) as u8), 0x1::vector::pop_back<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&mut v0));
        };
        0x1::vector::destroy_empty<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(v0);
        v1
    }

    // decompiled from Move bytecode v6
}

