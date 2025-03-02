module 0xb8c681f9d2e0961726173f4dde1d692a9e67673c53359124fdba893bb51fa62c::profile {
    struct ProfileRegistry has key {
        id: 0x2::object::UID,
        profiles: 0x2::table::Table<address, UserProfile>,
        owner: address,
    }

    struct UserProfile has store, key {
        id: 0x2::object::UID,
        username: vector<u8>,
        display_name: vector<u8>,
        bio: vector<u8>,
        avatar_cid: vector<u8>,
        owner: address,
        kiosk_id: 0x1::option::Option<0x2::object::ID>,
    }

    public entry fun delete_profile(arg0: &mut ProfileRegistry, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::table::contains<address, UserProfile>(&arg0.profiles, v0), 4);
        let v1 = 0x2::table::remove<address, UserProfile>(&mut arg0.profiles, v0);
        assert!(v0 == v1.owner, 1);
        let UserProfile {
            id           : v2,
            username     : _,
            display_name : _,
            bio          : _,
            avatar_cid   : _,
            owner        : _,
            kiosk_id     : _,
        } = v1;
        0x2::object::delete(v2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ProfileRegistry{
            id       : 0x2::object::new(arg0),
            profiles : 0x2::table::new<address, UserProfile>(arg0),
            owner    : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<ProfileRegistry>(v0);
    }

    public entry fun link_kiosk(arg0: &mut ProfileRegistry, arg1: &0xb8c681f9d2e0961726173f4dde1d692a9e67673c53359124fdba893bb51fa62c::kiosk::UserKiosk, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, UserProfile>(&arg0.profiles, v0), 4);
        let v1 = 0x2::table::borrow_mut<address, UserProfile>(&mut arg0.profiles, v0);
        assert!(v0 == v1.owner, 1);
        assert!(0x1::option::is_none<0x2::object::ID>(&v1.kiosk_id), 2);
        assert!(v0 == 0xb8c681f9d2e0961726173f4dde1d692a9e67673c53359124fdba893bb51fa62c::kiosk::get_owner(arg1), 1);
        v1.kiosk_id = 0x1::option::some<0x2::object::ID>(0x2::object::id<0xb8c681f9d2e0961726173f4dde1d692a9e67673c53359124fdba893bb51fa62c::kiosk::UserKiosk>(arg1));
    }

    public entry fun register_profile(arg0: &mut ProfileRegistry, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(!0x2::table::contains<address, UserProfile>(&arg0.profiles, v0), 3);
        let v1 = UserProfile{
            id           : 0x2::object::new(arg5),
            username     : arg1,
            display_name : arg2,
            bio          : arg3,
            avatar_cid   : arg4,
            owner        : v0,
            kiosk_id     : 0x1::option::none<0x2::object::ID>(),
        };
        0x2::table::add<address, UserProfile>(&mut arg0.profiles, v0, v1);
    }

    public entry fun reset_profile(arg0: &mut ProfileRegistry, arg1: address, arg2: &0xb8c681f9d2e0961726173f4dde1d692a9e67673c53359124fdba893bb51fa62c::admin::AdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 1);
        assert!(0x2::table::contains<address, UserProfile>(&arg0.profiles, arg1), 4);
        let v0 = 0x2::table::borrow_mut<address, UserProfile>(&mut arg0.profiles, arg1);
        v0.display_name = 0x1::vector::empty<u8>();
        v0.bio = 0x1::vector::empty<u8>();
        v0.avatar_cid = 0x1::vector::empty<u8>();
        v0.kiosk_id = 0x1::option::none<0x2::object::ID>();
    }

    public entry fun update_profile(arg0: &mut ProfileRegistry, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::table::contains<address, UserProfile>(&arg0.profiles, v0), 4);
        let v1 = 0x2::table::borrow_mut<address, UserProfile>(&mut arg0.profiles, v0);
        assert!(v0 == v1.owner, 1);
        v1.display_name = arg1;
        v1.bio = arg2;
        v1.avatar_cid = arg3;
    }

    // decompiled from Move bytecode v6
}

