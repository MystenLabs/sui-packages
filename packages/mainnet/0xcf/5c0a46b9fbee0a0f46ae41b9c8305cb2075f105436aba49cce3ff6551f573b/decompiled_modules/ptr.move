module 0xcf5c0a46b9fbee0a0f46ae41b9c8305cb2075f105436aba49cce3ff6551f573b::ptr {
    struct ProtocolLiquidity has copy, drop {
        available: 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::Fixed18,
        apr: 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::Fixed18,
        type_name: 0x1::type_name::TypeName,
    }

    struct ProtocolPoint has copy, drop, store {
        apr: 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::Fixed18,
        depth: 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::Fixed18,
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
        0x2::vec_set::length<0x1::type_name::TypeName>(&arg0.protocols)
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : ProtocolRegistry {
        ProtocolRegistry{
            id        : 0x2::object::new(arg0),
            protocols : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        }
    }

    public(friend) fun contains<T0>(arg0: &ProtocolRegistry) : bool {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.protocols, &v0)
    }

    public(friend) fun remove<T0>(arg0: &mut ProtocolRegistry) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.protocols, &v0);
    }

    public(friend) fun add<T0>(arg0: &mut ProtocolRegistry) {
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.protocols, 0x1::type_name::with_defining_ids<T0>());
    }

    public(friend) fun approve_request<T0, T1: drop>(arg0: &ProtocolRegistry, arg1: &mut ProtocolRequest<T0>, arg2: T1, arg3: 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::Fixed18, arg4: 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::Fixed18, arg5: 0x2::balance::Balance<T0>) {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.protocols, &v0), 6);
        let v1 = ProtocolLiquidity{
            available : arg3,
            apr       : arg4,
            type_name : 0x1::type_name::with_defining_ids<T1>(),
        };
        0x2::vec_map::insert<0x1::type_name::TypeName, ProtocolLiquidity>(&mut arg1.approvals, 0x1::type_name::with_defining_ids<T1>(), v1);
        0x2::balance::join<T0>(&mut arg1.earnings, arg5);
    }

    public(friend) fun apr(arg0: &ProtocolLiquidity) : 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::Fixed18 {
        arg0.apr
    }

    public(friend) fun available_liquidity(arg0: &ProtocolLiquidity) : 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::Fixed18 {
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

    public(friend) fun new_point(arg0: 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::Fixed18, arg1: 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::Fixed18) : ProtocolPoint {
        ProtocolPoint{
            apr   : arg0,
            depth : arg1,
        }
    }

    public(friend) fun point_apr(arg0: &ProtocolPoint) : 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::Fixed18 {
        arg0.apr
    }

    public(friend) fun point_depth(arg0: &ProtocolPoint) : 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::Fixed18 {
        arg0.depth
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

    // decompiled from Move bytecode v7
}

