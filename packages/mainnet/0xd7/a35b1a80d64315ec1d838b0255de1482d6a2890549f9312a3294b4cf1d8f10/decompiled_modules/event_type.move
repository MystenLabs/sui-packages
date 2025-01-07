module 0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::event_type {
    struct IRL has drop {
        dummy_field: bool,
    }

    struct Podcast has drop {
        dummy_field: bool,
    }

    struct Article has drop {
        dummy_field: bool,
    }

    struct Video has drop {
        dummy_field: bool,
    }

    struct Album has drop {
        dummy_field: bool,
    }

    struct Soundtrack has drop {
        dummy_field: bool,
    }

    struct Merch has drop {
        dummy_field: bool,
    }

    public fun album() : 0x1::type_name::TypeName {
        0x1::type_name::get<Album>()
    }

    public fun all() : vector<0x1::type_name::TypeName> {
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<IRL>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<Podcast>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<Article>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<Video>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<Album>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<Soundtrack>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<Merch>());
        v0
    }

    public fun article() : 0x1::type_name::TypeName {
        0x1::type_name::get<Article>()
    }

    public fun irl() : 0x1::type_name::TypeName {
        0x1::type_name::get<IRL>()
    }

    public fun merch() : 0x1::type_name::TypeName {
        0x1::type_name::get<Merch>()
    }

    public fun podcast() : 0x1::type_name::TypeName {
        0x1::type_name::get<Podcast>()
    }

    public fun soundtrack() : 0x1::type_name::TypeName {
        0x1::type_name::get<Soundtrack>()
    }

    public fun video() : 0x1::type_name::TypeName {
        0x1::type_name::get<Video>()
    }

    // decompiled from Move bytecode v6
}

