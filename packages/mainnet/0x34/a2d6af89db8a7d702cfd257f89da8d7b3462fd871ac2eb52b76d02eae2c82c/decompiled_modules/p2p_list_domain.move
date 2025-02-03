module 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::p2p_list_domain {
    struct P2PListDomain has store {
        lists: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    public fun empty() : P2PListDomain {
        P2PListDomain{lists: 0x2::vec_set::empty<0x2::object::ID>()}
    }

    public fun add_domain(arg0: &mut 0x2::object::UID, arg1: P2PListDomain) {
        assert_no_transfer_allowlist(arg0);
        0x2::dynamic_field::add<0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::Marker<P2PListDomain>, P2PListDomain>(arg0, 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::marker<P2PListDomain>(), arg1);
    }

    public fun add_id<T0>(arg0: 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::Witness<T0>, arg1: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<T0>, arg2: &0x228b48911fdc05f8d80ac4334cd734d38dd7db74a0f4e423cb91f736f429ebe4::authlist::Authlist) {
        let v0 = 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::borrow_uid_mut<T0>(arg0, arg1);
        0x2::vec_set::insert<0x2::object::ID>(&mut borrow_domain_mut(v0).lists, 0x2::object::id<0x228b48911fdc05f8d80ac4334cd734d38dd7db74a0f4e423cb91f736f429ebe4::authlist::Authlist>(arg2));
    }

    public fun assert_no_transfer_allowlist(arg0: &0x2::object::UID) {
        assert!(!has_domain(arg0), 1);
    }

    public fun assert_transfer_allowlist(arg0: &0x2::object::UID) {
        assert!(has_domain(arg0), 1);
    }

    public fun borrow_allowlists(arg0: &P2PListDomain) : &0x2::vec_set::VecSet<0x2::object::ID> {
        &arg0.lists
    }

    public fun borrow_domain(arg0: &0x2::object::UID) : &P2PListDomain {
        assert_transfer_allowlist(arg0);
        0x2::dynamic_field::borrow<0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::Marker<P2PListDomain>, P2PListDomain>(arg0, 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::marker<P2PListDomain>())
    }

    public fun borrow_domain_mut(arg0: &mut 0x2::object::UID) : &mut P2PListDomain {
        assert_transfer_allowlist(arg0);
        0x2::dynamic_field::borrow_mut<0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::Marker<P2PListDomain>, P2PListDomain>(arg0, 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::marker<P2PListDomain>())
    }

    public fun delete(arg0: P2PListDomain) {
        let P2PListDomain {  } = arg0;
    }

    public fun from_id(arg0: 0x2::object::ID) : P2PListDomain {
        P2PListDomain{lists: 0x2::vec_set::singleton<0x2::object::ID>(arg0)}
    }

    public fun has_domain(arg0: &0x2::object::UID) : bool {
        0x2::dynamic_field::exists_with_type<0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::Marker<P2PListDomain>, P2PListDomain>(arg0, 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::marker<P2PListDomain>())
    }

    public fun remove_domain(arg0: &mut 0x2::object::UID) : P2PListDomain {
        assert_transfer_allowlist(arg0);
        0x2::dynamic_field::remove<0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::Marker<P2PListDomain>, P2PListDomain>(arg0, 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::marker<P2PListDomain>())
    }

    public fun remove_id<T0>(arg0: 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::Witness<T0>, arg1: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<T0>, arg2: 0x2::object::ID) {
        let v0 = 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::borrow_uid_mut<T0>(arg0, arg1);
        0x2::vec_set::remove<0x2::object::ID>(&mut borrow_domain_mut(v0).lists, &arg2);
    }

    // decompiled from Move bytecode v6
}

