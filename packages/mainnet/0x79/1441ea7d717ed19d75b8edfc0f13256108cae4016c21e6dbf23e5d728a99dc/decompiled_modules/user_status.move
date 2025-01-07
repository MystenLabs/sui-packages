module 0x791441ea7d717ed19d75b8edfc0f13256108cae4016c21e6dbf23e5d728a99dc::user_status {
    struct UserStatus has key {
        id: 0x2::object::UID,
        allStatus: 0x2::vec_map::VecMap<address, vector<0x791441ea7d717ed19d75b8edfc0f13256108cae4016c21e6dbf23e5d728a99dc::social_bottle::BlobInfo>>,
        relations: 0x2::vec_map::VecMap<address, vector<address>>,
    }

    struct PublishStatusEvent has copy, drop {
        account: address,
        current_user_status: vector<0x791441ea7d717ed19d75b8edfc0f13256108cae4016c21e6dbf23e5d728a99dc::social_bottle::BlobInfo>,
    }

    struct BecomeFriendsEvent has copy, drop {
        me: address,
        new_friend: address,
    }

    public entry fun becomeFriends(arg0: address, arg1: &mut UserStatus, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 != 0x2::tx_context::sender(arg2), 2);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x1::vector::empty<address>();
        if (0x2::vec_map::contains<address, vector<address>>(&arg1.relations, &v0)) {
            let v2 = 0x2::tx_context::sender(arg2);
            let (_, v4) = 0x2::vec_map::remove<address, vector<address>>(&mut arg1.relations, &v2);
            v1 = v4;
            assert!(!0x1::vector::contains<address>(&v1, &arg0), 3);
        };
        0x1::vector::push_back<address>(&mut v1, arg0);
        0x2::vec_map::insert<address, vector<address>>(&mut arg1.relations, 0x2::tx_context::sender(arg2), v1);
        let v5 = BecomeFriendsEvent{
            me         : 0x2::tx_context::sender(arg2),
            new_friend : arg0,
        };
        0x2::event::emit<BecomeFriendsEvent>(v5);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = UserStatus{
            id        : 0x2::object::new(arg0),
            allStatus : 0x2::vec_map::empty<address, vector<0x791441ea7d717ed19d75b8edfc0f13256108cae4016c21e6dbf23e5d728a99dc::social_bottle::BlobInfo>>(),
            relations : 0x2::vec_map::empty<address, vector<address>>(),
        };
        0x2::transfer::share_object<UserStatus>(v0);
    }

    public fun publishStatus(arg0: &mut UserStatus, arg1: vector<0x1::string::String>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!0x1::vector::is_empty<0x1::string::String>(&arg1), 0);
        assert!(0x1::vector::length<0x1::string::String>(&arg1) == 0x1::vector::length<address>(&arg2), 1);
        let v0 = 0x1::vector::empty<0x791441ea7d717ed19d75b8edfc0f13256108cae4016c21e6dbf23e5d728a99dc::social_bottle::BlobInfo>();
        let v1 = 0x2::tx_context::sender(arg3);
        if (0x2::vec_map::contains<address, vector<0x791441ea7d717ed19d75b8edfc0f13256108cae4016c21e6dbf23e5d728a99dc::social_bottle::BlobInfo>>(&arg0.allStatus, &v1)) {
            let v2 = 0x2::tx_context::sender(arg3);
            let (_, v4) = 0x2::vec_map::remove<address, vector<0x791441ea7d717ed19d75b8edfc0f13256108cae4016c21e6dbf23e5d728a99dc::social_bottle::BlobInfo>>(&mut arg0.allStatus, &v2);
            v0 = v4;
        };
        0x1::vector::append<0x791441ea7d717ed19d75b8edfc0f13256108cae4016c21e6dbf23e5d728a99dc::social_bottle::BlobInfo>(&mut v0, 0x791441ea7d717ed19d75b8edfc0f13256108cae4016c21e6dbf23e5d728a99dc::social_bottle::createBlobInfos(arg1, arg2));
        let v5 = PublishStatusEvent{
            account             : 0x2::tx_context::sender(arg3),
            current_user_status : v0,
        };
        0x2::event::emit<PublishStatusEvent>(v5);
        0x2::vec_map::insert<address, vector<0x791441ea7d717ed19d75b8edfc0f13256108cae4016c21e6dbf23e5d728a99dc::social_bottle::BlobInfo>>(&mut arg0.allStatus, 0x2::tx_context::sender(arg3), v0);
    }

    public fun queryFriendStatus(arg0: address, arg1: &UserStatus, arg2: &0x2::tx_context::TxContext) : vector<0x791441ea7d717ed19d75b8edfc0f13256108cae4016c21e6dbf23e5d728a99dc::social_bottle::BlobInfo> {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::vec_map::try_get<address, vector<address>>(&arg1.relations, &v0);
        let v2 = 0x1::option::is_some<vector<address>>(&v1) && 0x1::vector::contains<address>(0x1::option::borrow<vector<address>>(&v1), &arg0);
        if (!v2) {
            return 0x1::vector::empty<0x791441ea7d717ed19d75b8edfc0f13256108cae4016c21e6dbf23e5d728a99dc::social_bottle::BlobInfo>()
        };
        *0x2::vec_map::get<address, vector<0x791441ea7d717ed19d75b8edfc0f13256108cae4016c21e6dbf23e5d728a99dc::social_bottle::BlobInfo>>(&arg1.allStatus, &arg0)
    }

    // decompiled from Move bytecode v6
}

