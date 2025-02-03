module 0xff6bdce100185ec8d4d1c84d169aa03148627f37a07b6e408886a11d93dbf0d9::url {
    public fun add_domain(arg0: &mut 0x2::object::UID, arg1: 0x2::url::Url) {
        assert_no_url(arg0);
        0x2::dynamic_field::add<0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::Marker<0x2::url::Url>, 0x2::url::Url>(arg0, 0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::marker<0x2::url::Url>(), arg1);
    }

    public fun assert_no_url(arg0: &0x2::object::UID) {
        assert!(!has_domain(arg0), 2);
    }

    public fun assert_url(arg0: &0x2::object::UID) {
        assert!(has_domain(arg0), 1);
    }

    public fun borrow_domain(arg0: &0x2::object::UID) : &0x2::url::Url {
        assert_url(arg0);
        0x2::dynamic_field::borrow<0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::Marker<0x2::url::Url>, 0x2::url::Url>(arg0, 0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::marker<0x2::url::Url>())
    }

    public fun borrow_domain_mut(arg0: &mut 0x2::object::UID) : &mut 0x2::url::Url {
        assert_url(arg0);
        0x2::dynamic_field::borrow_mut<0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::Marker<0x2::url::Url>, 0x2::url::Url>(arg0, 0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::marker<0x2::url::Url>())
    }

    public fun has_domain(arg0: &0x2::object::UID) : bool {
        0x2::dynamic_field::exists_with_type<0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::Marker<0x2::url::Url>, 0x2::url::Url>(arg0, 0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::marker<0x2::url::Url>())
    }

    public fun remove_domain(arg0: &mut 0x2::object::UID) : 0x2::url::Url {
        assert_url(arg0);
        0x2::dynamic_field::remove<0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::Marker<0x2::url::Url>, 0x2::url::Url>(arg0, 0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::marker<0x2::url::Url>())
    }

    // decompiled from Move bytecode v6
}

