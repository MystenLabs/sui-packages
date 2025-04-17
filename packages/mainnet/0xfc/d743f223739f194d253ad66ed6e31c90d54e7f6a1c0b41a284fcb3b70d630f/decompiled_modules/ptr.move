module 0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::ptr {
    struct ProtocolLiquidity has copy, drop {
        available: 0x911fd84fd98ed5c8c32cfc25f08f1493e532e4a4ba7d126290de00db75aa494f::fixed18::Fixed18,
        apr: 0x911fd84fd98ed5c8c32cfc25f08f1493e532e4a4ba7d126290de00db75aa494f::fixed18::Fixed18,
        type_name: 0x1::type_name::TypeName,
    }

    struct ProtocolRequest<phantom T0> {
        approvals: 0x2::vec_map::VecMap<0x1::type_name::TypeName, ProtocolLiquidity>,
        earnings: 0x2::balance::Balance<T0>,
    }

    struct ProtocolRegistry has store, key {
        id: 0x2::object::UID,
        protocols: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    public(friend) fun length(arg0: &ProtocolRegistry) : u64 {
        0x2::vec_set::size<0x1::type_name::TypeName>(&arg0.protocols)
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : ProtocolRegistry {
        ProtocolRegistry{
            id        : 0x2::object::new(arg0),
            protocols : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        }
    }

    public(friend) fun contains<T0>(arg0: &ProtocolRegistry) : bool {
        let v0 = 0x1::type_name::get<T0>();
        0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.protocols, &v0)
    }

    public(friend) fun remove<T0>(arg0: &mut ProtocolRegistry) {
        let v0 = 0x1::type_name::get<T0>();
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.protocols, &v0);
    }

    public(friend) fun add<T0>(arg0: &mut ProtocolRegistry) {
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.protocols, 0x1::type_name::get<T0>());
    }

    public(friend) fun approve_request<T0, T1: drop>(arg0: &ProtocolRegistry, arg1: &mut ProtocolRequest<T0>, arg2: T1, arg3: 0x911fd84fd98ed5c8c32cfc25f08f1493e532e4a4ba7d126290de00db75aa494f::fixed18::Fixed18, arg4: 0x911fd84fd98ed5c8c32cfc25f08f1493e532e4a4ba7d126290de00db75aa494f::fixed18::Fixed18, arg5: 0x2::balance::Balance<T0>) {
        let v0 = 0x1::type_name::get<T1>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.protocols, &v0), 6);
        let v1 = ProtocolLiquidity{
            available : arg3,
            apr       : arg4,
            type_name : 0x1::type_name::get<T1>(),
        };
        0x2::vec_map::insert<0x1::type_name::TypeName, ProtocolLiquidity>(&mut arg1.approvals, 0x1::type_name::get<T1>(), v1);
        0x2::balance::join<T0>(&mut arg1.earnings, arg5);
    }

    public(friend) fun apr(arg0: &ProtocolLiquidity) : 0x911fd84fd98ed5c8c32cfc25f08f1493e532e4a4ba7d126290de00db75aa494f::fixed18::Fixed18 {
        arg0.apr
    }

    public(friend) fun available_liquidity(arg0: &ProtocolLiquidity) : 0x911fd84fd98ed5c8c32cfc25f08f1493e532e4a4ba7d126290de00db75aa494f::fixed18::Fixed18 {
        arg0.available
    }

    public(friend) fun consume<T0>(arg0: &ProtocolRegistry, arg1: ProtocolRequest<T0>) : (0x2::balance::Balance<T0>, vector<ProtocolLiquidity>) {
        let ProtocolRequest {
            approvals : v0,
            earnings  : v1,
        } = arg1;
        let v2 = v0;
        let v3 = 0x2::vec_map::keys<0x1::type_name::TypeName, ProtocolLiquidity>(&v2);
        assert!(&v3 == 0x2::vec_set::keys<0x1::type_name::TypeName>(&arg0.protocols), 6);
        let (_, v5) = 0x2::vec_map::into_keys_values<0x1::type_name::TypeName, ProtocolLiquidity>(v2);
        (v1, v5)
    }

    public(friend) fun contains_type_name(arg0: &ProtocolRegistry, arg1: 0x1::type_name::TypeName) : bool {
        0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.protocols, &arg1)
    }

    public(friend) fun get_all_type_names(arg0: &ProtocolRegistry) : vector<0x1::type_name::TypeName> {
        *0x2::vec_set::keys<0x1::type_name::TypeName>(&arg0.protocols)
    }

    public(friend) fun request<T0>() : ProtocolRequest<T0> {
        ProtocolRequest<T0>{
            approvals : 0x2::vec_map::empty<0x1::type_name::TypeName, ProtocolLiquidity>(),
            earnings  : 0x2::balance::zero<T0>(),
        }
    }

    public(friend) fun witness_type_name(arg0: &ProtocolLiquidity) : 0x1::type_name::TypeName {
        arg0.type_name
    }

    // decompiled from Move bytecode v6
}

