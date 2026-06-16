module 0xa58f2dee1dd01ac655ef2d9180a96228ab4667219049cfc1286752b3923ad730::yield_router {
    struct YieldPosition has key {
        id: 0x2::object::UID,
        owner: address,
        basis_usdc: u64,
        active_venues: u8,
        rotations_total: u64,
        rebalance_enabled: bool,
        rebalance_paused: bool,
        max_per_rotation: u64,
        max_per_day: u64,
        used_today: u64,
        day_start_ms: u64,
        expires_at_ms: u64,
    }

    struct RebalanceRegistry has key {
        id: 0x2::object::UID,
        admin: address,
        workers: vector<address>,
        paused_venues: u8,
    }

    struct RotationTicket {
        position_id: 0x2::object::ID,
        from_venue: u8,
        to_venue: u8,
        amount: u64,
    }

    struct PositionMinted has copy, drop {
        position_id: 0x2::object::ID,
        owner: address,
    }

    struct ReceiptDeposited has copy, drop {
        position_id: 0x2::object::ID,
        venue: u8,
        basis_added: u64,
    }

    struct ReceiptRemoved has copy, drop {
        position_id: 0x2::object::ID,
        venue: u8,
    }

    struct Rotated has copy, drop {
        position_id: 0x2::object::ID,
        from_venue: u8,
        to_venue: u8,
        amount: u64,
        ts_ms: u64,
    }

    public fun active_venues(arg0: &YieldPosition) : u8 {
        arg0.active_venues
    }

    public fun add_worker(arg0: &mut RebalanceRegistry, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 400);
        if (!0x1::vector::contains<address>(&arg0.workers, &arg1)) {
            0x1::vector::push_back<address>(&mut arg0.workers, arg1);
        };
    }

    public fun basis_usdc(arg0: &YieldPosition) : u64 {
        arg0.basis_usdc
    }

    public fun begin_rotation<T0: store + key>(arg0: &mut YieldPosition, arg1: &RebalanceRegistry, arg2: u8, arg3: u8, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) : (T0, RotationTicket) {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(0x1::vector::contains<address>(&arg1.workers, &v0), 406);
        assert!(arg0.rebalance_enabled, 412);
        assert!(!arg0.rebalance_paused, 402);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        assert!(v1 < arg0.expires_at_ms, 403);
        assert!(arg4 > 0, 411);
        assert!(arg4 <= arg0.max_per_rotation, 404);
        if (v1 >= arg0.day_start_ms + 86400000) {
            arg0.day_start_ms = v1;
            arg0.used_today = 0;
        };
        assert!(arg0.used_today <= arg0.max_per_day, 405);
        assert!(arg4 <= arg0.max_per_day - arg0.used_today, 405);
        arg0.used_today = arg0.used_today + arg4;
        assert!(is_known_venue(arg2) && is_known_venue(arg3), 407);
        assert!(arg2 != arg3, 410);
        assert!(arg1.paused_venues & venue_bit(arg3) == 0, 408);
        assert!(0x2::dynamic_object_field::exists_with_type<u8, T0>(&arg0.id, arg2), 409);
        arg0.active_venues = arg0.active_venues & (255 ^ venue_bit(arg2));
        let v2 = RotationTicket{
            position_id : 0x2::object::id<YieldPosition>(arg0),
            from_venue  : arg2,
            to_venue    : arg3,
            amount      : arg4,
        };
        (0x2::dynamic_object_field::remove<u8, T0>(&mut arg0.id, arg2), v2)
    }

    public fun deposit_receipt<T0: store + key>(arg0: &mut YieldPosition, arg1: T0, arg2: u8, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 400);
        assert!(is_known_venue(arg2), 407);
        0x2::dynamic_object_field::add<u8, T0>(&mut arg0.id, arg2, arg1);
        arg0.active_venues = arg0.active_venues | venue_bit(arg2);
        arg0.basis_usdc = arg0.basis_usdc + arg3;
        let v0 = ReceiptDeposited{
            position_id : 0x2::object::id<YieldPosition>(arg0),
            venue       : arg2,
            basis_added : arg3,
        };
        0x2::event::emit<ReceiptDeposited>(v0);
    }

    public fun disable_rebalance(arg0: &mut YieldPosition, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 400);
        arg0.rebalance_enabled = false;
    }

    public fun enable_rebalance(arg0: &mut YieldPosition, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.owner, 400);
        arg0.rebalance_enabled = true;
        arg0.rebalance_paused = false;
        arg0.max_per_rotation = arg1;
        arg0.max_per_day = arg2;
        arg0.used_today = 0;
        arg0.day_start_ms = 0x2::clock::timestamp_ms(arg4);
        arg0.expires_at_ms = arg3;
    }

    public fun end_rotation<T0: store + key>(arg0: &mut YieldPosition, arg1: T0, arg2: RotationTicket, arg3: &0x2::clock::Clock) {
        let RotationTicket {
            position_id : v0,
            from_venue  : v1,
            to_venue    : v2,
            amount      : v3,
        } = arg2;
        assert!(v0 == 0x2::object::id<YieldPosition>(arg0), 401);
        0x2::dynamic_object_field::add<u8, T0>(&mut arg0.id, v2, arg1);
        arg0.active_venues = arg0.active_venues | venue_bit(v2);
        arg0.rotations_total = arg0.rotations_total + 1;
        let v4 = Rotated{
            position_id : 0x2::object::id<YieldPosition>(arg0),
            from_venue  : v1,
            to_venue    : v2,
            amount      : v3,
            ts_ms       : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<Rotated>(v4);
    }

    public fun holds(arg0: &YieldPosition, arg1: u8) : bool {
        0x2::dynamic_object_field::exists_<u8>(&arg0.id, arg1)
    }

    fun is_known_venue(arg0: u8) : bool {
        if (arg0 == 1) {
            true
        } else if (arg0 == 2) {
            true
        } else if (arg0 == 3) {
            true
        } else {
            arg0 == 4
        }
    }

    public fun mint_position(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = YieldPosition{
            id                : 0x2::object::new(arg0),
            owner             : 0x2::tx_context::sender(arg0),
            basis_usdc        : 0,
            active_venues     : 0,
            rotations_total   : 0,
            rebalance_enabled : false,
            rebalance_paused  : false,
            max_per_rotation  : 0,
            max_per_day       : 0,
            used_today        : 0,
            day_start_ms      : 0,
            expires_at_ms     : 0,
        };
        let v1 = PositionMinted{
            position_id : 0x2::object::id<YieldPosition>(&v0),
            owner       : 0x2::tx_context::sender(arg0),
        };
        0x2::event::emit<PositionMinted>(v1);
        0x2::transfer::share_object<YieldPosition>(v0);
    }

    public fun new_registry(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RebalanceRegistry{
            id            : 0x2::object::new(arg0),
            admin         : 0x2::tx_context::sender(arg0),
            workers       : vector[],
            paused_venues : 0,
        };
        0x2::transfer::share_object<RebalanceRegistry>(v0);
    }

    public fun owner(arg0: &YieldPosition) : address {
        arg0.owner
    }

    public fun pause(arg0: &mut YieldPosition, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 400);
        arg0.rebalance_paused = true;
    }

    public fun rebalance_enabled(arg0: &YieldPosition) : bool {
        arg0.rebalance_enabled
    }

    public fun resume(arg0: &mut YieldPosition, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 400);
        arg0.rebalance_paused = false;
    }

    public fun rotations_total(arg0: &YieldPosition) : u64 {
        arg0.rotations_total
    }

    public fun set_venue_paused(arg0: &mut RebalanceRegistry, arg1: u8, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 400);
        assert!(is_known_venue(arg1), 407);
        let v0 = if (arg2) {
            arg0.paused_venues | venue_bit(arg1)
        } else {
            arg0.paused_venues & (255 ^ venue_bit(arg1))
        };
        arg0.paused_venues = v0;
    }

    public fun take_receipt<T0: store + key>(arg0: &mut YieldPosition, arg1: u8, arg2: u64, arg3: &0x2::tx_context::TxContext) : T0 {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 400);
        assert!(0x2::dynamic_object_field::exists_with_type<u8, T0>(&arg0.id, arg1), 409);
        arg0.active_venues = arg0.active_venues & (255 ^ venue_bit(arg1));
        let v0 = if (arg2 >= arg0.basis_usdc) {
            0
        } else {
            arg0.basis_usdc - arg2
        };
        arg0.basis_usdc = v0;
        let v1 = ReceiptRemoved{
            position_id : 0x2::object::id<YieldPosition>(arg0),
            venue       : arg1,
        };
        0x2::event::emit<ReceiptRemoved>(v1);
        0x2::dynamic_object_field::remove<u8, T0>(&mut arg0.id, arg1)
    }

    fun venue_bit(arg0: u8) : u8 {
        1 << ((arg0 - 1) as u8)
    }

    // decompiled from Move bytecode v7
}

