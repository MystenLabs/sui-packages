module 0x2fa86cb35a443fe6ef0c534d1c6f1b8f05750c9043e39548ae708dda8a499337::intent_rfq {
    struct ChainType has copy, drop, store {
        chain_type: u8,
    }

    struct OrderStatus has copy, drop, store {
        status: u8,
    }

    struct IntentRFQ has key {
        id: 0x2::object::UID,
        owner: address,
        resolver_registry: 0x2::object::ID,
        fee_rate: u64,
        pending_orders_root: vector<u8>,
        completed_orders_root: vector<u8>,
        cancelled_orders_root: vector<u8>,
        collected_fees: 0x2::bag::Bag,
    }

    struct ResolverRegistry has key {
        id: 0x2::object::UID,
        owner: address,
        resolvers: 0x2::bag::Bag,
    }

    struct ResolverInfo has store {
        is_active: bool,
        reputation: u64,
        total_executed: u64,
        registered_at: u64,
    }

    struct OrderCreated has copy, drop {
        intent_id: vector<u8>,
        user: address,
        source_type: u8,
        source_chain_id: u64,
        dest_type: u8,
        dest_chain_id: u64,
        resolver: address,
        amount_in: u64,
        fee_amount: u64,
        token_type: 0x1::string::String,
    }

    struct OrderCompleted has copy, drop {
        intent_id: vector<u8>,
        resolver: address,
        tx_hash: 0x1::string::String,
    }

    struct StatusRootsUpdated has copy, drop {
        pending_root: vector<u8>,
        completed_root: vector<u8>,
        cancelled_root: vector<u8>,
        updater: address,
    }

    struct FeesWithdrawn has copy, drop {
        token_type: 0x1::string::String,
        amount: u64,
    }

    struct ResolverRegistered has copy, drop {
        resolver: address,
        reputation: u64,
    }

    public fun calculate_fee(arg0: &IntentRFQ, arg1: u64) : u64 {
        arg1 * arg0.fee_rate / 10000
    }

    public fun create_chain_type(arg0: u8) : ChainType {
        assert!(arg0 <= 4, 5);
        ChainType{chain_type: arg0}
    }

    public fun create_order<T0>(arg0: &mut IntentRFQ, arg1: &ResolverRegistry, arg2: ChainType, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: ChainType, arg6: u64, arg7: u64, arg8: address, arg9: &mut 0x2::tx_context::TxContext) : vector<u8> {
        assert!(is_active_resolver(arg1, arg8), 0);
        let v0 = 0x2::coin::value<T0>(&arg4);
        assert!(v0 > 0 && arg7 > 0, 1);
        assert!(arg2.chain_type <= 4 && arg5.chain_type <= 4, 5);
        let v1 = 0x2::tx_context::sender(arg9);
        let v2 = generate_intent_id(v1, arg2.chain_type, arg3, v0, arg5.chain_type, arg6, arg7, arg8, arg9);
        let v3 = v0 * arg0.fee_rate / 10000;
        let v4 = 0x2::coin::into_balance<T0>(arg4);
        let v5 = get_token_type_string<T0>();
        if (0x2::bag::contains_with_type<0x1::string::String, 0x2::balance::Balance<T0>>(&arg0.collected_fees, v5)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg0.collected_fees, v5), 0x2::balance::split<T0>(&mut v4, v3));
        } else {
            0x2::bag::add<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg0.collected_fees, v5, 0x2::balance::split<T0>(&mut v4, v3));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v4, arg9), arg8);
        let v6 = OrderCreated{
            intent_id       : v2,
            user            : 0x2::tx_context::sender(arg9),
            source_type     : arg2.chain_type,
            source_chain_id : arg3,
            dest_type       : arg5.chain_type,
            dest_chain_id   : arg6,
            resolver        : arg8,
            amount_in       : v0,
            fee_amount      : v3,
            token_type      : v5,
        };
        0x2::event::emit<OrderCreated>(v6);
        v2
    }

    public fun create_order_status(arg0: u8) : OrderStatus {
        OrderStatus{status: arg0}
    }

    public fun deactivate_resolver(arg0: &mut ResolverRegistry, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 2);
        if (0x2::bag::contains<address>(&arg0.resolvers, arg1)) {
            0x2::bag::borrow_mut<address, ResolverInfo>(&mut arg0.resolvers, arg1).is_active = false;
        };
    }

    fun generate_intent_id(arg0: address, arg1: u8, arg2: u64, arg3: u64, arg4: u8, arg5: u64, arg6: u64, arg7: address, arg8: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u8>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u8>(&arg4));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg5));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg6));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg7));
        let v1 = 0x2::tx_context::epoch(arg8);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&v1));
        let v2 = 0x2::tx_context::sender(arg8);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&v2));
        0x2::hash::keccak256(&v0)
    }

    public fun get_collected_fees<T0>(arg0: &IntentRFQ) : u64 {
        let v0 = get_token_type_string<T0>();
        if (0x2::bag::contains_with_type<0x1::string::String, 0x2::balance::Balance<T0>>(&arg0.collected_fees, v0)) {
            0x2::balance::value<T0>(0x2::bag::borrow<0x1::string::String, 0x2::balance::Balance<T0>>(&arg0.collected_fees, v0))
        } else {
            0
        }
    }

    public fun get_resolver_info(arg0: &ResolverRegistry, arg1: address) : (bool, u64, u64) {
        if (0x2::bag::contains<address>(&arg0.resolvers, arg1)) {
            let v3 = 0x2::bag::borrow<address, ResolverInfo>(&arg0.resolvers, arg1);
            (v3.is_active, v3.reputation, v3.total_executed)
        } else {
            (false, 0, 0)
        }
    }

    public fun get_status_roots(arg0: &IntentRFQ) : (vector<u8>, vector<u8>, vector<u8>) {
        (arg0.pending_orders_root, arg0.completed_orders_root, arg0.cancelled_orders_root)
    }

    public fun get_token_type_string<T0>() : 0x1::string::String {
        0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())))
    }

    fun hash_intent_id(arg0: &vector<u8>) : vector<u8> {
        0x2::hash::keccak256(arg0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ResolverRegistry{
            id        : 0x2::object::new(arg0),
            owner     : 0x2::tx_context::sender(arg0),
            resolvers : 0x2::bag::new(arg0),
        };
        let v1 = IntentRFQ{
            id                    : 0x2::object::new(arg0),
            owner                 : 0x2::tx_context::sender(arg0),
            resolver_registry     : 0x2::object::id<ResolverRegistry>(&v0),
            fee_rate              : 30,
            pending_orders_root   : 0x1::vector::empty<u8>(),
            completed_orders_root : 0x1::vector::empty<u8>(),
            cancelled_orders_root : 0x1::vector::empty<u8>(),
            collected_fees        : 0x2::bag::new(arg0),
        };
        0x2::transfer::share_object<ResolverRegistry>(v0);
        0x2::transfer::share_object<IntentRFQ>(v1);
    }

    public fun is_active_resolver(arg0: &ResolverRegistry, arg1: address) : bool {
        0x2::bag::contains<address>(&arg0.resolvers, arg1) && 0x2::bag::borrow<address, ResolverInfo>(&arg0.resolvers, arg1).is_active
    }

    public entry fun register_resolver(arg0: &mut ResolverRegistry, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 2);
        let v0 = ResolverInfo{
            is_active      : true,
            reputation     : 100,
            total_executed : 0,
            registered_at  : 0x2::tx_context::epoch(arg2),
        };
        0x2::bag::add<address, ResolverInfo>(&mut arg0.resolvers, arg1, v0);
        let v1 = ResolverRegistered{
            resolver   : arg1,
            reputation : 100,
        };
        0x2::event::emit<ResolverRegistered>(v1);
    }

    public entry fun set_fee_rate(arg0: &mut IntentRFQ, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 2);
        assert!(arg1 <= 50, 3);
        arg0.fee_rate = arg1;
    }

    public entry fun update_all_status_roots(arg0: &mut IntentRFQ, arg1: &ResolverRegistry, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(v0 == arg0.owner || is_active_resolver(arg1, v0), 2);
        arg0.pending_orders_root = arg2;
        arg0.completed_orders_root = arg3;
        arg0.cancelled_orders_root = arg4;
        let v1 = StatusRootsUpdated{
            pending_root   : arg2,
            completed_root : arg3,
            cancelled_root : arg4,
            updater        : v0,
        };
        0x2::event::emit<StatusRootsUpdated>(v1);
    }

    public entry fun update_cancelled_orders_root(arg0: &mut IntentRFQ, arg1: &ResolverRegistry, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg0.owner || is_active_resolver(arg1, v0), 2);
        arg0.cancelled_orders_root = arg2;
    }

    public entry fun update_completed_orders_root(arg0: &mut IntentRFQ, arg1: &ResolverRegistry, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg0.owner || is_active_resolver(arg1, v0), 2);
        arg0.completed_orders_root = arg2;
    }

    public entry fun update_pending_orders_root(arg0: &mut IntentRFQ, arg1: &ResolverRegistry, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg0.owner || is_active_resolver(arg1, v0), 2);
        arg0.pending_orders_root = arg2;
    }

    public entry fun update_resolver_reputation(arg0: &mut ResolverRegistry, arg1: address, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 2);
        if (0x2::bag::contains<address>(&arg0.resolvers, arg1)) {
            let v0 = 0x2::bag::borrow_mut<address, ResolverInfo>(&mut arg0.resolvers, arg1);
            if (arg2) {
                v0.total_executed = v0.total_executed + 1;
                if (v0.reputation < 1000) {
                    v0.reputation = v0.reputation + 1;
                };
            } else if (v0.reputation >= 10) {
                v0.reputation = v0.reputation - 10;
            };
        };
    }

    public fun verify_order_status(arg0: &IntentRFQ, arg1: vector<u8>, arg2: u8, arg3: &vector<vector<u8>>) : bool {
        let v0 = if (arg2 == 1) {
            &arg0.pending_orders_root
        } else if (arg2 == 2) {
            &arg0.completed_orders_root
        } else if (arg2 == 3) {
            &arg0.cancelled_orders_root
        } else {
            return false
        };
        0x1::vector::length<u8>(v0) == 0 && false || 0x2fa86cb35a443fe6ef0c534d1c6f1b8f05750c9043e39548ae708dda8a499337::merkle_proof::verify(arg3, *v0, hash_intent_id(&arg1))
    }

    public fun withdraw_all_fees<T0>(arg0: &mut IntentRFQ, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 2);
        let v0 = get_token_type_string<T0>();
        assert!(0x2::bag::contains_with_type<0x1::string::String, 0x2::balance::Balance<T0>>(&arg0.collected_fees, v0), 4);
        let v1 = 0x2::bag::remove<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg0.collected_fees, v0);
        let v2 = FeesWithdrawn{
            token_type : v0,
            amount     : 0x2::balance::value<T0>(&v1),
        };
        0x2::event::emit<FeesWithdrawn>(v2);
        0x2::coin::from_balance<T0>(v1, arg1)
    }

    public fun withdraw_fees<T0>(arg0: &mut IntentRFQ, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 2);
        let v0 = get_token_type_string<T0>();
        assert!(0x2::bag::contains_with_type<0x1::string::String, 0x2::balance::Balance<T0>>(&arg0.collected_fees, v0), 4);
        let v1 = 0x2::bag::borrow_mut<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg0.collected_fees, v0);
        assert!(0x2::balance::value<T0>(v1) >= arg1, 4);
        let v2 = FeesWithdrawn{
            token_type : v0,
            amount     : arg1,
        };
        0x2::event::emit<FeesWithdrawn>(v2);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v1, arg1), arg2)
    }

    // decompiled from Move bytecode v6
}

