module 0xfb1de1177b901a16a0558b3e0d7ed8bab2e9ae633747f91a7ad50f65d0eced29::withdraw {
    public entry fun add_request_as_object<T0, T1, T2, T3: key>(arg0: &mut 0xfb1de1177b901a16a0558b3e0d7ed8bab2e9ae633747f91a7ad50f65d0eced29::vault::Vault<T0, T1, T2>, arg1: 0x2::coin::Coin<T2>, arg2: &T3) {
        let v0 = 0x2::object::id<T3>(arg2);
        0xfb1de1177b901a16a0558b3e0d7ed8bab2e9ae633747f91a7ad50f65d0eced29::vault::add_withdraw_request<T0, T1, T2>(arg0, arg1, 0x2::object::id_to_address(&v0), 0xfb1de1177b901a16a0558b3e0d7ed8bab2e9ae633747f91a7ad50f65d0eced29::constants::request_from_object());
    }

    public entry fun add_request_as_user<T0, T1, T2>(arg0: &mut 0xfb1de1177b901a16a0558b3e0d7ed8bab2e9ae633747f91a7ad50f65d0eced29::vault::Vault<T0, T1, T2>, arg1: 0x2::coin::Coin<T2>, arg2: &mut 0x2::tx_context::TxContext) {
        0xfb1de1177b901a16a0558b3e0d7ed8bab2e9ae633747f91a7ad50f65d0eced29::vault::add_withdraw_request<T0, T1, T2>(arg0, arg1, 0x2::tx_context::sender(arg2), 0xfb1de1177b901a16a0558b3e0d7ed8bab2e9ae633747f91a7ad50f65d0eced29::constants::request_from_user());
    }

    public entry fun claim_as_object<T0, T1, T2, T3: key>(arg0: &mut 0xfb1de1177b901a16a0558b3e0d7ed8bab2e9ae633747f91a7ad50f65d0eced29::vault::Vault<T0, T1, T2>, arg1: &T3, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<T3>(arg1);
        let v1 = 0x2::object::id_to_address(&v0);
        let (v2, v3) = 0xfb1de1177b901a16a0558b3e0d7ed8bab2e9ae633747f91a7ad50f65d0eced29::vault::claim_withdrawal<T0, T1, T2>(arg0, v1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v3, v1);
    }

    public entry fun claim_as_user<T0, T1, T2>(arg0: &mut 0xfb1de1177b901a16a0558b3e0d7ed8bab2e9ae633747f91a7ad50f65d0eced29::vault::Vault<T0, T1, T2>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0xfb1de1177b901a16a0558b3e0d7ed8bab2e9ae633747f91a7ad50f65d0eced29::vault::claim_withdrawal<T0, T1, T2>(arg0, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, v0);
    }

    public entry fun process_queue<T0, T1, T2>(arg0: &mut 0xfb1de1177b901a16a0558b3e0d7ed8bab2e9ae633747f91a7ad50f65d0eced29::vault::Vault<T0, T1, T2>, arg1: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xfb1de1177b901a16a0558b3e0d7ed8bab2e9ae633747f91a7ad50f65d0eced29::vault::process_withdrawals<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v6
}

