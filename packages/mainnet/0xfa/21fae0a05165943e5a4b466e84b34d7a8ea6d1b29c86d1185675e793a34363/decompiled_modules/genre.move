module 0xfa21fae0a05165943e5a4b466e84b34d7a8ea6d1b29c86d1185675e793a34363::genre {
    struct Genre has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
    }

    struct GenreRegistry has key {
        id: 0x2::object::UID,
    }

    struct GenreKey has copy, drop, store {
        pos0: 0x1::string::String,
    }

    struct GenreCreatedEvent has copy, drop {
        genre_id: 0x2::object::ID,
        name: 0x1::string::String,
    }

    public fun derive_address(arg0: &GenreRegistry, arg1: 0x1::string::String) : address {
        let v0 = GenreKey{pos0: arg1};
        0x2::derived_object::derive_address<GenreKey>(0x2::object::uid_to_inner(&arg0.id), v0)
    }

    public fun new(arg0: &mut GenreRegistry, arg1: 0x1::string::String) : Genre {
        assert!(!0x1::string::is_empty(&arg1), 0);
        assert!(0x1::string::length(&arg1) <= 64, 1);
        let v0 = true;
        let v1 = v0;
        let v2 = 0x1::string::as_bytes(&arg1);
        let v3 = 0;
        while (v3 < 0x1::vector::length<u8>(v2)) {
            let v4 = 0x1::vector::borrow<u8>(v2, v3);
            let v5 = *v4 == 95;
            assert!(v5 || *v4 >= 65 && *v4 <= 90, 2);
            let v6 = v5 && v0;
            assert!(!v6, 3);
            v1 = v5;
            v3 = v3 + 1;
        };
        assert!(!v1, 3);
        let v7 = GenreKey{pos0: arg1};
        let v8 = Genre{
            id   : 0x2::derived_object::claim<GenreKey>(&mut arg0.id, v7),
            name : arg1,
        };
        let v9 = GenreCreatedEvent{
            genre_id : 0x2::object::id<Genre>(&v8),
            name     : arg1,
        };
        0x2::event::emit<GenreCreatedEvent>(v9);
        v8
    }

    public fun freeze_genre(arg0: Genre) {
        0x2::transfer::freeze_object<Genre>(arg0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GenreRegistry{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<GenreRegistry>(v0);
    }

    public fun name(arg0: &Genre) : &0x1::string::String {
        &arg0.name
    }

    // decompiled from Move bytecode v7
}

