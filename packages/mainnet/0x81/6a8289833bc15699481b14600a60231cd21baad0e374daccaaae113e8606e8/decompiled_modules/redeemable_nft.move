module 0xb908f3c6fea6865d32e2048c520cdfe3b5c5bbcebb658117c41bad70f52b7ccc::redeemable_nft {
    struct Redeemable has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        link: 0x1::string::String,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
        project_url: 0x1::string::String,
        creator: 0x1::string::String,
        key: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct RedeemableMinted has copy, drop {
        nft_id: 0x2::object::ID,
        key: 0x1::string::String,
    }

    struct RedeemableBurned has copy, drop {
        nft_id: 0x2::object::ID,
        key: 0x1::string::String,
    }

    public fun attributes(arg0: &Redeemable) : 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        arg0.attributes
    }

    public fun burn(arg0: Redeemable) {
        let Redeemable {
            id          : v0,
            name        : _,
            link        : _,
            image_url   : _,
            description : _,
            project_url : _,
            creator     : _,
            key         : v7,
            attributes  : _,
        } = arg0;
        let v9 = v0;
        let v10 = RedeemableBurned{
            nft_id : 0x2::object::uid_to_inner(&v9),
            key    : v7,
        };
        0x2::event::emit<RedeemableBurned>(v10);
        0x2::object::delete(v9);
    }

    public fun creator(arg0: &Redeemable) : 0x1::string::String {
        arg0.creator
    }

    public fun description(arg0: &Redeemable) : 0x1::string::String {
        arg0.description
    }

    public fun id(arg0: &Redeemable) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun image_url(arg0: &Redeemable) : 0x1::string::String {
        arg0.image_url
    }

    public fun key(arg0: &Redeemable) : 0x1::string::String {
        arg0.key
    }

    public fun link(arg0: &Redeemable) : 0x1::string::String {
        arg0.link
    }

    public fun mint(arg0: &0xb908f3c6fea6865d32e2048c520cdfe3b5c5bbcebb658117c41bad70f52b7ccc::registry::WhiteListMintRegistry, arg1: address, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg10: &mut 0x2::tx_context::TxContext) {
        0xb908f3c6fea6865d32e2048c520cdfe3b5c5bbcebb658117c41bad70f52b7ccc::registry::validate_whitelist_version(arg0);
        assert!(0xb908f3c6fea6865d32e2048c520cdfe3b5c5bbcebb658117c41bad70f52b7ccc::registry::is_whitelisted(arg0, 0x2::tx_context::sender(arg10)), 0);
        let v0 = 0x2::object::new(arg10);
        let v1 = RedeemableMinted{
            nft_id : 0x2::object::uid_to_inner(&v0),
            key    : arg8,
        };
        0x2::event::emit<RedeemableMinted>(v1);
        let v2 = Redeemable{
            id          : v0,
            name        : arg2,
            link        : arg3,
            image_url   : arg4,
            description : arg5,
            project_url : arg6,
            creator     : arg7,
            key         : arg8,
            attributes  : arg9,
        };
        0x2::transfer::transfer<Redeemable>(v2, arg1);
    }

    public fun name(arg0: &Redeemable) : 0x1::string::String {
        arg0.name
    }

    public fun project_url(arg0: &Redeemable) : 0x1::string::String {
        arg0.project_url
    }

    // decompiled from Move bytecode v6
}

