module 0xf5bf8fc9054d0ac6daeb8f73e374bde28015d588b2b3375f8f48d74c0cc2e476::vault_actions {
    struct VaultCreatedEvent has copy, drop {
        vaultId: 0x2::object::ID,
        createdBy: address,
        typeX: 0x1::type_name::TypeName,
        typeY: 0x1::type_name::TypeName,
    }

    struct LiquidityAddedEvent has copy, drop {
        vaultId: 0x2::object::ID,
        amount_x: u64,
        amount_y: u64,
        lpTokensMinted: u64,
        sender: address,
    }

    public entry fun add_liquidity<T0, T1>(arg0: &mut 0xf5bf8fc9054d0ac6daeb8f73e374bde28015d588b2b3375f8f48d74c0cc2e476::vault::Vault<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = LiquidityAddedEvent{
            vaultId        : 0x2::object::id<0xf5bf8fc9054d0ac6daeb8f73e374bde28015d588b2b3375f8f48d74c0cc2e476::vault::Vault<T0, T1>>(arg0),
            amount_x       : 0x2::coin::value<T0>(&arg1),
            amount_y       : 0x2::coin::value<T1>(&arg2),
            lpTokensMinted : 0xf5bf8fc9054d0ac6daeb8f73e374bde28015d588b2b3375f8f48d74c0cc2e476::vault::add_liquidity<T0, T1>(arg0, arg1, arg2, arg3),
            sender         : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<LiquidityAddedEvent>(v0);
    }

    public entry fun process_withdrawals<T0, T1>(arg0: &0xf5bf8fc9054d0ac6daeb8f73e374bde28015d588b2b3375f8f48d74c0cc2e476::app::AdminCap, arg1: &mut 0xf5bf8fc9054d0ac6daeb8f73e374bde28015d588b2b3375f8f48d74c0cc2e476::vault::Vault<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0xf5bf8fc9054d0ac6daeb8f73e374bde28015d588b2b3375f8f48d74c0cc2e476::vault::process_withdrawals<T0, T1>(arg0, arg1, arg2);
    }

    public entry fun create_vault<T0, T1>(arg0: &0xf5bf8fc9054d0ac6daeb8f73e374bde28015d588b2b3375f8f48d74c0cc2e476::app::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf5bf8fc9054d0ac6daeb8f73e374bde28015d588b2b3375f8f48d74c0cc2e476::vault::new_vault<T0, T1>(arg0, arg1);
        let v2 = v0;
        let v3 = VaultCreatedEvent{
            vaultId   : 0x2::object::id<0xf5bf8fc9054d0ac6daeb8f73e374bde28015d588b2b3375f8f48d74c0cc2e476::vault::Vault<T0, T1>>(&v2),
            createdBy : 0x2::tx_context::sender(arg1),
            typeX     : 0x1::type_name::get<T0>(),
            typeY     : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<VaultCreatedEvent>(v3);
        0x2::transfer::public_share_object<0xf5bf8fc9054d0ac6daeb8f73e374bde28015d588b2b3375f8f48d74c0cc2e476::vault::Vault<T0, T1>>(v2);
        0x2::transfer::public_transfer<0xf5bf8fc9054d0ac6daeb8f73e374bde28015d588b2b3375f8f48d74c0cc2e476::vault::VaultCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun submit_withdrawal_request<T0, T1>(arg0: &mut 0xf5bf8fc9054d0ac6daeb8f73e374bde28015d588b2b3375f8f48d74c0cc2e476::vault::Vault<T0, T1>, arg1: 0xf5bf8fc9054d0ac6daeb8f73e374bde28015d588b2b3375f8f48d74c0cc2e476::vault::VaultLpToken<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0xf5bf8fc9054d0ac6daeb8f73e374bde28015d588b2b3375f8f48d74c0cc2e476::vault::add_withdraw_request<T0, T1>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

