module 0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::withdraw {
    public entry fun add_request_as_object<T0, T1, T2, T3: key>(arg0: &mut 0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::vault::Vault<T0, T1, T2>, arg1: 0x2::coin::Coin<T2>, arg2: &0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::version::Version, arg3: &T3) {
        0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::version::assert_current_version(arg2);
        let v0 = 0x2::object::id<T3>(arg3);
        0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::vault::add_withdraw_request<T0, T1, T2>(arg0, arg1, 0x2::object::id_to_address(&v0), 0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::constants::request_from_object());
    }

    public entry fun add_request_as_user<T0, T1, T2>(arg0: &mut 0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::vault::Vault<T0, T1, T2>, arg1: 0x2::coin::Coin<T2>, arg2: &0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::version::assert_current_version(arg2);
        0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::vault::add_withdraw_request<T0, T1, T2>(arg0, arg1, 0x2::tx_context::sender(arg3), 0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::constants::request_from_user());
    }

    public entry fun claim_as_object<T0, T1, T2, T3: key>(arg0: &mut 0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::vault::Vault<T0, T1, T2>, arg1: &T3, arg2: &0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::version::assert_current_version(arg2);
        let v0 = 0x2::object::id<T3>(arg1);
        let v1 = 0x2::object::id_to_address(&v0);
        let (v2, v3) = 0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::vault::claim_withdrawal<T0, T1, T2>(arg0, v1, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v3, v1);
    }

    public entry fun claim_as_user<T0, T1, T2>(arg0: &mut 0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::vault::Vault<T0, T1, T2>, arg1: &0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::version::Version, arg2: &mut 0x2::tx_context::TxContext) {
        0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::version::assert_current_version(arg1);
        let v0 = 0x2::tx_context::sender(arg2);
        let (v1, v2) = 0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::vault::claim_withdrawal<T0, T1, T2>(arg0, v0, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, v0);
    }

    public entry fun process_queue<T0, T1, T2>(arg0: &mut 0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::vault::Vault<T0, T1, T2>, arg1: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg2: &0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::version::Version, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::version::assert_current_version(arg2);
        0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::vault::process_withdrawals<T0, T1, T2>(arg0, arg1, arg4, arg3, arg5);
    }

    // decompiled from Move bytecode v6
}

