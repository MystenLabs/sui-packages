module 0x732ef956d38c32fb7dff4b1c0decbcf4599c18e998e67bfbb0ecf00de9193f99::vault {
    struct VAULT has drop {
        dummy_field: bool,
    }

    struct WithdrawRequest<phantom T0, phantom T1> has store {
        lp_token: 0x2::coin::Coin<VAULT>,
        owner: address,
    }

    struct ClaimableWithdrawals<phantom T0, phantom T1> has store {
        balance_base: 0x2::balance::Balance<T0>,
        balance_quote: 0x2::balance::Balance<T1>,
        owner: address,
    }

    struct DepositRequest<phantom T0> has store {
        amount: 0x2::balance::Balance<T0>,
        owner: address,
    }

    struct Vault<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        type_x: 0x1::type_name::TypeName,
        type_y: 0x1::type_name::TypeName,
        balance_x: 0x2::balance::Balance<T0>,
        balance_y: 0x2::balance::Balance<T1>,
        maker_fees_X: 0x2::balance::Balance<T0>,
        maker_fees_Y: 0x2::balance::Balance<T1>,
        deposit_requests_keys: vector<address>,
        deposit_requests: 0x2::table::Table<address, DepositRequest<T1>>,
        withdraw_requests_keys: vector<address>,
        withdraw_requests: 0x2::table::Table<address, WithdrawRequest<T0, T1>>,
        whitelisted_addresses: vector<address>,
        deepbook_account_cap: 0xdee9::custodian_v2::AccountCap,
        claimable_withdrawals: 0x2::table::Table<address, ClaimableWithdrawals<T0, T1>>,
        last_processed_timestamp: u64,
        epoch_counter: u64,
        strategy_state: 0x1::string::String,
        total_unprocessed_usdc_deposits: u64,
        total_unprocessed_lp_token_withdrawals: u64,
    }

    struct VaultCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    public fun add_deposit_request<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x732ef956d38c32fb7dff4b1c0decbcf4599c18e998e67bfbb0ecf00de9193f99::constants::strategy_active();
        assert!(&arg0.strategy_state == &v0, 0x732ef956d38c32fb7dff4b1c0decbcf4599c18e998e67bfbb0ecf00de9193f99::error::strategy_not_active());
        arg0.total_unprocessed_usdc_deposits = arg0.total_unprocessed_usdc_deposits + 0x2::balance::value<T1>(&arg1);
        if (0x2::table::contains<address, DepositRequest<T1>>(&arg0.deposit_requests, 0x2::tx_context::sender(arg2))) {
            0x2::balance::join<T1>(&mut 0x2::table::borrow_mut<address, DepositRequest<T1>>(&mut arg0.deposit_requests, 0x2::tx_context::sender(arg2)).amount, arg1);
        } else {
            let v1 = DepositRequest<T1>{
                amount : arg1,
                owner  : 0x2::tx_context::sender(arg2),
            };
            0x2::table::add<address, DepositRequest<T1>>(&mut arg0.deposit_requests, 0x2::tx_context::sender(arg2), v1);
            0x1::vector::push_back<address>(&mut arg0.deposit_requests_keys, 0x2::tx_context::sender(arg2));
        };
    }

    public fun add_withdraw_request<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::coin::Coin<VAULT>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x732ef956d38c32fb7dff4b1c0decbcf4599c18e998e67bfbb0ecf00de9193f99::constants::strategy_active();
        assert!(&arg0.strategy_state == &v0, 0x732ef956d38c32fb7dff4b1c0decbcf4599c18e998e67bfbb0ecf00de9193f99::error::strategy_not_active());
        arg0.total_unprocessed_lp_token_withdrawals = arg0.total_unprocessed_lp_token_withdrawals + 0x2::coin::value<VAULT>(&arg1);
        if (0x2::table::contains<address, WithdrawRequest<T0, T1>>(&arg0.withdraw_requests, 0x2::tx_context::sender(arg2))) {
            0x2::coin::join<VAULT>(&mut 0x2::table::borrow_mut<address, WithdrawRequest<T0, T1>>(&mut arg0.withdraw_requests, 0x2::tx_context::sender(arg2)).lp_token, arg1);
        } else {
            let v1 = WithdrawRequest<T0, T1>{
                lp_token : arg1,
                owner    : 0x2::tx_context::sender(arg2),
            };
            0x2::table::add<address, WithdrawRequest<T0, T1>>(&mut arg0.withdraw_requests, 0x2::tx_context::sender(arg2), v1);
            0x1::vector::push_back<address>(&mut arg0.withdraw_requests_keys, 0x2::tx_context::sender(arg2));
        };
    }

    public fun calculate_lp_token_share<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0xdee9::clob_v2::Pool<T0, T1>, arg2: &0x2::coin::TreasuryCap<VAULT>, arg3: u64) : (u64, u64) {
        let (v0, _, v2, _) = get_deepbook_account_assets<T0, T1>(arg0, arg1);
        let v4 = 0x2::coin::total_supply<VAULT>(arg2);
        assert!(v4 > 0, 0x732ef956d38c32fb7dff4b1c0decbcf4599c18e998e67bfbb0ecf00de9193f99::error::invalidLPToken());
        (v0 * arg3 / v4, v2 * arg3 / v4)
    }

    public fun claim_withdrawal<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        let ClaimableWithdrawals {
            balance_base  : v0,
            balance_quote : v1,
            owner         : v2,
        } = 0x2::table::remove<address, ClaimableWithdrawals<T0, T1>>(&mut arg0.claimable_withdrawals, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg1), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v1, arg1), v2);
    }

    public(friend) fun get_account_cap<T0, T1>(arg0: &Vault<T0, T1>) : &0xdee9::custodian_v2::AccountCap {
        &arg0.deepbook_account_cap
    }

    public fun get_claimable_amount<T0, T1>(arg0: &Vault<T0, T1>, arg1: address) : (u64, u64) {
        if (0x2::table::contains<address, ClaimableWithdrawals<T0, T1>>(&arg0.claimable_withdrawals, arg1)) {
            let v2 = 0x2::table::borrow<address, ClaimableWithdrawals<T0, T1>>(&arg0.claimable_withdrawals, arg1);
            (0x2::balance::value<T0>(&v2.balance_base), 0x2::balance::value<T1>(&v2.balance_quote))
        } else {
            (0, 0)
        }
    }

    public(friend) fun get_deepbook_account_assets<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0xdee9::clob_v2::Pool<T0, T1>) : (u64, u64, u64, u64) {
        0xdee9::clob_v2::account_balance<T0, T1>(arg1, get_account_cap<T0, T1>(arg0))
    }

    public fun get_deepbook_price<T0, T1>(arg0: &0xdee9::clob_v2::Pool<T0, T1>) : (u64, u64, u64) {
        let (v0, v1) = 0xdee9::clob_v2::get_market_price<T0, T1>(arg0);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0x1::option::get_with_default<u64>(&v3, 0);
        let v5 = 0x1::option::get_with_default<u64>(&v2, 0);
        (v4, v5, (v4 + v5) / 2)
    }

    public fun get_last_rebalanced_timestamp<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.last_processed_timestamp
    }

    public fun get_number_of_unprocessed_deposits<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        0x2::table::length<address, DepositRequest<T1>>(&arg0.deposit_requests)
    }

    public fun get_number_of_unprocessed_withdrawals<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        0x2::table::length<address, WithdrawRequest<T0, T1>>(&arg0.withdraw_requests)
    }

    public entry fun get_strategy_state<T0, T1>(arg0: &Vault<T0, T1>) : 0x1::string::String {
        arg0.strategy_state
    }

    public fun get_unprocessed_deposits<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.total_unprocessed_usdc_deposits
    }

    public fun get_unprocessed_withdrawals<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0xdee9::clob_v2::Pool<T0, T1>, arg2: &0x2::coin::TreasuryCap<VAULT>) : (u64, u64, u64) {
        let v0 = arg0.total_unprocessed_lp_token_withdrawals;
        let (v1, v2) = calculate_lp_token_share<T0, T1>(arg0, arg1, arg2, v0);
        (v0, v1, v2)
    }

    public fun get_user_unprocessed_deposits<T0, T1>(arg0: &Vault<T0, T1>, arg1: address) : u64 {
        if (0x2::table::contains<address, DepositRequest<T1>>(&arg0.deposit_requests, arg1)) {
            0x2::balance::value<T1>(&0x2::table::borrow<address, DepositRequest<T1>>(&arg0.deposit_requests, arg1).amount)
        } else {
            0
        }
    }

    public fun get_user_unprocessed_withdrawals<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0xdee9::clob_v2::Pool<T0, T1>, arg2: &0x2::coin::TreasuryCap<VAULT>, arg3: address) : (u64, u64, u64) {
        if (0x2::table::contains<address, WithdrawRequest<T0, T1>>(&arg0.withdraw_requests, arg3)) {
            let v3 = 0x2::coin::value<VAULT>(&0x2::table::borrow<address, WithdrawRequest<T0, T1>>(&arg0.withdraw_requests, arg3).lp_token);
            let (v4, v5) = calculate_lp_token_share<T0, T1>(arg0, arg1, arg2, v3);
            (v3, v4, v5)
        } else {
            (0, 0, 0)
        }
    }

    public(friend) fun get_vault_id_from_vault<T0, T1>(arg0: &Vault<T0, T1>) : 0x2::object::ID {
        *0x2::object::uid_as_inner(&arg0.id)
    }

    public(friend) fun get_vault_id_from_vault_cap(arg0: &VaultCap) : 0x2::object::ID {
        arg0.vault_id
    }

    fun init(arg0: VAULT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x732ef956d38c32fb7dff4b1c0decbcf4599c18e998e67bfbb0ecf00de9193f99::constants::lp_token_metadata();
        let (v4, v5) = 0x2::coin::create_currency<VAULT>(arg0, v0, v1, v2, v3, 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<VAULT>>(v4);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VAULT>>(v5);
    }

    public(friend) fun is_address_whitelisted_for_trading<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.whitelisted_addresses, &arg1)
    }

    public fun mark_state_as_ready_for_withdrawal_processing<T0, T1>(arg0: &mut Vault<T0, T1>) {
        let v0 = 0x732ef956d38c32fb7dff4b1c0decbcf4599c18e998e67bfbb0ecf00de9193f99::constants::strategy_paused_and_ready_for_deposit_processing();
        assert!(&arg0.strategy_state == &v0, 0x732ef956d38c32fb7dff4b1c0decbcf4599c18e998e67bfbb0ecf00de9193f99::error::strategy_not_ready_for_withdrawal_processing());
        arg0.strategy_state = 0x732ef956d38c32fb7dff4b1c0decbcf4599c18e998e67bfbb0ecf00de9193f99::constants::strategy_paused_and_ready_for_withdrawal_processing();
    }

    public fun mark_strategy_as_ready_to_start<T0, T1>(arg0: &mut Vault<T0, T1>) {
        let v0 = 0x732ef956d38c32fb7dff4b1c0decbcf4599c18e998e67bfbb0ecf00de9193f99::constants::strategy_paused_and_ready_for_withdrawal_processing();
        assert!(&arg0.strategy_state == &v0, 0x732ef956d38c32fb7dff4b1c0decbcf4599c18e998e67bfbb0ecf00de9193f99::error::strategy_not_ready_to_start());
        arg0.strategy_state = 0x732ef956d38c32fb7dff4b1c0decbcf4599c18e998e67bfbb0ecf00de9193f99::constants::strategy_paused_and_ready_to_start();
    }

    fun mint_lp_token(arg0: &mut 0x2::coin::TreasuryCap<VAULT>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<VAULT> {
        let v0 = 0x2::coin::total_supply<VAULT>(arg0);
        let v1 = if (v0 == 0) {
            let v2 = (0x2::math::sqrt_u128((arg3 as u128) * (arg4 as u128)) as u64);
            assert!(v2 > 0x732ef956d38c32fb7dff4b1c0decbcf4599c18e998e67bfbb0ecf00de9193f99::constants::minimal_liquidity(), 0x732ef956d38c32fb7dff4b1c0decbcf4599c18e998e67bfbb0ecf00de9193f99::error::notEnoughInitialLiquidity());
            v2
        } else {
            0x2::math::min(0x732ef956d38c32fb7dff4b1c0decbcf4599c18e998e67bfbb0ecf00de9193f99::safe_math::safe_mul_div_u64(arg3, v0, arg1), 0x732ef956d38c32fb7dff4b1c0decbcf4599c18e998e67bfbb0ecf00de9193f99::safe_math::safe_mul_div_u64(arg4, v0, arg2))
        };
        assert!(v1 > 0, 0x732ef956d38c32fb7dff4b1c0decbcf4599c18e998e67bfbb0ecf00de9193f99::error::liquidityInsufficientMinted());
        0x2::coin::mint<VAULT>(arg0, v1, arg5)
    }

    public fun new_vault<T0, T1>(arg0: &0x732ef956d38c32fb7dff4b1c0decbcf4599c18e998e67bfbb0ecf00de9193f99::app::AdminCap, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : (Vault<T0, T1>, VaultCap) {
        let v0 = Vault<T0, T1>{
            id                                     : 0x2::object::new(arg2),
            type_x                                 : 0x1::type_name::get<T0>(),
            type_y                                 : 0x1::type_name::get<T1>(),
            balance_x                              : 0x2::balance::zero<T0>(),
            balance_y                              : 0x2::balance::zero<T1>(),
            maker_fees_X                           : 0x2::balance::zero<T0>(),
            maker_fees_Y                           : 0x2::balance::zero<T1>(),
            deposit_requests_keys                  : 0x1::vector::empty<address>(),
            deposit_requests                       : 0x2::table::new<address, DepositRequest<T1>>(arg2),
            withdraw_requests_keys                 : 0x1::vector::empty<address>(),
            withdraw_requests                      : 0x2::table::new<address, WithdrawRequest<T0, T1>>(arg2),
            whitelisted_addresses                  : 0x1::vector::empty<address>(),
            deepbook_account_cap                   : 0xdee9::clob_v2::create_account(arg2),
            claimable_withdrawals                  : 0x2::table::new<address, ClaimableWithdrawals<T0, T1>>(arg2),
            last_processed_timestamp               : 0x2::clock::timestamp_ms(arg1),
            epoch_counter                          : 0,
            strategy_state                         : 0x732ef956d38c32fb7dff4b1c0decbcf4599c18e998e67bfbb0ecf00de9193f99::constants::strategy_active(),
            total_unprocessed_usdc_deposits        : 0,
            total_unprocessed_lp_token_withdrawals : 0,
        };
        let v1 = VaultCap{
            id       : 0x2::object::new(arg2),
            vault_id : 0x2::object::id<Vault<T0, T1>>(&v0),
        };
        (v0, v1)
    }

    public fun pause_strategy_and_mark_ready_for_deposit_processing<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut 0xdee9::clob_v2::Pool<T0, T1>) {
        let v0 = 0x732ef956d38c32fb7dff4b1c0decbcf4599c18e998e67bfbb0ecf00de9193f99::constants::strategy_active();
        assert!(&arg0.strategy_state == &v0, 0x732ef956d38c32fb7dff4b1c0decbcf4599c18e998e67bfbb0ecf00de9193f99::error::strategy_not_active());
        let v1 = get_account_cap<T0, T1>(arg0);
        let v2 = 0xdee9::clob_v2::list_open_orders<T0, T1>(arg1, v1);
        if (0x1::vector::length<0xdee9::clob_v2::Order>(&v2) > 0) {
            0xdee9::clob_v2::cancel_all_orders<T0, T1>(arg1, v1);
        };
        arg0.strategy_state = 0x732ef956d38c32fb7dff4b1c0decbcf4599c18e998e67bfbb0ecf00de9193f99::constants::strategy_paused_and_ready_for_deposit_processing();
    }

    public fun process_deposits<T0, T1>(arg0: &VaultCap, arg1: &mut Vault<T0, T1>, arg2: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg3: &mut 0x2::coin::TreasuryCap<VAULT>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(get_vault_id_from_vault_cap(arg0) == get_vault_id_from_vault<T0, T1>(arg1), 0x732ef956d38c32fb7dff4b1c0decbcf4599c18e998e67bfbb0ecf00de9193f99::error::invalid_vault_cap());
        let v0 = 0x732ef956d38c32fb7dff4b1c0decbcf4599c18e998e67bfbb0ecf00de9193f99::constants::strategy_paused_and_ready_for_deposit_processing();
        assert!(&arg1.strategy_state == &v0, 0x732ef956d38c32fb7dff4b1c0decbcf4599c18e998e67bfbb0ecf00de9193f99::error::strategy_not_ready_for_deposit_processing());
        assert!(is_address_whitelisted_for_trading<T0, T1>(arg1, 0x2::tx_context::sender(arg5)), 0x732ef956d38c32fb7dff4b1c0decbcf4599c18e998e67bfbb0ecf00de9193f99::error::address_not_whitelisted());
        let v1 = &arg1.deepbook_account_cap;
        let (v2, v3, v4, v5) = get_deepbook_account_assets<T0, T1>(arg1, arg2);
        assert!(v3 == 0, 0x732ef956d38c32fb7dff4b1c0decbcf4599c18e998e67bfbb0ecf00de9193f99::error::locked_base_asset_found());
        assert!(v5 == 0, 0x732ef956d38c32fb7dff4b1c0decbcf4599c18e998e67bfbb0ecf00de9193f99::error::locked_quote_asset_found());
        let (_, _, v8) = get_deepbook_price<T0, T1>(arg2);
        let v9 = v2;
        let v10 = v4;
        let v11 = 0;
        while (v11 < 80 || 0x1::vector::length<address>(&arg1.deposit_requests_keys) > 0) {
            let DepositRequest {
                amount : v12,
                owner  : v13,
            } = 0x2::table::remove<address, DepositRequest<T1>>(&mut arg1.deposit_requests, 0x1::vector::pop_back<address>(&mut arg1.deposit_requests_keys));
            let v14 = v12;
            let v15 = 0x2::balance::value<T1>(&v14);
            let v16 = if (v4 == 0) {
                0x732ef956d38c32fb7dff4b1c0decbcf4599c18e998e67bfbb0ecf00de9193f99::safe_math::safe_mul_div_u64(v15, 1, 2)
            } else {
                0x732ef956d38c32fb7dff4b1c0decbcf4599c18e998e67bfbb0ecf00de9193f99::safe_math::safe_mul_div_u64(v15, v2, 1000 * v4 + v2)
            };
            let v17 = 0x732ef956d38c32fb7dff4b1c0decbcf4599c18e998e67bfbb0ecf00de9193f99::safe_math::safe_mul_div_u64(v16, v8, 1000000) * 1000;
            let (v18, v19) = 0xdee9::clob_v2::place_market_order<T0, T1>(arg2, v1, 1, v17 - v17 % 100000000, true, 0x2::coin::zero<T0>(arg5), 0x2::coin::from_balance<T1>(v14, arg5), arg4, arg5);
            let v20 = v19;
            let v21 = v18;
            let v22 = v9 + 0x2::coin::value<T0>(&v21);
            v9 = v22;
            let v23 = v10 + 0x2::coin::value<T1>(&v20);
            v10 = v23;
            0xdee9::clob_v2::deposit_base<T0, T1>(arg2, v21, v1);
            0xdee9::clob_v2::deposit_quote<T0, T1>(arg2, v20, v1);
            0x2::transfer::public_transfer<0x2::coin::Coin<VAULT>>(mint_lp_token(arg3, v22, v23, 0x2::coin::value<T0>(&v21), 0x2::coin::value<T1>(&v20), arg5), v13);
            arg1.total_unprocessed_usdc_deposits = arg1.total_unprocessed_usdc_deposits - v15;
            v11 = v11 + 1;
        };
    }

    public fun process_withdrawals<T0, T1>(arg0: &VaultCap, arg1: &mut Vault<T0, T1>, arg2: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg3: &mut 0x2::coin::TreasuryCap<VAULT>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(get_vault_id_from_vault_cap(arg0) == get_vault_id_from_vault<T0, T1>(arg1), 0x732ef956d38c32fb7dff4b1c0decbcf4599c18e998e67bfbb0ecf00de9193f99::error::invalid_vault_cap());
        let v0 = 0x732ef956d38c32fb7dff4b1c0decbcf4599c18e998e67bfbb0ecf00de9193f99::constants::strategy_paused_and_ready_for_withdrawal_processing();
        assert!(&arg1.strategy_state == &v0, 0x732ef956d38c32fb7dff4b1c0decbcf4599c18e998e67bfbb0ecf00de9193f99::error::strategy_not_ready_for_withdrawal_processing());
        assert!(is_address_whitelisted_for_trading<T0, T1>(arg1, 0x2::tx_context::sender(arg4)), 0x732ef956d38c32fb7dff4b1c0decbcf4599c18e998e67bfbb0ecf00de9193f99::error::address_not_whitelisted());
        let v1 = &arg1.deepbook_account_cap;
        let v2 = 0;
        while (v2 < 80 || 0x1::vector::length<address>(&arg1.withdraw_requests_keys) > 0) {
            let WithdrawRequest {
                lp_token : v3,
                owner    : v4,
            } = 0x2::table::remove<address, WithdrawRequest<T0, T1>>(&mut arg1.withdraw_requests, 0x1::vector::pop_back<address>(&mut arg1.withdraw_requests_keys));
            let v5 = v3;
            let v6 = 0x2::coin::value<VAULT>(&v5);
            let (v7, v8) = calculate_lp_token_share<T0, T1>(arg1, arg2, arg3, v6);
            0x2::coin::burn<VAULT>(arg3, v5);
            let v9 = ClaimableWithdrawals<T0, T1>{
                balance_base  : 0x2::coin::into_balance<T0>(0xdee9::clob_v2::withdraw_base<T0, T1>(arg2, v7, v1, arg4)),
                balance_quote : 0x2::coin::into_balance<T1>(0xdee9::clob_v2::withdraw_quote<T0, T1>(arg2, v8, v1, arg4)),
                owner         : v4,
            };
            0x2::table::add<address, ClaimableWithdrawals<T0, T1>>(&mut arg1.claimable_withdrawals, v4, v9);
            arg1.total_unprocessed_lp_token_withdrawals = arg1.total_unprocessed_lp_token_withdrawals - v6;
            v2 = v2 + 1;
        };
    }

    public fun revoke_trading_permission<T0, T1>(arg0: &VaultCap, arg1: &mut Vault<T0, T1>, arg2: address) {
        assert!(get_vault_id_from_vault_cap(arg0) == get_vault_id_from_vault<T0, T1>(arg1), 0x732ef956d38c32fb7dff4b1c0decbcf4599c18e998e67bfbb0ecf00de9193f99::error::invalid_vault_cap());
        let (v0, v1) = 0x1::vector::index_of<address>(&arg1.whitelisted_addresses, &arg2);
        assert!(v0, 0x732ef956d38c32fb7dff4b1c0decbcf4599c18e998e67bfbb0ecf00de9193f99::error::address_not_whitelisted());
        0x1::vector::remove<address>(&mut arg1.whitelisted_addresses, v1);
    }

    public fun start_strategy<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x2::clock::Clock) {
        let v0 = 0x732ef956d38c32fb7dff4b1c0decbcf4599c18e998e67bfbb0ecf00de9193f99::constants::strategy_paused_and_ready_to_start();
        assert!(&arg0.strategy_state == &v0, 0x732ef956d38c32fb7dff4b1c0decbcf4599c18e998e67bfbb0ecf00de9193f99::error::strategy_not_ready_to_make_active());
        arg0.strategy_state = 0x732ef956d38c32fb7dff4b1c0decbcf4599c18e998e67bfbb0ecf00de9193f99::constants::strategy_active();
        arg0.epoch_counter = arg0.epoch_counter + 1;
        arg0.last_processed_timestamp = 0x2::clock::timestamp_ms(arg1);
    }

    public fun whitelist_address_for_trading<T0, T1>(arg0: &VaultCap, arg1: &mut Vault<T0, T1>, arg2: address) {
        assert!(get_vault_id_from_vault_cap(arg0) == get_vault_id_from_vault<T0, T1>(arg1), 0x732ef956d38c32fb7dff4b1c0decbcf4599c18e998e67bfbb0ecf00de9193f99::error::invalid_vault_cap());
        0x1::vector::push_back<address>(&mut arg1.whitelisted_addresses, arg2);
    }

    // decompiled from Move bytecode v6
}

