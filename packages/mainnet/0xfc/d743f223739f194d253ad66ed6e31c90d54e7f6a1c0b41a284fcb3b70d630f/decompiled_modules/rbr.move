module 0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::rbr {
    struct RebalanceRequest<phantom T0> {
        amount: u64,
        from_witness: 0x1::option::Option<0x1::type_name::TypeName>,
        from_balance: 0x2::balance::Balance<T0>,
        to_witness: 0x1::option::Option<0x1::type_name::TypeName>,
    }

    public fun amount<T0>(arg0: &RebalanceRequest<T0>) : u64 {
        arg0.amount
    }

    public(friend) fun consume<T0, T1: drop>(arg0: RebalanceRequest<T0>, arg1: T1) : 0x2::balance::Balance<T0> {
        let RebalanceRequest {
            amount       : _,
            from_witness : _,
            from_balance : v2,
            to_witness   : v3,
        } = arg0;
        let v4 = v3;
        assert!(0x1::option::extract<0x1::type_name::TypeName>(&mut v4) == 0x1::type_name::get<T1>(), 7);
        v2
    }

    public(friend) fun consume_idle<T0>(arg0: RebalanceRequest<T0>) : 0x2::balance::Balance<T0> {
        let RebalanceRequest {
            amount       : _,
            from_witness : _,
            from_balance : v2,
            to_witness   : v3,
        } = arg0;
        let v4 = v3;
        assert!(0x1::option::is_none<0x1::type_name::TypeName>(&v4), 7);
        v2
    }

    public(friend) fun fill<T0, T1: drop>(arg0: &mut RebalanceRequest<T0>, arg1: 0x2::balance::Balance<T0>, arg2: T1) {
        assert!(0x2::balance::value<T0>(&arg0.from_balance) + 0x2::balance::value<T0>(&arg1) <= arg0.amount, 8);
        assert!(0x1::option::extract<0x1::type_name::TypeName>(&mut arg0.from_witness) == 0x1::type_name::get<T1>(), 7);
        0x2::balance::join<T0>(&mut arg0.from_balance, arg1);
    }

    public(friend) fun fill_idle<T0>(arg0: &mut RebalanceRequest<T0>, arg1: 0x2::balance::Balance<T0>) {
        assert!(0x2::balance::value<T0>(&arg0.from_balance) + 0x2::balance::value<T0>(&arg1) <= arg0.amount, 8);
        assert!(0x1::option::is_none<0x1::type_name::TypeName>(&arg0.from_witness), 7);
        0x2::balance::join<T0>(&mut arg0.from_balance, arg1);
    }

    public fun from_witness<T0>(arg0: &RebalanceRequest<T0>) : 0x1::option::Option<0x1::type_name::TypeName> {
        arg0.from_witness
    }

    public(friend) fun new<T0>(arg0: u64, arg1: 0x1::option::Option<0x1::type_name::TypeName>, arg2: 0x1::option::Option<0x1::type_name::TypeName>) : RebalanceRequest<T0> {
        RebalanceRequest<T0>{
            amount       : arg0,
            from_witness : arg1,
            from_balance : 0x2::balance::zero<T0>(),
            to_witness   : arg2,
        }
    }

    public fun to_witness<T0>(arg0: &RebalanceRequest<T0>) : 0x1::option::Option<0x1::type_name::TypeName> {
        arg0.to_witness
    }

    // decompiled from Move bytecode v6
}

