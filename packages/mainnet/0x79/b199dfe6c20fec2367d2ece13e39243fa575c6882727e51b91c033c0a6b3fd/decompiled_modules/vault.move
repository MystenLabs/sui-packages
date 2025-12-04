module 0x79b199dfe6c20fec2367d2ece13e39243fa575c6882727e51b91c033c0a6b3fd::vault {
    struct UserPoolKey has copy, drop, store {
        user: address,
        pool_index: u64,
    }

    struct VAULT has drop {
        dummy_field: bool,
    }

    struct Vault has store, key {
        id: 0x2::object::UID,
        coin: 0x2::coin::Coin<0x2::sui::SUI>,
        vault_value: u64,
        total_shares: u64,
        hwm: u64,
        paused: bool,
        config: VaultConfig,
        admin: address,
        strategies_id: 0x2::object::ID,
        sui_index: u8,
        usdc_index: u8,
        share_treasury: 0x2::coin::TreasuryCap<VAULT>,
        total_deposits: u64,
        total_withdrawals: u64,
        active_reserves: vector<u64>,
    }

    struct ReserveKey has copy, drop, store {
        reserve_index: u64,
    }

    struct VaultReserveSlot<phantom T0> has store {
        obligation_cap: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>,
    }

    struct VaultConfig has store {
        min_deposit: u64,
        deposit_paused: bool,
        fee_bps: u64,
        fee_recipient: address,
    }

    struct VaultEvent has copy, drop, store {
        kind: u8,
        user: address,
        amount: u64,
        shares: u64,
        extra: u64,
        type_name: 0x1::type_name::TypeName,
        flag: bool,
    }

    public fun accrue_performance_fee(arg0: &mut Vault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.config.fee_recipient;
        if (get_pps(arg0) <= get_hwm(arg0)) {
            return
        };
        let v1 = arg1 * arg0.config.fee_bps / 10000;
        if (v1 == 0) {
            return
        };
        let v2 = (((v1 as u128) * (arg0.total_shares as u128) / (arg0.vault_value as u128)) as u64);
        if (v2 > 0) {
            arg0.total_shares = arg0.total_shares + v2;
            0x2::transfer::public_transfer<0x2::coin::Coin<VAULT>>(0x2::coin::mint<VAULT>(&mut arg0.share_treasury, v2, arg2), v0);
            let v3 = VaultEvent{
                kind      : 4,
                user      : v0,
                amount    : v1,
                shares    : v2,
                extra     : 0,
                type_name : 0x1::type_name::with_defining_ids<0x2::sui::SUI>(),
                flag      : false,
            };
            0x2::event::emit<VaultEvent>(v3);
        };
        sync_hwm(arg0);
    }

    public fun accrue_performance_fee_with_adapter<T0>(arg0: &mut Vault, arg1: u64, arg2: u64, arg3: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0x79b199dfe6c20fec2367d2ece13e39243fa575c6882727e51b91c033c0a6b3fd::suilend_adapter::get_suilend_reserve<T0, 0x2::sui::SUI>(arg3);
        let v0 = arg0.config.fee_recipient;
        if (get_pps_with_lst(arg0, arg2) <= get_hwm(arg0)) {
            return
        };
        let v1 = arg1 * arg0.config.fee_bps / 10000;
        if (v1 == 0) {
            return
        };
        let v2 = (((v1 as u128) * (arg0.total_shares as u128) / (get_total_assets(arg0, arg2) as u128)) as u64);
        if (v2 > 0) {
            arg0.total_shares = arg0.total_shares + v2;
            0x2::transfer::public_transfer<0x2::coin::Coin<VAULT>>(0x2::coin::mint<VAULT>(&mut arg0.share_treasury, v2, arg4), v0);
        };
        sync_hwm(arg0);
        let v3 = VaultEvent{
            kind      : 4,
            user      : v0,
            amount    : v1,
            shares    : v2,
            extra     : 0,
            type_name : 0x1::type_name::with_defining_ids<0x2::sui::SUI>(),
            flag      : false,
        };
        0x2::event::emit<VaultEvent>(v3);
    }

    public fun accrue_performance_fee_with_lst(arg0: &mut Vault, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.config.fee_recipient;
        if (get_pps_with_lst(arg0, arg2) <= get_hwm(arg0)) {
            return
        };
        let v1 = arg1 * arg0.config.fee_bps / 10000;
        if (v1 == 0) {
            return
        };
        let v2 = (((v1 as u128) * (arg0.total_shares as u128) / (get_total_assets(arg0, arg2) as u128)) as u64);
        if (v2 > 0) {
            arg0.total_shares = arg0.total_shares + v2;
            0x2::transfer::public_transfer<0x2::coin::Coin<VAULT>>(0x2::coin::mint<VAULT>(&mut arg0.share_treasury, v2, arg3), v0);
            let v3 = VaultEvent{
                kind      : 4,
                user      : v0,
                amount    : v1,
                shares    : v2,
                extra     : 0,
                type_name : 0x1::type_name::with_defining_ids<0x2::sui::SUI>(),
                flag      : false,
            };
            0x2::event::emit<VaultEvent>(v3);
        };
        sync_hwm(arg0);
    }

    fun accrue_protocol_yields<T0, T1, T2, T3>(arg0: &mut Vault, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T1>, arg3: &0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T2>, arg4: &0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T3>, arg5: &vector<u64>) {
        arg0.vault_value = 0x2::coin::value<0x2::sui::SUI>(&arg0.coin) + calculate_suilend_sui_value<T0>(arg0, arg1) + calculate_lst_current_value<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun add_active_reserve(arg0: &mut Vault, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg0.active_reserves)) {
            assert!(*0x1::vector::borrow<u64>(&arg0.active_reserves, v0) != arg1, 2);
            v0 = v0 + 1;
        };
        0x1::vector::push_back<u64>(&mut arg0.active_reserves, arg1);
    }

    public fun add_total_shares(arg0: &mut Vault, arg1: u64) {
        arg0.total_shares = arg0.total_shares + arg1;
    }

    public entry fun admin_claim_and_compound_reward<T0>(arg0: &mut Vault, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x2::clock::Clock, arg3: u64, arg4: u64, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg6) == arg0.admin, 1001);
        let v0 = borrow_reserve_slot_shared<T0>(arg0, arg3);
        let v1 = 0x79b199dfe6c20fec2367d2ece13e39243fa575c6882727e51b91c033c0a6b3fd::suilend_adapter::claim_rewards_from_suilend<T0, 0x2::sui::SUI>(arg1, &v0.obligation_cap, arg2, arg3, arg4, arg5, arg6);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&v1);
        if (v2 > 0) {
            0x2::balance::join<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(&mut arg0.coin), 0x2::coin::into_balance<0x2::sui::SUI>(v1));
            arg0.vault_value = arg0.vault_value + v2;
            if (get_pps(arg0) > get_hwm(arg0)) {
                let v3 = arg0.vault_value - arg0.hwm;
                accrue_performance_fee(arg0, v3, arg6);
            };
            let v4 = VaultEvent{
                kind      : 7,
                user      : arg0.admin,
                amount    : v2,
                shares    : 0,
                extra     : 0x2::clock::timestamp_ms(arg2),
                type_name : 0x1::type_name::with_defining_ids<0x2::sui::SUI>(),
                flag      : true,
            };
            0x2::event::emit<VaultEvent>(v4);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v1);
        };
    }

    public entry fun admin_claim_reward<T0, T1>(arg0: &mut Vault, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x2::clock::Clock, arg3: u64, arg4: u64, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg6) == arg0.admin, 1001);
        let v0 = arg0.config.fee_recipient;
        let v1 = 0x79b199dfe6c20fec2367d2ece13e39243fa575c6882727e51b91c033c0a6b3fd::suilend_adapter::claim_rewards_from_suilend<T0, T1>(arg1, &borrow_reserve_slot_shared<T0>(arg0, arg3).obligation_cap, arg2, arg3, arg4, arg5, arg6);
        let v2 = 0x2::coin::value<T1>(&v1);
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, v0);
            let v3 = VaultEvent{
                kind      : 7,
                user      : v0,
                amount    : v2,
                shares    : 0,
                extra     : 0x2::clock::timestamp_ms(arg2),
                type_name : 0x1::type_name::with_defining_ids<T1>(),
                flag      : false,
            };
            0x2::event::emit<VaultEvent>(v3);
        } else {
            0x2::coin::destroy_zero<T1>(v1);
        };
    }

    public entry fun admin_rebalance<T0, T1: drop, T2: drop, T3: drop>(arg0: &mut Vault, arg1: &0x79b199dfe6c20fec2367d2ece13e39243fa575c6882727e51b91c033c0a6b3fd::strategy::Strategies, arg2: 0x79b199dfe6c20fec2367d2ece13e39243fa575c6882727e51b91c033c0a6b3fd::strategy::Strategies, arg3: vector<u64>, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T1>, arg7: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T2>, arg8: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T3>, arg9: &mut 0x3::sui_system::SuiSystemState, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg11) == arg0.admin, 0);
        assert!(!arg0.paused, 1);
        let v0 = 0x79b199dfe6c20fec2367d2ece13e39243fa575c6882727e51b91c033c0a6b3fd::strategy::get_allocations(arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x79b199dfe6c20fec2367d2ece13e39243fa575c6882727e51b91c033c0a6b3fd::strategy::Allocation>(&v0)) {
            let (_, v3, _, _) = 0x79b199dfe6c20fec2367d2ece13e39243fa575c6882727e51b91c033c0a6b3fd::strategy::get_allocation_fields(0x1::vector::borrow<0x79b199dfe6c20fec2367d2ece13e39243fa575c6882727e51b91c033c0a6b3fd::strategy::Allocation>(&v0, v1));
            if (0x2::dynamic_field::exists_<ReserveKey>(&arg0.id, reserve_key(v3))) {
                let v6 = withdraw_from_reserve<T0, T1, T2, T3>(arg0, arg4, v3, arg10, arg5, 18446744073709551615, 10000, arg6, arg7, arg8, &arg3, arg9, arg11);
                0x2::coin::join<0x2::sui::SUI>(&mut arg0.coin, v6);
            };
            v1 = v1 + 1;
        };
        arg0.vault_value = 0x2::coin::value<0x2::sui::SUI>(&arg0.coin);
        let v7 = 0x79b199dfe6c20fec2367d2ece13e39243fa575c6882727e51b91c033c0a6b3fd::strategy::get_allocations(&arg2);
        let v8 = 0;
        while (v8 < 0x1::vector::length<0x79b199dfe6c20fec2367d2ece13e39243fa575c6882727e51b91c033c0a6b3fd::strategy::Allocation>(&v7)) {
            let (_, v10, v11, v12) = 0x79b199dfe6c20fec2367d2ece13e39243fa575c6882727e51b91c033c0a6b3fd::strategy::get_allocation_fields(0x1::vector::borrow<0x79b199dfe6c20fec2367d2ece13e39243fa575c6882727e51b91c033c0a6b3fd::strategy::Allocation>(&v7, v8));
            let v13 = arg0.vault_value * v11 / 10000;
            if (v13 > 0) {
                let v14 = 0x2::coin::split<0x2::sui::SUI>(&mut arg0.coin, v13, arg11);
                ensure_reserve_slot<T0>(arg0, arg4, v10, arg11);
                deposit_to_reserve<T0, T1, T2, T3>(arg0, arg4, v10, arg10, v14, v12, arg5, arg6, arg7, arg8, &arg3, arg9, arg11);
            };
            v8 = v8 + 1;
        };
        arg0.strategies_id = 0x2::object::id<0x79b199dfe6c20fec2367d2ece13e39243fa575c6882727e51b91c033c0a6b3fd::strategy::Strategies>(&arg2);
        0x2::transfer::public_share_object<0x79b199dfe6c20fec2367d2ece13e39243fa575c6882727e51b91c033c0a6b3fd::strategy::Strategies>(arg2);
        let v15 = VaultEvent{
            kind      : 5,
            user      : 0x2::tx_context::sender(arg11),
            amount    : arg0.vault_value,
            shares    : 0,
            extra     : 0,
            type_name : 0x1::type_name::with_defining_ids<0x2::sui::SUI>(),
            flag      : false,
        };
        0x2::event::emit<VaultEvent>(v15);
    }

    public entry fun borrow_from_vault<T0, T1>(arg0: &mut Vault, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.admin, 0);
        assert!(!arg0.paused, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x79b199dfe6c20fec2367d2ece13e39243fa575c6882727e51b91c033c0a6b3fd::suilend_adapter::borrow_from_suilend<T0, T1>(arg1, arg2, &borrow_reserve_slot_shared<T0>(arg0, arg2).obligation_cap, arg3, arg4, arg5), 0x2::tx_context::sender(arg5));
        let v0 = VaultEvent{
            kind      : 5,
            user      : 0x2::tx_context::sender(arg5),
            amount    : arg4,
            shares    : 0,
            extra     : 0x2::clock::timestamp_ms(arg3),
            type_name : 0x1::type_name::with_defining_ids<T1>(),
            flag      : false,
        };
        0x2::event::emit<VaultEvent>(v0);
    }

    fun borrow_reserve_slot<T0>(arg0: &Vault, arg1: u64) : &VaultReserveSlot<T0> {
        0x2::dynamic_field::borrow<ReserveKey, VaultReserveSlot<T0>>(&arg0.id, reserve_key(arg1))
    }

    fun borrow_reserve_slot_mut<T0>(arg0: &mut Vault, arg1: u64) : &mut VaultReserveSlot<T0> {
        0x2::dynamic_field::borrow_mut<ReserveKey, VaultReserveSlot<T0>>(&mut arg0.id, reserve_key(arg1))
    }

    fun borrow_reserve_slot_shared<T0>(arg0: &mut Vault, arg1: u64) : &VaultReserveSlot<T0> {
        0x2::dynamic_field::borrow<ReserveKey, VaultReserveSlot<T0>>(&arg0.id, reserve_key(arg1))
    }

    public fun calc_shares_for_deposit(arg0: &Vault, arg1: u64) : u64 {
        if (arg0.total_shares == 0 || arg0.vault_value == 0) {
            arg1
        } else {
            arg1 * arg0.total_shares / arg0.vault_value
        }
    }

    fun calculate_lst_current_value<T0, T1, T2, T3>(arg0: &Vault, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T1>, arg3: &0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T2>, arg4: &0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T3>, arg5: &vector<u64>) : u64 {
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserves<T0>(arg1);
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        let v4 = reserve_key(0);
        if (0x2::dynamic_field::exists_<ReserveKey>(&arg0.id, v4)) {
            v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::borrowed_amount<T0, 0x2::sui::SUI>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T0>(arg1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<T0>(&0x2::dynamic_field::borrow<ReserveKey, VaultReserveSlot<T0>>(&arg0.id, v4).obligation_cap))));
        };
        while (v3 < 0x1::vector::length<u64>(&arg0.active_reserves)) {
            let v5 = *0x1::vector::borrow<u64>(&arg0.active_reserves, v3);
            if (v5 == 0) {
                v3 = v3 + 1;
                continue
            };
            if (!0x2::dynamic_field::exists_<ReserveKey>(&arg0.id, reserve_key(v5)) || v5 >= 0x1::vector::length<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::Reserve<T0>>(v0)) {
                v3 = v3 + 1;
                continue
            };
            let v6 = find_lst_index(arg5, v5);
            if (v6 == 0) {
                let v7 = get_reserve_ctoken_balance<T0, T1>(arg0, arg1, v5);
                if (v7 > 0) {
                    let v8 = 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::total_lst_supply<T1>(arg2);
                    if (v8 > 0) {
                        v2 = v2 + (((0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(v7), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::ctoken_ratio<T0>(0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::Reserve<T0>>(v0, v5)))) as u128) * (0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::total_sui_supply<T1>(arg2) as u128) / (v8 as u128)) as u64);
                    };
                };
            } else if (v6 == 1) {
                let v9 = get_reserve_ctoken_balance<T0, T2>(arg0, arg1, v5);
                if (v9 > 0) {
                    let v10 = 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::total_lst_supply<T2>(arg3);
                    if (v10 > 0) {
                        v2 = v2 + (((0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(v9), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::ctoken_ratio<T0>(0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::Reserve<T0>>(v0, v5)))) as u128) * (0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::total_sui_supply<T2>(arg3) as u128) / (v10 as u128)) as u64);
                    };
                };
            } else if (v6 == 2) {
                let v11 = get_reserve_ctoken_balance<T0, T3>(arg0, arg1, v5);
                if (v11 > 0) {
                    let v12 = 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::total_lst_supply<T3>(arg4);
                    if (v12 > 0) {
                        v2 = v2 + (((0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(v11), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::ctoken_ratio<T0>(0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::Reserve<T0>>(v0, v5)))) as u128) * (0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::total_sui_supply<T3>(arg4) as u128) / (v12 as u128)) as u64);
                    };
                };
            };
            v3 = v3 + 1;
        };
        if (v2 > v1) {
            v2 - v1
        } else {
            0
        }
    }

    fun calculate_suilend_sui_value<T0>(arg0: &Vault, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>) : u64 {
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserves<T0>(arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg0.active_reserves)) {
            let v2 = *0x1::vector::borrow<u64>(&arg0.active_reserves, v1);
            if (v2 == 0) {
                let v3 = reserve_key(v2);
                if (0x2::dynamic_field::exists_<ReserveKey>(&arg0.id, v3) && v2 < 0x1::vector::length<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::Reserve<T0>>(v0)) {
                    let v4 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(get_reserve_ctoken_balance<T0, 0x2::sui::SUI>(arg0, arg1, v2)), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::ctoken_ratio<T0>(0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::Reserve<T0>>(v0, v2))));
                    let v5 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::borrowed_amount<T0, 0x2::sui::SUI>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T0>(arg1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<T0>(&0x2::dynamic_field::borrow<ReserveKey, VaultReserveSlot<T0>>(&arg0.id, v3).obligation_cap))));
                    return if (v4 > v5) {
                        v4 - v5
                    } else {
                        0
                    }
                };
            };
            v1 = v1 + 1;
        };
        0
    }

    public entry fun deposit<T0, T1: drop, T2: drop, T3: drop>(arg0: &mut Vault, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &0x2::clock::Clock, arg4: &0x79b199dfe6c20fec2367d2ece13e39243fa575c6882727e51b91c033c0a6b3fd::strategy::Strategies, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T1>, arg7: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T2>, arg8: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T3>, arg9: vector<u64>, arg10: &mut 0x3::sui_system::SuiSystemState, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 0);
        assert!(0x2::object::id<0x79b199dfe6c20fec2367d2ece13e39243fa575c6882727e51b91c033c0a6b3fd::strategy::Strategies>(arg4) == arg0.strategies_id, 9999);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 >= arg0.config.min_deposit, 1);
        accrue_protocol_yields<T0, T1, T2, T3>(arg0, arg2, arg6, arg7, arg8, &arg9);
        let v1 = calc_shares_for_deposit(arg0, v0);
        arg0.vault_value = arg0.vault_value + v0;
        arg0.total_shares = arg0.total_shares + v1;
        arg0.total_deposits = arg0.total_deposits + v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<VAULT>>(0x2::coin::mint<VAULT>(&mut arg0.share_treasury, v1, arg11), 0x2::tx_context::sender(arg11));
        let v2 = 0x79b199dfe6c20fec2367d2ece13e39243fa575c6882727e51b91c033c0a6b3fd::strategy::get_allocations(arg4);
        let v3 = 0x1::vector::length<0x79b199dfe6c20fec2367d2ece13e39243fa575c6882727e51b91c033c0a6b3fd::strategy::Allocation>(&v2);
        assert!(v3 > 0, 9998);
        let v4 = 0;
        while (v4 < v3 - 1) {
            let (v5, v6, v7, v8) = 0x79b199dfe6c20fec2367d2ece13e39243fa575c6882727e51b91c033c0a6b3fd::strategy::get_allocation_fields(0x1::vector::borrow<0x79b199dfe6c20fec2367d2ece13e39243fa575c6882727e51b91c033c0a6b3fd::strategy::Allocation>(&v2, v4));
            assert!(v5 == 0, 9997);
            ensure_reserve_slot<T0>(arg0, arg2, v6, arg11);
            let v9 = 0x2::coin::split<0x2::sui::SUI>(&mut arg1, v0 * v7 / 10000, arg11);
            deposit_to_reserve<T0, T1, T2, T3>(arg0, arg2, v6, arg3, v9, v8, arg5, arg6, arg7, arg8, &arg9, arg10, arg11);
            v4 = v4 + 1;
        };
        if (v3 > 0) {
            let (v10, v11, _, v13) = 0x79b199dfe6c20fec2367d2ece13e39243fa575c6882727e51b91c033c0a6b3fd::strategy::get_allocation_fields(0x1::vector::borrow<0x79b199dfe6c20fec2367d2ece13e39243fa575c6882727e51b91c033c0a6b3fd::strategy::Allocation>(&v2, v3 - 1));
            assert!(v10 == 0, 9997);
            ensure_reserve_slot<T0>(arg0, arg2, v11, arg11);
            deposit_to_reserve<T0, T1, T2, T3>(arg0, arg2, v11, arg3, arg1, v13, arg5, arg6, arg7, arg8, &arg9, arg10, arg11);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg1);
        };
        ensure_vault_invariants(arg0);
        let v14 = VaultEvent{
            kind      : 0,
            user      : 0x2::tx_context::sender(arg11),
            amount    : v0,
            shares    : v1,
            extra     : 0,
            type_name : 0x1::type_name::with_defining_ids<0x2::sui::SUI>(),
            flag      : false,
        };
        0x2::event::emit<VaultEvent>(v14);
    }

    fun deposit_to_reserve<T0, T1: drop, T2: drop, T3: drop>(arg0: &mut Vault, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: u64, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T1>, arg8: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T2>, arg9: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T3>, arg10: &vector<u64>, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = borrow_reserve_slot_shared<T0>(arg0, arg2);
        if (arg2 == 0) {
            0x79b199dfe6c20fec2367d2ece13e39243fa575c6882727e51b91c033c0a6b3fd::suilend_adapter::deposit_to_suilend<T0, 0x2::sui::SUI>(arg1, arg2, arg3, arg4, &v0.obligation_cap, arg12);
        } else {
            let v1 = find_lst_index(arg10, arg2);
            if (v1 == 0) {
                let v2 = 0x79b199dfe6c20fec2367d2ece13e39243fa575c6882727e51b91c033c0a6b3fd::suilend_adapter::deposit_with_looping<T0, T1>(arg1, 0, arg2, &v0.obligation_cap, arg3, arg4, arg5, arg7, arg11, arg6, arg12);
                assert!(0x2::coin::value<0x2::sui::SUI>(&v2) == 0, 9993);
                0x2::coin::destroy_zero<0x2::sui::SUI>(v2);
            } else if (v1 == 1) {
                let v3 = 0x79b199dfe6c20fec2367d2ece13e39243fa575c6882727e51b91c033c0a6b3fd::suilend_adapter::deposit_with_looping<T0, T2>(arg1, 0, arg2, &v0.obligation_cap, arg3, arg4, arg5, arg8, arg11, arg6, arg12);
                assert!(0x2::coin::value<0x2::sui::SUI>(&v3) == 0, 9993);
                0x2::coin::destroy_zero<0x2::sui::SUI>(v3);
            } else {
                assert!(v1 == 2, 9996);
                let v4 = 0x79b199dfe6c20fec2367d2ece13e39243fa575c6882727e51b91c033c0a6b3fd::suilend_adapter::deposit_with_looping<T0, T3>(arg1, 0, arg2, &v0.obligation_cap, arg3, arg4, arg5, arg9, arg11, arg6, arg12);
                assert!(0x2::coin::value<0x2::sui::SUI>(&v4) == 0, 9993);
                0x2::coin::destroy_zero<0x2::sui::SUI>(v4);
            };
        };
    }

    public entry fun emergency_liquidate<T0, T1, T2>(arg0: &mut Vault, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: 0x2::object::ID, arg3: &mut 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, _) = 0x79b199dfe6c20fec2367d2ece13e39243fa575c6882727e51b91c033c0a6b3fd::suilend_adapter::liquidate_obligation<T0, T1, T2>(arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T2>>>(v2, 0x2::tx_context::sender(arg7));
        let v3 = VaultEvent{
            kind      : 6,
            user      : 0x2::tx_context::sender(arg7),
            amount    : 0x2::coin::value<T1>(arg3),
            shares    : 0,
            extra     : 0x2::coin::value<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T2>>(&v2),
            type_name : 0x1::type_name::with_defining_ids<T1>(),
            flag      : false,
        };
        0x2::event::emit<VaultEvent>(v3);
    }

    fun ensure_reserve_slot<T0>(arg0: &mut Vault, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = reserve_key(arg2);
        if (!0x2::dynamic_field::exists_<ReserveKey>(&arg0.id, v0)) {
            let v1 = VaultReserveSlot<T0>{obligation_cap: 0x79b199dfe6c20fec2367d2ece13e39243fa575c6882727e51b91c033c0a6b3fd::suilend_adapter::create_obligation_cap<T0>(arg1, arg3)};
            0x2::dynamic_field::add<ReserveKey, VaultReserveSlot<T0>>(&mut arg0.id, v0, v1);
        };
    }

    fun ensure_vault_invariants(arg0: &mut Vault) {
        sync_hwm(arg0);
    }

    fun find_lst_index(arg0: &vector<u64>, arg1: u64) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(arg0)) {
            if (*0x1::vector::borrow<u64>(arg0, v0) == arg1) {
                return v0
            };
            v0 = v0 + 1;
        };
        abort 9995
    }

    public fun get_admin(arg0: &Vault) : address {
        arg0.admin
    }

    public fun get_fee_bps(arg0: &Vault) : u64 {
        arg0.config.fee_bps
    }

    public fun get_fee_recipient(arg0: &Vault) : address {
        arg0.config.fee_recipient
    }

    public fun get_hwm(arg0: &Vault) : u128 {
        if (arg0.hwm == 0) {
            get_pps(arg0)
        } else {
            (arg0.hwm as u128)
        }
    }

    public fun get_pps(arg0: &Vault) : u128 {
        if (arg0.total_shares == 0) {
            1000000000000
        } else {
            (arg0.vault_value as u128) * 1000000000000 / (arg0.total_shares as u128)
        }
    }

    public fun get_pps_with_lst(arg0: &Vault, arg1: u64) : u128 {
        if (arg0.total_shares == 0) {
            1000000000000
        } else {
            (get_total_assets(arg0, arg1) as u128) * 1000000000000 / (arg0.total_shares as u128)
        }
    }

    fun get_reserve_ctoken_balance<T0, T1>(arg0: &Vault, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: u64) : u64 {
        let v0 = reserve_key(arg2);
        if (!0x2::dynamic_field::exists_<ReserveKey>(&arg0.id, v0)) {
            return 0
        };
        0x79b199dfe6c20fec2367d2ece13e39243fa575c6882727e51b91c033c0a6b3fd::suilend_adapter::get_actual_ctoken_amount<T0, T1>(arg1, &0x2::dynamic_field::borrow<ReserveKey, VaultReserveSlot<T0>>(&arg0.id, v0).obligation_cap)
    }

    public fun get_sui_balance(arg0: &Vault) : u64 {
        arg0.vault_value
    }

    public fun get_total_assets(arg0: &Vault, arg1: u64) : u64 {
        arg0.vault_value + arg1
    }

    public fun get_total_shares(arg0: &Vault) : u64 {
        arg0.total_shares
    }

    public fun get_vault_id(arg0: &Vault) : address {
        0x2::object::id_address<Vault>(arg0)
    }

    public entry fun harvest_rewards<T0, T1>(arg0: &mut Vault, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x2::clock::Clock, arg3: u64, arg4: u64, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 0);
        assert!(0x2::tx_context::sender(arg6) == arg0.admin, 1001);
        let v0 = borrow_reserve_slot_shared<T0>(arg0, arg3);
        let v1 = 0x79b199dfe6c20fec2367d2ece13e39243fa575c6882727e51b91c033c0a6b3fd::suilend_adapter::claim_rewards_from_suilend<T0, T1>(arg1, &v0.obligation_cap, arg2, arg3, arg4, arg5, arg6);
        let v2 = 0x2::coin::value<T1>(&v1);
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, arg0.admin);
            let v3 = VaultEvent{
                kind      : 7,
                user      : arg0.admin,
                amount    : v2,
                shares    : 0,
                extra     : 0x2::clock::timestamp_ms(arg2),
                type_name : 0x1::type_name::with_defining_ids<T1>(),
                flag      : false,
            };
            0x2::event::emit<VaultEvent>(v3);
        } else {
            0x2::coin::destroy_zero<T1>(v1);
        };
    }

    fun init(arg0: VAULT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VAULT>(arg0, 9, b"VSHARE", b"Vault Share", b"Vault share token", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = VaultConfig{
            min_deposit    : 10,
            deposit_paused : false,
            fee_bps        : 1000,
            fee_recipient  : 0x2::tx_context::sender(arg1),
        };
        let v3 = Vault{
            id                : 0x2::object::new(arg1),
            coin              : 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::zero<0x2::sui::SUI>(), arg1),
            vault_value       : 0,
            total_shares      : 0,
            hwm               : 0,
            paused            : false,
            config            : v2,
            admin             : 0x2::tx_context::sender(arg1),
            strategies_id     : 0x2::object::id_from_address(@0x0),
            sui_index         : 0,
            usdc_index        : 1,
            share_treasury    : v0,
            total_deposits    : 0,
            total_withdrawals : 0,
            active_reserves   : 0x1::vector::empty<u64>(),
        };
        0x2::transfer::public_share_object<Vault>(v3);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<VAULT>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun initialize_reserves(arg0: &mut Vault, arg1: vector<u64>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        assert!(0x1::vector::is_empty<u64>(&arg0.active_reserves), 1);
        arg0.active_reserves = arg1;
    }

    public fun is_paused(arg0: &Vault) : bool {
        arg0.paused
    }

    public entry fun remove_active_reserve(arg0: &mut Vault, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        let v0 = 0;
        let v1 = false;
        while (v0 < 0x1::vector::length<u64>(&arg0.active_reserves)) {
            if (*0x1::vector::borrow<u64>(&arg0.active_reserves, v0) == arg1) {
                0x1::vector::remove<u64>(&mut arg0.active_reserves, v0);
                v1 = true;
                break
            };
            v0 = v0 + 1;
        };
        assert!(v1, 3);
    }

    fun reserve_key(arg0: u64) : ReserveKey {
        ReserveKey{reserve_index: arg0}
    }

    public fun set_hwm(arg0: &mut Vault, arg1: u64) {
        arg0.hwm = arg1;
    }

    public entry fun set_strategies(arg0: &mut Vault, arg1: &0x79b199dfe6c20fec2367d2ece13e39243fa575c6882727e51b91c033c0a6b3fd::strategy::Strategies, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        arg0.strategies_id = 0x2::object::id<0x79b199dfe6c20fec2367d2ece13e39243fa575c6882727e51b91c033c0a6b3fd::strategy::Strategies>(arg1);
        let v0 = VaultEvent{
            kind      : 2,
            user      : 0x2::tx_context::sender(arg2),
            amount    : 0,
            shares    : 0,
            extra     : 0,
            type_name : 0x1::type_name::with_defining_ids<0x2::sui::SUI>(),
            flag      : false,
        };
        0x2::event::emit<VaultEvent>(v0);
    }

    public fun sync_hwm(arg0: &mut Vault) {
        let v0 = get_pps(arg0);
        if (v0 > get_hwm(arg0)) {
            arg0.hwm = (v0 as u64);
        };
    }

    public entry fun toggle_pause(arg0: &mut Vault, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 0);
        arg0.paused = !arg0.paused;
        let v0 = VaultEvent{
            kind      : 3,
            user      : 0x2::tx_context::sender(arg1),
            amount    : 0,
            shares    : 0,
            extra     : 0,
            type_name : 0x1::type_name::with_defining_ids<0x2::sui::SUI>(),
            flag      : arg0.paused,
        };
        0x2::event::emit<VaultEvent>(v0);
    }

    public entry fun withdraw<T0, T1: drop, T2: drop, T3: drop>(arg0: &mut Vault, arg1: 0x2::coin::Coin<VAULT>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &0x2::clock::Clock, arg4: &0x79b199dfe6c20fec2367d2ece13e39243fa575c6882727e51b91c033c0a6b3fd::strategy::Strategies, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T1>, arg7: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T2>, arg8: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T3>, arg9: vector<u64>, arg10: &mut 0x3::sui_system::SuiSystemState, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 0);
        assert!(0x2::object::id<0x79b199dfe6c20fec2367d2ece13e39243fa575c6882727e51b91c033c0a6b3fd::strategy::Strategies>(arg4) == arg0.strategies_id, 9999);
        accrue_protocol_yields<T0, T1, T2, T3>(arg0, arg2, arg6, arg7, arg8, &arg9);
        let v0 = 0x2::coin::value<VAULT>(&arg1);
        assert!(v0 > 0 && v0 <= arg0.total_shares, 1);
        let v1 = (((v0 as u128) * get_pps(arg0) / 1000000000000) as u64);
        assert!(v1 <= arg0.vault_value, 2);
        arg0.vault_value = arg0.vault_value - v1;
        arg0.total_shares = arg0.total_shares - v0;
        arg0.total_withdrawals = arg0.total_withdrawals + v1;
        0x2::coin::burn<VAULT>(&mut arg0.share_treasury, arg1);
        let v2 = 0x79b199dfe6c20fec2367d2ece13e39243fa575c6882727e51b91c033c0a6b3fd::strategy::get_allocations(arg4);
        let v3 = 0x1::vector::length<0x79b199dfe6c20fec2367d2ece13e39243fa575c6882727e51b91c033c0a6b3fd::strategy::Allocation>(&v2);
        assert!(v3 > 0, 9998);
        let v4 = 0x2::coin::zero<0x2::sui::SUI>(arg11);
        let v5 = 0;
        while (v5 < v3) {
            let (v6, v7, v8, v9) = 0x79b199dfe6c20fec2367d2ece13e39243fa575c6882727e51b91c033c0a6b3fd::strategy::get_allocation_fields(0x1::vector::borrow<0x79b199dfe6c20fec2367d2ece13e39243fa575c6882727e51b91c033c0a6b3fd::strategy::Allocation>(&v2, v5));
            assert!(v6 == 0, 9997);
            let v10 = withdraw_from_reserve<T0, T1, T2, T3>(arg0, arg2, v7, arg3, arg5, v1 * v8 / 10000, v9, arg6, arg7, arg8, &arg9, arg10, arg11);
            0x2::coin::join<0x2::sui::SUI>(&mut v4, v10);
            v5 = v5 + 1;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v4, 0x2::tx_context::sender(arg11));
        ensure_vault_invariants(arg0);
        let v11 = VaultEvent{
            kind      : 1,
            user      : 0x2::tx_context::sender(arg11),
            amount    : v1,
            shares    : v0,
            extra     : 0,
            type_name : 0x1::type_name::with_defining_ids<0x2::sui::SUI>(),
            flag      : false,
        };
        0x2::event::emit<VaultEvent>(v11);
    }

    fun withdraw_from_reserve<T0, T1: drop, T2: drop, T3: drop>(arg0: &mut Vault, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: u64, arg6: u64, arg7: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T1>, arg8: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T2>, arg9: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T3>, arg10: &vector<u64>, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        if (arg5 == 0) {
            return 0x2::coin::zero<0x2::sui::SUI>(arg12)
        };
        let v0 = borrow_reserve_slot_shared<T0>(arg0, arg2);
        if (arg2 == 0) {
            0x79b199dfe6c20fec2367d2ece13e39243fa575c6882727e51b91c033c0a6b3fd::suilend_adapter::withdraw_sui_with_staker<T0>(arg1, arg2, arg3, &v0.obligation_cap, arg5, arg11, arg12)
        } else {
            let v2 = find_lst_index(arg10, arg2);
            let v3 = 0;
            let v4 = if (v2 == 0) {
                0x79b199dfe6c20fec2367d2ece13e39243fa575c6882727e51b91c033c0a6b3fd::suilend_adapter::withdraw_with_delevering<T0, T1>(arg1, v3, arg2, &v0.obligation_cap, arg3, arg5, arg7, arg11, arg4, arg12)
            } else if (v2 == 1) {
                0x79b199dfe6c20fec2367d2ece13e39243fa575c6882727e51b91c033c0a6b3fd::suilend_adapter::withdraw_with_delevering<T0, T2>(arg1, v3, arg2, &v0.obligation_cap, arg3, arg5, arg8, arg11, arg4, arg12)
            } else {
                assert!(v2 == 2, 9996);
                0x79b199dfe6c20fec2367d2ece13e39243fa575c6882727e51b91c033c0a6b3fd::suilend_adapter::withdraw_with_delevering<T0, T3>(arg1, v3, arg2, &v0.obligation_cap, arg3, arg5, arg9, arg11, arg4, arg12)
            };
            if (arg6 > 10000) {
                if (v2 == 0) {
                    0x79b199dfe6c20fec2367d2ece13e39243fa575c6882727e51b91c033c0a6b3fd::suilend_adapter::restore_leverage<T0, T1>(arg1, v3, arg2, &v0.obligation_cap, arg3, arg6, arg7, arg11, arg4, arg12);
                } else if (v2 == 1) {
                    0x79b199dfe6c20fec2367d2ece13e39243fa575c6882727e51b91c033c0a6b3fd::suilend_adapter::restore_leverage<T0, T2>(arg1, v3, arg2, &v0.obligation_cap, arg3, arg6, arg8, arg11, arg4, arg12);
                } else {
                    0x79b199dfe6c20fec2367d2ece13e39243fa575c6882727e51b91c033c0a6b3fd::suilend_adapter::restore_leverage<T0, T3>(arg1, v3, arg2, &v0.obligation_cap, arg3, arg6, arg9, arg11, arg4, arg12);
                };
            };
            v4
        }
    }

    // decompiled from Move bytecode v6
}

