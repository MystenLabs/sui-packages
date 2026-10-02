module 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account {
    struct PositionKey has copy, drop, store {
        market_id: 0x2::object::ID,
        outcome: u8,
    }

    struct TradingAccount<phantom T0> has key {
        id: 0x2::object::UID,
        protocol_id: 0x2::object::ID,
        owner: address,
        collateral: 0x2::balance::Balance<T0>,
        positions: 0x2::table::Table<PositionKey, u64>,
        session_keys: 0x2::table::Table<vector<u8>, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::SessionKey>,
        order_states: 0x2::table::Table<0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::OrderKey, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::OrderState>,
        order_epoch: u64,
    }

    struct MarginBoundKey has copy, drop, store {
        dummy_field: bool,
    }

    struct QuotaKey has copy, drop, store {
        dummy_field: bool,
    }

    struct QuotaState<phantom T0> has store {
        locked: 0x2::balance::Balance<T0>,
        pending: 0x2::balance::Balance<T0>,
        unlock_at_ms: u64,
    }

    public fun assert_margin_bound_to<T0>(arg0: &TradingAccount<T0>, arg1: 0x2::object::ID) {
        let v0 = MarginBoundKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<MarginBoundKey>(&arg0.id, v0), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::margin_binding_mismatch());
        let v1 = MarginBoundKey{dummy_field: false};
        assert!(*0x2::dynamic_field::borrow<MarginBoundKey, 0x2::object::ID>(&arg0.id, v1) == arg1, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::margin_binding_mismatch());
    }

    public(friend) fun assert_order_domain(arg0: &0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::OrderV1, arg1: vector<u8>, arg2: address, arg3: address, arg4: address) {
        assert!(0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::chain_identifier(arg0) == arg1, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::wrong_domain());
        assert!(0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::package_id(arg0) == arg2, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::wrong_domain());
        assert!(0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::exchange_id(arg0) == arg3, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::wrong_domain());
        assert!(0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::account_id(arg0) == arg4, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::wrong_domain());
    }

    public fun assert_owner<T0>(arg0: &TradingAccount<T0>, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::unauthorized());
    }

    public fun assert_same_protocol<T0>(arg0: &TradingAccount<T0>, arg1: &0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::admin::ProtocolConfig<T0>) {
        assert!(arg0.protocol_id == 0x2::object::id<0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::admin::ProtocolConfig<T0>>(arg1), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::wrong_protocol());
    }

    public(friend) fun bind_margin<T0>(arg0: &mut TradingAccount<T0>, arg1: 0x2::object::ID) {
        let v0 = MarginBoundKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists<MarginBoundKey>(&arg0.id, v0), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::margin_already_bound());
        let v1 = MarginBoundKey{dummy_field: false};
        0x2::dynamic_field::add<MarginBoundKey, 0x2::object::ID>(&mut arg0.id, v1, arg1);
    }

    public(friend) fun bind_or_check_order_state<T0>(arg0: &mut TradingAccount<T0>, arg1: 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::OrderKey, arg2: vector<u8>, arg3: u64) : &mut 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::OrderState {
        if (0x2::table::contains<0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::OrderKey, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::OrderState>(&arg0.order_states, arg1)) {
            let v1 = 0x2::table::borrow_mut<0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::OrderKey, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::OrderState>(&mut arg0.order_states, arg1);
            assert!(0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::state_order_hash(v1) == arg2, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::nonce_conflict());
            v1
        } else {
            0x2::table::add<0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::OrderKey, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::OrderState>(&mut arg0.order_states, arg1, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::new_order_state(arg2, arg3));
            0x2::table::borrow_mut<0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::OrderKey, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::OrderState>(&mut arg0.order_states, arg1)
        }
    }

    public fun bump_order_epoch<T0>(arg0: &mut TradingAccount<T0>, arg1: &0x2::tx_context::TxContext) {
        assert_owner<T0>(arg0, arg1);
        arg0.order_epoch = arg0.order_epoch + 1;
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::events::emit_order_epoch_bumped(arg0.protocol_id, 0x2::object::id<TradingAccount<T0>>(arg0), arg0.order_epoch);
    }

    public(friend) fun bump_order_epoch_internal<T0>(arg0: &mut TradingAccount<T0>) : u64 {
        arg0.order_epoch = arg0.order_epoch + 1;
        arg0.order_epoch
    }

    public fun cancel_order<T0>(arg0: &0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::admin::ProtocolConfig<T0>, arg1: &mut TradingAccount<T0>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::tx_context::TxContext) {
        assert_same_protocol<T0>(arg1, arg0);
        assert_owner<T0>(arg1, arg4);
        let v0 = 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::decode_order(arg2);
        let v1 = 0x2::object::id<0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::admin::ProtocolConfig<T0>>(arg0);
        let v2 = 0x2::object::id<TradingAccount<T0>>(arg1);
        assert_order_domain(&v0, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::admin::expected_chain_identifier<T0>(arg0), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::admin::order_domain_package_id<T0>(arg0), 0x2::object::id_to_address(&v1), 0x2::object::id_to_address(&v2));
        cancel_verified_domain_order<T0>(arg1, v0, arg2, arg3);
    }

    public fun cancel_quota_decrease<T0>(arg0: &mut TradingAccount<T0>, arg1: &0x2::tx_context::TxContext) {
        assert_owner<T0>(arg0, arg1);
        let v0 = arg0.protocol_id;
        let v1 = 0x2::object::id<TradingAccount<T0>>(arg0);
        let v2 = arg0.owner;
        let v3 = quota_state_mut<T0>(arg0);
        assert!(v3.unlock_at_ms > 0, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::quota_no_pending());
        v3.unlock_at_ms = 0;
        let v4 = 0x2::balance::withdraw_all<T0>(&mut v3.pending);
        0x2::balance::join<T0>(&mut v3.locked, v4);
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::events::emit_quota_decrease_cancelled(v0, v1, v2, 0x2::balance::value<T0>(&v4));
    }

    public fun cancel_up_to<T0>(arg0: &mut TradingAccount<T0>, arg1: vector<u8>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert_owner<T0>(arg0, arg3);
        assert!(0x2::table::contains<vector<u8>, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::SessionKey>(&arg0.session_keys, arg1), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::session_key_not_found());
        let v0 = 0x2::table::borrow_mut<vector<u8>, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::SessionKey>(&mut arg0.session_keys, arg1);
        assert!(arg2 > 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::key_nonce_floor(v0), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::floor_not_increased());
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::set_nonce_floor(v0, arg2);
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::events::emit_nonce_floor_raised(arg0.protocol_id, 0x2::object::id<TradingAccount<T0>>(arg0), arg1, arg2);
    }

    public(friend) fun cancel_verified_domain_order<T0>(arg0: &mut TradingAccount<T0>, arg1: 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::OrderV1, arg2: vector<u8>, arg3: vector<u8>) {
        assert!(0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::account_epoch(&arg1) == arg0.order_epoch, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::order_epoch_mismatch());
        let v0 = 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::session_key_id(&arg1);
        assert!(0x2::table::contains<vector<u8>, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::SessionKey>(&arg0.session_keys, v0), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::session_key_not_found());
        let v1 = 0x2::table::borrow<vector<u8>, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::SessionKey>(&arg0.session_keys, v0);
        let v2 = 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::order_hash(&arg2);
        let v3 = 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::key_public_key(v1);
        assert!(0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::verify_order_signature(&v3, &v2, &arg3), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::bad_signature());
        assert!(0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::nonce(&arg1) >= 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::key_nonce_floor(v1), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::nonce_below_floor());
        let v4 = 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::new_order_key(arg0.order_epoch, v0, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::nonce(&arg1));
        let v5 = bind_or_check_order_state<T0>(arg0, v4, v2, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::expiration_ms(&arg1));
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::set_cancelled(v5);
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::events::emit_order_cancelled(arg0.protocol_id, 0x2::object::id<TradingAccount<T0>>(arg0), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::account_epoch(&arg1), v0, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::nonce(&arg1), v2);
    }

    public fun collateral_value<T0>(arg0: &TradingAccount<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.collateral)
    }

    public fun create_account<T0>(arg0: &0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::admin::ProtocolConfig<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = TradingAccount<T0>{
            id           : 0x2::object::new(arg1),
            protocol_id  : 0x2::object::id<0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::admin::ProtocolConfig<T0>>(arg0),
            owner        : 0x2::tx_context::sender(arg1),
            collateral   : 0x2::balance::zero<T0>(),
            positions    : 0x2::table::new<PositionKey, u64>(arg1),
            session_keys : 0x2::table::new<vector<u8>, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::SessionKey>(arg1),
            order_states : 0x2::table::new<0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::OrderKey, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::OrderState>(arg1),
            order_epoch  : 0,
        };
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::events::emit_account_created(0x2::object::id<0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::admin::ProtocolConfig<T0>>(arg0), 0x2::object::id<TradingAccount<T0>>(&v0), 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<TradingAccount<T0>>(v0);
    }

    public(friend) fun credit_collateral<T0>(arg0: &mut TradingAccount<T0>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.collateral, arg1);
    }

    public(friend) fun credit_position<T0>(arg0: &mut TradingAccount<T0>, arg1: 0x2::object::ID, arg2: u8, arg3: u64) {
        let v0 = PositionKey{
            market_id : arg1,
            outcome   : arg2,
        };
        if (0x2::table::contains<PositionKey, u64>(&arg0.positions, v0)) {
            let v1 = 0x2::table::borrow_mut<PositionKey, u64>(&mut arg0.positions, v0);
            *v1 = *v1 + arg3;
        } else {
            0x2::table::add<PositionKey, u64>(&mut arg0.positions, v0, arg3);
        };
    }

    public(friend) fun debit_collateral<T0>(arg0: &mut TradingAccount<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(&mut arg0.collateral, arg1)
    }

    public(friend) fun debit_for_settlement<T0>(arg0: &mut TradingAccount<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        assert!(arg1 > 0, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::quota_zero_amount());
        let v0 = arg1;
        let v1 = 0x2::balance::zero<T0>();
        if (quota_state_exists<T0>(arg0)) {
            let v2 = arg0.protocol_id;
            let v3 = 0x2::object::id<TradingAccount<T0>>(arg0);
            let v4 = arg0.owner;
            let v5 = 0;
            let v6 = 0;
            let v7 = quota_state_mut<T0>(arg0);
            let v8 = 0x2::balance::value<T0>(&v7.locked);
            if (v8 > 0 && arg1 > 0) {
                let v9 = if (v8 < arg1) {
                    v8
                } else {
                    arg1
                };
                0x2::balance::join<T0>(&mut v1, 0x2::balance::split<T0>(&mut v7.locked, v9));
                v0 = arg1 - v9;
                v5 = v9;
            };
            let v10 = 0x2::balance::value<T0>(&v7.pending);
            if (v10 > 0 && v0 > 0) {
                let v11 = if (v10 < v0) {
                    v10
                } else {
                    v0
                };
                0x2::balance::join<T0>(&mut v1, 0x2::balance::split<T0>(&mut v7.pending, v11));
                v0 = v0 - v11;
                v6 = v10;
            };
            if (v5 + v6 > 0) {
                0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::events::emit_quota_drawn_by_settlement(v2, v3, v4, v5, v6, arg1 - v5 - v6);
            };
        };
        if (v0 > 0) {
            assert!(0x2::balance::value<T0>(&arg0.collateral) >= v0, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::quota_insufficient_collateral());
            0x2::balance::join<T0>(&mut v1, 0x2::balance::split<T0>(&mut arg0.collateral, v0));
        };
        v1
    }

    public(friend) fun debit_position<T0>(arg0: &mut TradingAccount<T0>, arg1: 0x2::object::ID, arg2: u8, arg3: u64) {
        let v0 = PositionKey{
            market_id : arg1,
            outcome   : arg2,
        };
        let v1 = 0x2::table::borrow_mut<PositionKey, u64>(&mut arg0.positions, v0);
        *v1 = *v1 - arg3;
    }

    public fun deposit<T0>(arg0: &0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::admin::ProtocolConfig<T0>, arg1: &mut TradingAccount<T0>, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::tx_context::TxContext) {
        assert_same_protocol<T0>(arg1, arg0);
        assert_owner<T0>(arg1, arg3);
        assert!(!0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::admin::is_paused<T0>(arg0, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::admin::pause_deposit_and_split_flag()), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::paused());
        let v0 = 0x2::balance::value<T0>(&arg2);
        assert!(v0 > 0, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::zero_amount());
        0x2::balance::join<T0>(&mut arg1.collateral, arg2);
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::events::emit_deposited(arg1.protocol_id, 0x2::object::id<TradingAccount<T0>>(arg1), arg1.owner, v0, 0x2::balance::value<T0>(&arg1.collateral));
    }

    public fun execute_quota_decrease<T0>(arg0: &mut TradingAccount<T0>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert_owner<T0>(arg0, arg2);
        let v0 = arg0.protocol_id;
        let v1 = 0x2::object::id<TradingAccount<T0>>(arg0);
        let v2 = arg0.owner;
        let v3 = quota_state_mut<T0>(arg0);
        assert!(v3.unlock_at_ms > 0, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::quota_no_pending());
        assert!(0x2::clock::timestamp_ms(arg1) >= v3.unlock_at_ms, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::quota_timelock_active());
        v3.unlock_at_ms = 0;
        let v4 = 0x2::balance::withdraw_all<T0>(&mut v3.pending);
        0x2::balance::join<T0>(&mut arg0.collateral, v4);
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::events::emit_quota_decrease_executed(v0, v1, v2, 0x2::balance::value<T0>(&v4));
    }

    public fun lock_quota_coin<T0>(arg0: &0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::admin::ProtocolConfig<T0>, arg1: &mut TradingAccount<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::tx_context::TxContext) {
        deposit<T0>(arg0, arg1, 0x2::coin::into_balance<T0>(arg2), arg3);
        lock_quota_from_collateral<T0>(arg1, 0x2::coin::value<T0>(&arg2), arg3);
    }

    public fun lock_quota_from_collateral<T0>(arg0: &mut TradingAccount<T0>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert_owner<T0>(arg0, arg2);
        assert!(arg1 > 0, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::quota_zero_amount());
        assert!(0x2::balance::value<T0>(&arg0.collateral) >= arg1, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::quota_insufficient_collateral());
        let v0 = 0x2::balance::split<T0>(&mut arg0.collateral, arg1);
        let v1 = arg0.protocol_id;
        let v2 = 0x2::object::id<TradingAccount<T0>>(arg0);
        let v3 = arg0.owner;
        let v4 = quota_state_mut<T0>(arg0);
        0x2::balance::join<T0>(&mut v4.locked, v0);
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::events::emit_quota_locked(v1, v2, v3, arg1, 0x2::balance::value<T0>(&v4.locked));
    }

    public fun locked_quota_value<T0>(arg0: &TradingAccount<T0>) : u64 {
        if (quota_state_exists<T0>(arg0)) {
            0x2::balance::value<T0>(&quota_state_borrow<T0>(arg0).locked)
        } else {
            0
        }
    }

    public fun margin_bound<T0>(arg0: &TradingAccount<T0>) : bool {
        let v0 = MarginBoundKey{dummy_field: false};
        0x2::dynamic_field::exists<MarginBoundKey>(&arg0.id, v0)
    }

    public fun order_epoch<T0>(arg0: &TradingAccount<T0>) : u64 {
        arg0.order_epoch
    }

    public(friend) fun order_states<T0>(arg0: &TradingAccount<T0>) : &0x2::table::Table<0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::OrderKey, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::OrderState> {
        &arg0.order_states
    }

    public(friend) fun order_states_mut<T0>(arg0: &mut TradingAccount<T0>) : &mut 0x2::table::Table<0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::OrderKey, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::OrderState> {
        &mut arg0.order_states
    }

    public fun owner<T0>(arg0: &TradingAccount<T0>) : address {
        arg0.owner
    }

    public fun pending_quota_value<T0>(arg0: &TradingAccount<T0>) : u64 {
        if (quota_state_exists<T0>(arg0)) {
            0x2::balance::value<T0>(&quota_state_borrow<T0>(arg0).pending)
        } else {
            0
        }
    }

    public fun position_of<T0>(arg0: &TradingAccount<T0>, arg1: 0x2::object::ID, arg2: u8) : u64 {
        let v0 = PositionKey{
            market_id : arg1,
            outcome   : arg2,
        };
        if (0x2::table::contains<PositionKey, u64>(&arg0.positions, v0)) {
            *0x2::table::borrow<PositionKey, u64>(&arg0.positions, v0)
        } else {
            0
        }
    }

    public fun protocol_id<T0>(arg0: &TradingAccount<T0>) : 0x2::object::ID {
        arg0.protocol_id
    }

    public fun prune_order_state<T0>(arg0: &mut TradingAccount<T0>, arg1: u64, arg2: vector<u8>, arg3: u64, arg4: &0x2::clock::Clock) {
        let v0 = 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::new_order_key(arg1, arg2, arg3);
        assert!(0x2::table::contains<0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::OrderKey, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::OrderState>(&arg0.order_states, v0), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::prune_not_allowed());
        let v1 = if (arg1 < arg0.order_epoch) {
            true
        } else if (0x2::table::contains<vector<u8>, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::SessionKey>(&arg0.session_keys, arg2)) {
            let v2 = 0x2::table::borrow<vector<u8>, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::SessionKey>(&arg0.session_keys, arg2);
            if (0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::key_revoked(v2)) {
                true
            } else if (arg3 < 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::key_nonce_floor(v2)) {
                true
            } else {
                0x2::clock::timestamp_ms(arg4) >= 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::key_valid_until_ms(v2) + 86400000
            }
        } else {
            false
        };
        assert!(v1, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::prune_not_allowed());
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::destroy_order_state(0x2::table::remove<0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::OrderKey, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::OrderState>(&mut arg0.order_states, v0));
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::events::emit_order_state_pruned(arg0.protocol_id, 0x2::object::id<TradingAccount<T0>>(arg0), arg1, arg2, arg3);
    }

    fun quota_state_borrow<T0>(arg0: &TradingAccount<T0>) : &QuotaState<T0> {
        let v0 = QuotaKey{dummy_field: false};
        0x2::dynamic_field::borrow<QuotaKey, QuotaState<T0>>(&arg0.id, v0)
    }

    fun quota_state_exists<T0>(arg0: &TradingAccount<T0>) : bool {
        let v0 = QuotaKey{dummy_field: false};
        0x2::dynamic_field::exists<QuotaKey>(&arg0.id, v0)
    }

    fun quota_state_mut<T0>(arg0: &mut TradingAccount<T0>) : &mut QuotaState<T0> {
        if (!quota_state_exists<T0>(arg0)) {
            let v0 = QuotaKey{dummy_field: false};
            let v1 = QuotaState<T0>{
                locked       : 0x2::balance::zero<T0>(),
                pending      : 0x2::balance::zero<T0>(),
                unlock_at_ms : 0,
            };
            0x2::dynamic_field::add<QuotaKey, QuotaState<T0>>(&mut arg0.id, v0, v1);
        };
        let v2 = QuotaKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<QuotaKey, QuotaState<T0>>(&mut arg0.id, v2)
    }

    public fun quota_unlock_at_ms<T0>(arg0: &TradingAccount<T0>) : u64 {
        if (quota_state_exists<T0>(arg0)) {
            quota_state_borrow<T0>(arg0).unlock_at_ms
        } else {
            0
        }
    }

    public fun register_session_key<T0>(arg0: &0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::admin::ProtocolConfig<T0>, arg1: &mut TradingAccount<T0>, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        assert_same_protocol<T0>(arg1, arg0);
        assert_owner<T0>(arg1, arg7);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::session_key_invalid());
        let v0 = 0x2::clock::timestamp_ms(arg6);
        assert!(v0 < arg3, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::session_key_expired());
        assert!(arg3 <= v0 + 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::admin::max_session_key_lifetime_ms<T0>(arg0), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::session_lifetime_exceeded());
        assert!(arg4 > 0, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::session_key_invalid());
        assert!(arg4 <= 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::admin::max_session_order_notional_e6<T0>(arg0), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::session_notional_exceeded());
        let v1 = 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::session_key_id_from_public_key(&arg2);
        assert!(!0x2::table::contains<vector<u8>, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::SessionKey>(&arg1.session_keys, v1), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::session_key_exists());
        0x2::table::add<vector<u8>, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::SessionKey>(&mut arg1.session_keys, v1, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::new_session_key(arg2, arg3, arg4));
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::events::emit_session_key_registered(arg1.protocol_id, 0x2::object::id<TradingAccount<T0>>(arg1), v1, arg2, arg3, arg4, arg5);
    }

    public fun request_quota_decrease<T0>(arg0: &mut TradingAccount<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert_owner<T0>(arg0, arg3);
        assert!(!margin_bound<T0>(arg0), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::account_margin_bound());
        assert!(arg1 > 0, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::quota_zero_amount());
        let v0 = arg0.protocol_id;
        let v1 = 0x2::object::id<TradingAccount<T0>>(arg0);
        let v2 = arg0.owner;
        let v3 = quota_state_mut<T0>(arg0);
        assert!(v3.unlock_at_ms == 0, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::quota_decrease_pending());
        assert!(0x2::balance::value<T0>(&v3.locked) >= arg1, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::quota_insufficient_locked());
        0x2::balance::join<T0>(&mut v3.pending, 0x2::balance::split<T0>(&mut v3.locked, arg1));
        let v4 = 0x2::clock::timestamp_ms(arg2) + 3600000;
        v3.unlock_at_ms = v4;
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::events::emit_quota_decrease_requested(v0, v1, v2, arg1, v4, 0x2::balance::value<T0>(&v3.locked));
    }

    public fun revoke_session_key<T0>(arg0: &mut TradingAccount<T0>, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        assert_owner<T0>(arg0, arg2);
        assert!(0x2::table::contains<vector<u8>, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::SessionKey>(&arg0.session_keys, arg1), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::session_key_not_found());
        let v0 = 0x2::table::borrow_mut<vector<u8>, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::SessionKey>(&mut arg0.session_keys, arg1);
        assert!(!0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::key_revoked(v0), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::session_key_revoked());
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::set_revoked(v0);
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::events::emit_session_key_revoked(arg0.protocol_id, 0x2::object::id<TradingAccount<T0>>(arg0), arg1);
    }

    public(friend) fun session_keys<T0>(arg0: &TradingAccount<T0>) : &0x2::table::Table<vector<u8>, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::SessionKey> {
        &arg0.session_keys
    }

    public(friend) fun session_keys_mut<T0>(arg0: &mut TradingAccount<T0>) : &mut 0x2::table::Table<vector<u8>, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::SessionKey> {
        &mut arg0.session_keys
    }

    public fun settleable_value<T0>(arg0: &TradingAccount<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.collateral) + locked_quota_value<T0>(arg0) + pending_quota_value<T0>(arg0)
    }

    public(friend) fun unbind_margin<T0>(arg0: &mut TradingAccount<T0>, arg1: 0x2::object::ID) {
        let v0 = MarginBoundKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<MarginBoundKey>(&arg0.id, v0), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::margin_binding_mismatch());
        let v1 = MarginBoundKey{dummy_field: false};
        assert!(0x2::dynamic_field::remove<MarginBoundKey, 0x2::object::ID>(&mut arg0.id, v1) == arg1, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::margin_binding_mismatch());
    }

    public fun withdraw_balance<T0>(arg0: &mut TradingAccount<T0>, arg1: u64, arg2: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        assert_owner<T0>(arg0, arg2);
        assert!(!margin_bound<T0>(arg0), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::account_margin_bound());
        assert!(arg1 > 0, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::zero_amount());
        assert!(0x2::balance::value<T0>(&arg0.collateral) >= arg1, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::insufficient_collateral());
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::events::emit_withdrawn(arg0.protocol_id, 0x2::object::id<TradingAccount<T0>>(arg0), arg0.owner, arg1, 0x2::balance::value<T0>(&arg0.collateral));
        0x2::balance::split<T0>(&mut arg0.collateral, arg1)
    }

    public fun withdraw_coin<T0>(arg0: &mut TradingAccount<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(withdraw_balance<T0>(arg0, arg1, arg2), arg2)
    }

    // decompiled from Move bytecode v7
}

