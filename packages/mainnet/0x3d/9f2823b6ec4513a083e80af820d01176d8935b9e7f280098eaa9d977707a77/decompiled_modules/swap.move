module 0x3d9f2823b6ec4513a083e80af820d01176d8935b9e7f280098eaa9d977707a77::swap {
    public fun add_swap_route<T0, T1, T2>(arg0: &0x3d9f2823b6ec4513a083e80af820d01176d8935b9e7f280098eaa9d977707a77::vault::VaultCap, arg1: &mut 0x3d9f2823b6ec4513a083e80af820d01176d8935b9e7f280098eaa9d977707a77::vault::Vault<T0, T1, T2>, arg2: vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>, arg3: &0x3d9f2823b6ec4513a083e80af820d01176d8935b9e7f280098eaa9d977707a77::version::Version) {
        0x3d9f2823b6ec4513a083e80af820d01176d8935b9e7f280098eaa9d977707a77::version::assert_current_version(arg3);
        0x3d9f2823b6ec4513a083e80af820d01176d8935b9e7f280098eaa9d977707a77::vault::check_vault_cap_compatibility<T0, T1, T2>(arg0, arg1);
        0x3d9f2823b6ec4513a083e80af820d01176d8935b9e7f280098eaa9d977707a77::vault::add_swap_route<T0, T1, T2>(arg1, arg2);
    }

    public fun remove_swap_route<T0, T1, T2>(arg0: &0x3d9f2823b6ec4513a083e80af820d01176d8935b9e7f280098eaa9d977707a77::vault::VaultCap, arg1: &mut 0x3d9f2823b6ec4513a083e80af820d01176d8935b9e7f280098eaa9d977707a77::vault::Vault<T0, T1, T2>, arg2: &0x3d9f2823b6ec4513a083e80af820d01176d8935b9e7f280098eaa9d977707a77::version::Version) {
        0x3d9f2823b6ec4513a083e80af820d01176d8935b9e7f280098eaa9d977707a77::version::assert_current_version(arg2);
        0x3d9f2823b6ec4513a083e80af820d01176d8935b9e7f280098eaa9d977707a77::vault::check_vault_cap_compatibility<T0, T1, T2>(arg0, arg1);
        0x3d9f2823b6ec4513a083e80af820d01176d8935b9e7f280098eaa9d977707a77::vault::remove_swap_route<T0, T1, T2>(arg1);
    }

    // decompiled from Move bytecode v6
}

