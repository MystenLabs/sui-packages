module 0x7678b7c0f852144d393d00c92f633a99c154597c9d1c4b39827e57bc30043807::registry {
    struct RootIdRegistry has key {
        id: 0x2::object::UID,
        users: 0x2::table::Table<0x1::string::String, NftCard>,
        addressToName: 0x2::table::Table<address, 0x1::string::String>,
    }

    struct NftCard has store, key {
        id: 0x2::object::UID,
        walletAddress: address,
        current: ProfileData,
        history: vector<ProfileData>,
        templates: vector<ProfileData>,
    }

    struct ProfileData has copy, drop, store {
        name: 0x1::string::String,
        bio: 0x1::string::String,
        image: 0x1::string::String,
        theme: Theme,
        links: vector<Link>,
        socialLinks: vector<SocialLink>,
    }

    struct Theme has copy, drop, store {
        backgroundColor: 0x1::string::String,
        textColor: 0x1::string::String,
        buttonColor: 0x1::string::String,
        buttonTextColor: 0x1::string::String,
        socialIconBg: 0x1::string::String,
        socialIconColor: 0x1::string::String,
    }

    struct Link has copy, drop, store {
        id: 0x1::string::String,
        title: 0x1::string::String,
        url: 0x1::string::String,
    }

    struct SocialLink has copy, drop, store {
        id: 0x1::string::String,
        platform: 0x1::string::String,
        url: 0x1::string::String,
        iconName: 0x1::string::String,
    }

    public fun addUser(arg0: &mut RootIdRegistry, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: vector<0x1::string::String>, arg11: vector<0x1::string::String>, arg12: vector<0x1::string::String>, arg13: vector<0x1::string::String>, arg14: vector<0x1::string::String>, arg15: vector<0x1::string::String>, arg16: vector<0x1::string::String>, arg17: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::table::contains<0x1::string::String, NftCard>(&arg0.users, arg1), 1);
        let v0 = Theme{
            backgroundColor : arg4,
            textColor       : arg5,
            buttonColor     : arg6,
            buttonTextColor : arg7,
            socialIconBg    : arg8,
            socialIconColor : arg9,
        };
        let v1 = 0x1::vector::empty<Link>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::string::String>(&arg10)) {
            let v3 = Link{
                id    : *0x1::vector::borrow<0x1::string::String>(&arg10, v2),
                title : *0x1::vector::borrow<0x1::string::String>(&arg11, v2),
                url   : *0x1::vector::borrow<0x1::string::String>(&arg12, v2),
            };
            0x1::vector::push_back<Link>(&mut v1, v3);
            v2 = v2 + 1;
        };
        let v4 = 0x1::vector::empty<SocialLink>();
        let v5 = 0;
        while (v5 < 0x1::vector::length<0x1::string::String>(&arg13)) {
            let v6 = SocialLink{
                id       : *0x1::vector::borrow<0x1::string::String>(&arg13, v5),
                platform : *0x1::vector::borrow<0x1::string::String>(&arg14, v5),
                url      : *0x1::vector::borrow<0x1::string::String>(&arg15, v5),
                iconName : *0x1::vector::borrow<0x1::string::String>(&arg16, v5),
            };
            0x1::vector::push_back<SocialLink>(&mut v4, v6);
            v5 = v5 + 1;
        };
        let v7 = ProfileData{
            name        : arg1,
            bio         : arg2,
            image       : arg3,
            theme       : v0,
            links       : v1,
            socialLinks : v4,
        };
        let v8 = 0x2::tx_context::sender(arg17);
        let v9 = NftCard{
            id            : 0x2::object::new(arg17),
            walletAddress : v8,
            current       : v7,
            history       : 0x1::vector::empty<ProfileData>(),
            templates     : 0x1::vector::empty<ProfileData>(),
        };
        0x2::table::add<0x1::string::String, NftCard>(&mut arg0.users, arg1, v9);
        if (!0x2::table::contains<address, 0x1::string::String>(&arg0.addressToName, v8)) {
            0x2::table::add<address, 0x1::string::String>(&mut arg0.addressToName, v8, arg1);
        };
    }

    public(friend) fun add_template(arg0: &mut RootIdRegistry, arg1: 0x1::string::String, arg2: ProfileData) {
        assert!(0x2::table::contains<0x1::string::String, NftCard>(&arg0.users, arg1), 0);
        0x1::vector::push_back<ProfileData>(&mut 0x2::table::borrow_mut<0x1::string::String, NftCard>(&mut arg0.users, arg1).templates, arg2);
    }

    public fun get_profile(arg0: &RootIdRegistry, arg1: 0x1::string::String) : ProfileData {
        assert!(0x2::table::contains<0x1::string::String, NftCard>(&arg0.users, arg1), 0);
        0x2::table::borrow<0x1::string::String, NftCard>(&arg0.users, arg1).current
    }

    public fun get_template_for_listing(arg0: &RootIdRegistry, arg1: 0x1::string::String) : ProfileData {
        assert!(0x2::table::contains<0x1::string::String, NftCard>(&arg0.users, arg1), 0);
        0x2::table::borrow<0x1::string::String, NftCard>(&arg0.users, arg1).current
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RootIdRegistry{
            id            : 0x2::object::new(arg0),
            users         : 0x2::table::new<0x1::string::String, NftCard>(arg0),
            addressToName : 0x2::table::new<address, 0x1::string::String>(arg0),
        };
        0x2::transfer::share_object<RootIdRegistry>(v0);
    }

    public fun updateUser(arg0: &mut RootIdRegistry, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: vector<0x1::string::String>, arg11: vector<0x1::string::String>, arg12: vector<0x1::string::String>, arg13: vector<0x1::string::String>, arg14: vector<0x1::string::String>, arg15: vector<0x1::string::String>, arg16: vector<0x1::string::String>, arg17: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::string::String, NftCard>(&arg0.users, arg1), 0);
        let v0 = 0x2::table::borrow_mut<0x1::string::String, NftCard>(&mut arg0.users, arg1);
        0x1::vector::push_back<ProfileData>(&mut v0.history, v0.current);
        let v1 = Theme{
            backgroundColor : arg4,
            textColor       : arg5,
            buttonColor     : arg6,
            buttonTextColor : arg7,
            socialIconBg    : arg8,
            socialIconColor : arg9,
        };
        let v2 = 0x1::vector::empty<Link>();
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x1::string::String>(&arg10)) {
            let v4 = Link{
                id    : *0x1::vector::borrow<0x1::string::String>(&arg10, v3),
                title : *0x1::vector::borrow<0x1::string::String>(&arg11, v3),
                url   : *0x1::vector::borrow<0x1::string::String>(&arg12, v3),
            };
            0x1::vector::push_back<Link>(&mut v2, v4);
            v3 = v3 + 1;
        };
        let v5 = 0x1::vector::empty<SocialLink>();
        let v6 = 0;
        while (v6 < 0x1::vector::length<0x1::string::String>(&arg13)) {
            let v7 = SocialLink{
                id       : *0x1::vector::borrow<0x1::string::String>(&arg13, v6),
                platform : *0x1::vector::borrow<0x1::string::String>(&arg14, v6),
                url      : *0x1::vector::borrow<0x1::string::String>(&arg15, v6),
                iconName : *0x1::vector::borrow<0x1::string::String>(&arg16, v6),
            };
            0x1::vector::push_back<SocialLink>(&mut v5, v7);
            v6 = v6 + 1;
        };
        let v8 = ProfileData{
            name        : arg1,
            bio         : arg2,
            image       : arg3,
            theme       : v1,
            links       : v2,
            socialLinks : v5,
        };
        v0.current = v8;
    }

    // decompiled from Move bytecode v6
}

