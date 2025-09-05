module 0xf71f6742194126fc5b822810baa61c0f780ed1d43ff16136e519b8239fb87c20::vault {
    struct VAULT has drop {
        dummy_field: bool,
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
        ctoken: 0x1::option::Option<0x2::object::ID>,
        obligation_cap: 0x1::option::Option<0x2::object::ID>,
    }

    struct VaultConfig has store {
        min_deposit: u64,
        deposit_paused: bool,
        fee_bps: u64,
        fee_recipient: address,
    }

    struct DepositEvent has copy, drop, store {
        user: address,
        amount: u64,
        shares: u64,
    }

    struct WithdrawEvent has copy, drop, store {
        user: address,
        amount: u64,
        shares: u64,
    }

    struct StrategyUpdatedEvent has copy, drop, store {
        by: address,
        new_strategy: address,
    }

    struct EmergencyToggledEvent has copy, drop, store {
        by: address,
        paused: bool,
    }

    struct PerformanceFeeAccruedEvent has copy, drop, store {
        fee_shares: u64,
        treasury: address,
    }

    struct BorrowEvent has copy, drop, store {
        vault_id: address,
        borrowed_amount: u64,
        borrow_type: 0x1::type_name::TypeName,
        timestamp: u64,
    }

    struct LiquidationEvent has copy, drop, store {
        vault_id: address,
        liquidated_amount: u64,
        seized_collateral: u64,
        liquidator: address,
        timestamp: u64,
    }

    struct RewardsClaimedEvent has copy, drop, store {
        vault_id: address,
        reward_type: 0x1::type_name::TypeName,
        amount: u64,
        compounded: bool,
        timestamp: u64,
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
        };
        arg0.hwm = (v0 as u64);
        let v4 = PerformanceFeeAccruedEvent{
            fee_shares : v3,
            treasury   : v1,
        };
        0x2::event::emit<PerformanceFeeAccruedEvent>(v4);
    }

    public entry fun add_strategy_id(arg0: &mut Vault, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1001);
        0x1::vector::push_back<address>(&mut arg0.strategy_ids, arg1);
    }

    public fun add_total_shares(arg0: &mut Vault, arg1: u64) {
        arg0.total_shares = arg0.total_shares + arg1;
    }

    public entry fun admin_claim_and_compound_reward<T0>(arg0: &mut Vault, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>, arg3: &0x2::clock::Clock, arg4: u64, arg5: u64, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg7) == arg0.admin, 1001);
        let v0 = 0xf71f6742194126fc5b822810baa61c0f780ed1d43ff16136e519b8239fb87c20::suilend_adapter::claim_rewards_from_suilend<T0, 0x2::sui::SUI>(arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&v0);
        if (v1 > 0) {
            0x2::balance::join<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(&mut arg0.coin), 0x2::coin::into_balance<0x2::sui::SUI>(v0));
            arg0.sui_balance = arg0.sui_balance + v1;
            let v2 = get_pps(arg0);
            if (v2 > (arg0.hwm as u128)) {
                let v3 = arg0.sui_balance - arg0.hwm;
                accrue_performance_fee(arg0, v3, arg7);
            } else {
                arg0.hwm = (v2 as u64);
            };
            let v4 = RewardsClaimedEvent{
                vault_id    : 0x2::object::id_address<Vault>(arg0),
                reward_type : 0x1::type_name::get<0x2::sui::SUI>(),
                amount      : v1,
                compounded  : true,
                timestamp   : 0x2::clock::timestamp_ms(arg3),
            };
            0x2::event::emit<RewardsClaimedEvent>(v4);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v0);
        };
    }

    public entry fun admin_claim_reward<T0, T1>(arg0: &mut Vault, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>, arg3: &0x2::clock::Clock, arg4: u64, arg5: u64, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg7) == arg0.admin, 1001);
        let v0 = 0xf71f6742194126fc5b822810baa61c0f780ed1d43ff16136e519b8239fb87c20::suilend_adapter::claim_rewards_from_suilend<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v1 = 0x2::coin::value<T1>(&v0);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, arg0.admin);
            let v2 = RewardsClaimedEvent{
                vault_id    : 0x2::object::id_address<Vault>(arg0),
                reward_type : 0x1::type_name::get<T1>(),
                amount      : v1,
                compounded  : false,
                timestamp   : 0x2::clock::timestamp_ms(arg3),
            };
            0x2::event::emit<RewardsClaimedEvent>(v2);
        } else {
            0x2::coin::destroy_zero<T1>(v0);
        };
    }

    public entry fun borrow_from_vault<T0, T1>(arg0: &mut Vault, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: u64, arg3: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>, arg4: &0x2::clock::Clock, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg6) == arg0.admin, 0);
        assert!(!arg0.paused, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0xf71f6742194126fc5b822810baa61c0f780ed1d43ff16136e519b8239fb87c20::suilend_adapter::borrow_from_suilend<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6), 0x2::tx_context::sender(arg6));
        let v0 = BorrowEvent{
            vault_id        : 0x2::object::id_address<Vault>(arg0),
            borrowed_amount : arg5,
            borrow_type     : 0x1::type_name::get<T1>(),
            timestamp       : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<BorrowEvent>(v0);
    }

    public fun calc_shares_for_deposit(arg0: &Vault, arg1: u64) : u64 {
        if (arg0.total_shares == 0 || arg0.sui_balance == 0) {
            arg1
        } else {
            arg1 * arg0.total_shares / arg0.sui_balance
        }
    }

    public entry fun deposit<T0, T1>(arg0: &mut Vault, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: 0xf71f6742194126fc5b822810baa61c0f780ed1d43ff16136e519b8239fb87c20::strategy::Strategies, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 0);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 >= arg0.config.min_deposit, 1);
        let v1 = calc_shares_for_deposit(arg0, v0);
        arg0.sui_balance = arg0.sui_balance + v0;
        arg0.total_shares = arg0.total_shares + v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<VAULT>>(0x2::coin::mint<VAULT>(&mut arg0.share_treasury, v1, arg6), 0x2::tx_context::sender(arg6));
        0xf71f6742194126fc5b822810baa61c0f780ed1d43ff16136e519b8239fb87c20::strategy::allocate_and_execute(&arg5, v0, arg6);
        0x2::transfer::public_share_object<0xf71f6742194126fc5b822810baa61c0f780ed1d43ff16136e519b8239fb87c20::strategy::Strategies>(arg5);
        let (v2, v3) = 0xf71f6742194126fc5b822810baa61c0f780ed1d43ff16136e519b8239fb87c20::suilend_adapter::deposit_to_suilend<T0, T1>(arg2, arg3, arg4, arg1, arg0.admin, arg6);
        let v4 = v3;
        let v5 = v2;
        0x1::option::fill<0x2::object::ID>(&mut arg0.ctoken, 0x2::object::id<0x2::coin::Coin<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, 0x2::sui::SUI>>>(&v5));
        0x1::option::fill<0x2::object::ID>(&mut arg0.obligation_cap, 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>>(&v4));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, 0x2::sui::SUI>>>(v5, arg0.admin);
        0x2::transfer::public_transfer<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>>(v4, arg0.admin);
        let v6 = DepositEvent{
            user   : 0x2::tx_context::sender(arg6),
            amount : v0,
            shares : v1,
        };
        0x2::event::emit<DepositEvent>(v6);
    }

    public entry fun emergency_liquidate<T0, T1, T2>(arg0: &mut Vault, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: 0x2::object::ID, arg3: &mut 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, _) = 0xf71f6742194126fc5b822810baa61c0f780ed1d43ff16136e519b8239fb87c20::suilend_adapter::liquidate_obligation<T0, T1, T2>(arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T2>>>(v2, 0x2::tx_context::sender(arg7));
        let v3 = LiquidationEvent{
            vault_id          : 0x2::object::id_address<Vault>(arg0),
            liquidated_amount : 0x2::coin::value<T1>(arg3),
            seized_collateral : 0x2::coin::value<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T2>>(&v2),
            liquidator        : 0x2::tx_context::sender(arg7),
            timestamp         : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<LiquidationEvent>(v3);
    }

    public fun emit_performance_fee_event(arg0: &Vault, arg1: u64, arg2: address) {
        let v0 = PerformanceFeeAccruedEvent{
            fee_shares : arg1,
            treasury   : arg2,
        };
        0x2::event::emit<PerformanceFeeAccruedEvent>(v0);
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

    public entry fun get_reward_and_compound(arg0: &mut Vault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.sui_balance = arg0.sui_balance + arg1;
        let v0 = get_pps(arg0);
        if (v0 > (arg0.hwm as u128)) {
            let v1 = arg0.config.fee_recipient;
            let v2 = arg1 * arg0.config.fee_bps / 10000;
            if (v2 > 0) {
                let v3 = (((v2 as u128) * (arg0.total_shares as u128) / (arg0.sui_balance as u128)) as u64);
                arg0.total_shares = arg0.total_shares + v3;
                0x2::transfer::public_transfer<0x2::coin::Coin<VAULT>>(0x2::coin::mint<VAULT>(&mut arg0.share_treasury, v3, arg2), v1);
                let v4 = PerformanceFeeAccruedEvent{
                    fee_shares : v3,
                    treasury   : v1,
                };
                0x2::event::emit<PerformanceFeeAccruedEvent>(v4);
            };
            arg0.hwm = (v0 as u64);
        } else {
            arg0.hwm = (v0 as u64);
        };
    }

    public fun get_sui_balance(arg0: &Vault) : u64 {
        arg0.sui_balance
    }

    public fun get_total_shares(arg0: &Vault) : u64 {
        arg0.total_shares
    }

    public fun get_vault_id(arg0: &Vault) : address {
        0x2::object::id_address<Vault>(arg0)
    }

    public entry fun harvest_rewards<T0, T1>(arg0: &mut Vault, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>, arg3: &0x2::clock::Clock, arg4: u64, arg5: u64, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 0);
        assert!(0x2::tx_context::sender(arg7) == arg0.admin, 1001);
        let v0 = 0xf71f6742194126fc5b822810baa61c0f780ed1d43ff16136e519b8239fb87c20::suilend_adapter::claim_rewards_from_suilend<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v1 = 0x2::coin::value<T1>(&v0);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, arg0.admin);
            let v2 = RewardsClaimedEvent{
                vault_id    : 0x2::object::id_address<Vault>(arg0),
                reward_type : 0x1::type_name::get<T1>(),
                amount      : v1,
                compounded  : false,
                timestamp   : 0x2::clock::timestamp_ms(arg3),
            };
            0x2::event::emit<RewardsClaimedEvent>(v2);
        } else {
            0x2::coin::destroy_zero<T1>(v0);
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
            ctoken         : 0x1::option::none<0x2::object::ID>(),
            obligation_cap : 0x1::option::none<0x2::object::ID>(),
        };
        0x2::transfer::public_share_object<Vault>(v3);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<VAULT>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun is_paused(arg0: &Vault) : bool {
        arg0.paused
    }

    public fun set_hwm(arg0: &mut Vault, arg1: u64) {
        arg0.hwm = arg1;
    }

    public entry fun set_strategy(arg0: &mut Vault, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        let v0 = StrategyUpdatedEvent{
            by           : 0x2::tx_context::sender(arg2),
            new_strategy : arg1,
        };
        0x2::event::emit<StrategyUpdatedEvent>(v0);
    }

    public entry fun toggle_pause(arg0: &mut Vault, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 0);
        arg0.paused = !arg0.paused;
        let v0 = EmergencyToggledEvent{
            by     : 0x2::tx_context::sender(arg1),
            paused : arg0.paused,
        };
        0x2::event::emit<EmergencyToggledEvent>(v0);
    }

    public entry fun withdraw<T0>(arg0: &mut Vault, arg1: &mut 0x2::coin::Coin<VAULT>, arg2: u64, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: u64, arg5: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 0);
        assert!(arg2 > 0 && arg2 <= arg0.total_shares, 1);
        let v0 = get_pps(arg0);
        let v1 = (((arg2 as u128) * v0 / 1000000000000) as u64);
        assert!(v1 <= arg0.sui_balance, 2);
        if (v0 > (arg0.hwm as u128)) {
            let v2 = arg0.sui_balance - arg0.hwm;
            accrue_performance_fee(arg0, v2, arg7);
        };
        arg0.sui_balance = arg0.sui_balance - v1;
        arg0.total_shares = arg0.total_shares - arg2;
        0x2::coin::burn<VAULT>(&mut arg0.share_treasury, 0x2::coin::split<VAULT>(arg1, arg2, arg7));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xf71f6742194126fc5b822810baa61c0f780ed1d43ff16136e519b8239fb87c20::suilend_adapter::withdraw_from_suilend<T0>(arg3, arg4, arg6, arg5, arg2, arg7), 0x2::tx_context::sender(arg7));
        let v3 = WithdrawEvent{
            user   : 0x2::tx_context::sender(arg7),
            amount : v1,
            shares : arg2,
        };
        0x2::event::emit<WithdrawEvent>(v3);
    }

    // decompiled from Move bytecode v6
}

