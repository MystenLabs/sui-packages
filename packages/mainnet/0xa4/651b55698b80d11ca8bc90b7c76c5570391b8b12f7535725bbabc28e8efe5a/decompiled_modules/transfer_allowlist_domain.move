module 0xa4651b55698b80d11ca8bc90b7c76c5570391b8b12f7535725bbabc28e8efe5a::transfer_allowlist_domain {
    struct TransferAllowlistDomain has store {
        allowlists: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    public fun empty() : TransferAllowlistDomain {
        TransferAllowlistDomain{allowlists: 0x2::vec_set::empty<0x2::object::ID>()}
    }

    public fun add_domain(arg0: &mut 0x2::object::UID, arg1: TransferAllowlistDomain) {
        assert_no_transfer_allowlist(arg0);
        0x2::dynamic_field::add<0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::Marker<TransferAllowlistDomain>, TransferAllowlistDomain>(arg0, 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::marker<TransferAllowlistDomain>(), arg1);
    }

    public fun add_id<T0>(arg0: 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::Witness<T0>, arg1: &mut 0xa4651b55698b80d11ca8bc90b7c76c5570391b8b12f7535725bbabc28e8efe5a::collection::Collection<T0>, arg2: &0x70e34fcd390b767edbddaf7573450528698188c84c5395af8c4b12e3e37622fa::allowlist::Allowlist) {
        let v0 = 0xa4651b55698b80d11ca8bc90b7c76c5570391b8b12f7535725bbabc28e8efe5a::collection::borrow_uid_mut<T0>(arg0, arg1);
        0x2::vec_set::insert<0x2::object::ID>(&mut borrow_domain_mut(v0).allowlists, 0x2::object::id<0x70e34fcd390b767edbddaf7573450528698188c84c5395af8c4b12e3e37622fa::allowlist::Allowlist>(arg2));
    }

    public fun assert_no_transfer_allowlist(arg0: &0x2::object::UID) {
        assert!(!has_domain(arg0), 1);
    }

    public fun assert_transfer_allowlist(arg0: &0x2::object::UID) {
        assert!(has_domain(arg0), 1);
    }

    public fun borrow_allowlists(arg0: &TransferAllowlistDomain) : &0x2::vec_set::VecSet<0x2::object::ID> {
        &arg0.allowlists
    }

    public fun borrow_domain(arg0: &0x2::object::UID) : &TransferAllowlistDomain {
        assert_transfer_allowlist(arg0);
        0x2::dynamic_field::borrow<0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::Marker<TransferAllowlistDomain>, TransferAllowlistDomain>(arg0, 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::marker<TransferAllowlistDomain>())
    }

    public fun borrow_domain_mut(arg0: &mut 0x2::object::UID) : &mut TransferAllowlistDomain {
        assert_transfer_allowlist(arg0);
        0x2::dynamic_field::borrow_mut<0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::Marker<TransferAllowlistDomain>, TransferAllowlistDomain>(arg0, 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::marker<TransferAllowlistDomain>())
    }

    public fun delete(arg0: TransferAllowlistDomain) {
        let TransferAllowlistDomain {  } = arg0;
    }

    public fun from_id(arg0: 0x2::object::ID) : TransferAllowlistDomain {
        TransferAllowlistDomain{allowlists: 0x2::vec_set::singleton<0x2::object::ID>(arg0)}
    }

    public fun has_domain(arg0: &0x2::object::UID) : bool {
        0x2::dynamic_field::exists_with_type<0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::Marker<TransferAllowlistDomain>, TransferAllowlistDomain>(arg0, 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::marker<TransferAllowlistDomain>())
    }

    public fun remove_domain(arg0: &mut 0x2::object::UID) : TransferAllowlistDomain {
        assert_transfer_allowlist(arg0);
        0x2::dynamic_field::remove<0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::Marker<TransferAllowlistDomain>, TransferAllowlistDomain>(arg0, 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::marker<TransferAllowlistDomain>())
    }

    public fun remove_id<T0>(arg0: 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::Witness<T0>, arg1: &mut 0xa4651b55698b80d11ca8bc90b7c76c5570391b8b12f7535725bbabc28e8efe5a::collection::Collection<T0>, arg2: 0x2::object::ID) {
        let v0 = 0xa4651b55698b80d11ca8bc90b7c76c5570391b8b12f7535725bbabc28e8efe5a::collection::borrow_uid_mut<T0>(arg0, arg1);
        0x2::vec_set::remove<0x2::object::ID>(&mut borrow_domain_mut(v0).allowlists, &arg2);
    }

    // decompiled from Move bytecode v6
}

