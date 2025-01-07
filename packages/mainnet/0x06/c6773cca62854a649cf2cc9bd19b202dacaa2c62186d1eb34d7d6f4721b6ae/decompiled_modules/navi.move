module 0x6c6773cca62854a649cf2cc9bd19b202dacaa2c62186d1eb34d7d6f4721b6ae::navi {
    struct NaviAccountCapKey has copy, drop, store {
        dummy_field: bool,
    }

    public(friend) fun balance(arg0: &0x6c6773cca62854a649cf2cc9bd19b202dacaa2c62186d1eb34d7d6f4721b6ae::vault::Vault, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: u8) : (u256, u256) {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg1, arg2, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(get_account_cap(arg0)))
    }

    public(friend) fun claim_reward<T0>(arg0: &0x6c6773cca62854a649cf2cc9bd19b202dacaa2c62186d1eb34d7d6f4721b6ae::vault::Vault, arg1: &0x2::clock::Clock, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<T0>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: u8, arg6: u8) : 0x2::balance::Balance<T0> {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::claim_reward_with_account_cap<T0>(arg1, arg2, arg3, arg4, arg5, arg6, get_account_cap(arg0))
    }

    public(friend) fun deposit<T0>(arg0: &0x6c6773cca62854a649cf2cc9bd19b202dacaa2c62186d1eb34d7d6f4721b6ae::vault::Vault, arg1: &0x2::clock::Clock, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: u8, arg5: 0x2::coin::Coin<T0>, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive) {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::deposit_with_account_cap<T0>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, get_account_cap(arg0));
    }

    fun get_account_cap(arg0: &0x6c6773cca62854a649cf2cc9bd19b202dacaa2c62186d1eb34d7d6f4721b6ae::vault::Vault) : &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap {
        let v0 = NaviAccountCapKey{dummy_field: false};
        0x6c6773cca62854a649cf2cc9bd19b202dacaa2c62186d1eb34d7d6f4721b6ae::vault::borrow_object<NaviAccountCapKey, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(arg0, v0)
    }

    public(friend) fun setup(arg0: &mut 0x6c6773cca62854a649cf2cc9bd19b202dacaa2c62186d1eb34d7d6f4721b6ae::vault::Vault, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = NaviAccountCapKey{dummy_field: false};
        0x6c6773cca62854a649cf2cc9bd19b202dacaa2c62186d1eb34d7d6f4721b6ae::vault::put_object<NaviAccountCapKey, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(arg0, v0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::create_account(arg1));
    }

    public(friend) fun withdraw<T0>(arg0: &0x6c6773cca62854a649cf2cc9bd19b202dacaa2c62186d1eb34d7d6f4721b6ae::vault::Vault, arg1: &0x2::clock::Clock, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: u8, arg6: u64, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive) : 0x2::balance::Balance<T0> {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::withdraw_with_account_cap<T0>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, get_account_cap(arg0))
    }

    // decompiled from Move bytecode v6
}

