module 0x8a71874f3037bb658ca3faf1bdd1e6068e164d5fa24724733cbe3c919a56986::interface {
    entry fun admin_deposit<T0>(arg0: &mut 0x8a71874f3037bb658ca3faf1bdd1e6068e164d5fa24724733cbe3c919a56986::implements::Global<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x8a71874f3037bb658ca3faf1bdd1e6068e164d5fa24724733cbe3c919a56986::implements::admin_deposit<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        0x8a71874f3037bb658ca3faf1bdd1e6068e164d5fa24724733cbe3c919a56986::event::admin_deposited_event(0x8a71874f3037bb658ca3faf1bdd1e6068e164d5fa24724733cbe3c919a56986::implements::get_id<T0>(arg0), 0x2::coin::value<T0>(&arg1), 0x8a71874f3037bb658ca3faf1bdd1e6068e164d5fa24724733cbe3c919a56986::implements::cumulative_admin_deposited<T0>(arg0));
    }

    entry fun admin_withdraw<T0>(arg0: &mut 0x8a71874f3037bb658ca3faf1bdd1e6068e164d5fa24724733cbe3c919a56986::implements::Global<T0>, arg1: u64, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg6: &0x2::clock::Clock, arg7: &mut 0x3::sui_system::SuiSystemState, arg8: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg9: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x8a71874f3037bb658ca3faf1bdd1e6068e164d5fa24724733cbe3c919a56986::implements::admin_withdraw<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9), 0x2::tx_context::sender(arg9));
        0x8a71874f3037bb658ca3faf1bdd1e6068e164d5fa24724733cbe3c919a56986::event::admin_withdrawn_event(0x8a71874f3037bb658ca3faf1bdd1e6068e164d5fa24724733cbe3c919a56986::implements::get_id<T0>(arg0), arg1, 0x8a71874f3037bb658ca3faf1bdd1e6068e164d5fa24724733cbe3c919a56986::implements::cumulative_admin_deposited<T0>(arg0), 0x8a71874f3037bb658ca3faf1bdd1e6068e164d5fa24724733cbe3c919a56986::implements::cumulative_admin_withdrawn<T0>(arg0));
    }

    public fun get_active_orders<T0>(arg0: &0x8a71874f3037bb658ca3faf1bdd1e6068e164d5fa24724733cbe3c919a56986::implements::Global<T0>, arg1: address) : vector<0x8a71874f3037bb658ca3faf1bdd1e6068e164d5fa24724733cbe3c919a56986::implements::StakeOrder> {
        0x8a71874f3037bb658ca3faf1bdd1e6068e164d5fa24724733cbe3c919a56986::implements::get_active_orders<T0>(arg0, arg1)
    }

    public fun get_redeemed_orders<T0>(arg0: &0x8a71874f3037bb658ca3faf1bdd1e6068e164d5fa24724733cbe3c919a56986::implements::Global<T0>, arg1: address) : vector<0x8a71874f3037bb658ca3faf1bdd1e6068e164d5fa24724733cbe3c919a56986::implements::StakeOrder> {
        0x8a71874f3037bb658ca3faf1bdd1e6068e164d5fa24724733cbe3c919a56986::implements::get_redeemed_orders<T0>(arg0, arg1)
    }

    entry fun stake<T0>(arg0: &mut 0x8a71874f3037bb658ca3faf1bdd1e6068e164d5fa24724733cbe3c919a56986::implements::Global<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x8a71874f3037bb658ca3faf1bdd1e6068e164d5fa24724733cbe3c919a56986::event::staked_event(0x8a71874f3037bb658ca3faf1bdd1e6068e164d5fa24724733cbe3c919a56986::implements::get_id<T0>(arg0), 0x2::tx_context::sender(arg7), 0x8a71874f3037bb658ca3faf1bdd1e6068e164d5fa24724733cbe3c919a56986::implements::stake<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7), 0x2::coin::value<T0>(&arg1));
    }

    entry fun transfer_admin<T0>(arg0: &mut 0x8a71874f3037bb658ca3faf1bdd1e6068e164d5fa24724733cbe3c919a56986::implements::Global<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x8a71874f3037bb658ca3faf1bdd1e6068e164d5fa24724733cbe3c919a56986::implements::transfer_admin<T0>(arg0, arg1, arg2);
    }

    entry fun unstake<T0>(arg0: &mut 0x8a71874f3037bb658ca3faf1bdd1e6068e164d5fa24724733cbe3c919a56986::implements::Global<T0>, arg1: u64, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg6: &0x2::clock::Clock, arg7: &mut 0x3::sui_system::SuiSystemState, arg8: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x8a71874f3037bb658ca3faf1bdd1e6068e164d5fa24724733cbe3c919a56986::implements::unstake<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        let v3 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg9));
        0x8a71874f3037bb658ca3faf1bdd1e6068e164d5fa24724733cbe3c919a56986::event::unstaked_event(0x8a71874f3037bb658ca3faf1bdd1e6068e164d5fa24724733cbe3c919a56986::implements::get_id<T0>(arg0), 0x2::tx_context::sender(arg9), arg1, v1, 0x2::coin::value<T0>(&v3), v2);
    }

    public fun create_pool<T0>(arg0: u8, arg1: &mut 0x2::tx_context::TxContext) {
        0x8a71874f3037bb658ca3faf1bdd1e6068e164d5fa24724733cbe3c919a56986::implements::create_and_share<T0>(arg0, arg1);
    }

    public fun get_cumulative_admin_deposited<T0>(arg0: &0x8a71874f3037bb658ca3faf1bdd1e6068e164d5fa24724733cbe3c919a56986::implements::Global<T0>) : u64 {
        0x8a71874f3037bb658ca3faf1bdd1e6068e164d5fa24724733cbe3c919a56986::implements::cumulative_admin_deposited<T0>(arg0)
    }

    public fun get_cumulative_admin_withdrawn<T0>(arg0: &0x8a71874f3037bb658ca3faf1bdd1e6068e164d5fa24724733cbe3c919a56986::implements::Global<T0>) : u64 {
        0x8a71874f3037bb658ca3faf1bdd1e6068e164d5fa24724733cbe3c919a56986::implements::cumulative_admin_withdrawn<T0>(arg0)
    }

    public fun get_cumulative_redeemed<T0>(arg0: &0x8a71874f3037bb658ca3faf1bdd1e6068e164d5fa24724733cbe3c919a56986::implements::Global<T0>) : u64 {
        0x8a71874f3037bb658ca3faf1bdd1e6068e164d5fa24724733cbe3c919a56986::implements::cumulative_redeemed<T0>(arg0)
    }

    public fun get_cumulative_staked<T0>(arg0: &0x8a71874f3037bb658ca3faf1bdd1e6068e164d5fa24724733cbe3c919a56986::implements::Global<T0>) : u64 {
        0x8a71874f3037bb658ca3faf1bdd1e6068e164d5fa24724733cbe3c919a56986::implements::cumulative_staked<T0>(arg0)
    }

    public fun get_current_amount(arg0: u64, arg1: u64, arg2: u64) : u64 {
        0x8a71874f3037bb658ca3faf1bdd1e6068e164d5fa24724733cbe3c919a56986::implements::current_amount(arg0, arg1, arg2)
    }

    public fun get_navi_pool_balance<T0>(arg0: &0x8a71874f3037bb658ca3faf1bdd1e6068e164d5fa24724733cbe3c919a56986::implements::Global<T0>, arg1: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage) : u64 {
        0x8a71874f3037bb658ca3faf1bdd1e6068e164d5fa24724733cbe3c919a56986::implements::navi_pool_balance<T0>(arg0, arg1, arg2)
    }

    entry fun pause<T0>(arg0: &mut 0x8a71874f3037bb658ca3faf1bdd1e6068e164d5fa24724733cbe3c919a56986::implements::Global<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x8a71874f3037bb658ca3faf1bdd1e6068e164d5fa24724733cbe3c919a56986::implements::set_emergency<T0>(arg0, true, arg1);
    }

    entry fun unpause<T0>(arg0: &mut 0x8a71874f3037bb658ca3faf1bdd1e6068e164d5fa24724733cbe3c919a56986::implements::Global<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x8a71874f3037bb658ca3faf1bdd1e6068e164d5fa24724733cbe3c919a56986::implements::set_emergency<T0>(arg0, false, arg1);
    }

    // decompiled from Move bytecode v6
}

