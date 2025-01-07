module 0x324b03d6d2e30ac7e1675865bc54bceb68926eb11d433ece526fe774220087f9::x_supply {
    struct XSupply<phantom T0> has store {
        supply: 0x2::balance::Supply<T0>,
        issuers: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    struct XSupplyCap<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    public fun decrease_supply<T0: drop, T1: drop>(arg0: T1, arg1: &mut XSupply<T0>, arg2: 0x2::balance::Balance<T0>) : u64 {
        assert!(is_authorized_issuer<T0, T1>(arg0, arg1), 403);
        0x2::balance::decrease_supply<T0>(&mut arg1.supply, arg2)
    }

    public fun increase_supply<T0: drop, T1: drop>(arg0: T1, arg1: &mut XSupply<T0>, arg2: u64) : 0x2::balance::Balance<T0> {
        assert!(is_authorized_issuer<T0, T1>(arg0, arg1), 403);
        0x2::balance::increase_supply<T0>(&mut arg1.supply, arg2)
    }

    public fun supply_value<T0: drop>(arg0: &XSupply<T0>) : u64 {
        0x2::balance::supply_value<T0>(&arg0.supply)
    }

    public fun add_issuer<T0: drop, T1: drop>(arg0: &XSupplyCap<T0>, arg1: &mut XSupply<T0>) {
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg1.issuers, 0x1::type_name::get<T1>());
    }

    public fun create_x_supply<T0: drop>(arg0: 0x2::balance::Supply<T0>, arg1: &mut 0x2::tx_context::TxContext) : (XSupply<T0>, XSupplyCap<T0>) {
        let v0 = XSupply<T0>{
            supply  : arg0,
            issuers : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        };
        let v1 = XSupplyCap<T0>{id: 0x2::object::new(arg1)};
        (v0, v1)
    }

    public fun is_authorized_issuer<T0: drop, T1: drop>(arg0: T1, arg1: &mut XSupply<T0>) : bool {
        let v0 = 0x1::type_name::get<T1>();
        0x2::vec_set::contains<0x1::type_name::TypeName>(&arg1.issuers, &v0)
    }

    public fun remove_issuer<T0: drop, T1: drop>(arg0: &XSupplyCap<T0>, arg1: &mut XSupply<T0>) {
        let v0 = 0x1::type_name::get<T1>();
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg1.issuers, &v0);
    }

    // decompiled from Move bytecode v6
}

