module 0x782bddf0d94cd1652d91f56a1cf34db0c5631318c74eb1aab3711839bbb600aa::display {
    struct DisplayRegistry has store, key {
        id: 0x2::object::UID,
        displays: 0x2::vec_map::VecMap<0x1::string::String, 0x2::object::ID>,
    }

    public fun init_avatar_display(arg0: &mut 0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"data:image/svg+xml;base64,{image}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{creator}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{project_url}"));
        let v4 = 0x2::display::new_with_fields<0x782bddf0d94cd1652d91f56a1cf34db0c5631318c74eb1aab3711839bbb600aa::avatar::Avatar>(arg0, v0, v2, arg1);
        0x2::display::update_version<0x782bddf0d94cd1652d91f56a1cf34db0c5631318c74eb1aab3711839bbb600aa::avatar::Avatar>(&mut v4);
        0x2::transfer::public_transfer<0x2::display::Display<0x782bddf0d94cd1652d91f56a1cf34db0c5631318c74eb1aab3711839bbb600aa::avatar::Avatar>>(v4, 0x2::tx_context::sender(arg1));
        0x2::object::id<0x2::display::Display<0x782bddf0d94cd1652d91f56a1cf34db0c5631318c74eb1aab3711839bbb600aa::avatar::Avatar>>(&v4)
    }

    public fun init_collection_display(arg0: &mut 0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMDAiIGhlaWdodD0iMTAwIj48cmVjdCB3aWR0aD0iMjAwIiBoZWlnaHQ9IjEwMCIgZmlsbD0iIzExMSIgcng9IjEwIiByeT0iMTAiLz48dGV4dCB4PSIxMDAiIHk9IjYwIiBmb250LWZhbWlseT0iQXJpYWwiIGZvbnQtc2l6ZT0iMjQiIGZvbnQtd2VpZ2h0PSJib2xkIiBmaWxsPSIjMDBjYzY2IiB0ZXh0LWFuY2hvcj0ibWlkZGxlIj5Qcml2YXN1aTwvdGV4dD48L3N2Zz4="));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{creator}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{project_url}"));
        let v4 = 0x2::display::new_with_fields<0x782bddf0d94cd1652d91f56a1cf34db0c5631318c74eb1aab3711839bbb600aa::avatar_collection::AvatarCollection>(arg0, v0, v2, arg1);
        0x2::display::update_version<0x782bddf0d94cd1652d91f56a1cf34db0c5631318c74eb1aab3711839bbb600aa::avatar_collection::AvatarCollection>(&mut v4);
        0x2::transfer::public_transfer<0x2::display::Display<0x782bddf0d94cd1652d91f56a1cf34db0c5631318c74eb1aab3711839bbb600aa::avatar_collection::AvatarCollection>>(v4, 0x2::tx_context::sender(arg1));
        0x2::object::id<0x2::display::Display<0x782bddf0d94cd1652d91f56a1cf34db0c5631318c74eb1aab3711839bbb600aa::avatar_collection::AvatarCollection>>(&v4)
    }

    public fun initialize(arg0: &mut 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::Registry, arg1: &mut 0x2::package::Publisher, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = DisplayRegistry{
            id       : 0x2::object::new(arg2),
            displays : 0x2::vec_map::empty<0x1::string::String, 0x2::object::ID>(),
        };
        0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::add<DisplayRegistry>(arg0, v0);
        let v1 = init_collection_display(arg1, arg2);
        insert_display(arg0, 0x1::string::utf8(b"display_avatar_collection_id"), v1);
        insert_display(arg0, 0x1::string::utf8(b"display_avatar_id"), init_avatar_display(arg1, arg2));
    }

    public fun insert_display(arg0: &mut 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::Registry, arg1: 0x1::string::String, arg2: 0x2::object::ID) {
        let v0 = 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::borrow_mut<DisplayRegistry>(arg0);
        if (!0x2::vec_map::contains<0x1::string::String, 0x2::object::ID>(&v0.displays, &arg1)) {
            0x2::vec_map::insert<0x1::string::String, 0x2::object::ID>(&mut v0.displays, arg1, arg2);
        };
    }

    // decompiled from Move bytecode v6
}

