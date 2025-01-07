module 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::partners {
    struct PartnerList has store, key {
        id: 0x2::object::UID,
        partners: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    public fun contains<T0>(arg0: &PartnerList) : bool {
        let v0 = 0x1::type_name::get<T0>();
        0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.partners, &v0)
    }

    public fun add_partner<T0>(arg0: &0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::unihouse::AdminCap, arg1: &mut PartnerList) {
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg1.partners, 0x1::type_name::get<T0>());
    }

    public fun create_partner_list(arg0: &0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::unihouse::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = PartnerList{
            id       : 0x2::object::new(arg1),
            partners : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        };
        0x2::transfer::share_object<PartnerList>(v0);
    }

    public fun remove_partner<T0>(arg0: &0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::unihouse::AdminCap, arg1: &mut PartnerList) {
        let v0 = 0x1::type_name::get<T0>();
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg1.partners, &v0);
    }

    // decompiled from Move bytecode v6
}

