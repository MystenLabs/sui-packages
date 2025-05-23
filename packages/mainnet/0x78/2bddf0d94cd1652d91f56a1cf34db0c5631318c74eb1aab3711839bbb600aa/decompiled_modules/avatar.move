module 0x782bddf0d94cd1652d91f56a1cf34db0c5631318c74eb1aab3711839bbb600aa::avatar {
    struct Avatar has store, key {
        id: 0x2::object::UID,
        image: 0x1::string::String,
        owner: address,
        name: 0x1::string::String,
        description: 0x1::string::String,
        creator: 0x1::string::String,
        project_url: 0x1::string::String,
        collection_id: 0x2::object::ID,
        collection: 0x1::string::String,
    }

    fun assert_args(arg0: &0x1::string::String, arg1: &vector<u8>) {
        assert!(0x1::string::length(arg0) <= 128, 0x782bddf0d94cd1652d91f56a1cf34db0c5631318c74eb1aab3711839bbb600aa::errors::ENameTooLong());
        assert!(0x1::vector::length<u8>(arg1) <= 65536, 0x782bddf0d94cd1652d91f56a1cf34db0c5631318c74eb1aab3711839bbb600aa::errors::EAvatarTooLarge());
    }

    public fun create_avatar(arg0: &mut 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::Registry, arg1: 0x1::string::String, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : Avatar {
        assert_args(&arg1, &arg2);
        let v0 = 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::borrow_mut<0x782bddf0d94cd1652d91f56a1cf34db0c5631318c74eb1aab3711839bbb600aa::avatar_collection::AvatarCollection>(arg0);
        0x782bddf0d94cd1652d91f56a1cf34db0c5631318c74eb1aab3711839bbb600aa::avatar_collection::increment_avatar_count(v0);
        Avatar{
            id            : 0x2::object::new(arg3),
            image         : 0x1::string::utf8(arg2),
            owner         : 0x2::tx_context::sender(arg3),
            name          : arg1,
            description   : 0x1::string::utf8(b"Privasui Avatar"),
            creator       : 0x1::string::utf8(b"Privasui"),
            project_url   : 0x1::string::utf8(b"https://privasui.xyz"),
            collection_id : 0x782bddf0d94cd1652d91f56a1cf34db0c5631318c74eb1aab3711839bbb600aa::avatar_collection::get_id(v0),
            collection    : 0x782bddf0d94cd1652d91f56a1cf34db0c5631318c74eb1aab3711839bbb600aa::avatar_collection::get_name(v0),
        }
    }

    public fun get_id(arg0: &Avatar) : 0x2::object::ID {
        0x2::object::id<Avatar>(arg0)
    }

    // decompiled from Move bytecode v6
}

