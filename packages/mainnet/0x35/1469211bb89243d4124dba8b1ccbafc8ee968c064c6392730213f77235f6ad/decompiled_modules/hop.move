module 0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::hop {
    struct Hop has copy, drop, store {
        tunnel_id: vector<u8>,
        node_address: address,
        fee: u64,
        timeout_ms: u64,
        index: u64,
    }

    struct Route has copy, drop, store {
        id: vector<u8>,
        sender: address,
        receiver: address,
        amount: u64,
        hops: vector<Hop>,
        total_fees: u64,
        status: u8,
        created_at: u64,
    }

    struct HTLC has drop, store {
        id: vector<u8>,
        payment_hash: vector<u8>,
        amount: u64,
        sender: address,
        receiver: address,
        expiry_ms: u64,
        status: u8,
        preimage: vector<u8>,
    }

    struct FeePolicy has copy, drop, store {
        base_fee: u64,
        fee_rate_ppm: u64,
        min_htlc: u64,
        max_htlc: u64,
        min_timeout_delta_ms: u64,
    }

    struct RoutingNode has copy, drop, store {
        version: u64,
        address: address,
        tunnel_ids: vector<vector<u8>>,
        fee_policy: FeePolicy,
        active: bool,
        total_routed: u64,
        successful_routes: u64,
        failed_routes: u64,
    }

    struct RouteValidation has copy, drop, store {
        valid: bool,
        error_code: u64,
        error_message: vector<u8>,
        total_amount_needed: u64,
    }

    struct RouteActivated has copy, drop {
        sender: address,
        receiver: address,
        amount: u64,
        hop_count: u64,
    }

    struct RouteCompleted has copy, drop {
        sender: address,
        receiver: address,
        amount: u64,
    }

    struct RouteFailed has copy, drop {
        sender: address,
        receiver: address,
        amount: u64,
    }

    struct HTLCClaimed has copy, drop {
        amount: u64,
        sender: address,
        receiver: address,
    }

    struct HTLCExpired has copy, drop {
        amount: u64,
        sender: address,
        receiver: address,
    }

    public fun activate_node(arg0: &mut RoutingNode, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.address, 13906838044108914689);
        arg0.active = true;
    }

    public fun activate_route(arg0: &mut Route) {
        assert!(arg0.status == 0, 13906836459266506761);
        arg0.status = 1;
        let v0 = RouteActivated{
            sender    : arg0.sender,
            receiver  : arg0.receiver,
            amount    : arg0.amount,
            hop_count : 0x1::vector::length<Hop>(&arg0.hops),
        };
        0x2::event::emit<RouteActivated>(v0);
    }

    public fun add_hop(arg0: &mut Route, arg1: vector<u8>, arg2: address, arg3: u64, arg4: u64) {
        assert!(arg0.status == 0, 13906835892330823689);
        assert!(0x1::vector::length<Hop>(&arg0.hops) < 20, 13906835896625922059);
        assert!(arg3 < arg0.amount, 13906835905215725577);
        0x1::vector::push_back<Hop>(&mut arg0.hops, create_hop(arg1, arg2, arg3, arg4, 0x1::vector::length<Hop>(&arg0.hops)));
        arg0.total_fees = arg0.total_fees + arg3;
    }

    public fun add_tunnel_to_node(arg0: &mut RoutingNode, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.address, 13906837906669961217);
        0x1::vector::push_back<vector<u8>>(&mut arg0.tunnel_ids, arg1);
    }

    public fun assert_current_version(arg0: &RoutingNode) {
        assert!(is_current_version(arg0), 13906837885195386885);
    }

    public fun calculate_fee(arg0: &FeePolicy, arg1: u64) : u64 {
        arg0.base_fee + (((arg1 as u128) * (arg0.fee_rate_ppm as u128) / 1000000) as u64)
    }

    public fun calculate_total_with_fees(arg0: u64, arg1: &Route) : u64 {
        arg0 + arg1.total_fees
    }

    public fun cancel_htlc(arg0: &mut HTLC, arg1: &0x2::tx_context::TxContext) : bool {
        assert!(0x2::tx_context::sender(arg1) == arg0.sender || 0x2::tx_context::sender(arg1) == arg0.receiver, 13906837326849376257);
        if (arg0.status != 0) {
            return false
        };
        arg0.status = 3;
        true
    }

    public fun claim_htlc(arg0: &mut HTLC, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) : bool {
        assert!(0x2::tx_context::sender(arg2) == arg0.receiver, 13906836974662057985);
        claim_htlc_internal(arg0, arg1)
    }

    public(friend) fun claim_htlc_internal(arg0: &mut HTLC, arg1: vector<u8>) : bool {
        if (arg0.status != 0) {
            return false
        };
        if (!verify_preimage(arg0, &arg1)) {
            return false
        };
        arg0.status = 1;
        arg0.preimage = arg1;
        let v0 = HTLCClaimed{
            amount   : arg0.amount,
            sender   : arg0.sender,
            receiver : arg0.receiver,
        };
        0x2::event::emit<HTLCClaimed>(v0);
        true
    }

    public fun complete_route(arg0: &mut Route) {
        assert!(arg0.status == 1, 13906836510806114313);
        arg0.status = 2;
        let v0 = RouteCompleted{
            sender   : arg0.sender,
            receiver : arg0.receiver,
            amount   : arg0.amount,
        };
        0x2::event::emit<RouteCompleted>(v0);
    }

    public fun create_cascading_timeouts(arg0: u64, arg1: u64, arg2: u64) : vector<u64> {
        assert!(arg1 > 0, 13906838340462182409);
        assert!(arg2 >= 60000, 13906838344757018631);
        assert!((arg0 as u128) >= (arg2 as u128) * (arg1 as u128), 13906838374821789703);
        let v0 = vector[];
        let v1 = 0;
        while (v1 < arg1) {
            0x1::vector::push_back<u64>(&mut v0, arg0 - v1 * arg2);
            v1 = v1 + 1;
        };
        v0
    }

    public fun create_fee_policy(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : FeePolicy {
        assert!(arg2 <= arg3, 13906837588842512387);
        assert!(arg4 >= 60000, 13906837593137741831);
        FeePolicy{
            base_fee             : arg0,
            fee_rate_ppm         : arg1,
            min_htlc             : arg2,
            max_htlc             : arg3,
            min_timeout_delta_ms : arg4,
        }
    }

    public fun create_hop(arg0: vector<u8>, arg1: address, arg2: u64, arg3: u64, arg4: u64) : Hop {
        Hop{
            tunnel_id    : arg0,
            node_address : arg1,
            fee          : arg2,
            timeout_ms   : arg3,
            index        : arg4,
        }
    }

    public fun create_htlc(arg0: vector<u8>, arg1: u64, arg2: address, arg3: address, arg4: u64) : HTLC {
        HTLC{
            id           : create_htlc_id(&arg0, arg2, arg3, arg1),
            payment_hash : arg0,
            amount       : arg1,
            sender       : arg2,
            receiver     : arg3,
            expiry_ms    : arg4,
            status       : 0,
            preimage     : b"",
        }
    }

    public fun create_htlc_id(arg0: &vector<u8>, arg1: address, arg2: address, arg3: u64) : vector<u8> {
        let v0 = *arg0;
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg2));
        0x1::vector::append<u8>(&mut v0, 0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::signature::u64_to_be_bytes(arg3));
        0x2::hash::blake2b256(&v0)
    }

    public fun create_payment_hash(arg0: &vector<u8>) : vector<u8> {
        0x2::hash::blake2b256(arg0)
    }

    public fun create_route(arg0: address, arg1: address, arg2: u64, arg3: u64) : Route {
        Route{
            id         : create_route_id(arg0, arg1, arg2, arg3),
            sender     : arg0,
            receiver   : arg1,
            amount     : arg2,
            hops       : 0x1::vector::empty<Hop>(),
            total_fees : 0,
            status     : 0,
            created_at : arg3,
        }
    }

    public fun create_route_id(arg0: address, arg1: address, arg2: u64, arg3: u64) : vector<u8> {
        let v0 = 0x2::address::to_bytes(arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg1));
        0x1::vector::append<u8>(&mut v0, 0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::signature::u64_to_be_bytes(arg2));
        0x1::vector::append<u8>(&mut v0, 0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::signature::u64_to_be_bytes(arg3));
        0x2::hash::blake2b256(&v0)
    }

    public fun create_routing_node(arg0: address, arg1: FeePolicy) : RoutingNode {
        RoutingNode{
            version           : 1,
            address           : arg0,
            tunnel_ids        : vector[],
            fee_policy        : arg1,
            active            : true,
            total_routed      : 0,
            successful_routes : 0,
            failed_routes     : 0,
        }
    }

    public fun current_version() : u64 {
        1
    }

    public fun deactivate_node(arg0: &mut RoutingNode, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.address, 13906838069878718465);
        arg0.active = false;
    }

    public fun default_base_fee() : u64 {
        1000
    }

    public fun default_fee_policy() : FeePolicy {
        FeePolicy{
            base_fee             : 1000,
            fee_rate_ppm         : 100,
            min_htlc             : 1000,
            max_htlc             : 1000000000000,
            min_timeout_delta_ms : 60000,
        }
    }

    public fun default_fee_rate() : u64 {
        100
    }

    public fun estimate_route_fee(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        arg2 * arg1 + (((arg0 as u128) * (arg3 as u128) * (arg1 as u128) / 1000000) as u64)
    }

    public fun expire_htlc(arg0: &mut HTLC, arg1: u64, arg2: &0x2::tx_context::TxContext) : bool {
        assert!(0x2::tx_context::sender(arg2) == arg0.sender, 13906837112101011457);
        if (arg0.status != 0) {
            return false
        };
        if (arg1 < arg0.expiry_ms) {
            return false
        };
        arg0.status = 2;
        let v0 = HTLCExpired{
            amount   : arg0.amount,
            sender   : arg0.sender,
            receiver : arg0.receiver,
        };
        0x2::event::emit<HTLCExpired>(v0);
        true
    }

    public(friend) fun expire_htlc_internal(arg0: &mut HTLC, arg1: u64) : bool {
        if (arg0.status != 0) {
            return false
        };
        if (arg1 < arg0.expiry_ms) {
            return false
        };
        arg0.status = 2;
        let v0 = HTLCExpired{
            amount   : arg0.amount,
            sender   : arg0.sender,
            receiver : arg0.receiver,
        };
        0x2::event::emit<HTLCExpired>(v0);
        true
    }

    public fun fail_route(arg0: &mut Route) {
        assert!(arg0.status == 0 || arg0.status == 1, 13906836566640689161);
        arg0.status = 3;
        let v0 = RouteFailed{
            sender   : arg0.sender,
            receiver : arg0.receiver,
            amount   : arg0.amount,
        };
        0x2::event::emit<RouteFailed>(v0);
    }

    public fun hop_fee(arg0: &Hop) : u64 {
        arg0.fee
    }

    public fun hop_index(arg0: &Hop) : u64 {
        arg0.index
    }

    public fun hop_node_address(arg0: &Hop) : address {
        arg0.node_address
    }

    public fun hop_timeout_ms(arg0: &Hop) : u64 {
        arg0.timeout_ms
    }

    public fun hop_tunnel_id(arg0: &Hop) : &vector<u8> {
        &arg0.tunnel_id
    }

    public fun htlc_amount(arg0: &HTLC) : u64 {
        arg0.amount
    }

    public fun htlc_expiry_ms(arg0: &HTLC) : u64 {
        arg0.expiry_ms
    }

    public fun htlc_id(arg0: &HTLC) : &vector<u8> {
        &arg0.id
    }

    public fun htlc_payment_hash(arg0: &HTLC) : &vector<u8> {
        &arg0.payment_hash
    }

    public fun htlc_preimage(arg0: &HTLC) : &vector<u8> {
        &arg0.preimage
    }

    public fun htlc_receiver(arg0: &HTLC) : address {
        arg0.receiver
    }

    public fun htlc_sender(arg0: &HTLC) : address {
        arg0.sender
    }

    public fun htlc_status(arg0: &HTLC) : u8 {
        arg0.status
    }

    public fun htlc_status_cancelled() : u8 {
        3
    }

    public fun htlc_status_claimed() : u8 {
        1
    }

    public fun htlc_status_expired() : u8 {
        2
    }

    public fun htlc_status_pending() : u8 {
        0
    }

    public fun is_amount_acceptable(arg0: &FeePolicy, arg1: u64) : bool {
        arg1 >= arg0.min_htlc && arg1 <= arg0.max_htlc
    }

    public fun is_current_version(arg0: &RoutingNode) : bool {
        arg0.version == 1
    }

    public fun is_htlc_claimable(arg0: &HTLC, arg1: u64) : bool {
        arg0.status == 0 && arg1 < arg0.expiry_ms
    }

    public fun is_htlc_expired(arg0: &HTLC, arg1: u64) : bool {
        arg0.status == 0 && arg1 >= arg0.expiry_ms
    }

    public fun max_hops() : u64 {
        20
    }

    public fun min_timeout_delta_ms() : u64 {
        60000
    }

    public fun node_address(arg0: &RoutingNode) : address {
        arg0.address
    }

    public fun node_failed_routes(arg0: &RoutingNode) : u64 {
        arg0.failed_routes
    }

    public fun node_fee_policy(arg0: &RoutingNode) : &FeePolicy {
        &arg0.fee_policy
    }

    public fun node_is_active(arg0: &RoutingNode) : bool {
        arg0.active
    }

    public fun node_success_rate(arg0: &RoutingNode) : u64 {
        let v0 = arg0.successful_routes + arg0.failed_routes;
        if (v0 == 0) {
            return 10000
        };
        arg0.successful_routes * 10000 / v0
    }

    public fun node_successful_routes(arg0: &RoutingNode) : u64 {
        arg0.successful_routes
    }

    public fun node_total_routed(arg0: &RoutingNode) : u64 {
        arg0.total_routed
    }

    public fun node_tunnel_count(arg0: &RoutingNode) : u64 {
        0x1::vector::length<vector<u8>>(&arg0.tunnel_ids)
    }

    public fun node_tunnel_ids(arg0: &RoutingNode) : &vector<vector<u8>> {
        &arg0.tunnel_ids
    }

    public fun node_version(arg0: &RoutingNode) : u64 {
        arg0.version
    }

    public fun policy_base_fee(arg0: &FeePolicy) : u64 {
        arg0.base_fee
    }

    public fun policy_fee_rate_ppm(arg0: &FeePolicy) : u64 {
        arg0.fee_rate_ppm
    }

    public fun policy_max_htlc(arg0: &FeePolicy) : u64 {
        arg0.max_htlc
    }

    public fun policy_min_htlc(arg0: &FeePolicy) : u64 {
        arg0.min_htlc
    }

    public fun policy_min_timeout_delta_ms(arg0: &FeePolicy) : u64 {
        arg0.min_timeout_delta_ms
    }

    public fun record_failed_route(arg0: &mut RoutingNode, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.address, 13906838018339110913);
        arg0.failed_routes = arg0.failed_routes + 1;
    }

    public fun record_successful_route(arg0: &mut RoutingNode, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.address, 13906837988274339841);
        arg0.total_routed = arg0.total_routed + arg1;
        arg0.successful_routes = arg0.successful_routes + 1;
    }

    public fun remove_tunnel_from_node(arg0: &mut RoutingNode, arg1: &vector<u8>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.address, 13906837949619634177);
        let v0 = &arg0.tunnel_ids;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<vector<u8>>(v0)) {
            if (0x1::vector::borrow<vector<u8>>(v0, v1) == arg1) {
                v2 = 0x1::option::some<u64>(v1);
                /* label 8 */
                if (0x1::option::is_some<u64>(&v2)) {
                    0x1::vector::swap_remove<vector<u8>>(&mut arg0.tunnel_ids, *0x1::option::borrow<u64>(&v2));
                };
                return
            };
            v1 = v1 + 1;
        };
        v2 = 0x1::option::none<u64>();
        /* goto 8 */
    }

    public fun route_amount(arg0: &Route) : u64 {
        arg0.amount
    }

    public fun route_created_at(arg0: &Route) : u64 {
        arg0.created_at
    }

    public fun route_get_hop(arg0: &Route, arg1: u64) : &Hop {
        assert!(arg1 < 0x1::vector::length<Hop>(&arg0.hops), 13906836699784675337);
        0x1::vector::borrow<Hop>(&arg0.hops, arg1)
    }

    public fun route_hop_count(arg0: &Route) : u64 {
        0x1::vector::length<Hop>(&arg0.hops)
    }

    public fun route_hops(arg0: &Route) : &vector<Hop> {
        &arg0.hops
    }

    public fun route_id(arg0: &Route) : &vector<u8> {
        &arg0.id
    }

    public fun route_receiver(arg0: &Route) : address {
        arg0.receiver
    }

    public fun route_sender(arg0: &Route) : address {
        arg0.sender
    }

    public fun route_status(arg0: &Route) : u8 {
        arg0.status
    }

    public fun route_status_active() : u8 {
        1
    }

    public fun route_status_completed() : u8 {
        2
    }

    public fun route_status_failed() : u8 {
        3
    }

    public fun route_status_planning() : u8 {
        0
    }

    public fun route_total_fees(arg0: &Route) : u64 {
        arg0.total_fees
    }

    public fun update_node_fee_policy(arg0: &mut RoutingNode, arg1: FeePolicy, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.address, 13906838095648522241);
        arg0.fee_policy = arg1;
    }

    public fun validate_route(arg0: &Route) : RouteValidation {
        if (0x1::vector::length<Hop>(&arg0.hops) == 0) {
            return RouteValidation{
                valid               : false,
                error_code          : 700,
                error_message       : b"Route must have at least one hop",
                total_amount_needed : 0,
            }
        };
        if (0x1::vector::length<Hop>(&arg0.hops) > 20) {
            return RouteValidation{
                valid               : false,
                error_code          : 707,
                error_message       : b"Route exceeds maximum hops",
                total_amount_needed : 0,
            }
        };
        let v0 = 0x1::vector::length<Hop>(&arg0.hops);
        if (v0 > 1) {
            let v1 = 1;
            while (v1 < v0) {
                let v2 = 0x1::vector::borrow<Hop>(&arg0.hops, v1 - 1);
                let v3 = 0x1::vector::borrow<Hop>(&arg0.hops, v1);
                if (v3.timeout_ms >= v2.timeout_ms) {
                    return RouteValidation{
                        valid               : false,
                        error_code          : 510,
                        error_message       : b"Timeouts must decrease along route",
                        total_amount_needed : 0,
                    }
                };
                if (v2.timeout_ms - v3.timeout_ms < 60000) {
                    return RouteValidation{
                        valid               : false,
                        error_code          : 510,
                        error_message       : b"Timeout delta too small",
                        total_amount_needed : 0,
                    }
                };
                v1 = v1 + 1;
            };
        };
        if (0x1::vector::borrow<Hop>(&arg0.hops, v0 - 1).node_address != arg0.receiver) {
            return RouteValidation{
                valid               : false,
                error_code          : 700,
                error_message       : b"Final hop must go to receiver",
                total_amount_needed : 0,
            }
        };
        if ((arg0.total_fees as u128) >= (arg0.amount as u128)) {
            return RouteValidation{
                valid               : false,
                error_code          : 800,
                error_message       : b"Total fees must be less than route amount",
                total_amount_needed : 0,
            }
        };
        let v4 = 0;
        let v5 = 0;
        while (v5 < v0) {
            let v6 = (0x1::vector::borrow<Hop>(&arg0.hops, v5).fee as u128);
            if (v6 >= (arg0.amount as u128) - v4) {
                return RouteValidation{
                    valid               : false,
                    error_code          : 800,
                    error_message       : b"Hop fee exceeds amount reaching the hop",
                    total_amount_needed : 0,
                }
            };
            v4 = v4 + v6;
            v5 = v5 + 1;
        };
        let v7 = (arg0.amount as u128) + (arg0.total_fees as u128);
        if (v7 > 18446744073709551615) {
            return RouteValidation{
                valid               : false,
                error_code          : 2,
                error_message       : b"Total amount (amount + fees) overflows u64",
                total_amount_needed : 0,
            }
        };
        RouteValidation{
            valid               : true,
            error_code          : 0,
            error_message       : b"",
            total_amount_needed : (v7 as u64),
        }
    }

    public fun validation_error_code(arg0: &RouteValidation) : u64 {
        arg0.error_code
    }

    public fun validation_error_message(arg0: &RouteValidation) : &vector<u8> {
        &arg0.error_message
    }

    public fun validation_total_amount(arg0: &RouteValidation) : u64 {
        arg0.total_amount_needed
    }

    public fun validation_valid(arg0: &RouteValidation) : bool {
        arg0.valid
    }

    public fun verify_preimage(arg0: &HTLC, arg1: &vector<u8>) : bool {
        create_payment_hash(arg1) == arg0.payment_hash
    }

    // decompiled from Move bytecode v7
}

