module 0xb908f3c6fea6865d32e2048c520cdfe3b5c5bbcebb658117c41bad70f52b7ccc::claynosaurz_nft {
    struct Claynosaurz has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
        project_url: 0x1::string::String,
        creator: 0x1::string::String,
        key: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct ClaynosaurzMinted has copy, drop {
        claynosaurz_id: 0x2::object::ID,
        key: 0x1::string::String,
    }

    struct ClaynosaurzTransferred has copy, drop {
        claynosaurz_id: 0x2::object::ID,
        from: address,
        to: address,
    }

    struct ClaynosaurzBurned has copy, drop {
        claynosaurz_id: 0x2::object::ID,
        key: 0x1::string::String,
    }

    struct ClaynosaurzUpdated has copy, drop {
        claynosaurz_id: 0x2::object::ID,
        new_name: 0x1::string::String,
        new_image_url: 0x1::string::String,
        new_description: 0x1::string::String,
        new_project_url: 0x1::string::String,
        new_creator: 0x1::string::String,
        new_key: 0x1::string::String,
        new_attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    public fun transfer(arg0: &0xb908f3c6fea6865d32e2048c520cdfe3b5c5bbcebb658117c41bad70f52b7ccc::registry::PlayerRegistry, arg1: Claynosaurz, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0xb908f3c6fea6865d32e2048c520cdfe3b5c5bbcebb658117c41bad70f52b7ccc::registry::validate_player_registry_version(arg0);
        assert!(0xb908f3c6fea6865d32e2048c520cdfe3b5c5bbcebb658117c41bad70f52b7ccc::registry::is_player(arg0, arg2), 1);
        let v0 = ClaynosaurzTransferred{
            claynosaurz_id : 0x2::object::uid_to_inner(&arg1.id),
            from           : 0x2::tx_context::sender(arg3),
            to             : arg2,
        };
        0x2::event::emit<ClaynosaurzTransferred>(v0);
        0x2::transfer::transfer<Claynosaurz>(arg1, arg2);
    }

    public fun attributes(arg0: &Claynosaurz) : 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        arg0.attributes
    }

    public fun burn(arg0: Claynosaurz) {
        let Claynosaurz {
            id          : v0,
            name        : _,
            image_url   : _,
            description : _,
            project_url : _,
            creator     : _,
            key         : v6,
            attributes  : _,
        } = arg0;
        let v8 = v0;
        let v9 = ClaynosaurzBurned{
            claynosaurz_id : 0x2::object::uid_to_inner(&v8),
            key            : v6,
        };
        0x2::event::emit<ClaynosaurzBurned>(v9);
        0x2::object::delete(v8);
    }

    public fun creator(arg0: &Claynosaurz) : 0x1::string::String {
        arg0.creator
    }

    public fun description(arg0: &Claynosaurz) : 0x1::string::String {
        arg0.description
    }

    public fun id(arg0: &Claynosaurz) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun image_url(arg0: &Claynosaurz) : 0x1::string::String {
        arg0.image_url
    }

    public fun key(arg0: &Claynosaurz) : 0x1::string::String {
        arg0.key
    }

    public fun mint(arg0: &0xb908f3c6fea6865d32e2048c520cdfe3b5c5bbcebb658117c41bad70f52b7ccc::registry::WhiteListMintRegistry, arg1: address, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg9: &mut 0x2::tx_context::TxContext) {
        0xb908f3c6fea6865d32e2048c520cdfe3b5c5bbcebb658117c41bad70f52b7ccc::registry::validate_whitelist_version(arg0);
        assert!(0xb908f3c6fea6865d32e2048c520cdfe3b5c5bbcebb658117c41bad70f52b7ccc::registry::is_whitelisted(arg0, 0x2::tx_context::sender(arg9)), 0);
        let v0 = 0x2::object::new(arg9);
        let v1 = ClaynosaurzMinted{
            claynosaurz_id : 0x2::object::uid_to_inner(&v0),
            key            : arg7,
        };
        0x2::event::emit<ClaynosaurzMinted>(v1);
        let v2 = Claynosaurz{
            id          : v0,
            name        : arg2,
            image_url   : arg3,
            description : arg4,
            project_url : arg5,
            creator     : arg6,
            key         : arg7,
            attributes  : arg8,
        };
        0x2::transfer::transfer<Claynosaurz>(v2, arg1);
    }

    public fun name(arg0: &Claynosaurz) : 0x1::string::String {
        arg0.name
    }

    public fun project_url(arg0: &Claynosaurz) : 0x1::string::String {
        arg0.project_url
    }

    public fun update_claynosaurz(arg0: &0xb908f3c6fea6865d32e2048c520cdfe3b5c5bbcebb658117c41bad70f52b7ccc::registry::Registry, arg1: &mut Claynosaurz, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::clock::Clock) {
        0xb908f3c6fea6865d32e2048c520cdfe3b5c5bbcebb658117c41bad70f52b7ccc::registry::validate_registry_version(arg0);
        let v0 = 0xb908f3c6fea6865d32e2048c520cdfe3b5c5bbcebb658117c41bad70f52b7ccc::registry::admin_public_key(arg0);
        assert!(0x2::ed25519::ed25519_verify(&arg3, &v0, &arg2), 2);
        let v1 = 0x2::bcs::new(arg2);
        let v2 = 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v1));
        let v3 = 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v1));
        let v4 = 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v1));
        let v5 = 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v1));
        let v6 = 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v1));
        let v7 = 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v1));
        assert!(0x2::clock::timestamp_ms(arg4) < 0x2::bcs::peel_u64(&mut v1), 4);
        assert!(id(arg1) == 0x2::object::id_from_address(0x2::bcs::peel_address(&mut v1)), 5);
        let v8 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        let v9 = 0;
        while (v9 < 0x2::bcs::peel_u64(&mut v1)) {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v8, 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v1)), 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v1)));
            v9 = v9 + 1;
        };
        let v10 = 0x2::bcs::into_remainder_bytes(v1);
        assert!(0x1::vector::length<u8>(&v10) == 0, 3);
        arg1.name = v2;
        arg1.image_url = v3;
        arg1.description = v4;
        arg1.project_url = v5;
        arg1.creator = v6;
        arg1.key = v7;
        arg1.attributes = v8;
        let v11 = ClaynosaurzUpdated{
            claynosaurz_id  : 0x2::object::uid_to_inner(&arg1.id),
            new_name        : v2,
            new_image_url   : v3,
            new_description : v4,
            new_project_url : v5,
            new_creator     : v6,
            new_key         : v7,
            new_attributes  : v8,
        };
        0x2::event::emit<ClaynosaurzUpdated>(v11);
    }

    // decompiled from Move bytecode v6
}

