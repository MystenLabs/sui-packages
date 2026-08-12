module 0x84c679c4363edd63890dbdeffda14c6730a38f150d7c19a5df50b87d29f2832b::router {
    struct Config has key {
        id: 0x2::object::UID,
        owner: address,
        pending_owner: address,
        fee_bps: u64,
        paused: bool,
        frozen: bool,
        activated: bool,
        venues: 0x2::vec_map::VecMap<vector<u8>, bool>,
        venue_eta: 0x2::vec_map::VecMap<vector<u8>, u64>,
        solids: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        solid_eta: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
    }

    struct Ticket {
        sender: address,
        in_type: 0x1::type_name::TypeName,
        in_gross: u64,
        fee_on_input: bool,
        min_out: u64,
        cur_type: 0x1::type_name::TypeName,
        cur_value: u64,
        legs: u8,
        fee_done: bool,
        fee_amount: u64,
        mid_type: 0x1::option::Option<0x1::type_name::TypeName>,
        venue1: vector<u8>,
        venue2: vector<u8>,
    }

    struct Swapped has copy, drop {
        sender: address,
        token_in: 0x1::type_name::TypeName,
        token_out: 0x1::type_name::TypeName,
        amount_in: u64,
        out: u64,
        fee: u64,
        fee_on_input: bool,
        venue: vector<u8>,
    }

    struct SwappedTwoLeg has copy, drop {
        sender: address,
        token_in: 0x1::type_name::TypeName,
        token_out: 0x1::type_name::TypeName,
        intermediate: 0x1::type_name::TypeName,
        amount_in: u64,
        out: u64,
        fee: u64,
        venue1: vector<u8>,
        venue2: vector<u8>,
    }

    struct VenueProposed has copy, drop {
        name: vector<u8>,
        eta: u64,
    }

    struct VenueAdded has copy, drop {
        name: vector<u8>,
    }

    struct VenueRemoved has copy, drop {
        name: vector<u8>,
    }

    struct SolidProposed has copy, drop {
        solid: 0x1::type_name::TypeName,
        eta: u64,
    }

    struct SolidAdded has copy, drop {
        solid: 0x1::type_name::TypeName,
    }

    struct SolidRemoved has copy, drop {
        solid: 0x1::type_name::TypeName,
    }

    struct SolidsRegistered has copy, drop {
        solids: vector<0x1::type_name::TypeName>,
    }

    struct FeeChanged has copy, drop {
        bps: u64,
    }

    struct PausedEvent has copy, drop {
        by: address,
    }

    struct UnpausedEvent has copy, drop {
        by: address,
    }

    struct OwnershipTransferStarted has copy, drop {
        from: address,
        to: address,
    }

    struct OwnershipTransferred has copy, drop {
        from: address,
        to: address,
    }

    struct Frozen has copy, drop {
        by: address,
    }

    struct Activated has copy, drop {
        by: address,
    }

    public fun accept_ownership(arg0: &mut Config, arg1: &0x2::tx_context::TxContext) {
        assert_not_frozen(arg0);
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(arg0.pending_owner != @0x0 && v0 == arg0.pending_owner, 25);
        arg0.owner = v0;
        arg0.pending_owner = @0x0;
        let v1 = OwnershipTransferred{
            from : arg0.owner,
            to   : v0,
        };
        0x2::event::emit<OwnershipTransferred>(v1);
    }

    public fun activate(arg0: &mut Config, arg1: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg1);
        assert!(!arg0.activated, 28);
        arg0.activated = true;
        let v0 = SolidsRegistered{solids: 0x2::vec_set::into_keys<0x1::type_name::TypeName>(arg0.solids)};
        0x2::event::emit<SolidsRegistered>(v0);
        let v1 = Activated{by: 0x2::tx_context::sender(arg1)};
        0x2::event::emit<Activated>(v1);
    }

    fun assert_not_frozen(arg0: &Config) {
        assert!(!arg0.frozen, 20);
    }

    fun assert_owner(arg0: &Config, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 19);
    }

    public fun begin_swap<T0>(arg0: &Config, arg1: 0x2::coin::Coin<T0>, arg2: bool, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (Ticket, 0x2::coin::Coin<T0>) {
        assert!(arg0.activated, 2);
        assert!(!arg0.paused, 1);
        assert!(arg3 != 0, 3);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 != 0, 4);
        let v1 = false;
        let v2 = 0;
        if (arg2) {
            assert!(is_solid_or_sui<T0>(arg0), 5);
            let v3 = bps_of(v0, arg0.fee_bps);
            assert!(v0 - v3 != 0, 6);
            if (v3 != 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, v3, arg4), @0x31144765db2bb7a2c275fcf86e300b4062457daa113901e27a3264d6afd47c56);
            };
            v1 = true;
            v2 = v3;
        };
        let v4 = Ticket{
            sender       : 0x2::tx_context::sender(arg4),
            in_type      : 0x1::type_name::with_defining_ids<T0>(),
            in_gross     : v0,
            fee_on_input : arg2,
            min_out      : arg3,
            cur_type     : 0x1::type_name::with_defining_ids<T0>(),
            cur_value    : 0x2::coin::value<T0>(&arg1),
            legs         : 0,
            fee_done     : v1,
            fee_amount   : v2,
            mid_type     : 0x1::option::none<0x1::type_name::TypeName>(),
            venue1       : b"",
            venue2       : b"",
        };
        (v4, arg1)
    }

    fun bps_of(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (10000 as u128)) as u64)
    }

    public fun execute_solid<T0>(arg0: &mut Config, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg2);
        assert_not_frozen(arg0);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.solid_eta, &v0), 24);
        let (_, v2) = 0x2::vec_map::remove<0x1::type_name::TypeName, u64>(&mut arg0.solid_eta, &v0);
        assert!(0x2::clock::timestamp_ms(arg1) >= v2, 24);
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.solids, &v0)) {
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.solids, v0);
        };
        let v3 = SolidAdded{solid: v0};
        0x2::event::emit<SolidAdded>(v3);
    }

    public fun execute_venue(arg0: &mut Config, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg3);
        assert_not_frozen(arg0);
        assert!(0x2::vec_map::contains<vector<u8>, u64>(&arg0.venue_eta, &arg1), 24);
        let (_, v1) = 0x2::vec_map::remove<vector<u8>, u64>(&mut arg0.venue_eta, &arg1);
        assert!(0x2::clock::timestamp_ms(arg2) >= v1, 24);
        if (0x2::vec_map::contains<vector<u8>, bool>(&arg0.venues, &arg1)) {
            *0x2::vec_map::get_mut<vector<u8>, bool>(&mut arg0.venues, &arg1) = true;
        } else {
            0x2::vec_map::insert<vector<u8>, bool>(&mut arg0.venues, arg1, true);
        };
        let v2 = VenueAdded{name: arg1};
        0x2::event::emit<VenueAdded>(v2);
    }

    public fun fee_bps(arg0: &Config) : u64 {
        arg0.fee_bps
    }

    public fun fee_recipient() : address {
        @0x31144765db2bb7a2c275fcf86e300b4062457daa113901e27a3264d6afd47c56
    }

    public fun finish_swap<T0>(arg0: Ticket, arg1: &Config, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let Ticket {
            sender       : v0,
            in_type      : v1,
            in_gross     : v2,
            fee_on_input : v3,
            min_out      : v4,
            cur_type     : v5,
            cur_value    : v6,
            legs         : v7,
            fee_done     : v8,
            fee_amount   : v9,
            mid_type     : v10,
            venue1       : v11,
            venue2       : v12,
        } = arg0;
        let v13 = v10;
        assert!(v7 >= 1, 17);
        let v14 = 0x1::type_name::with_defining_ids<T0>();
        assert!(v14 == v5, 11);
        assert!(0x2::coin::value<T0>(&arg2) == v6, 12);
        assert!(v14 != v1, 16);
        if (0x1::option::is_some<0x1::type_name::TypeName>(&v13)) {
            assert!(v14 != *0x1::option::borrow<0x1::type_name::TypeName>(&v13), 16);
        };
        let v15 = 0x2::coin::value<T0>(&arg2);
        let v16 = v9;
        let v17 = if (v7 == 1 && !v8) {
            assert!(is_solid_or_sui<T0>(arg1), 5);
            let v18 = bps_of(v15, arg1.fee_bps);
            v16 = v18;
            if (v18 != 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg2, v18, arg3), @0x31144765db2bb7a2c275fcf86e300b4062457daa113901e27a3264d6afd47c56);
            };
            v15 - v18
        } else {
            assert!(v8, 29);
            v15
        };
        assert!(v17 >= v4, 18);
        if (v7 == 1) {
            let v19 = Swapped{
                sender       : v0,
                token_in     : v1,
                token_out    : v14,
                amount_in    : v2,
                out          : v15,
                fee          : v16,
                fee_on_input : v3,
                venue        : v11,
            };
            0x2::event::emit<Swapped>(v19);
        } else {
            let v20 = SwappedTwoLeg{
                sender       : v0,
                token_in     : v1,
                token_out    : v14,
                intermediate : *0x1::option::borrow<0x1::type_name::TypeName>(&v13),
                amount_in    : v2,
                out          : v15,
                fee          : v16,
                venue1       : v11,
                venue2       : v12,
            };
            0x2::event::emit<SwappedTwoLeg>(v20);
        };
        arg2
    }

    public fun freeze_forever(arg0: &mut Config, arg1: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg1);
        arg0.frozen = true;
        let v0 = Frozen{by: 0x2::tx_context::sender(arg1)};
        0x2::event::emit<Frozen>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id            : 0x2::object::new(arg0),
            owner         : 0x2::tx_context::sender(arg0),
            pending_owner : @0x0,
            fee_bps       : 50,
            paused        : false,
            frozen        : false,
            activated     : false,
            venues        : 0x2::vec_map::empty<vector<u8>, bool>(),
            venue_eta     : 0x2::vec_map::empty<vector<u8>, u64>(),
            solids        : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            solid_eta     : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
        };
        0x2::transfer::share_object<Config>(v0);
    }

    public fun is_activated(arg0: &Config) : bool {
        arg0.activated
    }

    public fun is_frozen(arg0: &Config) : bool {
        arg0.frozen
    }

    public fun is_paused(arg0: &Config) : bool {
        arg0.paused
    }

    public fun is_solid<T0>(arg0: &Config) : bool {
        is_solid_or_sui<T0>(arg0)
    }

    fun is_solid_or_sui<T0>(arg0: &Config) : bool {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        v0 == 0x1::type_name::with_defining_ids<0x2::sui::SUI>() || 0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.solids, &v0)
    }

    public fun is_venue_enabled(arg0: &Config, arg1: vector<u8>) : bool {
        venue_enabled(arg0, &arg1)
    }

    fun known_venue(arg0: &vector<u8>) : bool {
        let v0 = b"cetus";
        if (arg0 == &v0) {
            true
        } else {
            let v2 = b"bluefin";
            if (arg0 == &v2) {
                true
            } else {
                let v3 = b"turbos-finance";
                if (arg0 == &v3) {
                    true
                } else {
                    let v4 = b"momentum";
                    if (arg0 == &v4) {
                        true
                    } else {
                        let v5 = b"fullsail-finance";
                        if (arg0 == &v5) {
                            true
                        } else {
                            let v6 = b"ferra-dlmm";
                            if (arg0 == &v6) {
                                true
                            } else {
                                let v7 = b"flowx-clmm";
                                if (arg0 == &v7) {
                                    true
                                } else {
                                    let v8 = b"flow-x";
                                    if (arg0 == &v8) {
                                        true
                                    } else {
                                        let v9 = b"suidex";
                                        if (arg0 == &v9) {
                                            true
                                        } else {
                                            let v10 = b"kriya-dex";
                                            if (arg0 == &v10) {
                                                true
                                            } else {
                                                let v11 = b"steamm";
                                                arg0 == &v11
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    public(friend) fun leg_advance<T0>(arg0: &mut Ticket, arg1: vector<u8>, arg2: u64) {
        arg0.legs = arg0.legs + 1;
        if (arg0.legs == 1) {
            arg0.venue1 = arg1;
        } else {
            arg0.venue2 = arg1;
        };
        arg0.cur_type = 0x1::type_name::with_defining_ids<T0>();
        arg0.cur_value = arg2;
    }

    public(friend) fun leg_check<T0>(arg0: &Ticket, arg1: &Config, arg2: vector<u8>, arg3: u64) {
        assert!(venue_enabled(arg1, &arg2), 7);
        assert!(arg0.legs < 2, 8);
        if (arg0.legs == 1) {
            assert!(!arg0.fee_on_input, 10);
            assert!(arg0.fee_done, 9);
        };
        assert!(0x1::type_name::with_defining_ids<T0>() == arg0.cur_type, 11);
        assert!(arg3 == arg0.cur_value, 12);
    }

    public fun owner(arg0: &Config) : address {
        arg0.owner
    }

    public fun pause(arg0: &mut Config, arg1: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg1);
        arg0.paused = true;
        let v0 = PausedEvent{by: 0x2::tx_context::sender(arg1)};
        0x2::event::emit<PausedEvent>(v0);
    }

    public fun pending_owner(arg0: &Config) : address {
        arg0.pending_owner
    }

    public fun propose_solid<T0>(arg0: &mut Config, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg2);
        assert_not_frozen(arg0);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(v0 != 0x1::type_name::with_defining_ids<0x2::sui::SUI>(), 22);
        assert!(!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.solids, &v0), 23);
        let v1 = 0x2::clock::timestamp_ms(arg1) + 86400000;
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.solid_eta, &v0)) {
            *0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut arg0.solid_eta, &v0) = v1;
        } else {
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut arg0.solid_eta, v0, v1);
        };
        let v2 = SolidProposed{
            solid : v0,
            eta   : v1,
        };
        0x2::event::emit<SolidProposed>(v2);
    }

    public fun propose_venue(arg0: &mut Config, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg3);
        assert_not_frozen(arg0);
        assert!(known_venue(&arg1), 27);
        assert!(!venue_enabled(arg0, &arg1), 23);
        let v0 = 0x2::clock::timestamp_ms(arg2) + 86400000;
        if (0x2::vec_map::contains<vector<u8>, u64>(&arg0.venue_eta, &arg1)) {
            *0x2::vec_map::get_mut<vector<u8>, u64>(&mut arg0.venue_eta, &arg1) = v0;
        } else {
            0x2::vec_map::insert<vector<u8>, u64>(&mut arg0.venue_eta, arg1, v0);
        };
        let v1 = VenueProposed{
            name : arg1,
            eta  : v0,
        };
        0x2::event::emit<VenueProposed>(v1);
    }

    public fun remove_solid<T0>(arg0: &mut Config, arg1: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg1);
        assert_not_frozen(arg0);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.solid_eta, &v0)) {
            let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, u64>(&mut arg0.solid_eta, &v0);
        };
        if (0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.solids, &v0)) {
            0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.solids, &v0);
        };
        let v3 = SolidRemoved{solid: v0};
        0x2::event::emit<SolidRemoved>(v3);
    }

    public fun remove_venue(arg0: &mut Config, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg2);
        assert_not_frozen(arg0);
        if (0x2::vec_map::contains<vector<u8>, u64>(&arg0.venue_eta, &arg1)) {
            let (_, _) = 0x2::vec_map::remove<vector<u8>, u64>(&mut arg0.venue_eta, &arg1);
        };
        if (0x2::vec_map::contains<vector<u8>, bool>(&arg0.venues, &arg1)) {
            *0x2::vec_map::get_mut<vector<u8>, bool>(&mut arg0.venues, &arg1) = false;
        };
        let v2 = VenueRemoved{name: arg1};
        0x2::event::emit<VenueRemoved>(v2);
    }

    public fun seed_solid<T0>(arg0: &mut Config, arg1: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg1);
        assert!(!arg0.activated, 28);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(v0 != 0x1::type_name::with_defining_ids<0x2::sui::SUI>(), 22);
        assert!(!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.solids, &v0), 23);
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.solids, v0);
    }

    public fun set_fee(arg0: &mut Config, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg2);
        assert_not_frozen(arg0);
        assert!(arg1 >= 0 && arg1 <= 100, 21);
        arg0.fee_bps = arg1;
        let v0 = FeeChanged{bps: arg1};
        0x2::event::emit<FeeChanged>(v0);
    }

    public fun take_mid_fee<T0>(arg0: Ticket, arg1: &Config, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) : (Ticket, 0x2::coin::Coin<T0>) {
        assert!(arg0.legs == 1, 13);
        assert!(!arg0.fee_done, 14);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(v0 == arg0.cur_type, 11);
        assert!(0x2::coin::value<T0>(&arg2) == arg0.cur_value, 12);
        assert!(v0 != arg0.in_type, 16);
        assert!(is_solid_or_sui<T0>(arg1), 5);
        let v1 = 0x2::coin::value<T0>(&arg2);
        assert!(v1 != 0, 15);
        let v2 = bps_of(v1, arg1.fee_bps);
        let v3 = v1 - v2;
        assert!(v3 != 0, 15);
        if (v2 != 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg2, v2, arg3), @0x31144765db2bb7a2c275fcf86e300b4062457daa113901e27a3264d6afd47c56);
        };
        arg0.fee_done = true;
        arg0.fee_amount = v2;
        arg0.mid_type = 0x1::option::some<0x1::type_name::TypeName>(v0);
        arg0.cur_value = v3;
        (arg0, arg2)
    }

    public(friend) fun ticket_sender(arg0: &Ticket) : address {
        arg0.sender
    }

    public fun transfer_ownership(arg0: &mut Config, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg2);
        assert_not_frozen(arg0);
        assert!(arg1 != @0x0, 26);
        arg0.pending_owner = arg1;
        let v0 = OwnershipTransferStarted{
            from : arg0.owner,
            to   : arg1,
        };
        0x2::event::emit<OwnershipTransferStarted>(v0);
    }

    public fun unpause(arg0: &mut Config, arg1: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg1);
        arg0.paused = false;
        let v0 = UnpausedEvent{by: 0x2::tx_context::sender(arg1)};
        0x2::event::emit<UnpausedEvent>(v0);
    }

    fun venue_enabled(arg0: &Config, arg1: &vector<u8>) : bool {
        0x2::vec_map::contains<vector<u8>, bool>(&arg0.venues, arg1) && *0x2::vec_map::get<vector<u8>, bool>(&arg0.venues, arg1)
    }

    // decompiled from Move bytecode v7
}

