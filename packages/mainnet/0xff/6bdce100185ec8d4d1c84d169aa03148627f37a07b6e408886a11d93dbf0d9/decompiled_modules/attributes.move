module 0xff6bdce100185ec8d4d1c84d169aa03148627f37a07b6e408886a11d93dbf0d9::attributes {
    struct Attributes has drop, store {
        map: 0x2::vec_map::VecMap<0x1::ascii::String, 0x1::ascii::String>,
    }

    public fun empty() : Attributes {
        Attributes{map: 0x2::vec_map::empty<0x1::ascii::String, 0x1::ascii::String>()}
    }

    public fun add_domain(arg0: &mut 0x2::object::UID, arg1: Attributes) {
        assert_no_attributes(arg0);
        0x2::dynamic_field::add<0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::Marker<Attributes>, Attributes>(arg0, 0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::marker<Attributes>(), arg1);
    }

    public fun add_empty(arg0: &mut 0x2::object::UID) {
        0x2::dynamic_field::add<0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::Marker<Attributes>, Attributes>(arg0, 0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::marker<Attributes>(), empty());
    }

    public fun add_from_vec(arg0: vector<0x1::ascii::String>, arg1: vector<0x1::ascii::String>) : Attributes {
        new(0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::from_vec_to_map<0x1::ascii::String, 0x1::ascii::String>(arg0, arg1))
    }

    public fun add_new(arg0: &mut 0x2::object::UID, arg1: 0x2::vec_map::VecMap<0x1::ascii::String, 0x1::ascii::String>) {
        0x2::dynamic_field::add<0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::Marker<Attributes>, Attributes>(arg0, 0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::marker<Attributes>(), new(arg1));
    }

    public fun as_url_parameters(arg0: &Attributes) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = get_attributes(arg0);
        let v2 = 0x2::vec_map::size<0x1::ascii::String, 0x1::ascii::String>(v1);
        if (v2 > 0) {
            0x1::vector::append<u8>(&mut v0, b"?");
        };
        let v3 = 0;
        while (v3 < v2) {
            let (v4, v5) = 0x2::vec_map::get_entry_by_idx<0x1::ascii::String, 0x1::ascii::String>(v1, v3);
            0x1::vector::append<u8>(&mut v0, 0x1::ascii::into_bytes(*v4));
            0x1::vector::append<u8>(&mut v0, b"=");
            0x1::vector::append<u8>(&mut v0, 0x1::ascii::into_bytes(*v5));
            let v6 = v3 + 1;
            v3 = v6;
            if (v6 != v2) {
                0x1::vector::append<u8>(&mut v0, b"&");
            };
        };
        v0
    }

    public fun assert_attributes(arg0: &0x2::object::UID) {
        assert!(has_domain(arg0), 1);
    }

    public fun assert_no_attributes(arg0: &0x2::object::UID) {
        assert!(!has_domain(arg0), 2);
    }

    public fun borrow_domain(arg0: &0x2::object::UID) : &Attributes {
        assert_attributes(arg0);
        0x2::dynamic_field::borrow<0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::Marker<Attributes>, Attributes>(arg0, 0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::marker<Attributes>())
    }

    public fun borrow_domain_mut(arg0: &mut 0x2::object::UID) : &mut Attributes {
        assert_attributes(arg0);
        0x2::dynamic_field::borrow_mut<0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::Marker<Attributes>, Attributes>(arg0, 0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::marker<Attributes>())
    }

    public fun from_vec(arg0: vector<0x1::ascii::String>, arg1: vector<0x1::ascii::String>) : Attributes {
        new(0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::from_vec_to_map<0x1::ascii::String, 0x1::ascii::String>(arg0, arg1))
    }

    public fun get_attributes(arg0: &Attributes) : &0x2::vec_map::VecMap<0x1::ascii::String, 0x1::ascii::String> {
        &arg0.map
    }

    public fun get_attributes_mut(arg0: &mut Attributes) : &mut 0x2::vec_map::VecMap<0x1::ascii::String, 0x1::ascii::String> {
        &mut arg0.map
    }

    public fun has_domain(arg0: &0x2::object::UID) : bool {
        0x2::dynamic_field::exists_with_type<0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::Marker<Attributes>, Attributes>(arg0, 0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::marker<Attributes>())
    }

    public fun insert_attribute<T0: drop, T1: key>(arg0: &mut Attributes, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String) {
        0x2::vec_map::insert<0x1::ascii::String, 0x1::ascii::String>(get_attributes_mut(arg0), arg1, arg2);
    }

    public fun new(arg0: 0x2::vec_map::VecMap<0x1::ascii::String, 0x1::ascii::String>) : Attributes {
        Attributes{map: arg0}
    }

    public fun remove_attribute<T0: drop, T1: key>(arg0: &mut Attributes, arg1: &0x1::ascii::String) {
        let (_, _) = 0x2::vec_map::remove<0x1::ascii::String, 0x1::ascii::String>(get_attributes_mut(arg0), arg1);
    }

    public fun remove_domain(arg0: &mut 0x2::object::UID) : Attributes {
        assert_attributes(arg0);
        0x2::dynamic_field::remove<0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::Marker<Attributes>, Attributes>(arg0, 0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::marker<Attributes>())
    }

    // decompiled from Move bytecode v6
}

