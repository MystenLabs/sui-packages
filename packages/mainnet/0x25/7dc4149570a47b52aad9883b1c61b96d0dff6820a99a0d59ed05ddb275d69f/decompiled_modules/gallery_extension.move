module 0x257dc4149570a47b52aad9883b1c61b96d0dff6820a99a0d59ed05ddb275d69f::gallery_extension {
    struct GalleryMarker has copy, drop, store {
        dummy_field: bool,
    }

    struct GalleryExtension has copy, drop, store {
        enabled_at: u64,
        curator: address,
        note: 0x1::string::String,
    }

    struct GalleryEnabled has copy, drop {
        kiosk_id: 0x2::object::ID,
        curator: address,
        timestamp: u64,
        note: 0x1::string::String,
    }

    struct GalleryDisabled has copy, drop {
        kiosk_id: 0x2::object::ID,
        curator: address,
        timestamp: u64,
    }

    public fun disable_gallery(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(is_enabled(arg0), 2);
        let v0 = GalleryMarker{dummy_field: false};
        0x2::dynamic_field::remove<GalleryMarker, GalleryExtension>(0x2::kiosk::uid_mut_as_owner(arg0, arg1), v0);
        let v1 = GalleryDisabled{
            kiosk_id  : 0x2::object::id<0x2::kiosk::Kiosk>(arg0),
            curator   : 0x2::tx_context::sender(arg3),
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<GalleryDisabled>(v1);
    }

    public fun enable_gallery(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!is_enabled(arg0), 1);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = GalleryExtension{
            enabled_at : v1,
            curator    : v0,
            note       : arg2,
        };
        let v3 = GalleryMarker{dummy_field: false};
        0x2::dynamic_field::add<GalleryMarker, GalleryExtension>(0x2::kiosk::uid_mut_as_owner(arg0, arg1), v3, v2);
        let v4 = GalleryEnabled{
            kiosk_id  : 0x2::object::id<0x2::kiosk::Kiosk>(arg0),
            curator   : v0,
            timestamp : v1,
            note      : arg2,
        };
        0x2::event::emit<GalleryEnabled>(v4);
    }

    public fun get_curator(arg0: &0x2::kiosk::Kiosk) : 0x1::option::Option<address> {
        if (is_enabled(arg0)) {
            let v1 = GalleryMarker{dummy_field: false};
            0x1::option::some<address>(0x2::dynamic_field::borrow<GalleryMarker, GalleryExtension>(0x2::kiosk::uid(arg0), v1).curator)
        } else {
            0x1::option::none<address>()
        }
    }

    public fun get_enabled_at(arg0: &0x2::kiosk::Kiosk) : 0x1::option::Option<u64> {
        if (is_enabled(arg0)) {
            let v1 = GalleryMarker{dummy_field: false};
            0x1::option::some<u64>(0x2::dynamic_field::borrow<GalleryMarker, GalleryExtension>(0x2::kiosk::uid(arg0), v1).enabled_at)
        } else {
            0x1::option::none<u64>()
        }
    }

    public fun get_extension(arg0: &0x2::kiosk::Kiosk) : 0x1::option::Option<GalleryExtension> {
        if (is_enabled(arg0)) {
            let v1 = GalleryMarker{dummy_field: false};
            0x1::option::some<GalleryExtension>(*0x2::dynamic_field::borrow<GalleryMarker, GalleryExtension>(0x2::kiosk::uid(arg0), v1))
        } else {
            0x1::option::none<GalleryExtension>()
        }
    }

    public fun get_note(arg0: &0x2::kiosk::Kiosk) : 0x1::option::Option<0x1::string::String> {
        if (is_enabled(arg0)) {
            let v1 = GalleryMarker{dummy_field: false};
            0x1::option::some<0x1::string::String>(0x2::dynamic_field::borrow<GalleryMarker, GalleryExtension>(0x2::kiosk::uid(arg0), v1).note)
        } else {
            0x1::option::none<0x1::string::String>()
        }
    }

    public fun is_enabled(arg0: &0x2::kiosk::Kiosk) : bool {
        let v0 = GalleryMarker{dummy_field: false};
        0x2::dynamic_field::exists_<GalleryMarker>(0x2::kiosk::uid(arg0), v0)
    }

    public fun update_note(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x1::string::String) {
        assert!(is_enabled(arg0), 2);
        let v0 = GalleryMarker{dummy_field: false};
        0x2::dynamic_field::borrow_mut<GalleryMarker, GalleryExtension>(0x2::kiosk::uid_mut_as_owner(arg0, arg1), v0).note = arg2;
    }

    // decompiled from Move bytecode v6
}

