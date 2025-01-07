module 0xf5bf8fc9054d0ac6daeb8f73e374bde28015d588b2b3375f8f48d74c0cc2e476::vault {
    struct LSP<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    struct VaultLpToken<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        lsp: 0x2::coin::Coin<LSP<T0, T1>>,
    }

    struct WithdrawRequest<phantom T0, phantom T1> has store {
        lp_token: VaultLpToken<T0, T1>,
        owner: address,
        epoch: u64,
    }

    struct Vault<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        type_x: 0x1::type_name::TypeName,
        type_y: 0x1::type_name::TypeName,
        balance_x: 0x2::balance::Balance<T0>,
        balance_y: 0x2::balance::Balance<T1>,
        maker_fees_X: 0x2::balance::Balance<T0>,
        maker_fees_Y: 0x2::balance::Balance<T1>,
        open_orders_collateral_x: 0x2::balance::Balance<T0>,
        open_orders_collateral_y: 0x2::balance::Balance<T1>,
        lp_supply: 0x2::balance::Supply<LSP<T0, T1>>,
        withdraw_requests: vector<WithdrawRequest<T0, T1>>,
    }

    struct VaultCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    public fun add_liquidity<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = mint_lp_token<T0, T1>(arg0, 0x2::coin::into_balance<T0>(arg1), 0x2::coin::into_balance<T1>(arg2), arg3);
        let v1 = VaultLpToken<T0, T1>{
            id       : 0x2::object::new(arg3),
            vault_id : *0x2::object::uid_as_inner(&arg0.id),
            lsp      : v0,
        };
        0x2::transfer::public_transfer<VaultLpToken<T0, T1>>(v1, 0x2::tx_context::sender(arg3));
        0x2::coin::value<LSP<T0, T1>>(&v0)
    }

    public fun add_withdraw_request<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: VaultLpToken<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.vault_id == *0x2::object::uid_as_inner(&arg0.id), 0xf5bf8fc9054d0ac6daeb8f73e374bde28015d588b2b3375f8f48d74c0cc2e476::error::invalidLPToken());
        assert!(lp_token_value<T0, T1>(&arg1) > 0, 0xf5bf8fc9054d0ac6daeb8f73e374bde28015d588b2b3375f8f48d74c0cc2e476::error::zeroAmount());
        let v0 = WithdrawRequest<T0, T1>{
            lp_token : arg1,
            owner    : 0x2::tx_context::sender(arg2),
            epoch    : 0x2::tx_context::epoch(arg2),
        };
        0x1::vector::push_back<WithdrawRequest<T0, T1>>(&mut arg0.withdraw_requests, v0);
    }

    public fun get_reserves<T0, T1>(arg0: &Vault<T0, T1>) : (u64, u64, u64) {
        (0x2::balance::value<T0>(&arg0.balance_x), 0x2::balance::value<T1>(&arg0.balance_y), 0x2::balance::supply_value<LSP<T0, T1>>(&arg0.lp_supply))
    }

    public fun lp_token_value<T0, T1>(arg0: &VaultLpToken<T0, T1>) : u64 {
        0x2::coin::value<LSP<T0, T1>>(&arg0.lsp)
    }

    fun mint_lp_token<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<LSP<T0, T1>> {
        let (v0, v1, v2) = get_reserves<T0, T1>(arg0);
        let v3 = if (v2 == 0) {
            let v4 = (0x2::math::sqrt_u128((0x2::balance::value<T0>(&arg1) as u128) * (0x2::balance::value<T1>(&arg2) as u128)) as u64);
            assert!(v4 > 0xf5bf8fc9054d0ac6daeb8f73e374bde28015d588b2b3375f8f48d74c0cc2e476::constants::minimal_liquidity(), 0xf5bf8fc9054d0ac6daeb8f73e374bde28015d588b2b3375f8f48d74c0cc2e476::error::notEnoughInitialLiquidity());
            v4
        } else {
            0x2::math::min(0xf5bf8fc9054d0ac6daeb8f73e374bde28015d588b2b3375f8f48d74c0cc2e476::safe_math::safe_mul_div_u64(0x2::balance::value<T0>(&arg1), v2, v0), 0xf5bf8fc9054d0ac6daeb8f73e374bde28015d588b2b3375f8f48d74c0cc2e476::safe_math::safe_mul_div_u64(0x2::balance::value<T1>(&arg2), v2, v1))
        };
        assert!(v3 > 0, 0xf5bf8fc9054d0ac6daeb8f73e374bde28015d588b2b3375f8f48d74c0cc2e476::error::liquidityInsufficientMinted());
        0x2::balance::join<T0>(&mut arg0.balance_x, arg1);
        0x2::balance::join<T1>(&mut arg0.balance_y, arg2);
        0x2::coin::from_balance<LSP<T0, T1>>(0x2::balance::increase_supply<LSP<T0, T1>>(&mut arg0.lp_supply, v3), arg3)
    }

    public fun new_vault<T0, T1>(arg0: &0xf5bf8fc9054d0ac6daeb8f73e374bde28015d588b2b3375f8f48d74c0cc2e476::app::AdminCap, arg1: &mut 0x2::tx_context::TxContext) : (Vault<T0, T1>, VaultCap) {
        let v0 = LSP<T0, T1>{dummy_field: false};
        let v1 = Vault<T0, T1>{
            id                       : 0x2::object::new(arg1),
            type_x                   : 0x1::type_name::get<T0>(),
            type_y                   : 0x1::type_name::get<T1>(),
            balance_x                : 0x2::balance::zero<T0>(),
            balance_y                : 0x2::balance::zero<T1>(),
            maker_fees_X             : 0x2::balance::zero<T0>(),
            maker_fees_Y             : 0x2::balance::zero<T1>(),
            open_orders_collateral_x : 0x2::balance::zero<T0>(),
            open_orders_collateral_y : 0x2::balance::zero<T1>(),
            lp_supply                : 0x2::balance::create_supply<LSP<T0, T1>>(v0),
            withdraw_requests        : 0x1::vector::empty<WithdrawRequest<T0, T1>>(),
        };
        let v2 = VaultCap{
            id       : 0x2::object::new(arg1),
            vault_id : 0x2::object::id<Vault<T0, T1>>(&v1),
        };
        (v1, v2)
    }

    public fun process_withdrawals<T0, T1>(arg0: &0xf5bf8fc9054d0ac6daeb8f73e374bde28015d588b2b3375f8f48d74c0cc2e476::app::AdminCap, arg1: &mut Vault<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        while (0x1::vector::length<WithdrawRequest<T0, T1>>(&arg1.withdraw_requests) > 0) {
            let WithdrawRequest {
                lp_token : v0,
                owner    : v1,
                epoch    : _,
            } = 0x1::vector::pop_back<WithdrawRequest<T0, T1>>(&mut arg1.withdraw_requests);
            let v3 = v0;
            let v4 = lp_token_value<T0, T1>(&v3);
            let (v5, v6, v7) = get_reserves<T0, T1>(arg1);
            let v8 = 0xf5bf8fc9054d0ac6daeb8f73e374bde28015d588b2b3375f8f48d74c0cc2e476::safe_math::safe_mul_div_u64(v6, v4, v7);
            let v9 = 0xf5bf8fc9054d0ac6daeb8f73e374bde28015d588b2b3375f8f48d74c0cc2e476::safe_math::safe_mul_div_u64(v5, v4, v7);
            assert!(v8 > 0 && v9 > 0, 0xf5bf8fc9054d0ac6daeb8f73e374bde28015d588b2b3375f8f48d74c0cc2e476::error::zeroAmount());
            0x2::balance::decrease_supply<LSP<T0, T1>>(&mut arg1.lp_supply, 0x2::coin::into_balance<LSP<T0, T1>>(0x2::coin::split<LSP<T0, T1>>(&mut v3.lsp, v4, arg2)));
            let VaultLpToken {
                id       : v10,
                vault_id : _,
                lsp      : v12,
            } = v3;
            0x2::object::delete(v10);
            0x2::coin::destroy_zero<LSP<T0, T1>>(v12);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.balance_x, v9, arg2), v1);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg1.balance_y, v8, arg2), v1);
        };
    }

    public fun withdraw_assets_for_trading_account<T0, T1>(arg0: &0xf5bf8fc9054d0ac6daeb8f73e374bde28015d588b2b3375f8f48d74c0cc2e476::app::AdminCap, arg1: &mut Vault<T0, T1>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        (0x2::coin::take<T0>(&mut arg1.balance_x, arg2, arg4), 0x2::coin::take<T1>(&mut arg1.balance_y, arg3, arg4))
    }

    // decompiled from Move bytecode v6
}

