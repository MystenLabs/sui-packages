module 0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault_entry {
    entry fun emergency_exit<T0, T1, T2>(arg0: &0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::VaultAdminCap, arg1: &mut 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::Pool<T0, T1>, arg2: &mut 0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::Vault<T0, T1, T2>, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::strategy::emergency_exit<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    entry fun emergency_exit_x_sui<T0, T1>(arg0: &0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::VaultAdminCap, arg1: &mut 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::Pool<0x2::sui::SUI, T0>, arg2: &mut 0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::Vault<0x2::sui::SUI, T0, T1>, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::strategy::emergency_exit_x_sui<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    entry fun guardian_emergency_exit<T0, T1, T2>(arg0: &mut 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::Pool<T0, T1>, arg1: &mut 0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::Vault<T0, T1, T2>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::strategy::guardian_emergency_exit<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4);
    }

    entry fun guardian_emergency_exit_x_sui<T0, T1>(arg0: &mut 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::Pool<0x2::sui::SUI, T0>, arg1: &mut 0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::Vault<0x2::sui::SUI, T0, T1>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::strategy::guardian_emergency_exit_x_sui<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    entry fun keeper_deploy<T0, T1, T2>(arg0: &0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::VaultRegistry, arg1: &mut 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::Pool<T0, T1>, arg2: &mut 0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::Vault<T0, T1, T2>, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: vector<u32>, arg5: vector<u64>, arg6: vector<u64>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::assert_registry_not_paused(arg0);
        0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::strategy::keeper_deploy<T0, T1, T2>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    entry fun keeper_rebalance<T0, T1, T2>(arg0: &0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::VaultRegistry, arg1: &mut 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::Pool<T0, T1>, arg2: &mut 0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::Vault<T0, T1, T2>, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: vector<u32>, arg5: vector<u64>, arg6: vector<u64>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::assert_registry_not_paused(arg0);
        0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::strategy::keeper_rebalance<T0, T1, T2>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    entry fun keeper_rebalance_x_sui<T0, T1>(arg0: &0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::VaultRegistry, arg1: &mut 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::Pool<0x2::sui::SUI, T0>, arg2: &mut 0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::Vault<0x2::sui::SUI, T0, T1>, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: vector<u32>, arg5: vector<u64>, arg6: vector<u64>, arg7: &mut 0x3::sui_system::SuiSystemState, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::assert_registry_not_paused(arg0);
        0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::strategy::keeper_rebalance_x_sui<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    entry fun apply_authorized_keeper<T0, T1, T2>(arg0: &0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::VaultAdminCap, arg1: &mut 0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::Vault<T0, T1, T2>, arg2: &0x2::clock::Clock) {
        0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::apply_authorized_keeper<T0, T1, T2>(arg0, arg1, arg2);
    }

    entry fun apply_deposit_cap<T0, T1, T2>(arg0: &0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::VaultAdminCap, arg1: &mut 0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::Vault<T0, T1, T2>, arg2: &0x2::clock::Clock) {
        0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::apply_deposit_cap<T0, T1, T2>(arg0, arg1, arg2);
    }

    entry fun apply_emergency_guardian<T0, T1, T2>(arg0: &0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::VaultAdminCap, arg1: &mut 0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::Vault<T0, T1, T2>, arg2: &0x2::clock::Clock) {
        0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::apply_emergency_guardian<T0, T1, T2>(arg0, arg1, arg2);
    }

    entry fun apply_strategy_config<T0, T1, T2>(arg0: &0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::VaultAdminCap, arg1: &mut 0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::Vault<T0, T1, T2>, arg2: &0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock) {
        0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::apply_strategy_config<T0, T1, T2>(arg0, arg1, arg2, arg3);
    }

    entry fun clear_emergency_guardian<T0, T1, T2>(arg0: &0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::VaultAdminCap, arg1: &mut 0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::Vault<T0, T1, T2>) {
        0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::clear_emergency_guardian<T0, T1, T2>(arg0, arg1);
    }

    entry fun clear_exit_only<T0, T1, T2>(arg0: &0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::VaultAdminCap, arg1: &mut 0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::Vault<T0, T1, T2>) {
        0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::clear_exit_only<T0, T1, T2>(arg0, arg1);
    }

    entry fun guardian_pause<T0, T1, T2>(arg0: &mut 0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::Vault<T0, T1, T2>, arg1: &0x2::tx_context::TxContext) {
        0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::guardian_pause<T0, T1, T2>(arg0, arg1);
    }

    entry fun pause<T0, T1, T2>(arg0: &0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::VaultAdminCap, arg1: &mut 0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::Vault<T0, T1, T2>) {
        0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::pause<T0, T1, T2>(arg0, arg1);
    }

    entry fun propose_authorized_keeper<T0, T1, T2>(arg0: &0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::VaultAdminCap, arg1: &mut 0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::Vault<T0, T1, T2>, arg2: address, arg3: &0x2::clock::Clock) {
        0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::propose_authorized_keeper<T0, T1, T2>(arg0, arg1, arg2, arg3);
    }

    entry fun propose_deposit_cap<T0, T1, T2>(arg0: &0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::VaultAdminCap, arg1: &mut 0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::Vault<T0, T1, T2>, arg2: u64, arg3: &0x2::clock::Clock) {
        0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::propose_deposit_cap<T0, T1, T2>(arg0, arg1, arg2, arg3);
    }

    entry fun propose_emergency_guardian<T0, T1, T2>(arg0: &0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::VaultAdminCap, arg1: &mut 0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::Vault<T0, T1, T2>, arg2: address, arg3: &0x2::clock::Clock) {
        0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::propose_emergency_guardian<T0, T1, T2>(arg0, arg1, arg2, arg3);
    }

    entry fun propose_strategy_config<T0, T1, T2>(arg0: &0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::VaultAdminCap, arg1: &mut 0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::Vault<T0, T1, T2>, arg2: &0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::Pool<T0, T1>, arg3: u32, arg4: u32, arg5: u64, arg6: u32, arg7: u32, arg8: u64, arg9: &0x2::clock::Clock) {
        0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::propose_strategy_config<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    entry fun set_bootstrapper<T0, T1, T2>(arg0: &0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::VaultAdminCap, arg1: &mut 0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::Vault<T0, T1, T2>, arg2: address) {
        0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::set_bootstrapper<T0, T1, T2>(arg0, arg1, arg2);
    }

    entry fun unpause<T0, T1, T2>(arg0: &0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::VaultAdminCap, arg1: &mut 0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::Vault<T0, T1, T2>) {
        0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::unpause<T0, T1, T2>(arg0, arg1);
    }

    public fun deposit_coins<T0, T1, T2>(arg0: &0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::VaultRegistry, arg1: &mut 0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::Vault<T0, T1, T2>, arg2: &mut 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::Pool<T0, T1>, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::assert_registry_not_paused(arg0);
        0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool_lending_ops::checkpoint_lending_value<T0, T1>(arg2, arg3, arg7);
        0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::deposit<T0, T1, T2>(arg1, arg2, arg4, arg5, arg6, arg7, arg8)
    }

    public fun deposit_no_lending_coins<T0, T1, T2>(arg0: &0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::VaultRegistry, arg1: &mut 0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::Vault<T0, T1, T2>, arg2: &0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::assert_registry_not_paused(arg0);
        0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::deposit_no_lending<T0, T1, T2>(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    entry fun initialize_vault<T0, T1, T2>(arg0: &0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::admin::AdminCap, arg1: &mut 0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::VaultRegistry, arg2: &0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::Pool<T0, T1>, arg3: 0x2::coin::TreasuryCap<T2>, arg4: u32, arg5: u32, arg6: u64, arg7: u32, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::register_vault<T0, T1, T2>(arg1, 0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::create_vault<T0, T1, T2>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10));
    }

    public fun withdraw_coins<T0, T1, T2>(arg0: &mut 0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::Vault<T0, T1, T2>, arg1: &mut 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::Pool<T0, T1>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: 0x2::coin::Coin<T2>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool_lending_ops::checkpoint_lending_value<T0, T1>(arg1, arg2, arg6);
        0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::withdraw<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public fun withdraw_no_lending_coins<T0, T1, T2>(arg0: &mut 0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::Vault<T0, T1, T2>, arg1: &mut 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T2>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::withdraw_no_lending<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun withdraw_x_sui_coins<T0, T1>(arg0: &mut 0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::Vault<0x2::sui::SUI, T0, T1>, arg1: &mut 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::Pool<0x2::sui::SUI, T0>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<T0>) {
        0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool_lending_ops::checkpoint_lending_value<0x2::sui::SUI, T0>(arg1, arg2, arg7);
        0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::withdraw_x_sui<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    // decompiled from Move bytecode v7
}

