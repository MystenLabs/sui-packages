module 0xc56a55893f4791d03726f9c109725765b584c06eb5625704ce782112d763ef99::ember_market_vault {
    struct EmberMarketVault<phantom T0: drop, phantom T1: drop, phantom T2: drop, phantom T3: drop, phantom T4: drop> has key {
        id: 0x2::object::UID,
        market_id: 0x2::object::ID,
        ember_vault_id: 0x2::object::ID,
        receipt_balance: 0x2::balance::Balance<T1>,
        updated_at: u64,
        withdraw_window_ms: u64,
        withdraw_bps_per_window: u64,
        withdraw_window_start_ms: u64,
        withdraw_window_base_reserve: u64,
        withdraw_window_withdrawn: u128,
        withdraw_window_minted: u128,
        queued_receipt: u64,
        next_withdraw_request_id: u64,
        withdraw_queue: 0x337f85b36287d38cdf2bb60964187f432dd3abeb5228f8a2db4cff7a9f47a87d::linked_table::LinkedTable<u64, WithdrawRequest<T0, T1, T2, T3, T4>>,
    }

    struct WithdrawRequest<phantom T0: drop, phantom T1: drop, phantom T2: drop, phantom T3: drop, phantom T4: drop> has store {
        request_id: u64,
        vault_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        ember_vault_id: 0x2::object::ID,
        owner: address,
        receipt_amount: u64,
        created_at: u64,
        sy_balance: 0x2::balance::Balance<T2>,
    }

    struct MarketVaultCreatedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        ember_vault_id: 0x2::object::ID,
        created_by: address,
    }

    struct DepositEvent has copy, drop {
        market_id: 0x2::object::ID,
        ember_vault_id: 0x2::object::ID,
        underlying_value_in: u64,
        receipt_shares_in: u64,
        receipt_change_out: u64,
        depositor: address,
    }

    struct RedeemEvent has copy, drop {
        market_id: 0x2::object::ID,
        ember_vault_id: 0x2::object::ID,
        underlying_value_out: u64,
        receipt_shares_out: u64,
        redeemer: address,
    }

    struct WithdrawCircuitBreakerUpdatedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        withdraw_window_ms: u64,
        withdraw_bps_per_window: u64,
        window_start_ms: u64,
        window_base_reserve: u64,
        updater: address,
    }

    struct WithdrawCircuitBreakerRefreshedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        withdraw_window_ms: u64,
        withdraw_bps_per_window: u64,
        window_start_ms: u64,
        window_base_reserve: u64,
        refresher: address,
    }

    struct WithdrawWindowRolledEvent has copy, drop {
        vault_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        window_start_ms: u64,
        window_base_reserve: u64,
    }

    struct WithdrawQueuedEvent has copy, drop {
        request_id: u64,
        vault_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        ember_vault_id: 0x2::object::ID,
        owner: address,
        receipt_amount: u64,
        created_at: u64,
    }

    struct WithdrawCancelledEvent has copy, drop {
        request_id: u64,
        vault_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        ember_vault_id: 0x2::object::ID,
        owner: address,
        receipt_amount: u64,
        sy_amount: u64,
        cancelled_at: u64,
    }

    struct WithdrawCompletedEvent has copy, drop {
        request_id: u64,
        vault_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        ember_vault_id: 0x2::object::ID,
        owner: address,
        receipt_amount: u64,
        completed_at: u64,
        operator: address,
    }

    struct WithdrawRejectedEvent has copy, drop {
        request_id: u64,
        vault_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        ember_vault_id: 0x2::object::ID,
        owner: address,
        receipt_amount: u64,
        sy_amount: u64,
        rejected_at: u64,
        operator: address,
    }

    struct ReceiptRedeemedEvent has copy, drop {
        market_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        receipt_amount: u64,
        redeemer: address,
    }

    public(friend) fun assert_ember_vault_match<T0: drop, T1: drop, T2: drop, T3: drop, T4: drop>(arg0: &EmberMarketVault<T0, T1, T2, T3, T4>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T0, T1>) {
        assert!(arg0.ember_vault_id == 0x2::object::id<0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T0, T1>>(arg1), 1004);
    }

    fun assert_market_active<T0: drop, T1: drop, T2: drop, T3: drop, T4: drop>(arg0: &EmberMarketVault<T0, T1, T2, T3, T4>, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig) {
        0xc56a55893f4791d03726f9c109725765b584c06eb5625704ce782112d763ef99::package_version::assert_current(arg1);
        0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::assert_target_active<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::package_version::PackageMarker>(arg1, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::package_version::version(), b"market", arg0.market_id, 1019);
    }

    fun assert_market_match<T0: drop, T1: drop, T2: drop, T3: drop, T4: drop>(arg0: &EmberMarketVault<T0, T1, T2, T3, T4>, arg1: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T2, T3, T4>) {
        assert!(arg0.market_id == 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T2, T3, T4>(arg1), 1002);
    }

    fun assert_request_matches_vault<T0: drop, T1: drop, T2: drop, T3: drop, T4: drop>(arg0: &EmberMarketVault<T0, T1, T2, T3, T4>, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID) {
        assert!(arg1 == 0x2::object::id<EmberMarketVault<T0, T1, T2, T3, T4>>(arg0), 1010);
        assert!(arg2 == arg0.market_id, 1010);
        assert!(arg3 == arg0.ember_vault_id, 1010);
    }

    fun assert_unqueued_reserve_available<T0: drop, T1: drop, T2: drop, T3: drop, T4: drop>(arg0: &EmberMarketVault<T0, T1, T2, T3, T4>, arg1: u64) {
        let v0 = 0x2::balance::value<T1>(&arg0.receipt_balance);
        assert!(v0 >= arg0.queued_receipt, 1017);
        assert!(arg1 <= v0 - arg0.queued_receipt, 1017);
    }

    fun assert_withdraw_circuit_breaker_config(arg0: u64, arg1: u64) {
        assert!(arg0 > 0, 1007);
        assert!(arg1 > 0 && arg1 <= 10000, 1008);
    }

    fun borrow_withdraw_request<T0: drop, T1: drop, T2: drop, T3: drop, T4: drop>(arg0: &EmberMarketVault<T0, T1, T2, T3, T4>, arg1: u64) : &WithdrawRequest<T0, T1, T2, T3, T4> {
        assert!(0x337f85b36287d38cdf2bb60964187f432dd3abeb5228f8a2db4cff7a9f47a87d::linked_table::contains<u64, WithdrawRequest<T0, T1, T2, T3, T4>>(&arg0.withdraw_queue, arg1), 1015);
        0x337f85b36287d38cdf2bb60964187f432dd3abeb5228f8a2db4cff7a9f47a87d::linked_table::borrow<u64, WithdrawRequest<T0, T1, T2, T3, T4>>(&arg0.withdraw_queue, arg1)
    }

    public fun cancel_queued_redeem<T0: drop, T1: drop, T2: drop, T3: drop, T4: drop>(arg0: u64, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &mut EmberMarketVault<T0, T1, T2, T3, T4>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        assert_market_active<T0, T1, T2, T3, T4>(arg2, arg1);
        let v0 = take_withdraw_request<T0, T1, T2, T3, T4>(arg2, arg0);
        let WithdrawRequest {
            request_id     : v1,
            vault_id       : v2,
            market_id      : v3,
            ember_vault_id : v4,
            owner          : v5,
            receipt_amount : v6,
            created_at     : _,
            sy_balance     : v8,
        } = v0;
        let v9 = v8;
        assert!(v1 == arg0, 1010);
        assert_request_matches_vault<T0, T1, T2, T3, T4>(arg2, v2, v3, v4);
        assert!(v5 == 0x2::tx_context::sender(arg4), 1011);
        assert!(arg2.queued_receipt >= v6, 1012);
        arg2.queued_receipt = arg2.queued_receipt - v6;
        let v10 = 0x2::clock::timestamp_ms(arg3);
        arg2.updated_at = v10;
        let v11 = WithdrawCancelledEvent{
            request_id     : arg0,
            vault_id       : v2,
            market_id      : v3,
            ember_vault_id : v4,
            owner          : v5,
            receipt_amount : v6,
            sy_amount      : 0x2::balance::value<T2>(&v9),
            cancelled_at   : v10,
        };
        0x2::event::emit<WithdrawCancelledEvent>(v11);
        0x2::coin::from_balance<T2>(v9, arg4)
    }

    fun checked_add_u64(arg0: u64, arg1: u64) : u64 {
        let v0 = (arg0 as u128) + (arg1 as u128);
        assert!(v0 <= 18446744073709551615, 13906839427088383999);
        (v0 as u64)
    }

    fun complete_queued_redeem<T0: drop, T1: drop, T2: drop, T3: drop, T4: drop>(arg0: u64, arg1: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::sy::SyState, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg3: &mut EmberMarketVault<T0, T1, T2, T3, T4>, arg4: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T2, T3, T4>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_market_active<T0, T1, T2, T3, T4>(arg3, arg2);
        assert_market_match<T0, T1, T2, T3, T4>(arg3, arg4);
        let v0 = take_withdraw_request<T0, T1, T2, T3, T4>(arg3, arg0);
        let WithdrawRequest {
            request_id     : v1,
            vault_id       : v2,
            market_id      : v3,
            ember_vault_id : v4,
            owner          : v5,
            receipt_amount : v6,
            created_at     : _,
            sy_balance     : v8,
        } = v0;
        assert!(v1 == arg0, 1010);
        assert_request_matches_vault<T0, T1, T2, T3, T4>(arg3, v2, v3, v4);
        assert!(arg3.queued_receipt >= v6, 1012);
        arg3.queued_receipt = arg3.queued_receipt - v6;
        arg3.updated_at = 0x2::clock::timestamp_ms(arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg3.receipt_balance, v6), arg6), v5);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::sy::burn_escrowed_sy_market_state<T2, T0, T3, T4, 0xc56a55893f4791d03726f9c109725765b584c06eb5625704ce782112d763ef99::sign::EMBER>(0x2::coin::from_balance<T2>(v8, arg6), 0xc56a55893f4791d03726f9c109725765b584c06eb5625704ce782112d763ef99::sign::sign(), arg1, arg2, arg4, 0x2::object::id<EmberMarketVault<T0, T1, T2, T3, T4>>(arg3));
        let v9 = WithdrawCompletedEvent{
            request_id     : arg0,
            vault_id       : v2,
            market_id      : v3,
            ember_vault_id : v4,
            owner          : v5,
            receipt_amount : v6,
            completed_at   : arg3.updated_at,
            operator       : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<WithdrawCompletedEvent>(v9);
    }

    public fun complete_queued_redeem_by_ACL<T0: drop, T1: drop, T2: drop, T3: drop, T4: drop>(arg0: &0x413f0b727ca3a6fded067960c364d337ad57e284c96f3b21a922455627ca332b::acl::ACL, arg1: u64, arg2: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::sy::SyState, arg3: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg4: &mut EmberMarketVault<T0, T1, T2, T3, T4>, arg5: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T2, T3, T4>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x413f0b727ca3a6fded067960c364d337ad57e284c96f3b21a922455627ca332b::acl::assert_has_role(arg0, arg3, 0x2::tx_context::sender(arg7), 0x1::string::utf8(b"ember_adapter.complete_withdraw"));
        complete_queued_redeem<T0, T1, T2, T3, T4>(arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun complete_queued_redeem_by_admin<T0: drop, T1: drop, T2: drop, T3: drop, T4: drop>(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg1: u64, arg2: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::sy::SyState, arg3: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg4: &mut EmberMarketVault<T0, T1, T2, T3, T4>, arg5: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T2, T3, T4>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        complete_queued_redeem<T0, T1, T2, T3, T4>(arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    fun consume_withdraw_quota<T0: drop, T1: drop, T2: drop, T3: drop, T4: drop>(arg0: &mut EmberMarketVault<T0, T1, T2, T3, T4>, arg1: u64) {
        assert!(arg1 <= remaining_quota<T0, T1, T2, T3, T4>(arg0), 1009);
        arg0.withdraw_window_withdrawn = arg0.withdraw_window_withdrawn + (arg1 as u128);
    }

    fun create_market_vault<T0: drop, T1: drop, T2: drop, T3: drop, T4: drop>(arg0: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::sy::SyState, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T2, T3, T4>, arg3: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T0, T1>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xc56a55893f4791d03726f9c109725765b584c06eb5625704ce782112d763ef99::package_version::assert_current(arg1);
        assert_withdraw_circuit_breaker_config(arg4, arg5);
        0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::assert_target_active<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::package_version::PackageMarker>(arg1, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::package_version::version(), b"market", 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T2, T3, T4>(arg2), 1019);
        let v0 = 0x2::clock::timestamp_ms(arg6);
        let v1 = EmberMarketVault<T0, T1, T2, T3, T4>{
            id                           : 0x2::object::new(arg7),
            market_id                    : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T2, T3, T4>(arg2),
            ember_vault_id               : 0x2::object::id<0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T0, T1>>(arg3),
            receipt_balance              : 0x2::balance::zero<T1>(),
            updated_at                   : v0,
            withdraw_window_ms           : arg4,
            withdraw_bps_per_window      : arg5,
            withdraw_window_start_ms     : v0,
            withdraw_window_base_reserve : 0,
            withdraw_window_withdrawn    : 0,
            withdraw_window_minted       : 0,
            queued_receipt               : 0,
            next_withdraw_request_id     : 0,
            withdraw_queue               : 0x337f85b36287d38cdf2bb60964187f432dd3abeb5228f8a2db4cff7a9f47a87d::linked_table::new<u64, WithdrawRequest<T0, T1, T2, T3, T4>>(arg7),
        };
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::sy::bind_market_vault<T2, T0, 0xc56a55893f4791d03726f9c109725765b584c06eb5625704ce782112d763ef99::sign::EMBER>(arg0, arg1, 0xc56a55893f4791d03726f9c109725765b584c06eb5625704ce782112d763ef99::sign::sign(), v1.market_id, 0x2::object::id<EmberMarketVault<T0, T1, T2, T3, T4>>(&v1));
        let v2 = MarketVaultCreatedEvent{
            vault_id       : 0x2::object::id<EmberMarketVault<T0, T1, T2, T3, T4>>(&v1),
            market_id      : v1.market_id,
            ember_vault_id : v1.ember_vault_id,
            created_by     : 0x2::tx_context::sender(arg7),
        };
        0x2::event::emit<MarketVaultCreatedEvent>(v2);
        0x2::transfer::share_object<EmberMarketVault<T0, T1, T2, T3, T4>>(v1);
    }

    public fun create_market_vault_by_ACL<T0: drop, T1: drop, T2: drop, T3: drop, T4: drop>(arg0: &0x413f0b727ca3a6fded067960c364d337ad57e284c96f3b21a922455627ca332b::acl::ACL, arg1: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::sy::SyState, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg3: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T2, T3, T4>, arg4: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T0, T1>, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xc56a55893f4791d03726f9c109725765b584c06eb5625704ce782112d763ef99::package_version::assert_current(arg2);
        0x413f0b727ca3a6fded067960c364d337ad57e284c96f3b21a922455627ca332b::acl::assert_has_role(arg0, arg2, 0x2::tx_context::sender(arg8), 0x1::string::utf8(b"ember_adapter.create_market"));
        create_market_vault<T0, T1, T2, T3, T4>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public fun create_market_vault_by_admin<T0: drop, T1: drop, T2: drop, T3: drop, T4: drop>(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg1: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::sy::SyState, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg3: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T2, T3, T4>, arg4: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T0, T1>, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xc56a55893f4791d03726f9c109725765b584c06eb5625704ce782112d763ef99::package_version::assert_current(arg2);
        create_market_vault<T0, T1, T2, T3, T4>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public fun deposit<T0: drop, T1: drop, T2: drop, T3: drop, T4: drop>(arg0: 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::sy::MintSyRequest<T2>, arg1: 0x2::coin::Coin<T1>, arg2: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::sy::SyState, arg3: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg4: &mut EmberMarketVault<T0, T1, T2, T3, T4>, arg5: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T2, T3, T4>, arg6: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T0, T1>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_market_active<T0, T1, T2, T3, T4>(arg4, arg3);
        assert_market_match<T0, T1, T2, T3, T4>(arg4, arg5);
        assert!(0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::sy::get_mint_request_market_id<T2>(&arg0) == arg4.market_id, 1002);
        assert_ember_vault_match<T0, T1, T2, T3, T4>(arg4, arg6);
        let v0 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::sy::get_mint_request_sy_amount<T2>(&arg0);
        assert!(0x2::coin::value<T1>(&arg1) >= v0, 1003);
        let v1 = 0x2::clock::timestamp_ms(arg7);
        refresh_withdraw_window<T0, T1, T2, T3, T4>(arg4, v1);
        0x2::balance::join<T1>(&mut arg4.receipt_balance, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg1, v0, arg8)));
        arg4.withdraw_window_minted = arg4.withdraw_window_minted + (v0 as u128);
        arg4.updated_at = v1;
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::sy::destroy_mint_request<T2, T0, 0xc56a55893f4791d03726f9c109725765b584c06eb5625704ce782112d763ef99::sign::EMBER>(arg0, 0xc56a55893f4791d03726f9c109725765b584c06eb5625704ce782112d763ef99::sign::sign(), arg2, arg3, arg4.market_id, 0x2::object::id<EmberMarketVault<T0, T1, T2, T3, T4>>(arg4));
        let v2 = DepositEvent{
            market_id           : arg4.market_id,
            ember_vault_id      : arg4.ember_vault_id,
            underlying_value_in : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::sy::get_mint_request_amount<T2>(&arg0),
            receipt_shares_in   : v0,
            receipt_change_out  : 0x2::coin::value<T1>(&arg1),
            depositor           : 0x2::tx_context::sender(arg8),
        };
        0x2::event::emit<DepositEvent>(v2);
        arg1
    }

    public fun ember_vault_id<T0: drop, T1: drop, T2: drop, T3: drop, T4: drop>(arg0: &EmberMarketVault<T0, T1, T2, T3, T4>) : 0x2::object::ID {
        arg0.ember_vault_id
    }

    public fun market_id<T0: drop, T1: drop, T2: drop, T3: drop, T4: drop>(arg0: &EmberMarketVault<T0, T1, T2, T3, T4>) : 0x2::object::ID {
        arg0.market_id
    }

    public fun queue_redeem<T0: drop, T1: drop, T2: drop, T3: drop, T4: drop>(arg0: 0x2::coin::Coin<T2>, arg1: u64, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg3: &mut EmberMarketVault<T0, T1, T2, T3, T4>, arg4: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T2, T3, T4>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : u64 {
        0xc56a55893f4791d03726f9c109725765b584c06eb5625704ce782112d763ef99::package_version::assert_current(arg2);
        assert_market_match<T0, T1, T2, T3, T4>(arg3, arg4);
        0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::assert_target_active<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::package_version::PackageMarker>(arg2, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::package_version::version(), b"market", 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T2, T3, T4>(arg4), 1019);
        let v0 = 0x2::coin::value<T2>(&arg0);
        assert!(v0 > 0, 1018);
        assert!(v0 >= arg1, 1016);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        refresh_withdraw_window<T0, T1, T2, T3, T4>(arg3, v1);
        assert_unqueued_reserve_available<T0, T1, T2, T3, T4>(arg3, v0);
        arg3.queued_receipt = checked_add_u64(arg3.queued_receipt, v0);
        arg3.updated_at = v1;
        let v2 = arg3.next_withdraw_request_id;
        arg3.next_withdraw_request_id = checked_add_u64(arg3.next_withdraw_request_id, 1);
        let v3 = WithdrawRequest<T0, T1, T2, T3, T4>{
            request_id     : v2,
            vault_id       : 0x2::object::id<EmberMarketVault<T0, T1, T2, T3, T4>>(arg3),
            market_id      : arg3.market_id,
            ember_vault_id : arg3.ember_vault_id,
            owner          : 0x2::tx_context::sender(arg6),
            receipt_amount : v0,
            created_at     : v1,
            sy_balance     : 0x2::coin::into_balance<T2>(arg0),
        };
        0x337f85b36287d38cdf2bb60964187f432dd3abeb5228f8a2db4cff7a9f47a87d::linked_table::push_back<u64, WithdrawRequest<T0, T1, T2, T3, T4>>(&mut arg3.withdraw_queue, v2, v3);
        let v4 = WithdrawQueuedEvent{
            request_id     : v2,
            vault_id       : 0x2::object::id<EmberMarketVault<T0, T1, T2, T3, T4>>(arg3),
            market_id      : arg3.market_id,
            ember_vault_id : arg3.ember_vault_id,
            owner          : 0x2::tx_context::sender(arg6),
            receipt_amount : v0,
            created_at     : v1,
        };
        0x2::event::emit<WithdrawQueuedEvent>(v4);
        v2
    }

    public fun queued_receipt<T0: drop, T1: drop, T2: drop, T3: drop, T4: drop>(arg0: &EmberMarketVault<T0, T1, T2, T3, T4>) : u64 {
        arg0.queued_receipt
    }

    public fun receipt_balance<T0: drop, T1: drop, T2: drop, T3: drop, T4: drop>(arg0: &EmberMarketVault<T0, T1, T2, T3, T4>) : u64 {
        0x2::balance::value<T1>(&arg0.receipt_balance)
    }

    public fun redeem<T0: drop, T1: drop, T2: drop, T3: drop, T4: drop>(arg0: 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::sy::BurnSyRequest<T2>, arg1: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::sy::SyState, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg3: &mut EmberMarketVault<T0, T1, T2, T3, T4>, arg4: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T2, T3, T4>, arg5: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T0, T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xc56a55893f4791d03726f9c109725765b584c06eb5625704ce782112d763ef99::package_version::assert_current(arg2);
        assert_market_match<T0, T1, T2, T3, T4>(arg3, arg4);
        assert_ember_vault_match<T0, T1, T2, T3, T4>(arg3, arg5);
        assert!(0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::sy::get_burn_request_market_id<T2>(&arg0) == arg3.market_id, 1002);
        assert_market_active<T0, T1, T2, T3, T4>(arg3, arg2);
        let v0 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::sy::get_burn_request_sy_amount<T2>(&arg0);
        assert!(v0 > 0, 1018);
        refresh_withdraw_window<T0, T1, T2, T3, T4>(arg3, 0x2::clock::timestamp_ms(arg6));
        assert_unqueued_reserve_available<T0, T1, T2, T3, T4>(arg3, v0);
        consume_withdraw_quota<T0, T1, T2, T3, T4>(arg3, v0);
        arg3.updated_at = 0x2::clock::timestamp_ms(arg6);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::sy::destroy_burn_request<T2, T0, 0xc56a55893f4791d03726f9c109725765b584c06eb5625704ce782112d763ef99::sign::EMBER>(arg0, 0xc56a55893f4791d03726f9c109725765b584c06eb5625704ce782112d763ef99::sign::sign(), arg1, arg2, arg3.market_id, 0x2::object::id<EmberMarketVault<T0, T1, T2, T3, T4>>(arg3));
        let v1 = RedeemEvent{
            market_id            : arg3.market_id,
            ember_vault_id       : arg3.ember_vault_id,
            underlying_value_out : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::sy::get_burn_request_amount<T2>(&arg0),
            receipt_shares_out   : v0,
            redeemer             : 0x2::tx_context::sender(arg7),
        };
        0x2::event::emit<RedeemEvent>(v1);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg3.receipt_balance, v0), arg7)
    }

    public fun redeem_receipt<T0: drop, T1: drop, T2: drop, T3: drop, T4: drop>(arg0: 0x2::coin::Coin<T2>, arg1: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::sy::SyState, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg3: &mut EmberMarketVault<T0, T1, T2, T3, T4>, arg4: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T2, T3, T4>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xc56a55893f4791d03726f9c109725765b584c06eb5625704ce782112d763ef99::package_version::assert_current(arg2);
        assert_market_match<T0, T1, T2, T3, T4>(arg3, arg4);
        let v0 = 0x2::coin::value<T2>(&arg0);
        assert!(v0 > 0, 1018);
        refresh_withdraw_window<T0, T1, T2, T3, T4>(arg3, 0x2::clock::timestamp_ms(arg5));
        assert_unqueued_reserve_available<T0, T1, T2, T3, T4>(arg3, v0);
        consume_withdraw_quota<T0, T1, T2, T3, T4>(arg3, v0);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::sy::burn_escrowed_sy_market_state<T2, T0, T3, T4, 0xc56a55893f4791d03726f9c109725765b584c06eb5625704ce782112d763ef99::sign::EMBER>(arg0, 0xc56a55893f4791d03726f9c109725765b584c06eb5625704ce782112d763ef99::sign::sign(), arg1, arg2, arg4, 0x2::object::id<EmberMarketVault<T0, T1, T2, T3, T4>>(arg3));
        arg3.updated_at = 0x2::clock::timestamp_ms(arg5);
        let v1 = ReceiptRedeemedEvent{
            market_id      : arg3.market_id,
            vault_id       : 0x2::object::id<EmberMarketVault<T0, T1, T2, T3, T4>>(arg3),
            receipt_amount : v0,
            redeemer       : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<ReceiptRedeemedEvent>(v1);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg3.receipt_balance, v0), arg6)
    }

    fun refresh_withdraw_circuit_breaker<T0: drop, T1: drop, T2: drop, T3: drop, T4: drop>(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &mut EmberMarketVault<T0, T1, T2, T3, T4>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0xc56a55893f4791d03726f9c109725765b584c06eb5625704ce782112d763ef99::package_version::assert_version(arg0);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        reset_withdraw_window<T0, T1, T2, T3, T4>(arg1, v0);
        arg1.updated_at = v0;
        let v1 = WithdrawCircuitBreakerRefreshedEvent{
            vault_id                : 0x2::object::id<EmberMarketVault<T0, T1, T2, T3, T4>>(arg1),
            market_id               : arg1.market_id,
            withdraw_window_ms      : arg1.withdraw_window_ms,
            withdraw_bps_per_window : arg1.withdraw_bps_per_window,
            window_start_ms         : v0,
            window_base_reserve     : arg1.withdraw_window_base_reserve,
            refresher               : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<WithdrawCircuitBreakerRefreshedEvent>(v1);
    }

    public fun refresh_withdraw_circuit_breaker_by_ACL<T0: drop, T1: drop, T2: drop, T3: drop, T4: drop>(arg0: &0x413f0b727ca3a6fded067960c364d337ad57e284c96f3b21a922455627ca332b::acl::ACL, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &mut EmberMarketVault<T0, T1, T2, T3, T4>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x413f0b727ca3a6fded067960c364d337ad57e284c96f3b21a922455627ca332b::acl::assert_has_role(arg0, arg1, 0x2::tx_context::sender(arg4), 0x1::string::utf8(b"ember_adapter.refresh_withdraw_circuit_breaker"));
        refresh_withdraw_circuit_breaker<T0, T1, T2, T3, T4>(arg1, arg2, arg3, arg4);
    }

    public fun refresh_withdraw_circuit_breaker_by_admin<T0: drop, T1: drop, T2: drop, T3: drop, T4: drop>(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &mut EmberMarketVault<T0, T1, T2, T3, T4>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        refresh_withdraw_circuit_breaker<T0, T1, T2, T3, T4>(arg1, arg2, arg3, arg4);
    }

    fun refresh_withdraw_window<T0: drop, T1: drop, T2: drop, T3: drop, T4: drop>(arg0: &mut EmberMarketVault<T0, T1, T2, T3, T4>, arg1: u64) {
        if (arg1 < arg0.withdraw_window_start_ms) {
            return
        };
        let v0 = arg1 - arg0.withdraw_window_start_ms;
        if (v0 < arg0.withdraw_window_ms) {
            return
        };
        arg0.withdraw_window_start_ms = arg0.withdraw_window_start_ms + v0 / arg0.withdraw_window_ms * arg0.withdraw_window_ms;
        arg0.withdraw_window_base_reserve = 0x2::balance::value<T1>(&arg0.receipt_balance);
        arg0.withdraw_window_withdrawn = 0;
        arg0.withdraw_window_minted = 0;
        let v1 = WithdrawWindowRolledEvent{
            vault_id            : 0x2::object::id<EmberMarketVault<T0, T1, T2, T3, T4>>(arg0),
            market_id           : arg0.market_id,
            window_start_ms     : arg0.withdraw_window_start_ms,
            window_base_reserve : arg0.withdraw_window_base_reserve,
        };
        0x2::event::emit<WithdrawWindowRolledEvent>(v1);
    }

    fun reject_withdraw<T0: drop, T1: drop, T2: drop, T3: drop, T4: drop>(arg0: u64, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &mut EmberMarketVault<T0, T1, T2, T3, T4>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_market_active<T0, T1, T2, T3, T4>(arg2, arg1);
        let v0 = take_withdraw_request<T0, T1, T2, T3, T4>(arg2, arg0);
        let WithdrawRequest {
            request_id     : v1,
            vault_id       : v2,
            market_id      : v3,
            ember_vault_id : v4,
            owner          : v5,
            receipt_amount : v6,
            created_at     : _,
            sy_balance     : v8,
        } = v0;
        let v9 = v8;
        assert!(v1 == arg0, 1010);
        assert_request_matches_vault<T0, T1, T2, T3, T4>(arg2, v2, v3, v4);
        assert!(arg2.queued_receipt >= v6, 1012);
        arg2.queued_receipt = arg2.queued_receipt - v6;
        arg2.updated_at = 0x2::clock::timestamp_ms(arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v9, arg4), v5);
        let v10 = WithdrawRejectedEvent{
            request_id     : arg0,
            vault_id       : v2,
            market_id      : v3,
            ember_vault_id : v4,
            owner          : v5,
            receipt_amount : v6,
            sy_amount      : 0x2::balance::value<T2>(&v9),
            rejected_at    : arg2.updated_at,
            operator       : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<WithdrawRejectedEvent>(v10);
    }

    public fun reject_withdraw_by_ACL<T0: drop, T1: drop, T2: drop, T3: drop, T4: drop>(arg0: &0x413f0b727ca3a6fded067960c364d337ad57e284c96f3b21a922455627ca332b::acl::ACL, arg1: u64, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg3: &mut EmberMarketVault<T0, T1, T2, T3, T4>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x413f0b727ca3a6fded067960c364d337ad57e284c96f3b21a922455627ca332b::acl::assert_has_role(arg0, arg2, 0x2::tx_context::sender(arg5), 0x1::string::utf8(b"ember_adapter.reject_withdraw"));
        reject_withdraw<T0, T1, T2, T3, T4>(arg1, arg2, arg3, arg4, arg5);
    }

    public fun reject_withdraw_by_admin<T0: drop, T1: drop, T2: drop, T3: drop, T4: drop>(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg1: u64, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg3: &mut EmberMarketVault<T0, T1, T2, T3, T4>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        reject_withdraw<T0, T1, T2, T3, T4>(arg1, arg2, arg3, arg4, arg5);
    }

    fun remaining_quota<T0: drop, T1: drop, T2: drop, T3: drop, T4: drop>(arg0: &EmberMarketVault<T0, T1, T2, T3, T4>) : u64 {
        let v0 = (withdraw_quota<T0, T1, T2, T3, T4>(arg0) as u128);
        let v1 = if (arg0.withdraw_window_withdrawn > arg0.withdraw_window_minted) {
            arg0.withdraw_window_withdrawn - arg0.withdraw_window_minted
        } else {
            0
        };
        if (v0 > v1) {
            ((v0 - v1) as u64)
        } else {
            0
        }
    }

    public fun remaining_withdraw_quota<T0: drop, T1: drop, T2: drop, T3: drop, T4: drop>(arg0: &EmberMarketVault<T0, T1, T2, T3, T4>) : u64 {
        remaining_quota<T0, T1, T2, T3, T4>(arg0)
    }

    public fun request_owner<T0: drop, T1: drop, T2: drop, T3: drop, T4: drop>(arg0: &EmberMarketVault<T0, T1, T2, T3, T4>, arg1: u64) : address {
        borrow_withdraw_request<T0, T1, T2, T3, T4>(arg0, arg1).owner
    }

    public fun request_receipt_amount<T0: drop, T1: drop, T2: drop, T3: drop, T4: drop>(arg0: &EmberMarketVault<T0, T1, T2, T3, T4>, arg1: u64) : u64 {
        borrow_withdraw_request<T0, T1, T2, T3, T4>(arg0, arg1).receipt_amount
    }

    public fun request_sy_amount<T0: drop, T1: drop, T2: drop, T3: drop, T4: drop>(arg0: &EmberMarketVault<T0, T1, T2, T3, T4>, arg1: u64) : u64 {
        0x2::balance::value<T2>(&borrow_withdraw_request<T0, T1, T2, T3, T4>(arg0, arg1).sy_balance)
    }

    public fun request_vault_id<T0: drop, T1: drop, T2: drop, T3: drop, T4: drop>(arg0: &EmberMarketVault<T0, T1, T2, T3, T4>, arg1: u64) : 0x2::object::ID {
        borrow_withdraw_request<T0, T1, T2, T3, T4>(arg0, arg1).vault_id
    }

    fun reset_withdraw_window<T0: drop, T1: drop, T2: drop, T3: drop, T4: drop>(arg0: &mut EmberMarketVault<T0, T1, T2, T3, T4>, arg1: u64) {
        arg0.withdraw_window_start_ms = arg1;
        arg0.withdraw_window_base_reserve = 0x2::balance::value<T1>(&arg0.receipt_balance);
        arg0.withdraw_window_withdrawn = 0;
        arg0.withdraw_window_minted = 0;
    }

    fun set_withdraw_circuit_breaker<T0: drop, T1: drop, T2: drop, T3: drop, T4: drop>(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &mut EmberMarketVault<T0, T1, T2, T3, T4>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0xc56a55893f4791d03726f9c109725765b584c06eb5625704ce782112d763ef99::package_version::assert_current(arg0);
        assert_withdraw_circuit_breaker_config(arg2, arg3);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        arg1.withdraw_window_ms = arg2;
        arg1.withdraw_bps_per_window = arg3;
        reset_withdraw_window<T0, T1, T2, T3, T4>(arg1, v0);
        arg1.updated_at = v0;
        let v1 = WithdrawCircuitBreakerUpdatedEvent{
            vault_id                : 0x2::object::id<EmberMarketVault<T0, T1, T2, T3, T4>>(arg1),
            market_id               : arg1.market_id,
            withdraw_window_ms      : arg2,
            withdraw_bps_per_window : arg3,
            window_start_ms         : v0,
            window_base_reserve     : arg1.withdraw_window_base_reserve,
            updater                 : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<WithdrawCircuitBreakerUpdatedEvent>(v1);
    }

    public fun set_withdraw_circuit_breaker_by_ACL<T0: drop, T1: drop, T2: drop, T3: drop, T4: drop>(arg0: &0x413f0b727ca3a6fded067960c364d337ad57e284c96f3b21a922455627ca332b::acl::ACL, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &mut EmberMarketVault<T0, T1, T2, T3, T4>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x413f0b727ca3a6fded067960c364d337ad57e284c96f3b21a922455627ca332b::acl::assert_has_role(arg0, arg1, 0x2::tx_context::sender(arg6), 0x1::string::utf8(b"ember_adapter.set_withdraw_circuit_breaker"));
        set_withdraw_circuit_breaker<T0, T1, T2, T3, T4>(arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun set_withdraw_circuit_breaker_by_admin<T0: drop, T1: drop, T2: drop, T3: drop, T4: drop>(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &mut EmberMarketVault<T0, T1, T2, T3, T4>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        set_withdraw_circuit_breaker<T0, T1, T2, T3, T4>(arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun shares_for_underlying_ceil(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 > 0, 1005);
        let v0 = (0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::full_math_u128::mul_div_ceil((arg0 as u128), (arg1 as u128), 1000000000) as u64);
        assert!(v0 > 0, 1006);
        v0
    }

    public fun shares_for_underlying_floor(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 > 0, 1005);
        let v0 = (0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::full_math_u128::mul_div_floor((arg0 as u128), (arg1 as u128), 1000000000) as u64);
        assert!(v0 > 0, 1006);
        v0
    }

    fun take_withdraw_request<T0: drop, T1: drop, T2: drop, T3: drop, T4: drop>(arg0: &mut EmberMarketVault<T0, T1, T2, T3, T4>, arg1: u64) : WithdrawRequest<T0, T1, T2, T3, T4> {
        assert!(0x337f85b36287d38cdf2bb60964187f432dd3abeb5228f8a2db4cff7a9f47a87d::linked_table::contains<u64, WithdrawRequest<T0, T1, T2, T3, T4>>(&arg0.withdraw_queue, arg1), 1015);
        0x337f85b36287d38cdf2bb60964187f432dd3abeb5228f8a2db4cff7a9f47a87d::linked_table::remove<u64, WithdrawRequest<T0, T1, T2, T3, T4>>(&mut arg0.withdraw_queue, arg1)
    }

    public fun updated_at<T0: drop, T1: drop, T2: drop, T3: drop, T4: drop>(arg0: &EmberMarketVault<T0, T1, T2, T3, T4>) : u64 {
        arg0.updated_at
    }

    public fun vault_id<T0: drop, T1: drop, T2: drop, T3: drop, T4: drop>(arg0: &EmberMarketVault<T0, T1, T2, T3, T4>) : 0x2::object::ID {
        0x2::object::id<EmberMarketVault<T0, T1, T2, T3, T4>>(arg0)
    }

    public fun withdraw_bps_per_window<T0: drop, T1: drop, T2: drop, T3: drop, T4: drop>(arg0: &EmberMarketVault<T0, T1, T2, T3, T4>) : u64 {
        arg0.withdraw_bps_per_window
    }

    public fun withdraw_queue_length<T0: drop, T1: drop, T2: drop, T3: drop, T4: drop>(arg0: &EmberMarketVault<T0, T1, T2, T3, T4>) : u64 {
        0x337f85b36287d38cdf2bb60964187f432dd3abeb5228f8a2db4cff7a9f47a87d::linked_table::length<u64, WithdrawRequest<T0, T1, T2, T3, T4>>(&arg0.withdraw_queue)
    }

    public fun withdraw_queue_request_id<T0: drop, T1: drop, T2: drop, T3: drop, T4: drop>(arg0: &EmberMarketVault<T0, T1, T2, T3, T4>, arg1: u64) : u64 {
        withdraw_request_id_at<T0, T1, T2, T3, T4>(arg0, arg1)
    }

    fun withdraw_quota<T0: drop, T1: drop, T2: drop, T3: drop, T4: drop>(arg0: &EmberMarketVault<T0, T1, T2, T3, T4>) : u64 {
        (0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::full_math_u128::mul_div_floor((arg0.withdraw_window_base_reserve as u128), (arg0.withdraw_bps_per_window as u128), (10000 as u128)) as u64)
    }

    public fun withdraw_quota_per_window<T0: drop, T1: drop, T2: drop, T3: drop, T4: drop>(arg0: &EmberMarketVault<T0, T1, T2, T3, T4>) : u64 {
        withdraw_quota<T0, T1, T2, T3, T4>(arg0)
    }

    public fun withdraw_request_exists<T0: drop, T1: drop, T2: drop, T3: drop, T4: drop>(arg0: &EmberMarketVault<T0, T1, T2, T3, T4>, arg1: u64) : bool {
        0x337f85b36287d38cdf2bb60964187f432dd3abeb5228f8a2db4cff7a9f47a87d::linked_table::contains<u64, WithdrawRequest<T0, T1, T2, T3, T4>>(&arg0.withdraw_queue, arg1)
    }

    fun withdraw_request_id_at<T0: drop, T1: drop, T2: drop, T3: drop, T4: drop>(arg0: &EmberMarketVault<T0, T1, T2, T3, T4>, arg1: u64) : u64 {
        let v0 = 0x337f85b36287d38cdf2bb60964187f432dd3abeb5228f8a2db4cff7a9f47a87d::linked_table::front<u64, WithdrawRequest<T0, T1, T2, T3, T4>>(&arg0.withdraw_queue);
        let v1 = 0;
        while (0x1::option::is_some<u64>(&v0)) {
            let v2 = *0x1::option::borrow<u64>(&v0);
            if (v1 == arg1) {
                return v2
            };
            v0 = 0x337f85b36287d38cdf2bb60964187f432dd3abeb5228f8a2db4cff7a9f47a87d::linked_table::next<u64, WithdrawRequest<T0, T1, T2, T3, T4>>(&arg0.withdraw_queue, v2);
            v1 = v1 + 1;
        };
        abort 1015
    }

    public fun withdraw_window_base_reserve<T0: drop, T1: drop, T2: drop, T3: drop, T4: drop>(arg0: &EmberMarketVault<T0, T1, T2, T3, T4>) : u64 {
        arg0.withdraw_window_base_reserve
    }

    public fun withdraw_window_minted<T0: drop, T1: drop, T2: drop, T3: drop, T4: drop>(arg0: &EmberMarketVault<T0, T1, T2, T3, T4>) : u128 {
        arg0.withdraw_window_minted
    }

    public fun withdraw_window_ms<T0: drop, T1: drop, T2: drop, T3: drop, T4: drop>(arg0: &EmberMarketVault<T0, T1, T2, T3, T4>) : u64 {
        arg0.withdraw_window_ms
    }

    public fun withdraw_window_start_ms<T0: drop, T1: drop, T2: drop, T3: drop, T4: drop>(arg0: &EmberMarketVault<T0, T1, T2, T3, T4>) : u64 {
        arg0.withdraw_window_start_ms
    }

    public fun withdraw_window_withdrawn<T0: drop, T1: drop, T2: drop, T3: drop, T4: drop>(arg0: &EmberMarketVault<T0, T1, T2, T3, T4>) : u128 {
        arg0.withdraw_window_withdrawn
    }

    // decompiled from Move bytecode v7
}

