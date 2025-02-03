module 0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::ticket_issuer_policy {
    struct TicketIssuerPolicy has key {
        id: 0x2::object::UID,
        witness_types: 0x2::table::Table<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>,
    }

    public(friend) fun add_witness_type<T0, T1: drop>(arg0: &mut TicketIssuerPolicy) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.witness_types, v0)) {
            0x2::table::add<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut arg0.witness_types, v0, 0x2::vec_set::singleton<0x1::type_name::TypeName>(0x1::type_name::get<T1>()));
        } else {
            0x2::vec_set::insert<0x1::type_name::TypeName>(0x2::table::borrow_mut<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut arg0.witness_types, v0), 0x1::type_name::get<T1>());
        };
    }

    public fun is_witness_can_issue_ticket<T0, T1: drop>(arg0: &TicketIssuerPolicy, arg1: &T1) : bool {
        let v0 = 0x1::type_name::get<T1>();
        0x2::vec_set::contains<0x1::type_name::TypeName>(0x2::table::borrow<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.witness_types, 0x1::type_name::get<T0>()), &v0)
    }

    public(friend) fun remove_witness_type<T0, T1: drop>(arg0: &mut TicketIssuerPolicy) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        let v2 = 0x2::table::borrow_mut<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut arg0.witness_types, v0);
        0x2::vec_set::remove<0x1::type_name::TypeName>(v2, &v1);
        if (0x2::vec_set::is_empty<0x1::type_name::TypeName>(v2)) {
            0x2::table::remove<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut arg0.witness_types, v0);
        };
    }

    // decompiled from Move bytecode v6
}

