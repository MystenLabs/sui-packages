module 0xa9827654aee8031055646137cc896afb9d6516bd6bc8cc37e1f2e4c9cc7e418e::party_tags {
    struct TagsKey has copy, drop, store {
        dummy_field: bool,
    }

    struct TagAddedEvent has copy, drop {
        party_id: address,
        admin_cap_id: address,
        tag: vector<u8>,
        tag_count_before: u64,
        tag_count_after: u64,
    }

    struct TagRemovedEvent has copy, drop {
        party_id: address,
        admin_cap_id: address,
        tag: vector<u8>,
        tag_count_before: u64,
        tag_count_after: u64,
    }

    struct TagsClearedEvent has copy, drop {
        party_id: address,
        admin_cap_id: address,
        tag_count_before: u64,
        tag_count_after: u64,
    }

    public fun add_tag(arg0: &mut 0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::Party, arg1: &0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::PartyAdminCap, arg2: 0x1::string::String) {
        assert!(!0x1::string::is_empty(&arg2), 0);
        assert!(0x1::string::length(&arg2) <= 50, 1);
        let v0 = 0x2::object::id<0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::Party>(arg0);
        let v1 = 0x2::object::id<0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::PartyAdminCap>(arg1);
        let v2 = TagsKey{dummy_field: false};
        0x3a8db4338b58e7967347d233ba0bb1fd92092b782a55f561f69084e787a280be::typed_set::add<TagsKey, 0x1::string::String>(0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::uid_mut(arg0, arg1), v2, arg2, 30);
        let v3 = TagsKey{dummy_field: false};
        let v4 = 0x3a8db4338b58e7967347d233ba0bb1fd92092b782a55f561f69084e787a280be::typed_set::keys<TagsKey, 0x1::string::String>(0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::uid(arg0), v3);
        let v5 = 0x1::vector::length<0x1::string::String>(&v4);
        let v6 = TagAddedEvent{
            party_id         : 0x2::object::id_to_address(&v0),
            admin_cap_id     : 0x2::object::id_to_address(&v1),
            tag              : *0x1::string::as_bytes(&arg2),
            tag_count_before : v5 - 1,
            tag_count_after  : v5,
        };
        0x2::event::emit<TagAddedEvent>(v6);
    }

    public fun clear_tags(arg0: &mut 0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::Party, arg1: &0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::PartyAdminCap) {
        let v0 = 0x2::object::id<0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::Party>(arg0);
        let v1 = 0x2::object::id<0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::PartyAdminCap>(arg1);
        let v2 = 0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::uid_mut(arg0, arg1);
        let v3 = TagsKey{dummy_field: false};
        if (0x3a8db4338b58e7967347d233ba0bb1fd92092b782a55f561f69084e787a280be::typed_set::exists<TagsKey>(v2, v3)) {
            let v4 = TagsKey{dummy_field: false};
            let v5 = 0x3a8db4338b58e7967347d233ba0bb1fd92092b782a55f561f69084e787a280be::typed_set::keys<TagsKey, 0x1::string::String>(v2, v4);
            let v6 = TagsKey{dummy_field: false};
            0x3a8db4338b58e7967347d233ba0bb1fd92092b782a55f561f69084e787a280be::typed_set::clear<TagsKey, 0x1::string::String>(v2, v6);
            let v7 = TagsKey{dummy_field: false};
            let v8 = 0x3a8db4338b58e7967347d233ba0bb1fd92092b782a55f561f69084e787a280be::typed_set::keys<TagsKey, 0x1::string::String>(v2, v7);
            let v9 = TagsClearedEvent{
                party_id         : 0x2::object::id_to_address(&v0),
                admin_cap_id     : 0x2::object::id_to_address(&v1),
                tag_count_before : 0x1::vector::length<0x1::string::String>(&v5),
                tag_count_after  : 0x1::vector::length<0x1::string::String>(&v8),
            };
            0x2::event::emit<TagsClearedEvent>(v9);
        };
    }

    public fun has_tag(arg0: &0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::Party, arg1: 0x1::string::String) : bool {
        let v0 = TagsKey{dummy_field: false};
        0x3a8db4338b58e7967347d233ba0bb1fd92092b782a55f561f69084e787a280be::typed_set::contains<TagsKey, 0x1::string::String>(0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::uid(arg0), v0, &arg1)
    }

    public fun has_tags(arg0: &0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::Party) : bool {
        let v0 = TagsKey{dummy_field: false};
        0x3a8db4338b58e7967347d233ba0bb1fd92092b782a55f561f69084e787a280be::typed_set::exists<TagsKey>(0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::uid(arg0), v0)
    }

    public fun remove_tag(arg0: &mut 0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::Party, arg1: &0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::PartyAdminCap, arg2: 0x1::string::String) {
        let v0 = 0x2::object::id<0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::Party>(arg0);
        let v1 = 0x2::object::id<0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::PartyAdminCap>(arg1);
        let v2 = TagsKey{dummy_field: false};
        0x3a8db4338b58e7967347d233ba0bb1fd92092b782a55f561f69084e787a280be::typed_set::remove<TagsKey, 0x1::string::String>(0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::uid_mut(arg0, arg1), v2, arg2);
        let v3 = TagsKey{dummy_field: false};
        let v4 = 0x3a8db4338b58e7967347d233ba0bb1fd92092b782a55f561f69084e787a280be::typed_set::keys<TagsKey, 0x1::string::String>(0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::uid(arg0), v3);
        let v5 = 0x1::vector::length<0x1::string::String>(&v4);
        let v6 = TagRemovedEvent{
            party_id         : 0x2::object::id_to_address(&v0),
            admin_cap_id     : 0x2::object::id_to_address(&v1),
            tag              : *0x1::string::as_bytes(&arg2),
            tag_count_before : v5 + 1,
            tag_count_after  : v5,
        };
        0x2::event::emit<TagRemovedEvent>(v6);
    }

    public fun tags(arg0: &0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::Party) : vector<0x1::string::String> {
        let v0 = TagsKey{dummy_field: false};
        0x3a8db4338b58e7967347d233ba0bb1fd92092b782a55f561f69084e787a280be::typed_set::keys<TagsKey, 0x1::string::String>(0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::uid(arg0), v0)
    }

    // decompiled from Move bytecode v7
}

