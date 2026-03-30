module 0x618133114431cc2ea88b37751c12be778f3818dbe105d11769195a287516fec4::alphafi_bridge {
    struct BridgeState<phantom T0> has key {
        id: 0x2::object::UID,
    }

    struct WithdrawReceipt {
        vault_id: 0x2::object::ID,
        vault_balance_before: u64,
        min_expected: u64,
    }

    public fun begin_withdraw<T0, T1>(arg0: &0x6f8d1d25f7a66d967e92fed17d6a362055d3544b6218dc606c1cbc70bfc55f5f::vault::Vault<T0>, arg1: &BridgeState<T1>, arg2: &T1, arg3: u64) : WithdrawReceipt {
        WithdrawReceipt{
            vault_id             : 0x2::object::id<0x6f8d1d25f7a66d967e92fed17d6a362055d3544b6218dc606c1cbc70bfc55f5f::vault::Vault<T0>>(arg0),
            vault_balance_before : 0x6f8d1d25f7a66d967e92fed17d6a362055d3544b6218dc606c1cbc70bfc55f5f::vault::idle_balance<T0>(arg0),
            min_expected         : arg3,
        }
    }

    public fun create_bridge_state<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = BridgeState<T0>{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<BridgeState<T0>>(v0);
    }

    public fun end_withdraw<T0>(arg0: &0x6f8d1d25f7a66d967e92fed17d6a362055d3544b6218dc606c1cbc70bfc55f5f::vault::Vault<T0>, arg1: WithdrawReceipt) {
        let WithdrawReceipt {
            vault_id             : v0,
            vault_balance_before : v1,
            min_expected         : v2,
        } = arg1;
        assert!(0x2::object::id<0x6f8d1d25f7a66d967e92fed17d6a362055d3544b6218dc606c1cbc70bfc55f5f::vault::Vault<T0>>(arg0) == v0, 0);
        assert!(0x6f8d1d25f7a66d967e92fed17d6a362055d3544b6218dc606c1cbc70bfc55f5f::vault::idle_balance<T0>(arg0) >= v1 + v2, 1);
    }

    // decompiled from Move bytecode v6
}

