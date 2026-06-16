module 0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::withdraw {
    fun compute_fee(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::constants::percentage_denominator() as u128)) as u64)
    }

    public fun run<T0>(arg0: &0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::state::Config, arg1: &mut 0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::vault::Vault<T0>, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg7: &mut 0x3::sui_system::SuiSystemState, arg8: &0x2::clock::Clock, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg10);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(take<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10), v0);
    }

    public fun take<T0>(arg0: &0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::state::Config, arg1: &mut 0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::vault::Vault<T0>, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg7: &mut 0x3::sui_system::SuiSystemState, arg8: &0x2::clock::Clock, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::tx_context::sender(arg10);
        let v1 = 0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::vault::asset<T0>(arg1);
        0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::vault::assert_nonzero_amount(arg9);
        0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::vault::assert_storage<T0>(arg1, 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage>(arg3));
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::update_state_of_user(arg8, arg3, 0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::vault::account_owner<T0>(arg1));
        let (v2, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_index(arg3, v1);
        0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::vault::checkpoint_yield<T0>(arg1, 0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::vault::scale_index(v2));
        0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::vault::debit_shares<T0>(arg1, v0, arg9);
        let v4 = 0x2::coin::from_balance<T0>(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::withdraw_with_account_cap_v2<T0>(arg8, arg2, arg3, arg4, v1, arg9, arg5, arg6, 0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::vault::borrow_account_cap<T0>(arg1), arg7, arg10), arg10);
        let v5 = 0x2::coin::value<T0>(&v4);
        let v6 = compute_fee(v5, 0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::vault::withdraw_fee<T0>(arg1));
        0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::vault::sub_checkpointed_f_balance<T0>(arg1, arg9);
        if (v6 > 0) {
            0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::vault::join_accumulated_fee<T0>(arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v6, arg10)));
        };
        0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::events::emit_withdraw(0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::vault::id<T0>(arg1), v0, arg9, v5 - v6, v6, 0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::vault::shares_of<T0>(arg1, v0), 0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::vault::total_shares<T0>(arg1));
        v4
    }

    // decompiled from Move bytecode v7
}

