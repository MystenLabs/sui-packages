module 0xff6bdce100185ec8d4d1c84d169aa03148627f37a07b6e408886a11d93dbf0d9::svg {
    struct Svg has drop, store {
        svg: vector<u8>,
    }

    public fun add_domain(arg0: &mut 0x2::object::UID, arg1: Svg) {
        assert_no_svg(arg0);
        0x2::dynamic_field::add<0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::Marker<Svg>, Svg>(arg0, 0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::marker<Svg>(), arg1);
    }

    public fun add_empty(arg0: &mut 0x2::object::UID) {
        add_domain(arg0, new_empty());
    }

    public fun add_new(arg0: &mut 0x2::object::UID, arg1: vector<u8>) {
        add_domain(arg0, new(arg1));
    }

    public fun assert_no_svg(arg0: &0x2::object::UID) {
        assert!(!has_domain(arg0), 2);
    }

    public fun assert_svg(arg0: &0x2::object::UID) {
        assert!(has_domain(arg0), 1);
    }

    public fun borrow_domain(arg0: &0x2::object::UID) : &Svg {
        assert_svg(arg0);
        0x2::dynamic_field::borrow<0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::Marker<Svg>, Svg>(arg0, 0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::marker<Svg>())
    }

    public fun borrow_domain_mut(arg0: &mut 0x2::object::UID) : &mut Svg {
        assert_svg(arg0);
        0x2::dynamic_field::borrow_mut<0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::Marker<Svg>, Svg>(arg0, 0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::marker<Svg>())
    }

    public fun get_svg(arg0: &Svg) : &vector<u8> {
        &arg0.svg
    }

    public fun has_domain(arg0: &0x2::object::UID) : bool {
        0x2::dynamic_field::exists_with_type<0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::Marker<Svg>, Svg>(arg0, 0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::marker<Svg>())
    }

    public fun new(arg0: vector<u8>) : Svg {
        Svg{svg: arg0}
    }

    public fun new_empty() : Svg {
        Svg{svg: 0x1::vector::empty<u8>()}
    }

    public fun remove_domain(arg0: &mut 0x2::object::UID) : Svg {
        assert_svg(arg0);
        0x2::dynamic_field::remove<0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::Marker<Svg>, Svg>(arg0, 0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::marker<Svg>())
    }

    public fun set_svg<T0>(arg0: &mut Svg, arg1: vector<u8>) {
        arg0.svg = arg1;
    }

    // decompiled from Move bytecode v6
}

