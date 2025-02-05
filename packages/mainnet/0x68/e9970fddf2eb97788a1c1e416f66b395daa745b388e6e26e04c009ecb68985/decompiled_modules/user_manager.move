module 0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::user_manager {
    struct UserManager has store {
        relations: 0x2::table::Table<address, UserRelation>,
    }

    struct UserRelation has store, key {
        id: 0x2::object::UID,
        friends: 0x2::table::Table<address, FriendInfo>,
        friend_requests_received: 0x2::table::Table<address, FriendRequestInfo>,
    }

    struct FriendInfo has drop, store {
        friend_since: u64,
    }

    struct FriendRequestInfo has drop, store {
        dummy_field: bool,
    }

    struct FriendRequestEvent has copy, drop {
        from: address,
        to: address,
        action: 0x1::string::String,
    }

    public fun new(arg0: &0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::app::AdminCap, arg1: &mut 0x2::tx_context::TxContext) : UserManager {
        UserManager{relations: 0x2::table::new<address, UserRelation>(arg1)}
    }

    public fun accept_friend_request(arg0: &mut 0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::app::GilderApp, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::blacklist::assert_not_banned(arg0, 0x2::tx_context::sender(arg3));
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = get_or_create_relation_mut(arg0, arg3);
        0x2::table::remove<address, FriendRequestInfo>(&mut v2.friend_requests_received, arg1);
        let v3 = FriendInfo{friend_since: v1};
        0x2::table::add<address, FriendInfo>(&mut v2.friends, arg1, v3);
        let v4 = FriendInfo{friend_since: v1};
        0x2::table::add<address, FriendInfo>(&mut 0x2::table::borrow_mut<address, UserRelation>(&mut 0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::app::app_object_mut<0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::version::UserManagerV2, UserManager>(arg0).relations, arg1).friends, v0, v4);
        let v5 = FriendRequestEvent{
            from   : v0,
            to     : arg1,
            action : 0x1::string::utf8(b"accept"),
        };
        0x2::event::emit<FriendRequestEvent>(v5);
    }

    public fun can_send_friend_request(arg0: &mut 0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::app::GilderApp, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : bool {
        0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::blacklist::assert_not_banned(arg0, 0x2::tx_context::sender(arg2));
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = get_or_create_relation(arg0, arg2);
        if (v0 != arg1) {
            if (!0x2::table::contains<address, FriendInfo>(&v1.friends, arg1)) {
                if (!0x2::table::contains<address, FriendRequestInfo>(&get_or_create_relation_from_address(arg0, arg1, arg2).friend_requests_received, v0)) {
                    !0x2::table::contains<address, FriendRequestInfo>(&v1.friend_requests_received, arg1)
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun create_friend_request(arg0: &mut 0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::app::GilderApp, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::blacklist::assert_not_banned(arg0, 0x2::tx_context::sender(arg2));
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(can_send_friend_request(arg0, arg1, arg2), 100);
        let v1 = FriendRequestInfo{dummy_field: false};
        0x2::table::add<address, FriendRequestInfo>(&mut 0x2::table::borrow_mut<address, UserRelation>(&mut 0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::app::app_object_mut<0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::version::UserManagerV2, UserManager>(arg0).relations, arg1).friend_requests_received, v0, v1);
        let v2 = FriendRequestEvent{
            from   : v0,
            to     : arg1,
            action : 0x1::string::utf8(b"request"),
        };
        0x2::event::emit<FriendRequestEvent>(v2);
    }

    public fun create_relation(arg0: &mut 0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::app::GilderApp, arg1: &mut 0x2::tx_context::TxContext) {
        0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::blacklist::assert_not_banned(arg0, 0x2::tx_context::sender(arg1));
        let v0 = 0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::app::app_object_mut<0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::version::UserManagerV2, UserManager>(arg0);
        internal_create_relation(v0, arg1);
    }

    public fun get_friend_info(arg0: &mut 0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::app::GilderApp, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : &FriendInfo {
        0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::blacklist::assert_not_banned(arg0, 0x2::tx_context::sender(arg2));
        0x2::table::borrow<address, FriendInfo>(&get_or_create_relation(arg0, arg2).friends, arg1)
    }

    fun get_or_create_relation(arg0: &mut 0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::app::GilderApp, arg1: &mut 0x2::tx_context::TxContext) : &UserRelation {
        let v0 = 0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::app::app_object_mut<0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::version::UserManagerV2, UserManager>(arg0);
        let v1 = 0x2::tx_context::sender(arg1);
        if (!0x2::table::contains<address, UserRelation>(&v0.relations, v1)) {
            internal_create_relation(v0, arg1);
        };
        0x2::table::borrow<address, UserRelation>(&v0.relations, v1)
    }

    fun get_or_create_relation_from_address(arg0: &mut 0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::app::GilderApp, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : &UserRelation {
        let v0 = 0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::app::app_object_mut<0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::version::UserManagerV2, UserManager>(arg0);
        if (!0x2::table::contains<address, UserRelation>(&v0.relations, arg1)) {
            let v1 = UserRelation{
                id                       : 0x2::object::new(arg2),
                friends                  : 0x2::table::new<address, FriendInfo>(arg2),
                friend_requests_received : 0x2::table::new<address, FriendRequestInfo>(arg2),
            };
            0x2::table::add<address, UserRelation>(&mut v0.relations, arg1, v1);
        };
        0x2::table::borrow<address, UserRelation>(&v0.relations, arg1)
    }

    fun get_or_create_relation_mut(arg0: &mut 0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::app::GilderApp, arg1: &mut 0x2::tx_context::TxContext) : &mut UserRelation {
        let v0 = 0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::app::app_object_mut<0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::version::UserManagerV2, UserManager>(arg0);
        let v1 = 0x2::tx_context::sender(arg1);
        if (!0x2::table::contains<address, UserRelation>(&v0.relations, v1)) {
            internal_create_relation(v0, arg1);
        };
        0x2::table::borrow_mut<address, UserRelation>(&mut v0.relations, v1)
    }

    fun internal_create_relation(arg0: &mut UserManager, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = UserRelation{
            id                       : 0x2::object::new(arg1),
            friends                  : 0x2::table::new<address, FriendInfo>(arg1),
            friend_requests_received : 0x2::table::new<address, FriendRequestInfo>(arg1),
        };
        0x2::table::add<address, UserRelation>(&mut arg0.relations, 0x2::tx_context::sender(arg1), v0);
    }

    public fun reject_friend_request(arg0: &mut 0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::app::GilderApp, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::blacklist::assert_not_banned(arg0, 0x2::tx_context::sender(arg2));
        let v0 = 0x2::tx_context::sender(arg2);
        0x2::table::remove<address, FriendRequestInfo>(&mut get_or_create_relation_mut(arg0, arg2).friend_requests_received, arg1);
        let v1 = FriendRequestEvent{
            from   : v0,
            to     : arg1,
            action : 0x1::string::utf8(b"reject"),
        };
        0x2::event::emit<FriendRequestEvent>(v1);
    }

    public fun remove_friend(arg0: &mut 0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::app::GilderApp, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::blacklist::assert_not_banned(arg0, 0x2::tx_context::sender(arg2));
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = get_or_create_relation_mut(arg0, arg2);
        0x2::table::remove<address, FriendInfo>(&mut v1.friends, arg1);
        0x2::table::remove<address, FriendInfo>(&mut 0x2::table::borrow_mut<address, UserRelation>(&mut 0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::app::app_object_mut<0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::version::UserManagerV2, UserManager>(arg0).relations, arg1).friends, v0);
        let v2 = FriendRequestEvent{
            from   : v0,
            to     : arg1,
            action : 0x1::string::utf8(b"remove"),
        };
        0x2::event::emit<FriendRequestEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

