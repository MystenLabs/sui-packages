module 0x793da2359ac24b204174ea37440b2cbb42c34f989320a84e48a504ec8a0e3dcc::genre {
    struct GenreRegistry has key {
        id: 0x2::object::UID,
    }

    struct Genre has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
    }

    struct GenreKey has copy, drop, store {
        pos0: 0x1::string::String,
    }

    struct GenreRegistryCreatedEvent has copy, drop {
        registry_id: address,
        initializer: address,
        is_shared: bool,
    }

    struct GenreCreatedEvent has copy, drop {
        registry_id: address,
        genre_id: address,
        name: vector<u8>,
        is_frozen: bool,
    }

    public fun derive_address(arg0: &GenreRegistry, arg1: 0x1::string::String) : address {
        let v0 = GenreKey{pos0: arg1};
        0x2::derived_object::derive_address<GenreKey>(0x2::object::uid_to_inner(&arg0.id), v0)
    }

    public fun new(arg0: &mut GenreRegistry, arg1: 0x1::string::String) {
        assert!(!0x1::string::is_empty(&arg1), 20);
        assert!(0x1::string::length(&arg1) <= 64, 21);
        let v0 = 0x1::string::as_bytes(&arg1);
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<u8>(v0)) {
            let v3 = 0x1::vector::borrow<u8>(v0, v1);
            let v4 = *v3 >= 65 && *v3 <= 90 || *v3 == 95;
            if (!v4) {
                v2 = false;
                /* label 18 */
                assert!(v2, 22);
                let v5 = GenreKey{pos0: arg1};
                let v6 = Genre{
                    id   : 0x2::derived_object::claim<GenreKey>(&mut arg0.id, v5),
                    name : 0x1::string::utf8(*0x1::string::as_bytes(&arg1)),
                };
                0x2::transfer::freeze_object<Genre>(v6);
                let v7 = GenreCreatedEvent{
                    registry_id : 0x2::object::id_address<GenreRegistry>(arg0),
                    genre_id    : 0x2::object::id_address<Genre>(&v6),
                    name        : *0x1::string::as_bytes(name(&v6)),
                    is_frozen   : true,
                };
                0x2::event::emit<GenreCreatedEvent>(v7);
                return
            };
            v1 = v1 + 1;
        };
        v2 = true;
        /* goto 18 */
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GenreRegistry{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<GenreRegistry>(v0);
        let v1 = GenreRegistryCreatedEvent{
            registry_id : 0x2::object::id_address<GenreRegistry>(&v0),
            initializer : 0x2::tx_context::sender(arg0),
            is_shared   : true,
        };
        0x2::event::emit<GenreRegistryCreatedEvent>(v1);
    }

    public fun name(arg0: &Genre) : &0x1::string::String {
        &arg0.name
    }

    // decompiled from Move bytecode v7
}

