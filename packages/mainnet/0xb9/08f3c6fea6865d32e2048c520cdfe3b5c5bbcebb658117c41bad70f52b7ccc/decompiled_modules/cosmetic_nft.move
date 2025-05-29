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

    public fun transfer(arg0: &0xb908f3c6fea6865d32e2048c520cdfe3b5c5bbcebb658117c41bad70f52b7ccc::registry::PlayerRegistry, arg1: Cosmetic, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xb908f3c6fea6865d32e2048c520cdfe3b5c5bbcebb658117c41bad70f52b7ccc::registry::is_player(arg0, arg2), 1);
        0x2::transfer::transfer<Cosmetic>(arg1, arg2);
    }

    public fun attributes(arg0: &Cosmetic) : 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        arg0.attributes
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

    // decompiled from Move bytecode v6
}

