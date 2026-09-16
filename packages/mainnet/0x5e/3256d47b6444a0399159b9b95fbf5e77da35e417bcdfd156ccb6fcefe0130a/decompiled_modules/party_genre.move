module 0x5e3256d47b6444a0399159b9b95fbf5e77da35e417bcdfd156ccb6fcefe0130a::party_genre {
    struct GenresKey has copy, drop, store {
        dummy_field: bool,
    }

    struct GenreAddedEvent has copy, drop {
        party_id: address,
        admin_cap_id: address,
        genre_id: address,
        genre_name: vector<u8>,
        genre_count_before: u64,
        genre_count_after: u64,
        max_genres: u64,
    }

    struct GenreRemovedEvent has copy, drop {
        party_id: address,
        admin_cap_id: address,
        genre_id: address,
        genre_count_before: u64,
        genre_count_after: u64,
    }

    struct GenresClearedEvent has copy, drop {
        party_id: address,
        admin_cap_id: address,
        genre_count_before: u64,
        genre_count_after: u64,
        genre_ids_before: vector<address>,
    }

    public fun add_genre(arg0: &mut 0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::Party, arg1: &0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::PartyAdminCap, arg2: &0x793da2359ac24b204174ea37440b2cbb42c34f989320a84e48a504ec8a0e3dcc::genre::Genre) {
        let v0 = 0x2::object::id<0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::Party>(arg0);
        let v1 = 0x2::object::id<0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::PartyAdminCap>(arg1);
        let v2 = 0x2::object::id<0x793da2359ac24b204174ea37440b2cbb42c34f989320a84e48a504ec8a0e3dcc::genre::Genre>(arg2);
        let v3 = 0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::uid_mut(arg0, arg1);
        let v4 = GenresKey{dummy_field: false};
        let v5 = 0x3a8db4338b58e7967347d233ba0bb1fd92092b782a55f561f69084e787a280be::typed_set::keys<GenresKey, 0x2::object::ID>(v3, v4);
        let v6 = GenresKey{dummy_field: false};
        0x3a8db4338b58e7967347d233ba0bb1fd92092b782a55f561f69084e787a280be::typed_set::add<GenresKey, 0x2::object::ID>(v3, v6, v2, 20);
        let v7 = GenresKey{dummy_field: false};
        let v8 = 0x3a8db4338b58e7967347d233ba0bb1fd92092b782a55f561f69084e787a280be::typed_set::keys<GenresKey, 0x2::object::ID>(v3, v7);
        let v9 = GenreAddedEvent{
            party_id           : 0x2::object::id_to_address(&v0),
            admin_cap_id       : 0x2::object::id_to_address(&v1),
            genre_id           : 0x2::object::id_to_address(&v2),
            genre_name         : *0x1::string::as_bytes(0x793da2359ac24b204174ea37440b2cbb42c34f989320a84e48a504ec8a0e3dcc::genre::name(arg2)),
            genre_count_before : 0x1::vector::length<0x2::object::ID>(&v5),
            genre_count_after  : 0x1::vector::length<0x2::object::ID>(&v8),
            max_genres         : 20,
        };
        0x2::event::emit<GenreAddedEvent>(v9);
    }

    public fun clear_genres(arg0: &mut 0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::Party, arg1: &0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::PartyAdminCap) {
        let v0 = 0x2::object::id<0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::Party>(arg0);
        let v1 = 0x2::object::id<0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::PartyAdminCap>(arg1);
        let v2 = 0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::uid_mut(arg0, arg1);
        let v3 = GenresKey{dummy_field: false};
        if (0x3a8db4338b58e7967347d233ba0bb1fd92092b782a55f561f69084e787a280be::typed_set::exists<GenresKey>(v2, v3)) {
            let v4 = GenresKey{dummy_field: false};
            let v5 = 0x3a8db4338b58e7967347d233ba0bb1fd92092b782a55f561f69084e787a280be::typed_set::keys<GenresKey, 0x2::object::ID>(v2, v4);
            let v6 = GenresKey{dummy_field: false};
            let v7 = vector[];
            let v8 = 0x3a8db4338b58e7967347d233ba0bb1fd92092b782a55f561f69084e787a280be::typed_set::keys<GenresKey, 0x2::object::ID>(v2, v6);
            0x1::vector::reverse<0x2::object::ID>(&mut v8);
            let v9 = 0;
            while (v9 < 0x1::vector::length<0x2::object::ID>(&v8)) {
                let v10 = 0x1::vector::pop_back<0x2::object::ID>(&mut v8);
                0x1::vector::push_back<address>(&mut v7, 0x2::object::id_to_address(&v10));
                v9 = v9 + 1;
            };
            0x1::vector::destroy_empty<0x2::object::ID>(v8);
            let v11 = GenresKey{dummy_field: false};
            0x3a8db4338b58e7967347d233ba0bb1fd92092b782a55f561f69084e787a280be::typed_set::clear<GenresKey, 0x2::object::ID>(v2, v11);
            let v12 = GenresKey{dummy_field: false};
            let v13 = 0x3a8db4338b58e7967347d233ba0bb1fd92092b782a55f561f69084e787a280be::typed_set::keys<GenresKey, 0x2::object::ID>(v2, v12);
            let v14 = GenresClearedEvent{
                party_id           : 0x2::object::id_to_address(&v0),
                admin_cap_id       : 0x2::object::id_to_address(&v1),
                genre_count_before : 0x1::vector::length<0x2::object::ID>(&v5),
                genre_count_after  : 0x1::vector::length<0x2::object::ID>(&v13),
                genre_ids_before   : v7,
            };
            0x2::event::emit<GenresClearedEvent>(v14);
        };
    }

    public fun genres(arg0: &0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::Party) : vector<0x2::object::ID> {
        let v0 = GenresKey{dummy_field: false};
        0x3a8db4338b58e7967347d233ba0bb1fd92092b782a55f561f69084e787a280be::typed_set::keys<GenresKey, 0x2::object::ID>(0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::uid(arg0), v0)
    }

    public fun has_genre(arg0: &0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::Party, arg1: 0x2::object::ID) : bool {
        let v0 = GenresKey{dummy_field: false};
        0x3a8db4338b58e7967347d233ba0bb1fd92092b782a55f561f69084e787a280be::typed_set::contains<GenresKey, 0x2::object::ID>(0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::uid(arg0), v0, &arg1)
    }

    public fun has_genres(arg0: &0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::Party) : bool {
        let v0 = GenresKey{dummy_field: false};
        0x3a8db4338b58e7967347d233ba0bb1fd92092b782a55f561f69084e787a280be::typed_set::exists<GenresKey>(0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::uid(arg0), v0)
    }

    public fun remove_genre(arg0: &mut 0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::Party, arg1: &0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::PartyAdminCap, arg2: 0x2::object::ID) {
        let v0 = 0x2::object::id<0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::Party>(arg0);
        let v1 = 0x2::object::id<0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::PartyAdminCap>(arg1);
        let v2 = 0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::uid_mut(arg0, arg1);
        let v3 = GenresKey{dummy_field: false};
        let v4 = 0x3a8db4338b58e7967347d233ba0bb1fd92092b782a55f561f69084e787a280be::typed_set::keys<GenresKey, 0x2::object::ID>(v2, v3);
        let v5 = GenresKey{dummy_field: false};
        0x3a8db4338b58e7967347d233ba0bb1fd92092b782a55f561f69084e787a280be::typed_set::remove<GenresKey, 0x2::object::ID>(v2, v5, arg2);
        let v6 = GenresKey{dummy_field: false};
        let v7 = 0x3a8db4338b58e7967347d233ba0bb1fd92092b782a55f561f69084e787a280be::typed_set::keys<GenresKey, 0x2::object::ID>(v2, v6);
        let v8 = GenreRemovedEvent{
            party_id           : 0x2::object::id_to_address(&v0),
            admin_cap_id       : 0x2::object::id_to_address(&v1),
            genre_id           : 0x2::object::id_to_address(&arg2),
            genre_count_before : 0x1::vector::length<0x2::object::ID>(&v4),
            genre_count_after  : 0x1::vector::length<0x2::object::ID>(&v7),
        };
        0x2::event::emit<GenreRemovedEvent>(v8);
    }

    // decompiled from Move bytecode v7
}

