module 0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::display {
    struct DisplayRegistry has store, key {
        id: 0x2::object::UID,
        displays: 0x2::vec_map::VecMap<0x1::string::String, 0x2::object::ID>,
    }

    public fun init_pim_stream_display(arg0: &mut 0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"My PiM Stream"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Encrypted PiM stream for conversation"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyNTYiIGhlaWdodD0iMjU2Ij4KICA8IS0tIFNvbGlkIGdyZWVuIGJhY2tncm91bmQsIHNoYXJwIGNvcm5lcnMgLS0+CiAgPHJlY3Qgd2lkdGg9IjI1NiIgaGVpZ2h0PSIyNTYiIGZpbGw9IiMwYzYiLz4KICA8IS0tIFRvcC1sZWZ0IGxhYmVsIC0tPgogIDx0ZXh0IHg9IjE2IiB5PSI0OCIgZm9udC1mYW1pbHk9IkFyaWFsIiBmb250LXNpemU9IjQyIiBmb250LXdlaWdodD0iYm9sZCIgZmlsbD0iI2ZmZiI+UHJpdmFzdWk8L3RleHQ+CiAgICA8dGV4dCB4PSIxNiIgeT0iMTA4IiBmb250LWZhbWlseT0iQXJpYWwiIGZvbnQtc2l6ZT0iMzYiIGZvbnQtd2VpZ2h0PSJib2xkIiBmaWxsPSIjZmZmIj5TdHJlYW08L3RleHQ+Cjwvc3ZnPg=="));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"PiM Streams"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Privasui"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://privasui.xyz"));
        let v4 = 0x2::display::new_with_fields<0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::stream::Stream<0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::chat::Message>>(arg0, v0, v2, arg1);
        0x2::display::update_version<0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::stream::Stream<0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::chat::Message>>(&mut v4);
        0x2::transfer::public_transfer<0x2::display::Display<0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::stream::Stream<0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::chat::Message>>>(v4, 0x2::tx_context::sender(arg1));
        0x2::object::id<0x2::display::Display<0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::stream::Stream<0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::chat::Message>>>(&v4)
    }

    public fun initialize(arg0: &mut 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::Registry, arg1: &mut 0x2::package::Publisher, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = DisplayRegistry{
            id       : 0x2::object::new(arg2),
            displays : 0x2::vec_map::empty<0x1::string::String, 0x2::object::ID>(),
        };
        0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::add<DisplayRegistry>(arg0, v0);
        insert_display(arg0, 0x1::string::utf8(b"pim_stream_display_id"), init_pim_stream_display(arg1, arg2));
    }

    public fun insert_display(arg0: &mut 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::Registry, arg1: 0x1::string::String, arg2: 0x2::object::ID) {
        let v0 = 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::borrow_mut<DisplayRegistry>(arg0);
        if (!0x2::vec_map::contains<0x1::string::String, 0x2::object::ID>(&v0.displays, &arg1)) {
            0x2::vec_map::insert<0x1::string::String, 0x2::object::ID>(&mut v0.displays, arg1, arg2);
        };
    }

    // decompiled from Move bytecode v6
}

