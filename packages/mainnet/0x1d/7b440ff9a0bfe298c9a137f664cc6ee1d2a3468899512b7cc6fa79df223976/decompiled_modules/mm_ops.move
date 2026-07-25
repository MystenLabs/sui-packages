module 0x1d7b440ff9a0bfe298c9a137f664cc6ee1d2a3468899512b7cc6fa79df223976::mm_ops {
    struct SwapExecuted has copy, drop {
        vault_id: 0x2::object::ID,
        dex: 0x1::type_name::TypeName,
        amount_in: u64,
        amount_out: u64,
        is_buy: bool,
    }

    struct LiquidityAdded has copy, drop {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        amount_a: u64,
        amount_b: u64,
    }

    struct LiquidityRemoved has copy, drop {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        amount_a: u64,
        amount_b: u64,
    }

    public fun add_liquidity<T0>(arg0: &mut 0x1d7b440ff9a0bfe298c9a137f664cc6ee1d2a3468899512b7cc6fa79df223976::vault::Vault, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x1d7b440ff9a0bfe298c9a137f664cc6ee1d2a3468899512b7cc6fa79df223976::vault::assert_authorized(arg0, arg3);
        assert!(arg1 > 0 && arg2 > 0, 2);
        let v0 = LiquidityAdded{
            vault_id : 0x1d7b440ff9a0bfe298c9a137f664cc6ee1d2a3468899512b7cc6fa79df223976::vault::vault_id(arg0),
            pool_id  : 0x1d7b440ff9a0bfe298c9a137f664cc6ee1d2a3468899512b7cc6fa79df223976::vault::vault_id(arg0),
            amount_a : arg1,
            amount_b : arg2,
        };
        0x2::event::emit<LiquidityAdded>(v0);
    }

    public fun buy_with_sui<T0>(arg0: &mut 0x1d7b440ff9a0bfe298c9a137f664cc6ee1d2a3468899512b7cc6fa79df223976::vault::Vault, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        0x1d7b440ff9a0bfe298c9a137f664cc6ee1d2a3468899512b7cc6fa79df223976::vault::assert_authorized(arg0, arg3);
        assert!(arg1 > 0, 2);
        let v0 = SwapExecuted{
            vault_id   : 0x1d7b440ff9a0bfe298c9a137f664cc6ee1d2a3468899512b7cc6fa79df223976::vault::vault_id(arg0),
            dex        : 0x1::type_name::with_defining_ids<T0>(),
            amount_in  : arg1,
            amount_out : 0,
            is_buy     : true,
        };
        0x2::event::emit<SwapExecuted>(v0);
        0
    }

    public fun remove_liquidity<T0>(arg0: &mut 0x1d7b440ff9a0bfe298c9a137f664cc6ee1d2a3468899512b7cc6fa79df223976::vault::Vault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x1d7b440ff9a0bfe298c9a137f664cc6ee1d2a3468899512b7cc6fa79df223976::vault::assert_authorized(arg0, arg2);
        assert!(arg1 > 0, 2);
        let v0 = LiquidityRemoved{
            vault_id : 0x1d7b440ff9a0bfe298c9a137f664cc6ee1d2a3468899512b7cc6fa79df223976::vault::vault_id(arg0),
            pool_id  : 0x1d7b440ff9a0bfe298c9a137f664cc6ee1d2a3468899512b7cc6fa79df223976::vault::vault_id(arg0),
            amount_a : 0,
            amount_b : 0,
        };
        0x2::event::emit<LiquidityRemoved>(v0);
    }

    public fun sell_for_sui<T0>(arg0: &mut 0x1d7b440ff9a0bfe298c9a137f664cc6ee1d2a3468899512b7cc6fa79df223976::vault::Vault, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        0x1d7b440ff9a0bfe298c9a137f664cc6ee1d2a3468899512b7cc6fa79df223976::vault::assert_authorized(arg0, arg3);
        assert!(arg1 > 0, 2);
        let v0 = SwapExecuted{
            vault_id   : 0x1d7b440ff9a0bfe298c9a137f664cc6ee1d2a3468899512b7cc6fa79df223976::vault::vault_id(arg0),
            dex        : 0x1::type_name::with_defining_ids<T0>(),
            amount_in  : arg1,
            amount_out : 0,
            is_buy     : false,
        };
        0x2::event::emit<SwapExecuted>(v0);
        0
    }

    public fun transfer_to<T0>(arg0: &mut 0x1d7b440ff9a0bfe298c9a137f664cc6ee1d2a3468899512b7cc6fa79df223976::vault::Vault, arg1: 0x2::coin::Coin<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x1d7b440ff9a0bfe298c9a137f664cc6ee1d2a3468899512b7cc6fa79df223976::vault::assert_authorized(arg0, arg3);
        if (0x2::coin::value<T0>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, arg2);
        } else {
            0x2::coin::destroy_zero<T0>(arg1);
        };
    }

    // decompiled from Move bytecode v7
}

