module 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::url {
    public fun add_domain(arg0: &mut 0x2::object::UID, arg1: 0x2::url::Url) {
        assert_no_url(arg0);
        0x2::dynamic_field::add<0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::Marker<0x2::url::Url>, 0x2::url::Url>(arg0, 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::marker<0x2::url::Url>(), arg1);
    }

    public fun assert_no_url(arg0: &0x2::object::UID) {
        assert!(!has_domain(arg0), 2);
    }

    public fun assert_url(arg0: &0x2::object::UID) {
        assert!(has_domain(arg0), 1);
    }

    public fun borrow_domain(arg0: &0x2::object::UID) : &0x2::url::Url {
        assert_url(arg0);
        0x2::dynamic_field::borrow<0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::Marker<0x2::url::Url>, 0x2::url::Url>(arg0, 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::marker<0x2::url::Url>())
    }

    public fun borrow_domain_mut(arg0: &mut 0x2::object::UID) : &mut 0x2::url::Url {
        assert_url(arg0);
        0x2::dynamic_field::borrow_mut<0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::Marker<0x2::url::Url>, 0x2::url::Url>(arg0, 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::marker<0x2::url::Url>())
    }

    public fun has_domain(arg0: &0x2::object::UID) : bool {
        0x2::dynamic_field::exists_with_type<0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::Marker<0x2::url::Url>, 0x2::url::Url>(arg0, 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::marker<0x2::url::Url>())
    }

    public fun remove_domain(arg0: &mut 0x2::object::UID) : 0x2::url::Url {
        assert_url(arg0);
        0x2::dynamic_field::remove<0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::Marker<0x2::url::Url>, 0x2::url::Url>(arg0, 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::marker<0x2::url::Url>())
    }

    // decompiled from Move bytecode v6
}

