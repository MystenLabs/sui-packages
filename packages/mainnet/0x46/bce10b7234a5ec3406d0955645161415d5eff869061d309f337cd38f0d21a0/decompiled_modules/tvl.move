module 0x46bce10b7234a5ec3406d0955645161415d5eff869061d309f337cd38f0d21a0::tvl {
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

    public fun guard_reroute_verified(arg0: &TvlRegistry, arg1: u8, arg2: u64, arg3: address, arg4: &0x2::clock::Clock) {
        assert!(0x2::vec_map::contains<u8, address>(&arg0.known_objects, &arg1), 803);
        assert!(arg3 == *0x2::vec_map::get<u8, address>(&arg0.known_objects, &arg1), 802);
        assert!(arg2 >= 1000000000000, 800);
        0x14de5ce960a411ab210ea069c1c73f9cb86d69ff0773ee0fa5a3bd5e96f00b6b::floors::assert_min_tvl(arg2);
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

    public(friend) fun register_protocol_object(arg0: &mut TvlRegistry, arg1: &0x14de5ce960a411ab210ea069c1c73f9cb86d69ff0773ee0fa5a3bd5e96f00b6b::vault::AdminCap, arg2: u8, arg3: address) {
        if (0x2::vec_map::contains<u8, address>(&arg0.known_objects, &arg2)) {
            *0x2::vec_map::get_mut<u8, address>(&mut arg0.known_objects, &arg2) = arg3;
        } else {
            0x2::vec_map::insert<u8, address>(&mut arg0.known_objects, arg2, arg3);
        };
        let v0 = ProtocolObjectRegisteredEvent{
            strategy_id        : arg2,
            protocol_object_id : arg3,
        };
        0x2::event::emit<ProtocolObjectRegisteredEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

