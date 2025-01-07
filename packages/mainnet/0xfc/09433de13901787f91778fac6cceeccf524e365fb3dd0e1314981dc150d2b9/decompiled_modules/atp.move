module 0xfc09433de13901787f91778fac6cceeccf524e365fb3dd0e1314981dc150d2b9::atp {
    struct ATP has drop {
        dummy_field: bool,
    }

    struct MatchTrace has store, key {
        id: 0x2::object::UID,
        title: 0x1::string::String,
        number: u64,
        tournament: 0x1::string::String,
        location: 0x1::string::String,
        date: 0x1::string::String,
        player_a: 0x1::string::String,
        player_b: 0x1::string::String,
        winner: 0x1::string::String,
        round: 0x1::string::String,
        score: 0x1::string::String,
        poster_id: 0x1::string::String,
        image_key: 0x1::string::String,
    }

    struct TournamentTrace has store, key {
        id: 0x2::object::UID,
        title: 0x1::string::String,
        number: u64,
        tournament: 0x1::string::String,
        location: 0x1::string::String,
        level: u8,
        poster_id: 0x1::string::String,
        image_key: 0x1::string::String,
    }

    fun init(arg0: ATP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{title}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"15 matches, 15 Traces. Official digital memorabilia from the 2024 Nitto ATP Finals."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://storage.trace.fan/{image_key}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://atp.trace.fan/"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Trace"));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"creator"));
        let v6 = 0x1::vector::empty<0x1::string::String>();
        let v7 = &mut v6;
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"{title}"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"A thank you to the fans from around the world who took part in Momentum at the 2024 Nitto ATP Finals."));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"https://storage.trace.fan/{image_key}"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"https://atp.trace.fan/"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"Trace"));
        let v8 = 0x2::package::claim<ATP>(arg0, arg1);
        let v9 = 0x2::display::new_with_fields<MatchTrace>(&v8, v0, v2, arg1);
        0x2::display::update_version<MatchTrace>(&mut v9);
        let v10 = 0x2::display::new_with_fields<TournamentTrace>(&v8, v4, v6, arg1);
        0x2::display::update_version<TournamentTrace>(&mut v10);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v8, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<MatchTrace>>(v9, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<TournamentTrace>>(v10, 0x2::tx_context::sender(arg1));
    }

    public fun new_match_to_kiosk(arg0: &0xaa644104d5b63baf73e7f7a1148f7fb062f0e882862f01917b7be823426deb25::access_control::AuthorizationProof<MatchTrace>, arg1: &0xaa644104d5b63baf73e7f7a1148f7fb062f0e882862f01917b7be823426deb25::access_control::Registry, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::transfer_policy::TransferPolicy<MatchTrace>, arg4: 0x1::string::String, arg5: u64, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: 0x1::string::String, arg13: 0x1::string::String, arg14: 0x1::string::String, arg15: 0x1::string::String, arg16: &mut 0x2::tx_context::TxContext) {
        let v0 = MatchTrace{
            id         : 0x2::object::new(arg16),
            title      : arg4,
            number     : arg5,
            tournament : arg6,
            location   : arg7,
            date       : arg8,
            player_a   : arg9,
            player_b   : arg10,
            winner     : arg11,
            round      : arg12,
            score      : arg13,
            poster_id  : arg14,
            image_key  : arg15,
        };
        0xaa644104d5b63baf73e7f7a1148f7fb062f0e882862f01917b7be823426deb25::extension::place<MatchTrace>(arg0, arg1, arg2, v0, arg3);
    }

    public fun new_tournament_to_kiosk(arg0: &0xaa644104d5b63baf73e7f7a1148f7fb062f0e882862f01917b7be823426deb25::access_control::AuthorizationProof<TournamentTrace>, arg1: &0xaa644104d5b63baf73e7f7a1148f7fb062f0e882862f01917b7be823426deb25::access_control::Registry, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::transfer_policy::TransferPolicy<TournamentTrace>, arg4: 0x1::string::String, arg5: u64, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: u8, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg8 >= 1 && arg8 <= 5, 0);
        let v0 = TournamentTrace{
            id         : 0x2::object::new(arg11),
            title      : arg4,
            number     : arg5,
            tournament : arg6,
            location   : arg7,
            level      : arg8,
            poster_id  : arg9,
            image_key  : arg10,
        };
        0xaa644104d5b63baf73e7f7a1148f7fb062f0e882862f01917b7be823426deb25::extension::place<TournamentTrace>(arg0, arg1, arg2, v0, arg3);
    }

    // decompiled from Move bytecode v6
}

