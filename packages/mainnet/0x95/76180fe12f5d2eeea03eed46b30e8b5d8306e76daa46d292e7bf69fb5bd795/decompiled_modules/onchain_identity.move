module 0x9576180fe12f5d2eeea03eed46b30e8b5d8306e76daa46d292e7bf69fb5bd795::onchain_identity {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct UserProfile has key {
        id: 0x2::object::UID,
        user_address: address,
        name: 0x1::string::String,
        bio: 0x1::option::Option<0x1::string::String>,
        twitter_handle: 0x1::option::Option<0x1::string::String>,
    }

    public entry fun change_bio(arg0: &mut UserProfile, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.user_address, 0);
        0x1::option::swap_or_fill<0x1::string::String>(&mut arg0.bio, 0x1::string::utf8(arg1));
    }

    public entry fun create_profile(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = UserProfile{
            id             : 0x2::object::new(arg1),
            user_address   : 0x2::tx_context::sender(arg1),
            name           : 0x1::string::utf8(arg0),
            bio            : 0x1::option::none<0x1::string::String>(),
            twitter_handle : 0x1::option::none<0x1::string::String>(),
        };
        0x2::transfer::transfer<UserProfile>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun delete_profile(arg0: &AdminCap, arg1: UserProfile) {
        let UserProfile {
            id             : v0,
            user_address   : _,
            name           : _,
            bio            : _,
            twitter_handle : _,
        } = arg1;
        0x2::object::delete(v0);
    }

    // decompiled from Move bytecode v6
}

