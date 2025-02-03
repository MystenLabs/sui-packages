module 0x8c6e5d67f9d33484ce6f09a8f158cc11b5b0d1387187958ea6579be6a4039086::vault {
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

    struct DepositRequest has store {
        amount: u64,
        owner: address,
        request_type: u8,
        deposit_token: u64,
    }

    struct DepositQueue<phantom T0, phantom T1> has store {
        requests: 0x2::linked_table::LinkedTable<address, DepositRequest>,
        pending_requests: u64,
        total_balance: 0x2::balance::Balance<T0>,
        total_deposit_tokens: u64,
        undistributed_lp_tokens: 0x2::balance::Balance<T1>,
    }

    struct WithdrawQueue<phantom T0> has store {
        requests: 0x2::linked_table::LinkedTable<address, WithdrawRequest<T0>>,
        unprocessed_amount: u64,
        pending_requests: u64,
    }

    struct SwapRoute has store {
        route: vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>,
    }

    struct Vault<phantom T0, phantom T1, phantom T2> has key {
        id: 0x2::object::UID,
        type_x: 0x1::type_name::TypeName,
        type_y: 0x1::type_name::TypeName,
        treasury_cap: 0x2::coin::TreasuryCap<T2>,
        deposit_queue: DepositQueue<T1, T2>,
        withdraw_queue: WithdrawQueue<T2>,
        whitelisted_addresses: vector<address>,
        deepbook_account_cap: 0xdee9::custodian_v2::AccountCap,
        claimable_withdrawals: 0x2::table::Table<address, ClaimableWithdrawals<T0, T1>>,
        last_epoch_timestamp: u64,
        epoch_counter: u64,
        state: u8,
        pool_id: 0x2::object::ID,
        swap_routes: 0x2::bag::Bag,
        seed_balance: 0x2::balance::Balance<T2>,
    }

    struct VaultCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    public(friend) fun add_deposit_request<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: 0x2::balance::Balance<T1>, arg2: address, arg3: u8) {
        assert!(0x2::balance::value<T2>(&arg0.seed_balance) > 0, 0x8c6e5d67f9d33484ce6f09a8f158cc11b5b0d1387187958ea6579be6a4039086::error::vault_not_seeded());
        let v0 = 0x8c6e5d67f9d33484ce6f09a8f158cc11b5b0d1387187958ea6579be6a4039086::constants::strategy_active();
        assert!(&arg0.state == &v0, 0x8c6e5d67f9d33484ce6f09a8f158cc11b5b0d1387187958ea6579be6a4039086::error::strategy_not_active());
        let v1 = 0x2::balance::value<T1>(&arg1);
        let v2 = &mut arg0.deposit_queue;
        v2.pending_requests = v2.pending_requests + 1;
        v2.total_deposit_tokens = v2.total_deposit_tokens + v1;
        0x2::balance::join<T1>(&mut v2.total_balance, arg1);
        if (0x2::linked_table::contains<address, DepositRequest>(&v2.requests, arg2)) {
            let v3 = 0x2::linked_table::borrow_mut<address, DepositRequest>(&mut v2.requests, arg2);
            v3.amount = v3.amount + v1;
            v3.deposit_token = v3.deposit_token + v1;
        } else {
            let v4 = DepositRequest{
                amount        : v1,
                owner         : arg2,
                request_type  : arg3,
                deposit_token : v1,
            };
            0x2::linked_table::push_back<address, DepositRequest>(&mut v2.requests, arg2, v4);
        };
    }

    public(friend) fun add_swap_route<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        assert!(!0x2::bag::contains<0x1::ascii::String>(&arg0.swap_routes, v0), 0x8c6e5d67f9d33484ce6f09a8f158cc11b5b0d1387187958ea6579be6a4039086::error::invalid_route());
        let v1 = SwapRoute{route: arg1};
        0x2::bag::add<0x1::ascii::String, SwapRoute>(&mut arg0.swap_routes, v0, v1);
    }

    public(friend) fun add_withdraw_request<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: 0x2::coin::Coin<T2>, arg2: address, arg3: u8) {
        let v0 = 0x8c6e5d67f9d33484ce6f09a8f158cc11b5b0d1387187958ea6579be6a4039086::constants::strategy_active();
        assert!(&arg0.state == &v0, 0x8c6e5d67f9d33484ce6f09a8f158cc11b5b0d1387187958ea6579be6a4039086::error::strategy_not_active());
        let v1 = &mut arg0.withdraw_queue;
        v1.unprocessed_amount = v1.unprocessed_amount + 0x2::coin::value<T2>(&arg1);
        v1.pending_requests = v1.pending_requests + 1;
        if (0x2::linked_table::contains<address, WithdrawRequest<T2>>(&v1.requests, arg2)) {
            0x2::coin::join<T2>(&mut 0x2::linked_table::borrow_mut<address, WithdrawRequest<T2>>(&mut v1.requests, arg2).lp_token, arg1);
        } else {
            let v2 = WithdrawRequest<T2>{
                lp_token     : arg1,
                owner        : arg2,
                request_type : arg3,
            };
            0x2::linked_table::push_back<address, WithdrawRequest<T2>>(&mut v1.requests, arg2, v2);
        };
    }

    public(friend) fun assert_vault_state_is_active<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) {
        let v0 = 0x8c6e5d67f9d33484ce6f09a8f158cc11b5b0d1387187958ea6579be6a4039086::constants::strategy_active();
        assert!(&arg0.state == &v0, 0x8c6e5d67f9d33484ce6f09a8f158cc11b5b0d1387187958ea6579be6a4039086::error::strategy_not_active());
    }

    public fun calculate_lp_token_share<T0, T1, T2>(arg0: &Vault<T0, T1, T2>, arg1: &0xdee9::clob_v2::Pool<T0, T1>, arg2: u64) : (u64, u64) {
        let (v0, v1, v2, v3) = get_deepbook_account_assets<T0, T1, T2>(arg0, arg1);
        let v4 = 0x2::coin::total_supply<T2>(&arg0.treasury_cap);
        assert!(v4 > 0, 0x8c6e5d67f9d33484ce6f09a8f158cc11b5b0d1387187958ea6579be6a4039086::error::invalidLPToken());
        ((v0 + v1) * arg2 / v4, (v2 + v3) * arg2 / v4)
    }

    public(friend) fun check_vault_cap_compatibility<T0, T1, T2>(arg0: &VaultCap, arg1: &Vault<T0, T1, T2>) {
        assert!(get_vault_id_from_vault_cap(arg0) == get_vault_id_from_vault<T0, T1, T2>(arg1), 0x8c6e5d67f9d33484ce6f09a8f158cc11b5b0d1387187958ea6579be6a4039086::error::invalid_vault_cap());
    }

    public(friend) fun claim_withdrawal<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(0x2::table::contains<address, ClaimableWithdrawals<T0, T1>>(&arg0.claimable_withdrawals, arg1), 0x8c6e5d67f9d33484ce6f09a8f158cc11b5b0d1387187958ea6579be6a4039086::error::claim_does_not_exist());
        let ClaimableWithdrawals {
            balance_base  : v0,
            balance_quote : v1,
            owner         : _,
        } = 0x2::table::remove<address, ClaimableWithdrawals<T0, T1>>(&mut arg0.claimable_withdrawals, arg1);
        (0x2::coin::from_balance<T0>(v0, arg2), 0x2::coin::from_balance<T1>(v1, arg2))
    }

    public(friend) fun consume_receipt_and_deposit_assets<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg2: 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt, arg3: &0x8c6e5d67f9d33484ce6f09a8f158cc11b5b0d1387187958ea6579be6a4039086::vault_acl::VaultAcl, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = &arg0.deepbook_account_cap;
        let v1 = 0x8c6e5d67f9d33484ce6f09a8f158cc11b5b0d1387187958ea6579be6a4039086::process_deposit_helper::consume_swap_receipt<T0>(arg2, arg3);
        let (v2, _, v4, _) = get_deepbook_account_assets<T0, T1, T2>(arg0, arg1);
        let v6 = &mut arg0.treasury_cap;
        let v7 = &mut arg0.deposit_queue;
        let v8 = mint_lp_token<T2>(v6, v2, v4, 0x2::coin::value<T0>(&v1), 0x2::balance::value<T1>(&v7.total_balance), arg4);
        0x2::balance::join<T2>(&mut v7.undistributed_lp_tokens, 0x2::coin::into_balance<T2>(v8));
        0xdee9::clob_v2::deposit_base<T0, T1>(arg1, v1, v0);
        0xdee9::clob_v2::deposit_quote<T0, T1>(arg1, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v7.total_balance, 0x2::balance::value<T1>(&v7.total_balance)), arg4), v0);
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

    public fun get_deepbook_account_assets<T0, T1, T2>(arg0: &Vault<T0, T1, T2>, arg1: &0xdee9::clob_v2::Pool<T0, T1>) : (u64, u64, u64, u64) {
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
        arg0.deposit_queue.pending_requests
    }

    public fun get_number_of_unprocessed_withdrawals<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : u64 {
        arg0.withdraw_queue.pending_requests
    }

    public fun get_seed_lp_amount<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : u64 {
        0x2::balance::value<T2>(&arg0.seed_balance)
    }

    public fun get_strategy_state<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : u8 {
        arg0.state
    }

    public fun get_swap_route<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value> {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        assert!(0x2::bag::contains<0x1::ascii::String>(&arg0.swap_routes, v0), 0x8c6e5d67f9d33484ce6f09a8f158cc11b5b0d1387187958ea6579be6a4039086::error::invalid_route());
        0x2::bag::borrow<0x1::ascii::String, SwapRoute>(&arg0.swap_routes, v0).route
    }

    public fun get_unprocessed_deposits<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : u64 {
        0x2::balance::value<T1>(&arg0.deposit_queue.total_balance)
    }

    public fun get_unprocessed_withdrawals<T0, T1, T2>(arg0: &Vault<T0, T1, T2>, arg1: &0xdee9::clob_v2::Pool<T0, T1>) : (u64, u64, u64) {
        let v0 = arg0.withdraw_queue.unprocessed_amount;
        let (v1, v2) = calculate_lp_token_share<T0, T1, T2>(arg0, arg1, v0);
        (v0, v1, v2)
    }

    public fun get_user_unprocessed_deposits<T0, T1, T2>(arg0: &Vault<T0, T1, T2>, arg1: address) : u64 {
        let v0 = &arg0.deposit_queue;
        if (0x2::linked_table::contains<address, DepositRequest>(&v0.requests, arg1)) {
            0x2::linked_table::borrow<address, DepositRequest>(&v0.requests, arg1).amount
        } else {
            0
        }
    }

    public fun get_user_unprocessed_withdrawals<T0, T1, T2>(arg0: &Vault<T0, T1, T2>, arg1: &0xdee9::clob_v2::Pool<T0, T1>, arg2: address) : (u64, u64, u64) {
        let v0 = &arg0.withdraw_queue;
        if (0x2::linked_table::contains<address, WithdrawRequest<T2>>(&v0.requests, arg2)) {
            let v4 = 0x2::coin::value<T2>(&0x2::linked_table::borrow<address, WithdrawRequest<T2>>(&v0.requests, arg2).lp_token);
            let (v5, v6) = calculate_lp_token_share<T0, T1, T2>(arg0, arg1, v4);
            (v4, v5, v6)
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

    public(friend) fun mark_state_as_ready_for_withdrawal_processing<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: &0x2::tx_context::TxContext) {
        assert!(is_address_whitelisted_for_trading<T0, T1, T2>(arg0, 0x2::tx_context::sender(arg1)), 0x8c6e5d67f9d33484ce6f09a8f158cc11b5b0d1387187958ea6579be6a4039086::error::address_not_whitelisted());
        let v0 = &arg0.deposit_queue;
        let v1 = 0x8c6e5d67f9d33484ce6f09a8f158cc11b5b0d1387187958ea6579be6a4039086::constants::strategy_paused_and_ready_for_deposit_processing();
        assert!(&arg0.state == &v1 && v0.pending_requests == 0, 0x8c6e5d67f9d33484ce6f09a8f158cc11b5b0d1387187958ea6579be6a4039086::error::strategy_not_ready_for_withdrawal_processing());
        arg0.state = 0x8c6e5d67f9d33484ce6f09a8f158cc11b5b0d1387187958ea6579be6a4039086::constants::strategy_paused_and_ready_for_withdrawal_processing();
    }

    fun mint_lp_token<T0>(arg0: &mut 0x2::coin::TreasuryCap<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::total_supply<T0>(arg0);
        let v1 = if (v0 == 0) {
            let v2 = (0x2::math::sqrt_u128((arg3 as u128) * (arg4 as u128)) as u64);
            assert!(v2 > 0x8c6e5d67f9d33484ce6f09a8f158cc11b5b0d1387187958ea6579be6a4039086::constants::minimal_liquidity(), 0x8c6e5d67f9d33484ce6f09a8f158cc11b5b0d1387187958ea6579be6a4039086::error::notEnoughInitialLiquidity());
            v2
        } else {
            0x2::math::min(0x8c6e5d67f9d33484ce6f09a8f158cc11b5b0d1387187958ea6579be6a4039086::safe_math::safe_mul_div_u64(arg3, v0, arg1), 0x8c6e5d67f9d33484ce6f09a8f158cc11b5b0d1387187958ea6579be6a4039086::safe_math::safe_mul_div_u64(arg4, v0, arg2))
        };
        assert!(v1 > 0, 0x8c6e5d67f9d33484ce6f09a8f158cc11b5b0d1387187958ea6579be6a4039086::error::liquidityInsufficientMinted());
        0x2::coin::mint<T0>(arg0, v1, arg5)
    }

    public(friend) fun new_vault<T0, T1, T2>(arg0: &0x8c6e5d67f9d33484ce6f09a8f158cc11b5b0d1387187958ea6579be6a4039086::app::AdminCap, arg1: 0x2::coin::TreasuryCap<T2>, arg2: &0xdee9::clob_v2::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, VaultCap) {
        let v0 = DepositQueue<T1, T2>{
            requests                : 0x2::linked_table::new<address, DepositRequest>(arg4),
            pending_requests        : 0,
            total_balance           : 0x2::balance::zero<T1>(),
            total_deposit_tokens    : 0,
            undistributed_lp_tokens : 0x2::balance::zero<T2>(),
        };
        let v1 = WithdrawQueue<T2>{
            requests           : 0x2::linked_table::new<address, WithdrawRequest<T2>>(arg4),
            unprocessed_amount : 0,
            pending_requests   : 0,
        };
        let v2 = Vault<T0, T1, T2>{
            id                    : 0x2::object::new(arg4),
            type_x                : 0x1::type_name::get<T0>(),
            type_y                : 0x1::type_name::get<T1>(),
            treasury_cap          : arg1,
            deposit_queue         : v0,
            withdraw_queue        : v1,
            whitelisted_addresses : 0x1::vector::empty<address>(),
            deepbook_account_cap  : 0xdee9::clob_v2::create_account(arg4),
            claimable_withdrawals : 0x2::table::new<address, ClaimableWithdrawals<T0, T1>>(arg4),
            last_epoch_timestamp  : 0x2::clock::timestamp_ms(arg3),
            epoch_counter         : 0,
            state                 : 0x8c6e5d67f9d33484ce6f09a8f158cc11b5b0d1387187958ea6579be6a4039086::constants::strategy_active(),
            pool_id               : 0x2::object::id<0xdee9::clob_v2::Pool<T0, T1>>(arg2),
            swap_routes           : 0x2::bag::new(arg4),
            seed_balance          : 0x2::balance::zero<T2>(),
        };
        let v3 = VaultCap{
            id       : 0x2::object::new(arg4),
            vault_id : 0x2::object::id<Vault<T0, T1, T2>>(&v2),
        };
        0x2::transfer::share_object<Vault<T0, T1, T2>>(v2);
        (0x2::object::id<Vault<T0, T1, T2>>(&v2), v3)
    }

    public(friend) fun pause_strategy_and_mark_ready_for_deposit_processing<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg2: &0x2::tx_context::TxContext) {
        assert!(is_address_whitelisted_for_trading<T0, T1, T2>(arg0, 0x2::tx_context::sender(arg2)), 0x8c6e5d67f9d33484ce6f09a8f158cc11b5b0d1387187958ea6579be6a4039086::error::address_not_whitelisted());
        let v0 = 0x8c6e5d67f9d33484ce6f09a8f158cc11b5b0d1387187958ea6579be6a4039086::constants::strategy_active();
        assert!(&arg0.state == &v0, 0x8c6e5d67f9d33484ce6f09a8f158cc11b5b0d1387187958ea6579be6a4039086::error::strategy_not_active());
        assert!(0x2::object::id<0xdee9::clob_v2::Pool<T0, T1>>(arg1) == arg0.pool_id, 0x8c6e5d67f9d33484ce6f09a8f158cc11b5b0d1387187958ea6579be6a4039086::error::invalid_pool());
        let v1 = get_account_cap<T0, T1, T2>(arg0);
        let v2 = 0xdee9::clob_v2::list_open_orders<T0, T1>(arg1, v1);
        if (0x1::vector::length<0xdee9::clob_v2::Order>(&v2) > 0) {
            0xdee9::clob_v2::cancel_all_orders<T0, T1>(arg1, v1);
        };
        arg0.state = 0x8c6e5d67f9d33484ce6f09a8f158cc11b5b0d1387187958ea6579be6a4039086::constants::strategy_paused_and_ready_for_deposit_processing();
    }

    public fun process_deposited_balance<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &0x8c6e5d67f9d33484ce6f09a8f158cc11b5b0d1387187958ea6579be6a4039086::vault_acl::VaultAcl, arg4: &0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::acl::RouterAcl, arg5: &mut 0x2::tx_context::TxContext) : 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt {
        let v0 = 0x8c6e5d67f9d33484ce6f09a8f158cc11b5b0d1387187958ea6579be6a4039086::constants::strategy_paused_and_ready_for_deposit_processing();
        assert!(&arg0.state == &v0, 0x8c6e5d67f9d33484ce6f09a8f158cc11b5b0d1387187958ea6579be6a4039086::error::strategy_not_ready_for_deposit_processing());
        assert!(0x2::object::id<0xdee9::clob_v2::Pool<T0, T1>>(arg1) == arg0.pool_id, 0x8c6e5d67f9d33484ce6f09a8f158cc11b5b0d1387187958ea6579be6a4039086::error::invalid_pool());
        let (v1, v2, v3, v4) = get_deepbook_account_assets<T0, T1, T2>(arg0, arg1);
        assert!(v2 == 0, 0x8c6e5d67f9d33484ce6f09a8f158cc11b5b0d1387187958ea6579be6a4039086::error::locked_base_asset_found());
        assert!(v4 == 0, 0x8c6e5d67f9d33484ce6f09a8f158cc11b5b0d1387187958ea6579be6a4039086::error::locked_quote_asset_found());
        let v5 = &mut arg0.deposit_queue;
        0x8c6e5d67f9d33484ce6f09a8f158cc11b5b0d1387187958ea6579be6a4039086::process_deposit_helper::issue_swap_receipt<T1>(arg3, arg4, get_swap_route<T0, T1, T2>(arg0), 0x2::balance::split<T1>(&mut v5.total_balance, 0x8c6e5d67f9d33484ce6f09a8f158cc11b5b0d1387187958ea6579be6a4039086::process_deposit_helper::get_amount_to_swap<T0, T1>(0x2::balance::value<T1>(&v5.total_balance), v1, v3, arg2)), arg5)
    }

    public(friend) fun process_undistributed_lp_tokens<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: &0x8c6e5d67f9d33484ce6f09a8f158cc11b5b0d1387187958ea6579be6a4039086::vault_acl::VaultAcl, arg2: &0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::acl::RouterAcl, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x8c6e5d67f9d33484ce6f09a8f158cc11b5b0d1387187958ea6579be6a4039086::constants::strategy_paused_and_ready_for_deposit_processing();
        assert!(&arg0.state == &v0, 0x8c6e5d67f9d33484ce6f09a8f158cc11b5b0d1387187958ea6579be6a4039086::error::strategy_not_ready_for_deposit_processing());
        let v1 = 0;
        let v2 = &mut arg0.deposit_queue;
        let v3 = &mut v2.undistributed_lp_tokens;
        let v4 = 0x2::balance::value<T2>(v3);
        while (v1 < arg3 && 0x2::linked_table::length<address, DepositRequest>(&v2.requests) > 0) {
            let (_, v6) = 0x2::linked_table::pop_front<address, DepositRequest>(&mut v2.requests);
            let DepositRequest {
                amount        : _,
                owner         : v8,
                request_type  : _,
                deposit_token : v10,
            } = v6;
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(0x2::balance::split<T2>(v3, 0x8c6e5d67f9d33484ce6f09a8f158cc11b5b0d1387187958ea6579be6a4039086::safe_math::safe_mul_div_u64(v4, v10, v2.total_deposit_tokens)), arg4), v8);
            v2.pending_requests = v2.pending_requests - 1;
            v1 = v1 + 1;
        };
        v2.total_deposit_tokens = 0;
        if (v2.pending_requests == 0) {
            mark_state_as_ready_for_withdrawal_processing<T0, T1, T2>(arg0, arg4);
        };
    }

    public(friend) fun process_withdrawals<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x8c6e5d67f9d33484ce6f09a8f158cc11b5b0d1387187958ea6579be6a4039086::constants::strategy_paused_and_ready_for_withdrawal_processing();
        assert!(&arg0.state == &v0, 0x8c6e5d67f9d33484ce6f09a8f158cc11b5b0d1387187958ea6579be6a4039086::error::strategy_not_ready_for_withdrawal_processing());
        assert!(0x2::object::id<0xdee9::clob_v2::Pool<T0, T1>>(arg1) == arg0.pool_id, 0x8c6e5d67f9d33484ce6f09a8f158cc11b5b0d1387187958ea6579be6a4039086::error::invalid_pool());
        let v1 = &arg0.deepbook_account_cap;
        let v2 = 0;
        let v3 = &mut arg0.withdraw_queue;
        while (v2 < arg2 && 0x2::linked_table::length<address, WithdrawRequest<T2>>(&v3.requests) > 0) {
            let (_, v5) = 0x2::linked_table::pop_front<address, WithdrawRequest<T2>>(&mut v3.requests);
            let WithdrawRequest {
                lp_token     : v6,
                owner        : v7,
                request_type : _,
            } = v5;
            let v9 = v6;
            let v10 = 0x2::coin::value<T2>(&v9);
            let (v11, _, v13, _) = 0xdee9::clob_v2::account_balance<T0, T1>(arg1, &arg0.deepbook_account_cap);
            let v15 = 0x2::coin::total_supply<T2>(&arg0.treasury_cap);
            0x2::coin::burn<T2>(&mut arg0.treasury_cap, v9);
            if (0x2::table::contains<address, ClaimableWithdrawals<T0, T1>>(&arg0.claimable_withdrawals, v7)) {
                let v16 = 0x2::table::borrow_mut<address, ClaimableWithdrawals<T0, T1>>(&mut arg0.claimable_withdrawals, v7);
                0x2::balance::join<T0>(&mut v16.balance_base, 0x2::coin::into_balance<T0>(0xdee9::clob_v2::withdraw_base<T0, T1>(arg1, v11 * v10 / v15, v1, arg4)));
                0x2::balance::join<T1>(&mut v16.balance_quote, 0x2::coin::into_balance<T1>(0xdee9::clob_v2::withdraw_quote<T0, T1>(arg1, v13 * v10 / v15, v1, arg4)));
            } else {
                let v17 = ClaimableWithdrawals<T0, T1>{
                    balance_base  : 0x2::coin::into_balance<T0>(0xdee9::clob_v2::withdraw_base<T0, T1>(arg1, v11 * v10 / v15, v1, arg4)),
                    balance_quote : 0x2::coin::into_balance<T1>(0xdee9::clob_v2::withdraw_quote<T0, T1>(arg1, v13 * v10 / v15, v1, arg4)),
                    owner         : v7,
                };
                0x2::table::add<address, ClaimableWithdrawals<T0, T1>>(&mut arg0.claimable_withdrawals, v7, v17);
            };
            v3.unprocessed_amount = v3.unprocessed_amount - v10;
            v3.pending_requests = v3.pending_requests - 1;
            v2 = v2 + 1;
        };
        if (v3.pending_requests == 0) {
            start_strategy<T0, T1, T2>(arg0, arg3, arg4);
        };
    }

    public(friend) fun remove_swap_route<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        assert!(0x2::bag::contains<0x1::ascii::String>(&arg0.swap_routes, v0), 0x8c6e5d67f9d33484ce6f09a8f158cc11b5b0d1387187958ea6579be6a4039086::error::invalid_route());
        let SwapRoute { route: v1 } = 0x2::bag::remove<0x1::ascii::String, SwapRoute>(&mut arg0.swap_routes, v0);
        while (!0x1::vector::is_empty<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&v1)) {
            let (_, _) = 0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::unwrap(0x1::vector::pop_back<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&mut v1));
        };
        0x1::vector::destroy_empty<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(v1);
    }

    public(friend) fun revoke_trading_permission<T0, T1, T2>(arg0: &VaultCap, arg1: &mut Vault<T0, T1, T2>, arg2: address) {
        check_vault_cap_compatibility<T0, T1, T2>(arg0, arg1);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg1.whitelisted_addresses, &arg2);
        assert!(v0, 0x8c6e5d67f9d33484ce6f09a8f158cc11b5b0d1387187958ea6579be6a4039086::error::address_not_whitelisted());
        0x1::vector::remove<address>(&mut arg1.whitelisted_addresses, v1);
    }

    public(friend) fun seed_vault<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<T2>(&arg0.seed_balance) == 0, 0x8c6e5d67f9d33484ce6f09a8f158cc11b5b0d1387187958ea6579be6a4039086::error::vault_already_seeded());
        assert!(0x2::object::id<0xdee9::clob_v2::Pool<T0, T1>>(arg1) == arg0.pool_id, 0x8c6e5d67f9d33484ce6f09a8f158cc11b5b0d1387187958ea6579be6a4039086::error::invalid_pool());
        assert!(arg4 > 0, 0x8c6e5d67f9d33484ce6f09a8f158cc11b5b0d1387187958ea6579be6a4039086::error::invalid_lp_tokens_to_mint());
        assert!(0x2::balance::value<T0>(&arg2) > 0, 0x8c6e5d67f9d33484ce6f09a8f158cc11b5b0d1387187958ea6579be6a4039086::error::too_less_deposit_to_seed());
        assert!(0x2::balance::value<T1>(&arg3) > 0, 0x8c6e5d67f9d33484ce6f09a8f158cc11b5b0d1387187958ea6579be6a4039086::error::too_less_deposit_to_seed());
        let v0 = &arg0.deepbook_account_cap;
        0xdee9::clob_v2::deposit_base<T0, T1>(arg1, 0x2::coin::from_balance<T0>(arg2, arg5), v0);
        0xdee9::clob_v2::deposit_quote<T0, T1>(arg1, 0x2::coin::from_balance<T1>(arg3, arg5), v0);
        0x2::balance::join<T2>(&mut arg0.seed_balance, 0x2::coin::into_balance<T2>(0x2::coin::mint<T2>(&mut arg0.treasury_cap, arg4, arg5)));
    }

    public(friend) fun start_strategy<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(is_address_whitelisted_for_trading<T0, T1, T2>(arg0, 0x2::tx_context::sender(arg2)), 0x8c6e5d67f9d33484ce6f09a8f158cc11b5b0d1387187958ea6579be6a4039086::error::address_not_whitelisted());
        let v0 = &arg0.withdraw_queue;
        let v1 = 0x8c6e5d67f9d33484ce6f09a8f158cc11b5b0d1387187958ea6579be6a4039086::constants::strategy_paused_and_ready_for_withdrawal_processing();
        assert!(&arg0.state == &v1 && v0.pending_requests == 0, 0x8c6e5d67f9d33484ce6f09a8f158cc11b5b0d1387187958ea6579be6a4039086::error::strategy_not_ready_to_make_active());
        arg0.state = 0x8c6e5d67f9d33484ce6f09a8f158cc11b5b0d1387187958ea6579be6a4039086::constants::strategy_active();
        arg0.epoch_counter = arg0.epoch_counter + 1;
        arg0.last_epoch_timestamp = 0x2::clock::timestamp_ms(arg1);
    }

    public(friend) fun whitelist_address_for_trading<T0, T1, T2>(arg0: &VaultCap, arg1: &mut Vault<T0, T1, T2>, arg2: address) {
        check_vault_cap_compatibility<T0, T1, T2>(arg0, arg1);
        0x1::vector::push_back<address>(&mut arg1.whitelisted_addresses, arg2);
    }

    public entry fun withdraw_all_funds<T0, T1, T2>(arg0: &0x8c6e5d67f9d33484ce6f09a8f158cc11b5b0d1387187958ea6579be6a4039086::app::AdminCap, arg1: &mut Vault<T0, T1, T2>, arg2: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = &arg1.deepbook_account_cap;
        let v1 = &mut arg1.deposit_queue;
        let v2 = 0x2::balance::split<T1>(&mut v1.total_balance, 0x2::balance::value<T1>(&v1.total_balance));
        let (v3, _, v5, _) = get_deepbook_account_assets<T0, T1, T2>(arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v2, arg3), 0x2::tx_context::sender(arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0xdee9::clob_v2::withdraw_base<T0, T1>(arg2, v3, v0, arg3), 0x2::tx_context::sender(arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0xdee9::clob_v2::withdraw_quote<T0, T1>(arg2, v5, v0, arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

