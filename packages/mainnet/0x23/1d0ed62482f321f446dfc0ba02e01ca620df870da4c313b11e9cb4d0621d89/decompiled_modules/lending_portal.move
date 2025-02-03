module 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::lending_portal {
    struct LendingPortal has key {
        id: 0x2::object::UID,
        relayer: address,
        next_nonce: u64,
    }

    struct RelayEvent has copy, drop {
        sequence: u64,
        nonce: u64,
        dst_pool: 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::DolaAddress,
        fee_amount: u64,
        call_type: u8,
    }

    struct LendingPortalEvent has copy, drop {
        nonce: u64,
        sender: address,
        dola_pool_address: vector<u8>,
        source_chain_id: u16,
        dst_chain_id: u16,
        receiver: vector<u8>,
        amount: u64,
        call_type: u8,
    }

    struct LendingLocalEvent has copy, drop {
        nonce: u64,
        sender: address,
        dola_pool_address: vector<u8>,
        amount: u64,
        call_type: u8,
    }

    public entry fun as_collateral(arg0: &0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::genesis::GovernanceGenesis, arg1: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::lending_core_storage::Storage, arg2: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::oracle::PriceOracle, arg3: &0x2::clock::Clock, arg4: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::pool_manager::PoolManagerInfo, arg5: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::user_manager::UserManagerInfo, arg6: vector<u16>, arg7: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun borrow_local<T0>(arg0: &0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::genesis::GovernanceGenesis, arg1: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::lending_core_storage::Storage, arg2: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::oracle::PriceOracle, arg3: &0x2::clock::Clock, arg4: &mut LendingPortal, arg5: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::pool_manager::PoolManagerInfo, arg6: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::user_manager::UserManagerInfo, arg7: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_pool::Pool<T0>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun borrow_remote(arg0: &0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::genesis::GovernanceGenesis, arg1: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::lending_core_storage::Storage, arg2: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::oracle::PriceOracle, arg3: &0x2::clock::Clock, arg4: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::wormhole_adapter_core::CoreState, arg5: &mut LendingPortal, arg6: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg7: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::pool_manager::PoolManagerInfo, arg8: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::user_manager::UserManagerInfo, arg9: vector<u8>, arg10: vector<u8>, arg11: u16, arg12: u64, arg13: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun cancel_as_collateral(arg0: &0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::genesis::GovernanceGenesis, arg1: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::lending_core_storage::Storage, arg2: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::oracle::PriceOracle, arg3: &0x2::clock::Clock, arg4: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::pool_manager::PoolManagerInfo, arg5: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::user_manager::UserManagerInfo, arg6: vector<u16>, arg7: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    entry fun cancel_as_collateral_remote(arg0: &0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::genesis::GovernanceGenesis, arg1: &0x2::clock::Clock, arg2: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::wormhole_adapter_pool::PoolState, arg3: &mut LendingPortal, arg4: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg5: vector<u16>, arg6: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    fun get_nonce(arg0: &mut LendingPortal) : u64 {
        arg0.next_nonce = arg0.next_nonce + 1;
        arg0.next_nonce
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = LendingPortal{
            id         : 0x2::object::new(arg0),
            relayer    : 0x2::tx_context::sender(arg0),
            next_nonce : 0,
        };
        0x2::transfer::share_object<LendingPortal>(v0);
    }

    public entry fun liquidate<T0>(arg0: &0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::genesis::GovernanceGenesis, arg1: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::lending_core_storage::Storage, arg2: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::oracle::PriceOracle, arg3: &0x2::clock::Clock, arg4: &mut LendingPortal, arg5: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::user_manager::UserManagerInfo, arg6: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::pool_manager::PoolManagerInfo, arg7: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_pool::Pool<T0>, arg8: vector<0x2::coin::Coin<T0>>, arg9: u64, arg10: u16, arg11: vector<u8>, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun repay<T0>(arg0: &0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::genesis::GovernanceGenesis, arg1: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::lending_core_storage::Storage, arg2: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::oracle::PriceOracle, arg3: &0x2::clock::Clock, arg4: &mut LendingPortal, arg5: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::user_manager::UserManagerInfo, arg6: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::pool_manager::PoolManagerInfo, arg7: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_pool::Pool<T0>, arg8: vector<0x2::coin::Coin<T0>>, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun set_relayer(arg0: &0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::genesis::GovernanceCap, arg1: &mut LendingPortal, arg2: address) {
        abort 0
    }

    public entry fun supply<T0>(arg0: &0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::genesis::GovernanceGenesis, arg1: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::lending_core_storage::Storage, arg2: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::oracle::PriceOracle, arg3: &0x2::clock::Clock, arg4: &mut LendingPortal, arg5: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::user_manager::UserManagerInfo, arg6: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::pool_manager::PoolManagerInfo, arg7: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_pool::Pool<T0>, arg8: vector<0x2::coin::Coin<T0>>, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun withdraw_local<T0>(arg0: &0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::genesis::GovernanceGenesis, arg1: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::lending_core_storage::Storage, arg2: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::oracle::PriceOracle, arg3: &0x2::clock::Clock, arg4: &mut LendingPortal, arg5: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::pool_manager::PoolManagerInfo, arg6: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::user_manager::UserManagerInfo, arg7: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_pool::Pool<T0>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun withdraw_remote(arg0: &0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::genesis::GovernanceGenesis, arg1: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::lending_core_storage::Storage, arg2: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::oracle::PriceOracle, arg3: &0x2::clock::Clock, arg4: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::wormhole_adapter_core::CoreState, arg5: &mut LendingPortal, arg6: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg7: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::pool_manager::PoolManagerInfo, arg8: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::user_manager::UserManagerInfo, arg9: vector<u8>, arg10: vector<u8>, arg11: u16, arg12: u64, arg13: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    // decompiled from Move bytecode v6
}

