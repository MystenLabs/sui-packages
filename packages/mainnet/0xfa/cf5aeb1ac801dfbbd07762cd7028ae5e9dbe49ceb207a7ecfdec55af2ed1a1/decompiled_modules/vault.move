module 0xfacf5aeb1ac801dfbbd07762cd7028ae5e9dbe49ceb207a7ecfdec55af2ed1a1::vault {
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

    public fun add_liquidity<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = mint_lp_token<T0, T1>(arg0, 0x2::coin::into_balance<T1>(arg1), arg2);
        let v1 = VaultLpToken<T0, T1>{
            id       : 0x2::object::new(arg2),
            vault_id : *0x2::object::uid_as_inner(&arg0.id),
            lsp      : v0,
        };
        0x2::transfer::public_transfer<VaultLpToken<T0, T1>>(v1, 0x2::tx_context::sender(arg2));
        0x2::coin::value<LSP<T0, T1>>(&v0)
    }

    public fun add_withdraw_request<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: VaultLpToken<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.vault_id == *0x2::object::uid_as_inner(&arg0.id), 0xfacf5aeb1ac801dfbbd07762cd7028ae5e9dbe49ceb207a7ecfdec55af2ed1a1::error::invalidLPToken());
        assert!(lp_token_value<T0, T1>(&arg1) > 0, 0xfacf5aeb1ac801dfbbd07762cd7028ae5e9dbe49ceb207a7ecfdec55af2ed1a1::error::zeroAmount());
        let v0 = WithdrawRequest<T0, T1>{
            lp_token : arg1,
            owner    : 0x2::tx_context::sender(arg2),
            epoch    : 0x2::tx_context::epoch(arg2),
        };
        0x1::vector::push_back<WithdrawRequest<T0, T1>>(&mut arg0.withdraw_requests, v0);
    }

    public fun adjust_vault_quote_asset_for_withdrawals<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg2: &0xdee9::custodian_v2::AccountCap, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = calculate_total_withdrawal_amount<T0, T1>(arg0);
        let v1 = 0x2::balance::value<T1>(&arg0.balance_y);
        if (v0 > v1) {
            let v2 = v0 - v1;
            let (_, _, v5, _) = 0xdee9::clob_v2::account_balance<T0, T1>(arg1, arg2);
            if (v5 >= v2) {
                0x2::coin::put<T1>(&mut arg0.balance_y, 0xdee9::clob_v2::withdraw_quote<T0, T1>(arg1, v5 - v2, arg2, arg4));
            } else {
                0x2::coin::put<T1>(&mut arg0.balance_y, 0xdee9::clob_v2::withdraw_quote<T0, T1>(arg1, v5, arg2, arg4));
                let (v7, _) = 0xdee9::clob_v2::get_market_price<T0, T1>(arg1);
                let v9 = v7;
                let v10 = (v2 - v5) / 0x1::option::get_with_default<u64>(&v9, 0);
                let (v11, v12) = 0xdee9::clob_v2::place_market_order<T0, T1>(arg1, arg2, 1, v10, false, 0xdee9::clob_v2::withdraw_base<T0, T1>(arg1, v10, arg2, arg4), 0x2::coin::zero<T1>(arg4), arg3, arg4);
                0x2::coin::put<T1>(&mut arg0.balance_y, v12);
                0xdee9::clob_v2::deposit_base<T0, T1>(arg1, v11, arg2);
            };
        };
    }

    public fun calculate_total_withdrawal_amount<T0, T1>(arg0: &mut Vault<T0, T1>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<WithdrawRequest<T0, T1>>(&arg0.withdraw_requests)) {
            let (_, v3, v4) = get_reserves<T0, T1>(arg0);
            v0 = v0 + 0xfacf5aeb1ac801dfbbd07762cd7028ae5e9dbe49ceb207a7ecfdec55af2ed1a1::safe_math::safe_mul_div_u64(v3, lp_token_value<T0, T1>(&0x1::vector::borrow<WithdrawRequest<T0, T1>>(&arg0.withdraw_requests, v1).lp_token), v4);
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_reserves<T0, T1>(arg0: &Vault<T0, T1>) : (u64, u64, u64) {
        (0x2::balance::value<T0>(&arg0.balance_x), 0x2::balance::value<T1>(&arg0.balance_y), 0x2::balance::supply_value<LSP<T0, T1>>(&arg0.lp_supply))
    }

    public fun lp_token_value<T0, T1>(arg0: &VaultLpToken<T0, T1>) : u64 {
        0x2::coin::value<LSP<T0, T1>>(&arg0.lsp)
    }

    fun mint_lp_token<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<LSP<T0, T1>> {
        let (_, v1, v2) = get_reserves<T0, T1>(arg0);
        let v3 = 0x2::balance::value<T1>(&arg1);
        let v4 = 0;
        if (v2 == 0) {
            v4 = v3;
            assert!(v3 > 0xfacf5aeb1ac801dfbbd07762cd7028ae5e9dbe49ceb207a7ecfdec55af2ed1a1::constants::minimal_liquidity(), 0xfacf5aeb1ac801dfbbd07762cd7028ae5e9dbe49ceb207a7ecfdec55af2ed1a1::error::notEnoughInitialLiquidity());
        } else {
            0xfacf5aeb1ac801dfbbd07762cd7028ae5e9dbe49ceb207a7ecfdec55af2ed1a1::safe_math::safe_mul_div_u64(v3, v2, v1);
        };
        assert!(v4 > 0, 0xfacf5aeb1ac801dfbbd07762cd7028ae5e9dbe49ceb207a7ecfdec55af2ed1a1::error::liquidityInsufficientMinted());
        0x2::balance::join<T1>(&mut arg0.balance_y, arg1);
        0x2::coin::from_balance<LSP<T0, T1>>(0x2::balance::increase_supply<LSP<T0, T1>>(&mut arg0.lp_supply, v4), arg2)
    }

    public fun new_vault<T0, T1>(arg0: &0xfacf5aeb1ac801dfbbd07762cd7028ae5e9dbe49ceb207a7ecfdec55af2ed1a1::app::AdminCap, arg1: &mut 0x2::tx_context::TxContext) : (Vault<T0, T1>, VaultCap) {
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

    public fun process_withdrawals<T0, T1>(arg0: &0xfacf5aeb1ac801dfbbd07762cd7028ae5e9dbe49ceb207a7ecfdec55af2ed1a1::app::AdminCap, arg1: &mut Vault<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        while (0x1::vector::length<WithdrawRequest<T0, T1>>(&arg1.withdraw_requests) > 0) {
            let WithdrawRequest {
                lp_token : v0,
                owner    : v1,
                epoch    : _,
            } = 0x1::vector::pop_back<WithdrawRequest<T0, T1>>(&mut arg1.withdraw_requests);
            let v3 = v0;
            let v4 = lp_token_value<T0, T1>(&v3);
            let (_, v6, v7) = get_reserves<T0, T1>(arg1);
            let v8 = 0xfacf5aeb1ac801dfbbd07762cd7028ae5e9dbe49ceb207a7ecfdec55af2ed1a1::safe_math::safe_mul_div_u64(v6, v4, v7);
            assert!(v8 > 0, 0xfacf5aeb1ac801dfbbd07762cd7028ae5e9dbe49ceb207a7ecfdec55af2ed1a1::error::zeroAmount());
            0x2::balance::decrease_supply<LSP<T0, T1>>(&mut arg1.lp_supply, 0x2::coin::into_balance<LSP<T0, T1>>(0x2::coin::split<LSP<T0, T1>>(&mut v3.lsp, v4, arg2)));
            let VaultLpToken {
                id       : v9,
                vault_id : _,
                lsp      : v11,
            } = v3;
            0x2::object::delete(v9);
            0x2::coin::destroy_zero<LSP<T0, T1>>(v11);
            let v12 = v8 * 0xfacf5aeb1ac801dfbbd07762cd7028ae5e9dbe49ceb207a7ecfdec55af2ed1a1::constants::withdraw_fee_percent();
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg1.balance_y, v8 - v12, arg2), v1);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg1.balance_y, v12, arg2), 0x2::tx_context::sender(arg2));
        };
    }

    public fun withdraw_assets_for_trading_account<T0, T1>(arg0: &0xfacf5aeb1ac801dfbbd07762cd7028ae5e9dbe49ceb207a7ecfdec55af2ed1a1::app::AdminCap, arg1: &mut Vault<T0, T1>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        (0x2::coin::take<T0>(&mut arg1.balance_x, arg2, arg4), 0x2::coin::take<T1>(&mut arg1.balance_y, arg3, arg4))
    }

    // decompiled from Move bytecode v6
}

