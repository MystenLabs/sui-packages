module 0xb81a8531ebcc965130e03f9f8d17a9dcfb3f24982984dfc2fffe055254d1d88f::partners {
    struct PartnerList has store, key {
        id: 0x2::object::UID,
        partners: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    public fun contains<T0>(arg0: &PartnerList) : bool {
        let v0 = 0x1::type_name::get<T0>();
        0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.partners, &v0)
    }

    public fun add_partner<T0>(arg0: &0xb81a8531ebcc965130e03f9f8d17a9dcfb3f24982984dfc2fffe055254d1d88f::unihouse::AdminCap, arg1: &mut PartnerList) {
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg1.partners, 0x1::type_name::get<T0>());
    }

    public fun create_partner_list(arg0: &0xb81a8531ebcc965130e03f9f8d17a9dcfb3f24982984dfc2fffe055254d1d88f::unihouse::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = PartnerList{
            id       : 0x2::object::new(arg1),
            partners : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        };
        0x2::transfer::share_object<PartnerList>(v0);
    }

    public fun remove_partner<T0>(arg0: &0xb81a8531ebcc965130e03f9f8d17a9dcfb3f24982984dfc2fffe055254d1d88f::unihouse::AdminCap, arg1: &mut PartnerList) {
        let v0 = 0x1::type_name::get<T0>();
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg1.partners, &v0);
    }

    // decompiled from Move bytecode v6
}

