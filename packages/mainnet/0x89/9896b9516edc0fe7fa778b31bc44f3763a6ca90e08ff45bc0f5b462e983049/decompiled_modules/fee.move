module 0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::fee {
    struct PairFeeKey has copy, drop, store {
        pair_id: 0x1::string::String,
    }

    struct ProtocolDefaultFeeSetEvent has copy, drop {
        fee_bps: u16,
    }

    struct PairFeeSetEvent has copy, drop {
        pair_id: 0x1::string::String,
        fee_bps: u16,
    }

    struct PairFeeRemovedEvent has copy, drop {
        pair_id: 0x1::string::String,
    }

    struct MmFeeOverrideSetEvent has copy, drop {
        mm_id: 0x2::object::ID,
        fee_bps: 0x1::option::Option<u16>,
    }

    public(friend) fun assert_fee_bps_valid(arg0: u16) {
        assert!(arg0 <= 100, 1);
    }

    fun bytes_le(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(arg0);
        let v1 = 0x1::vector::length<u8>(arg1);
        let v2 = if (v0 < v1) {
            v0
        } else {
            v1
        };
        let v3 = 0;
        while (v3 < v2) {
            let v4 = *0x1::vector::borrow<u8>(arg0, v3);
            let v5 = *0x1::vector::borrow<u8>(arg1, v3);
            if (v4 != v5) {
                return v4 < v5
            };
            v3 = v3 + 1;
        };
        v0 <= v1
    }

    public fun compute_fee(arg0: u64, arg1: u16) : u64 {
        if (arg1 == 0) {
            return 0
        };
        (((arg0 as u128) * (arg1 as u128) / (10000 as u128)) as u64)
    }

    public fun compute_pair_id<T0, T1>() : 0x1::string::String {
        let v0 = 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        let v1 = 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T1>()));
        assert!(v0 != v1, 2);
        let (v2, v3) = if (bytes_le(&v0, &v1)) {
            (v0, v1)
        } else {
            (v1, v0)
        };
        let v4 = v2;
        0x1::vector::append<u8>(&mut v4, b"|");
        0x1::vector::append<u8>(&mut v4, v3);
        0x1::string::utf8(v4)
    }

    public fun hard_max_fee_bps() : u16 {
        100
    }

    public fun remove_pair_fee<T0, T1>(arg0: &0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::versioned::Versioned, arg1: &mut 0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::config::GlobalConfig, arg2: &0x2::tx_context::TxContext) {
        0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::versioned::check_version(arg0);
        0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::config::assert_fee_manager(arg1, 0x2::tx_context::sender(arg2));
        let v0 = compute_pair_id<T0, T1>();
        let v1 = PairFeeKey{pair_id: v0};
        if (0x2::dynamic_field::exists_<PairFeeKey>(0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::config::uid(arg1), v1)) {
            0x2::dynamic_field::remove<PairFeeKey, u16>(0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::config::uid_mut(arg1), v1);
        };
        let v2 = PairFeeRemovedEvent{pair_id: v0};
        0x2::event::emit<PairFeeRemovedEvent>(v2);
    }

    public(friend) fun resolve_fee_bps(arg0: &0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::config::GlobalConfig, arg1: &0x1::option::Option<u16>, arg2: &0x1::option::Option<u16>, arg3: &0x1::string::String) : u16 {
        if (0x1::option::is_some<u16>(arg2)) {
            return *0x1::option::borrow<u16>(arg2)
        };
        if (0x1::option::is_some<u16>(arg1)) {
            return *0x1::option::borrow<u16>(arg1)
        };
        let v0 = PairFeeKey{pair_id: *arg3};
        if (0x2::dynamic_field::exists_<PairFeeKey>(0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::config::uid(arg0), v0)) {
            return *0x2::dynamic_field::borrow<PairFeeKey, u16>(0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::config::uid(arg0), v0)
        };
        0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::config::default_fee_bps(arg0)
    }

    public fun set_mm_fee_override(arg0: &0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::versioned::Versioned, arg1: &0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::config::GlobalConfig, arg2: &mut 0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::market_maker::MarketMaker, arg3: 0x1::option::Option<u16>, arg4: &0x2::tx_context::TxContext) {
        0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::versioned::check_version(arg0);
        0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::config::assert_fee_manager(arg1, 0x2::tx_context::sender(arg4));
        if (0x1::option::is_some<u16>(&arg3)) {
            assert_fee_bps_valid(*0x1::option::borrow<u16>(&arg3));
        };
        0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::market_maker::set_fee_override(arg2, arg3);
        let v0 = MmFeeOverrideSetEvent{
            mm_id   : 0x2::object::id<0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::market_maker::MarketMaker>(arg2),
            fee_bps : arg3,
        };
        0x2::event::emit<MmFeeOverrideSetEvent>(v0);
    }

    public fun set_pair_fee<T0, T1>(arg0: &0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::versioned::Versioned, arg1: &mut 0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::config::GlobalConfig, arg2: u16, arg3: &0x2::tx_context::TxContext) {
        0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::versioned::check_version(arg0);
        0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::config::assert_fee_manager(arg1, 0x2::tx_context::sender(arg3));
        assert_fee_bps_valid(arg2);
        let v0 = compute_pair_id<T0, T1>();
        let v1 = PairFeeKey{pair_id: v0};
        if (0x2::dynamic_field::exists_<PairFeeKey>(0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::config::uid(arg1), v1)) {
            *0x2::dynamic_field::borrow_mut<PairFeeKey, u16>(0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::config::uid_mut(arg1), v1) = arg2;
        } else {
            0x2::dynamic_field::add<PairFeeKey, u16>(0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::config::uid_mut(arg1), v1, arg2);
        };
        let v2 = PairFeeSetEvent{
            pair_id : v0,
            fee_bps : arg2,
        };
        0x2::event::emit<PairFeeSetEvent>(v2);
    }

    public fun set_protocol_default_fee(arg0: &0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::versioned::Versioned, arg1: &mut 0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::config::GlobalConfig, arg2: u16, arg3: &0x2::tx_context::TxContext) {
        0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::versioned::check_version(arg0);
        0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::config::assert_fee_manager(arg1, 0x2::tx_context::sender(arg3));
        assert_fee_bps_valid(arg2);
        0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::config::set_default_fee_bps(arg1, arg2);
        let v0 = ProtocolDefaultFeeSetEvent{fee_bps: arg2};
        0x2::event::emit<ProtocolDefaultFeeSetEvent>(v0);
    }

    // decompiled from Move bytecode v7
}

