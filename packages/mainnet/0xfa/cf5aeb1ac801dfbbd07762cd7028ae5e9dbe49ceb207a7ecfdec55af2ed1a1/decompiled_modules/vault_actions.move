module 0xfacf5aeb1ac801dfbbd07762cd7028ae5e9dbe49ceb207a7ecfdec55af2ed1a1::vault_actions {
    struct VaultCreatedEvent has copy, drop {
        vaultId: 0x2::object::ID,
        createdBy: address,
        typeX: 0x1::type_name::TypeName,
        typeY: 0x1::type_name::TypeName,
    }

    struct LiquidityAddedEvent has copy, drop {
        vaultId: 0x2::object::ID,
        amount_y: u64,
        lpTokensMinted: u64,
        sender: address,
    }

    public entry fun add_liquidity<T0, T1>(arg0: &mut 0xfacf5aeb1ac801dfbbd07762cd7028ae5e9dbe49ceb207a7ecfdec55af2ed1a1::vault::Vault<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = LiquidityAddedEvent{
            vaultId        : 0x2::object::id<0xfacf5aeb1ac801dfbbd07762cd7028ae5e9dbe49ceb207a7ecfdec55af2ed1a1::vault::Vault<T0, T1>>(arg0),
            amount_y       : 0x2::coin::value<T1>(&arg1),
            lpTokensMinted : 0xfacf5aeb1ac801dfbbd07762cd7028ae5e9dbe49ceb207a7ecfdec55af2ed1a1::vault::add_liquidity<T0, T1>(arg0, arg1, arg2),
            sender         : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<LiquidityAddedEvent>(v0);
    }

    public entry fun process_withdrawals<T0, T1>(arg0: &0xfacf5aeb1ac801dfbbd07762cd7028ae5e9dbe49ceb207a7ecfdec55af2ed1a1::app::AdminCap, arg1: &mut 0xfacf5aeb1ac801dfbbd07762cd7028ae5e9dbe49ceb207a7ecfdec55af2ed1a1::vault::Vault<T0, T1>, arg2: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg3: &0xdee9::custodian_v2::AccountCap, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xfacf5aeb1ac801dfbbd07762cd7028ae5e9dbe49ceb207a7ecfdec55af2ed1a1::vault::adjust_vault_quote_asset_for_withdrawals<T0, T1>(arg1, arg2, arg3, arg4, arg5);
        0xfacf5aeb1ac801dfbbd07762cd7028ae5e9dbe49ceb207a7ecfdec55af2ed1a1::vault::process_withdrawals<T0, T1>(arg0, arg1, arg5);
    }

    public entry fun create_vault<T0, T1>(arg0: &0xfacf5aeb1ac801dfbbd07762cd7028ae5e9dbe49ceb207a7ecfdec55af2ed1a1::app::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xfacf5aeb1ac801dfbbd07762cd7028ae5e9dbe49ceb207a7ecfdec55af2ed1a1::vault::new_vault<T0, T1>(arg0, arg1);
        let v2 = v0;
        let v3 = VaultCreatedEvent{
            vaultId   : 0x2::object::id<0xfacf5aeb1ac801dfbbd07762cd7028ae5e9dbe49ceb207a7ecfdec55af2ed1a1::vault::Vault<T0, T1>>(&v2),
            createdBy : 0x2::tx_context::sender(arg1),
            typeX     : 0x1::type_name::get<T0>(),
            typeY     : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<VaultCreatedEvent>(v3);
        0x2::transfer::public_share_object<0xfacf5aeb1ac801dfbbd07762cd7028ae5e9dbe49ceb207a7ecfdec55af2ed1a1::vault::Vault<T0, T1>>(v2);
        0x2::transfer::public_transfer<0xfacf5aeb1ac801dfbbd07762cd7028ae5e9dbe49ceb207a7ecfdec55af2ed1a1::vault::VaultCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun submit_withdrawal_request<T0, T1>(arg0: &mut 0xfacf5aeb1ac801dfbbd07762cd7028ae5e9dbe49ceb207a7ecfdec55af2ed1a1::vault::Vault<T0, T1>, arg1: 0xfacf5aeb1ac801dfbbd07762cd7028ae5e9dbe49ceb207a7ecfdec55af2ed1a1::vault::VaultLpToken<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0xfacf5aeb1ac801dfbbd07762cd7028ae5e9dbe49ceb207a7ecfdec55af2ed1a1::vault::add_withdraw_request<T0, T1>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

