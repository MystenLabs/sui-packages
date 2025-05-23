module 0xc2d1ee8262aaaa8b3849c12627e72625365b9c28289edc1595d82aa1668d0b72::display {
    struct DisplayRegistry has store, key {
        id: 0x2::object::UID,
        displays: 0x2::vec_map::VecMap<0x1::string::String, 0x2::object::ID>,
    }

    public fun init_piname_ownership_display(arg0: &mut 0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"collection"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"PiNS Name Ownership."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyNTYiIGhlaWdodD0iMjU2Ij4KICA8cmVjdCB3aWR0aD0iMjU2IiBoZWlnaHQ9IjI1NiIgZmlsbD0iIzBjNiIvPgogIDx0ZXh0IHg9IjE2IiB5PSI2NCIgZm9udC1mYW1pbHk9IkFyaWFsIiBmb250LXNpemU9IjY0IiBmb250LXdlaWdodD0iYm9sZCIgZmlsbD0iI2ZmZiI+UGlOUzwvdGV4dD4KPC9zdmc+"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"PiNS collection by privasui.xyz"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Privasui"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://privasui.xyz"));
        let v4 = 0x2::display::new_with_fields<0xc2d1ee8262aaaa8b3849c12627e72625365b9c28289edc1595d82aa1668d0b72::name::PiNameOwnership>(arg0, v0, v2, arg1);
        0x2::display::update_version<0xc2d1ee8262aaaa8b3849c12627e72625365b9c28289edc1595d82aa1668d0b72::name::PiNameOwnership>(&mut v4);
        0x2::transfer::public_transfer<0x2::display::Display<0xc2d1ee8262aaaa8b3849c12627e72625365b9c28289edc1595d82aa1668d0b72::name::PiNameOwnership>>(v4, 0x2::tx_context::sender(arg1));
        0x2::object::id<0x2::display::Display<0xc2d1ee8262aaaa8b3849c12627e72625365b9c28289edc1595d82aa1668d0b72::name::PiNameOwnership>>(&v4)
    }

    public fun initialize(arg0: &mut 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::Registry, arg1: &mut 0x2::package::Publisher, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = DisplayRegistry{
            id       : 0x2::object::new(arg2),
            displays : 0x2::vec_map::empty<0x1::string::String, 0x2::object::ID>(),
        };
        0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::add<DisplayRegistry>(arg0, v0);
        insert_display(arg0, 0x1::string::utf8(b"pins_display_id"), init_piname_ownership_display(arg1, arg2));
    }

    public fun insert_display(arg0: &mut 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::Registry, arg1: 0x1::string::String, arg2: 0x2::object::ID) {
        let v0 = 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::borrow_mut<DisplayRegistry>(arg0);
        if (!0x2::vec_map::contains<0x1::string::String, 0x2::object::ID>(&v0.displays, &arg1)) {
            0x2::vec_map::insert<0x1::string::String, 0x2::object::ID>(&mut v0.displays, arg1, arg2);
        };
    }

    // decompiled from Move bytecode v6
}

