module 0x75908ec2bcdfe076f8c2c94e42af470b94b165b33c1c1d53046c29130028d483::composable_url {
    struct ComposableUrl has store {
        url: 0x2::url::Url,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    public fun borrow_domain(arg0: &0x2::object::UID) : &ComposableUrl {
        assert_composable_url(arg0);
        0x2::dynamic_field::borrow<0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils::Marker<ComposableUrl>, ComposableUrl>(arg0, 0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils::marker<ComposableUrl>())
    }

    public fun has_domain(arg0: &0x2::object::UID) : bool {
        0x2::dynamic_field::exists_with_type<0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils::Marker<ComposableUrl>, ComposableUrl>(arg0, 0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils::marker<ComposableUrl>())
    }

    public fun add_domain(arg0: &mut 0x2::object::UID, arg1: ComposableUrl) {
        assert_no_composable_url(arg0);
        0x2::dynamic_field::add<0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils::Marker<ComposableUrl>, ComposableUrl>(arg0, 0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils::marker<ComposableUrl>(), arg1);
    }

    public fun assert_composable_url(arg0: &0x2::object::UID) {
        assert!(has_domain(arg0), 1);
    }

    public fun assert_no_composable_url(arg0: &0x2::object::UID) {
        assert!(!has_domain(arg0), 2);
    }

    public fun borrow_domain_mut(arg0: &mut 0x2::object::UID) : &mut ComposableUrl {
        assert_composable_url(arg0);
        0x2::dynamic_field::borrow_mut<0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils::Marker<ComposableUrl>, ComposableUrl>(arg0, 0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils::marker<ComposableUrl>())
    }

    public fun new() : ComposableUrl {
        ComposableUrl{url: 0x2::url::new_unsafe_from_bytes(b"")}
    }

    public fun regenerate(arg0: &mut 0x2::object::UID) {
        let v0 = 0x1::ascii::into_bytes(0x2::url::inner_url(0x75908ec2bcdfe076f8c2c94e42af470b94b165b33c1c1d53046c29130028d483::url::borrow_domain(arg0)));
        if (0x75908ec2bcdfe076f8c2c94e42af470b94b165b33c1c1d53046c29130028d483::attributes::has_domain(arg0)) {
            0x1::vector::append<u8>(&mut v0, 0x75908ec2bcdfe076f8c2c94e42af470b94b165b33c1c1d53046c29130028d483::attributes::as_url_parameters(0x75908ec2bcdfe076f8c2c94e42af470b94b165b33c1c1d53046c29130028d483::attributes::borrow_domain(arg0)));
        };
    }

    public fun remove_domain(arg0: &mut 0x2::object::UID) : ComposableUrl {
        assert_composable_url(arg0);
        0x2::dynamic_field::remove<0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils::Marker<ComposableUrl>, ComposableUrl>(arg0, 0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils::marker<ComposableUrl>())
    }

    public fun set_url<T0>(arg0: &mut ComposableUrl, arg1: 0x2::url::Url) {
        arg0.url = arg1;
    }

    // decompiled from Move bytecode v6
}

