module 0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::activity_badge {
    struct ActivityBadge<phantom T0> has store, key {
        id: 0x2::object::UID,
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

    public(friend) fun mint_activity_badges(arg0: &0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::blockblock::AttendanceSheet, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::blockblock::session(arg0);
        let v1 = 0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::blockblock::attendees_including_late(arg0);
        if (v0 == 0x1::string::utf8(b"GENERAL")) {
            let v2 = &v1;
            let v3 = 0;
            while (v3 < 0x1::vector::length<address>(v2)) {
                let v4 = ActivityBadge<GeneralSession>{
                    id      : 0x2::object::new(arg1),
                    img_url : 0x1::string::utf8(b""),
                };
                0x2::transfer::transfer<ActivityBadge<GeneralSession>>(v4, *0x1::vector::borrow<address>(v2, v3));
                v3 = v3 + 1;
            };
        } else if (v0 == 0x1::string::utf8(b"OT")) {
            let v5 = &v1;
            let v6 = 0;
            while (v6 < 0x1::vector::length<address>(v5)) {
                let v7 = ActivityBadge<Orientation>{
                    id      : 0x2::object::new(arg1),
                    img_url : 0x1::string::utf8(b""),
                };
                0x2::transfer::transfer<ActivityBadge<Orientation>>(v7, *0x1::vector::borrow<address>(v5, v6));
                v6 = v6 + 1;
            };
        } else if (v0 == 0x1::string::utf8(b"MT")) {
            let v8 = &v1;
            let v9 = 0;
            while (v9 < 0x1::vector::length<address>(v8)) {
                let v10 = ActivityBadge<MembershipTraning>{
                    id      : 0x2::object::new(arg1),
                    img_url : 0x1::string::utf8(b""),
                };
                0x2::transfer::transfer<ActivityBadge<MembershipTraning>>(v10, *0x1::vector::borrow<address>(v8, v9));
                v9 = v9 + 1;
            };
        } else if (v0 == 0x1::string::utf8(b"GUEST_SPEAKER")) {
            let v11 = &v1;
            let v12 = 0;
            while (v12 < 0x1::vector::length<address>(v11)) {
                let v13 = ActivityBadge<GuestSpeakerSession>{
                    id      : 0x2::object::new(arg1),
                    img_url : 0x1::string::utf8(b""),
                };
                0x2::transfer::transfer<ActivityBadge<GuestSpeakerSession>>(v13, *0x1::vector::borrow<address>(v11, v12));
                v12 = v12 + 1;
            };
        } else if (v0 == 0x1::string::utf8(b"VACATION_KICK_OFF")) {
            let v14 = &v1;
            let v15 = 0;
            while (v15 < 0x1::vector::length<address>(v14)) {
                let v16 = ActivityBadge<VacationKickOff>{
                    id      : 0x2::object::new(arg1),
                    img_url : 0x1::string::utf8(b""),
                };
                0x2::transfer::transfer<ActivityBadge<VacationKickOff>>(v16, *0x1::vector::borrow<address>(v14, v15));
                v15 = v15 + 1;
            };
        } else if (v0 == 0x1::string::utf8(b"BLOCKBLOCK_NIGHT")) {
            let v17 = &v1;
            let v18 = 0;
            while (v18 < 0x1::vector::length<address>(v17)) {
                let v19 = ActivityBadge<BlockBlockNight>{
                    id      : 0x2::object::new(arg1),
                    img_url : 0x1::string::utf8(b""),
                };
                0x2::transfer::transfer<ActivityBadge<BlockBlockNight>>(v19, *0x1::vector::borrow<address>(v17, v18));
                v18 = v18 + 1;
            };
        } else if (v0 == 0x1::string::utf8(b"COMPLETION_CEREMONY")) {
            let v20 = &v1;
            let v21 = 0;
            while (v21 < 0x1::vector::length<address>(v20)) {
                let v22 = ActivityBadge<CompletionCeremony>{
                    id      : 0x2::object::new(arg1),
                    img_url : 0x1::string::utf8(b""),
                };
                0x2::transfer::transfer<ActivityBadge<CompletionCeremony>>(v22, *0x1::vector::borrow<address>(v20, v21));
                v21 = v21 + 1;
            };
        } else if (v0 == 0x1::string::utf8(b"HOME_COMMING_DAY")) {
            let v23 = &v1;
            let v24 = 0;
            while (v24 < 0x1::vector::length<address>(v23)) {
                let v25 = ActivityBadge<HomeCommingDay>{
                    id      : 0x2::object::new(arg1),
                    img_url : 0x1::string::utf8(b""),
                };
                0x2::transfer::transfer<ActivityBadge<HomeCommingDay>>(v25, *0x1::vector::borrow<address>(v23, v24));
                v24 = v24 + 1;
            };
        } else {
            let v26 = &v1;
            let v27 = 0;
            while (v27 < 0x1::vector::length<address>(v26)) {
                let v28 = ActivityBadge<GeneralSession>{
                    id      : 0x2::object::new(arg1),
                    img_url : 0x1::string::utf8(b""),
                };
                0x2::transfer::transfer<ActivityBadge<GeneralSession>>(v28, *0x1::vector::borrow<address>(v26, v27));
                v27 = v27 + 1;
            };
        };
    }

    // decompiled from Move bytecode v6
}

