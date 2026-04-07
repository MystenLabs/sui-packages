module 0x7ee9b1ce9ed1122316bd9589befe8088ec6b31e14bfc00651fd3408d0e8eaac0::tvl {
    struct TvlRegistry has key {
        id: 0x2::object::UID,
        known_objects: 0x2::vec_map::VecMap<u8, address>,
        last_payload_timestamp_ms: 0x2::vec_map::VecMap<u8, u64>,
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

    struct CapacityUpdatedEvent has copy, drop {
        strategy_id: u8,
        cap_million: u64,
        fill_bps: u64,
        tvl: u64,
        timestamp_ms: u64,
    }

    public fun assert_capacity_sufficient(arg0: u64, arg1: u64) {
        assert!(arg0 >= arg1, 801);
    }

    fun cap_key(arg0: u8) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"cap_");
        let v1 = 0x1::vector::empty<u8>();
        let v2 = &mut v1;
        0x1::vector::push_back<u8>(v2, arg0 / 100 + 48);
        0x1::vector::push_back<u8>(v2, arg0 % 100 / 10 + 48);
        0x1::vector::push_back<u8>(v2, arg0 % 10 + 48);
        0x1::string::append_utf8(&mut v0, v1);
        v0
    }

    public fun create_registry(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TvlRegistry{
            id                        : 0x2::object::new(arg0),
            known_objects             : 0x2::vec_map::empty<u8, address>(),
            last_payload_timestamp_ms : 0x2::vec_map::empty<u8, u64>(),
        };
        0x2::transfer::share_object<TvlRegistry>(v0);
    }

    fun fill_key(arg0: u8) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"fill_");
        let v1 = 0x1::vector::empty<u8>();
        let v2 = &mut v1;
        0x1::vector::push_back<u8>(v2, arg0 / 100 + 48);
        0x1::vector::push_back<u8>(v2, arg0 % 100 / 10 + 48);
        0x1::vector::push_back<u8>(v2, arg0 % 10 + 48);
        0x1::string::append_utf8(&mut v0, v1);
        v0
    }

    public fun get_cap_million(arg0: &TvlRegistry, arg1: u8) : u64 {
        let v0 = cap_key(arg1);
        if (!0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, v0)) {
            return 0
        };
        *0x2::dynamic_field::borrow<0x1::string::String, u64>(&arg0.id, v0)
    }

    public fun get_fill_bps(arg0: &TvlRegistry, arg1: u8) : u64 {
        let v0 = fill_key(arg1);
        if (!0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, v0)) {
            return 0
        };
        *0x2::dynamic_field::borrow<0x1::string::String, u64>(&arg0.id, v0)
    }

    public fun get_protocol_object_id(arg0: &TvlRegistry, arg1: u8) : address {
        assert!(0x2::vec_map::contains<u8, address>(&arg0.known_objects, &arg1), 803);
        *0x2::vec_map::get<u8, address>(&arg0.known_objects, &arg1)
    }

    public fun guard_reroute_trustless(arg0: &TvlRegistry, arg1: u8, arg2: u64, arg3: address, arg4: &0x2::clock::Clock) {
        assert!(0x2::vec_map::contains<u8, address>(&arg0.known_objects, &arg1), 803);
        assert!(arg3 == *0x2::vec_map::get<u8, address>(&arg0.known_objects, &arg1), 802);
        assert!(arg2 >= 1000000000000, 800);
        0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::floors::assert_min_tvl(arg2);
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
        0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::floors::assert_min_tvl(arg2);
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

    public fun push_capacity(arg0: &mut TvlRegistry, arg1: u8, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) {
        let v0 = cap_key(arg1);
        let v1 = fill_key(arg1);
        if (0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow_mut<0x1::string::String, u64>(&mut arg0.id, v0) = arg2;
        } else {
            0x2::dynamic_field::add<0x1::string::String, u64>(&mut arg0.id, v0, arg2);
        };
        if (0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, v1)) {
            *0x2::dynamic_field::borrow_mut<0x1::string::String, u64>(&mut arg0.id, v1) = arg3;
        } else {
            0x2::dynamic_field::add<0x1::string::String, u64>(&mut arg0.id, v1, arg3);
        };
        let v2 = CapacityUpdatedEvent{
            strategy_id  : arg1,
            cap_million  : arg2,
            fill_bps     : arg3,
            tvl          : arg4,
            timestamp_ms : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<CapacityUpdatedEvent>(v2);
    }

    public fun push_capacity_from_enclave(arg0: &mut TvlRegistry, arg1: &0x7ee9b1ce9ed1122316bd9589befe8088ec6b31e14bfc00651fd3408d0e8eaac0::crank::CrankConfig, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::clock::Clock) {
        assert!(0x2::ed25519::ed25519_verify(&arg3, 0x7ee9b1ce9ed1122316bd9589befe8088ec6b31e14bfc00651fd3408d0e8eaac0::crank::tee_public_key(arg1), &arg2), 805);
        let v0 = 0x2::bcs::new(arg2);
        let v1 = 0x2::bcs::peel_u8(&mut v0);
        0x2::bcs::peel_u64(&mut v0);
        0x2::bcs::peel_u64(&mut v0);
        let v2 = 0x2::bcs::peel_u64(&mut v0);
        let v3 = 0x2::clock::timestamp_ms(arg4);
        assert!(v3 >= v2 && v3 - v2 <= 300000, 804);
        if (0x2::vec_map::contains<u8, u64>(&arg0.last_payload_timestamp_ms, &v1)) {
            assert!(v2 > *0x2::vec_map::get<u8, u64>(&arg0.last_payload_timestamp_ms, &v1), 804);
            *0x2::vec_map::get_mut<u8, u64>(&mut arg0.last_payload_timestamp_ms, &v1) = v2;
        } else {
            0x2::vec_map::insert<u8, u64>(&mut arg0.last_payload_timestamp_ms, v1, v2);
        };
        push_capacity(arg0, v1, 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0), arg4);
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

