module 0x9b663c476982aaacaeb641cd67ca661d8b1fc672fed0aa424a0cef3408e876d::genre {
    struct GENRE has drop {
        dummy_field: bool,
    }

    struct GenreRegistry has key {
        id: 0x2::object::UID,
    }

    struct GenreRegistryCap has store, key {
        id: 0x2::object::UID,
    }

    struct Genre has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
    }

    struct GenreKey has copy, drop, store {
        pos0: 0x1::string::String,
    }

    struct GenreCreatedEvent has copy, drop {
        genre_id: 0x2::object::ID,
        name: 0x1::string::String,
    }

    public fun new(arg0: &GenreRegistryCap, arg1: &mut GenreRegistry, arg2: 0x1::string::String) {
        assert!(!0x1::string::is_empty(&arg2), 20);
        assert!(0x1::string::length(&arg2) <= 64, 21);
        let v0 = 0x1::string::as_bytes(&arg2);
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<u8>(v0)) {
            let v3 = 0x1::vector::borrow<u8>(v0, v1);
            let v4 = *v3 >= 65 && *v3 <= 90 || *v3 == 95;
            if (!v4) {
                v2 = false;
                /* label 17 */
                assert!(v2, 22);
                let v5 = GenreKey{pos0: arg2};
                let v6 = Genre{
                    id   : 0x2::derived_object::claim<GenreKey>(&mut arg1.id, v5),
                    name : 0x1::string::utf8(*0x1::string::as_bytes(&arg2)),
                };
                let v7 = GenreCreatedEvent{
                    genre_id : id(&v6),
                    name     : *name(&v6),
                };
                0x2::event::emit<GenreCreatedEvent>(v7);
                0x2::transfer::freeze_object<Genre>(v6);
                return
            };
            v1 = v1 + 1;
        };
        v2 = true;
        /* goto 17 */
    }

    public fun derive_genre_id(arg0: &GenreRegistry, arg1: 0x1::string::String) : 0x2::object::ID {
        let v0 = GenreKey{pos0: arg1};
        0x2::object::id_from_address(0x2::derived_object::derive_address<GenreKey>(0x2::object::uid_to_inner(&arg0.id), v0))
    }

    public fun id(arg0: &Genre) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    fun init(arg0: GENRE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = GenreRegistry{id: 0x2::object::new(arg1)};
        0x2::transfer::share_object<GenreRegistry>(v0);
        let v1 = GenreRegistryCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<GenreRegistryCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun name(arg0: &Genre) : &0x1::string::String {
        &arg0.name
    }

    // decompiled from Move bytecode v7
}

