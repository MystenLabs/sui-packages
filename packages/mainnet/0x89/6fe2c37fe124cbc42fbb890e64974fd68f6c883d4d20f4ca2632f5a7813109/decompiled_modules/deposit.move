module 0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::deposit {
    public fun run<T0>(arg0: &0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::state::Config, arg1: &mut 0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::vault::Vault<T0>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg6: &0x2::clock::Clock, arg7: 0x2::coin::Coin<T0>, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0x2::coin::value<T0>(&arg7);
        let v2 = 0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::vault::asset<T0>(arg1);
        0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::vault::assert_nonzero_amount(v1);
        0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::vault::assert_at_or_above_min_deposit<T0>(arg1, v1);
        0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::vault::assert_storage<T0>(arg1, 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage>(arg2));
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::deposit_with_account_cap<T0>(arg6, arg2, arg3, v2, arg7, arg4, arg5, 0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::vault::borrow_account_cap<T0>(arg1));
        let (v3, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_index(arg2, v2);
        0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::vault::checkpoint_yield<T0>(arg1, 0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::vault::scale_index(v3));
        0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::vault::add_checkpointed_f_balance<T0>(arg1, v1);
        0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::vault::credit_shares<T0>(arg1, v0, v1);
        0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::events::emit_deposit(0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::vault::id<T0>(arg1), v0, v1, 0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::vault::shares_of<T0>(arg1, v0), 0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::vault::total_shares<T0>(arg1));
    }

    // decompiled from Move bytecode v7
}

