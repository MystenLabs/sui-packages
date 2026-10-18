module 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::strategy_suilend {
    struct SuilendCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ReduceTicket {
        vault: 0x2::object::ID,
        flash_used: u64,
        collateral_withdrawn: u64,
        rate: u64,
    }

    struct SuilendLevered has copy, drop {
        vault: 0x2::object::ID,
        principal: u64,
        flash: u64,
        flash_repay: u64,
        receipt_minted: u64,
    }

    struct SuilendReduced has copy, drop {
        vault: 0x2::object::ID,
        path: u8,
        collateral: u64,
        debt_repaid: u64,
        to_buffer: u64,
    }

    public fun deposit<T0, T1, T2, T3>(arg0: &mut 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T1, T2, T3>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T1, T2>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T3> {
        sync<T0, T1, T2, T3>(arg0, arg3, arg4, arg5, arg6);
        0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::deposit<T1, T2, T3>(arg0, arg2, 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::get_vault_rate<T1, T2>(arg1), 0x2::clock::timestamp_ms(arg6), arg7)
    }

    public fun deposit_receipt<T0, T1, T2, T3>(arg0: &mut 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T1, T2, T3>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T1, T2>, arg2: 0x2::coin::Coin<T2>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T3> {
        let v0 = 0x2::coin::value<T2>(&arg2);
        assert!(v0 > 0, 206);
        sync<T0, T1, T2, T3>(arg0, arg3, arg4, arg5, arg6);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_ctokens_into_obligation<T0, T2>(arg3, arg4, cap_ref<T0, T1, T2, T3>(arg0), arg6, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<T0, T2>(arg3, arg4, arg6, arg2, arg7), arg7);
        let v1 = 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::deposit_receipt<T1, T2, T3>(arg0, 0, v0, 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::get_vault_rate<T1, T2>(arg1), 0x2::clock::timestamp_ms(arg6), arg7);
        sync<T0, T1, T2, T3>(arg0, arg3, arg4, arg5, arg6);
        v1
    }

    public fun request_withdraw<T0, T1, T2, T3>(arg0: &mut 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T1, T2, T3>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T1, T2>, arg2: 0x2::coin::Coin<T3>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::WithdrawTicket {
        sync<T0, T1, T2, T3>(arg0, arg3, arg4, arg5, arg6);
        0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::request_withdraw<T1, T2, T3>(arg0, arg2, 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::get_vault_rate<T1, T2>(arg1), 0x2::clock::timestamp_ms(arg6), arg7)
    }

    public fun withdraw<T0, T1, T2, T3>(arg0: &mut 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T1, T2, T3>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T1, T2>, arg2: 0x2::coin::Coin<T3>, arg3: u64, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        sync<T0, T1, T2, T3>(arg0, arg4, arg5, arg6, arg7);
        0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::withdraw<T1, T2, T3>(arg0, arg2, arg3, 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::get_vault_rate<T1, T2>(arg1), 0x2::clock::timestamp_ms(arg7), arg8)
    }

    public fun attach_suilend<T0, T1, T2, T3>(arg0: &mut 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T1, T2, T3>, arg1: &0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::AdminCap, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::uid_mut<T1, T2, T3>(arg0);
        let v1 = SuilendCapKey{dummy_field: false};
        assert!(!0x2::dynamic_object_field::exists<SuilendCapKey>(v0, v1), 200);
        let v2 = SuilendCapKey{dummy_field: false};
        0x2::dynamic_object_field::add<SuilendCapKey, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>>(v0, v2, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::create_obligation<T0>(arg2, arg3));
    }

    public fun begin_reduce<T0, T1, T2, T3>(arg0: &mut 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T1, T2, T3>, arg1: &0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::KeeperCap, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: u64, arg6: u64, arg7: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T1, T2>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, 0x2::coin::Coin<T1>, ReduceTicket) {
        0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::assert_keeper<T1, T2, T3>(arg0, arg1);
        let v0 = 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::get_vault_rate<T1, T2>(arg7);
        sync<T0, T1, T2, T3>(arg0, arg4, arg5, arg6, arg8);
        let v1 = 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::leg_ltv_bps<T1, T2, T3>(arg0, 0, v0);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::repay<T0, T1>(arg4, arg6, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<T0>(cap_ref<T0, T1, T2, T3>(arg0)), arg8, &mut arg2, arg9);
        let v2 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<T0, T2>(arg4, arg5, arg8, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<T0, T2>(arg4, arg5, cap_ref<T0, T1, T2, T3>(arg0), arg8, arg3, arg9), 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T2>>(), arg9);
        sync<T0, T1, T2, T3>(arg0, arg4, arg5, arg6, arg8);
        0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::check_leg_after_sync<T1, T2, T3>(arg0, 0, v0, true, v1);
        let v3 = ReduceTicket{
            vault                : 0x2::object::id<0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T1, T2, T3>>(arg0),
            flash_used           : 0x2::coin::value<T1>(&arg2) - 0x2::coin::value<T1>(&arg2),
            collateral_withdrawn : 0x2::coin::value<T2>(&v2),
            rate                 : v0,
        };
        (v2, arg2, v3)
    }

    fun cap_ref<T0, T1, T2, T3>(arg0: &0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T1, T2, T3>) : &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0> {
        let v0 = 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::uid<T1, T2, T3>(arg0);
        let v1 = SuilendCapKey{dummy_field: false};
        assert!(0x2::dynamic_object_field::exists<SuilendCapKey>(v0, v1), 201);
        let v2 = SuilendCapKey{dummy_field: false};
        0x2::dynamic_object_field::borrow<SuilendCapKey, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>>(v0, v2)
    }

    fun ceil_bps(arg0: u64, arg1: u64) : u64 {
        ((((arg0 as u128) * (arg1 as u128) + (10000 as u128) - 1) / (10000 as u128)) as u64)
    }

    public fun finish_reduce_redeem<T0, T1, T2>(arg0: &mut 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T0, T1, T2>, arg1: &0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::KeeperCap, arg2: 0x2::coin::Coin<T1>, arg3: ReduceTicket, arg4: u64, arg5: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T0, T1>, arg6: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::assert_keeper<T0, T1, T2>(arg0, arg1);
        let ReduceTicket {
            vault                : v0,
            flash_used           : v1,
            collateral_withdrawn : v2,
            rate                 : _,
        } = arg3;
        assert!(v0 == 0x2::object::id<0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T0, T1, T2>>(arg0), 204);
        assert!(arg4 <= ceil_bps(v1, 10), 202);
        assert!(0x2::coin::value<T1>(&arg2) == v2, 207);
        let v4 = 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::redeem_shares<T0, T1>(arg5, arg6, 0x2::coin::into_balance<T1>(arg2), 0x2::object::id_address<0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T0, T1, T2>>(arg0), arg7, arg8);
        let (_, _, _, v8, _, _) = 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::decode_withdrawal_request(&v4);
        0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::add_redeeming<T0, T1, T2>(arg0, v8);
        let v11 = SuilendReduced{
            vault       : v0,
            path        : 1,
            collateral  : v2,
            debt_repaid : v1,
            to_buffer   : 0,
        };
        0x2::event::emit<SuilendReduced>(v11);
        0x2::coin::from_balance<T0>(0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::take_buffer<T0, T1, T2>(arg0, v1 + arg4), arg8)
    }

    public fun finish_reduce_swapped<T0, T1, T2>(arg0: &mut 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T0, T1, T2>, arg1: &0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::KeeperCap, arg2: 0x2::coin::Coin<T0>, arg3: ReduceTicket, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::assert_keeper<T0, T1, T2>(arg0, arg1);
        let ReduceTicket {
            vault                : v0,
            flash_used           : v1,
            collateral_withdrawn : v2,
            rate                 : v3,
        } = arg3;
        assert!(v0 == 0x2::object::id<0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T0, T1, T2>>(arg0), 204);
        assert!(arg4 <= ceil_bps(v1, 10), 202);
        assert!((0x2::coin::value<T0>(&arg2) as u128) >= 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::receipt_value(v2, v3) * ((10000 - 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::max_exit_slippage_bps<T0, T1, T2>(arg0)) as u128) / (10000 as u128), 203);
        let v4 = 0x2::coin::into_balance<T0>(arg2);
        0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::put_buffer<T0, T1, T2>(arg0, v4);
        let v5 = SuilendReduced{
            vault       : v0,
            path        : 0,
            collateral  : v2,
            debt_repaid : v1,
            to_buffer   : 0x2::balance::value<T0>(&v4),
        };
        0x2::event::emit<SuilendReduced>(v5);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v4, v1 + arg4), arg5)
    }

    public fun lever_up<T0, T1, T2, T3>(arg0: &mut 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T1, T2, T3>, arg1: &0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::KeeperCap, arg2: u64, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg7: u64, arg8: u64, arg9: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T1, T2>, arg10: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::assert_keeper<T1, T2, T3>(arg0, arg1);
        0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::assert_can_lever<T1, T2, T3>(arg0, 0);
        let v0 = 0x2::coin::value<T1>(&arg3);
        assert!(arg4 >= v0 && arg4 <= v0 + ceil_bps(v0, 10), 202);
        let v1 = 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::take_pending<T1, T2, T3>(arg0, arg2);
        0x2::balance::join<T1>(&mut v1, 0x2::coin::into_balance<T1>(arg3));
        let v2 = 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::deposit_asset_v2<T1, T2>(arg9, arg10, v1, arg5, arg11, arg12);
        let v3 = cap_ref<T0, T1, T2, T3>(arg0);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_ctokens_into_obligation<T0, T2>(arg6, arg7, v3, arg11, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<T0, T2>(arg6, arg7, arg11, v2, arg12), arg12);
        let v4 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<T0, T1>(arg6, arg8, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::borrow_request<T0, T1>(arg6, arg8, v3, arg11, arg4), arg12);
        sync<T0, T1, T2, T3>(arg0, arg6, arg7, arg8, arg11);
        0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::check_leg_after_sync<T1, T2, T3>(arg0, 0, 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::get_vault_rate<T1, T2>(arg9), false, 0);
        let v5 = SuilendLevered{
            vault          : 0x2::object::id<0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T1, T2, T3>>(arg0),
            principal      : arg2,
            flash          : v0,
            flash_repay    : arg4,
            receipt_minted : 0x2::coin::value<T2>(&v2),
        };
        0x2::event::emit<SuilendLevered>(v5);
        v4
    }

    fun sync<T0, T1, T2, T3>(arg0: &mut 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T1, T2, T3>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) {
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<T0>(cap_ref<T0, T1, T2, T3>(arg0));
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_obligation<T0>(arg1, v0, arg4);
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T0>(arg1, v0);
        let v2 = 0;
        let v3 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposits<T0>(v1);
        let v4 = 0;
        while (v4 < 0x1::vector::length<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Deposit>(v3)) {
            let v5 = 0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Deposit>(v3, v4);
            assert!(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposit_reserve_array_index(v5) == arg2, 205);
            v2 = v2 + 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposit_deposited_ctoken_amount(v5);
            v4 = v4 + 1;
        };
        let v6 = 0;
        let v7 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::borrows<T0>(v1);
        let v8 = 0;
        while (v8 < 0x1::vector::length<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Borrow>(v7)) {
            let v9 = 0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Borrow>(v7, v8);
            assert!(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::borrow_reserve_array_index(v9) == arg3, 205);
            v6 = v6 + 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::ceil(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::borrow_borrowed_amount(v9));
            v8 = v8 + 1;
        };
        0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::sync_leg<T1, T2, T3>(arg0, 0, v2, v6, 0x2::clock::timestamp_ms(arg4));
    }

    public fun sync_books<T0, T1, T2, T3>(arg0: &mut 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T1, T2, T3>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) {
        sync<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v7
}

