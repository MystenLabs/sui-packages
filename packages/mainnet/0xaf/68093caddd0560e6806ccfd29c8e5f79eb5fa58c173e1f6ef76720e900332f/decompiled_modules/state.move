module 0xaf68093caddd0560e6806ccfd29c8e5f79eb5fa58c173e1f6ef76720e900332f::state {
    struct StateCreated has copy, drop {
        state: 0x2::object::ID,
    }

    struct FundsReceiverCreated has copy, drop {
        funds_receiver: 0x2::object::ID,
    }

    struct FundsReceiver has key {
        id: 0x2::object::UID,
    }

    struct MayanRecipientKey has copy, drop, store {
        cctp_dest_domain: u32,
        currency_id: address,
    }

    struct PendingBridge has store {
        source_domain: u32,
        message_sender: address,
        local_token: address,
        amount: u64,
        payload: 0xaf68093caddd0560e6806ccfd29c8e5f79eb5fa58c173e1f6ef76720e900332f::bridge_payload::BridgePayload,
    }

    struct PendingOrder has store {
        source_domain: u32,
        message_sender: address,
        local_token: address,
        amount: u64,
        payload: 0xaf68093caddd0560e6806ccfd29c8e5f79eb5fa58c173e1f6ef76720e900332f::order_payload::OrderPayload,
    }

    struct State has store, key {
        id: 0x2::object::UID,
        paused: bool,
        cctp_mayan_recipient_registry: 0x2::table::Table<MayanRecipientKey, address>,
        cctp_mayan_caller_registry: 0x2::table::Table<u32, address>,
        whitelisted_drivers: 0x2::table::Table<address, bool>,
        pending_bridges: 0x2::table::Table<u256, PendingBridge>,
        pending_orders: 0x2::table::Table<u256, PendingOrder>,
        version_set: 0x2::vec_set::VecSet<u64>,
        latest_package_id: address,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun add_cctp_mayan_caller(arg0: &AdminCap, arg1: &mut State, arg2: u32, arg3: address) {
        assert!(!0x2::table::contains<u32, address>(&arg1.cctp_mayan_caller_registry, arg2), 2);
        0x2::table::add<u32, address>(&mut arg1.cctp_mayan_caller_registry, arg2, arg3);
    }

    public(friend) fun add_cctp_mayan_recipient(arg0: &AdminCap, arg1: &mut State, arg2: u32, arg3: address, arg4: address) {
        let v0 = MayanRecipientKey{
            cctp_dest_domain : arg2,
            currency_id      : arg3,
        };
        assert!(!0x2::table::contains<MayanRecipientKey, address>(&arg1.cctp_mayan_recipient_registry, v0), 1);
        0x2::table::add<MayanRecipientKey, address>(&mut arg1.cctp_mayan_recipient_registry, v0, arg4);
    }

    entry fun add_compatible_state_version(arg0: &AdminCap, arg1: address, arg2: &mut State) {
        assert!(max_compatible_state_version(arg2) < current_state_version(), 7);
        0x2::vec_set::insert<u64>(&mut arg2.version_set, current_state_version());
        arg2.latest_package_id = arg1;
    }

    public(friend) fun add_pending_bridge(arg0: &mut State, arg1: u256, arg2: u32, arg3: address, arg4: address, arg5: u64, arg6: 0xaf68093caddd0560e6806ccfd29c8e5f79eb5fa58c173e1f6ef76720e900332f::bridge_payload::BridgePayload) {
        assert!(!0x2::table::contains<u256, PendingBridge>(&arg0.pending_bridges, arg1), 3);
        let v0 = PendingBridge{
            source_domain  : arg2,
            message_sender : arg3,
            local_token    : arg4,
            amount         : arg5,
            payload        : arg6,
        };
        0x2::table::add<u256, PendingBridge>(&mut arg0.pending_bridges, arg1, v0);
    }

    public(friend) fun add_pending_order(arg0: &mut State, arg1: u256, arg2: u32, arg3: address, arg4: address, arg5: u64, arg6: 0xaf68093caddd0560e6806ccfd29c8e5f79eb5fa58c173e1f6ef76720e900332f::order_payload::OrderPayload) {
        assert!(!0x2::table::contains<u256, PendingOrder>(&arg0.pending_orders, arg1), 5);
        let v0 = PendingOrder{
            source_domain  : arg2,
            message_sender : arg3,
            local_token    : arg4,
            amount         : arg5,
            payload        : arg6,
        };
        0x2::table::add<u256, PendingOrder>(&mut arg0.pending_orders, arg1, v0);
    }

    public fun assert_valid_version(arg0: &State) {
        let v0 = current_state_version();
        assert!(0x2::vec_set::contains<u64>(&arg0.version_set, &v0), 7);
    }

    public fun current_state_version() : u64 {
        1
    }

    public(friend) fun get_cctp_mayan_caller(arg0: &State, arg1: u32) : address {
        *0x2::table::borrow<u32, address>(&arg0.cctp_mayan_caller_registry, arg1)
    }

    public(friend) fun get_cctp_mayan_recipient(arg0: &State, arg1: u32, arg2: address) : address {
        let v0 = MayanRecipientKey{
            cctp_dest_domain : arg1,
            currency_id      : arg2,
        };
        *0x2::table::borrow<MayanRecipientKey, address>(&arg0.cctp_mayan_recipient_registry, v0)
    }

    public(friend) fun has_pending_bridge(arg0: &State, arg1: u256) : bool {
        0x2::table::contains<u256, PendingBridge>(&arg0.pending_bridges, arg1)
    }

    public(friend) fun has_pending_order(arg0: &State, arg1: u256) : bool {
        0x2::table::contains<u256, PendingOrder>(&arg0.pending_orders, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = FundsReceiver{id: 0x2::object::new(arg0)};
        let v2 = FundsReceiverCreated{funds_receiver: 0x2::object::id<FundsReceiver>(&v1)};
        0x2::event::emit<FundsReceiverCreated>(v2);
        0x2::transfer::share_object<FundsReceiver>(v1);
    }

    public(friend) fun is_paused(arg0: &State) : bool {
        arg0.paused
    }

    public(friend) fun is_whitelisted_driver(arg0: &State, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.whitelisted_drivers, arg1)
    }

    fun max_compatible_state_version(arg0: &State) : u64 {
        let v0 = 0x2::vec_set::keys<u64>(&arg0.version_set);
        let v1 = 0x1::vector::length<u64>(v0);
        assert!(v1 > 0, 8);
        let v2 = *0x1::vector::borrow<u64>(v0, 0);
        let v3 = 1;
        while (v3 < v1) {
            let v4 = *0x1::vector::borrow<u64>(v0, v3);
            if (v4 > v2) {
                v2 = v4;
            };
            v3 = v3 + 1;
        };
        v2
    }

    public(friend) fun new_state(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : State {
        let v0 = 0x2::vec_set::empty<u64>();
        0x2::vec_set::insert<u64>(&mut v0, 1);
        let v1 = State{
            id                            : 0x2::object::new(arg1),
            paused                        : false,
            cctp_mayan_recipient_registry : 0x2::table::new<MayanRecipientKey, address>(arg1),
            cctp_mayan_caller_registry    : 0x2::table::new<u32, address>(arg1),
            whitelisted_drivers           : 0x2::table::new<address, bool>(arg1),
            pending_bridges               : 0x2::table::new<u256, PendingBridge>(arg1),
            pending_orders                : 0x2::table::new<u256, PendingOrder>(arg1),
            version_set                   : v0,
            latest_package_id             : arg0,
        };
        let v2 = StateCreated{state: 0x2::object::id<State>(&v1)};
        0x2::event::emit<StateCreated>(v2);
        v1
    }

    public(friend) fun receive_minted_funds<T0>(arg0: &mut FundsReceiver, arg1: u64, arg2: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg0.id, arg2);
        assert!(0x2::coin::value<T0>(&v0) == arg1, 0);
        v0
    }

    entry fun remove_old_state_version(arg0: &AdminCap, arg1: &mut State, arg2: u64) {
        assert_valid_version(arg1);
        assert!(current_state_version() > arg2, 7);
        0x2::vec_set::remove<u64>(&mut arg1.version_set, &arg2);
    }

    public(friend) fun remove_pending_bridge(arg0: &mut State, arg1: u256) : (u32, address, address, u64, 0xaf68093caddd0560e6806ccfd29c8e5f79eb5fa58c173e1f6ef76720e900332f::bridge_payload::BridgePayload) {
        assert!(0x2::table::contains<u256, PendingBridge>(&arg0.pending_bridges, arg1), 4);
        let PendingBridge {
            source_domain  : v0,
            message_sender : v1,
            local_token    : v2,
            amount         : v3,
            payload        : v4,
        } = 0x2::table::remove<u256, PendingBridge>(&mut arg0.pending_bridges, arg1);
        (v0, v1, v2, v3, v4)
    }

    public(friend) fun remove_pending_order(arg0: &mut State, arg1: u256) : (u32, address, address, u64, 0xaf68093caddd0560e6806ccfd29c8e5f79eb5fa58c173e1f6ef76720e900332f::order_payload::OrderPayload) {
        assert!(0x2::table::contains<u256, PendingOrder>(&arg0.pending_orders, arg1), 6);
        let PendingOrder {
            source_domain  : v0,
            message_sender : v1,
            local_token    : v2,
            amount         : v3,
            payload        : v4,
        } = 0x2::table::remove<u256, PendingOrder>(&mut arg0.pending_orders, arg1);
        (v0, v1, v2, v3, v4)
    }

    public(friend) fun rescue_funds<T0>(arg0: &AdminCap, arg1: &mut FundsReceiver, arg2: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>) : 0x2::coin::Coin<T0> {
        0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg1.id, arg2)
    }

    public(friend) fun set_paused(arg0: &AdminCap, arg1: &mut State, arg2: bool) {
        arg1.paused = arg2;
    }

    public(friend) fun set_whitelisted_driver(arg0: &AdminCap, arg1: &mut State, arg2: address, arg3: bool) {
        if (0x2::table::contains<address, bool>(&arg1.whitelisted_drivers, arg2)) {
            0x2::table::remove<address, bool>(&mut arg1.whitelisted_drivers, arg2);
        };
        if (arg3) {
            0x2::table::add<address, bool>(&mut arg1.whitelisted_drivers, arg2, true);
        };
    }

    // decompiled from Move bytecode v7
}

