module 0x26a018a4bf534acf396730051e2391023dd7d7991404c4e6f5a6b8417ab081fc::deposit {
    public entry fun add_request_as_object<T0, T1, T2, T3: key>(arg0: &mut 0x26a018a4bf534acf396730051e2391023dd7d7991404c4e6f5a6b8417ab081fc::vault::Vault<T0, T1, T2>, arg1: 0x2::coin::Coin<T1>, arg2: &0x26a018a4bf534acf396730051e2391023dd7d7991404c4e6f5a6b8417ab081fc::version::Version, arg3: &T3) {
        0x26a018a4bf534acf396730051e2391023dd7d7991404c4e6f5a6b8417ab081fc::version::assert_current_version(arg2);
        let v0 = 0x2::object::id<T3>(arg3);
        0x26a018a4bf534acf396730051e2391023dd7d7991404c4e6f5a6b8417ab081fc::vault::add_deposit_request<T0, T1, T2>(arg0, 0x2::coin::into_balance<T1>(arg1), 0x2::object::id_to_address(&v0), 0x26a018a4bf534acf396730051e2391023dd7d7991404c4e6f5a6b8417ab081fc::constants::request_from_object());
    }

    public entry fun add_request_as_user<T0, T1, T2>(arg0: &mut 0x26a018a4bf534acf396730051e2391023dd7d7991404c4e6f5a6b8417ab081fc::vault::Vault<T0, T1, T2>, arg1: 0x2::coin::Coin<T1>, arg2: &0x26a018a4bf534acf396730051e2391023dd7d7991404c4e6f5a6b8417ab081fc::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x26a018a4bf534acf396730051e2391023dd7d7991404c4e6f5a6b8417ab081fc::version::assert_current_version(arg2);
        0x26a018a4bf534acf396730051e2391023dd7d7991404c4e6f5a6b8417ab081fc::vault::add_deposit_request<T0, T1, T2>(arg0, 0x2::coin::into_balance<T1>(arg1), 0x2::tx_context::sender(arg3), 0x26a018a4bf534acf396730051e2391023dd7d7991404c4e6f5a6b8417ab081fc::constants::request_from_user());
    }

    public entry fun process_queue<T0, T1, T2>(arg0: &mut 0x26a018a4bf534acf396730051e2391023dd7d7991404c4e6f5a6b8417ab081fc::vault::Vault<T0, T1, T2>, arg1: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg2: &0x26a018a4bf534acf396730051e2391023dd7d7991404c4e6f5a6b8417ab081fc::version::Version, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x26a018a4bf534acf396730051e2391023dd7d7991404c4e6f5a6b8417ab081fc::version::assert_current_version(arg2);
        0x26a018a4bf534acf396730051e2391023dd7d7991404c4e6f5a6b8417ab081fc::vault::process_deposits<T0, T1, T2>(arg0, arg1, arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

