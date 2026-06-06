module 0x8509610948b6437c3a9dd841af6f1083a3481adaa521625d18c90d08e05b10e9::actions {
    struct SwapReceipt {
        vault_id: 0x2::object::ID,
        borrowed_amount: u64,
        is_sui: bool,
    }

    public fun initiate_swap_sui<T0>(arg0: &mut 0x8509610948b6437c3a9dd841af6f1083a3481adaa521625d18c90d08e05b10e9::vault::Vault<T0>, arg1: &mut 0x8509610948b6437c3a9dd841af6f1083a3481adaa521625d18c90d08e05b10e9::agent_cap::AgentCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, SwapReceipt) {
        let v0 = SwapReceipt{
            vault_id        : 0x2::object::id<0x8509610948b6437c3a9dd841af6f1083a3481adaa521625d18c90d08e05b10e9::vault::Vault<T0>>(arg0),
            borrowed_amount : arg2,
            is_sui          : true,
        };
        (0x8509610948b6437c3a9dd841af6f1083a3481adaa521625d18c90d08e05b10e9::vault::borrow_sui<T0>(arg0, arg1, arg2, arg3), v0)
    }

    public fun initiate_swap_target<T0>(arg0: &mut 0x8509610948b6437c3a9dd841af6f1083a3481adaa521625d18c90d08e05b10e9::vault::Vault<T0>, arg1: &mut 0x8509610948b6437c3a9dd841af6f1083a3481adaa521625d18c90d08e05b10e9::agent_cap::AgentCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, SwapReceipt) {
        let v0 = SwapReceipt{
            vault_id        : 0x2::object::id<0x8509610948b6437c3a9dd841af6f1083a3481adaa521625d18c90d08e05b10e9::vault::Vault<T0>>(arg0),
            borrowed_amount : arg2,
            is_sui          : false,
        };
        (0x8509610948b6437c3a9dd841af6f1083a3481adaa521625d18c90d08e05b10e9::vault::borrow_target<T0>(arg0, arg1, arg2, arg3), v0)
    }

    public fun resolve_swap_sui<T0>(arg0: &mut 0x8509610948b6437c3a9dd841af6f1083a3481adaa521625d18c90d08e05b10e9::vault::Vault<T0>, arg1: SwapReceipt, arg2: 0x2::coin::Coin<T0>) {
        let SwapReceipt {
            vault_id        : v0,
            borrowed_amount : _,
            is_sui          : v2,
        } = arg1;
        assert!(v0 == 0x2::object::id<0x8509610948b6437c3a9dd841af6f1083a3481adaa521625d18c90d08e05b10e9::vault::Vault<T0>>(arg0), 1);
        assert!(v2, 2);
        0x8509610948b6437c3a9dd841af6f1083a3481adaa521625d18c90d08e05b10e9::vault::return_target<T0>(arg0, arg2);
    }

    public fun resolve_swap_target<T0>(arg0: &mut 0x8509610948b6437c3a9dd841af6f1083a3481adaa521625d18c90d08e05b10e9::vault::Vault<T0>, arg1: SwapReceipt, arg2: 0x2::coin::Coin<0x2::sui::SUI>) {
        let SwapReceipt {
            vault_id        : v0,
            borrowed_amount : _,
            is_sui          : v2,
        } = arg1;
        assert!(v0 == 0x2::object::id<0x8509610948b6437c3a9dd841af6f1083a3481adaa521625d18c90d08e05b10e9::vault::Vault<T0>>(arg0), 1);
        assert!(!v2, 2);
        0x8509610948b6437c3a9dd841af6f1083a3481adaa521625d18c90d08e05b10e9::vault::return_sui<T0>(arg0, arg2);
    }

    // decompiled from Move bytecode v7
}

