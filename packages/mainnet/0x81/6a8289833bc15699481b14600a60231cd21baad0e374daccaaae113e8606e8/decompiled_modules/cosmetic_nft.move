module 0xb908f3c6fea6865d32e2048c520cdfe3b5c5bbcebb658117c41bad70f52b7ccc::cosmetic_nft {
    struct Cosmetic has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
        project_url: 0x1::string::String,
        creator: 0x1::string::String,
        key: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct CosmeticMinted has copy, drop {
        cosmetic_id: 0x2::object::ID,
        key: 0x1::string::String,
    }

    struct CosmeticTransferred has copy, drop {
        cosmetic_id: 0x2::object::ID,
        from: address,
        to: address,
    }

    struct CosmeticBurned has copy, drop {
        cosmetic_id: 0x2::object::ID,
        key: 0x1::string::String,
    }

    struct CosmeticUpdated has copy, drop {
        cosmetic_id: 0x2::object::ID,
    }

    public fun transfer(arg0: &0xb908f3c6fea6865d32e2048c520cdfe3b5c5bbcebb658117c41bad70f52b7ccc::registry::PlayerRegistry, arg1: Cosmetic, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xb908f3c6fea6865d32e2048c520cdfe3b5c5bbcebb658117c41bad70f52b7ccc::registry::is_player(arg0, arg2), 1);
        let v0 = CosmeticTransferred{
            cosmetic_id : 0x2::object::uid_to_inner(&arg1.id),
            from        : 0x2::tx_context::sender(arg3),
            to          : arg2,
        };
        0x2::event::emit<CosmeticTransferred>(v0);
        0xb908f3c6fea6865d32e2048c520cdfe3b5c5bbcebb658117c41bad70f52b7ccc::registry::validate_player_registry_version(arg0);
        0x2::transfer::transfer<Cosmetic>(arg1, arg2);
    }

    public fun attributes(arg0: &Cosmetic) : 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        arg0.attributes
    }

    public fun burn(arg0: Cosmetic) {
        let Cosmetic {
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
        let v9 = CosmeticBurned{
            cosmetic_id : 0x2::object::uid_to_inner(&v8),
            key         : v6,
        };
        0x2::event::emit<CosmeticBurned>(v9);
        0x2::object::delete(v8);
    }

    public fun creator(arg0: &Cosmetic) : 0x1::string::String {
        arg0.creator
    }

    public fun description(arg0: &Cosmetic) : 0x1::string::String {
        arg0.description
    }

    public fun id(arg0: &Cosmetic) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun image_url(arg0: &Cosmetic) : 0x1::string::String {
        arg0.image_url
    }

    public fun key(arg0: &Cosmetic) : 0x1::string::String {
        arg0.key
    }

    public fun mint(arg0: &0xb908f3c6fea6865d32e2048c520cdfe3b5c5bbcebb658117c41bad70f52b7ccc::registry::WhiteListMintRegistry, arg1: address, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg9: &mut 0x2::tx_context::TxContext) {
        0xb908f3c6fea6865d32e2048c520cdfe3b5c5bbcebb658117c41bad70f52b7ccc::registry::validate_whitelist_version(arg0);
        assert!(0xb908f3c6fea6865d32e2048c520cdfe3b5c5bbcebb658117c41bad70f52b7ccc::registry::is_whitelisted(arg0, 0x2::tx_context::sender(arg9)), 0);
        let v0 = 0x2::object::new(arg9);
        let v1 = CosmeticMinted{
            cosmetic_id : 0x2::object::uid_to_inner(&v0),
            key         : arg7,
        };
        0x2::event::emit<CosmeticMinted>(v1);
        let v2 = Cosmetic{
            id          : v0,
            name        : arg2,
            image_url   : arg3,
            description : arg4,
            project_url : arg5,
            creator     : arg6,
            key         : arg7,
            attributes  : arg8,
        };
        0x2::transfer::transfer<Cosmetic>(v2, arg1);
    }

    public fun name(arg0: &Cosmetic) : 0x1::string::String {
        arg0.name
    }

    public fun project_url(arg0: &Cosmetic) : 0x1::string::String {
        arg0.project_url
    }

    public fun update_cosmetic(arg0: &0xb908f3c6fea6865d32e2048c520cdfe3b5c5bbcebb658117c41bad70f52b7ccc::registry::Registry, arg1: &mut Cosmetic, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::clock::Clock) {
        0xb908f3c6fea6865d32e2048c520cdfe3b5c5bbcebb658117c41bad70f52b7ccc::registry::validate_registry_version(arg0);
        let v0 = 0xb908f3c6fea6865d32e2048c520cdfe3b5c5bbcebb658117c41bad70f52b7ccc::registry::admin_public_key(arg0);
        assert!(0x2::ed25519::ed25519_verify(&arg3, &v0, &arg2), 2);
        let v1 = 0x2::bcs::new(arg2);
        assert!(0x2::clock::timestamp_ms(arg4) < 0x2::bcs::peel_u64(&mut v1), 4);
        assert!(id(arg1) == 0x2::object::id_from_address(0x2::bcs::peel_address(&mut v1)), 5);
        let v2 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        let v3 = 0;
        while (v3 < 0x2::bcs::peel_u64(&mut v1)) {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v2, 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v1)), 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v1)));
            v3 = v3 + 1;
        };
        let v4 = 0x2::bcs::into_remainder_bytes(v1);
        assert!(0x1::vector::length<u8>(&v4) == 0, 3);
        arg1.name = 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v1));
        arg1.image_url = 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v1));
        arg1.description = 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v1));
        arg1.project_url = 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v1));
        arg1.creator = 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v1));
        arg1.key = 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v1));
        arg1.attributes = v2;
        let v5 = CosmeticUpdated{cosmetic_id: 0x2::object::uid_to_inner(&arg1.id)};
        0x2::event::emit<CosmeticUpdated>(v5);
    }

    // decompiled from Move bytecode v6
}

