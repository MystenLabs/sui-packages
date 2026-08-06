module 0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::twap_orders {
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
        integrator_info: 0x1::option::Option<0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::account::IntegratorInfo>,
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

    public(friend) fun assert_amount_within_uncertainty(arg0: &TWAPOrderDetails, arg1: u64, arg2: u64) {
        let v0 = target_chunk_amount(arg0, arg2);
        assert!((0x1::u64::diff(arg1, v0) as u128) <= (v0 as u128) * (arg0.amount_uncertainty_bps as u128) / 10000, 6302);
    }

    fun assert_execution_gap_within_uncertainty(arg0: &TWAPOrderDetails, arg1: u64) {
        if (arg1 >= arg0.execution_gap_ms) {
            return
        };
        assert!(arg0.execution_gap_ms - arg1 <= arg0.execution_time_uncertainty_ms, 6303);
    }

    fun assert_lot_compatible(arg0: &TWAPOrderDetails, arg1: u64, arg2: u64) {
        let v0 = if (arg0.size % arg2 == 0) {
            if (arg0.size / arg2 >= arg0.chunks_amount) {
                arg1 % arg2 == 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 6312);
    }

    fun assert_order_details_are_valid(arg0: &TWAPOrderDetails, arg1: &vector<u8>) {
        let v0 = 0x1::bcs::to_bytes<TWAPOrderDetails>(arg0);
        assert!(0x2::hash::blake2b256(&v0) == *arg1, 6300);
    }

    fun assert_twap_order_can_be_executed<T0>(arg0: &TWAPOrderTicket<T0>, arg1: &TWAPOrderDetails, arg2: u64, arg3: u64, arg4: u64) {
        assert_order_details_are_valid(arg1, &arg0.encrypted_details);
        assert_lot_compatible(arg1, arg2, arg4);
        assert!(arg0.processed_amount < arg1.size, 6304);
        if (!is_first_execution<T0>(arg0)) {
        } else if (0x1::option::is_none<u64>(&arg1.first_run_expire_timestamp)) {
        } else {
            assert!(arg3 < *0x1::option::borrow<u64>(&arg1.first_run_expire_timestamp), 6310);
        };
        let v0 = arg1.expire_timestamp;
        let v1 = 0x1::option::is_some<u64>(&v0) && arg3 > *0x1::option::borrow<u64>(&v0);
        assert!(!v1, 6301);
        assert_amount_within_uncertainty(arg1, arg2, arg4);
        if (!has_attempts<T0>(arg0)) {
        } else {
            assert_execution_gap_within_uncertainty(arg1, arg3 - arg0.last_attempt_timestamp_ms);
            assert!(is_not_spoiled<T0>(arg0, arg1, arg3), 6305);
        };
    }

    fun assert_valid_ticket_clearing_house<T0>(arg0: &TWAPOrderTicket<T0>, arg1: 0x2::object::ID) {
        assert!(arg0.clearing_house_id == arg1, 6309);
    }

    fun assert_valid_ticket_executor<T0>(arg0: &TWAPOrderTicket<T0>, arg1: &0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::clearing_house::Executor) {
        let v0 = 0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::clearing_house::executor_sender(arg1);
        assert!(0x1::vector::contains<address>(&arg0.executors, &v0), 6306);
        assert!(arg0.execution_domain == 0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::clearing_house::executor_domain(arg1), 6306);
    }

    public fun cancel<T0>(arg0: &mut 0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::account::Account<T0>, arg1: &mut 0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::clearing_house::ClearingHouse<T0>, arg2: &0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::price_feed_storage::PriceFeedStorage, arg3: &0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::price_feed_storage::PriceFeedStorage, arg4: 0x2::object::ID, arg5: &0x2::clock::Clock, arg6: &0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::clearing_house::Executor, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::clearing_house::assert_package_version<T0>(arg1);
        0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::account::assert_order_ticket_exists<T0>(arg0, arg4);
        let v0 = 0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::account::remove_order_ticket<T0, TWAPOrderTicket<T0>>(arg0, arg4);
        let v1 = 0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::clearing_house::executor_sender(arg6);
        assert_valid_ticket_executor<T0>(&v0, arg6);
        assert_valid_ticket_clearing_house<T0>(&v0, 0x2::object::id<0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::clearing_house::ClearingHouse<T0>>(arg1));
        let v2 = if (v0.processed_amount != 0 && !0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::clearing_house::is_market_paused<T0>(arg1)) {
            0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::clearing_house::deallocate_collateral_internal<T0>(arg1, arg0, arg2, arg3, 0x1::option::none<u64>(), arg5)
        } else {
            0
        };
        0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::events::e39<T0>(0x2::object::uid_to_inner(&v0.id), v0.account_id, v1, v2, v0.processed_amount != 0);
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
        0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::events::e40<T0>(0x2::object::uid_to_inner(&v17), v9, v1);
        0x2::object::delete(v17);
        0x2::coin::from_balance<0x2::sui::SUI>(v7, arg7)
    }

    public fun create_twap_order_ticket<T0, T1>(arg0: &mut 0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::account::Account<T0>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::authority::ACCOUNT, T1>, arg2: &0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::clearing_house::ClearingHouse<T0>, arg3: vector<address>, arg4: 0x1::option::Option<address>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::clearing_house::assert_package_version<T0>(arg2);
        0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::account::assert_authority_cap_is_valid<T0, T1>(arg0, arg1);
        0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::authority::assert_is_admin_or_assistant<T1>();
        let v0 = 0x2::object::id<0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::clearing_house::ClearingHouse<T0>>(arg2);
        let v1 = 0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::account::account_id<T0>(arg0);
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
        0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::events::e36<T0>(0x2::object::uid_to_inner(&v3.id), v0, v1, arg3, arg4, v2, v3.encrypted_details);
        0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::account::add_order_ticket<T0, TWAPOrderTicket<T0>>(arg0, v3)
    }

    public fun execute<T0>(arg0: &mut 0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::account::Account<T0>, arg1: 0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::clearing_house::ClearingHouse<T0>, arg2: &0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::price_feed_storage::PriceFeedStorage, arg3: &0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::price_feed_storage::PriceFeedStorage, arg4: 0x2::object::ID, arg5: &TWAPOrderDetails, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::clearing_house::Executor, arg9: &mut 0x2::tx_context::TxContext) : (0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::clearing_house::SessionSummary, 0x2::coin::Coin<0x2::sui::SUI>, 0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::clearing_house::ClearingHouse<T0>) {
        0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::clearing_house::assert_package_version<T0>(&arg1);
        0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::clearing_house::assert_market_is_not_paused<T0>(&arg1);
        assert!(0x2::tx_context::gas_price(arg9) == 0x2::tx_context::reference_gas_price(arg9), 6311);
        0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::account::assert_order_ticket_exists<T0>(arg0, arg4);
        let v0 = 0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::account::remove_order_ticket<T0, TWAPOrderTicket<T0>>(arg0, arg4);
        assert_valid_ticket_executor<T0>(&v0, arg8);
        assert_valid_ticket_clearing_house<T0>(&v0, 0x2::object::id<0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::clearing_house::ClearingHouse<T0>>(&arg1));
        let v1 = 0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::market::lot_size(0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::clearing_house::market_params<T0>(&arg1));
        let v2 = 0x2::clock::timestamp_ms(arg7);
        assert_twap_order_can_be_executed<T0>(&v0, arg5, arg6, v2, v1);
        let v3 = &v0;
        let v4 = target_chunk_amount(arg5, v1);
        let v5 = unfilled_scheduled_amount<T0>(v3);
        let v6 = arg5.size - v3.scheduled_amount;
        let v7 = v6 % v4;
        let v8 = if (v6 / v4 == 1) {
            if (v7 > 0) {
                (v7 as u128) * 10000 < (v4 as u128) * (arg5.small_tail_merge_threshold_bps as u128)
            } else {
                false
            }
        } else {
            false
        };
        let v9 = if (v8) {
            v6
        } else {
            0x1::u64::min(arg6, v6)
        };
        let v10 = (((arg5.size as u128) * (0x1::u64::min(arg5.max_one_execution_amount_bps, 10000) as u128) / 10000) as u64);
        let v11 = if (v8) {
            0x1::u64::max(v10 - v10 % v1, v9)
        } else {
            v10 - v10 % v1
        };
        let v12 = if (v5 > 0 && v9 < v11) {
            0x1::u64::min(v5, v11 - v9)
        } else {
            0
        };
        let v13 = v9 + v12;
        assert!(v13 <= v11, 6302);
        let v14 = 0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::clearing_house::start_session_<T0>(arg1, 0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::account::account_id<T0>(arg0), arg2, arg3, false, arg5.integrator_info, arg7);
        let v15 = &v14;
        let v16 = arg5.side == false;
        let v17 = 0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::market::tick_size(0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::clearing_house::market_params<T0>(0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::clearing_house::clearing_house<T0>(v15)));
        let v18 = if (v16) {
            0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(1000000000000000000, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::from_u64fraction(arg5.max_slippage_bps, 10000))
        } else {
            0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::sub(1000000000000000000, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::from_u64fraction(arg5.max_slippage_bps, 10000))
        };
        let v19 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::to_balance(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::clearing_house::mark_price_in_session<T0>(v15), v18), 1000000000);
        let v20 = v19 % v17;
        let v21 = if (v20 == 0) {
            v19
        } else if (v16) {
            v19 - v20
        } else {
            v19 + v17 - v20
        };
        0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::clearing_house::place_limit_order<T0>(&mut v14, arg5.side, v13, v21, 3, 0x1::option::none<u64>(), arg5.reduce_only, 0x1::option::none<u64>());
        let v22 = 0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::clearing_house::summary<T0>(&v14);
        let v23 = 0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::clearing_house::base_filled_bid(v22) != 0 || 0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::clearing_house::base_filled_ask(v22) != 0;
        let v24 = !arg5.reduce_only && v23;
        let (v25, v26) = 0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::clearing_house::end_session_<T0>(v14, arg0, v24, false, true);
        let v27 = v26;
        let v28 = &mut v0;
        let v29 = if (arg5.side == false) {
            0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::to_balance(0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::clearing_house::base_filled_bid(&v27), 1000000000)
        } else {
            0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::to_balance(0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::clearing_house::base_filled_ask(&v27), 1000000000)
        };
        v28.scheduled_amount = v28.scheduled_amount + v9;
        if (v28.last_attempt_timestamp_ms == 0) {
            v28.retry_anchor_timestamp_ms = v2;
        };
        v28.last_attempt_timestamp_ms = v2;
        if (v29 != 0) {
            v28.retry_anchor_timestamp_ms = v2;
            v28.last_execution_timestamp_ms = v2;
            v28.processed_amount = v28.processed_amount + v29;
        };
        0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::events::e37<T0>(0x2::object::uid_to_inner(&v28.id), v0.account_id, v13, v29, unfilled_scheduled_amount<T0>(v28), v28.processed_amount, v28.scheduled_amount, v28.last_attempt_timestamp_ms, v28.retry_anchor_timestamp_ms, v28.last_execution_timestamp_ms);
        let v30 = &mut v0;
        let v31 = (((v30.gas_execution_budget as u128) * (0x1::u64::min(v30.processed_amount, arg5.size) as u128) / (arg5.size as u128)) as u64);
        let v32 = v31 - v30.paid_execution_gas;
        v30.paid_execution_gas = v31;
        let v33 = if (v32 == 0) {
            0x2::balance::zero<0x2::sui::SUI>()
        } else {
            0x2::balance::split<0x2::sui::SUI>(&mut v30.gas, v32)
        };
        0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::account::add_order_ticket<T0, TWAPOrderTicket<T0>>(arg0, v0);
        (v27, 0x2::coin::from_balance<0x2::sui::SUI>(v33, arg9), v25)
    }

    public fun finalize<T0>(arg0: &mut 0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::account::Account<T0>, arg1: &mut 0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::clearing_house::ClearingHouse<T0>, arg2: &0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::price_feed_storage::PriceFeedStorage, arg3: &0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::price_feed_storage::PriceFeedStorage, arg4: &0x2::clock::Clock, arg5: 0x2::object::ID, arg6: &TWAPOrderDetails, arg7: &0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::clearing_house::Executor, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::clearing_house::assert_package_version<T0>(arg1);
        0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::account::assert_order_ticket_exists<T0>(arg0, arg5);
        let v0 = 0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::account::remove_order_ticket<T0, TWAPOrderTicket<T0>>(arg0, arg5);
        let v1 = 0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::clearing_house::executor_sender(arg7);
        assert_valid_ticket_executor<T0>(&v0, arg7);
        assert_valid_ticket_clearing_house<T0>(&v0, 0x2::object::id<0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::clearing_house::ClearingHouse<T0>>(arg1));
        assert_order_details_are_valid(arg6, &v0.encrypted_details);
        assert!(is_complete<T0>(&v0, arg6.size), 6308);
        let v2 = if (!0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::clearing_house::is_market_paused<T0>(arg1)) {
            0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::clearing_house::deallocate_collateral_internal<T0>(arg1, arg0, arg2, arg3, 0x1::option::none<u64>(), arg4)
        } else {
            0
        };
        0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::events::e38<T0>(0x2::object::uid_to_inner(&v0.id), v0.account_id, v1, v2);
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
        0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::events::e40<T0>(0x2::object::uid_to_inner(&v17), v9, v1);
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

    public fun new_details(arg0: 0x1::option::Option<u64>, arg1: 0x1::option::Option<u64>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: bool, arg10: u64, arg11: u64, arg12: bool, arg13: 0x1::option::Option<0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::account::IntegratorInfo>, arg14: vector<u8>) : TWAPOrderDetails {
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

    public fun set_details<T0, T1>(arg0: &mut 0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::account::Account<T0>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::authority::ACCOUNT, T1>, arg2: &0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::registry::Registry, arg3: 0x2::object::ID, arg4: vector<u8>) {
        0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::registry::assert_package_version(arg2);
        0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::account::assert_authority_cap_is_valid<T0, T1>(arg0, arg1);
        0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::account::assert_order_ticket_exists<T0>(arg0, arg3);
        0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::authority::assert_is_admin_or_assistant<T1>();
        let v0 = 0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::account::borrow_mut_order_ticket<T0, TWAPOrderTicket<T0>>(arg0, arg3);
        assert!(!has_attempts<T0>(v0), 6307);
        v0.encrypted_details = arg4;
        0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::events::e41<T0>(0x2::object::uid_to_inner(&v0.id), v0.account_id, arg4);
    }

    public fun set_executors<T0, T1>(arg0: &mut 0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::account::Account<T0>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::authority::ACCOUNT, T1>, arg2: &0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::registry::Registry, arg3: 0x2::object::ID, arg4: vector<address>) {
        0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::registry::assert_package_version(arg2);
        0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::account::assert_authority_cap_is_valid<T0, T1>(arg0, arg1);
        0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::account::assert_order_ticket_exists<T0>(arg0, arg3);
        0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::authority::assert_is_admin_or_assistant<T1>();
        let v0 = 0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::account::borrow_mut_order_ticket<T0, TWAPOrderTicket<T0>>(arg0, arg3);
        assert!(!has_attempts<T0>(v0), 6307);
        v0.executors = arg4;
        0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::events::e42<T0>(0x2::object::uid_to_inner(&v0.id), v0.account_id, arg4);
    }

    public(friend) fun target_chunk_amount(arg0: &TWAPOrderDetails, arg1: u64) : u64 {
        arg0.size / arg1 / arg0.chunks_amount * arg1
    }

    public fun unfilled_scheduled_amount<T0>(arg0: &TWAPOrderTicket<T0>) : u64 {
        arg0.scheduled_amount - arg0.processed_amount
    }

    public fun user_cancel_twap_order<T0, T1>(arg0: &mut 0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::account::Account<T0>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::authority::ACCOUNT, T1>, arg2: &mut 0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::clearing_house::ClearingHouse<T0>, arg3: &0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::price_feed_storage::PriceFeedStorage, arg4: &0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::price_feed_storage::PriceFeedStorage, arg5: 0x2::object::ID, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::clearing_house::assert_package_version<T0>(arg2);
        0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::account::assert_authority_cap_is_valid<T0, T1>(arg0, arg1);
        0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::account::assert_order_ticket_exists<T0>(arg0, arg5);
        let v0 = 0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::account::remove_order_ticket<T0, TWAPOrderTicket<T0>>(arg0, arg5);
        let v1 = 0x2::tx_context::sender(arg7);
        assert_valid_ticket_clearing_house<T0>(&v0, 0x2::object::id<0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::clearing_house::ClearingHouse<T0>>(arg2));
        let v2 = if (v0.processed_amount != 0 && !0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::clearing_house::is_market_paused<T0>(arg2)) {
            0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::clearing_house::deallocate_collateral_internal<T0>(arg2, arg0, arg3, arg4, 0x1::option::none<u64>(), arg6)
        } else {
            0
        };
        0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::events::e39<T0>(0x2::object::uid_to_inner(&v0.id), v0.account_id, v1, v2, v0.processed_amount != 0);
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
        0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::events::e40<T0>(0x2::object::uid_to_inner(&v17), v9, v1);
        0x2::object::delete(v17);
        0x2::coin::from_balance<0x2::sui::SUI>(v7, arg7)
    }

    // decompiled from Move bytecode v7
}

