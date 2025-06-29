module 0xfd0e50a4fdd706442f403b7328ed01551fd0371c502d4238a753df74a3947776::oracle_price_policy {
    struct OraclePricePolicy has store, key {
        id: 0x2::object::UID,
        primary: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        secondary: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : OraclePricePolicy {
        OraclePricePolicy{
            id        : 0x2::object::new(arg0),
            primary   : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            secondary : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        }
    }

    public(friend) fun add_primary_provider<T0: drop>(arg0: &mut OraclePricePolicy) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.primary, &v0), 0);
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.primary, v0);
    }

    public(friend) fun add_secondary_provider<T0: drop>(arg0: &mut OraclePricePolicy) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.secondary, &v0), 0);
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.secondary, v0);
    }

    public(friend) fun is_primary_provider<T0: drop>(arg0: &OraclePricePolicy) : bool {
        let v0 = 0x1::type_name::get<T0>();
        0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.primary, &v0)
    }

    public(friend) fun is_secondary_provider<T0: drop>(arg0: &OraclePricePolicy) : bool {
        let v0 = 0x1::type_name::get<T0>();
        0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.secondary, &v0)
    }

    public(friend) fun primary_providers(arg0: &OraclePricePolicy) : 0x2::vec_set::VecSet<0x1::type_name::TypeName> {
        arg0.primary
    }

    public(friend) fun remove_primary_provider<T0: drop>(arg0: &mut OraclePricePolicy) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.primary, &v0), 1);
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.primary, &v0);
    }

    public(friend) fun remove_secondary_provider<T0: drop>(arg0: &mut OraclePricePolicy) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.secondary, &v0), 2);
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.secondary, &v0);
    }

    public(friend) fun secondary_providers(arg0: &OraclePricePolicy) : 0x2::vec_set::VecSet<0x1::type_name::TypeName> {
        arg0.secondary
    }

    // decompiled from Move bytecode v6
}

