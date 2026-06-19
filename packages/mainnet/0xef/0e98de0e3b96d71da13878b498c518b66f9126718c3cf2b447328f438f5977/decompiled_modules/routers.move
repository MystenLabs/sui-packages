module 0xef0e98de0e3b96d71da13878b498c518b66f9126718c3cf2b447328f438f5977::routers {
    struct PendingRetry has key {
        id: 0x2::object::UID,
        router: address,
        payload_hash: vector<u8>,
        src_receiver: vector<u8>,
        net_hint: u64,
        payload: vector<u8>,
        active: bool,
    }

    struct PassthroughRouter<phantom T0> has key {
        id: 0x2::object::UID,
        beneficiary: address,
        reserve: u64,
        drain: address,
        balance: 0x2::balance::Balance<T0>,
    }

    struct SplitRouter<phantom T0> has key {
        id: 0x2::object::UID,
        recipients: vector<address>,
        weights_bps: vector<u64>,
        reserve: u64,
        drain: address,
        balance: 0x2::balance::Balance<T0>,
    }

    struct RouterDeposited has copy, drop {
        router: address,
        amount: u64,
    }

    struct RouterExecuted has copy, drop {
        router: address,
        actionable: u64,
        reserve: u64,
    }

    struct RouterDrained has copy, drop {
        router: address,
        to: address,
        amount: u64,
    }

    struct Forwarded has copy, drop {
        router: address,
        to: address,
        amount: u64,
    }

    struct Distributed has copy, drop {
        router: address,
        actionable: u64,
        recipient_count: u64,
    }

    struct Slice has copy, drop {
        router: address,
        recipient: address,
        amount: u64,
    }

    struct CctpReceivePending has copy, drop {
        router: address,
        src_receiver: vector<u8>,
        net_hint: u64,
        payload: vector<u8>,
    }

    public fun actionable_passthrough<T0>(arg0: &PassthroughRouter<T0>) : u64 {
        let v0 = 0x2::balance::value<T0>(&arg0.balance);
        if (v0 > arg0.reserve) {
            v0 - arg0.reserve
        } else {
            0
        }
    }

    public fun actionable_split<T0>(arg0: &SplitRouter<T0>) : u64 {
        let v0 = 0x2::balance::value<T0>(&arg0.balance);
        if (v0 > arg0.reserve) {
            v0 - arg0.reserve
        } else {
            0
        }
    }

    public fun cctp_on_receive_passthrough<T0>(arg0: &mut PassthroughRouter<T0>, arg1: 0x2::coin::Coin<T0>, arg2: vector<u8>, arg3: u64, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
        let v0 = 0xef0e98de0e3b96d71da13878b498c518b66f9126718c3cf2b447328f438f5977::memo::payload(&arg4);
        let v1 = 0x2::object::uid_to_address(&arg0.id);
        0x2::transfer::share_object<PendingRetry>(new_pending_retry(v1, v0, arg2, arg3, arg5));
        let v2 = RouterDeposited{
            router : v1,
            amount : 0x2::coin::value<T0>(&arg1),
        };
        0x2::event::emit<RouterDeposited>(v2);
        let v3 = CctpReceivePending{
            router       : v1,
            src_receiver : arg2,
            net_hint     : arg3,
            payload      : v0,
        };
        0x2::event::emit<CctpReceivePending>(v3);
    }

    public fun cctp_on_receive_split<T0>(arg0: &mut SplitRouter<T0>, arg1: 0x2::coin::Coin<T0>, arg2: vector<u8>, arg3: u64, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
        let v0 = 0xef0e98de0e3b96d71da13878b498c518b66f9126718c3cf2b447328f438f5977::memo::payload(&arg4);
        let v1 = 0x2::object::uid_to_address(&arg0.id);
        0x2::transfer::share_object<PendingRetry>(new_pending_retry(v1, v0, arg2, arg3, arg5));
        let v2 = RouterDeposited{
            router : v1,
            amount : 0x2::coin::value<T0>(&arg1),
        };
        0x2::event::emit<RouterDeposited>(v2);
        let v3 = CctpReceivePending{
            router       : v1,
            src_receiver : arg2,
            net_hint     : arg3,
            payload      : v0,
        };
        0x2::event::emit<CctpReceivePending>(v3);
    }

    fun clear_pending_retry(arg0: &mut PendingRetry) {
        arg0.active = false;
        arg0.payload = b"";
    }

    public fun create_passthrough<T0>(arg0: address, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 != @0x0 && arg2 != @0x0, 1);
        let v0 = PassthroughRouter<T0>{
            id          : 0x2::object::new(arg3),
            beneficiary : arg0,
            reserve     : arg1,
            drain       : arg2,
            balance     : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<PassthroughRouter<T0>>(v0);
    }

    public fun create_split<T0>(arg0: vector<address>, arg1: vector<u64>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 != @0x0, 1);
        let v0 = 0x1::vector::length<address>(&arg0);
        assert!(v0 > 0, 3);
        assert!(v0 <= 8, 4);
        assert!(0x1::vector::length<u64>(&arg1) == v0, 5);
        let v1 = 0;
        let v2 = 0;
        while (v2 < v0) {
            assert!(*0x1::vector::borrow<address>(&arg0, v2) != @0x0, 1);
            let v3 = *0x1::vector::borrow<u64>(&arg1, v2);
            assert!(v3 > 0, 6);
            v1 = v1 + v3;
            v2 = v2 + 1;
        };
        assert!(v1 == 10000, 7);
        let v4 = SplitRouter<T0>{
            id          : 0x2::object::new(arg4),
            recipients  : arg0,
            weights_bps : arg1,
            reserve     : arg2,
            drain       : arg3,
            balance     : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<SplitRouter<T0>>(v4);
    }

    public fun deposit_passthrough<T0>(arg0: &mut PassthroughRouter<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
        let v0 = RouterDeposited{
            router : 0x2::object::uid_to_address(&arg0.id),
            amount : 0x2::coin::value<T0>(&arg1),
        };
        0x2::event::emit<RouterDeposited>(v0);
    }

    public fun deposit_split<T0>(arg0: &mut SplitRouter<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
        let v0 = RouterDeposited{
            router : 0x2::object::uid_to_address(&arg0.id),
            amount : 0x2::coin::value<T0>(&arg1),
        };
        0x2::event::emit<RouterDeposited>(v0);
    }

    public fun drain_passthrough<T0>(arg0: &mut PassthroughRouter<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.drain, 2);
        let v0 = 0x2::balance::value<T0>(&arg0.balance);
        if (v0 == 0) {
            return
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v0), arg1), arg0.drain);
        let v1 = RouterDrained{
            router : 0x2::object::uid_to_address(&arg0.id),
            to     : arg0.drain,
            amount : v0,
        };
        0x2::event::emit<RouterDrained>(v1);
    }

    public fun drain_split<T0>(arg0: &mut SplitRouter<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.drain, 2);
        let v0 = 0x2::balance::value<T0>(&arg0.balance);
        if (v0 == 0) {
            return
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v0), arg1), arg0.drain);
        let v1 = RouterDrained{
            router : 0x2::object::uid_to_address(&arg0.id),
            to     : arg0.drain,
            amount : v0,
        };
        0x2::event::emit<RouterDrained>(v1);
    }

    public fun execute_passthrough<T0>(arg0: &mut PassthroughRouter<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        execute_passthrough_inner<T0>(arg0, arg1);
    }

    fun execute_passthrough_inner<T0>(arg0: &mut PassthroughRouter<T0>, arg1: &mut 0x2::tx_context::TxContext) : bool {
        let v0 = actionable_passthrough<T0>(arg0);
        if (v0 == 0) {
            return false
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v0), arg1), arg0.beneficiary);
        let v1 = 0x2::object::uid_to_address(&arg0.id);
        let v2 = Forwarded{
            router : v1,
            to     : arg0.beneficiary,
            amount : v0,
        };
        0x2::event::emit<Forwarded>(v2);
        let v3 = RouterExecuted{
            router     : v1,
            actionable : v0,
            reserve    : arg0.reserve,
        };
        0x2::event::emit<RouterExecuted>(v3);
        true
    }

    public fun execute_passthrough_with_memo<T0>(arg0: &mut PassthroughRouter<T0>, arg1: &mut PendingRetry, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xef0e98de0e3b96d71da13878b498c518b66f9126718c3cf2b447328f438f5977::memo::payload(&arg2);
        let v1 = retry_matches(arg1, passthrough_address<T0>(arg0), &v0);
        if (execute_passthrough_inner<T0>(arg0, arg3)) {
            if (v1) {
                clear_pending_retry(arg1);
            };
        };
    }

    public fun execute_split<T0>(arg0: &mut SplitRouter<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        execute_split_inner<T0>(arg0, arg1);
    }

    fun execute_split_inner<T0>(arg0: &mut SplitRouter<T0>, arg1: &mut 0x2::tx_context::TxContext) : bool {
        let v0 = actionable_split<T0>(arg0);
        if (v0 == 0) {
            return false
        };
        let v1 = 0x1::vector::length<address>(&arg0.recipients);
        let v2 = 0;
        let v3 = 0;
        let v4 = 0x2::object::uid_to_address(&arg0.id);
        while (v3 < v1) {
            let v5 = if (v3 + 1 < v1) {
                v0 * *0x1::vector::borrow<u64>(&arg0.weights_bps, v3) / 10000
            } else {
                v0 - v2
            };
            if (v5 > 0) {
                let v6 = *0x1::vector::borrow<address>(&arg0.recipients, v3);
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v5), arg1), v6);
                v2 = v2 + v5;
                let v7 = Slice{
                    router    : v4,
                    recipient : v6,
                    amount    : v5,
                };
                0x2::event::emit<Slice>(v7);
            };
            v3 = v3 + 1;
        };
        let v8 = Distributed{
            router          : v4,
            actionable      : v0,
            recipient_count : v1,
        };
        0x2::event::emit<Distributed>(v8);
        let v9 = RouterExecuted{
            router     : v4,
            actionable : v0,
            reserve    : arg0.reserve,
        };
        0x2::event::emit<RouterExecuted>(v9);
        true
    }

    public fun execute_split_with_memo<T0>(arg0: &mut SplitRouter<T0>, arg1: &mut PendingRetry, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xef0e98de0e3b96d71da13878b498c518b66f9126718c3cf2b447328f438f5977::memo::payload(&arg2);
        let v1 = retry_matches(arg1, split_address<T0>(arg0), &v0);
        if (execute_split_inner<T0>(arg0, arg3)) {
            if (v1) {
                clear_pending_retry(arg1);
            };
        };
    }

    fun new_pending_retry(arg0: address, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : PendingRetry {
        PendingRetry{
            id           : 0x2::object::new(arg4),
            router       : arg0,
            payload_hash : 0x2::hash::keccak256(&arg1),
            src_receiver : arg2,
            net_hint     : arg3,
            payload      : arg1,
            active       : true,
        }
    }

    public fun passthrough_address<T0>(arg0: &PassthroughRouter<T0>) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public fun passthrough_balance<T0>(arg0: &PassthroughRouter<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun retry_active(arg0: &PendingRetry) : bool {
        arg0.active
    }

    public fun retry_has_payload(arg0: &PendingRetry, arg1: vector<u8>) : bool {
        if (arg0.active) {
            let v1 = 0xef0e98de0e3b96d71da13878b498c518b66f9126718c3cf2b447328f438f5977::memo::payload(&arg1);
            arg0.payload_hash == 0x2::hash::keccak256(&v1)
        } else {
            false
        }
    }

    fun retry_matches(arg0: &PendingRetry, arg1: address, arg2: &vector<u8>) : bool {
        assert!(arg0.router == arg1, 8);
        arg0.active && arg0.payload_hash == 0x2::hash::keccak256(arg2)
    }

    public fun retry_payload(arg0: &PendingRetry) : vector<u8> {
        arg0.payload
    }

    public fun retry_router(arg0: &PendingRetry) : address {
        arg0.router
    }

    public fun router_type_passthrough<T0>(arg0: &PassthroughRouter<T0>) : vector<u8> {
        b"passthrough"
    }

    public fun router_type_split<T0>(arg0: &SplitRouter<T0>) : vector<u8> {
        b"split"
    }

    public fun split_address<T0>(arg0: &SplitRouter<T0>) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public fun split_balance<T0>(arg0: &SplitRouter<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    // decompiled from Move bytecode v7
}

