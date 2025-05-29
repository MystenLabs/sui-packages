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

    struct ClaynosaurzBurned has copy, drop {
        claynosaurz_id: 0x2::object::ID,
        key: 0x1::string::String,
    }

    public fun transfer(arg0: &0xb908f3c6fea6865d32e2048c520cdfe3b5c5bbcebb658117c41bad70f52b7ccc::registry::PlayerRegistry, arg1: Claynosaurz, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xb908f3c6fea6865d32e2048c520cdfe3b5c5bbcebb658117c41bad70f52b7ccc::registry::is_player(arg0, arg2), 1);
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

    // decompiled from Move bytecode v6
}

