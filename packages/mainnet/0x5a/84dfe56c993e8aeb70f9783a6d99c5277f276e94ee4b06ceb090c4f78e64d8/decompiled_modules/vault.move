module 0x5a84dfe56c993e8aeb70f9783a6d99c5277f276e94ee4b06ceb090c4f78e64d8::vault {
    struct WithdrawRequest<phantom T0> has store {
        lp_token: 0x2::coin::Coin<T0>,
        owner: address,
        request_type: u8,
    }

    struct ClaimableWithdrawals<phantom T0, phantom T1> has store {
        balance_base: 0x2::balance::Balance<T0>,
        balance_quote: 0x2::balance::Balance<T1>,
        owner: address,
    }

    struct DepositRequest<phantom T0> has store {
        amount: 0x2::balance::Balance<T0>,
        owner: address,
        request_type: u8,
    }

    struct Vault<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        type_x: 0x1::type_name::TypeName,
        type_y: 0x1::type_name::TypeName,
        treasury_cap: 0x2::coin::TreasuryCap<T2>,
        deposit_requests: 0x2::linked_table::LinkedTable<address, DepositRequest<T1>>,
        withdraw_requests: 0x2::linked_table::LinkedTable<address, WithdrawRequest<T2>>,
        whitelisted_addresses: vector<address>,
        deepbook_account_cap: 0xdee9::custodian_v2::AccountCap,
        claimable_withdrawals: 0x2::table::Table<address, ClaimableWithdrawals<T0, T1>>,
        last_epoch_timestamp: u64,
        epoch_counter: u64,
        state: u8,
        total_unprocessed_usdc_deposits: u64,
        total_unprocessed_lp_token_withdrawals: u64,
    }

    struct VaultCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    public fun add_deposit_request_as_object<T0, T1, T2, T3: key>(arg0: &mut Vault<T0, T1, T2>, arg1: 0x2::balance::Balance<T1>, arg2: &T3) {
        let v0 = 0x5a84dfe56c993e8aeb70f9783a6d99c5277f276e94ee4b06ceb090c4f78e64d8::constants::strategy_active();
        assert!(&arg0.state == &v0, 0x5a84dfe56c993e8aeb70f9783a6d99c5277f276e94ee4b06ceb090c4f78e64d8::error::strategy_not_active());
        let v1 = 0x2::balance::value<T1>(&arg1);
        assert!(v1 > 0x5a84dfe56c993e8aeb70f9783a6d99c5277f276e94ee4b06ceb090c4f78e64d8::constants::min_deposit_amount(), 0x5a84dfe56c993e8aeb70f9783a6d99c5277f276e94ee4b06ceb090c4f78e64d8::error::deposit_amount_too_low());
        arg0.total_unprocessed_usdc_deposits = arg0.total_unprocessed_usdc_deposits + v1;
        let v2 = 0x2::object::id<T3>(arg2);
        let v3 = 0x2::object::id_to_address(&v2);
        if (0x2::linked_table::contains<address, DepositRequest<T1>>(&arg0.deposit_requests, v3)) {
            0x2::balance::join<T1>(&mut 0x2::linked_table::borrow_mut<address, DepositRequest<T1>>(&mut arg0.deposit_requests, v3).amount, arg1);
        } else {
            let v4 = DepositRequest<T1>{
                amount       : arg1,
                owner        : v3,
                request_type : 0x5a84dfe56c993e8aeb70f9783a6d99c5277f276e94ee4b06ceb090c4f78e64d8::constants::request_from_object(),
            };
            0x2::linked_table::push_back<address, DepositRequest<T1>>(&mut arg0.deposit_requests, v3, v4);
        };
    }

    public fun add_deposit_request_as_user<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: 0x2::balance::Balance<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x5a84dfe56c993e8aeb70f9783a6d99c5277f276e94ee4b06ceb090c4f78e64d8::constants::strategy_active();
        assert!(&arg0.state == &v0, 0x5a84dfe56c993e8aeb70f9783a6d99c5277f276e94ee4b06ceb090c4f78e64d8::error::strategy_not_active());
        let v1 = 0x2::balance::value<T1>(&arg1);
        assert!(v1 > 0x5a84dfe56c993e8aeb70f9783a6d99c5277f276e94ee4b06ceb090c4f78e64d8::constants::min_deposit_amount(), 0x5a84dfe56c993e8aeb70f9783a6d99c5277f276e94ee4b06ceb090c4f78e64d8::error::deposit_amount_too_low());
        arg0.total_unprocessed_usdc_deposits = arg0.total_unprocessed_usdc_deposits + v1;
        let v2 = 0x2::tx_context::sender(arg2);
        if (0x2::linked_table::contains<address, DepositRequest<T1>>(&arg0.deposit_requests, v2)) {
            0x2::balance::join<T1>(&mut 0x2::linked_table::borrow_mut<address, DepositRequest<T1>>(&mut arg0.deposit_requests, v2).amount, arg1);
        } else {
            let v3 = DepositRequest<T1>{
                amount       : arg1,
                owner        : v2,
                request_type : 0x5a84dfe56c993e8aeb70f9783a6d99c5277f276e94ee4b06ceb090c4f78e64d8::constants::request_from_user(),
            };
            0x2::linked_table::push_back<address, DepositRequest<T1>>(&mut arg0.deposit_requests, v2, v3);
        };
    }

    public fun add_withdraw_request_as_object<T0, T1, T2, T3: key>(arg0: &mut Vault<T0, T1, T2>, arg1: 0x2::coin::Coin<T2>, arg2: &T3) {
        let v0 = 0x5a84dfe56c993e8aeb70f9783a6d99c5277f276e94ee4b06ceb090c4f78e64d8::constants::strategy_active();
        assert!(&arg0.state == &v0, 0x5a84dfe56c993e8aeb70f9783a6d99c5277f276e94ee4b06ceb090c4f78e64d8::error::strategy_not_active());
        arg0.total_unprocessed_lp_token_withdrawals = arg0.total_unprocessed_lp_token_withdrawals + 0x2::coin::value<T2>(&arg1);
        let v1 = 0x2::object::id<T3>(arg2);
        let v2 = 0x2::object::id_to_address(&v1);
        if (0x2::linked_table::contains<address, WithdrawRequest<T2>>(&arg0.withdraw_requests, v2)) {
            0x2::coin::join<T2>(&mut 0x2::linked_table::borrow_mut<address, WithdrawRequest<T2>>(&mut arg0.withdraw_requests, v2).lp_token, arg1);
        } else {
            let v3 = WithdrawRequest<T2>{
                lp_token     : arg1,
                owner        : v2,
                request_type : 0x5a84dfe56c993e8aeb70f9783a6d99c5277f276e94ee4b06ceb090c4f78e64d8::constants::request_from_object(),
            };
            0x2::linked_table::push_back<address, WithdrawRequest<T2>>(&mut arg0.withdraw_requests, v2, v3);
        };
    }

    public fun add_withdraw_request_as_user<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: 0x2::coin::Coin<T2>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x5a84dfe56c993e8aeb70f9783a6d99c5277f276e94ee4b06ceb090c4f78e64d8::constants::strategy_active();
        assert!(&arg0.state == &v0, 0x5a84dfe56c993e8aeb70f9783a6d99c5277f276e94ee4b06ceb090c4f78e64d8::error::strategy_not_active());
        arg0.total_unprocessed_lp_token_withdrawals = arg0.total_unprocessed_lp_token_withdrawals + 0x2::coin::value<T2>(&arg1);
        let v1 = 0x2::tx_context::sender(arg2);
        if (0x2::linked_table::contains<address, WithdrawRequest<T2>>(&arg0.withdraw_requests, v1)) {
            0x2::coin::join<T2>(&mut 0x2::linked_table::borrow_mut<address, WithdrawRequest<T2>>(&mut arg0.withdraw_requests, v1).lp_token, arg1);
        } else {
            let v2 = WithdrawRequest<T2>{
                lp_token     : arg1,
                owner        : v1,
                request_type : 0x5a84dfe56c993e8aeb70f9783a6d99c5277f276e94ee4b06ceb090c4f78e64d8::constants::request_from_user(),
            };
            0x2::linked_table::push_back<address, WithdrawRequest<T2>>(&mut arg0.withdraw_requests, v1, v2);
        };
    }

    public fun calculate_lp_token_share<T0, T1, T2>(arg0: &Vault<T0, T1, T2>, arg1: &0xdee9::clob_v2::Pool<T0, T1>, arg2: u64) : (u64, u64) {
        let (v0, _, v2, _) = get_deepbook_account_assets<T0, T1, T2>(arg0, arg1);
        let v4 = 0x2::coin::total_supply<T2>(&arg0.treasury_cap);
        assert!(v4 > 0, 0x5a84dfe56c993e8aeb70f9783a6d99c5277f276e94ee4b06ceb090c4f78e64d8::error::invalidLPToken());
        (v0 * arg2 / v4, v2 * arg2 / v4)
    }

    public fun claim_withdrawal_as_object<T0, T1, T2, T3: key>(arg0: &mut Vault<T0, T1, T2>, arg1: &T3, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::object::id<T3>(arg1);
        let ClaimableWithdrawals {
            balance_base  : v1,
            balance_quote : v2,
            owner         : _,
        } = 0x2::table::remove<address, ClaimableWithdrawals<T0, T1>>(&mut arg0.claimable_withdrawals, 0x2::object::id_to_address(&v0));
        (0x2::coin::from_balance<T0>(v1, arg2), 0x2::coin::from_balance<T1>(v2, arg2))
    }

    public fun claim_withdrawal_as_user<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let ClaimableWithdrawals {
            balance_base  : v0,
            balance_quote : v1,
            owner         : _,
        } = 0x2::table::remove<address, ClaimableWithdrawals<T0, T1>>(&mut arg0.claimable_withdrawals, 0x2::tx_context::sender(arg1));
        (0x2::coin::from_balance<T0>(v0, arg1), 0x2::coin::from_balance<T1>(v1, arg1))
    }

    public(friend) fun get_account_cap<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : &0xdee9::custodian_v2::AccountCap {
        &arg0.deepbook_account_cap
    }

    public fun get_claimable_amount<T0, T1, T2>(arg0: &Vault<T0, T1, T2>, arg1: address) : (u64, u64) {
        if (0x2::table::contains<address, ClaimableWithdrawals<T0, T1>>(&arg0.claimable_withdrawals, arg1)) {
            let v2 = 0x2::table::borrow<address, ClaimableWithdrawals<T0, T1>>(&arg0.claimable_withdrawals, arg1);
            (0x2::balance::value<T0>(&v2.balance_base), 0x2::balance::value<T1>(&v2.balance_quote))
        } else {
            (0, 0)
        }
    }

    public(friend) fun get_deepbook_account_assets<T0, T1, T2>(arg0: &Vault<T0, T1, T2>, arg1: &0xdee9::clob_v2::Pool<T0, T1>) : (u64, u64, u64, u64) {
        0xdee9::clob_v2::account_balance<T0, T1>(arg1, get_account_cap<T0, T1, T2>(arg0))
    }

    public fun get_deepbook_price<T0, T1>(arg0: &0xdee9::clob_v2::Pool<T0, T1>) : (u64, u64, u64) {
        let (v0, v1) = 0xdee9::clob_v2::get_market_price<T0, T1>(arg0);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0x1::option::get_with_default<u64>(&v3, 0);
        let v5 = 0x1::option::get_with_default<u64>(&v2, 0);
        (v4, v5, (v4 + v5) / 2)
    }

    public fun get_last_rebalanced_timestamp<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : u64 {
        arg0.last_epoch_timestamp
    }

    public fun get_number_of_unprocessed_deposits<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : u64 {
        0x2::linked_table::length<address, DepositRequest<T1>>(&arg0.deposit_requests)
    }

    public fun get_number_of_unprocessed_withdrawals<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : u64 {
        0x2::linked_table::length<address, WithdrawRequest<T2>>(&arg0.withdraw_requests)
    }

    public entry fun get_strategy_state<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : u8 {
        arg0.state
    }

    public fun get_unprocessed_deposits<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : u64 {
        arg0.total_unprocessed_usdc_deposits
    }

    public fun get_unprocessed_withdrawals<T0, T1, T2>(arg0: &Vault<T0, T1, T2>, arg1: &0xdee9::clob_v2::Pool<T0, T1>) : (u64, u64, u64) {
        let v0 = arg0.total_unprocessed_lp_token_withdrawals;
        let (v1, v2) = calculate_lp_token_share<T0, T1, T2>(arg0, arg1, v0);
        (v0, v1, v2)
    }

    public fun get_user_unprocessed_deposits<T0, T1, T2>(arg0: &Vault<T0, T1, T2>, arg1: address) : u64 {
        if (0x2::linked_table::contains<address, DepositRequest<T1>>(&arg0.deposit_requests, arg1)) {
            0x2::balance::value<T1>(&0x2::linked_table::borrow<address, DepositRequest<T1>>(&arg0.deposit_requests, arg1).amount)
        } else {
            0
        }
    }

    public fun get_user_unprocessed_withdrawals<T0, T1, T2>(arg0: &Vault<T0, T1, T2>, arg1: &0xdee9::clob_v2::Pool<T0, T1>, arg2: address) : (u64, u64, u64) {
        if (0x2::linked_table::contains<address, WithdrawRequest<T2>>(&arg0.withdraw_requests, arg2)) {
            let v3 = 0x2::coin::value<T2>(&0x2::linked_table::borrow<address, WithdrawRequest<T2>>(&arg0.withdraw_requests, arg2).lp_token);
            let (v4, v5) = calculate_lp_token_share<T0, T1, T2>(arg0, arg1, v3);
            (v3, v4, v5)
        } else {
            (0, 0, 0)
        }
    }

    public(friend) fun get_vault_id_from_vault<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : 0x2::object::ID {
        *0x2::object::uid_as_inner(&arg0.id)
    }

    public(friend) fun get_vault_id_from_vault_cap(arg0: &VaultCap) : 0x2::object::ID {
        arg0.vault_id
    }

    public(friend) fun is_address_whitelisted_for_trading<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.whitelisted_addresses, &arg1)
    }

    public fun mark_state_as_ready_for_withdrawal_processing<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>) {
        let v0 = 0x5a84dfe56c993e8aeb70f9783a6d99c5277f276e94ee4b06ceb090c4f78e64d8::constants::strategy_paused_and_ready_for_deposit_processing();
        assert!(&arg0.state == &v0 && 0x2::linked_table::length<address, DepositRequest<T1>>(&arg0.deposit_requests) == 0, 0x5a84dfe56c993e8aeb70f9783a6d99c5277f276e94ee4b06ceb090c4f78e64d8::error::strategy_not_ready_for_withdrawal_processing());
        arg0.state = 0x5a84dfe56c993e8aeb70f9783a6d99c5277f276e94ee4b06ceb090c4f78e64d8::constants::strategy_paused_and_ready_for_withdrawal_processing();
    }

    fun mint_lp_token<T0>(arg0: &mut 0x2::coin::TreasuryCap<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::total_supply<T0>(arg0);
        let v1 = if (v0 == 0) {
            let v2 = (0x2::math::sqrt_u128((arg3 as u128) * (arg4 as u128)) as u64);
            assert!(v2 > 0x5a84dfe56c993e8aeb70f9783a6d99c5277f276e94ee4b06ceb090c4f78e64d8::constants::minimal_liquidity(), 0x5a84dfe56c993e8aeb70f9783a6d99c5277f276e94ee4b06ceb090c4f78e64d8::error::notEnoughInitialLiquidity());
            v2
        } else {
            0x2::math::min(0x5a84dfe56c993e8aeb70f9783a6d99c5277f276e94ee4b06ceb090c4f78e64d8::safe_math::safe_mul_div_u64(arg3, v0, arg1), 0x5a84dfe56c993e8aeb70f9783a6d99c5277f276e94ee4b06ceb090c4f78e64d8::safe_math::safe_mul_div_u64(arg4, v0, arg2))
        };
        assert!(v1 > 0, 0x5a84dfe56c993e8aeb70f9783a6d99c5277f276e94ee4b06ceb090c4f78e64d8::error::liquidityInsufficientMinted());
        0x2::coin::mint<T0>(arg0, v1, arg5)
    }

    public fun new_vault<T0, T1, T2>(arg0: &0x5a84dfe56c993e8aeb70f9783a6d99c5277f276e94ee4b06ceb090c4f78e64d8::app::AdminCap, arg1: 0x2::coin::TreasuryCap<T2>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (Vault<T0, T1, T2>, VaultCap) {
        let v0 = Vault<T0, T1, T2>{
            id                                     : 0x2::object::new(arg3),
            type_x                                 : 0x1::type_name::get<T0>(),
            type_y                                 : 0x1::type_name::get<T1>(),
            treasury_cap                           : arg1,
            deposit_requests                       : 0x2::linked_table::new<address, DepositRequest<T1>>(arg3),
            withdraw_requests                      : 0x2::linked_table::new<address, WithdrawRequest<T2>>(arg3),
            whitelisted_addresses                  : 0x1::vector::empty<address>(),
            deepbook_account_cap                   : 0xdee9::clob_v2::create_account(arg3),
            claimable_withdrawals                  : 0x2::table::new<address, ClaimableWithdrawals<T0, T1>>(arg3),
            last_epoch_timestamp                   : 0x2::clock::timestamp_ms(arg2),
            epoch_counter                          : 0,
            state                                  : 0x5a84dfe56c993e8aeb70f9783a6d99c5277f276e94ee4b06ceb090c4f78e64d8::constants::strategy_active(),
            total_unprocessed_usdc_deposits        : 0,
            total_unprocessed_lp_token_withdrawals : 0,
        };
        let v1 = VaultCap{
            id       : 0x2::object::new(arg3),
            vault_id : 0x2::object::id<Vault<T0, T1, T2>>(&v0),
        };
        (v0, v1)
    }

    public fun pause_strategy_and_mark_ready_for_deposit_processing<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: &mut 0xdee9::clob_v2::Pool<T0, T1>) {
        let v0 = 0x5a84dfe56c993e8aeb70f9783a6d99c5277f276e94ee4b06ceb090c4f78e64d8::constants::strategy_active();
        assert!(&arg0.state == &v0, 0x5a84dfe56c993e8aeb70f9783a6d99c5277f276e94ee4b06ceb090c4f78e64d8::error::strategy_not_active());
        let v1 = get_account_cap<T0, T1, T2>(arg0);
        let v2 = 0xdee9::clob_v2::list_open_orders<T0, T1>(arg1, v1);
        if (0x1::vector::length<0xdee9::clob_v2::Order>(&v2) > 0) {
            0xdee9::clob_v2::cancel_all_orders<T0, T1>(arg1, v1);
        };
        arg0.state = 0x5a84dfe56c993e8aeb70f9783a6d99c5277f276e94ee4b06ceb090c4f78e64d8::constants::strategy_paused_and_ready_for_deposit_processing();
    }

    public fun process_deposits<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x5a84dfe56c993e8aeb70f9783a6d99c5277f276e94ee4b06ceb090c4f78e64d8::constants::strategy_paused_and_ready_for_deposit_processing();
        assert!(&arg0.state == &v0, 0x5a84dfe56c993e8aeb70f9783a6d99c5277f276e94ee4b06ceb090c4f78e64d8::error::strategy_not_ready_for_deposit_processing());
        let v1 = &arg0.deepbook_account_cap;
        let (v2, v3, v4, v5) = get_deepbook_account_assets<T0, T1, T2>(arg0, arg1);
        assert!(v3 == 0, 0x5a84dfe56c993e8aeb70f9783a6d99c5277f276e94ee4b06ceb090c4f78e64d8::error::locked_base_asset_found());
        assert!(v5 == 0, 0x5a84dfe56c993e8aeb70f9783a6d99c5277f276e94ee4b06ceb090c4f78e64d8::error::locked_quote_asset_found());
        let (_, _, v8) = get_deepbook_price<T0, T1>(arg1);
        let v9 = v2;
        let v10 = v4;
        let v11 = &mut arg0.treasury_cap;
        let v12 = 0;
        while (v12 < arg3 && 0x2::linked_table::length<address, DepositRequest<T1>>(&arg0.deposit_requests) > 0) {
            let (_, v14) = 0x2::linked_table::pop_front<address, DepositRequest<T1>>(&mut arg0.deposit_requests);
            let DepositRequest {
                amount       : v15,
                owner        : v16,
                request_type : _,
            } = v14;
            let v18 = v15;
            let v19 = 0x2::balance::value<T1>(&v18);
            let v20 = if (v4 == 0) {
                0x5a84dfe56c993e8aeb70f9783a6d99c5277f276e94ee4b06ceb090c4f78e64d8::safe_math::safe_mul_div_u64(v19, 1, 2)
            } else {
                0x5a84dfe56c993e8aeb70f9783a6d99c5277f276e94ee4b06ceb090c4f78e64d8::safe_math::safe_mul_div_u64(v19, v2, 1000 * v4 + v2)
            };
            let v21 = 0x5a84dfe56c993e8aeb70f9783a6d99c5277f276e94ee4b06ceb090c4f78e64d8::safe_math::safe_mul_div_u64(v20, v8, 1000000) * 1000;
            let (v22, v23) = 0xdee9::clob_v2::place_market_order<T0, T1>(arg1, v1, 1, v21 - v21 % 100000000, true, 0x2::coin::zero<T0>(arg4), 0x2::coin::from_balance<T1>(v18, arg4), arg2, arg4);
            let v24 = v23;
            let v25 = v22;
            let v26 = v9 + 0x2::coin::value<T0>(&v25);
            v9 = v26;
            let v27 = v10 + 0x2::coin::value<T1>(&v24);
            v10 = v27;
            0xdee9::clob_v2::deposit_base<T0, T1>(arg1, v25, v1);
            0xdee9::clob_v2::deposit_quote<T0, T1>(arg1, v24, v1);
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(mint_lp_token<T2>(v11, v26, v27, 0x2::coin::value<T0>(&v25), 0x2::coin::value<T1>(&v24), arg4), v16);
            arg0.total_unprocessed_usdc_deposits = arg0.total_unprocessed_usdc_deposits - v19;
            v12 = v12 + 1;
        };
        if (0x2::linked_table::length<address, DepositRequest<T1>>(&arg0.deposit_requests) == 0) {
            mark_state_as_ready_for_withdrawal_processing<T0, T1, T2>(arg0);
        };
    }

    public fun process_withdrawals<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x5a84dfe56c993e8aeb70f9783a6d99c5277f276e94ee4b06ceb090c4f78e64d8::constants::strategy_paused_and_ready_for_withdrawal_processing();
        assert!(&arg0.state == &v0, 0x5a84dfe56c993e8aeb70f9783a6d99c5277f276e94ee4b06ceb090c4f78e64d8::error::strategy_not_ready_for_withdrawal_processing());
        let v1 = &arg0.deepbook_account_cap;
        let v2 = 0;
        while (v2 < arg2 && 0x2::linked_table::length<address, WithdrawRequest<T2>>(&arg0.withdraw_requests) > 0) {
            let (_, v4) = 0x2::linked_table::pop_front<address, WithdrawRequest<T2>>(&mut arg0.withdraw_requests);
            let WithdrawRequest {
                lp_token     : v5,
                owner        : v6,
                request_type : _,
            } = v4;
            let v8 = v5;
            let v9 = 0x2::coin::value<T2>(&v8);
            let (v10, _, v12, _) = get_deepbook_account_assets<T0, T1, T2>(arg0, arg1);
            let v14 = 0x2::coin::total_supply<T2>(&arg0.treasury_cap);
            0x2::coin::burn<T2>(&mut arg0.treasury_cap, v8);
            let v15 = ClaimableWithdrawals<T0, T1>{
                balance_base  : 0x2::coin::into_balance<T0>(0xdee9::clob_v2::withdraw_base<T0, T1>(arg1, v10 * v9 / v14, v1, arg4)),
                balance_quote : 0x2::coin::into_balance<T1>(0xdee9::clob_v2::withdraw_quote<T0, T1>(arg1, v12 * v9 / v14, v1, arg4)),
                owner         : v6,
            };
            0x2::table::add<address, ClaimableWithdrawals<T0, T1>>(&mut arg0.claimable_withdrawals, v6, v15);
            arg0.total_unprocessed_lp_token_withdrawals = arg0.total_unprocessed_lp_token_withdrawals - v9;
            v2 = v2 + 1;
        };
        if (0x2::linked_table::length<address, WithdrawRequest<T2>>(&arg0.withdraw_requests) == 0) {
            start_strategy<T0, T1, T2>(arg0, arg3);
        };
    }

    public fun revoke_trading_permission<T0, T1, T2>(arg0: &VaultCap, arg1: &mut Vault<T0, T1, T2>, arg2: address) {
        assert!(get_vault_id_from_vault_cap(arg0) == get_vault_id_from_vault<T0, T1, T2>(arg1), 0x5a84dfe56c993e8aeb70f9783a6d99c5277f276e94ee4b06ceb090c4f78e64d8::error::invalid_vault_cap());
        let (v0, v1) = 0x1::vector::index_of<address>(&arg1.whitelisted_addresses, &arg2);
        assert!(v0, 0x5a84dfe56c993e8aeb70f9783a6d99c5277f276e94ee4b06ceb090c4f78e64d8::error::address_not_whitelisted());
        0x1::vector::remove<address>(&mut arg1.whitelisted_addresses, v1);
    }

    public fun start_strategy<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: &0x2::clock::Clock) {
        let v0 = 0x5a84dfe56c993e8aeb70f9783a6d99c5277f276e94ee4b06ceb090c4f78e64d8::constants::strategy_paused_and_ready_for_withdrawal_processing();
        assert!(&arg0.state == &v0 && 0x2::linked_table::length<address, WithdrawRequest<T2>>(&arg0.withdraw_requests) == 0, 0x5a84dfe56c993e8aeb70f9783a6d99c5277f276e94ee4b06ceb090c4f78e64d8::error::strategy_not_ready_to_make_active());
        arg0.state = 0x5a84dfe56c993e8aeb70f9783a6d99c5277f276e94ee4b06ceb090c4f78e64d8::constants::strategy_active();
        arg0.epoch_counter = arg0.epoch_counter + 1;
        arg0.last_epoch_timestamp = 0x2::clock::timestamp_ms(arg1);
    }

    public fun whitelist_address_for_trading<T0, T1, T2>(arg0: &VaultCap, arg1: &mut Vault<T0, T1, T2>, arg2: address) {
        assert!(get_vault_id_from_vault_cap(arg0) == get_vault_id_from_vault<T0, T1, T2>(arg1), 0x5a84dfe56c993e8aeb70f9783a6d99c5277f276e94ee4b06ceb090c4f78e64d8::error::invalid_vault_cap());
        0x1::vector::push_back<address>(&mut arg1.whitelisted_addresses, arg2);
    }

    // decompiled from Move bytecode v6
}

