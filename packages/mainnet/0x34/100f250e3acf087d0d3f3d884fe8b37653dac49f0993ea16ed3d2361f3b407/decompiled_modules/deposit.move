module 0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::deposit {
    public entry fun add_request_as_object<T0, T1, T2, T3: key>(arg0: &mut 0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::vault::Vault<T0, T1, T2>, arg1: 0x2::coin::Coin<T1>, arg2: &0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::version::Version, arg3: &T3) {
        0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::version::assert_current_version(arg2);
        let v0 = 0x2::object::id<T3>(arg3);
        0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::vault::add_deposit_request<T0, T1, T2>(arg0, 0x2::coin::into_balance<T1>(arg1), 0x2::object::id_to_address(&v0), 0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::constants::request_from_object());
    }

    public entry fun add_request_as_user<T0, T1, T2>(arg0: &mut 0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::vault::Vault<T0, T1, T2>, arg1: 0x2::coin::Coin<T1>, arg2: &0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::version::assert_current_version(arg2);
        0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::vault::add_deposit_request<T0, T1, T2>(arg0, 0x2::coin::into_balance<T1>(arg1), 0x2::tx_context::sender(arg3), 0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::constants::request_from_user());
    }

    public entry fun process_queue<T0, T1, T2>(arg0: &mut 0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::vault::Vault<T0, T1, T2>, arg1: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::version::Version, arg5: &0x2::clock::Clock, arg6: &0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::vault_acl::VaultAcl, arg7: &0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::acl::RouterAcl, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::version::assert_current_version(arg4);
        0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::vault::process_deposits<T0, T1, T2>(arg0, arg1, arg2, arg3, arg5, arg6, arg7, arg8, arg9);
    }

    // decompiled from Move bytecode v6
}

