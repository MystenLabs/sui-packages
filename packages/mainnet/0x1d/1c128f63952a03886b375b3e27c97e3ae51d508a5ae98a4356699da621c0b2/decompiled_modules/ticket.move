module 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::ticket {
    struct AuthorizedTransferTicket {
        issued_to: 0x2::object::ID,
        issuer: 0x2::object::ID,
        keys: vector<vector<u8>>,
        assets: 0x2::bag::Bag,
    }

    public fun add_value<T0: store, T1: key, T2>(arg0: &mut AuthorizedTransferTicket, arg1: &T1, arg2: vector<u8>, arg3: T0, arg4: &T2) {
        assert!(0x2::object::id<T1>(arg1) == arg0.issued_to || 0x2::object::id<T1>(arg1) == arg0.issuer, 0);
        verify_adapter_access<T2>(arg0, arg4);
        0x2::bag::add<vector<u8>, T0>(&mut arg0.assets, arg2, arg3);
        if (!0x1::vector::contains<vector<u8>>(&arg0.keys, &arg2)) {
            0x1::vector::push_back<vector<u8>>(&mut arg0.keys, arg2);
        };
    }

    public(friend) fun add_value_internal<T0: store, T1: key>(arg0: &mut AuthorizedTransferTicket, arg1: &T1, arg2: vector<u8>, arg3: T0) {
        assert!(0x2::object::id<T1>(arg1) == arg0.issued_to || 0x2::object::id<T1>(arg1) == arg0.issuer, 0);
        0x2::bag::add<vector<u8>, T0>(&mut arg0.assets, arg2, arg3);
        if (!0x1::vector::contains<vector<u8>>(&arg0.keys, &arg2)) {
            0x1::vector::push_back<vector<u8>>(&mut arg0.keys, arg2);
        };
    }

    public fun borrow_value<T0: copy + drop + store, T1: store, T2: key, T3>(arg0: &AuthorizedTransferTicket, arg1: &T2, arg2: T0, arg3: &T3) : &T1 {
        assert!(0x2::object::id<T2>(arg1) == arg0.issued_to || 0x2::object::id<T2>(arg1) == arg0.issuer, 0);
        verify_adapter_access<T3>(arg0, arg3);
        0x2::bag::borrow<T0, T1>(&arg0.assets, arg2)
    }

    public(friend) fun borrow_value_internal<T0: copy + drop + store, T1: store, T2: key>(arg0: &AuthorizedTransferTicket, arg1: &T2, arg2: T0) : &T1 {
        assert!(0x2::object::id<T2>(arg1) == arg0.issued_to || 0x2::object::id<T2>(arg1) == arg0.issuer, 0);
        0x2::bag::borrow<T0, T1>(&arg0.assets, arg2)
    }

    public fun borrow_value_mut<T0: copy + drop + store, T1: store, T2: key, T3>(arg0: &mut AuthorizedTransferTicket, arg1: &T2, arg2: T0, arg3: &T3) : &mut T1 {
        assert!(0x2::object::id<T2>(arg1) == arg0.issued_to || 0x2::object::id<T2>(arg1) == arg0.issuer, 0);
        verify_adapter_access<T3>(arg0, arg3);
        0x2::bag::borrow_mut<T0, T1>(&mut arg0.assets, arg2)
    }

    public(friend) fun borrow_value_mut_internal<T0: copy + drop + store, T1: store, T2: key>(arg0: &mut AuthorizedTransferTicket, arg1: &T2, arg2: T0) : &mut T1 {
        assert!(0x2::object::id<T2>(arg1) == arg0.issued_to || 0x2::object::id<T2>(arg1) == arg0.issuer, 0);
        0x2::bag::borrow_mut<T0, T1>(&mut arg0.assets, arg2)
    }

    public fun burn(arg0: AuthorizedTransferTicket) {
        let AuthorizedTransferTicket {
            issued_to : _,
            issuer    : _,
            keys      : _,
            assets    : v3,
        } = arg0;
        0x2::bag::destroy_empty(v3);
    }

    public fun contains_asset<T0: copy + drop + store>(arg0: &AuthorizedTransferTicket, arg1: T0) : bool {
        0x2::bag::contains<T0>(&arg0.assets, arg1)
    }

    public fun get_keys(arg0: &AuthorizedTransferTicket) : &vector<vector<u8>> {
        &arg0.keys
    }

    public fun has_key(arg0: &AuthorizedTransferTicket, arg1: vector<u8>) : bool {
        0x1::vector::contains<vector<u8>>(&arg0.keys, &arg1)
    }

    public fun has_position(arg0: &AuthorizedTransferTicket) : bool {
        contains_asset<vector<u8>>(arg0, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::keys::position())
    }

    public fun has_position_changes(arg0: &AuthorizedTransferTicket) : bool {
        contains_asset<vector<u8>>(arg0, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::keys::position()) || contains_asset<vector<u8>>(arg0, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::keys::asset())
    }

    public fun has_rewards(arg0: &AuthorizedTransferTicket) : bool {
        contains_asset<vector<u8>>(arg0, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::keys::rewards())
    }

    public fun has_strategy_base_asset(arg0: &AuthorizedTransferTicket) : bool {
        contains_asset<vector<u8>>(arg0, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::keys::strategy_base_asset())
    }

    public fun issue(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : AuthorizedTransferTicket {
        AuthorizedTransferTicket{
            issued_to : arg0,
            issuer    : arg1,
            keys      : 0x1::vector::empty<vector<u8>>(),
            assets    : 0x2::bag::new(arg2),
        }
    }

    public fun remove_value<T0: store, T1: key, T2>(arg0: &mut AuthorizedTransferTicket, arg1: &T1, arg2: vector<u8>, arg3: &T2) : T0 {
        assert!(0x2::object::id<T1>(arg1) == arg0.issued_to || 0x2::object::id<T1>(arg1) == arg0.issuer, 0);
        verify_adapter_access<T2>(arg0, arg3);
        let (v0, v1) = 0x1::vector::index_of<vector<u8>>(&arg0.keys, &arg2);
        if (v0) {
            0x1::vector::remove<vector<u8>>(&mut arg0.keys, v1);
        };
        0x2::bag::remove<vector<u8>, T0>(&mut arg0.assets, arg2)
    }

    public(friend) fun remove_value_internal<T0: store, T1: key>(arg0: &mut AuthorizedTransferTicket, arg1: &T1, arg2: vector<u8>) : T0 {
        assert!(0x2::object::id<T1>(arg1) == arg0.issued_to || 0x2::object::id<T1>(arg1) == arg0.issuer, 0);
        let (v0, v1) = 0x1::vector::index_of<vector<u8>>(&arg0.keys, &arg2);
        if (v0) {
            0x1::vector::remove<vector<u8>>(&mut arg0.keys, v1);
        };
        0x2::bag::remove<vector<u8>, T0>(&mut arg0.assets, arg2)
    }

    public fun verify_adapter_access<T0>(arg0: &AuthorizedTransferTicket, arg1: &T0) {
        assert!(contains_asset<vector<u8>>(arg0, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::keys::rules()), 1);
        let v0 = 0x2::bag::borrow<vector<u8>, vector<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::Rule>>(&arg0.assets, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::keys::rules());
        let v1 = false;
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::Rule>(v0) && !v1) {
            if (0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::is_adapter_type_allowed(0x1::vector::borrow<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::Rule>(v0, v2), 0x1::type_name::get<T0>())) {
                v1 = true;
            };
            v2 = v2 + 1;
        };
        assert!(v1, 1);
    }

    // decompiled from Move bytecode v6
}

