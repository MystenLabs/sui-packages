module 0x75dde20ab838ad72cff25f552bd5f80d46966d8cc038a0a9fc21b36c020ee287::order {
    struct TpslLevel has copy, drop, store {
        id: u64,
        trigger_price: u128,
        execution_price: u128,
        close_ratio_bps: u64,
        target_is_base: bool,
    }

    struct OrphanDfKey has copy, drop, store {
        order_id: 0x2::object::ID,
    }

    struct ExecutionRecord has copy, drop, store {
        trigger_type: u8,
        level_ids: vector<u64>,
        actual_price: u128,
        effective_close_ratio_bps: u64,
        settlement_amount: u64,
        settlement_coin_type: 0x1::type_name::TypeName,
        keeper: address,
        timestamp: u64,
    }

    struct Order has store, key {
        id: 0x2::object::UID,
        order_book_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        position_cap: 0x1::option::Option<0x51bfedf86b5e18076f844bf0e1f82b14667bce59e2c38a8b5c8752ba3314bbd3::position::PositionCap>,
        tp_levels: vector<TpslLevel>,
        sl_levels: vector<TpslLevel>,
        next_level_id: u128,
        executions: vector<ExecutionRecord>,
        settlements: 0x2::bag::Bag,
        is_long: bool,
        entry_price: u128,
        status: u8,
        created_ts: u64,
        updated_ts: u64,
    }

    struct OrderCap has store, key {
        id: 0x2::object::UID,
        order_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
    }

    struct OrderBook<phantom T0, phantom T1, phantom T2> has key {
        id: 0x2::object::UID,
        market_id: 0x2::object::ID,
        order_index: 0x2::table::Table<0x2::object::ID, 0x2::object::ID>,
        fees: 0x2::bag::Bag,
        num_orders: u64,
        fee_rate_bps: u64,
        fee_cap: u64,
        max_price_age_seconds: u64,
        is_active: bool,
    }

    struct ExecuteReceipt {
        order_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        trigger_type: u8,
        triggered_level_id: u64,
        effective_close_ratio_bps: u64,
        is_full_close: bool,
        current_price: u128,
        execution_price: u128,
        debt_to_repay: u64,
        collateral_underlying: u64,
        target_is_base: bool,
        fee_amount_in_collateral: u64,
    }

    struct OrderCreatedEvent has copy, drop {
        order_id: 0x2::object::ID,
        order_cap_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        is_long: bool,
        entry_price: u128,
    }

    struct OrderCancelledEvent has copy, drop {
        order_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
    }

    struct OrderPartialExecutedEvent has copy, drop {
        order_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        executor: address,
        trigger_type: u8,
        triggered_level_ids: vector<u64>,
        effective_close_ratio_bps: u64,
        current_price: u128,
        fee_amount: u64,
        settlement_amount: u64,
        settlement_coin_type: 0x1::type_name::TypeName,
    }

    struct OrderExecutedEvent has copy, drop {
        order_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        executor: address,
        trigger_type: u8,
        triggered_level_ids: vector<u64>,
        current_price: u128,
        fee_amount: u64,
        settlement_amount: u64,
        settlement_coin_type: 0x1::type_name::TypeName,
    }

    struct SettlementClaimedEvent has copy, drop {
        order_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        claimer: address,
        amount: u64,
        settlement_coin_type: 0x1::type_name::TypeName,
    }

    struct OrderClosedEvent has copy, drop {
        order_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
    }

    struct OrphanOrderCleanedEvent has copy, drop {
        order_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
    }

    struct OrphanPositionClaimedEvent has copy, drop {
        order_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        claimer: address,
    }

    struct PositionCapParkedEvent has copy, drop {
        order_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
    }

    struct PositionCapReclaimedEvent has copy, drop {
        order_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        claimer: address,
    }

    struct OrderBookCreatedEvent has copy, drop {
        order_book_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
    }

    struct OrderBookPausedEvent has copy, drop {
        order_book_id: 0x2::object::ID,
        is_active: bool,
    }

    struct TpslLevelAddedEvent has copy, drop {
        order_id: 0x2::object::ID,
        level_id: u64,
        trigger_type: u8,
        trigger_price: u128,
        execution_price: u128,
        close_ratio_bps: u64,
        target_is_base: bool,
    }

    struct TpslLevelRemovedEvent has copy, drop {
        order_id: 0x2::object::ID,
        level_id: u64,
    }

    struct TpslLevelUpdatedEvent has copy, drop {
        order_id: 0x2::object::ID,
        level_id: u64,
        trigger_price: u128,
        execution_price: u128,
        close_ratio_bps: u64,
        target_is_base: bool,
    }

    public(friend) fun accumulate_fee<T0, T1, T2, T3>(arg0: &mut OrderBook<T0, T1, T2>, arg1: 0x2::balance::Balance<T3>) {
        let v0 = 0x1::type_name::with_defining_ids<T3>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.fees, v0)) {
            0x2::balance::join<T3>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T3>>(&mut arg0.fees, v0), arg1);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T3>>(&mut arg0.fees, v0, arg1);
        };
    }

    fun add_order_index<T0, T1, T2>(arg0: &mut OrderBook<T0, T1, T2>, arg1: 0x2::object::ID, arg2: 0x2::object::ID) {
        0x2::table::add<0x2::object::ID, 0x2::object::ID>(&mut arg0.order_index, arg1, arg2);
        arg0.num_orders = arg0.num_orders + 1;
    }

    public(friend) fun add_settlement<T0>(arg0: &mut Order, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.settlements, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.settlements, v0), arg1);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.settlements, v0, arg1);
        };
    }

    public(friend) fun add_tpsl_level(arg0: &mut Order, arg1: u8, arg2: u128, arg3: u128, arg4: u64, arg5: bool) : u64 {
        let v0 = arg0.next_level_id;
        assert!(v0 < 18446744073709551615, 13906837764937482263);
        let v1 = (v0 as u64);
        arg0.next_level_id = v0 + 1;
        let v2 = TpslLevel{
            id              : v1,
            trigger_price   : arg2,
            execution_price : arg3,
            close_ratio_bps : arg4,
            target_is_base  : arg5,
        };
        if (arg1 == 0) {
            0x1::vector::push_back<TpslLevel>(&mut arg0.tp_levels, v2);
        } else {
            0x1::vector::push_back<TpslLevel>(&mut arg0.sl_levels, v2);
        };
        v1
    }

    public(friend) fun assert_market_matches(arg0: &Order, arg1: 0x2::object::ID) {
        assert!(arg0.market_id == arg1, 13906838306102312967);
    }

    public(friend) fun assert_order_book_matches<T0, T1, T2>(arg0: &OrderBook<T0, T1, T2>, arg1: &Order) {
        assert!(arg1.order_book_id == 0x2::object::id<OrderBook<T0, T1, T2>>(arg0), 13906838284627345413);
        assert!(arg1.market_id == arg0.market_id, 13906838288922312709);
    }

    public(friend) fun assert_order_cap_matches(arg0: &Order, arg1: &OrderCap) {
        assert!(arg1.order_id == 0x2::object::uid_to_inner(&arg0.id), 13906838263152377859);
        assert!(arg1.position_id == arg0.position_id, 13906838267447345155);
    }

    public(friend) fun assert_receipt_matches_order(arg0: &Order, arg1: &ExecuteReceipt) {
        assert!(arg1.order_id == 0x2::object::uid_to_inner(&arg0.id), 13906838323282313225);
        assert!(arg1.position_id == arg0.position_id, 13906838327577280521);
    }

    public fun bps_denominator() : u64 {
        10000
    }

    public(friend) fun cancel<T0, T1, T2>(arg0: &mut OrderBook<T0, T1, T2>, arg1: Order, arg2: OrderCap) : 0x51bfedf86b5e18076f844bf0e1f82b14667bce59e2c38a8b5c8752ba3314bbd3::position::PositionCap {
        assert_order_book_matches<T0, T1, T2>(arg0, &arg1);
        assert_order_cap_matches(&arg1, &arg2);
        let OrderCap {
            id          : v0,
            order_id    : v1,
            position_id : _,
        } = arg2;
        0x2::object::delete(v0);
        assert!(arg1.status == 0, 13906837120691863567);
        let (v3, v4, v5, _) = destroy_order(arg1);
        assert!(v1 == v3, 13906837129281011715);
        remove_order_index<T0, T1, T2>(arg0, v4);
        let v7 = OrderCancelledEvent{
            order_id    : v3,
            position_id : v4,
        };
        0x2::event::emit<OrderCancelledEvent>(v7);
        0x1::option::destroy_some<0x51bfedf86b5e18076f844bf0e1f82b14667bce59e2c38a8b5c8752ba3314bbd3::position::PositionCap>(v5)
    }

    public(friend) fun claim_orphan<T0, T1, T2>(arg0: &mut OrderBook<T0, T1, T2>, arg1: OrderCap) : 0x51bfedf86b5e18076f844bf0e1f82b14667bce59e2c38a8b5c8752ba3314bbd3::position::PositionCap {
        let OrderCap {
            id          : v0,
            order_id    : v1,
            position_id : _,
        } = arg1;
        0x2::object::delete(v0);
        let v3 = OrphanDfKey{order_id: v1};
        assert!(0x2::dynamic_field::exists_<OrphanDfKey>(&arg0.id, v3), 13906837455699181581);
        0x2::dynamic_field::remove<OrphanDfKey, 0x51bfedf86b5e18076f844bf0e1f82b14667bce59e2c38a8b5c8752ba3314bbd3::position::PositionCap>(&mut arg0.id, v3)
    }

    public(friend) fun cleanup_and_claim_orphan<T0, T1, T2>(arg0: &mut OrderBook<T0, T1, T2>, arg1: Order, arg2: OrderCap) : 0x51bfedf86b5e18076f844bf0e1f82b14667bce59e2c38a8b5c8752ba3314bbd3::position::PositionCap {
        assert_order_book_matches<T0, T1, T2>(arg0, &arg1);
        assert_order_cap_matches(&arg1, &arg2);
        let OrderCap {
            id          : v0,
            order_id    : v1,
            position_id : _,
        } = arg2;
        0x2::object::delete(v0);
        let (v3, v4) = cleanup_orphan<T0, T1, T2>(arg0, arg1);
        assert!(v1 == v4, 13906837404158918659);
        v3
    }

    public(friend) fun cleanup_orphan<T0, T1, T2>(arg0: &mut OrderBook<T0, T1, T2>, arg1: Order) : (0x51bfedf86b5e18076f844bf0e1f82b14667bce59e2c38a8b5c8752ba3314bbd3::position::PositionCap, 0x2::object::ID) {
        assert_order_book_matches<T0, T1, T2>(arg0, &arg1);
        let (v0, v1, v2, _) = destroy_order(arg1);
        remove_order_index<T0, T1, T2>(arg0, v1);
        let v4 = OrphanOrderCleanedEvent{
            order_id    : v0,
            position_id : v1,
        };
        0x2::event::emit<OrphanOrderCleanedEvent>(v4);
        (0x1::option::destroy_some<0x51bfedf86b5e18076f844bf0e1f82b14667bce59e2c38a8b5c8752ba3314bbd3::position::PositionCap>(v2), v0)
    }

    public(friend) fun clear_all_levels(arg0: &mut Order) {
        arg0.tp_levels = 0x1::vector::empty<TpslLevel>();
        arg0.sl_levels = 0x1::vector::empty<TpslLevel>();
    }

    public(friend) fun close<T0, T1, T2>(arg0: &mut OrderBook<T0, T1, T2>, arg1: Order, arg2: OrderCap) {
        assert_order_book_matches<T0, T1, T2>(arg0, &arg1);
        assert_order_cap_matches(&arg1, &arg2);
        let OrderCap {
            id          : v0,
            order_id    : v1,
            position_id : _,
        } = arg2;
        0x2::object::delete(v0);
        assert!(arg1.status == 2, 13906837215181275153);
        let (v3, v4, v5, _) = destroy_order(arg1);
        assert!(v1 == v3, 13906837223770292227);
        0x1::option::destroy_none<0x51bfedf86b5e18076f844bf0e1f82b14667bce59e2c38a8b5c8752ba3314bbd3::position::PositionCap>(v5);
        remove_order_index<T0, T1, T2>(arg0, v4);
        let v7 = OrderClosedEvent{
            order_id    : v3,
            position_id : v4,
        };
        0x2::event::emit<OrderClosedEvent>(v7);
    }

    public fun close_ratio_bps(arg0: &TpslLevel) : u64 {
        arg0.close_ratio_bps
    }

    public(friend) fun complete(arg0: &mut Order, arg1: u64) {
        arg0.status = 2;
        arg0.updated_ts = arg1;
    }

    public fun create_order_book<T0, T1, T2>(arg0: &0x75dde20ab838ad72cff25f552bd5f80d46966d8cc038a0a9fc21b36c020ee287::global_config::AdminCap, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = new_order_book<T0, T1, T2>(arg1, arg2, arg3, arg4, arg5);
        let v1 = OrderBookCreatedEvent{
            order_book_id : 0x2::object::id<OrderBook<T0, T1, T2>>(&v0),
            market_id     : arg1,
        };
        0x2::event::emit<OrderBookCreatedEvent>(v1);
        0x2::transfer::share_object<OrderBook<T0, T1, T2>>(v0);
    }

    public fun create_order_book_with_registry<T0, T1, T2>(arg0: &0x75dde20ab838ad72cff25f552bd5f80d46966d8cc038a0a9fc21b36c020ee287::global_config::AdminCap, arg1: &mut 0x75dde20ab838ad72cff25f552bd5f80d46966d8cc038a0a9fc21b36c020ee287::order_book_registry::OrderBookRegistry, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = new_order_book<T0, T1, T2>(arg2, arg3, arg4, arg5, arg6);
        let v1 = 0x2::object::id<OrderBook<T0, T1, T2>>(&v0);
        0x75dde20ab838ad72cff25f552bd5f80d46966d8cc038a0a9fc21b36c020ee287::order_book_registry::register(arg1, arg2, v1);
        let v2 = OrderBookCreatedEvent{
            order_book_id : v1,
            market_id     : arg2,
        };
        0x2::event::emit<OrderBookCreatedEvent>(v2);
        0x2::transfer::share_object<OrderBook<T0, T1, T2>>(v0);
    }

    public fun created_ts(arg0: &Order) : u64 {
        arg0.created_ts
    }

    fun destroy_order(arg0: Order) : (0x2::object::ID, 0x2::object::ID, 0x1::option::Option<0x51bfedf86b5e18076f844bf0e1f82b14667bce59e2c38a8b5c8752ba3314bbd3::position::PositionCap>, u8) {
        let Order {
            id            : v0,
            order_book_id : _,
            market_id     : _,
            position_id   : v3,
            position_cap  : v4,
            tp_levels     : _,
            sl_levels     : _,
            next_level_id : _,
            executions    : _,
            settlements   : v9,
            is_long       : _,
            entry_price   : _,
            status        : v12,
            created_ts    : _,
            updated_ts    : _,
        } = arg0;
        let v15 = v9;
        let v16 = v0;
        assert!(0x2::bag::is_empty(&v15), 13906836326123175955);
        0x2::bag::destroy_empty(v15);
        0x2::object::delete(v16);
        (0x2::object::uid_to_inner(&v16), v3, v4, v12)
    }

    public(friend) fun destroy_receipt(arg0: ExecuteReceipt) : (0x2::object::ID, 0x2::object::ID, u8, u64, u64, bool, u128, u128, u64, u64, bool, u64) {
        let ExecuteReceipt {
            order_id                  : v0,
            position_id               : v1,
            trigger_type              : v2,
            triggered_level_id        : v3,
            effective_close_ratio_bps : v4,
            is_full_close             : v5,
            current_price             : v6,
            execution_price           : v7,
            debt_to_repay             : v8,
            collateral_underlying     : v9,
            target_is_base            : v10,
            fee_amount_in_collateral  : v11,
        } = arg0;
        (v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11)
    }

    public(friend) fun emit_cap_reclaimed(arg0: &Order, arg1: address) {
        let v0 = PositionCapReclaimedEvent{
            order_id    : 0x2::object::id<Order>(arg0),
            position_id : arg0.position_id,
            claimer     : arg1,
        };
        0x2::event::emit<PositionCapReclaimedEvent>(v0);
    }

    public(friend) fun emit_full_executed(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u8, arg4: vector<u64>, arg5: u128, arg6: u64, arg7: u64, arg8: 0x1::type_name::TypeName) {
        let v0 = OrderExecutedEvent{
            order_id             : arg0,
            position_id          : arg1,
            executor             : arg2,
            trigger_type         : arg3,
            triggered_level_ids  : arg4,
            current_price        : arg5,
            fee_amount           : arg6,
            settlement_amount    : arg7,
            settlement_coin_type : arg8,
        };
        0x2::event::emit<OrderExecutedEvent>(v0);
    }

    public(friend) fun emit_orphan_claimed(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address) {
        let v0 = OrphanPositionClaimedEvent{
            order_id    : arg0,
            position_id : arg1,
            claimer     : arg2,
        };
        0x2::event::emit<OrphanPositionClaimedEvent>(v0);
    }

    public(friend) fun emit_partial_executed(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u8, arg4: vector<u64>, arg5: u64, arg6: u128, arg7: u64, arg8: u64, arg9: 0x1::type_name::TypeName) {
        let v0 = OrderPartialExecutedEvent{
            order_id                  : arg0,
            position_id               : arg1,
            executor                  : arg2,
            trigger_type              : arg3,
            triggered_level_ids       : arg4,
            effective_close_ratio_bps : arg5,
            current_price             : arg6,
            fee_amount                : arg7,
            settlement_amount         : arg8,
            settlement_coin_type      : arg9,
        };
        0x2::event::emit<OrderPartialExecutedEvent>(v0);
    }

    public(friend) fun emit_settlement_claimed(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: 0x1::type_name::TypeName) {
        let v0 = SettlementClaimedEvent{
            order_id             : arg0,
            position_id          : arg1,
            claimer              : arg2,
            amount               : arg3,
            settlement_coin_type : arg4,
        };
        0x2::event::emit<SettlementClaimedEvent>(v0);
    }

    public(friend) fun emit_tpsl_level_added(arg0: 0x2::object::ID, arg1: u64, arg2: u8, arg3: u128, arg4: u128, arg5: u64, arg6: bool) {
        let v0 = TpslLevelAddedEvent{
            order_id        : arg0,
            level_id        : arg1,
            trigger_type    : arg2,
            trigger_price   : arg3,
            execution_price : arg4,
            close_ratio_bps : arg5,
            target_is_base  : arg6,
        };
        0x2::event::emit<TpslLevelAddedEvent>(v0);
    }

    public(friend) fun emit_tpsl_level_removed(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = TpslLevelRemovedEvent{
            order_id : arg0,
            level_id : arg1,
        };
        0x2::event::emit<TpslLevelRemovedEvent>(v0);
    }

    public(friend) fun emit_tpsl_level_updated(arg0: 0x2::object::ID, arg1: u64, arg2: u128, arg3: u128, arg4: u64, arg5: bool) {
        let v0 = TpslLevelUpdatedEvent{
            order_id        : arg0,
            level_id        : arg1,
            trigger_price   : arg2,
            execution_price : arg3,
            close_ratio_bps : arg4,
            target_is_base  : arg5,
        };
        0x2::event::emit<TpslLevelUpdatedEvent>(v0);
    }

    public fun entry_price(arg0: &Order) : u128 {
        arg0.entry_price
    }

    public fun execution_actual_price(arg0: &ExecutionRecord) : u128 {
        arg0.actual_price
    }

    public fun execution_effective_close_ratio_bps(arg0: &ExecutionRecord) : u64 {
        arg0.effective_close_ratio_bps
    }

    public fun execution_keeper(arg0: &ExecutionRecord) : address {
        arg0.keeper
    }

    public fun execution_level_ids(arg0: &ExecutionRecord) : &vector<u64> {
        &arg0.level_ids
    }

    public fun execution_settlement_amount(arg0: &ExecutionRecord) : u64 {
        arg0.settlement_amount
    }

    public fun execution_settlement_coin_type(arg0: &ExecutionRecord) : 0x1::type_name::TypeName {
        arg0.settlement_coin_type
    }

    public fun execution_timestamp(arg0: &ExecutionRecord) : u64 {
        arg0.timestamp
    }

    public fun execution_trigger_type(arg0: &ExecutionRecord) : u8 {
        arg0.trigger_type
    }

    public fun executions(arg0: &Order) : &vector<ExecutionRecord> {
        &arg0.executions
    }

    public fun fee_amount<T0, T1, T2, T3>(arg0: &OrderBook<T0, T1, T2>) : u64 {
        let v0 = 0x1::type_name::with_defining_ids<T3>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.fees, v0)) {
            0
        } else {
            0x2::balance::value<T3>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T3>>(&arg0.fees, v0))
        }
    }

    public fun fee_cap<T0, T1, T2>(arg0: &OrderBook<T0, T1, T2>) : u64 {
        arg0.fee_cap
    }

    public fun fee_rate_bps<T0, T1, T2>(arg0: &OrderBook<T0, T1, T2>) : u64 {
        arg0.fee_rate_bps
    }

    public fun harvest_fees<T0, T1, T2, T3>(arg0: &mut OrderBook<T0, T1, T2>, arg1: &0x75dde20ab838ad72cff25f552bd5f80d46966d8cc038a0a9fc21b36c020ee287::global_config::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T3>>(&mut arg0.fees, 0x1::type_name::with_defining_ids<T3>()), arg2), 0x2::tx_context::sender(arg2));
    }

    public fun has_order<T0, T1, T2>(arg0: &OrderBook<T0, T1, T2>, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.order_index, arg1)
    }

    public fun has_position_cap(arg0: &Order) : bool {
        0x1::option::is_some<0x51bfedf86b5e18076f844bf0e1f82b14667bce59e2c38a8b5c8752ba3314bbd3::position::PositionCap>(&arg0.position_cap)
    }

    public fun has_settlement_for_type<T0>(arg0: &Order) : bool {
        0x2::bag::contains<0x1::type_name::TypeName>(&arg0.settlements, 0x1::type_name::with_defining_ids<T0>())
    }

    public fun is_active<T0, T1, T2>(arg0: &OrderBook<T0, T1, T2>) : bool {
        arg0.is_active
    }

    public fun is_long(arg0: &Order) : bool {
        arg0.is_long
    }

    public fun level_execution_price(arg0: &TpslLevel) : u128 {
        arg0.execution_price
    }

    public fun level_id(arg0: &TpslLevel) : u64 {
        arg0.id
    }

    public(friend) fun make_tpsl_level(arg0: u64, arg1: u128, arg2: u128, arg3: u64, arg4: bool) : TpslLevel {
        TpslLevel{
            id              : arg0,
            trigger_price   : arg1,
            execution_price : arg2,
            close_ratio_bps : arg3,
            target_is_base  : arg4,
        }
    }

    public fun market_id<T0, T1, T2>(arg0: &OrderBook<T0, T1, T2>) : 0x2::object::ID {
        arg0.market_id
    }

    public fun max_price_age_seconds<T0, T1, T2>(arg0: &OrderBook<T0, T1, T2>) : u64 {
        arg0.max_price_age_seconds
    }

    public(friend) fun new_execution_record(arg0: u8, arg1: vector<u64>, arg2: u128, arg3: u64, arg4: u64, arg5: 0x1::type_name::TypeName, arg6: address, arg7: u64) : ExecutionRecord {
        ExecutionRecord{
            trigger_type              : arg0,
            level_ids                 : arg1,
            actual_price              : arg2,
            effective_close_ratio_bps : arg3,
            settlement_amount         : arg4,
            settlement_coin_type      : arg5,
            keeper                    : arg6,
            timestamp                 : arg7,
        }
    }

    public(friend) fun new_order<T0, T1, T2>(arg0: &OrderBook<T0, T1, T2>, arg1: 0x51bfedf86b5e18076f844bf0e1f82b14667bce59e2c38a8b5c8752ba3314bbd3::position::PositionCap, arg2: 0x2::object::ID, arg3: bool, arg4: u128, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : (Order, OrderCap) {
        let v0 = 0x51bfedf86b5e18076f844bf0e1f82b14667bce59e2c38a8b5c8752ba3314bbd3::position::position_cap_position_id(&arg1);
        assert!(!0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.order_index, v0), 13906836437791145985);
        let v1 = Order{
            id            : 0x2::object::new(arg6),
            order_book_id : 0x2::object::id<OrderBook<T0, T1, T2>>(arg0),
            market_id     : arg2,
            position_id   : v0,
            position_cap  : 0x1::option::some<0x51bfedf86b5e18076f844bf0e1f82b14667bce59e2c38a8b5c8752ba3314bbd3::position::PositionCap>(arg1),
            tp_levels     : 0x1::vector::empty<TpslLevel>(),
            sl_levels     : 0x1::vector::empty<TpslLevel>(),
            next_level_id : 0,
            executions    : 0x1::vector::empty<ExecutionRecord>(),
            settlements   : 0x2::bag::new(arg6),
            is_long       : arg3,
            entry_price   : arg4,
            status        : 0,
            created_ts    : arg5,
            updated_ts    : arg5,
        };
        let v2 = 0x2::object::id<Order>(&v1);
        let v3 = OrderCap{
            id          : 0x2::object::new(arg6),
            order_id    : v2,
            position_id : v0,
        };
        let v4 = OrderCreatedEvent{
            order_id     : v2,
            order_cap_id : 0x2::object::id<OrderCap>(&v3),
            position_id  : v0,
            is_long      : arg3,
            entry_price  : arg4,
        };
        0x2::event::emit<OrderCreatedEvent>(v4);
        (v1, v3)
    }

    fun new_order_book<T0, T1, T2>(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : OrderBook<T0, T1, T2> {
        assert!(arg1 <= 10000, 13906835677581934591);
        OrderBook<T0, T1, T2>{
            id                    : 0x2::object::new(arg4),
            market_id             : arg0,
            order_index           : 0x2::table::new<0x2::object::ID, 0x2::object::ID>(arg4),
            fees                  : 0x2::bag::new(arg4),
            num_orders            : 0,
            fee_rate_bps          : arg1,
            fee_cap               : arg2,
            max_price_age_seconds : arg3,
            is_active             : true,
        }
    }

    public(friend) fun new_receipt(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u8, arg3: u64, arg4: u64, arg5: bool, arg6: u128, arg7: u128, arg8: u64, arg9: u64, arg10: bool, arg11: u64) : ExecuteReceipt {
        ExecuteReceipt{
            order_id                  : arg0,
            position_id               : arg1,
            trigger_type              : arg2,
            triggered_level_id        : arg3,
            effective_close_ratio_bps : arg4,
            is_full_close             : arg5,
            current_price             : arg6,
            execution_price           : arg7,
            debt_to_repay             : arg8,
            collateral_underlying     : arg9,
            target_is_base            : arg10,
            fee_amount_in_collateral  : arg11,
        }
    }

    public fun next_level_id(arg0: &Order) : u128 {
        arg0.next_level_id
    }

    public fun num_executions(arg0: &Order) : u64 {
        0x1::vector::length<ExecutionRecord>(&arg0.executions)
    }

    public fun num_orders<T0, T1, T2>(arg0: &OrderBook<T0, T1, T2>) : u64 {
        arg0.num_orders
    }

    public fun num_sl_levels(arg0: &Order) : u64 {
        0x1::vector::length<TpslLevel>(&arg0.sl_levels)
    }

    public fun num_tp_levels(arg0: &Order) : u64 {
        0x1::vector::length<TpslLevel>(&arg0.tp_levels)
    }

    public fun order_book_id(arg0: &Order) : 0x2::object::ID {
        arg0.order_book_id
    }

    public fun order_id(arg0: &OrderCap) : 0x2::object::ID {
        arg0.order_id
    }

    public fun order_id_by_position<T0, T1, T2>(arg0: &OrderBook<T0, T1, T2>, arg1: 0x2::object::ID) : 0x2::object::ID {
        *0x2::table::borrow<0x2::object::ID, 0x2::object::ID>(&arg0.order_index, arg1)
    }

    public fun order_market_id(arg0: &Order) : 0x2::object::ID {
        arg0.market_id
    }

    public fun order_position_id(arg0: &Order) : 0x2::object::ID {
        arg0.position_id
    }

    public(friend) fun park_cap_post_completion(arg0: &mut Order, arg1: 0x51bfedf86b5e18076f844bf0e1f82b14667bce59e2c38a8b5c8752ba3314bbd3::position::PositionCap) {
        assert!(arg0.status == 2, 13906836845814087697);
        assert!(0x51bfedf86b5e18076f844bf0e1f82b14667bce59e2c38a8b5c8752ba3314bbd3::position::position_cap_position_id(&arg1) == arg0.position_id, 13906836858699513881);
        assert!(0x1::option::is_none<0x51bfedf86b5e18076f844bf0e1f82b14667bce59e2c38a8b5c8752ba3314bbd3::position::PositionCap>(&arg0.position_cap), 13906836867289579547);
        0x1::option::fill<0x51bfedf86b5e18076f844bf0e1f82b14667bce59e2c38a8b5c8752ba3314bbd3::position::PositionCap>(&mut arg0.position_cap, arg1);
        let v0 = PositionCapParkedEvent{
            order_id    : 0x2::object::id<Order>(arg0),
            position_id : arg0.position_id,
        };
        0x2::event::emit<PositionCapParkedEvent>(v0);
    }

    public fun pause<T0, T1, T2>(arg0: &mut OrderBook<T0, T1, T2>, arg1: &0x75dde20ab838ad72cff25f552bd5f80d46966d8cc038a0a9fc21b36c020ee287::global_config::AdminCap) {
        arg0.is_active = false;
        let v0 = OrderBookPausedEvent{
            order_book_id : 0x2::object::id<OrderBook<T0, T1, T2>>(arg0),
            is_active     : false,
        };
        0x2::event::emit<OrderBookPausedEvent>(v0);
    }

    public fun position_id(arg0: &OrderCap) : 0x2::object::ID {
        arg0.position_id
    }

    public(friend) fun push_execution(arg0: &mut Order, arg1: ExecutionRecord) {
        0x1::vector::push_back<ExecutionRecord>(&mut arg0.executions, arg1);
    }

    public fun receipt_collateral_underlying(arg0: &ExecuteReceipt) : u64 {
        arg0.collateral_underlying
    }

    public fun receipt_current_price(arg0: &ExecuteReceipt) : u128 {
        arg0.current_price
    }

    public fun receipt_debt_to_repay(arg0: &ExecuteReceipt) : u64 {
        arg0.debt_to_repay
    }

    public fun receipt_effective_close_ratio_bps(arg0: &ExecuteReceipt) : u64 {
        arg0.effective_close_ratio_bps
    }

    public fun receipt_execution_price(arg0: &ExecuteReceipt) : u128 {
        arg0.execution_price
    }

    public fun receipt_fee_amount_in_collateral(arg0: &ExecuteReceipt) : u64 {
        arg0.fee_amount_in_collateral
    }

    public fun receipt_is_full_close(arg0: &ExecuteReceipt) : bool {
        arg0.is_full_close
    }

    public fun receipt_order_id(arg0: &ExecuteReceipt) : 0x2::object::ID {
        arg0.order_id
    }

    public fun receipt_position_id(arg0: &ExecuteReceipt) : 0x2::object::ID {
        arg0.position_id
    }

    public fun receipt_target_is_base(arg0: &ExecuteReceipt) : bool {
        arg0.target_is_base
    }

    public fun receipt_trigger_type(arg0: &ExecuteReceipt) : u8 {
        arg0.trigger_type
    }

    public fun receipt_triggered_level_id(arg0: &ExecuteReceipt) : u64 {
        arg0.triggered_level_id
    }

    public fun register_existing_order_book<T0, T1, T2>(arg0: &0x75dde20ab838ad72cff25f552bd5f80d46966d8cc038a0a9fc21b36c020ee287::global_config::AdminCap, arg1: &mut 0x75dde20ab838ad72cff25f552bd5f80d46966d8cc038a0a9fc21b36c020ee287::order_book_registry::OrderBookRegistry, arg2: &OrderBook<T0, T1, T2>) {
        0x75dde20ab838ad72cff25f552bd5f80d46966d8cc038a0a9fc21b36c020ee287::order_book_registry::register(arg1, arg2.market_id, 0x2::object::id<OrderBook<T0, T1, T2>>(arg2));
    }

    fun remove_order_index<T0, T1, T2>(arg0: &mut OrderBook<T0, T1, T2>, arg1: 0x2::object::ID) {
        0x2::table::remove<0x2::object::ID, 0x2::object::ID>(&mut arg0.order_index, arg1);
        arg0.num_orders = arg0.num_orders - 1;
    }

    public(friend) fun remove_settlement<T0>(arg0: &mut Order) : 0x2::balance::Balance<T0> {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.settlements, v0), 13906837056267091979);
        0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.settlements, v0)
    }

    public(friend) fun remove_tpsl_level_by_id(arg0: &mut Order, arg1: u64) : u8 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<TpslLevel>(&arg0.tp_levels)) {
            if (0x1::vector::borrow<TpslLevel>(&arg0.tp_levels, v0).id == arg1) {
                0x1::vector::remove<TpslLevel>(&mut arg0.tp_levels, v0);
                return 0
            };
            v0 = v0 + 1;
        };
        v0 = 0;
        while (v0 < 0x1::vector::length<TpslLevel>(&arg0.sl_levels)) {
            if (0x1::vector::borrow<TpslLevel>(&arg0.sl_levels, v0).id == arg1) {
                0x1::vector::remove<TpslLevel>(&mut arg0.sl_levels, v0);
                return 1
            };
            v0 = v0 + 1;
        };
        abort 13906837902376304661
    }

    public(friend) fun remove_triggered_level(arg0: &mut Order, arg1: u8, arg2: u64) {
        let v0 = if (arg1 == 0) {
            &mut arg0.tp_levels
        } else {
            &mut arg0.sl_levels
        };
        let v1 = 0;
        while (v1 < 0x1::vector::length<TpslLevel>(v0)) {
            if (0x1::vector::borrow<TpslLevel>(v0, v1).id == arg2) {
                0x1::vector::remove<TpslLevel>(v0, v1);
                return
            };
            v1 = v1 + 1;
        };
        abort 13906838117124669461
    }

    public fun resume<T0, T1, T2>(arg0: &mut OrderBook<T0, T1, T2>, arg1: &0x75dde20ab838ad72cff25f552bd5f80d46966d8cc038a0a9fc21b36c020ee287::global_config::AdminCap) {
        arg0.is_active = true;
        let v0 = OrderBookPausedEvent{
            order_book_id : 0x2::object::id<OrderBook<T0, T1, T2>>(arg0),
            is_active     : true,
        };
        0x2::event::emit<OrderBookPausedEvent>(v0);
    }

    public(friend) fun return_position_cap(arg0: &mut Order, arg1: 0x51bfedf86b5e18076f844bf0e1f82b14667bce59e2c38a8b5c8752ba3314bbd3::position::PositionCap, arg2: u64) {
        assert!(0x51bfedf86b5e18076f844bf0e1f82b14667bce59e2c38a8b5c8752ba3314bbd3::position::position_cap_position_id(&arg1) == arg0.position_id, 13906836734145462297);
        0x1::option::fill<0x51bfedf86b5e18076f844bf0e1f82b14667bce59e2c38a8b5c8752ba3314bbd3::position::PositionCap>(&mut arg0.position_cap, arg1);
        arg0.status = 0;
        arg0.updated_ts = arg2;
    }

    public fun settlement_amount<T0>(arg0: &Order) : u64 {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.settlements, v0)) {
            0
        } else {
            0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.settlements, v0))
        }
    }

    public fun settlements_empty(arg0: &Order) : bool {
        0x2::bag::is_empty(&arg0.settlements)
    }

    public(friend) fun share_order<T0, T1, T2>(arg0: &mut OrderBook<T0, T1, T2>, arg1: Order) {
        assert!(arg1.order_book_id == 0x2::object::id<OrderBook<T0, T1, T2>>(arg0), 13906836622475001861);
        add_order_index<T0, T1, T2>(arg0, arg1.position_id, 0x2::object::id<Order>(&arg1));
        0x2::transfer::share_object<Order>(arg1);
    }

    public fun sl_levels(arg0: &Order) : &vector<TpslLevel> {
        &arg0.sl_levels
    }

    public fun status(arg0: &Order) : u8 {
        arg0.status
    }

    public fun status_active() : u8 {
        0
    }

    public fun status_completed() : u8 {
        2
    }

    public fun status_executing() : u8 {
        1
    }

    public(friend) fun store_orphan<T0, T1, T2>(arg0: &mut OrderBook<T0, T1, T2>, arg1: 0x2::object::ID, arg2: 0x51bfedf86b5e18076f844bf0e1f82b14667bce59e2c38a8b5c8752ba3314bbd3::position::PositionCap) {
        let v0 = OrphanDfKey{order_id: arg1};
        0x2::dynamic_field::add<OrphanDfKey, 0x51bfedf86b5e18076f844bf0e1f82b14667bce59e2c38a8b5c8752ba3314bbd3::position::PositionCap>(&mut arg0.id, v0, arg2);
    }

    public(friend) fun take_parked_cap(arg0: &mut Order) : 0x51bfedf86b5e18076f844bf0e1f82b14667bce59e2c38a8b5c8752ba3314bbd3::position::PositionCap {
        assert!(arg0.status == 2, 13906836918828531729);
        assert!(0x1::option::is_some<0x51bfedf86b5e18076f844bf0e1f82b14667bce59e2c38a8b5c8752ba3314bbd3::position::PositionCap>(&arg0.position_cap), 13906836923124285469);
        0x1::option::extract<0x51bfedf86b5e18076f844bf0e1f82b14667bce59e2c38a8b5c8752ba3314bbd3::position::PositionCap>(&mut arg0.position_cap)
    }

    public(friend) fun take_position_cap(arg0: &mut Order) : 0x51bfedf86b5e18076f844bf0e1f82b14667bce59e2c38a8b5c8752ba3314bbd3::position::PositionCap {
        assert!(arg0.status == 0, 13906836661130362895);
        arg0.status = 1;
        0x1::option::extract<0x51bfedf86b5e18076f844bf0e1f82b14667bce59e2c38a8b5c8752ba3314bbd3::position::PositionCap>(&mut arg0.position_cap)
    }

    public fun target_is_base(arg0: &TpslLevel) : bool {
        arg0.target_is_base
    }

    public fun tp_levels(arg0: &Order) : &vector<TpslLevel> {
        &arg0.tp_levels
    }

    public fun trigger_price(arg0: &TpslLevel) : u128 {
        arg0.trigger_price
    }

    public fun trigger_sl() : u8 {
        1
    }

    public fun trigger_tp() : u8 {
        0
    }

    public fun update_fee_params<T0, T1, T2>(arg0: &mut OrderBook<T0, T1, T2>, arg1: &0x75dde20ab838ad72cff25f552bd5f80d46966d8cc038a0a9fc21b36c020ee287::global_config::AdminCap, arg2: u64, arg3: u64) {
        assert!(arg2 <= 10000, 13906836094193762303);
        arg0.fee_rate_bps = arg2;
        arg0.fee_cap = arg3;
    }

    public fun update_params<T0, T1, T2>(arg0: &mut OrderBook<T0, T1, T2>, arg1: &0x75dde20ab838ad72cff25f552bd5f80d46966d8cc038a0a9fc21b36c020ee287::global_config::AdminCap, arg2: u64) {
        arg0.max_price_age_seconds = arg2;
    }

    public(friend) fun update_tpsl_level_by_id(arg0: &mut Order, arg1: u64, arg2: u128, arg3: u128, arg4: u64, arg5: bool) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<TpslLevel>(&arg0.tp_levels)) {
            if (0x1::vector::borrow<TpslLevel>(&arg0.tp_levels, v0).id == arg1) {
                0x1::vector::borrow_mut<TpslLevel>(&mut arg0.tp_levels, v0).trigger_price = arg2;
                0x1::vector::borrow_mut<TpslLevel>(&mut arg0.tp_levels, v0).execution_price = arg3;
                0x1::vector::borrow_mut<TpslLevel>(&mut arg0.tp_levels, v0).close_ratio_bps = arg4;
                0x1::vector::borrow_mut<TpslLevel>(&mut arg0.tp_levels, v0).target_is_base = arg5;
                return
            };
            v0 = v0 + 1;
        };
        v0 = 0;
        while (v0 < 0x1::vector::length<TpslLevel>(&arg0.sl_levels)) {
            if (0x1::vector::borrow<TpslLevel>(&arg0.sl_levels, v0).id == arg1) {
                0x1::vector::borrow_mut<TpslLevel>(&mut arg0.sl_levels, v0).trigger_price = arg2;
                0x1::vector::borrow_mut<TpslLevel>(&mut arg0.sl_levels, v0).execution_price = arg3;
                0x1::vector::borrow_mut<TpslLevel>(&mut arg0.sl_levels, v0).close_ratio_bps = arg4;
                0x1::vector::borrow_mut<TpslLevel>(&mut arg0.sl_levels, v0).target_is_base = arg5;
                return
            };
            v0 = v0 + 1;
        };
        abort 13906838056995127317
    }

    public fun updated_ts(arg0: &Order) : u64 {
        arg0.updated_ts
    }

    // decompiled from Move bytecode v7
}

