module 0xd438098fe8368939389d7bea35641b81273fed38ff44aeeb1c887ae8e4575609::platform_link {
    struct PlatformLink<T0: copy + drop + store> has copy, drop, store {
        data: T0,
    }

    struct PlatformLinkKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct PlatformLinkSetEvent<phantom T0> has copy, drop {
        parent_id: address,
        existed_before: bool,
        exists_after: bool,
    }

    struct PlatformLinkRemovedEvent<phantom T0> has copy, drop {
        parent_id: address,
        existed_before: bool,
        exists_after: bool,
    }

    public fun borrow<T0: copy + drop + store>(arg0: &0x2::object::UID) : &PlatformLink<T0> {
        let v0 = PlatformLinkKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists<PlatformLinkKey<T0>>(arg0, v0), 0);
        let v1 = PlatformLinkKey<T0>{dummy_field: false};
        0x2::dynamic_field::borrow<PlatformLinkKey<T0>, PlatformLink<T0>>(arg0, v1)
    }

    public fun remove<T0: copy + drop + store>(arg0: &mut 0x2::object::UID) : PlatformLink<T0> {
        let v0 = PlatformLinkKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists<PlatformLinkKey<T0>>(arg0, v0), 0);
        let v1 = PlatformLinkKey<T0>{dummy_field: false};
        let v2 = PlatformLinkRemovedEvent<T0>{
            parent_id      : 0x2::object::uid_to_address(arg0),
            existed_before : true,
            exists_after   : false,
        };
        0x2::event::emit<PlatformLinkRemovedEvent<T0>>(v2);
        0x2::dynamic_field::remove<PlatformLinkKey<T0>, PlatformLink<T0>>(arg0, v1)
    }

    public fun clear<T0: copy + drop + store>(arg0: &mut 0x2::object::UID) {
        let v0 = PlatformLinkKey<T0>{dummy_field: false};
        if (0x2::dynamic_field::exists<PlatformLinkKey<T0>>(arg0, v0)) {
            let v1 = PlatformLinkKey<T0>{dummy_field: false};
            0x2::dynamic_field::remove<PlatformLinkKey<T0>, PlatformLink<T0>>(arg0, v1);
            let v2 = PlatformLinkRemovedEvent<T0>{
                parent_id      : 0x2::object::uid_to_address(arg0),
                existed_before : true,
                exists_after   : false,
            };
            0x2::event::emit<PlatformLinkRemovedEvent<T0>>(v2);
        };
    }

    public fun data<T0: copy + drop + store>(arg0: &PlatformLink<T0>) : T0 {
        arg0.data
    }

    public fun exists_<T0: copy + drop + store>(arg0: &0x2::object::UID) : bool {
        let v0 = PlatformLinkKey<T0>{dummy_field: false};
        0x2::dynamic_field::exists<PlatformLinkKey<T0>>(arg0, v0)
    }

    public fun get<T0: copy + drop + store>(arg0: &0x2::object::UID) : 0x1::option::Option<PlatformLink<T0>> {
        let v0 = PlatformLinkKey<T0>{dummy_field: false};
        if (0x2::dynamic_field::exists<PlatformLinkKey<T0>>(arg0, v0)) {
            let v2 = PlatformLinkKey<T0>{dummy_field: false};
            0x1::option::some<PlatformLink<T0>>(*0x2::dynamic_field::borrow<PlatformLinkKey<T0>, PlatformLink<T0>>(arg0, v2))
        } else {
            0x1::option::none<PlatformLink<T0>>()
        }
    }

    public fun max_identifier_length() : u64 {
        256
    }

    public fun max_url_length() : u64 {
        2000
    }

    public fun new<T0: copy + drop + store>(arg0: T0) : PlatformLink<T0> {
        PlatformLink<T0>{data: arg0}
    }

    public fun set<T0: copy + drop + store>(arg0: &mut 0x2::object::UID, arg1: PlatformLink<T0>) {
        let v0 = PlatformLinkKey<T0>{dummy_field: false};
        if (0x2::dynamic_field::exists<PlatformLinkKey<T0>>(arg0, v0)) {
            let v1 = PlatformLinkKey<T0>{dummy_field: false};
            let v2 = PlatformLinkKey<T0>{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<PlatformLinkKey<T0>, PlatformLink<T0>>(arg0, v2) = arg1;
            if (0x2::dynamic_field::borrow<PlatformLinkKey<T0>, PlatformLink<T0>>(arg0, v1).data != arg1.data) {
                let v3 = PlatformLinkSetEvent<T0>{
                    parent_id      : 0x2::object::uid_to_address(arg0),
                    existed_before : true,
                    exists_after   : true,
                };
                0x2::event::emit<PlatformLinkSetEvent<T0>>(v3);
            };
        } else {
            let v4 = PlatformLinkKey<T0>{dummy_field: false};
            0x2::dynamic_field::add<PlatformLinkKey<T0>, PlatformLink<T0>>(arg0, v4, arg1);
            let v5 = PlatformLinkSetEvent<T0>{
                parent_id      : 0x2::object::uid_to_address(arg0),
                existed_before : false,
                exists_after   : true,
            };
            0x2::event::emit<PlatformLinkSetEvent<T0>>(v5);
        };
    }

    // decompiled from Move bytecode v7
}

