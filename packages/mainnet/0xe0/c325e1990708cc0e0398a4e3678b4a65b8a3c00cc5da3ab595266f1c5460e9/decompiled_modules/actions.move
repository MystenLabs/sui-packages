module 0xe0c325e1990708cc0e0398a4e3678b4a65b8a3c00cc5da3ab595266f1c5460e9::actions {
    struct SwapReceipt {
        vault_id: 0x2::object::ID,
        borrowed_amount: u64,
        is_asset_a: bool,
    }

    public fun initiate_swap_a<T0, T1>(arg0: &mut 0xe0c325e1990708cc0e0398a4e3678b4a65b8a3c00cc5da3ab595266f1c5460e9::vault::Vault<T0, T1>, arg1: &mut 0xe0c325e1990708cc0e0398a4e3678b4a65b8a3c00cc5da3ab595266f1c5460e9::agent_cap::AgentCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, SwapReceipt) {
        let v0 = SwapReceipt{
            vault_id        : 0x2::object::id<0xe0c325e1990708cc0e0398a4e3678b4a65b8a3c00cc5da3ab595266f1c5460e9::vault::Vault<T0, T1>>(arg0),
            borrowed_amount : arg2,
            is_asset_a      : true,
        };
        (0xe0c325e1990708cc0e0398a4e3678b4a65b8a3c00cc5da3ab595266f1c5460e9::vault::borrow_a<T0, T1>(arg0, arg1, arg2, arg3), v0)
    }

    public fun initiate_swap_b<T0, T1>(arg0: &mut 0xe0c325e1990708cc0e0398a4e3678b4a65b8a3c00cc5da3ab595266f1c5460e9::vault::Vault<T0, T1>, arg1: &mut 0xe0c325e1990708cc0e0398a4e3678b4a65b8a3c00cc5da3ab595266f1c5460e9::agent_cap::AgentCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, SwapReceipt) {
        let v0 = SwapReceipt{
            vault_id        : 0x2::object::id<0xe0c325e1990708cc0e0398a4e3678b4a65b8a3c00cc5da3ab595266f1c5460e9::vault::Vault<T0, T1>>(arg0),
            borrowed_amount : arg2,
            is_asset_a      : false,
        };
        (0xe0c325e1990708cc0e0398a4e3678b4a65b8a3c00cc5da3ab595266f1c5460e9::vault::borrow_b<T0, T1>(arg0, arg1, arg2, arg3), v0)
    }

    public fun resolve_swap_a<T0, T1>(arg0: &mut 0xe0c325e1990708cc0e0398a4e3678b4a65b8a3c00cc5da3ab595266f1c5460e9::vault::Vault<T0, T1>, arg1: SwapReceipt, arg2: 0x2::coin::Coin<T1>) {
        let SwapReceipt {
            vault_id        : v0,
            borrowed_amount : _,
            is_asset_a      : v2,
        } = arg1;
        assert!(v0 == 0x2::object::id<0xe0c325e1990708cc0e0398a4e3678b4a65b8a3c00cc5da3ab595266f1c5460e9::vault::Vault<T0, T1>>(arg0), 1);
        assert!(v2, 2);
        0xe0c325e1990708cc0e0398a4e3678b4a65b8a3c00cc5da3ab595266f1c5460e9::vault::return_b<T0, T1>(arg0, arg2);
    }

    public fun resolve_swap_b<T0, T1>(arg0: &mut 0xe0c325e1990708cc0e0398a4e3678b4a65b8a3c00cc5da3ab595266f1c5460e9::vault::Vault<T0, T1>, arg1: SwapReceipt, arg2: 0x2::coin::Coin<T0>) {
        let SwapReceipt {
            vault_id        : v0,
            borrowed_amount : _,
            is_asset_a      : v2,
        } = arg1;
        assert!(v0 == 0x2::object::id<0xe0c325e1990708cc0e0398a4e3678b4a65b8a3c00cc5da3ab595266f1c5460e9::vault::Vault<T0, T1>>(arg0), 1);
        assert!(!v2, 2);
        0xe0c325e1990708cc0e0398a4e3678b4a65b8a3c00cc5da3ab595266f1c5460e9::vault::return_a<T0, T1>(arg0, arg2);
    }

    // decompiled from Move bytecode v7
}

