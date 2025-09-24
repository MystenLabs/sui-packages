module 0xc7a2bac3546ebcded80f178ffc9198e8ef0745a597b57950d4f76962b888badd::vault {
    struct UserPoolKey has copy, drop, store {
        user: address,
        pool_index: u64,
    }

    struct VAULT has drop {
        dummy_field: bool,
    }

    struct LoopConfig has copy, drop, store {
        enabled: bool,
        target_leverage_bps: u64,
        warn_hf_bps: u64,
        stop_hf_bps: u64,
        max_iterations: u64,
    }

    struct Vault has store, key {
        id: 0x2::object::UID,
        coin: 0x2::coin::Coin<0x2::sui::SUI>,
        sui_balance: u64,
        total_shares: u64,
        hwm: u64,
        paused: bool,
        config: VaultConfig,
        admin: address,
        strategy_ids: vector<address>,
        sui_index: u8,
        usdc_index: u8,
        share_treasury: 0x2::coin::TreasuryCap<VAULT>,
        loop_config: LoopConfig,
    }

    struct ReserveKey has copy, drop, store {
        reserve_index: u64,
    }

    struct VaultReserveSlot<phantom T0> has store {
        obligation_cap: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>,
        total_borrowed: u64,
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
        let v0 = get_pps(arg0);
        let v1 = arg0.config.fee_recipient;
        if (v0 <= (arg0.hwm as u128)) {
            arg0.hwm = (v0 as u64);
            return
        };
        let v2 = arg1 * arg0.config.fee_bps / 10000;
        if (v2 == 0) {
            arg0.hwm = (v0 as u64);
            return
        };
        let v3 = (((v2 as u128) * (arg0.total_shares as u128) / (arg0.sui_balance as u128)) as u64);
        if (v3 > 0) {
            arg0.total_shares = arg0.total_shares + v3;
            0x2::transfer::public_transfer<0x2::coin::Coin<VAULT>>(0x2::coin::mint<VAULT>(&mut arg0.share_treasury, v3, arg2), v1);
            let v4 = VaultEvent{
                kind      : 4,
                user      : v1,
                amount    : v2,
                shares    : v3,
                extra     : 0,
                type_name : 0x1::type_name::get<0x2::sui::SUI>(),
                flag      : false,
            };
            0x2::event::emit<VaultEvent>(v4);
        };
        arg0.hwm = (v0 as u64);
    }

    public fun accrue_performance_fee_with_adapter<T0>(arg0: &mut Vault, arg1: u64, arg2: u64, arg3: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0xc7a2bac3546ebcded80f178ffc9198e8ef0745a597b57950d4f76962b888badd::suilend_adapter::get_suilend_reserve<T0, 0x2::sui::SUI>(arg3);
        let v0 = 0xc7a2bac3546ebcded80f178ffc9198e8ef0745a597b57950d4f76962b888badd::suilend_adapter::get_suilend_fee_receiver<T0>(arg3);
        let v1 = get_pps_with_lst(arg0, arg2);
        if (v1 <= (arg0.hwm as u128)) {
            arg0.hwm = (v1 as u64);
            return
        };
        let v2 = arg1 * arg0.config.fee_bps / 10000;
        if (v2 == 0) {
            arg0.hwm = (v1 as u64);
            return
        };
        let v3 = (((v2 as u128) * (arg0.total_shares as u128) / (get_total_assets(arg0, arg2) as u128)) as u64);
        if (v3 > 0) {
            arg0.total_shares = arg0.total_shares + v3;
            0x2::transfer::public_transfer<0x2::coin::Coin<VAULT>>(0x2::coin::mint<VAULT>(&mut arg0.share_treasury, v3, arg4), v0);
        };
        arg0.hwm = (v1 as u64);
        let v4 = VaultEvent{
            kind      : 4,
            user      : v0,
            amount    : v2,
            shares    : v3,
            extra     : 0,
            type_name : 0x1::type_name::get<0x2::sui::SUI>(),
            flag      : false,
        };
        0x2::event::emit<VaultEvent>(v4);
    }

    public fun accrue_performance_fee_with_lst(arg0: &mut Vault, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = get_pps_with_lst(arg0, arg2);
        let v1 = arg0.config.fee_recipient;
        if (v0 <= (arg0.hwm as u128)) {
            arg0.hwm = (v0 as u64);
            return
        };
        let v2 = arg1 * arg0.config.fee_bps / 10000;
        if (v2 == 0) {
            arg0.hwm = (v0 as u64);
            return
        };
        let v3 = (((v2 as u128) * (arg0.total_shares as u128) / (get_total_assets(arg0, arg2) as u128)) as u64);
        if (v3 > 0) {
            arg0.total_shares = arg0.total_shares + v3;
            0x2::transfer::public_transfer<0x2::coin::Coin<VAULT>>(0x2::coin::mint<VAULT>(&mut arg0.share_treasury, v3, arg3), v1);
            let v4 = VaultEvent{
                kind      : 4,
                user      : v1,
                amount    : v2,
                shares    : v3,
                extra     : 0,
                type_name : 0x1::type_name::get<0x2::sui::SUI>(),
                flag      : false,
            };
            0x2::event::emit<VaultEvent>(v4);
        };
        arg0.hwm = (v0 as u64);
    }

    public entry fun add_strategy_id(arg0: &mut Vault, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1001);
        0x1::vector::push_back<address>(&mut arg0.strategy_ids, arg1);
    }

    public fun add_total_shares(arg0: &mut Vault, arg1: u64) {
        arg0.total_shares = arg0.total_shares + arg1;
    }

    public entry fun admin_claim_and_compound_reward<T0>(arg0: &mut Vault, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x2::clock::Clock, arg3: u64, arg4: u64, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg6) == arg0.admin, 1001);
        0xc7a2bac3546ebcded80f178ffc9198e8ef0745a597b57950d4f76962b888badd::suilend_adapter::get_suilend_fee_receiver<T0>(arg1);
        let v0 = borrow_reserve_slot_shared<T0>(arg0, arg3);
        let v1 = 0xc7a2bac3546ebcded80f178ffc9198e8ef0745a597b57950d4f76962b888badd::suilend_adapter::claim_rewards_from_suilend<T0, 0x2::sui::SUI>(arg1, &v0.obligation_cap, arg2, arg3, arg4, arg5, arg6);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&v1);
        if (v2 > 0) {
            0x2::balance::join<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(&mut arg0.coin), 0x2::coin::into_balance<0x2::sui::SUI>(v1));
            arg0.sui_balance = arg0.sui_balance + v2;
            let v3 = get_pps(arg0);
            if (v3 > (arg0.hwm as u128)) {
                let v4 = arg0.sui_balance - arg0.hwm;
                accrue_performance_fee(arg0, v4, arg6);
            } else {
                arg0.hwm = (v3 as u64);
            };
            let v5 = VaultEvent{
                kind      : 7,
                user      : arg0.admin,
                amount    : v2,
                shares    : 0,
                extra     : 0x2::clock::timestamp_ms(arg2),
                type_name : 0x1::type_name::get<0x2::sui::SUI>(),
                flag      : true,
            };
            0x2::event::emit<VaultEvent>(v5);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v1);
        };
    }

    public entry fun admin_claim_reward<T0, T1>(arg0: &mut Vault, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x2::clock::Clock, arg3: u64, arg4: u64, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg6) == arg0.admin, 1001);
        let v0 = 0xc7a2bac3546ebcded80f178ffc9198e8ef0745a597b57950d4f76962b888badd::suilend_adapter::get_suilend_fee_receiver<T0>(arg1);
        let v1 = 0xc7a2bac3546ebcded80f178ffc9198e8ef0745a597b57950d4f76962b888badd::suilend_adapter::claim_rewards_from_suilend<T0, T1>(arg1, &borrow_reserve_slot_shared<T0>(arg0, arg3).obligation_cap, arg2, arg3, arg4, arg5, arg6);
        let v2 = 0x2::coin::value<T1>(&v1);
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, v0);
            let v3 = VaultEvent{
                kind      : 7,
                user      : v0,
                amount    : v2,
                shares    : 0,
                extra     : 0x2::clock::timestamp_ms(arg2),
                type_name : 0x1::type_name::get<T1>(),
                flag      : false,
            };
            0x2::event::emit<VaultEvent>(v3);
        } else {
            0x2::coin::destroy_zero<T1>(v1);
        };
    }

    public entry fun borrow_from_vault<T0, T1>(arg0: &mut Vault, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.admin, 0);
        assert!(!arg0.paused, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0xc7a2bac3546ebcded80f178ffc9198e8ef0745a597b57950d4f76962b888badd::suilend_adapter::borrow_from_suilend<T0, T1>(arg1, arg2, &borrow_reserve_slot_shared<T0>(arg0, arg2).obligation_cap, arg3, arg4, arg5), 0x2::tx_context::sender(arg5));
        let v0 = VaultEvent{
            kind      : 5,
            user      : 0x2::tx_context::sender(arg5),
            amount    : arg4,
            shares    : 0,
            extra     : 0x2::clock::timestamp_ms(arg3),
            type_name : 0x1::type_name::get<T1>(),
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

    public entry fun borrow_test<T0: drop>(arg0: &mut Vault, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T0>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: u64, arg5: &0x2::clock::Clock, arg6: u64, arg7: &mut 0x3::sui_system::SuiSystemState, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::create_obligation<T0>(arg3, arg8);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_ctokens_into_obligation<T0, T0>(arg3, arg4, &v0, arg5, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<T0, T0>(arg3, arg4, arg5, 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::mint<T0>(arg2, arg7, arg1, arg8), arg8), arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xc7a2bac3546ebcded80f178ffc9198e8ef0745a597b57950d4f76962b888badd::suilend_adapter::borrow_from_suilend<T0, 0x2::sui::SUI>(arg3, arg4, &v0, arg5, arg6, arg8), 0x2::tx_context::sender(arg8));
        0x2::transfer::public_transfer<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>>(v0, 0x2::tx_context::sender(arg8));
        let v1 = VaultEvent{
            kind      : 5,
            user      : 0x2::tx_context::sender(arg8),
            amount    : arg6,
            shares    : 0,
            extra     : 0x2::clock::timestamp_ms(arg5),
            type_name : 0x1::type_name::get<0x2::sui::SUI>(),
            flag      : false,
        };
        0x2::event::emit<VaultEvent>(v1);
    }

    public fun calc_shares_for_deposit(arg0: &Vault, arg1: u64) : u64 {
        if (arg0.total_shares == 0 || arg0.sui_balance == 0) {
            arg1
        } else {
            arg1 * arg0.total_shares / arg0.sui_balance
        }
    }

    fun calculate_target_borrow(arg0: u64, arg1: u64) : u64 {
        if (arg1 <= 10000) {
            0
        } else {
            (((arg0 as u128) * ((arg1 - 10000) as u128) / (10000 as u128)) as u64)
        }
    }

    public entry fun deposit<T0>(arg0: &mut Vault, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0xc7a2bac3546ebcded80f178ffc9198e8ef0745a597b57950d4f76962b888badd::strategy::Strategies, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &mut 0x2::tx_context::TxContext) {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<T0>(arg2, arg3, arg4, arg6);
        assert!(!arg0.paused, 0);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 >= arg0.config.min_deposit, 1);
        let v1 = calc_shares_for_deposit(arg0, v0);
        arg0.sui_balance = arg0.sui_balance + v0;
        arg0.total_shares = arg0.total_shares + v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<VAULT>>(0x2::coin::mint<VAULT>(&mut arg0.share_treasury, v1, arg7), 0x2::tx_context::sender(arg7));
        0xc7a2bac3546ebcded80f178ffc9198e8ef0745a597b57950d4f76962b888badd::strategy::allocate_and_execute(arg5, v0, arg7);
        ensure_reserve_slot<T0>(arg0, arg2, arg3, arg7);
        let v2 = borrow_reserve_slot_shared<T0>(arg0, arg3);
        0xc7a2bac3546ebcded80f178ffc9198e8ef0745a597b57950d4f76962b888badd::suilend_adapter::deposit_to_suilend<T0>(arg2, arg3, arg4, arg1, &v2.obligation_cap, arg7);
        execute_leverage_loop<T0>(arg0, arg2, arg3, v0, arg4, arg7);
        let v3 = VaultEvent{
            kind      : 0,
            user      : 0x2::tx_context::sender(arg7),
            amount    : v0,
            shares    : v1,
            extra     : 0,
            type_name : 0x1::type_name::get<0x2::sui::SUI>(),
            flag      : false,
        };
        0x2::event::emit<VaultEvent>(v3);
    }

    public entry fun emergency_liquidate<T0, T1, T2>(arg0: &mut Vault, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: 0x2::object::ID, arg3: &mut 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, _) = 0xc7a2bac3546ebcded80f178ffc9198e8ef0745a597b57950d4f76962b888badd::suilend_adapter::liquidate_obligation<T0, T1, T2>(arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T2>>>(v2, 0x2::tx_context::sender(arg7));
        let v3 = VaultEvent{
            kind      : 6,
            user      : 0x2::tx_context::sender(arg7),
            amount    : 0x2::coin::value<T1>(arg3),
            shares    : 0,
            extra     : 0x2::coin::value<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T2>>(&v2),
            type_name : 0x1::type_name::get<T1>(),
            flag      : false,
        };
        0x2::event::emit<VaultEvent>(v3);
    }

    fun ensure_reserve_slot<T0>(arg0: &mut Vault, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = reserve_key(arg2);
        if (!0x2::dynamic_field::exists_<ReserveKey>(&arg0.id, v0)) {
            let v1 = VaultReserveSlot<T0>{
                obligation_cap : 0xc7a2bac3546ebcded80f178ffc9198e8ef0745a597b57950d4f76962b888badd::suilend_adapter::create_obligation_cap<T0>(arg1, arg3),
                total_borrowed : 0,
            };
            0x2::dynamic_field::add<ReserveKey, VaultReserveSlot<T0>>(&mut arg0.id, v0, v1);
        };
    }

    fun execute_leverage_loop<T0>(arg0: &mut Vault, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = loop_config(arg0);
        let v1 = v0.max_iterations;
        if (!v0.enabled || arg3 == 0) {
            return
        };
        let v2 = calculate_target_borrow(arg3, v0.target_leverage_bps);
        if (v2 == 0) {
            return
        };
        let v3 = borrow_reserve_slot_mut<T0>(arg0, arg2);
        let v4 = 0;
        while (v2 > 0 && v4 < v1) {
            let v5 = v2 / (v1 - v4);
            let v6 = v5;
            if (v5 == 0) {
                v6 = v2;
            };
            v3.total_borrowed = v3.total_borrowed + v6;
            0xc7a2bac3546ebcded80f178ffc9198e8ef0745a597b57950d4f76962b888badd::suilend_adapter::deposit_to_suilend<T0>(arg1, arg2, arg4, 0xc7a2bac3546ebcded80f178ffc9198e8ef0745a597b57950d4f76962b888badd::suilend_adapter::borrow_from_suilend<T0, 0x2::sui::SUI>(arg1, arg2, &v3.obligation_cap, arg4, v6, arg5), &v3.obligation_cap, arg5);
            v2 = v2 - v6;
            v4 = v4 + 1;
        };
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

    public fun get_hwm(arg0: &Vault) : u64 {
        arg0.hwm
    }

    public fun get_pps(arg0: &Vault) : u128 {
        if (arg0.total_shares == 0) {
            1000000000000
        } else {
            (arg0.sui_balance as u128) * 1000000000000 / (arg0.total_shares as u128)
        }
    }

    public fun get_pps_with_lst(arg0: &Vault, arg1: u64) : u128 {
        if (arg0.total_shares == 0) {
            1000000000000
        } else {
            (get_total_assets(arg0, arg1) as u128) * 1000000000000 / (arg0.total_shares as u128)
        }
    }

    public fun get_sui_balance(arg0: &Vault) : u64 {
        arg0.sui_balance
    }

    public fun get_total_assets(arg0: &Vault, arg1: u64) : u64 {
        arg0.sui_balance + arg1
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
        let v1 = 0xc7a2bac3546ebcded80f178ffc9198e8ef0745a597b57950d4f76962b888badd::suilend_adapter::claim_rewards_from_suilend<T0, T1>(arg1, &v0.obligation_cap, arg2, arg3, arg4, arg5, arg6);
        let v2 = 0x2::coin::value<T1>(&v1);
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, arg0.admin);
            let v3 = VaultEvent{
                kind      : 7,
                user      : arg0.admin,
                amount    : v2,
                shares    : 0,
                extra     : 0x2::clock::timestamp_ms(arg2),
                type_name : 0x1::type_name::get<T1>(),
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
        let v3 = LoopConfig{
            enabled             : false,
            target_leverage_bps : 10000,
            warn_hf_bps         : 13500,
            stop_hf_bps         : 13000,
            max_iterations      : 5,
        };
        let v4 = Vault{
            id             : 0x2::object::new(arg1),
            coin           : 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::zero<0x2::sui::SUI>(), arg1),
            sui_balance    : 0,
            total_shares   : 0,
            hwm            : 0,
            paused         : false,
            config         : v2,
            admin          : 0x2::tx_context::sender(arg1),
            strategy_ids   : 0x1::vector::empty<address>(),
            sui_index      : 0,
            usdc_index     : 1,
            share_treasury : v0,
            loop_config    : v3,
        };
        0x2::transfer::public_share_object<Vault>(v4);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<VAULT>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun is_paused(arg0: &Vault) : bool {
        arg0.paused
    }

    fun loop_config(arg0: &Vault) : &LoopConfig {
        &arg0.loop_config
    }

    fun loop_config_mut(arg0: &mut Vault) : &mut LoopConfig {
        &mut arg0.loop_config
    }

    fun proportion(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg2 == 0) {
            0
        } else {
            (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
        }
    }

    fun repay_borrow_share<T0>(arg0: &mut Vault, arg1: u64, arg2: u64, arg3: u64) : u64 {
        if (arg2 == 0 || arg3 == 0) {
            return 0
        };
        let v0 = borrow_reserve_slot_mut<T0>(arg0, arg1);
        if (v0.total_borrowed == 0) {
            return 0
        };
        let v1 = proportion(v0.total_borrowed, arg3, arg2);
        if (v1 == 0) {
            return 0
        };
        v0.total_borrowed = v0.total_borrowed - v1;
        v1
    }

    fun reserve_key(arg0: u64) : ReserveKey {
        ReserveKey{reserve_index: arg0}
    }

    public fun set_hwm(arg0: &mut Vault, arg1: u64) {
        arg0.hwm = arg1;
    }

    public entry fun set_loop_config(arg0: &mut Vault, arg1: bool, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg6) == arg0.admin, 1002);
        assert!(arg2 >= 10000, 2001);
        assert!(arg3 >= arg4, 2002);
        assert!(arg4 > 0, 2003);
        assert!(arg5 > 0 && arg5 <= 20, 2004);
        let v0 = loop_config_mut(arg0);
        v0.enabled = arg1;
        v0.target_leverage_bps = arg2;
        v0.warn_hf_bps = arg3;
        v0.stop_hf_bps = arg4;
        v0.max_iterations = arg5;
    }

    public entry fun set_strategy(arg0: &mut Vault, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        let v0 = VaultEvent{
            kind      : 2,
            user      : 0x2::tx_context::sender(arg2),
            amount    : 0,
            shares    : 0,
            extra     : 0,
            type_name : 0x1::type_name::get<0x2::sui::SUI>(),
            flag      : false,
        };
        0x2::event::emit<VaultEvent>(v0);
    }

    public entry fun suilend_loop_step<T0: drop>(arg0: &mut Vault, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T0>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x3::sui_system::SuiSystemState, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg8) == arg0.admin, 0);
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<T0, T0>(arg3, arg4, arg6, 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::mint<T0>(arg2, arg7, arg1, arg8), arg8);
        ensure_reserve_slot<T0>(arg0, arg3, arg4, arg8);
        let v1 = borrow_reserve_slot_mut<T0>(arg0, arg4);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_ctokens_into_obligation<T0, T0>(arg3, arg4, &v1.obligation_cap, arg6, v0, arg8);
        v1.total_borrowed = v1.total_borrowed + arg5;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xc7a2bac3546ebcded80f178ffc9198e8ef0745a597b57950d4f76962b888badd::suilend_adapter::borrow_from_suilend<T0, 0x2::sui::SUI>(arg3, arg4, &v1.obligation_cap, arg6, arg5, arg8), arg0.admin);
        let v2 = VaultEvent{
            kind      : 5,
            user      : arg0.admin,
            amount    : arg5,
            shares    : 0,
            extra     : 0x2::clock::timestamp_ms(arg6),
            type_name : 0x1::type_name::get<0x2::sui::SUI>(),
            flag      : false,
        };
        0x2::event::emit<VaultEvent>(v2);
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
            type_name : 0x1::type_name::get<0x2::sui::SUI>(),
            flag      : arg0.paused,
        };
        0x2::event::emit<VaultEvent>(v0);
    }

    public entry fun withdraw<T0>(arg0: &mut Vault, arg1: &mut 0x2::coin::Coin<VAULT>, arg2: u64, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 0);
        assert!(arg2 > 0 && arg2 <= arg0.total_shares, 1);
        let v0 = (((arg2 as u128) * get_pps(arg0) / 1000000000000) as u64);
        assert!(v0 <= arg0.sui_balance, 2);
        let v1 = arg0.total_shares;
        let v2 = repay_borrow_share<T0>(arg0, arg4, v1, arg2);
        arg0.sui_balance = arg0.sui_balance - v0;
        arg0.total_shares = arg0.total_shares - arg2;
        0x2::coin::burn<VAULT>(&mut arg0.share_treasury, 0x2::coin::split<VAULT>(arg1, arg2, arg6));
        let v3 = borrow_reserve_slot_mut<T0>(arg0, arg4);
        let v4 = 0xc7a2bac3546ebcded80f178ffc9198e8ef0745a597b57950d4f76962b888badd::suilend_adapter::withdraw_liquidity_from_suilend<T0>(arg3, arg4, arg5, &v3.obligation_cap, v0 + v2, arg6);
        if (v2 > 0) {
            let v5 = 0x2::coin::split<0x2::sui::SUI>(&mut v4, v2, arg6);
            0xc7a2bac3546ebcded80f178ffc9198e8ef0745a597b57950d4f76962b888badd::suilend_adapter::repay_borrow<T0, 0x2::sui::SUI>(arg3, arg4, &v3.obligation_cap, arg5, &mut v5, arg6);
            0x2::coin::destroy_zero<0x2::sui::SUI>(v5);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v4, 0x2::tx_context::sender(arg6));
        let v6 = VaultEvent{
            kind      : 1,
            user      : 0x2::tx_context::sender(arg6),
            amount    : v0,
            shares    : arg2,
            extra     : 0,
            type_name : 0x1::type_name::get<0x2::sui::SUI>(),
            flag      : false,
        };
        0x2::event::emit<VaultEvent>(v6);
    }

    // decompiled from Move bytecode v6
}

