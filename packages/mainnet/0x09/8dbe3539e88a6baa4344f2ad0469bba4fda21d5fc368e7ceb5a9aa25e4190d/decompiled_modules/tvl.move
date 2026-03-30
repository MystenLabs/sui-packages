module 0x173eda7aa1cf63f9686bd23e3406b1d28f5b32a62f07f97a075d19f290211585::tvl {
    struct TvlRegistry has key {
        id: 0x2::object::UID,
        known_objects: 0x2::vec_map::VecMap<u8, address>,
    }

    struct TvlGuardPassedEvent has copy, drop {
        strategy_id: u8,
        tvl: u64,
        protocol_object_id: address,
        timestamp_ms: u64,
    }

    struct ProtocolObjectRegisteredEvent has copy, drop {
        strategy_id: u8,
        protocol_object_id: address,
    }

    public fun assert_capacity_sufficient(arg0: u64, arg1: u64) {
        assert!(arg0 >= arg1, 801);
    }

    public fun create_registry(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TvlRegistry{
            id            : 0x2::object::new(arg0),
            known_objects : 0x2::vec_map::empty<u8, address>(),
        };
        0x2::transfer::share_object<TvlRegistry>(v0);
    }

    public fun get_protocol_object_id(arg0: &TvlRegistry, arg1: u8) : address {
        assert!(0x2::vec_map::contains<u8, address>(&arg0.known_objects, &arg1), 803);
        *0x2::vec_map::get<u8, address>(&arg0.known_objects, &arg1)
    }

    public fun guard_reroute_trustless(arg0: &TvlRegistry, arg1: u8, arg2: u64, arg3: address, arg4: &0x2::clock::Clock) {
        assert!(0x2::vec_map::contains<u8, address>(&arg0.known_objects, &arg1), 803);
        assert!(arg3 == *0x2::vec_map::get<u8, address>(&arg0.known_objects, &arg1), 802);
        assert!(arg2 >= 1000000000000, 800);
        0x6f8d1d25f7a66d967e92fed17d6a362055d3544b6218dc606c1cbc70bfc55f5f::floors::assert_min_tvl(arg2);
        let v0 = TvlGuardPassedEvent{
            strategy_id        : arg1,
            tvl                : arg2,
            protocol_object_id : arg3,
            timestamp_ms       : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<TvlGuardPassedEvent>(v0);
    }

    public fun guard_reroute_verified(arg0: &TvlRegistry, arg1: u8, arg2: u64, arg3: address, arg4: &0x2::clock::Clock) {
        assert!(0x2::vec_map::contains<u8, address>(&arg0.known_objects, &arg1), 803);
        assert!(arg3 == *0x2::vec_map::get<u8, address>(&arg0.known_objects, &arg1), 802);
        assert!(arg2 >= 1000000000000, 800);
        0x6f8d1d25f7a66d967e92fed17d6a362055d3544b6218dc606c1cbc70bfc55f5f::floors::assert_min_tvl(arg2);
        let v0 = TvlGuardPassedEvent{
            strategy_id        : arg1,
            tvl                : arg2,
            protocol_object_id : arg3,
            timestamp_ms       : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<TvlGuardPassedEvent>(v0);
    }

    public fun has_registered_object(arg0: &TvlRegistry, arg1: u8) : bool {
        0x2::vec_map::contains<u8, address>(&arg0.known_objects, &arg1)
    }

    public fun min_tvl_floor() : u64 {
        1000000000000
    }

    public(friend) fun register_protocol_object(arg0: &mut TvlRegistry, arg1: u8, arg2: address) {
        if (0x2::vec_map::contains<u8, address>(&arg0.known_objects, &arg1)) {
            *0x2::vec_map::get_mut<u8, address>(&mut arg0.known_objects, &arg1) = arg2;
        } else {
            0x2::vec_map::insert<u8, address>(&mut arg0.known_objects, arg1, arg2);
        };
        let v0 = ProtocolObjectRegisteredEvent{
            strategy_id        : arg1,
            protocol_object_id : arg2,
        };
        0x2::event::emit<ProtocolObjectRegisteredEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

