module 0x7016aae72cfc67f2fadf55769c0a7dd54291a583b63051a5ed71081cce836ac6::x_supply {
    struct XSupply<phantom T0> has store {
        supply: 0x2::balance::Supply<T0>,
        issuers: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        cap_id: 0x2::object::ID,
    }

    struct XSupplyCap<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    public fun decrease_supply<T0: drop, T1: drop>(arg0: T1, arg1: &mut XSupply<T0>, arg2: 0x2::balance::Balance<T0>) : u64 {
        assert!(is_authorized_issuer<T0, T1>(arg1), 403);
        0x2::balance::decrease_supply<T0>(&mut arg1.supply, arg2)
    }

    public fun increase_supply<T0: drop, T1: drop>(arg0: T1, arg1: &mut XSupply<T0>, arg2: u64) : 0x2::balance::Balance<T0> {
        assert!(is_authorized_issuer<T0, T1>(arg1), 403);
        0x2::balance::increase_supply<T0>(&mut arg1.supply, arg2)
    }

    public fun supply_value<T0: drop>(arg0: &XSupply<T0>) : u64 {
        0x2::balance::supply_value<T0>(&arg0.supply)
    }

    public fun add_issuer<T0: drop, T1: drop>(arg0: &XSupplyCap<T0>, arg1: &mut XSupply<T0>) {
        assert_supply_cap<T0>(arg0, arg1);
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg1.issuers, 0x1::type_name::get<T1>());
    }

    fun assert_supply_cap<T0: drop>(arg0: &XSupplyCap<T0>, arg1: &XSupply<T0>) {
        assert!(0x2::object::id<XSupplyCap<T0>>(arg0) == arg1.cap_id, 407);
    }

    public fun create_x_supply<T0: drop>(arg0: 0x2::balance::Supply<T0>, arg1: &mut 0x2::tx_context::TxContext) : (XSupply<T0>, XSupplyCap<T0>) {
        let v0 = XSupplyCap<T0>{id: 0x2::object::new(arg1)};
        let v1 = XSupply<T0>{
            supply  : arg0,
            issuers : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            cap_id  : 0x2::object::id<XSupplyCap<T0>>(&v0),
        };
        (v1, v0)
    }

    public fun decrease_supply_with_cap<T0: drop>(arg0: &XSupplyCap<T0>, arg1: &mut XSupply<T0>, arg2: 0x2::balance::Balance<T0>) : u64 {
        assert_supply_cap<T0>(arg0, arg1);
        0x2::balance::decrease_supply<T0>(&mut arg1.supply, arg2)
    }

    public fun increase_supply_with_cap<T0: drop>(arg0: &XSupplyCap<T0>, arg1: &mut XSupply<T0>, arg2: u64) : 0x2::balance::Balance<T0> {
        assert_supply_cap<T0>(arg0, arg1);
        0x2::balance::increase_supply<T0>(&mut arg1.supply, arg2)
    }

    public fun is_authorized_issuer<T0: drop, T1: drop>(arg0: &mut XSupply<T0>) : bool {
        let v0 = 0x1::type_name::get<T1>();
        0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.issuers, &v0)
    }

    public fun remove_issuer<T0: drop, T1: drop>(arg0: &XSupplyCap<T0>, arg1: &mut XSupply<T0>) {
        assert_supply_cap<T0>(arg0, arg1);
        let v0 = 0x1::type_name::get<T1>();
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg1.issuers, &v0);
    }

    // decompiled from Move bytecode v6
}

