module 0xb86b4a7fd1b8c0ee10a8ae201568e0b178f137c917a4cf36cf41aa6bd23a25a9::partners {
    struct PartnerList has store, key {
        id: 0x2::object::UID,
        partners: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    public fun contains<T0>(arg0: &PartnerList) : bool {
        let v0 = 0x1::type_name::get<T0>();
        0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.partners, &v0)
    }

    public fun add_partner<T0>(arg0: &0xb86b4a7fd1b8c0ee10a8ae201568e0b178f137c917a4cf36cf41aa6bd23a25a9::unihouse::AdminCap, arg1: &mut PartnerList) {
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg1.partners, 0x1::type_name::get<T0>());
    }

    public fun create_partner_list(arg0: &0xb86b4a7fd1b8c0ee10a8ae201568e0b178f137c917a4cf36cf41aa6bd23a25a9::unihouse::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = PartnerList{
            id       : 0x2::object::new(arg1),
            partners : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        };
        0x2::transfer::share_object<PartnerList>(v0);
    }

    public fun remove_partner<T0>(arg0: &0xb86b4a7fd1b8c0ee10a8ae201568e0b178f137c917a4cf36cf41aa6bd23a25a9::unihouse::AdminCap, arg1: &mut PartnerList) {
        let v0 = 0x1::type_name::get<T0>();
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg1.partners, &v0);
    }

    // decompiled from Move bytecode v6
}

