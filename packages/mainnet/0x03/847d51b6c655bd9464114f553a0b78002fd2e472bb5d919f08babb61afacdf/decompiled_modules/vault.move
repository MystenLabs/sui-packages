module 0x3847d51b6c655bd9464114f553a0b78002fd2e472bb5d919f08babb61afacdf::vault {
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
        withdraw_queue: WithdrawQueue<T2>,
        whitelisted_addresses: vector<address>,
        deepbook_account_cap: 0xdee9::custodian_v2::AccountCap,
        claimable_withdrawals: 0x2::table::Table<address, ClaimableWithdrawals<T0, T1>>,
        last_epoch_timestamp: u64,
        epoch_counter: u64,
        state: u8,
        pool_id: 0x2::object::ID,
        swap_routes: 0x2::bag::Bag,
        min_deposit_amount: u64,
        withdraw_fee_percent: u64,
        seed_balance: 0x2::balance::Balance<T2>,
        fees_x: 0x2::balance::Balance<T0>,
        fees_y: 0x2::balance::Balance<T1>,
    }

    struct VaultCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    public(friend) fun add_swap_route<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        assert!(!0x2::bag::contains<0x1::ascii::String>(&arg0.swap_routes, v0), 0x3847d51b6c655bd9464114f553a0b78002fd2e472bb5d919f08babb61afacdf::error::invalid_route());
        let v1 = SwapRoute{route: arg1};
        0x2::bag::add<0x1::ascii::String, SwapRoute>(&mut arg0.swap_routes, v0, v1);
    }

    public(friend) fun add_withdraw_request<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: 0x2::coin::Coin<T2>, arg2: address, arg3: u8) {
        let v0 = 0x3847d51b6c655bd9464114f553a0b78002fd2e472bb5d919f08babb61afacdf::constants::strategy_active();
        assert!(&arg0.state == &v0, 0x3847d51b6c655bd9464114f553a0b78002fd2e472bb5d919f08babb61afacdf::error::strategy_not_active());
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

    public(friend) fun assert_address_whitelisted<T0, T1, T2>(arg0: &Vault<T0, T1, T2>, arg1: &0x2::tx_context::TxContext) {
        assert!(is_address_whitelisted_for_trading<T0, T1, T2>(arg0, 0x2::tx_context::sender(arg1)), 0x3847d51b6c655bd9464114f553a0b78002fd2e472bb5d919f08babb61afacdf::error::address_not_whitelisted());
    }

    public(friend) fun assert_vault_state_is_active<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) {
        let v0 = 0x3847d51b6c655bd9464114f553a0b78002fd2e472bb5d919f08babb61afacdf::constants::strategy_active();
        assert!(&arg0.state == &v0, 0x3847d51b6c655bd9464114f553a0b78002fd2e472bb5d919f08babb61afacdf::error::strategy_not_active());
    }

    public fun calculate_lp_token_share<T0, T1, T2>(arg0: &Vault<T0, T1, T2>, arg1: &0xdee9::clob_v2::Pool<T0, T1>, arg2: u64) : (u64, u64) {
        is_pool_and_vault_compatible<T0, T1, T2>(arg1, arg0);
        let (v0, v1, v2, v3) = get_deepbook_account_assets<T0, T1, T2>(arg0, arg1);
        let v4 = 0x2::coin::total_supply<T2>(&arg0.treasury_cap);
        assert!(v4 > 0, 0x3847d51b6c655bd9464114f553a0b78002fd2e472bb5d919f08babb61afacdf::error::invalidLPToken());
        (0x3847d51b6c655bd9464114f553a0b78002fd2e472bb5d919f08babb61afacdf::safe_math::safe_mul_div_u64(v0 + v1, arg2, v4), 0x3847d51b6c655bd9464114f553a0b78002fd2e472bb5d919f08babb61afacdf::safe_math::safe_mul_div_u64(v2 + v3, arg2, v4))
    }

    public(friend) fun check_vault_cap_compatibility<T0, T1, T2>(arg0: &VaultCap, arg1: &Vault<T0, T1, T2>) {
        assert!(get_vault_id_from_vault_cap(arg0) == get_vault_id_from_vault<T0, T1, T2>(arg1), 0x3847d51b6c655bd9464114f553a0b78002fd2e472bb5d919f08babb61afacdf::error::invalid_vault_cap());
    }

    public(friend) fun claim_withdrawal<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(0x2::table::contains<address, ClaimableWithdrawals<T0, T1>>(&arg0.claimable_withdrawals, arg1), 0x3847d51b6c655bd9464114f553a0b78002fd2e472bb5d919f08babb61afacdf::error::claim_does_not_exist());
        let ClaimableWithdrawals {
            balance_base  : v0,
            balance_quote : v1,
            owner         : _,
        } = 0x2::table::remove<address, ClaimableWithdrawals<T0, T1>>(&mut arg0.claimable_withdrawals, arg1);
        (0x2::coin::from_balance<T0>(v0, arg2), 0x2::coin::from_balance<T1>(v1, arg2))
    }

    public(friend) fun deposit<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: u128, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let v0 = &arg0.deepbook_account_cap;
        let (v1, v2, v3, v4) = get_deepbook_account_assets<T0, T1, T2>(arg0, arg1);
        let (v5, v6) = 0x3847d51b6c655bd9464114f553a0b78002fd2e472bb5d919f08babb61afacdf::cetus_swap::swap<T1, T0>(arg4, arg3, arg2, 0x2::coin::zero<T0>(arg7), true, true, 0x3847d51b6c655bd9464114f553a0b78002fd2e472bb5d919f08babb61afacdf::process_deposit_helper::get_amount_to_swap<T0, T1>(0x2::coin::value<T1>(&arg2), v1 + v2, v3 + v4, arg3), arg5, arg6, arg7);
        let v7 = v6;
        let v8 = v5;
        0xdee9::clob_v2::deposit_base<T0, T1>(arg1, v7, v0);
        0xdee9::clob_v2::deposit_quote<T0, T1>(arg1, v8, v0);
        let v9 = &mut arg0.treasury_cap;
        mint_lp_token<T2>(v9, v1 + v2, v3 + v4, 0x2::coin::value<T0>(&v7), 0x2::coin::value<T1>(&v8), arg7)
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
        assert!(0x2::bag::contains<0x1::ascii::String>(&arg0.swap_routes, v0), 0x3847d51b6c655bd9464114f553a0b78002fd2e472bb5d919f08babb61afacdf::error::invalid_route());
        0x2::bag::borrow<0x1::ascii::String, SwapRoute>(&arg0.swap_routes, v0).route
    }

    public fun get_unprocessed_withdrawals<T0, T1, T2>(arg0: &Vault<T0, T1, T2>, arg1: &0xdee9::clob_v2::Pool<T0, T1>) : (u64, u64, u64) {
        let v0 = arg0.withdraw_queue.unprocessed_amount;
        let (v1, v2) = calculate_lp_token_share<T0, T1, T2>(arg0, arg1, v0);
        (v0, v1, v2)
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

    public fun get_withdraw_fee_percent<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : u64 {
        arg0.withdraw_fee_percent
    }

    public(friend) fun is_address_whitelisted_for_trading<T0, T1, T2>(arg0: &Vault<T0, T1, T2>, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.whitelisted_addresses, &arg1)
    }

    public(friend) fun is_pool_and_vault_compatible<T0, T1, T2>(arg0: &0xdee9::clob_v2::Pool<T0, T1>, arg1: &Vault<T0, T1, T2>) {
        assert!(0x2::object::id<0xdee9::clob_v2::Pool<T0, T1>>(arg0) == arg1.pool_id, 0x3847d51b6c655bd9464114f553a0b78002fd2e472bb5d919f08babb61afacdf::error::invalid_pool());
    }

    public(friend) fun mark_state_as_ready_for_withdrawal_processing<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: &0x2::tx_context::TxContext) {
        assert_address_whitelisted<T0, T1, T2>(arg0, arg1);
        let v0 = 0x3847d51b6c655bd9464114f553a0b78002fd2e472bb5d919f08babb61afacdf::constants::strategy_active();
        assert!(&arg0.state == &v0, 0x3847d51b6c655bd9464114f553a0b78002fd2e472bb5d919f08babb61afacdf::error::strategy_not_ready_for_withdrawal_processing());
        arg0.state = 0x3847d51b6c655bd9464114f553a0b78002fd2e472bb5d919f08babb61afacdf::constants::strategy_paused_and_ready_for_withdrawal_processing();
    }

    fun mint_lp_token<T0>(arg0: &mut 0x2::coin::TreasuryCap<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::total_supply<T0>(arg0);
        let v1 = if (v0 == 0) {
            let v2 = (0x2::math::sqrt_u128((arg3 as u128) * (arg4 as u128)) as u64);
            assert!(v2 > 0x3847d51b6c655bd9464114f553a0b78002fd2e472bb5d919f08babb61afacdf::constants::minimal_liquidity(), 0x3847d51b6c655bd9464114f553a0b78002fd2e472bb5d919f08babb61afacdf::error::notEnoughInitialLiquidity());
            v2
        } else if (arg1 == 0) {
            0x3847d51b6c655bd9464114f553a0b78002fd2e472bb5d919f08babb61afacdf::safe_math::safe_mul_div_u64(arg4, v0, arg2)
        } else if (arg2 == 0) {
            0x3847d51b6c655bd9464114f553a0b78002fd2e472bb5d919f08babb61afacdf::safe_math::safe_mul_div_u64(arg3, v0, arg1)
        } else {
            0x2::math::min(0x3847d51b6c655bd9464114f553a0b78002fd2e472bb5d919f08babb61afacdf::safe_math::safe_mul_div_u64(arg3, v0, arg1), 0x3847d51b6c655bd9464114f553a0b78002fd2e472bb5d919f08babb61afacdf::safe_math::safe_mul_div_u64(arg4, v0, arg2))
        };
        assert!(v1 > 0, 0x3847d51b6c655bd9464114f553a0b78002fd2e472bb5d919f08babb61afacdf::error::liquidityInsufficientMinted());
        0x2::coin::mint<T0>(arg0, v1, arg5)
    }

    public(friend) fun new_vault<T0, T1, T2>(arg0: &0x3847d51b6c655bd9464114f553a0b78002fd2e472bb5d919f08babb61afacdf::app::AdminCap, arg1: 0x2::coin::TreasuryCap<T2>, arg2: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<T1>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, VaultCap) {
        assert!(0x2::coin::total_supply<T2>(&arg1) == 0, 0x3847d51b6c655bd9464114f553a0b78002fd2e472bb5d919f08babb61afacdf::error::vault_coin_supply_not_zero());
        let v0 = WithdrawQueue<T2>{
            requests           : 0x2::linked_table::new<address, WithdrawRequest<T2>>(arg7),
            unprocessed_amount : 0,
            pending_requests   : 0,
        };
        let v1 = Vault<T0, T1, T2>{
            id                    : 0x2::object::new(arg7),
            type_x                : 0x1::type_name::get<T0>(),
            type_y                : 0x1::type_name::get<T1>(),
            treasury_cap          : arg1,
            withdraw_queue        : v0,
            whitelisted_addresses : 0x1::vector::empty<address>(),
            deepbook_account_cap  : 0xdee9::clob_v2::create_account(arg7),
            claimable_withdrawals : 0x2::table::new<address, ClaimableWithdrawals<T0, T1>>(arg7),
            last_epoch_timestamp  : 0x2::clock::timestamp_ms(arg6),
            epoch_counter         : 0,
            state                 : 0x3847d51b6c655bd9464114f553a0b78002fd2e472bb5d919f08babb61afacdf::constants::strategy_active(),
            pool_id               : 0x2::object::id<0xdee9::clob_v2::Pool<T0, T1>>(arg2),
            swap_routes           : 0x2::bag::new(arg7),
            min_deposit_amount    : 10000000,
            withdraw_fee_percent  : 10000,
            seed_balance          : 0x2::balance::zero<T2>(),
            fees_x                : 0x2::balance::zero<T0>(),
            fees_y                : 0x2::balance::zero<T1>(),
        };
        let v2 = VaultCap{
            id       : 0x2::object::new(arg7),
            vault_id : 0x2::object::id<Vault<T0, T1, T2>>(&v1),
        };
        let v3 = &mut v1;
        seed_vault<T0, T1, T2>(v3, arg2, arg3, arg4, arg5, arg7);
        0x2::transfer::share_object<Vault<T0, T1, T2>>(v1);
        (0x2::object::id<Vault<T0, T1, T2>>(&v1), v2)
    }

    public(friend) fun process_withdrawals<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x3847d51b6c655bd9464114f553a0b78002fd2e472bb5d919f08babb61afacdf::constants::strategy_paused_and_ready_for_withdrawal_processing();
        assert!(&arg0.state == &v0, 0x3847d51b6c655bd9464114f553a0b78002fd2e472bb5d919f08babb61afacdf::error::strategy_not_ready_for_withdrawal_processing());
        let v1 = 0xdee9::clob_v2::list_open_orders<T0, T1>(arg1, get_account_cap<T0, T1, T2>(arg0));
        assert!(0x1::vector::length<0xdee9::clob_v2::Order>(&v1) == 0, 0x3847d51b6c655bd9464114f553a0b78002fd2e472bb5d919f08babb61afacdf::error::open_order_exists());
        is_pool_and_vault_compatible<T0, T1, T2>(arg1, arg0);
        let v2 = get_withdraw_fee_percent<T0, T1, T2>(arg0);
        let v3 = &arg0.deepbook_account_cap;
        let v4 = 0;
        let v5 = &mut arg0.withdraw_queue;
        while (v4 < arg2 && 0x2::linked_table::length<address, WithdrawRequest<T2>>(&v5.requests) > 0) {
            let (_, v7) = 0x2::linked_table::pop_front<address, WithdrawRequest<T2>>(&mut v5.requests);
            let WithdrawRequest {
                lp_token     : v8,
                owner        : v9,
                request_type : _,
            } = v7;
            let v11 = v8;
            let v12 = 0x2::coin::value<T2>(&v11);
            let (v13, _, v15, _) = 0xdee9::clob_v2::account_balance<T0, T1>(arg1, &arg0.deepbook_account_cap);
            let v17 = 0x2::coin::total_supply<T2>(&arg0.treasury_cap);
            0x2::coin::burn<T2>(&mut arg0.treasury_cap, v11);
            let v18 = 0xdee9::clob_v2::withdraw_base<T0, T1>(arg1, 0x3847d51b6c655bd9464114f553a0b78002fd2e472bb5d919f08babb61afacdf::safe_math::safe_mul_div_u64(v13, v12, v17), v3, arg4);
            let v19 = 0xdee9::clob_v2::withdraw_quote<T0, T1>(arg1, 0x3847d51b6c655bd9464114f553a0b78002fd2e472bb5d919f08babb61afacdf::safe_math::safe_mul_div_u64(v15, v12, v17), v3, arg4);
            0x2::balance::join<T0>(&mut arg0.fees_x, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v18, 0x3847d51b6c655bd9464114f553a0b78002fd2e472bb5d919f08babb61afacdf::safe_math::safe_mul_div_u64(0x2::coin::value<T0>(&v18), v2, 0x3847d51b6c655bd9464114f553a0b78002fd2e472bb5d919f08babb61afacdf::constants::withdraw_fee_scaling_factor()), arg4)));
            0x2::balance::join<T1>(&mut arg0.fees_y, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v19, 0x3847d51b6c655bd9464114f553a0b78002fd2e472bb5d919f08babb61afacdf::safe_math::safe_mul_div_u64(0x2::coin::value<T1>(&v19), v2, 0x3847d51b6c655bd9464114f553a0b78002fd2e472bb5d919f08babb61afacdf::constants::withdraw_fee_scaling_factor()), arg4)));
            if (0x2::table::contains<address, ClaimableWithdrawals<T0, T1>>(&arg0.claimable_withdrawals, v9)) {
                let v20 = 0x2::table::borrow_mut<address, ClaimableWithdrawals<T0, T1>>(&mut arg0.claimable_withdrawals, v9);
                0x2::balance::join<T0>(&mut v20.balance_base, 0x2::coin::into_balance<T0>(v18));
                0x2::balance::join<T1>(&mut v20.balance_quote, 0x2::coin::into_balance<T1>(v19));
            } else {
                let v21 = ClaimableWithdrawals<T0, T1>{
                    balance_base  : 0x2::coin::into_balance<T0>(v18),
                    balance_quote : 0x2::coin::into_balance<T1>(v19),
                    owner         : v9,
                };
                0x2::table::add<address, ClaimableWithdrawals<T0, T1>>(&mut arg0.claimable_withdrawals, v9, v21);
            };
            v5.unprocessed_amount = v5.unprocessed_amount - v12;
            v5.pending_requests = v5.pending_requests - 1;
            v4 = v4 + 1;
        };
        if (v5.pending_requests == 0) {
            start_strategy<T0, T1, T2>(arg0, arg3, arg4);
        };
    }

    public(friend) fun remove_swap_route<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        assert!(0x2::bag::contains<0x1::ascii::String>(&arg0.swap_routes, v0), 0x3847d51b6c655bd9464114f553a0b78002fd2e472bb5d919f08babb61afacdf::error::invalid_route());
        let SwapRoute { route: v1 } = 0x2::bag::remove<0x1::ascii::String, SwapRoute>(&mut arg0.swap_routes, v0);
        while (!0x1::vector::is_empty<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&v1)) {
            let (_, _) = 0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::unwrap(0x1::vector::pop_back<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&mut v1));
        };
        0x1::vector::destroy_empty<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(v1);
    }

    public(friend) fun revoke_trading_permission<T0, T1, T2>(arg0: &VaultCap, arg1: &mut Vault<T0, T1, T2>, arg2: address) {
        check_vault_cap_compatibility<T0, T1, T2>(arg0, arg1);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg1.whitelisted_addresses, &arg2);
        assert!(v0, 0x3847d51b6c655bd9464114f553a0b78002fd2e472bb5d919f08babb61afacdf::error::address_not_whitelisted());
        0x1::vector::remove<address>(&mut arg1.whitelisted_addresses, v1);
    }

    public(friend) fun seed_vault<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<T2>(&arg0.seed_balance) == 0, 0x3847d51b6c655bd9464114f553a0b78002fd2e472bb5d919f08babb61afacdf::error::vault_already_seeded());
        is_pool_and_vault_compatible<T0, T1, T2>(arg1, arg0);
        assert!(arg4 > 0, 0x3847d51b6c655bd9464114f553a0b78002fd2e472bb5d919f08babb61afacdf::error::invalid_lp_tokens_to_mint());
        assert!(0x2::balance::value<T0>(&arg2) > 0, 0x3847d51b6c655bd9464114f553a0b78002fd2e472bb5d919f08babb61afacdf::error::too_less_deposit_to_seed());
        assert!(0x2::balance::value<T1>(&arg3) > 0, 0x3847d51b6c655bd9464114f553a0b78002fd2e472bb5d919f08babb61afacdf::error::too_less_deposit_to_seed());
        let v0 = &arg0.deepbook_account_cap;
        0xdee9::clob_v2::deposit_base<T0, T1>(arg1, 0x2::coin::from_balance<T0>(arg2, arg5), v0);
        0xdee9::clob_v2::deposit_quote<T0, T1>(arg1, 0x2::coin::from_balance<T1>(arg3, arg5), v0);
        0x2::balance::join<T2>(&mut arg0.seed_balance, 0x2::coin::into_balance<T2>(0x2::coin::mint<T2>(&mut arg0.treasury_cap, arg4, arg5)));
    }

    public(friend) fun start_strategy<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert_address_whitelisted<T0, T1, T2>(arg0, arg2);
        let v0 = &arg0.withdraw_queue;
        let v1 = 0x3847d51b6c655bd9464114f553a0b78002fd2e472bb5d919f08babb61afacdf::constants::strategy_paused_and_ready_for_withdrawal_processing();
        assert!(&arg0.state == &v1 && v0.pending_requests == 0, 0x3847d51b6c655bd9464114f553a0b78002fd2e472bb5d919f08babb61afacdf::error::strategy_not_ready_to_make_active());
        arg0.state = 0x3847d51b6c655bd9464114f553a0b78002fd2e472bb5d919f08babb61afacdf::constants::strategy_active();
        arg0.epoch_counter = arg0.epoch_counter + 1;
        arg0.last_epoch_timestamp = 0x2::clock::timestamp_ms(arg1);
    }

    public(friend) fun whitelist_address_for_trading<T0, T1, T2>(arg0: &VaultCap, arg1: &mut Vault<T0, T1, T2>, arg2: address) {
        check_vault_cap_compatibility<T0, T1, T2>(arg0, arg1);
        0x1::vector::push_back<address>(&mut arg1.whitelisted_addresses, arg2);
    }

    public entry fun withdraw_all_funds<T0, T1, T2>(arg0: &0x3847d51b6c655bd9464114f553a0b78002fd2e472bb5d919f08babb61afacdf::app::AdminCap, arg1: &mut Vault<T0, T1, T2>, arg2: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = &arg1.deepbook_account_cap;
        let (v1, _, v3, _) = get_deepbook_account_assets<T0, T1, T2>(arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0xdee9::clob_v2::withdraw_base<T0, T1>(arg2, v1, v0, arg3), 0x2::tx_context::sender(arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0xdee9::clob_v2::withdraw_quote<T0, T1>(arg2, v3, v0, arg3), 0x2::tx_context::sender(arg3));
    }

    public(friend) fun withdraw_fees<T0, T1, T2>(arg0: &VaultCap, arg1: &mut Vault<T0, T1, T2>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        check_vault_cap_compatibility<T0, T1, T2>(arg0, arg1);
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.fees_x, 0x2::balance::value<T0>(&arg1.fees_x)), arg2), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1.fees_y, 0x2::balance::value<T1>(&arg1.fees_y)), arg2))
    }

    // decompiled from Move bytecode v6
}

