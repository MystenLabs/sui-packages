module 0x988209323614b9e6b9424f211ecf982db475b3c32e947263ff05fff939e7febe::adapter_bluefin {
    public fun add_liquidity<T0, T1>(arg0: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1, v2) = 0x988209323614b9e6b9424f211ecf982db475b3c32e947263ff05fff939e7febe::module_bluefin::add_liquidity<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(arg2), 0x2::coin::into_balance<T1>(arg3), 0x988209323614b9e6b9424f211ecf982db475b3c32e947263ff05fff939e7febe::params::to_open_params(arg4), arg5, arg6);
        (v0, 0x2::coin::from_balance<T0>(v1, arg6), 0x2::coin::from_balance<T1>(v2, arg6))
    }

    public fun close_position<T0, T1>(arg0: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1) = 0x988209323614b9e6b9424f211ecf982db475b3c32e947263ff05fff939e7febe::module_bluefin::burn_position<T0, T1>(arg0, arg1, arg2, arg3);
        (0x2::coin::from_balance<T0>(v0, arg4), 0x2::coin::from_balance<T1>(v1, arg4))
    }

    public fun collect_reward<T0, T1, T2>(arg0: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0x2::coin::from_balance<T2>(0x988209323614b9e6b9424f211ecf982db475b3c32e947263ff05fff939e7febe::module_bluefin::collect_reward<T0, T1, T2>(arg0, arg1, arg2, arg3), arg4)
    }

    public fun trader_add_liquidity<T0, T1>(arg0: &mut 0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::account::Account, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x988209323614b9e6b9424f211ecf982db475b3c32e947263ff05fff939e7febe::module_bluefin::add_liquidity<T0, T1>(arg1, arg2, 0x2::coin::into_balance<T0>(arg3), 0x2::coin::into_balance<T1>(arg4), 0x988209323614b9e6b9424f211ecf982db475b3c32e947263ff05fff939e7febe::params::to_open_params(arg5), arg6, arg7);
        let v3 = v2;
        let v4 = v1;
        0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::account::add_position<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg0, v0, arg7);
        let v5 = 0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::account::get_info(arg0);
        let v6 = 0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::account::account_recipient(&v5);
        if (0x2::balance::value<T0>(&v4) > 0) {
            0x2::balance::send_funds<T0>(v4, v6);
        } else {
            0x2::balance::destroy_zero<T0>(v4);
        };
        if (0x2::balance::value<T1>(&v3) > 0) {
            0x2::balance::send_funds<T1>(v3, v6);
        } else {
            0x2::balance::destroy_zero<T1>(v3);
        };
    }

    public fun trader_close_position<T0, T1>(arg0: &mut 0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::account::Account, arg1: 0x2::object::ID, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::account::get_info(arg0);
        let v1 = 0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::account::account_recipient(&v0);
        let (v2, v3) = 0x988209323614b9e6b9424f211ecf982db475b3c32e947263ff05fff939e7febe::module_bluefin::burn_position<T0, T1>(0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::account::take_position<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg0, arg1, arg5), arg2, arg3, arg4);
        let v4 = v3;
        let v5 = v2;
        if (0x2::balance::value<T0>(&v5) > 0) {
            0x2::balance::send_funds<T0>(v5, v1);
        } else {
            0x2::balance::destroy_zero<T0>(v5);
        };
        if (0x2::balance::value<T1>(&v4) > 0) {
            0x2::balance::send_funds<T1>(v4, v1);
        } else {
            0x2::balance::destroy_zero<T1>(v4);
        };
    }

    public fun trader_collect_reward<T0, T1, T2>(arg0: &mut 0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::account::Account, arg1: 0x2::object::ID, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x988209323614b9e6b9424f211ecf982db475b3c32e947263ff05fff939e7febe::module_bluefin::collect_reward<T0, T1, T2>(0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::account::borrow_mut_position<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg0, arg1, arg5), arg2, arg3, arg4);
        if (0x2::balance::value<T2>(&v0) > 0) {
            let v1 = 0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::account::get_info(arg0);
            0x2::balance::send_funds<T2>(v0, 0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::account::account_recipient(&v1));
        } else {
            0x2::balance::destroy_zero<T2>(v0);
        };
    }

    public fun vault_add_liquidity<T0, T1>(arg0: &mut 0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::account::Account, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::vault::Vault<T0>, arg4: &mut 0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::vault::Vault<T1>, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x988209323614b9e6b9424f211ecf982db475b3c32e947263ff05fff939e7febe::module_bluefin::add_liquidity<T0, T1>(arg1, arg2, 0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::account::withdraw_balance<T0>(arg0, arg3, 0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::vault::vault_balance<T0>(arg3), arg7), 0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::account::withdraw_balance<T1>(arg0, arg4, 0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::vault::vault_balance<T1>(arg4), arg7), 0x988209323614b9e6b9424f211ecf982db475b3c32e947263ff05fff939e7febe::params::to_open_params(arg5), arg6, arg7);
        let v3 = v2;
        let v4 = v1;
        0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::account::add_position<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg0, v0, arg7);
        if (0x2::balance::value<T0>(&v4) > 0) {
            0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::vault::deposit_v1<T0>(arg3, v4);
        } else {
            0x2::balance::destroy_zero<T0>(v4);
        };
        if (0x2::balance::value<T1>(&v3) > 0) {
            0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::vault::deposit_v1<T1>(arg4, v3);
        } else {
            0x2::balance::destroy_zero<T1>(v3);
        };
    }

    public fun vault_close_position<T0, T1>(arg0: &mut 0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::account::Account, arg1: 0x2::object::ID, arg2: &mut 0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::vault::Vault<T0>, arg3: &mut 0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::vault::Vault<T1>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x988209323614b9e6b9424f211ecf982db475b3c32e947263ff05fff939e7febe::module_bluefin::burn_position<T0, T1>(0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::account::take_position<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg0, arg1, arg7), arg4, arg5, arg6);
        let v2 = v1;
        let v3 = v0;
        if (0x2::balance::value<T0>(&v3) > 0) {
            0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::vault::deposit_v1<T0>(arg2, v3);
        } else {
            0x2::balance::destroy_zero<T0>(v3);
        };
        if (0x2::balance::value<T1>(&v2) > 0) {
            0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::vault::deposit_v1<T1>(arg3, v2);
        } else {
            0x2::balance::destroy_zero<T1>(v2);
        };
    }

    public fun vault_collect_reward<T0, T1, T2>(arg0: &mut 0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::account::Account, arg1: 0x2::object::ID, arg2: &mut 0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::vault::Vault<T2>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x988209323614b9e6b9424f211ecf982db475b3c32e947263ff05fff939e7febe::module_bluefin::collect_reward<T0, T1, T2>(0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::account::borrow_mut_position<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg0, arg1, arg6), arg3, arg4, arg5);
        if (0x2::balance::value<T2>(&v0) > 0) {
            0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::vault::deposit_v1<T2>(arg2, v0);
        } else {
            0x2::balance::destroy_zero<T2>(v0);
        };
    }

    // decompiled from Move bytecode v7
}

