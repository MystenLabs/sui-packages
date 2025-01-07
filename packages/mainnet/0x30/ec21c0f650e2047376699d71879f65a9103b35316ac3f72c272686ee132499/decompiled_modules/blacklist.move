module 0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::blacklist {
    struct Blacklists has store {
        community: 0x2::table::Table<address, 0x2::table::Table<address, BanDetails>>,
        platform: 0x2::table::Table<address, BanDetails>,
    }

    struct BanDetails has store, key {
        id: 0x2::object::UID,
    }

    struct CommunityBanEvent has copy, drop {
        community_id: address,
        user_id: address,
        is_banned: bool,
    }

    struct PlatformBanEvent has copy, drop {
        user_id: address,
        is_banned: bool,
    }

    public fun new(arg0: &0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::app::AdminCap, arg1: &mut 0x2::tx_context::TxContext) : Blacklists {
        Blacklists{
            community : 0x2::table::new<address, 0x2::table::Table<address, BanDetails>>(arg1),
            platform  : 0x2::table::new<address, BanDetails>(arg1),
        }
    }

    public fun admin_ban_user(arg0: &mut 0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::app::GilderApp, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::app::assert_is_gilder_admin(arg0, 0x2::tx_context::sender(arg2));
        ban_user_app_wide(arg0, arg1, arg2);
    }

    public fun admin_unban_user(arg0: &mut 0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::app::GilderApp, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::app::assert_is_gilder_admin(arg0, 0x2::tx_context::sender(arg2));
        unban_user_app_wide(arg0, arg1);
    }

    public fun assert_not_banned(arg0: &0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::app::GilderApp, arg1: address) {
        assert!(!is_user_banned(arg0, arg1), 2);
    }

    public fun assert_not_banned_in_community(arg0: &mut 0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::app::GilderApp, arg1: address, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!is_user_banned(arg0, arg2), 2);
        assert!(!is_user_banned_from_community(arg0, arg1, arg2, arg3), 1);
    }

    public(friend) fun ban_user_app_wide(arg0: &mut 0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::app::GilderApp, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = PlatformBanEvent{
            user_id   : arg1,
            is_banned : true,
        };
        0x2::event::emit<PlatformBanEvent>(v0);
        let v1 = 0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::app::app_object_mut<0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::version::BlacklistV1, Blacklists>(arg0);
        assert!(!0x2::table::contains<address, BanDetails>(&v1.platform, arg1), 2);
        0x2::table::add<address, BanDetails>(&mut v1.platform, arg1, create_ban_details(arg2));
    }

    public(friend) fun ban_user_from_community(arg0: &mut 0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::app::GilderApp, arg1: address, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = CommunityBanEvent{
            community_id : arg1,
            user_id      : arg2,
            is_banned    : true,
        };
        0x2::event::emit<CommunityBanEvent>(v0);
        let v1 = create_ban_details(arg3);
        let v2 = 0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::app::app_object_mut<0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::version::BlacklistV1, Blacklists>(arg0);
        let v3 = get_or_create_community(v2, arg1, arg3);
        assert!(!0x2::table::contains<address, BanDetails>(v3, arg2), 1);
        0x2::table::add<address, BanDetails>(v3, arg2, v1);
    }

    fun create_ban_details(arg0: &mut 0x2::tx_context::TxContext) : BanDetails {
        let v0 = BanDetails{id: 0x2::object::new(arg0)};
        0x2::dynamic_field::add<vector<u8>, address>(&mut v0.id, b"banned_by", 0x2::tx_context::sender(arg0));
        v0
    }

    fun destroy_ban_details(arg0: BanDetails) {
        let BanDetails { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public fun get_ban_details(arg0: &mut 0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::app::GilderApp, arg1: address, arg2: 0x1::option::Option<address>, arg3: &mut 0x2::tx_context::TxContext) : &BanDetails {
        let v0 = 0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::app::app_object_mut<0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::version::BlacklistV1, Blacklists>(arg0);
        if (0x1::option::is_none<address>(&arg2)) {
            0x2::table::borrow<address, BanDetails>(&v0.platform, arg1)
        } else {
            0x2::table::borrow<address, BanDetails>(get_or_create_community(v0, *0x1::option::borrow<address>(&arg2), arg3), arg1)
        }
    }

    fun get_or_create_community(arg0: &mut Blacklists, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : &mut 0x2::table::Table<address, BanDetails> {
        if (!0x2::table::contains<address, 0x2::table::Table<address, BanDetails>>(&arg0.community, arg1)) {
            0x2::table::add<address, 0x2::table::Table<address, BanDetails>>(&mut arg0.community, arg1, 0x2::table::new<address, BanDetails>(arg2));
        };
        0x2::table::borrow_mut<address, 0x2::table::Table<address, BanDetails>>(&mut arg0.community, arg1)
    }

    public fun is_user_banned(arg0: &0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::app::GilderApp, arg1: address) : bool {
        0x2::table::contains<address, BanDetails>(&0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::app::object<Blacklists>(arg0).platform, arg1)
    }

    public fun is_user_banned_from_community(arg0: &mut 0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::app::GilderApp, arg1: address, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : bool {
        let v0 = 0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::app::app_object_mut<0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::version::BlacklistV1, Blacklists>(arg0);
        0x2::table::contains<address, BanDetails>(get_or_create_community(v0, arg1, arg3), arg2)
    }

    public(friend) fun unban_user_app_wide(arg0: &mut 0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::app::GilderApp, arg1: address) {
        let v0 = PlatformBanEvent{
            user_id   : arg1,
            is_banned : false,
        };
        0x2::event::emit<PlatformBanEvent>(v0);
        let v1 = 0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::app::app_object_mut<0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::version::BlacklistV1, Blacklists>(arg0);
        assert!(0x2::table::contains<address, BanDetails>(&v1.platform, arg1), 0);
        destroy_ban_details(0x2::table::remove<address, BanDetails>(&mut v1.platform, arg1));
    }

    public(friend) fun unban_user_from_community(arg0: &mut 0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::app::GilderApp, arg1: address, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = CommunityBanEvent{
            community_id : arg1,
            user_id      : arg2,
            is_banned    : false,
        };
        0x2::event::emit<CommunityBanEvent>(v0);
        let v1 = 0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::app::app_object_mut<0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::version::BlacklistV1, Blacklists>(arg0);
        let v2 = get_or_create_community(v1, arg1, arg3);
        assert!(0x2::table::contains<address, BanDetails>(v2, arg2), 0);
        destroy_ban_details(0x2::table::remove<address, BanDetails>(v2, arg2));
    }

    // decompiled from Move bytecode v6
}

