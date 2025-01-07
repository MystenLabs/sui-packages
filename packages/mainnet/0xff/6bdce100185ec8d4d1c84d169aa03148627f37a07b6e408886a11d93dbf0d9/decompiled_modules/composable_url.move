module 0xff6bdce100185ec8d4d1c84d169aa03148627f37a07b6e408886a11d93dbf0d9::composable_url {
    struct ComposableUrl has store {
        url: 0x2::url::Url,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    public fun borrow_domain(arg0: &0x2::object::UID) : &ComposableUrl {
        assert_composable_url(arg0);
        0x2::dynamic_field::borrow<0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::Marker<ComposableUrl>, ComposableUrl>(arg0, 0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::marker<ComposableUrl>())
    }

    public fun has_domain(arg0: &0x2::object::UID) : bool {
        0x2::dynamic_field::exists_with_type<0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::Marker<ComposableUrl>, ComposableUrl>(arg0, 0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::marker<ComposableUrl>())
    }

    public fun add_domain(arg0: &mut 0x2::object::UID, arg1: ComposableUrl) {
        assert_no_composable_url(arg0);
        0x2::dynamic_field::add<0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::Marker<ComposableUrl>, ComposableUrl>(arg0, 0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::marker<ComposableUrl>(), arg1);
    }

    public fun assert_composable_url(arg0: &0x2::object::UID) {
        assert!(has_domain(arg0), 1);
    }

    public fun assert_no_composable_url(arg0: &0x2::object::UID) {
        assert!(!has_domain(arg0), 2);
    }

    public fun borrow_domain_mut(arg0: &mut 0x2::object::UID) : &mut ComposableUrl {
        assert_composable_url(arg0);
        0x2::dynamic_field::borrow_mut<0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::Marker<ComposableUrl>, ComposableUrl>(arg0, 0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::marker<ComposableUrl>())
    }

    public fun new() : ComposableUrl {
        ComposableUrl{url: 0x2::url::new_unsafe_from_bytes(b"")}
    }

    public fun regenerate(arg0: &mut 0x2::object::UID) {
        let v0 = 0x1::ascii::into_bytes(0x2::url::inner_url(0xff6bdce100185ec8d4d1c84d169aa03148627f37a07b6e408886a11d93dbf0d9::url::borrow_domain(arg0)));
        if (0xff6bdce100185ec8d4d1c84d169aa03148627f37a07b6e408886a11d93dbf0d9::attributes::has_domain(arg0)) {
            0x1::vector::append<u8>(&mut v0, 0xff6bdce100185ec8d4d1c84d169aa03148627f37a07b6e408886a11d93dbf0d9::attributes::as_url_parameters(0xff6bdce100185ec8d4d1c84d169aa03148627f37a07b6e408886a11d93dbf0d9::attributes::borrow_domain(arg0)));
        };
    }

    public fun remove_domain(arg0: &mut 0x2::object::UID) : ComposableUrl {
        assert_composable_url(arg0);
        0x2::dynamic_field::remove<0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::Marker<ComposableUrl>, ComposableUrl>(arg0, 0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::marker<ComposableUrl>())
    }

    public fun set_url<T0>(arg0: &mut ComposableUrl, arg1: 0x2::url::Url) {
        arg0.url = arg1;
    }

    // decompiled from Move bytecode v6
}

