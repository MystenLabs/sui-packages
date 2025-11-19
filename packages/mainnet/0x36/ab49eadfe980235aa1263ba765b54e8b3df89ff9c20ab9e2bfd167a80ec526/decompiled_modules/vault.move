module 0x36ab49eadfe980235aa1263ba765b54e8b3df89ff9c20ab9e2bfd167a80ec526::vault {
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
    }

    struct ReserveKey has copy, drop, store {
        reserve_index: u64,
    }

    struct VaultReserveSlot<phantom T0> has store {
        obligation_cap: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>,
    }

    struct StrategyKey has copy, drop, store {
        strategy_type: u8,
        reserve_index: u64,
    }

    struct VaultStrategySlot<phantom T0> has store {
        strategy_cap: 0xba97dc73a07638d03d77ad2161484eb21db577edc9cadcd7035fef4b4f2f6fa1::strategy_wrapper::StrategyOwnerCap<T0>,
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
        0x36ab49eadfe980235aa1263ba765b54e8b3df89ff9c20ab9e2bfd167a80ec526::suilend_adapter::get_suilend_reserve<T0, 0x2::sui::SUI>(arg3);
        let v0 = 0x36ab49eadfe980235aa1263ba765b54e8b3df89ff9c20ab9e2bfd167a80ec526::suilend_adapter::get_suilend_fee_receiver<T0>(arg3);
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
        0x36ab49eadfe980235aa1263ba765b54e8b3df89ff9c20ab9e2bfd167a80ec526::suilend_adapter::get_suilend_fee_receiver<T0>(arg1);
        let v0 = borrow_reserve_slot_shared<T0>(arg0, arg3);
        let v1 = 0x36ab49eadfe980235aa1263ba765b54e8b3df89ff9c20ab9e2bfd167a80ec526::suilend_adapter::claim_rewards_from_suilend<T0, 0x2::sui::SUI>(arg1, &v0.obligation_cap, arg2, arg3, arg4, arg5, arg6);
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
        let v0 = 0x36ab49eadfe980235aa1263ba765b54e8b3df89ff9c20ab9e2bfd167a80ec526::suilend_adapter::get_suilend_fee_receiver<T0>(arg1);
        let v1 = 0x36ab49eadfe980235aa1263ba765b54e8b3df89ff9c20ab9e2bfd167a80ec526::suilend_adapter::claim_rewards_from_suilend<T0, T1>(arg1, &borrow_reserve_slot_shared<T0>(arg0, arg3).obligation_cap, arg2, arg3, arg4, arg5, arg6);
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
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x36ab49eadfe980235aa1263ba765b54e8b3df89ff9c20ab9e2bfd167a80ec526::suilend_adapter::borrow_from_suilend<T0, T1>(arg1, arg2, &borrow_reserve_slot_shared<T0>(arg0, arg2).obligation_cap, arg3, arg4, arg5), 0x2::tx_context::sender(arg5));
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

    fun borrow_strategy_slot_shared<T0>(arg0: &mut Vault, arg1: u8, arg2: u64) : &VaultStrategySlot<T0> {
        0x2::dynamic_field::borrow<StrategyKey, VaultStrategySlot<T0>>(&arg0.id, strategy_key(arg1, arg2))
    }

    public fun calc_shares_for_deposit(arg0: &Vault, arg1: u64) : u64 {
        if (arg0.total_shares == 0 || arg0.sui_balance == 0) {
            arg1
        } else {
            arg1 * arg0.total_shares / arg0.sui_balance
        }
    }

    fun calculate_safe_borrow_amount<T0, T1>(arg0: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: &0xba97dc73a07638d03d77ad2161484eb21db577edc9cadcd7035fef4b4f2f6fa1::strategy_wrapper::StrategyOwnerCap<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) : u64 {
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T0>(arg0, 0xba97dc73a07638d03d77ad2161484eb21db577edc9cadcd7035fef4b4f2f6fa1::strategy_wrapper::obligation_id<T0>(arg1));
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::weighted_borrowed_value_usd<T0>(v0);
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::allowed_borrow_value_usd<T0>(v0), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(15000), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(10000)));
        let v2 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve<T0, 0x2::sui::SUI>(arg0);
        let v3 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::available_amount<T0>(v2);
        let v4 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::usd_to_token_amount_lower_bound<T0>(v2, v1));
        if (v4 < v3) {
            v4
        } else {
            v3
        }
    }

    fun check_health_factor_safe<T0>(arg0: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: &0xba97dc73a07638d03d77ad2161484eb21db577edc9cadcd7035fef4b4f2f6fa1::strategy_wrapper::StrategyOwnerCap<T0>, arg2: &0x2::clock::Clock) : bool {
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T0>(arg0, 0xba97dc73a07638d03d77ad2161484eb21db577edc9cadcd7035fef4b4f2f6fa1::strategy_wrapper::obligation_id<T0>(arg1));
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::weighted_borrowed_value_usd<T0>(v0);
        if (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::eq(v1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0))) {
            return true
        };
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::ge(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::allowed_borrow_value_usd<T0>(v0), v1), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(13000), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(10000)))
    }

    public entry fun deposit<T0>(arg0: &mut Vault, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x36ab49eadfe980235aa1263ba765b54e8b3df89ff9c20ab9e2bfd167a80ec526::strategy::Strategies, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 0);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 >= arg0.config.min_deposit, 1);
        let v1 = calc_shares_for_deposit(arg0, v0);
        arg0.sui_balance = arg0.sui_balance + v0;
        arg0.total_shares = arg0.total_shares + v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<VAULT>>(0x2::coin::mint<VAULT>(&mut arg0.share_treasury, v1, arg6), 0x2::tx_context::sender(arg6));
        0x36ab49eadfe980235aa1263ba765b54e8b3df89ff9c20ab9e2bfd167a80ec526::strategy::allocate_and_execute(arg5, v0, arg6);
        ensure_reserve_slot<T0>(arg0, arg2, arg3, arg6);
        0x36ab49eadfe980235aa1263ba765b54e8b3df89ff9c20ab9e2bfd167a80ec526::suilend_adapter::deposit_to_suilend<T0>(arg2, arg3, arg4, arg1, &borrow_reserve_slot_shared<T0>(arg0, arg3).obligation_cap, arg6);
        let v2 = VaultEvent{
            kind      : 0,
            user      : 0x2::tx_context::sender(arg6),
            amount    : v0,
            shares    : v1,
            extra     : 0,
            type_name : 0x1::type_name::get<0x2::sui::SUI>(),
            flag      : false,
        };
        0x2::event::emit<VaultEvent>(v2);
    }

    public entry fun deposit_with_suilend_loop<T0, T1: drop>(arg0: &mut Vault, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x36ab49eadfe980235aa1263ba765b54e8b3df89ff9c20ab9e2bfd167a80ec526::strategy::Strategies, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T1>, arg8: &mut 0x3::sui_system::SuiSystemState, arg9: &mut 0x2::tx_context::TxContext) {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<T0>(arg2, arg3, arg4, arg6);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<T0>(arg2, arg3 + 10, arg4, arg6);
        assert!(!arg0.paused, 0);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 >= arg0.config.min_deposit, 1);
        let v1 = calc_shares_for_deposit(arg0, v0);
        arg0.sui_balance = arg0.sui_balance + v0;
        arg0.total_shares = arg0.total_shares + v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<VAULT>>(0x2::coin::mint<VAULT>(&mut arg0.share_treasury, v1, arg9), 0x2::tx_context::sender(arg9));
        0x36ab49eadfe980235aa1263ba765b54e8b3df89ff9c20ab9e2bfd167a80ec526::strategy::allocate_and_execute(arg5, v0, arg9);
        ensure_strategy_slot<T0>(arg0, arg2, 1, arg3, arg9);
        let v2 = borrow_strategy_slot_shared<T0>(arg0, 1, arg3);
        let v3 = 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::mint<T1>(arg7, arg8, arg1, arg9);
        0xba97dc73a07638d03d77ad2161484eb21db577edc9cadcd7035fef4b4f2f6fa1::strategy_wrapper::deposit_liquidity_and_deposit_into_obligation<T0, T1>(&v2.strategy_cap, arg2, arg3 + 10, arg4, v3, arg9);
        let v4 = calculate_safe_borrow_amount<T0, T1>(arg2, &v2.strategy_cap, arg3, arg3 + 10, 0x2::coin::value<T1>(&v3), arg4);
        if (v4 > 10000) {
            if (check_health_factor_safe<T0>(arg2, &v2.strategy_cap, arg4)) {
                assert!(check_health_factor_safe<T0>(arg2, &v2.strategy_cap, arg4), 9001);
                0x2::coin::join<0x2::sui::SUI>(&mut arg0.coin, 0xba97dc73a07638d03d77ad2161484eb21db577edc9cadcd7035fef4b4f2f6fa1::strategy_wrapper::borrow_sui_from_obligation<T0>(&v2.strategy_cap, arg2, arg3, arg4, v4, arg8, arg9));
                arg0.sui_balance = arg0.sui_balance + v4;
                let v5 = VaultEvent{
                    kind      : 0,
                    user      : 0x2::tx_context::sender(arg9),
                    amount    : v0,
                    shares    : v1,
                    extra     : v4,
                    type_name : 0x1::type_name::get<0x2::sui::SUI>(),
                    flag      : true,
                };
                0x2::event::emit<VaultEvent>(v5);
            } else {
                let v6 = VaultEvent{
                    kind      : 0,
                    user      : 0x2::tx_context::sender(arg9),
                    amount    : v0,
                    shares    : v1,
                    extra     : 0,
                    type_name : 0x1::type_name::get<0x2::sui::SUI>(),
                    flag      : false,
                };
                0x2::event::emit<VaultEvent>(v6);
            };
        } else {
            let v7 = VaultEvent{
                kind      : 0,
                user      : 0x2::tx_context::sender(arg9),
                amount    : v0,
                shares    : v1,
                extra     : 0,
                type_name : 0x1::type_name::get<0x2::sui::SUI>(),
                flag      : false,
            };
            0x2::event::emit<VaultEvent>(v7);
        };
    }

    public entry fun emergency_liquidate<T0, T1, T2>(arg0: &mut Vault, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: 0x2::object::ID, arg3: &mut 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, _) = 0x36ab49eadfe980235aa1263ba765b54e8b3df89ff9c20ab9e2bfd167a80ec526::suilend_adapter::liquidate_obligation<T0, T1, T2>(arg1, arg2, arg3, arg4, arg5, arg6, arg7);
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
            let v1 = VaultReserveSlot<T0>{obligation_cap: 0x36ab49eadfe980235aa1263ba765b54e8b3df89ff9c20ab9e2bfd167a80ec526::suilend_adapter::create_obligation_cap<T0>(arg1, arg3)};
            0x2::dynamic_field::add<ReserveKey, VaultReserveSlot<T0>>(&mut arg0.id, v0, v1);
        };
    }

    fun ensure_strategy_slot<T0>(arg0: &mut Vault, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: u8, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = strategy_key(arg2, arg3);
        if (!0x2::dynamic_field::exists_<StrategyKey>(&arg0.id, v0)) {
            let v1 = VaultStrategySlot<T0>{strategy_cap: 0xba97dc73a07638d03d77ad2161484eb21db577edc9cadcd7035fef4b4f2f6fa1::strategy_wrapper::create_strategy_owner_cap<T0>(arg1, arg2, arg4)};
            0x2::dynamic_field::add<StrategyKey, VaultStrategySlot<T0>>(&mut arg0.id, v0, v1);
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
        let v1 = 0x36ab49eadfe980235aa1263ba765b54e8b3df89ff9c20ab9e2bfd167a80ec526::suilend_adapter::claim_rewards_from_suilend<T0, T1>(arg1, &v0.obligation_cap, arg2, arg3, arg4, arg5, arg6);
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
        };
        0x2::transfer::public_share_object<Vault>(v3);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<VAULT>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun is_paused(arg0: &Vault) : bool {
        arg0.paused
    }

    fun reserve_key(arg0: u64) : ReserveKey {
        ReserveKey{reserve_index: arg0}
    }

    public fun set_hwm(arg0: &mut Vault, arg1: u64) {
        arg0.hwm = arg1;
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

    fun strategy_key(arg0: u8, arg1: u64) : StrategyKey {
        StrategyKey{
            strategy_type : arg0,
            reserve_index : arg1,
        }
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
        arg0.sui_balance = arg0.sui_balance - v0;
        arg0.total_shares = arg0.total_shares - arg2;
        0x2::coin::burn<VAULT>(&mut arg0.share_treasury, 0x2::coin::split<VAULT>(arg1, arg2, arg6));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x36ab49eadfe980235aa1263ba765b54e8b3df89ff9c20ab9e2bfd167a80ec526::suilend_adapter::withdraw_liquidity_from_suilend<T0, 0x2::sui::SUI>(arg3, arg4, arg5, &borrow_reserve_slot_shared<T0>(arg0, arg4).obligation_cap, v0, arg6), 0x2::tx_context::sender(arg6));
        let v1 = VaultEvent{
            kind      : 1,
            user      : 0x2::tx_context::sender(arg6),
            amount    : v0,
            shares    : arg2,
            extra     : 0,
            type_name : 0x1::type_name::get<0x2::sui::SUI>(),
            flag      : false,
        };
        0x2::event::emit<VaultEvent>(v1);
    }

    public entry fun withdraw_with_suilend_loop<T0, T1: drop>(arg0: &mut Vault, arg1: &mut 0x2::coin::Coin<VAULT>, arg2: u64, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: u64, arg6: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T1>, arg7: &0x2::clock::Clock, arg8: &mut 0x3::sui_system::SuiSystemState, arg9: &0xba97dc73a07638d03d77ad2161484eb21db577edc9cadcd7035fef4b4f2f6fa1::strategy_wrapper::StrategyOwnerCap<T0>, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 0);
        assert!(arg2 > 0 && arg2 <= arg0.total_shares, 1);
        ensure_reserve_slot<T0>(arg0, arg3, arg5, arg10);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<T0>(arg3, arg5, arg7, arg4);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<T0>(arg3, arg5 + 10, arg7, arg4);
        assert!(check_health_factor_safe<T0>(arg3, arg9, arg7), 9002);
        let v0 = (((arg2 as u128) * get_pps(arg0) / 1000000000000) as u64);
        assert!(v0 <= arg0.sui_balance, 2);
        arg0.sui_balance = arg0.sui_balance - v0;
        arg0.total_shares = arg0.total_shares - arg2;
        0x2::coin::burn<VAULT>(&mut arg0.share_treasury, 0x2::coin::split<VAULT>(arg1, arg2, arg10));
        let v1 = 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::redeem<T1>(arg6, 0xba97dc73a07638d03d77ad2161484eb21db577edc9cadcd7035fef4b4f2f6fa1::strategy_wrapper::withdraw_from_obligation_and_redeem<T0, T1>(arg9, arg3, arg5 + 10, arg7, v0, arg10), arg8, arg10);
        let v2 = borrow_reserve_slot_shared<T0>(arg0, arg5);
        0x36ab49eadfe980235aa1263ba765b54e8b3df89ff9c20ab9e2bfd167a80ec526::suilend_adapter::repay_borrow<T0, 0x2::sui::SUI>(arg3, arg5, &v2.obligation_cap, arg7, &mut v1, arg10);
        assert!(check_health_factor_safe<T0>(arg3, arg9, arg7), 9003);
        0x2::coin::join<0x2::sui::SUI>(&mut arg0.coin, v1);
        let v3 = VaultEvent{
            kind      : 1,
            user      : 0x2::tx_context::sender(arg10),
            amount    : v0,
            shares    : arg2,
            extra     : 0,
            type_name : 0x1::type_name::get<0x2::sui::SUI>(),
            flag      : false,
        };
        0x2::event::emit<VaultEvent>(v3);
    }

    public entry fun withdraw_with_suilend_loop_and_claim<T0, T1: drop, T2>(arg0: &mut Vault, arg1: &mut 0x2::coin::Coin<VAULT>, arg2: u64, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 0);
        assert!(arg2 > 0 && arg2 <= arg0.total_shares, 1);
        let v0 = (((arg2 as u128) * get_pps(arg0) / 1000000000000) as u64);
        assert!(v0 <= arg0.sui_balance, 2);
        arg0.sui_balance = arg0.sui_balance - v0;
        arg0.total_shares = arg0.total_shares - arg2;
        0x2::coin::burn<VAULT>(&mut arg0.share_treasury, 0x2::coin::split<VAULT>(arg1, arg2, arg7));
        let v1 = borrow_strategy_slot_shared<T0>(arg0, 1, arg4);
        let v2 = 0xba97dc73a07638d03d77ad2161484eb21db577edc9cadcd7035fef4b4f2f6fa1::strategy_wrapper::claim_rewards<T0, T2>(&v1.strategy_cap, arg3, arg6, arg4, arg5, true, arg7);
        let v3 = 0x2::coin::value<T2>(&v2);
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v2, 0x2::tx_context::sender(arg7));
            let v4 = VaultEvent{
                kind      : 7,
                user      : 0x2::tx_context::sender(arg7),
                amount    : v3,
                shares    : 0,
                extra     : 0x2::clock::timestamp_ms(arg6),
                type_name : 0x1::type_name::get<T2>(),
                flag      : false,
            };
            0x2::event::emit<VaultEvent>(v4);
        } else {
            0x2::coin::destroy_zero<T2>(v2);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xba97dc73a07638d03d77ad2161484eb21db577edc9cadcd7035fef4b4f2f6fa1::strategy_wrapper::withdraw_from_obligation_and_redeem<T0, 0x2::sui::SUI>(&v1.strategy_cap, arg3, arg4, arg6, v0, arg7), 0x2::tx_context::sender(arg7));
        let v5 = VaultEvent{
            kind      : 1,
            user      : 0x2::tx_context::sender(arg7),
            amount    : v0,
            shares    : arg2,
            extra     : 0,
            type_name : 0x1::type_name::get<0x2::sui::SUI>(),
            flag      : false,
        };
        0x2::event::emit<VaultEvent>(v5);
    }

    // decompiled from Move bytecode v6
}

