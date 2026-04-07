module 0xc089b80b008f04f4a24a98c9970115b3b58b830d8b294111965a6cbc5bfc7c25::order {
    struct Target has copy, drop, store {
        id: u64,
        trigger_price: u128,
        execution_price: u128,
        close_ratio_bps: u64,
    }

    struct OrphanDfKey has copy, drop, store {
        order_id: 0x2::object::ID,
    }

    struct ExecutionRecord has copy, drop, store {
        trigger_type: u8,
        target_ids: vector<u64>,
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
        position_cap: 0x1::option::Option<0xd7a64d5acff2dc5b5f1a24469169165e7fa1c359d02e8d9a2919205dcb5a4297::position::PositionCap>,
        tp_targets: vector<Target>,
        sl_targets: vector<Target>,
        next_target_id: u64,
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
        triggered_target_ids: vector<u64>,
        effective_close_ratio_bps: u64,
        is_full_close: bool,
        current_price: u128,
        execution_price: u128,
        debt_to_repay: u64,
        collateral_underlying: u64,
    }

    struct OrderCreatedEvent has copy, drop {
        order_id: 0x2::object::ID,
        order_cap_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        is_long: bool,
        tp_target_ids: vector<u64>,
        tp_trigger_prices: vector<u128>,
        tp_execution_prices: vector<u128>,
        tp_ratios: vector<u64>,
        sl_target_ids: vector<u64>,
        sl_trigger_prices: vector<u128>,
        sl_execution_prices: vector<u128>,
        sl_ratios: vector<u64>,
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
        triggered_target_ids: vector<u64>,
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
        triggered_target_ids: vector<u64>,
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

    struct OrderBookCreatedEvent has copy, drop {
        order_book_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
    }

    struct OrderBookPausedEvent has copy, drop {
        order_book_id: 0x2::object::ID,
        is_active: bool,
    }

    struct TargetAddedEvent has copy, drop {
        order_id: 0x2::object::ID,
        target_id: u64,
        trigger_type: u8,
        trigger_price: u128,
        execution_price: u128,
        close_ratio_bps: u64,
    }

    struct TargetRemovedEvent has copy, drop {
        order_id: 0x2::object::ID,
        target_id: u64,
    }

    struct TargetUpdatedEvent has copy, drop {
        order_id: 0x2::object::ID,
        target_id: u64,
        trigger_price: u128,
        execution_price: u128,
        close_ratio_bps: u64,
    }

    struct TargetsSetEvent has copy, drop {
        order_id: 0x2::object::ID,
        trigger_type: u8,
        target_ids: vector<u64>,
        trigger_prices: vector<u128>,
        execution_prices: vector<u128>,
        ratios: vector<u64>,
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

    public(friend) fun add_target(arg0: &mut Order, arg1: u8, arg2: u128, arg3: u128, arg4: u64) : u64 {
        let v0 = arg0.next_target_id;
        arg0.next_target_id = v0 + 1;
        let v1 = Target{
            id              : v0,
            trigger_price   : arg2,
            execution_price : arg3,
            close_ratio_bps : arg4,
        };
        if (arg1 == 0) {
            0x1::vector::push_back<Target>(&mut arg0.tp_targets, v1);
        } else {
            0x1::vector::push_back<Target>(&mut arg0.sl_targets, v1);
        };
        v0
    }

    public(friend) fun assert_market_matches(arg0: &Order, arg1: 0x2::object::ID) {
        assert!(arg0.market_id == arg1, 13906837683332055047);
    }

    public(friend) fun assert_order_book_matches<T0, T1, T2>(arg0: &OrderBook<T0, T1, T2>, arg1: &Order) {
        assert!(arg1.order_book_id == 0x2::object::id<OrderBook<T0, T1, T2>>(arg0), 13906837661857087493);
        assert!(arg1.market_id == arg0.market_id, 13906837666152054789);
    }

    public(friend) fun assert_order_cap_matches(arg0: &Order, arg1: &OrderCap) {
        assert!(arg1.order_id == 0x2::object::uid_to_inner(&arg0.id), 13906837640382119939);
        assert!(arg1.position_id == arg0.position_id, 13906837644677087235);
    }

    public(friend) fun assert_receipt_matches_order(arg0: &Order, arg1: &ExecuteReceipt) {
        assert!(arg1.order_id == 0x2::object::uid_to_inner(&arg0.id), 13906837700512055305);
        assert!(arg1.position_id == arg0.position_id, 13906837704807022601);
    }

    public fun bps_denominator() : u64 {
        10000
    }

    public(friend) fun cancel<T0, T1, T2>(arg0: &mut OrderBook<T0, T1, T2>, arg1: Order, arg2: OrderCap) : 0xd7a64d5acff2dc5b5f1a24469169165e7fa1c359d02e8d9a2919205dcb5a4297::position::PositionCap {
        assert_order_book_matches<T0, T1, T2>(arg0, &arg1);
        assert_order_cap_matches(&arg1, &arg2);
        let OrderCap {
            id          : v0,
            order_id    : v1,
            position_id : _,
        } = arg2;
        0x2::object::delete(v0);
        assert!(arg1.status == 0, 13906836618180689935);
        let (v3, v4, v5, _) = destroy_order(arg1);
        assert!(v1 == v3, 13906836626769838083);
        remove_order_index<T0, T1, T2>(arg0, v4);
        let v7 = OrderCancelledEvent{
            order_id    : v3,
            position_id : v4,
        };
        0x2::event::emit<OrderCancelledEvent>(v7);
        0x1::option::destroy_some<0xd7a64d5acff2dc5b5f1a24469169165e7fa1c359d02e8d9a2919205dcb5a4297::position::PositionCap>(v5)
    }

    public(friend) fun claim_orphan<T0, T1, T2>(arg0: &mut OrderBook<T0, T1, T2>, arg1: OrderCap) : 0xd7a64d5acff2dc5b5f1a24469169165e7fa1c359d02e8d9a2919205dcb5a4297::position::PositionCap {
        let OrderCap {
            id          : v0,
            order_id    : v1,
            position_id : _,
        } = arg1;
        0x2::object::delete(v0);
        let v3 = OrphanDfKey{order_id: v1};
        assert!(0x2::dynamic_field::exists_<OrphanDfKey>(&arg0.id, v3), 13906836953188007949);
        0x2::dynamic_field::remove<OrphanDfKey, 0xd7a64d5acff2dc5b5f1a24469169165e7fa1c359d02e8d9a2919205dcb5a4297::position::PositionCap>(&mut arg0.id, v3)
    }

    public(friend) fun cleanup_and_claim_orphan<T0, T1, T2>(arg0: &mut OrderBook<T0, T1, T2>, arg1: Order, arg2: OrderCap) : 0xd7a64d5acff2dc5b5f1a24469169165e7fa1c359d02e8d9a2919205dcb5a4297::position::PositionCap {
        assert_order_book_matches<T0, T1, T2>(arg0, &arg1);
        assert_order_cap_matches(&arg1, &arg2);
        let OrderCap {
            id          : v0,
            order_id    : v1,
            position_id : _,
        } = arg2;
        0x2::object::delete(v0);
        let (v3, v4) = cleanup_orphan<T0, T1, T2>(arg0, arg1);
        assert!(v1 == v4, 13906836901647745027);
        v3
    }

    public(friend) fun cleanup_orphan<T0, T1, T2>(arg0: &mut OrderBook<T0, T1, T2>, arg1: Order) : (0xd7a64d5acff2dc5b5f1a24469169165e7fa1c359d02e8d9a2919205dcb5a4297::position::PositionCap, 0x2::object::ID) {
        assert_order_book_matches<T0, T1, T2>(arg0, &arg1);
        let (v0, v1, v2, _) = destroy_order(arg1);
        remove_order_index<T0, T1, T2>(arg0, v1);
        let v4 = OrphanOrderCleanedEvent{
            order_id    : v0,
            position_id : v1,
        };
        0x2::event::emit<OrphanOrderCleanedEvent>(v4);
        (0x1::option::destroy_some<0xd7a64d5acff2dc5b5f1a24469169165e7fa1c359d02e8d9a2919205dcb5a4297::position::PositionCap>(v2), v0)
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
        assert!(arg1.status == 2, 13906836712670101521);
        let (v3, v4, v5, _) = destroy_order(arg1);
        assert!(v1 == v3, 13906836721259118595);
        0x1::option::destroy_none<0xd7a64d5acff2dc5b5f1a24469169165e7fa1c359d02e8d9a2919205dcb5a4297::position::PositionCap>(v5);
        remove_order_index<T0, T1, T2>(arg0, v4);
        let v7 = OrderClosedEvent{
            order_id    : v3,
            position_id : v4,
        };
        0x2::event::emit<OrderClosedEvent>(v7);
    }

    public fun close_ratio_bps(arg0: &Target) : u64 {
        arg0.close_ratio_bps
    }

    public(friend) fun complete(arg0: &mut Order, arg1: u64) {
        arg0.status = 2;
        arg0.updated_ts = arg1;
    }

    public fun create_order_book<T0, T1, T2>(arg0: &0xc089b80b008f04f4a24a98c9970115b3b58b830d8b294111965a6cbc5bfc7c25::global_config::AdminCap, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 10000, 13906835553027883007);
        let v0 = OrderBook<T0, T1, T2>{
            id                    : 0x2::object::new(arg5),
            market_id             : arg1,
            order_index           : 0x2::table::new<0x2::object::ID, 0x2::object::ID>(arg5),
            fees                  : 0x2::bag::new(arg5),
            num_orders            : 0,
            fee_rate_bps          : arg2,
            fee_cap               : arg3,
            max_price_age_seconds : arg4,
            is_active             : true,
        };
        let v1 = OrderBookCreatedEvent{
            order_book_id : 0x2::object::id<OrderBook<T0, T1, T2>>(&v0),
            market_id     : arg1,
        };
        0x2::event::emit<OrderBookCreatedEvent>(v1);
        0x2::transfer::share_object<OrderBook<T0, T1, T2>>(v0);
    }

    fun destroy_order(arg0: Order) : (0x2::object::ID, 0x2::object::ID, 0x1::option::Option<0xd7a64d5acff2dc5b5f1a24469169165e7fa1c359d02e8d9a2919205dcb5a4297::position::PositionCap>, u8) {
        let Order {
            id             : v0,
            order_book_id  : _,
            market_id      : _,
            position_id    : v3,
            position_cap   : v4,
            tp_targets     : _,
            sl_targets     : _,
            next_target_id : _,
            executions     : _,
            settlements    : v9,
            is_long        : _,
            entry_price    : _,
            status         : v12,
            created_ts     : _,
            updated_ts     : _,
        } = arg0;
        let v15 = v9;
        let v16 = v0;
        assert!(0x2::bag::is_empty(&v15), 13906835969640890387);
        0x2::bag::destroy_empty(v15);
        0x2::object::delete(v16);
        (0x2::object::uid_to_inner(&v16), v3, v4, v12)
    }

    public(friend) fun destroy_receipt(arg0: ExecuteReceipt) : (0x2::object::ID, 0x2::object::ID, u8, vector<u64>, u64, bool, u128, u128, u64, u64) {
        let ExecuteReceipt {
            order_id                  : v0,
            position_id               : v1,
            trigger_type              : v2,
            triggered_target_ids      : v3,
            effective_close_ratio_bps : v4,
            is_full_close             : v5,
            current_price             : v6,
            execution_price           : v7,
            debt_to_repay             : v8,
            collateral_underlying     : v9,
        } = arg0;
        (v0, v1, v2, v3, v4, v5, v6, v7, v8, v9)
    }

    public(friend) fun emit_full_executed(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u8, arg4: vector<u64>, arg5: u128, arg6: u64, arg7: u64, arg8: 0x1::type_name::TypeName) {
        let v0 = OrderExecutedEvent{
            order_id             : arg0,
            position_id          : arg1,
            executor             : arg2,
            trigger_type         : arg3,
            triggered_target_ids : arg4,
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
            triggered_target_ids      : arg4,
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

    public(friend) fun emit_target_added(arg0: 0x2::object::ID, arg1: u64, arg2: u8, arg3: u128, arg4: u128, arg5: u64) {
        let v0 = TargetAddedEvent{
            order_id        : arg0,
            target_id       : arg1,
            trigger_type    : arg2,
            trigger_price   : arg3,
            execution_price : arg4,
            close_ratio_bps : arg5,
        };
        0x2::event::emit<TargetAddedEvent>(v0);
    }

    public(friend) fun emit_target_removed(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = TargetRemovedEvent{
            order_id  : arg0,
            target_id : arg1,
        };
        0x2::event::emit<TargetRemovedEvent>(v0);
    }

    public(friend) fun emit_target_updated(arg0: 0x2::object::ID, arg1: u64, arg2: u128, arg3: u128, arg4: u64) {
        let v0 = TargetUpdatedEvent{
            order_id        : arg0,
            target_id       : arg1,
            trigger_price   : arg2,
            execution_price : arg3,
            close_ratio_bps : arg4,
        };
        0x2::event::emit<TargetUpdatedEvent>(v0);
    }

    public(friend) fun emit_targets_set(arg0: 0x2::object::ID, arg1: u8, arg2: vector<u64>, arg3: vector<u128>, arg4: vector<u128>, arg5: vector<u64>) {
        let v0 = TargetsSetEvent{
            order_id         : arg0,
            trigger_type     : arg1,
            target_ids       : arg2,
            trigger_prices   : arg3,
            execution_prices : arg4,
            ratios           : arg5,
        };
        0x2::event::emit<TargetsSetEvent>(v0);
    }

    public fun entry_price(arg0: &Order) : u128 {
        arg0.entry_price
    }

    public fun fee_cap<T0, T1, T2>(arg0: &OrderBook<T0, T1, T2>) : u64 {
        arg0.fee_cap
    }

    public fun fee_rate_bps<T0, T1, T2>(arg0: &OrderBook<T0, T1, T2>) : u64 {
        arg0.fee_rate_bps
    }

    public fun harvest_fees<T0, T1, T2, T3>(arg0: &mut OrderBook<T0, T1, T2>, arg1: &0xc089b80b008f04f4a24a98c9970115b3b58b830d8b294111965a6cbc5bfc7c25::global_config::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T3>>(&mut arg0.fees, 0x1::type_name::with_defining_ids<T3>()), arg2), 0x2::tx_context::sender(arg2));
    }

    public fun has_order<T0, T1, T2>(arg0: &OrderBook<T0, T1, T2>, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.order_index, arg1)
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

    public(friend) fun make_target(arg0: u64, arg1: u128, arg2: u128, arg3: u64) : Target {
        Target{
            id              : arg0,
            trigger_price   : arg1,
            execution_price : arg2,
            close_ratio_bps : arg3,
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
            target_ids                : arg1,
            actual_price              : arg2,
            effective_close_ratio_bps : arg3,
            settlement_amount         : arg4,
            settlement_coin_type      : arg5,
            keeper                    : arg6,
            timestamp                 : arg7,
        }
    }

    public(friend) fun new_receipt(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u8, arg3: vector<u64>, arg4: u64, arg5: bool, arg6: u128, arg7: u128, arg8: u64, arg9: u64) : ExecuteReceipt {
        ExecuteReceipt{
            order_id                  : arg0,
            position_id               : arg1,
            trigger_type              : arg2,
            triggered_target_ids      : arg3,
            effective_close_ratio_bps : arg4,
            is_full_close             : arg5,
            current_price             : arg6,
            execution_price           : arg7,
            debt_to_repay             : arg8,
            collateral_underlying     : arg9,
        }
    }

    public fun next_target_id(arg0: &Order) : u64 {
        arg0.next_target_id
    }

    public fun num_executions(arg0: &Order) : u64 {
        0x1::vector::length<ExecutionRecord>(&arg0.executions)
    }

    public fun num_orders<T0, T1, T2>(arg0: &OrderBook<T0, T1, T2>) : u64 {
        arg0.num_orders
    }

    public fun num_sl_targets(arg0: &Order) : u64 {
        0x1::vector::length<Target>(&arg0.sl_targets)
    }

    public fun num_tp_targets(arg0: &Order) : u64 {
        0x1::vector::length<Target>(&arg0.tp_targets)
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

    public fun pause<T0, T1, T2>(arg0: &mut OrderBook<T0, T1, T2>, arg1: &0xc089b80b008f04f4a24a98c9970115b3b58b830d8b294111965a6cbc5bfc7c25::global_config::AdminCap) {
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

    public fun receipt_is_full_close(arg0: &ExecuteReceipt) : bool {
        arg0.is_full_close
    }

    public fun receipt_order_id(arg0: &ExecuteReceipt) : 0x2::object::ID {
        arg0.order_id
    }

    public fun receipt_position_id(arg0: &ExecuteReceipt) : 0x2::object::ID {
        arg0.position_id
    }

    public fun receipt_trigger_type(arg0: &ExecuteReceipt) : u8 {
        arg0.trigger_type
    }

    public fun receipt_triggered_target_ids(arg0: &ExecuteReceipt) : &vector<u64> {
        &arg0.triggered_target_ids
    }

    fun remove_order_index<T0, T1, T2>(arg0: &mut OrderBook<T0, T1, T2>, arg1: 0x2::object::ID) {
        0x2::table::remove<0x2::object::ID, 0x2::object::ID>(&mut arg0.order_index, arg1);
        arg0.num_orders = arg0.num_orders - 1;
    }

    public(friend) fun remove_settlement<T0>(arg0: &mut Order) : 0x2::balance::Balance<T0> {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.settlements, v0), 13906836553755918347);
        0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.settlements, v0)
    }

    public(friend) fun remove_target_by_id(arg0: &mut Order, arg1: u64) : u8 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Target>(&arg0.tp_targets)) {
            if (0x1::vector::borrow<Target>(&arg0.tp_targets, v0).id == arg1) {
                0x1::vector::remove<Target>(&mut arg0.tp_targets, v0);
                return 0
            };
            v0 = v0 + 1;
        };
        v0 = 0;
        while (v0 < 0x1::vector::length<Target>(&arg0.sl_targets)) {
            if (0x1::vector::borrow<Target>(&arg0.sl_targets, v0).id == arg1) {
                0x1::vector::remove<Target>(&mut arg0.sl_targets, v0);
                return 1
            };
            v0 = v0 + 1;
        };
        abort 13906837305375850517
    }

    public(friend) fun remove_triggered_targets(arg0: &mut Order, arg1: u8, arg2: &vector<u64>) {
        let v0 = if (arg1 == 0) {
            &mut arg0.tp_targets
        } else {
            &mut arg0.sl_targets
        };
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(arg2)) {
            let v2 = 0;
            while (v2 < 0x1::vector::length<Target>(v0)) {
                if (0x1::vector::borrow<Target>(v0, v2).id == *0x1::vector::borrow<u64>(arg2, v1)) {
                    0x1::vector::remove<Target>(v0, v2);
                    break
                };
                v2 = v2 + 1;
            };
            v1 = v1 + 1;
        };
    }

    public fun resume<T0, T1, T2>(arg0: &mut OrderBook<T0, T1, T2>, arg1: &0xc089b80b008f04f4a24a98c9970115b3b58b830d8b294111965a6cbc5bfc7c25::global_config::AdminCap) {
        arg0.is_active = true;
        let v0 = OrderBookPausedEvent{
            order_book_id : 0x2::object::id<OrderBook<T0, T1, T2>>(arg0),
            is_active     : true,
        };
        0x2::event::emit<OrderBookPausedEvent>(v0);
    }

    public(friend) fun return_position_cap(arg0: &mut Order, arg1: 0xd7a64d5acff2dc5b5f1a24469169165e7fa1c359d02e8d9a2919205dcb5a4297::position::PositionCap, arg2: u64) {
        0x1::option::fill<0xd7a64d5acff2dc5b5f1a24469169165e7fa1c359d02e8d9a2919205dcb5a4297::position::PositionCap>(&mut arg0.position_cap, arg1);
        arg0.status = 0;
        arg0.updated_ts = arg2;
    }

    public(friend) fun set_sl_targets(arg0: &mut Order, arg1: vector<Target>) {
        arg0.sl_targets = arg1;
    }

    public(friend) fun set_tp_targets(arg0: &mut Order, arg1: vector<Target>) {
        arg0.tp_targets = arg1;
    }

    public fun settlements_empty(arg0: &Order) : bool {
        0x2::bag::is_empty(&arg0.settlements)
    }

    public(friend) fun sl_targets(arg0: &Order) : &vector<Target> {
        &arg0.sl_targets
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

    public(friend) fun store_order<T0, T1, T2>(arg0: &mut OrderBook<T0, T1, T2>, arg1: 0xd7a64d5acff2dc5b5f1a24469169165e7fa1c359d02e8d9a2919205dcb5a4297::position::PositionCap, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: bool, arg5: u128, arg6: vector<Target>, arg7: vector<Target>, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) : OrderCap {
        assert!(!0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.order_index, arg2), 13906836064128991233);
        let v0 = Order{
            id             : 0x2::object::new(arg10),
            order_book_id  : 0x2::object::id<OrderBook<T0, T1, T2>>(arg0),
            market_id      : arg3,
            position_id    : arg2,
            position_cap   : 0x1::option::some<0xd7a64d5acff2dc5b5f1a24469169165e7fa1c359d02e8d9a2919205dcb5a4297::position::PositionCap>(arg1),
            tp_targets     : arg6,
            sl_targets     : arg7,
            next_target_id : arg8,
            executions     : 0x1::vector::empty<ExecutionRecord>(),
            settlements    : 0x2::bag::new(arg10),
            is_long        : arg4,
            entry_price    : arg5,
            status         : 0,
            created_ts     : arg9,
            updated_ts     : arg9,
        };
        let v1 = 0x2::object::id<Order>(&v0);
        let v2 = OrderCap{
            id          : 0x2::object::new(arg10),
            order_id    : v1,
            position_id : arg2,
        };
        let v3 = vector[];
        let v4 = vector[];
        let v5 = vector[];
        let v6 = vector[];
        let v7 = 0;
        while (v7 < 0x1::vector::length<Target>(&v0.tp_targets)) {
            0x1::vector::push_back<u64>(&mut v3, 0x1::vector::borrow<Target>(&v0.tp_targets, v7).id);
            0x1::vector::push_back<u128>(&mut v4, 0x1::vector::borrow<Target>(&v0.tp_targets, v7).trigger_price);
            0x1::vector::push_back<u128>(&mut v5, 0x1::vector::borrow<Target>(&v0.tp_targets, v7).execution_price);
            0x1::vector::push_back<u64>(&mut v6, 0x1::vector::borrow<Target>(&v0.tp_targets, v7).close_ratio_bps);
            v7 = v7 + 1;
        };
        let v8 = vector[];
        let v9 = vector[];
        let v10 = vector[];
        let v11 = vector[];
        v7 = 0;
        while (v7 < 0x1::vector::length<Target>(&v0.sl_targets)) {
            0x1::vector::push_back<u64>(&mut v8, 0x1::vector::borrow<Target>(&v0.sl_targets, v7).id);
            0x1::vector::push_back<u128>(&mut v9, 0x1::vector::borrow<Target>(&v0.sl_targets, v7).trigger_price);
            0x1::vector::push_back<u128>(&mut v10, 0x1::vector::borrow<Target>(&v0.sl_targets, v7).execution_price);
            0x1::vector::push_back<u64>(&mut v11, 0x1::vector::borrow<Target>(&v0.sl_targets, v7).close_ratio_bps);
            v7 = v7 + 1;
        };
        let v12 = OrderCreatedEvent{
            order_id            : v1,
            order_cap_id        : 0x2::object::id<OrderCap>(&v2),
            position_id         : arg2,
            is_long             : arg4,
            tp_target_ids       : v3,
            tp_trigger_prices   : v4,
            tp_execution_prices : v5,
            tp_ratios           : v6,
            sl_target_ids       : v8,
            sl_trigger_prices   : v9,
            sl_execution_prices : v10,
            sl_ratios           : v11,
        };
        0x2::event::emit<OrderCreatedEvent>(v12);
        add_order_index<T0, T1, T2>(arg0, arg2, v1);
        0x2::transfer::share_object<Order>(v0);
        v2
    }

    public(friend) fun store_orphan<T0, T1, T2>(arg0: &mut OrderBook<T0, T1, T2>, arg1: 0x2::object::ID, arg2: 0xd7a64d5acff2dc5b5f1a24469169165e7fa1c359d02e8d9a2919205dcb5a4297::position::PositionCap) {
        let v0 = OrphanDfKey{order_id: arg1};
        0x2::dynamic_field::add<OrphanDfKey, 0xd7a64d5acff2dc5b5f1a24469169165e7fa1c359d02e8d9a2919205dcb5a4297::position::PositionCap>(&mut arg0.id, v0, arg2);
    }

    public(friend) fun take_position_cap(arg0: &mut Order) : 0xd7a64d5acff2dc5b5f1a24469169165e7fa1c359d02e8d9a2919205dcb5a4297::position::PositionCap {
        assert!(arg0.status == 0, 13906836377662521359);
        arg0.status = 1;
        0x1::option::extract<0xd7a64d5acff2dc5b5f1a24469169165e7fa1c359d02e8d9a2919205dcb5a4297::position::PositionCap>(&mut arg0.position_cap)
    }

    public fun target_execution_price(arg0: &Target) : u128 {
        arg0.execution_price
    }

    public fun target_id(arg0: &Target) : u64 {
        arg0.id
    }

    public(friend) fun tp_targets(arg0: &Order) : &vector<Target> {
        &arg0.tp_targets
    }

    public fun trigger_price(arg0: &Target) : u128 {
        arg0.trigger_price
    }

    public fun trigger_sl() : u8 {
        1
    }

    public fun trigger_tp() : u8 {
        0
    }

    public fun update_fee_params<T0, T1, T2>(arg0: &mut OrderBook<T0, T1, T2>, arg1: &0xc089b80b008f04f4a24a98c9970115b3b58b830d8b294111965a6cbc5bfc7c25::global_config::AdminCap, arg2: u64, arg3: u64) {
        assert!(arg2 <= 10000, 13906835737711476735);
        arg0.fee_rate_bps = arg2;
        arg0.fee_cap = arg3;
    }

    public fun update_params<T0, T1, T2>(arg0: &mut OrderBook<T0, T1, T2>, arg1: &0xc089b80b008f04f4a24a98c9970115b3b58b830d8b294111965a6cbc5bfc7c25::global_config::AdminCap, arg2: u64) {
        arg0.max_price_age_seconds = arg2;
    }

    public(friend) fun update_target_by_id(arg0: &mut Order, arg1: u64, arg2: u128, arg3: u128, arg4: u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Target>(&arg0.tp_targets)) {
            if (0x1::vector::borrow<Target>(&arg0.tp_targets, v0).id == arg1) {
                0x1::vector::borrow_mut<Target>(&mut arg0.tp_targets, v0).trigger_price = arg2;
                0x1::vector::borrow_mut<Target>(&mut arg0.tp_targets, v0).execution_price = arg3;
                0x1::vector::borrow_mut<Target>(&mut arg0.tp_targets, v0).close_ratio_bps = arg4;
                return
            };
            v0 = v0 + 1;
        };
        v0 = 0;
        while (v0 < 0x1::vector::length<Target>(&arg0.sl_targets)) {
            if (0x1::vector::borrow<Target>(&arg0.sl_targets, v0).id == arg1) {
                0x1::vector::borrow_mut<Target>(&mut arg0.sl_targets, v0).trigger_price = arg2;
                0x1::vector::borrow_mut<Target>(&mut arg0.sl_targets, v0).execution_price = arg3;
                0x1::vector::borrow_mut<Target>(&mut arg0.sl_targets, v0).close_ratio_bps = arg4;
                return
            };
            v0 = v0 + 1;
        };
        abort 13906837421339967509
    }

    // decompiled from Move bytecode v6
}

