module 0xdf87ec097d3791bf30f3cb529816963122a924ab008659458ee6d693ea51e4b8::profiles {
    struct ProfileStorage has key {
        id: 0x2::object::UID,
        profiles: 0x2::table::Table<address, Profile>,
    }

    struct Profile has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image: 0x1::string::String,
        address: address,
    }

    public fun admin_update_profile(arg0: &0xdf87ec097d3791bf30f3cb529816963122a924ab008659458ee6d693ea51e4b8::options::OptionsStorage, arg1: &mut ProfileStorage, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        0xdf87ec097d3791bf30f3cb529816963122a924ab008659458ee6d693ea51e4b8::options::assert_is_admin(arg0, arg5);
        if (0x2::table::contains<address, Profile>(&arg1.profiles, v0)) {
            let v1 = 0x2::table::borrow_mut<address, Profile>(&mut arg1.profiles, v0);
            v1.name = 0x1::string::utf8(arg2);
            v1.description = 0x1::string::utf8(arg3);
            v1.image = 0x1::string::utf8(arg4);
        };
    }

    public(friend) fun create_profile_storage(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ProfileStorage{
            id       : 0x2::object::new(arg0),
            profiles : 0x2::table::new<address, Profile>(arg0),
        };
        0x2::transfer::share_object<ProfileStorage>(v0);
    }

    public fun get_profile(arg0: &ProfileStorage, arg1: address) : (0x1::string::String, 0x1::string::String, 0x1::string::String, address) {
        let v0 = 0x2::table::borrow<address, Profile>(&arg0.profiles, arg1);
        (v0.name, v0.description, v0.image, v0.address)
    }

    public fun update_profile(arg0: &mut ProfileStorage, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        if (0x2::table::contains<address, Profile>(&arg0.profiles, v0)) {
            let v1 = 0x2::table::borrow_mut<address, Profile>(&mut arg0.profiles, v0);
            v1.name = 0x1::string::utf8(arg1);
            v1.description = 0x1::string::utf8(arg2);
            v1.image = 0x1::string::utf8(arg3);
        } else {
            let v2 = Profile{
                id          : 0x2::object::new(arg4),
                name        : 0x1::string::utf8(arg1),
                description : 0x1::string::utf8(arg2),
                image       : 0x1::string::utf8(arg3),
                address     : v0,
            };
            0x2::table::add<address, Profile>(&mut arg0.profiles, v0, v2);
        };
    }

    // decompiled from Move bytecode v6
}

