module 0x721d599ee97ec61c863b7b28afcf855eee423ea76d2bd0f1fc6326d3cc41664c::composition_title {
    struct CompositionTitleKey has copy, drop, store {
        dummy_field: bool,
    }

    struct CompositionTitleSetEvent has copy, drop {
        composition_id: 0x2::object::ID,
        title: 0x1::string::String,
    }

    struct CompositionTitleClearedEvent has copy, drop {
        composition_id: 0x2::object::ID,
    }

    public fun clear_title<T0>(arg0: &mut 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::composition::Composition<T0>, arg1: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::composition::CompositionAdminCap<T0>) {
        let v0 = 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::composition::uid_mut<T0>(arg0, arg1);
        let v1 = CompositionTitleKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<CompositionTitleKey>(v0, v1)) {
            return
        };
        let v2 = CompositionTitleKey{dummy_field: false};
        0x2::dynamic_field::remove<CompositionTitleKey, 0x1::string::String>(v0, v2);
        let v3 = CompositionTitleClearedEvent{composition_id: 0x2::object::id<0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::composition::Composition<T0>>(arg0)};
        0x2::event::emit<CompositionTitleClearedEvent>(v3);
    }

    public fun has_title<T0>(arg0: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::composition::Composition<T0>) : bool {
        let v0 = CompositionTitleKey{dummy_field: false};
        0x2::dynamic_field::exists<CompositionTitleKey>(0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::composition::uid<T0>(arg0), v0)
    }

    public fun set_title<T0>(arg0: &mut 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::composition::Composition<T0>, arg1: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::composition::CompositionAdminCap<T0>, arg2: 0x1::string::String) {
        let v0 = 0x1::string::as_bytes(&arg2);
        assert!(!0x1::vector::is_empty<u8>(v0), 1);
        assert!(0x1::vector::length<u8>(v0) <= 300, 2);
        let v1 = 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::composition::uid_mut<T0>(arg0, arg1);
        let v2 = CompositionTitleKey{dummy_field: false};
        if (0x2::dynamic_field::exists<CompositionTitleKey>(v1, v2)) {
            let v3 = CompositionTitleKey{dummy_field: false};
            let v4 = 0x2::dynamic_field::borrow_mut<CompositionTitleKey, 0x1::string::String>(v1, v3);
            if (*v4 == arg2) {
                return
            };
            *v4 = arg2;
        } else {
            let v5 = CompositionTitleKey{dummy_field: false};
            0x2::dynamic_field::add<CompositionTitleKey, 0x1::string::String>(v1, v5, arg2);
        };
        let v6 = CompositionTitleSetEvent{
            composition_id : 0x2::object::id<0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::composition::Composition<T0>>(arg0),
            title          : arg2,
        };
        0x2::event::emit<CompositionTitleSetEvent>(v6);
    }

    public fun title<T0>(arg0: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::composition::Composition<T0>) : &0x1::string::String {
        assert!(has_title<T0>(arg0), 0);
        let v0 = CompositionTitleKey{dummy_field: false};
        0x2::dynamic_field::borrow<CompositionTitleKey, 0x1::string::String>(0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::composition::uid<T0>(arg0), v0)
    }

    // decompiled from Move bytecode v7
}

