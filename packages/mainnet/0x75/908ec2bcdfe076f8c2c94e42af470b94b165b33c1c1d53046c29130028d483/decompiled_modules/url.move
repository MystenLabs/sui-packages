module 0x75908ec2bcdfe076f8c2c94e42af470b94b165b33c1c1d53046c29130028d483::url {
    public fun add_domain(arg0: &mut 0x2::object::UID, arg1: 0x2::url::Url) {
        assert_no_url(arg0);
        0x2::dynamic_field::add<0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils::Marker<0x2::url::Url>, 0x2::url::Url>(arg0, 0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils::marker<0x2::url::Url>(), arg1);
    }

    public fun assert_no_url(arg0: &0x2::object::UID) {
        assert!(!has_domain(arg0), 2);
    }

    public fun assert_url(arg0: &0x2::object::UID) {
        assert!(has_domain(arg0), 1);
    }

    public fun borrow_domain(arg0: &0x2::object::UID) : &0x2::url::Url {
        assert_url(arg0);
        0x2::dynamic_field::borrow<0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils::Marker<0x2::url::Url>, 0x2::url::Url>(arg0, 0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils::marker<0x2::url::Url>())
    }

    public fun borrow_domain_mut(arg0: &mut 0x2::object::UID) : &mut 0x2::url::Url {
        assert_url(arg0);
        0x2::dynamic_field::borrow_mut<0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils::Marker<0x2::url::Url>, 0x2::url::Url>(arg0, 0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils::marker<0x2::url::Url>())
    }

    public fun has_domain(arg0: &0x2::object::UID) : bool {
        0x2::dynamic_field::exists_with_type<0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils::Marker<0x2::url::Url>, 0x2::url::Url>(arg0, 0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils::marker<0x2::url::Url>())
    }

    public fun remove_domain(arg0: &mut 0x2::object::UID) : 0x2::url::Url {
        assert_url(arg0);
        0x2::dynamic_field::remove<0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils::Marker<0x2::url::Url>, 0x2::url::Url>(arg0, 0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils::marker<0x2::url::Url>())
    }

    // decompiled from Move bytecode v6
}

