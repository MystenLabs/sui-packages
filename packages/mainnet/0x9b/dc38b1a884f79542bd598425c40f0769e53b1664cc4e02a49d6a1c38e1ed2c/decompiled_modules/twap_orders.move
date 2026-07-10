module 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::twap_orders {
    struct TWAPOrderDetails has drop {
        first_run_expire_timestamp: 0x1::option::Option<u64>,
        expire_timestamp: 0x1::option::Option<u64>,
        execution_gap_ms: u64,
        execution_time_uncertainty_ms: u64,
        chunks_amount: u64,
        small_tail_merge_threshold_bps: u64,
        time_for_retry_ms: u64,
        amount_uncertainty_bps: u64,
        max_one_execution_amount_bps: u64,
        side: bool,
        size: u64,
        max_slippage_bps: u64,
        reduce_only: bool,
        integrator_info: 0x1::option::Option<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::IntegratorInfo>,
        salt: vector<u8>,
    }

    struct TWAPOrderTicket<phantom T0> has store, key {
        id: 0x2::object::UID,
        clearing_house_id: 0x2::object::ID,
        executors: vector<address>,
        execution_domain: 0x1::option::Option<address>,
        gas: 0x2::balance::Balance<0x2::sui::SUI>,
        gas_execution_budget: u64,
        account_id: u64,
        encrypted_details: vector<u8>,
        processed_amount: u64,
        scheduled_amount: u64,
        last_attempt_timestamp_ms: u64,
        retry_anchor_timestamp_ms: u64,
        last_execution_timestamp_ms: u64,
        paid_execution_gas: u64,
    }

    public(friend) fun assert_amount_within_uncertainty(arg0: &TWAPOrderDetails, arg1: u64) {
        assert!((0x1::u64::diff(arg1, target_chunk_amount(arg0)) as u128) <= (target_chunk_amount(arg0) as u128) * (arg0.amount_uncertainty_bps as u128) / 10000, 6302);
    }

    fun assert_execution_gap_within_uncertainty(arg0: &TWAPOrderDetails, arg1: u64) {
        if (arg1 >= arg0.execution_gap_ms) {
            return
        };
        assert!(arg0.execution_gap_ms - arg1 <= arg0.execution_time_uncertainty_ms, 6303);
    }

    fun assert_order_details_are_valid(arg0: &TWAPOrderDetails, arg1: &vector<u8>) {
        let v0 = 0x1::bcs::to_bytes<TWAPOrderDetails>(arg0);
        assert!(0x2::hash::blake2b256(&v0) == *arg1, 6300);
    }

    fun assert_twap_order_can_be_executed<T0>(arg0: &TWAPOrderTicket<T0>, arg1: &TWAPOrderDetails, arg2: u64, arg3: u64) {
        assert_order_details_are_valid(arg1, &arg0.encrypted_details);
        assert!(arg0.processed_amount < arg1.size, 6304);
        if (!is_first_execution<T0>(arg0)) {
        } else if (0x1::option::is_none<u64>(&arg1.first_run_expire_timestamp)) {
        } else {
            assert!(arg3 < *0x1::option::borrow<u64>(&arg1.first_run_expire_timestamp), 6310);
        };
        let v0 = arg1.expire_timestamp;
        let v1 = 0x1::option::is_some<u64>(&v0) && arg3 > *0x1::option::borrow<u64>(&v0);
        assert!(!v1, 6301);
        assert_amount_within_uncertainty(arg1, arg2);
        if (!has_attempts<T0>(arg0)) {
        } else {
            assert_execution_gap_within_uncertainty(arg1, arg3 - arg0.last_attempt_timestamp_ms);
            assert!(is_not_spoiled<T0>(arg0, arg1, arg3), 6305);
        };
    }

    fun assert_valid_ticket_clearing_house<T0>(arg0: &TWAPOrderTicket<T0>, arg1: 0x2::object::ID) {
        assert!(arg0.clearing_house_id == arg1, 6309);
    }

    fun assert_valid_ticket_executor<T0>(arg0: &TWAPOrderTicket<T0>, arg1: &0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::clearing_house::Executor) {
        let v0 = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::clearing_house::executor_sender(arg1);
        assert!(0x1::vector::contains<address>(&arg0.executors, &v0), 6306);
        assert!(arg0.execution_domain == 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::clearing_house::executor_domain(arg1), 6306);
    }

    public fun cancel<T0>(arg0: &mut 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::Account<T0>, arg1: &mut 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::clearing_house::ClearingHouse<T0>, arg2: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg3: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg4: 0x2::object::ID, arg5: &0x2::clock::Clock, arg6: &0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::clearing_house::Executor, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::clearing_house::assert_package_version<T0>(arg1);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::assert_order_ticket_exists<T0>(arg0, arg4);
        let v0 = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::remove_order_ticket<T0, TWAPOrderTicket<T0>>(arg0, arg4);
        let v1 = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::clearing_house::executor_sender(arg6);
        assert_valid_ticket_executor<T0>(&v0, arg6);
        assert_valid_ticket_clearing_house<T0>(&v0, 0x2::object::id<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::clearing_house::ClearingHouse<T0>>(arg1));
        let v2 = if (v0.processed_amount != 0 && !0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::clearing_house::is_market_paused<T0>(arg1)) {
            0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::clearing_house::deallocate_collateral_internal<T0>(arg1, arg0, arg2, arg3, 0x1::option::none<u64>(), arg5)
        } else {
            0
        };
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::events::emit_canceled_twap_order_ticket<T0>(0x2::object::uid_to_inner(&v0.id), v0.account_id, v1, v2, v0.processed_amount != 0);
        let TWAPOrderTicket {
            id                          : v3,
            clearing_house_id           : _,
            executors                   : _,
            execution_domain            : _,
            gas                         : v7,
            gas_execution_budget        : _,
            account_id                  : v9,
            encrypted_details           : _,
            processed_amount            : _,
            scheduled_amount            : _,
            last_attempt_timestamp_ms   : _,
            retry_anchor_timestamp_ms   : _,
            last_execution_timestamp_ms : _,
            paid_execution_gas          : _,
        } = v0;
        let v17 = v3;
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::events::emit_deleted_twap_order_ticket<T0>(0x2::object::uid_to_inner(&v17), v9, v1);
        0x2::object::delete(v17);
        0x2::coin::from_balance<0x2::sui::SUI>(v7, arg7)
    }

    public fun create_twap_order_ticket<T0, T1>(arg0: &mut 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::Account<T0>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::authority::ACCOUNT, T1>, arg2: &0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::clearing_house::ClearingHouse<T0>, arg3: vector<address>, arg4: 0x1::option::Option<address>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::clearing_house::assert_package_version<T0>(arg2);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::assert_authority_cap_is_valid<T0, T1>(arg0, arg1);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::authority::assert_is_admin_or_assistant<T1>();
        let v0 = 0x2::object::id<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::clearing_house::ClearingHouse<T0>>(arg2);
        let v1 = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::account_id<T0>(arg0);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg5);
        let v3 = TWAPOrderTicket<T0>{
            id                          : 0x2::object::new(arg7),
            clearing_house_id           : v0,
            executors                   : arg3,
            execution_domain            : arg4,
            gas                         : 0x2::coin::into_balance<0x2::sui::SUI>(arg5),
            gas_execution_budget        : v2,
            account_id                  : v1,
            encrypted_details           : arg6,
            processed_amount            : 0,
            scheduled_amount            : 0,
            last_attempt_timestamp_ms   : 0,
            retry_anchor_timestamp_ms   : 0,
            last_execution_timestamp_ms : 0,
            paid_execution_gas          : 0,
        };
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::events::emit_created_twap_order_ticket<T0>(0x2::object::uid_to_inner(&v3.id), v0, v1, arg3, arg4, v2, v3.encrypted_details);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::add_order_ticket<T0, TWAPOrderTicket<T0>>(arg0, v3)
    }

    public fun execute<T0>(arg0: &mut 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::Account<T0>, arg1: 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::clearing_house::ClearingHouse<T0>, arg2: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg3: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg4: 0x2::object::ID, arg5: &TWAPOrderDetails, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::clearing_house::Executor, arg9: &mut 0x2::tx_context::TxContext) : (0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::clearing_house::SessionSummary, 0x2::coin::Coin<0x2::sui::SUI>, 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::clearing_house::ClearingHouse<T0>) {
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::clearing_house::assert_package_version<T0>(&arg1);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::clearing_house::assert_market_is_not_paused<T0>(&arg1);
        assert!(0x2::tx_context::gas_price(arg9) == 0x2::tx_context::reference_gas_price(arg9), 6311);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::assert_order_ticket_exists<T0>(arg0, arg4);
        let v0 = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::remove_order_ticket<T0, TWAPOrderTicket<T0>>(arg0, arg4);
        assert_valid_ticket_executor<T0>(&v0, arg8);
        assert_valid_ticket_clearing_house<T0>(&v0, 0x2::object::id<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::clearing_house::ClearingHouse<T0>>(&arg1));
        let v1 = 0x2::clock::timestamp_ms(arg7);
        assert_twap_order_can_be_executed<T0>(&v0, arg5, arg6, v1);
        let v2 = &v0;
        let v3 = target_chunk_amount(arg5);
        let v4 = unfilled_scheduled_amount<T0>(v2);
        let v5 = arg5.size - v2.scheduled_amount;
        let v6 = v5 % v3;
        let v7 = if (v5 / v3 == 1) {
            if (v6 > 0) {
                (v6 as u128) * 10000 < (v3 as u128) * (arg5.small_tail_merge_threshold_bps as u128)
            } else {
                false
            }
        } else {
            false
        };
        let v8 = if (v7) {
            v5
        } else {
            0x1::u64::min(arg6, v5)
        };
        let v9 = if (v7) {
            0x1::u64::max(arg5.size * arg5.max_one_execution_amount_bps / 10000, v8)
        } else {
            arg5.size * arg5.max_one_execution_amount_bps / 10000
        };
        let v10 = if (v4 > 0 && v8 < v9) {
            0x1::u64::min(v4, v9 - v8)
        } else {
            0
        };
        let v11 = v8 + v10;
        assert!(v11 <= v9, 6302);
        let v12 = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::clearing_house::start_session_<T0>(arg1, 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::account_id<T0>(arg0), arg2, arg3, false, arg5.integrator_info, arg7);
        let v13 = &v12;
        let v14 = arg5.side == false;
        let v15 = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::tick_size(0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::clearing_house::market_params<T0>(0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::clearing_house::clearing_house<T0>(v13)));
        let v16 = if (v14) {
            0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(1000000000000000000, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::from_u64fraction(arg5.max_slippage_bps, 10000))
        } else {
            0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::sub(1000000000000000000, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::from_u64fraction(arg5.max_slippage_bps, 10000))
        };
        let v17 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::to_balance(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::clearing_house::mark_price_in_session<T0>(v13), v16), 1000000000);
        let v18 = v17 % v15;
        let v19 = if (v18 == 0) {
            v17
        } else if (v14) {
            v17 - v18
        } else {
            v17 + v15 - v18
        };
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::clearing_house::place_limit_order<T0>(&mut v12, arg5.side, v11, v19, 3, 0x1::option::none<u64>(), arg5.reduce_only, 0x1::option::none<u64>());
        let v20 = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::clearing_house::summary<T0>(&v12);
        let v21 = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::clearing_house::base_filled_bid(v20) != 0 || 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::clearing_house::base_filled_ask(v20) != 0;
        let v22 = !arg5.reduce_only && v21;
        let (v23, v24) = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::clearing_house::end_session_<T0>(v12, arg0, v22, false, true);
        let v25 = v24;
        let v26 = &mut v0;
        let v27 = if (arg5.side == false) {
            0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::to_balance(0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::clearing_house::base_filled_bid(&v25), 1000000000)
        } else {
            0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::to_balance(0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::clearing_house::base_filled_ask(&v25), 1000000000)
        };
        v26.scheduled_amount = v26.scheduled_amount + v8;
        if (v26.last_attempt_timestamp_ms == 0) {
            v26.retry_anchor_timestamp_ms = v1;
        };
        v26.last_attempt_timestamp_ms = v1;
        if (v27 != 0) {
            v26.retry_anchor_timestamp_ms = v1;
            v26.last_execution_timestamp_ms = v1;
            v26.processed_amount = v26.processed_amount + v27;
        };
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::events::emit_processed_twap_order_ticket<T0>(0x2::object::uid_to_inner(&v26.id), v0.account_id, v11, v27, unfilled_scheduled_amount<T0>(v26), v26.processed_amount, v26.last_execution_timestamp_ms);
        let v28 = &mut v0;
        let v29 = (((v28.gas_execution_budget as u128) * (0x1::u64::min(v28.processed_amount, arg5.size) as u128) / (arg5.size as u128)) as u64);
        let v30 = v29 - v28.paid_execution_gas;
        v28.paid_execution_gas = v29;
        let v31 = if (v30 == 0) {
            0x2::balance::zero<0x2::sui::SUI>()
        } else {
            0x2::balance::split<0x2::sui::SUI>(&mut v28.gas, v30)
        };
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::add_order_ticket<T0, TWAPOrderTicket<T0>>(arg0, v0);
        (v25, 0x2::coin::from_balance<0x2::sui::SUI>(v31, arg9), v23)
    }

    public fun finalize<T0>(arg0: &mut 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::Account<T0>, arg1: &mut 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::clearing_house::ClearingHouse<T0>, arg2: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg3: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg4: &0x2::clock::Clock, arg5: 0x2::object::ID, arg6: &TWAPOrderDetails, arg7: &0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::clearing_house::Executor, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::clearing_house::assert_package_version<T0>(arg1);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::assert_order_ticket_exists<T0>(arg0, arg5);
        let v0 = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::remove_order_ticket<T0, TWAPOrderTicket<T0>>(arg0, arg5);
        let v1 = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::clearing_house::executor_sender(arg7);
        assert_valid_ticket_executor<T0>(&v0, arg7);
        assert_valid_ticket_clearing_house<T0>(&v0, 0x2::object::id<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::clearing_house::ClearingHouse<T0>>(arg1));
        assert_order_details_are_valid(arg6, &v0.encrypted_details);
        assert!(is_complete<T0>(&v0, arg6.size), 6308);
        let v2 = if (!0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::clearing_house::is_market_paused<T0>(arg1)) {
            0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::clearing_house::deallocate_collateral_internal<T0>(arg1, arg0, arg2, arg3, 0x1::option::none<u64>(), arg4)
        } else {
            0
        };
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::events::emit_finalized_twap_order_ticket<T0>(0x2::object::uid_to_inner(&v0.id), v0.account_id, v1, v2);
        let TWAPOrderTicket {
            id                          : v3,
            clearing_house_id           : _,
            executors                   : _,
            execution_domain            : _,
            gas                         : v7,
            gas_execution_budget        : _,
            account_id                  : v9,
            encrypted_details           : _,
            processed_amount            : _,
            scheduled_amount            : _,
            last_attempt_timestamp_ms   : _,
            retry_anchor_timestamp_ms   : _,
            last_execution_timestamp_ms : _,
            paid_execution_gas          : _,
        } = v0;
        let v17 = v3;
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::events::emit_deleted_twap_order_ticket<T0>(0x2::object::uid_to_inner(&v17), v9, v1);
        0x2::object::delete(v17);
        0x2::coin::from_balance<0x2::sui::SUI>(v7, arg8)
    }

    public fun has_attempts<T0>(arg0: &TWAPOrderTicket<T0>) : bool {
        arg0.last_attempt_timestamp_ms != 0
    }

    public fun is_complete<T0>(arg0: &TWAPOrderTicket<T0>, arg1: u64) : bool {
        arg0.processed_amount >= arg1
    }

    public fun is_first_execution<T0>(arg0: &TWAPOrderTicket<T0>) : bool {
        !has_attempts<T0>(arg0)
    }

    fun is_not_spoiled<T0>(arg0: &TWAPOrderTicket<T0>, arg1: &TWAPOrderDetails, arg2: u64) : bool {
        if (!has_attempts<T0>(arg0)) {
            return true
        };
        arg2 - arg0.retry_anchor_timestamp_ms < arg1.time_for_retry_ms + arg1.execution_gap_ms + arg1.execution_time_uncertainty_ms
    }

    public fun new_details(arg0: 0x1::option::Option<u64>, arg1: 0x1::option::Option<u64>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: bool, arg10: u64, arg11: u64, arg12: bool, arg13: 0x1::option::Option<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::IntegratorInfo>, arg14: vector<u8>) : TWAPOrderDetails {
        let v0 = if (arg10 != 0) {
            if (arg4 != 0) {
                arg10 >= arg4
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 6300);
        TWAPOrderDetails{
            first_run_expire_timestamp     : arg0,
            expire_timestamp               : arg1,
            execution_gap_ms               : arg2,
            execution_time_uncertainty_ms  : arg3,
            chunks_amount                  : arg4,
            small_tail_merge_threshold_bps : arg5,
            time_for_retry_ms              : arg6,
            amount_uncertainty_bps         : arg7,
            max_one_execution_amount_bps   : arg8,
            side                           : arg9,
            size                           : arg10,
            max_slippage_bps               : arg11,
            reduce_only                    : arg12,
            integrator_info                : arg13,
            salt                           : arg14,
        }
    }

    public fun set_details<T0, T1>(arg0: &mut 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::Account<T0>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::authority::ACCOUNT, T1>, arg2: 0x2::object::ID, arg3: vector<u8>) {
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::assert_authority_cap_is_valid<T0, T1>(arg0, arg1);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::assert_order_ticket_exists<T0>(arg0, arg2);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::authority::assert_is_admin_or_assistant<T1>();
        let v0 = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::borrow_mut_order_ticket<T0, TWAPOrderTicket<T0>>(arg0, arg2);
        assert!(!has_attempts<T0>(v0), 6307);
        v0.encrypted_details = arg3;
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::events::emit_edited_twap_order_ticket_details<T0>(0x2::object::uid_to_inner(&v0.id), v0.account_id, arg3);
    }

    public fun set_executors<T0, T1>(arg0: &mut 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::Account<T0>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::authority::ACCOUNT, T1>, arg2: 0x2::object::ID, arg3: vector<address>) {
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::assert_authority_cap_is_valid<T0, T1>(arg0, arg1);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::assert_order_ticket_exists<T0>(arg0, arg2);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::authority::assert_is_admin_or_assistant<T1>();
        let v0 = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::borrow_mut_order_ticket<T0, TWAPOrderTicket<T0>>(arg0, arg2);
        assert!(!has_attempts<T0>(v0), 6307);
        v0.executors = arg3;
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::events::emit_edited_twap_order_ticket_executors<T0>(0x2::object::uid_to_inner(&v0.id), v0.account_id, arg3);
    }

    public(friend) fun target_chunk_amount(arg0: &TWAPOrderDetails) : u64 {
        arg0.size / arg0.chunks_amount
    }

    public fun unfilled_scheduled_amount<T0>(arg0: &TWAPOrderTicket<T0>) : u64 {
        arg0.scheduled_amount - arg0.processed_amount
    }

    public fun user_cancel_twap_order<T0, T1>(arg0: &mut 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::Account<T0>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::authority::ACCOUNT, T1>, arg2: &mut 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::clearing_house::ClearingHouse<T0>, arg3: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg4: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg5: 0x2::object::ID, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::clearing_house::assert_package_version<T0>(arg2);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::assert_authority_cap_is_valid<T0, T1>(arg0, arg1);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::assert_order_ticket_exists<T0>(arg0, arg5);
        let v0 = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::remove_order_ticket<T0, TWAPOrderTicket<T0>>(arg0, arg5);
        let v1 = 0x2::tx_context::sender(arg7);
        assert_valid_ticket_clearing_house<T0>(&v0, 0x2::object::id<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::clearing_house::ClearingHouse<T0>>(arg2));
        let v2 = if (v0.processed_amount != 0 && !0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::clearing_house::is_market_paused<T0>(arg2)) {
            0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::clearing_house::deallocate_collateral_internal<T0>(arg2, arg0, arg3, arg4, 0x1::option::none<u64>(), arg6)
        } else {
            0
        };
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::events::emit_canceled_twap_order_ticket<T0>(0x2::object::uid_to_inner(&v0.id), v0.account_id, v1, v2, v0.processed_amount != 0);
        let TWAPOrderTicket {
            id                          : v3,
            clearing_house_id           : _,
            executors                   : _,
            execution_domain            : _,
            gas                         : v7,
            gas_execution_budget        : _,
            account_id                  : v9,
            encrypted_details           : _,
            processed_amount            : _,
            scheduled_amount            : _,
            last_attempt_timestamp_ms   : _,
            retry_anchor_timestamp_ms   : _,
            last_execution_timestamp_ms : _,
            paid_execution_gas          : _,
        } = v0;
        let v17 = v3;
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::events::emit_deleted_twap_order_ticket<T0>(0x2::object::uid_to_inner(&v17), v9, v1);
        0x2::object::delete(v17);
        0x2::coin::from_balance<0x2::sui::SUI>(v7, arg7)
    }

    // decompiled from Move bytecode v7
}

