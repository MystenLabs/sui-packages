module 0xce466e4a54bec4a2dc34dc6f19b6a371947f4aa930ca5318e71ddcdb46789da4::composable_url {
    struct ComposableUrl has store {
        url: 0x2::url::Url,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    public fun borrow_domain(arg0: &0x2::object::UID) : &ComposableUrl {
        assert_composable_url(arg0);
        0x2::dynamic_field::borrow<0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::Marker<ComposableUrl>, ComposableUrl>(arg0, 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::marker<ComposableUrl>())
    }

    public fun has_domain(arg0: &0x2::object::UID) : bool {
        0x2::dynamic_field::exists_with_type<0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::Marker<ComposableUrl>, ComposableUrl>(arg0, 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::marker<ComposableUrl>())
    }

    public fun add_domain(arg0: &mut 0x2::object::UID, arg1: ComposableUrl) {
        assert_no_composable_url(arg0);
        0x2::dynamic_field::add<0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::Marker<ComposableUrl>, ComposableUrl>(arg0, 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::marker<ComposableUrl>(), arg1);
    }

    public fun assert_composable_url(arg0: &0x2::object::UID) {
        assert!(has_domain(arg0), 1);
    }

    public fun assert_no_composable_url(arg0: &0x2::object::UID) {
        assert!(!has_domain(arg0), 2);
    }

    public fun borrow_domain_mut(arg0: &mut 0x2::object::UID) : &mut ComposableUrl {
        assert_composable_url(arg0);
        0x2::dynamic_field::borrow_mut<0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::Marker<ComposableUrl>, ComposableUrl>(arg0, 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::marker<ComposableUrl>())
    }

    public fun new() : ComposableUrl {
        ComposableUrl{url: 0x2::url::new_unsafe_from_bytes(b"")}
    }

    public fun regenerate(arg0: &mut 0x2::object::UID) {
        let v0 = 0x1::ascii::into_bytes(0x2::url::inner_url(0xce466e4a54bec4a2dc34dc6f19b6a371947f4aa930ca5318e71ddcdb46789da4::url::borrow_domain(arg0)));
        if (0xce466e4a54bec4a2dc34dc6f19b6a371947f4aa930ca5318e71ddcdb46789da4::attributes::has_domain(arg0)) {
            0x1::vector::append<u8>(&mut v0, 0xce466e4a54bec4a2dc34dc6f19b6a371947f4aa930ca5318e71ddcdb46789da4::attributes::as_url_parameters(0xce466e4a54bec4a2dc34dc6f19b6a371947f4aa930ca5318e71ddcdb46789da4::attributes::borrow_domain(arg0)));
        };
    }

    public fun remove_domain(arg0: &mut 0x2::object::UID) : ComposableUrl {
        assert_composable_url(arg0);
        0x2::dynamic_field::remove<0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::Marker<ComposableUrl>, ComposableUrl>(arg0, 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::marker<ComposableUrl>())
    }

    public fun set_url<T0>(arg0: &mut ComposableUrl, arg1: 0x2::url::Url) {
        arg0.url = arg1;
    }

    // decompiled from Move bytecode v6
}

