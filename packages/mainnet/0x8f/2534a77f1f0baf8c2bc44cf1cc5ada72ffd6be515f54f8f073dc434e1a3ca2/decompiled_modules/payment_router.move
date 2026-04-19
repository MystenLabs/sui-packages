module 0x8f2534a77f1f0baf8c2bc44cf1cc5ada72ffd6be515f54f8f073dc434e1a3ca2::payment_router {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct AgentCap has store, key {
        id: 0x2::object::UID,
        agent_address: address,
    }

    struct SponsorCap has store, key {
        id: 0x2::object::UID,
        sponsor_address: address,
        daily_limit: u64,
        used_today: u64,
        last_reset: u64,
    }

    struct PaymentRouterState has key {
        id: 0x2::object::UID,
        total_payments: u64,
        total_volume: u64,
        sponsor_fund: 0x2::balance::Balance<0x2::sui::SUI>,
        routes: 0x2::table::Table<address, 0x2::object::ID>,
        paused: bool,
        fee_recipient: address,
        routing_fee_bps: u64,
    }

    struct PaymentRoute has store, key {
        id: 0x2::object::UID,
        destination: address,
        name: 0x1::string::String,
        is_active: bool,
        payment_count: u64,
        volume: u64,
    }

    struct PaymentRecord has store, key {
        id: 0x2::object::UID,
        sender: address,
        recipient: address,
        amount: u64,
        fee: u64,
        timestamp: u64,
        reference: 0x1::string::String,
        sponsored: bool,
    }

    struct PaymentRouted has copy, drop {
        payment_id: 0x2::object::ID,
        sender: address,
        recipient: address,
        amount: u64,
        fee: u64,
        sponsored: bool,
    }

    struct RouteCreated has copy, drop {
        route_id: 0x2::object::ID,
        destination: address,
        name: 0x1::string::String,
    }

    struct RouteUpdated has copy, drop {
        route_id: 0x2::object::ID,
        is_active: bool,
    }

    struct SponsorFundDeposited has copy, drop {
        sponsor: address,
        amount: u64,
        new_balance: u64,
    }

    struct SponsoredTransaction has copy, drop {
        sponsor: address,
        beneficiary: address,
        gas_covered: u64,
        timestamp: u64,
    }

    public entry fun create_route(arg0: &AdminCap, arg1: &mut PaymentRouterState, arg2: address, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = PaymentRoute{
            id            : 0x2::object::new(arg4),
            destination   : arg2,
            name          : arg3,
            is_active     : true,
            payment_count : 0,
            volume        : 0,
        };
        let v1 = 0x2::object::id<PaymentRoute>(&v0);
        0x2::table::add<address, 0x2::object::ID>(&mut arg1.routes, arg2, v1);
        let v2 = RouteCreated{
            route_id    : v1,
            destination : arg2,
            name        : v0.name,
        };
        0x2::event::emit<RouteCreated>(v2);
        0x2::transfer::share_object<PaymentRoute>(v0);
    }

    public entry fun create_sponsor(arg0: &AdminCap, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = SponsorCap{
            id              : 0x2::object::new(arg4),
            sponsor_address : arg1,
            daily_limit     : arg2,
            used_today      : 0,
            last_reset      : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::transfer::transfer<SponsorCap>(v0, arg1);
    }

    public entry fun deposit_sponsor_fund(arg0: &mut PaymentRouterState, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sponsor_fund, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v0 = SponsorFundDeposited{
            sponsor     : 0x2::tx_context::sender(arg2),
            amount      : 0x2::coin::value<0x2::sui::SUI>(&arg1),
            new_balance : 0x2::balance::value<0x2::sui::SUI>(&arg0.sponsor_fund),
        };
        0x2::event::emit<SponsorFundDeposited>(v0);
    }

    public fun get_route_info(arg0: &PaymentRoute) : (address, bool, u64, u64) {
        (arg0.destination, arg0.is_active, arg0.payment_count, arg0.volume)
    }

    public fun get_router_stats(arg0: &PaymentRouterState) : (u64, u64, u64) {
        (arg0.total_payments, arg0.total_volume, 0x2::balance::value<0x2::sui::SUI>(&arg0.sponsor_fund))
    }

    public fun get_sponsor_info(arg0: &SponsorCap) : (u64, u64) {
        (arg0.daily_limit, arg0.used_today)
    }

    public entry fun grant_agent_role(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = AgentCap{
            id            : 0x2::object::new(arg2),
            agent_address : arg1,
        };
        0x2::transfer::transfer<AgentCap>(v0, arg1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, v0);
        let v2 = PaymentRouterState{
            id              : 0x2::object::new(arg0),
            total_payments  : 0,
            total_volume    : 0,
            sponsor_fund    : 0x2::balance::zero<0x2::sui::SUI>(),
            routes          : 0x2::table::new<address, 0x2::object::ID>(arg0),
            paused          : false,
            fee_recipient   : v0,
            routing_fee_bps : 10,
        };
        0x2::transfer::share_object<PaymentRouterState>(v2);
    }

    public fun is_paused(arg0: &PaymentRouterState) : bool {
        arg0.paused
    }

    public entry fun record_sponsored_tx(arg0: &mut SponsorCap, arg1: &PaymentRouterState, arg2: address, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.paused, 3);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        if (v0 >= arg0.last_reset + 86400000) {
            arg0.used_today = 0;
            arg0.last_reset = v0;
        };
        assert!(arg0.used_today + arg3 <= arg0.daily_limit, 5);
        arg0.used_today = arg0.used_today + arg3;
        let v1 = SponsoredTransaction{
            sponsor     : arg0.sponsor_address,
            beneficiary : arg2,
            gas_covered : arg3,
            timestamp   : v0,
        };
        0x2::event::emit<SponsoredTransaction>(v1);
    }

    public entry fun route_payment(arg0: &mut PaymentRouterState, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: address, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 3);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v1 > 0, 2);
        let v2 = v1 * arg0.routing_fee_bps / 10000;
        let v3 = v1 - v2;
        let v4 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v4, v2), arg5), arg0.fee_recipient);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v4, arg5), arg2);
        arg0.total_payments = arg0.total_payments + 1;
        arg0.total_volume = arg0.total_volume + v1;
        let v5 = PaymentRecord{
            id        : 0x2::object::new(arg5),
            sender    : v0,
            recipient : arg2,
            amount    : v3,
            fee       : v2,
            timestamp : 0x2::clock::timestamp_ms(arg4),
            reference : arg3,
            sponsored : false,
        };
        let v6 = PaymentRouted{
            payment_id : 0x2::object::id<PaymentRecord>(&v5),
            sender     : v0,
            recipient  : arg2,
            amount     : v3,
            fee        : v2,
            sponsored  : false,
        };
        0x2::event::emit<PaymentRouted>(v6);
        0x2::transfer::transfer<PaymentRecord>(v5, v0);
    }

    public entry fun route_payment_via_route(arg0: &mut PaymentRouterState, arg1: &mut PaymentRoute, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 3);
        assert!(arg1.is_active, 4);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        let v2 = arg1.destination;
        let v3 = v1 * arg0.routing_fee_bps / 10000;
        let v4 = v1 - v3;
        let v5 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v5, v3), arg5), arg0.fee_recipient);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v5, arg5), v2);
        arg1.payment_count = arg1.payment_count + 1;
        arg1.volume = arg1.volume + v1;
        arg0.total_payments = arg0.total_payments + 1;
        arg0.total_volume = arg0.total_volume + v1;
        let v6 = PaymentRecord{
            id        : 0x2::object::new(arg5),
            sender    : v0,
            recipient : v2,
            amount    : v4,
            fee       : v3,
            timestamp : 0x2::clock::timestamp_ms(arg4),
            reference : arg3,
            sponsored : false,
        };
        let v7 = PaymentRouted{
            payment_id : 0x2::object::id<PaymentRecord>(&v6),
            sender     : v0,
            recipient  : v2,
            amount     : v4,
            fee        : v3,
            sponsored  : false,
        };
        0x2::event::emit<PaymentRouted>(v7);
        0x2::transfer::transfer<PaymentRecord>(v6, v0);
    }

    public entry fun set_fee_recipient(arg0: &AdminCap, arg1: &mut PaymentRouterState, arg2: address) {
        arg1.fee_recipient = arg2;
    }

    public entry fun set_paused(arg0: &AdminCap, arg1: &mut PaymentRouterState, arg2: bool) {
        arg1.paused = arg2;
    }

    public entry fun set_routing_fee(arg0: &AdminCap, arg1: &mut PaymentRouterState, arg2: u64) {
        assert!(arg2 <= 1000, 2);
        arg1.routing_fee_bps = arg2;
    }

    public entry fun update_route_status(arg0: &AdminCap, arg1: &mut PaymentRoute, arg2: bool) {
        arg1.is_active = arg2;
        let v0 = RouteUpdated{
            route_id  : 0x2::object::id<PaymentRoute>(arg1),
            is_active : arg2,
        };
        0x2::event::emit<RouteUpdated>(v0);
    }

    public entry fun withdraw_sponsor_fund(arg0: &AdminCap, arg1: &mut PaymentRouterState, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.sponsor_fund) >= arg2, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.sponsor_fund, arg2), arg3), arg1.fee_recipient);
    }

    // decompiled from Move bytecode v7
}

