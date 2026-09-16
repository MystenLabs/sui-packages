module 0x44b97b2976f15b41537218ca63254b5ed647c484ab18e7cc199fe30d4a3bbbad::party_media {
    struct MediaKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Media has drop, store {
        quilt: u256,
    }

    struct MediaSetEvent has copy, drop {
        party_id: address,
        admin_cap_id: address,
        existed_before: bool,
        previous_quilt: u256,
        quilt: u256,
    }

    struct MediaClearedEvent has copy, drop {
        party_id: address,
        admin_cap_id: address,
        previous_quilt: u256,
    }

    public fun clear_media(arg0: &mut 0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::Party, arg1: &0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::PartyAdminCap) {
        let v0 = 0x2::object::id<0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::Party>(arg0);
        let v1 = 0x2::object::id<0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::PartyAdminCap>(arg1);
        let v2 = 0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::uid_mut(arg0, arg1);
        let v3 = MediaKey{dummy_field: false};
        if (0x2::dynamic_field::exists<MediaKey>(v2, v3)) {
            let v4 = MediaKey{dummy_field: false};
            let Media { quilt: v5 } = 0x2::dynamic_field::remove<MediaKey, Media>(v2, v4);
            let v6 = MediaClearedEvent{
                party_id       : 0x2::object::id_to_address(&v0),
                admin_cap_id   : 0x2::object::id_to_address(&v1),
                previous_quilt : v5,
            };
            0x2::event::emit<MediaClearedEvent>(v6);
        };
    }

    public fun has_media(arg0: &0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::Party) : bool {
        let v0 = MediaKey{dummy_field: false};
        0x2::dynamic_field::exists<MediaKey>(0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::uid(arg0), v0)
    }

    public fun quilt(arg0: &0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::Party) : 0x1::option::Option<u256> {
        let v0 = MediaKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<MediaKey>(0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::uid(arg0), v0)) {
            return 0x1::option::none<u256>()
        };
        let v1 = MediaKey{dummy_field: false};
        0x1::option::some<u256>(0x2::dynamic_field::borrow<MediaKey, Media>(0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::uid(arg0), v1).quilt)
    }

    public fun set_media(arg0: &mut 0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::Party, arg1: &0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::PartyAdminCap, arg2: u256) {
        assert!(arg2 != 0, 0);
        let v0 = 0x2::object::id<0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::Party>(arg0);
        let v1 = 0x2::object::id<0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::PartyAdminCap>(arg1);
        let v2 = 0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::uid_mut(arg0, arg1);
        let v3 = MediaKey{dummy_field: false};
        let v4 = 0x2::dynamic_field::exists<MediaKey>(v2, v3);
        let v5 = 0;
        if (v4) {
            let v6 = MediaKey{dummy_field: false};
            v5 = 0x2::dynamic_field::borrow<MediaKey, Media>(v2, v6).quilt;
            let v7 = MediaKey{dummy_field: false};
            0x2::dynamic_field::borrow_mut<MediaKey, Media>(v2, v7).quilt = arg2;
        } else {
            let v8 = MediaKey{dummy_field: false};
            let v9 = Media{quilt: arg2};
            0x2::dynamic_field::add<MediaKey, Media>(v2, v8, v9);
        };
        if (!v4 || v5 != arg2) {
            let v10 = MediaSetEvent{
                party_id       : 0x2::object::id_to_address(&v0),
                admin_cap_id   : 0x2::object::id_to_address(&v1),
                existed_before : v4,
                previous_quilt : v5,
                quilt          : arg2,
            };
            0x2::event::emit<MediaSetEvent>(v10);
        };
    }

    // decompiled from Move bytecode v7
}

