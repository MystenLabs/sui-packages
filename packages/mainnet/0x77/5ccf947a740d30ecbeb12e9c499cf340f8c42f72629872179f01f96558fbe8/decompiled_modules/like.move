module 0xb5401b12675a69d8be91971a7991fc899fcbd3033a759fa48085c9c01f347dd0::like {
    struct LikeEvent has copy, drop {
        liker: address,
        recipient: address,
    }

    struct LikeTracker has key {
        id: 0x2::object::UID,
        likes_given: 0x2::table::Table<address, 0x2::table::Table<address, bool>>,
        like_counts: 0x2::table::Table<address, u64>,
    }

    public fun get_like_count(arg0: &LikeTracker, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.like_counts, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.like_counts, arg1)
        } else {
            0
        }
    }

    public fun give_like(arg0: &0xb5401b12675a69d8be91971a7991fc899fcbd3033a759fa48085c9c01f347dd0::sui_liquidlink_profile::EditCap, arg1: &0xb5401b12675a69d8be91971a7991fc899fcbd3033a759fa48085c9c01f347dd0::sui_liquidlink_profile::ProfileRegistry, arg2: &0xb5401b12675a69d8be91971a7991fc899fcbd3033a759fa48085c9c01f347dd0::sui_liquidlink_profile::ProfileNFT, arg3: &mut LikeTracker, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0xb5401b12675a69d8be91971a7991fc899fcbd3033a759fa48085c9c01f347dd0::sui_liquidlink_profile::get_profile_id(arg1, v0);
        assert!(0x1::option::is_some<0x2::object::ID>(&v1), 2);
        assert!(0x2::object::id<0xb5401b12675a69d8be91971a7991fc899fcbd3033a759fa48085c9c01f347dd0::sui_liquidlink_profile::ProfileNFT>(arg2) == 0x1::option::destroy_some<0x2::object::ID>(v1), 2);
        assert!(v0 != arg4, 0);
        if (0x2::table::contains<address, 0x2::table::Table<address, bool>>(&arg3.likes_given, v0)) {
            assert!(!0x2::table::contains<address, bool>(0x2::table::borrow<address, 0x2::table::Table<address, bool>>(&arg3.likes_given, v0), arg4), 1);
        } else {
            0x2::table::add<address, 0x2::table::Table<address, bool>>(&mut arg3.likes_given, v0, 0x2::table::new<address, bool>(arg5));
        };
        0x2::table::add<address, bool>(0x2::table::borrow_mut<address, 0x2::table::Table<address, bool>>(&mut arg3.likes_given, v0), arg4, true);
        if (0x2::table::contains<address, u64>(&arg3.like_counts, arg4)) {
            let v2 = 0x2::table::borrow_mut<address, u64>(&mut arg3.like_counts, arg4);
            *v2 = *v2 + 1;
        } else {
            0x2::table::add<address, u64>(&mut arg3.like_counts, arg4, 1);
        };
        let v3 = LikeEvent{
            liker     : v0,
            recipient : arg4,
        };
        0x2::event::emit<LikeEvent>(v3);
    }

    public fun migrate(arg0: &0xb5401b12675a69d8be91971a7991fc899fcbd3033a759fa48085c9c01f347dd0::sui_liquidlink_profile::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = LikeTracker{
            id          : 0x2::object::new(arg1),
            likes_given : 0x2::table::new<address, 0x2::table::Table<address, bool>>(arg1),
            like_counts : 0x2::table::new<address, u64>(arg1),
        };
        0x2::transfer::share_object<LikeTracker>(v0);
    }

    // decompiled from Move bytecode v6
}

