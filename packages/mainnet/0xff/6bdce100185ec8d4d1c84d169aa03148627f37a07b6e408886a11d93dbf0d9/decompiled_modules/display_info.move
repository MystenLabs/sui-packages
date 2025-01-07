module 0xff6bdce100185ec8d4d1c84d169aa03148627f37a07b6e408886a11d93dbf0d9::display_info {
    struct DisplayInfo has drop, store {
        name: 0x1::string::String,
        description: 0x1::string::String,
    }

    public fun add_domain(arg0: &mut 0x2::object::UID, arg1: DisplayInfo) {
        assert_no_display(arg0);
        0x2::dynamic_field::add<0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::Marker<DisplayInfo>, DisplayInfo>(arg0, 0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::marker<DisplayInfo>(), arg1);
    }

    public fun assert_display(arg0: &0x2::object::UID) {
        assert!(has_domain(arg0), 1);
    }

    public fun assert_no_display(arg0: &0x2::object::UID) {
        assert!(!has_domain(arg0), 2);
    }

    public fun borrow_domain(arg0: &0x2::object::UID) : &DisplayInfo {
        assert_display(arg0);
        0x2::dynamic_field::borrow<0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::Marker<DisplayInfo>, DisplayInfo>(arg0, 0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::marker<DisplayInfo>())
    }

    public fun borrow_domain_mut(arg0: &mut 0x2::object::UID) : &mut DisplayInfo {
        assert_display(arg0);
        0x2::dynamic_field::borrow_mut<0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::Marker<DisplayInfo>, DisplayInfo>(arg0, 0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::marker<DisplayInfo>())
    }

    public fun change_description<T0: drop, T1: key>(arg0: &mut 0x2::object::UID, arg1: 0x1::string::String) {
        borrow_domain_mut(arg0).description = arg1;
    }

    public fun change_name<T0: drop, T1: key>(arg0: &mut 0x2::object::UID, arg1: 0x1::string::String) {
        borrow_domain_mut(arg0).name = arg1;
    }

    public fun get_description(arg0: &DisplayInfo) : &0x1::string::String {
        &arg0.description
    }

    public fun get_description_mut(arg0: &mut DisplayInfo) : &0x1::string::String {
        &mut arg0.description
    }

    public fun get_name(arg0: &DisplayInfo) : &0x1::string::String {
        &arg0.name
    }

    public fun get_name_mut(arg0: &mut DisplayInfo) : &0x1::string::String {
        &mut arg0.name
    }

    public fun has_domain(arg0: &0x2::object::UID) : bool {
        0x2::dynamic_field::exists_with_type<0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::Marker<DisplayInfo>, DisplayInfo>(arg0, 0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::marker<DisplayInfo>())
    }

    public fun new(arg0: 0x1::string::String, arg1: 0x1::string::String) : DisplayInfo {
        DisplayInfo{
            name        : arg0,
            description : arg1,
        }
    }

    public fun remove_domain(arg0: &mut 0x2::object::UID) : DisplayInfo {
        assert_display(arg0);
        0x2::dynamic_field::remove<0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::Marker<DisplayInfo>, DisplayInfo>(arg0, 0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::marker<DisplayInfo>())
    }

    // decompiled from Move bytecode v6
}

