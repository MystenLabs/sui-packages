module 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::activity_badge {
    struct ActivityBadge<phantom T0> has store, key {
        id: 0x2::object::UID,
        club_id: 0x2::object::ID,
        term: u64,
        img_url: 0x1::string::String,
    }

    struct GeneralSession {
        dummy_field: bool,
    }

    struct Orientation {
        dummy_field: bool,
    }

    struct MembershipTraning {
        dummy_field: bool,
    }

    struct GuestSpeakerSession {
        dummy_field: bool,
    }

    struct VacationKickOff {
        dummy_field: bool,
    }

    struct BlockBlockNight {
        dummy_field: bool,
    }

    struct CompletionCeremony {
        dummy_field: bool,
    }

    struct HomeCommingDay {
        dummy_field: bool,
    }

    struct ACTIVITY_BADGE has drop {
        dummy_field: bool,
    }

    fun create_badge_display<T0>(arg0: &0x2::package::Publisher, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, arg1);
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"BlockBlock activity attendance badge"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{img_url}"));
        let v4 = 0x2::display::new_with_fields<ActivityBadge<T0>>(arg0, v0, v2, arg2);
        0x2::display::update_version<ActivityBadge<T0>>(&mut v4);
        0x2::transfer::public_transfer<0x2::display::Display<ActivityBadge<T0>>>(v4, 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: ACTIVITY_BADGE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<ACTIVITY_BADGE>(arg0, arg1);
        create_badge_display<GeneralSession>(&v0, 0x1::string::utf8(b"BlockBlock General Session Badge"), arg1);
        create_badge_display<Orientation>(&v0, 0x1::string::utf8(b"BlockBlock Orientation Badge"), arg1);
        create_badge_display<MembershipTraning>(&v0, 0x1::string::utf8(b"BlockBlock Membership Training Badge"), arg1);
        create_badge_display<GuestSpeakerSession>(&v0, 0x1::string::utf8(b"BlockBlock Guest Speaker Badge"), arg1);
        create_badge_display<VacationKickOff>(&v0, 0x1::string::utf8(b"BlockBlock Vacation Kick-Off Badge"), arg1);
        create_badge_display<BlockBlockNight>(&v0, 0x1::string::utf8(b"BlockBlock Night Badge"), arg1);
        create_badge_display<CompletionCeremony>(&v0, 0x1::string::utf8(b"BlockBlock Completion Ceremony Badge"), arg1);
        create_badge_display<HomeCommingDay>(&v0, 0x1::string::utf8(b"BlockBlock Home Coming Day Badge"), arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun mint_activity_badges(arg0: &0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::AttendanceSheet, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::session(arg0);
        let v1 = 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::attendees_including_late(arg0);
        let v2 = b"";
        0x1::vector::append<u8>(&mut v2, b"https://vuhaopuyxmqlpkpeqvaf.supabase.co/storage/v1/object/public/activity_badge/");
        if (v0 == 0x1::string::utf8(b"GENERAL")) {
            0x1::vector::append<u8>(&mut v2, b"Blockblock_Activity_Badge_G.png");
            let v3 = &v1;
            let v4 = 0;
            while (v4 < 0x1::vector::length<address>(v3)) {
                let v5 = ActivityBadge<GeneralSession>{
                    id      : 0x2::object::new(arg3),
                    club_id : arg1,
                    term    : arg2,
                    img_url : 0x1::string::utf8(v2),
                };
                0x2::transfer::transfer<ActivityBadge<GeneralSession>>(v5, *0x1::vector::borrow<address>(v3, v4));
                v4 = v4 + 1;
            };
        } else if (v0 == 0x1::string::utf8(b"OT")) {
            0x1::vector::append<u8>(&mut v2, b"Blockblock_Activity_Badge_OT.png");
            let v6 = &v1;
            let v7 = 0;
            while (v7 < 0x1::vector::length<address>(v6)) {
                let v8 = ActivityBadge<Orientation>{
                    id      : 0x2::object::new(arg3),
                    club_id : arg1,
                    term    : arg2,
                    img_url : 0x1::string::utf8(v2),
                };
                0x2::transfer::transfer<ActivityBadge<Orientation>>(v8, *0x1::vector::borrow<address>(v6, v7));
                v7 = v7 + 1;
            };
        } else if (v0 == 0x1::string::utf8(b"MT")) {
            0x1::vector::append<u8>(&mut v2, b"Blockblock_Activity_Badge_MT.png");
            let v9 = &v1;
            let v10 = 0;
            while (v10 < 0x1::vector::length<address>(v9)) {
                let v11 = ActivityBadge<MembershipTraning>{
                    id      : 0x2::object::new(arg3),
                    club_id : arg1,
                    term    : arg2,
                    img_url : 0x1::string::utf8(v2),
                };
                0x2::transfer::transfer<ActivityBadge<MembershipTraning>>(v11, *0x1::vector::borrow<address>(v9, v10));
                v10 = v10 + 1;
            };
        } else if (v0 == 0x1::string::utf8(b"GUEST_SPEAKER")) {
            0x1::vector::append<u8>(&mut v2, b"Blockblock_Activity_Badge_GS.png");
            let v12 = &v1;
            let v13 = 0;
            while (v13 < 0x1::vector::length<address>(v12)) {
                let v14 = ActivityBadge<GuestSpeakerSession>{
                    id      : 0x2::object::new(arg3),
                    club_id : arg1,
                    term    : arg2,
                    img_url : 0x1::string::utf8(v2),
                };
                0x2::transfer::transfer<ActivityBadge<GuestSpeakerSession>>(v14, *0x1::vector::borrow<address>(v12, v13));
                v13 = v13 + 1;
            };
        } else if (v0 == 0x1::string::utf8(b"VACATION_KICK_OFF")) {
            0x1::vector::append<u8>(&mut v2, b"Blockblock_Activity_Badge_VK.png");
            let v15 = &v1;
            let v16 = 0;
            while (v16 < 0x1::vector::length<address>(v15)) {
                let v17 = ActivityBadge<VacationKickOff>{
                    id      : 0x2::object::new(arg3),
                    club_id : arg1,
                    term    : arg2,
                    img_url : 0x1::string::utf8(v2),
                };
                0x2::transfer::transfer<ActivityBadge<VacationKickOff>>(v17, *0x1::vector::borrow<address>(v15, v16));
                v16 = v16 + 1;
            };
        } else if (v0 == 0x1::string::utf8(b"BLOCKBLOCK_NIGHT")) {
            0x1::vector::append<u8>(&mut v2, b"Blockblock_Activity_Badge_BN.png");
            let v18 = &v1;
            let v19 = 0;
            while (v19 < 0x1::vector::length<address>(v18)) {
                let v20 = ActivityBadge<BlockBlockNight>{
                    id      : 0x2::object::new(arg3),
                    club_id : arg1,
                    term    : arg2,
                    img_url : 0x1::string::utf8(v2),
                };
                0x2::transfer::transfer<ActivityBadge<BlockBlockNight>>(v20, *0x1::vector::borrow<address>(v18, v19));
                v19 = v19 + 1;
            };
        } else if (v0 == 0x1::string::utf8(b"COMPLETION_CEREMONY")) {
            0x1::vector::append<u8>(&mut v2, b"Blockblock_Activity_Badge_CC.png");
            let v21 = &v1;
            let v22 = 0;
            while (v22 < 0x1::vector::length<address>(v21)) {
                let v23 = ActivityBadge<CompletionCeremony>{
                    id      : 0x2::object::new(arg3),
                    club_id : arg1,
                    term    : arg2,
                    img_url : 0x1::string::utf8(v2),
                };
                0x2::transfer::transfer<ActivityBadge<CompletionCeremony>>(v23, *0x1::vector::borrow<address>(v21, v22));
                v22 = v22 + 1;
            };
        } else if (v0 == 0x1::string::utf8(b"HOME_COMMING_DAY")) {
            0x1::vector::append<u8>(&mut v2, b"Blockblock_Activity_Badge_HD.png");
            let v24 = &v1;
            let v25 = 0;
            while (v25 < 0x1::vector::length<address>(v24)) {
                let v26 = ActivityBadge<HomeCommingDay>{
                    id      : 0x2::object::new(arg3),
                    club_id : arg1,
                    term    : arg2,
                    img_url : 0x1::string::utf8(v2),
                };
                0x2::transfer::transfer<ActivityBadge<HomeCommingDay>>(v26, *0x1::vector::borrow<address>(v24, v25));
                v25 = v25 + 1;
            };
        } else {
            0x1::vector::append<u8>(&mut v2, b"Blockblock_Activity_Badge_G.png");
            let v27 = &v1;
            let v28 = 0;
            while (v28 < 0x1::vector::length<address>(v27)) {
                let v29 = ActivityBadge<GeneralSession>{
                    id      : 0x2::object::new(arg3),
                    club_id : arg1,
                    term    : arg2,
                    img_url : 0x1::string::utf8(v2),
                };
                0x2::transfer::transfer<ActivityBadge<GeneralSession>>(v29, *0x1::vector::borrow<address>(v27, v28));
                v28 = v28 + 1;
            };
        };
    }

    // decompiled from Move bytecode v6
}

