module 0x14df736178104ac1f04525d58192a82eb390bba2422a79a69ac47046619e9d1c::voultron_players {
    struct VOULTRON_PLAYERS has drop {
        dummy_field: bool,
    }

    struct VoultronPlayer has store, key {
        id: 0x2::object::UID,
        owner: address,
        converted: u64,
        last_played: u64,
        current_streak: u64,
    }

    struct FHCap has drop {
        dummy_field: bool,
    }

    struct PointsMintWitness has drop {
        dummy_field: bool,
    }

    struct PlayerCreatedEvent has copy, drop {
        player_id: 0x2::object::ID,
        owner: address,
        timestamp: u64,
    }

    struct PointsAwardedEvent has copy, drop {
        player_id: 0x2::object::ID,
        owner: address,
        amount_staked: u64,
        points: u64,
        timestamp: u64,
    }

    struct StreakUpdatedEvent has copy, drop {
        player_id: 0x2::object::ID,
        owner: address,
        streak_bonus_points: u64,
        old_streak: u64,
        new_streak: u64,
        timestamp: u64,
    }

    struct DailyBonusEarnedEvent has copy, drop {
        player_id: 0x2::object::ID,
        owner: address,
        streak_count: u64,
        bonus_points: u64,
        timestamp: u64,
    }

    struct WhitelistedPlayerModules has store, key {
        id: 0x2::object::UID,
        modules: vector<0x1::string::String>,
    }

    struct Whitelisted has drop {
        dummy_field: bool,
    }

    public fun add_points_direct<T0: drop>(arg0: &mut VoultronPlayer, arg1: &WhitelistedPlayerModules, arg2: &0xdec974fe362e058b64b8215886ec45c17560e4d67da7133e75bb49f094b055ac::award_points::AwardPointsWhitelistedModule, arg3: &mut 0x2::token::TokenPolicy<0xdec974fe362e058b64b8215886ec45c17560e4d67da7133e75bb49f094b055ac::voultron_points::VOULTRON_POINTS>, arg4: &mut 0xdec974fe362e058b64b8215886ec45c17560e4d67da7133e75bb49f094b055ac::voultron_points::PointsTreasuryCapOwner, arg5: T0, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x1::string::from_ascii(0x1::type_name::address_string(&v0));
        assert!(0x1::vector::contains<0x1::string::String>(&arg1.modules, &v1), 1);
        if (arg6 > 0) {
            let v2 = PointsMintWitness{dummy_field: false};
            0xdec974fe362e058b64b8215886ec45c17560e4d67da7133e75bb49f094b055ac::award_points::award_points<PointsMintWitness>(arg2, arg3, arg4, v2, arg6, arg0.owner, arg8);
        };
        arg0.last_played = 0x2::clock::timestamp_ms(arg7);
        let v3 = PointsAwardedEvent{
            player_id     : *0x2::object::uid_as_inner(&arg0.id),
            owner         : arg0.owner,
            amount_staked : 0,
            points        : arg6,
            timestamp     : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<PointsAwardedEvent>(v3);
    }

    public fun award_points<T0: drop, T1>(arg0: &mut VoultronPlayer, arg1: &WhitelistedPlayerModules, arg2: &0xdec974fe362e058b64b8215886ec45c17560e4d67da7133e75bb49f094b055ac::award_points::AwardPointsWhitelistedModule, arg3: &mut 0x2::token::TokenPolicy<0xdec974fe362e058b64b8215886ec45c17560e4d67da7133e75bb49f094b055ac::voultron_points::VOULTRON_POINTS>, arg4: &mut 0xdec974fe362e058b64b8215886ec45c17560e4d67da7133e75bb49f094b055ac::voultron_points::PointsTreasuryCapOwner, arg5: T0, arg6: u64, arg7: &0x14df736178104ac1f04525d58192a82eb390bba2422a79a69ac47046619e9d1c::config::PlayerConfig, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x1::string::from_ascii(0x1::type_name::address_string(&v0));
        assert!(0x1::vector::contains<0x1::string::String>(&arg1.modules, &v1), 1);
        let v2 = 0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>())));
        let v3 = 1;
        let v4 = 0;
        while (v4 < 0x14df736178104ac1f04525d58192a82eb390bba2422a79a69ac47046619e9d1c::config::get_token_decimals(arg7, v2)) {
            v3 = v3 * 10;
            v4 = v4 + 1;
        };
        let v5 = (((arg6 as u128) * (0x14df736178104ac1f04525d58192a82eb390bba2422a79a69ac47046619e9d1c::config::get_token_rate(arg7, v2) as u128) / v3) as u64);
        if (v5 > 0) {
            let v6 = PointsMintWitness{dummy_field: false};
            0xdec974fe362e058b64b8215886ec45c17560e4d67da7133e75bb49f094b055ac::award_points::award_points<PointsMintWitness>(arg2, arg3, arg4, v6, v5, arg0.owner, arg9);
        };
        arg0.last_played = 0x2::clock::timestamp_ms(arg8);
        let v7 = PointsAwardedEvent{
            player_id     : *0x2::object::uid_as_inner(&arg0.id),
            owner         : arg0.owner,
            amount_staked : arg6,
            points        : v5,
            timestamp     : 0x2::clock::timestamp_ms(arg8),
        };
        0x2::event::emit<PointsAwardedEvent>(v7);
    }

    public fun admin_create_player(arg0: &0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::Admins, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : VoultronPlayer {
        0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::check_admin(arg0, arg3);
        let v0 = VoultronPlayer{
            id             : 0x2::object::new(arg3),
            owner          : arg1,
            converted      : 0,
            last_played    : 0,
            current_streak : 0,
        };
        let v1 = PlayerCreatedEvent{
            player_id : *0x2::object::uid_as_inner(&v0.id),
            owner     : arg1,
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<PlayerCreatedEvent>(v1);
        v0
    }

    public fun admin_whitelist_modules(arg0: &0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::Admins, arg1: &mut WhitelistedPlayerModules, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::check_admin(arg0, arg3);
        0x1::vector::push_back<0x1::string::String>(&mut arg1.modules, arg2);
    }

    public fun burn_player(arg0: VoultronPlayer) {
        let VoultronPlayer {
            id             : v0,
            owner          : _,
            converted      : _,
            last_played    : _,
            current_streak : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun check_if_module_whitelisted(arg0: &WhitelistedPlayerModules, arg1: 0x1::string::String) : bool {
        0x1::vector::contains<0x1::string::String>(&arg0.modules, &arg1)
    }

    public fun create_player<T0: drop>(arg0: &WhitelistedPlayerModules, arg1: T0, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : VoultronPlayer {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x1::string::from_ascii(0x1::type_name::address_string(&v0));
        assert!(0x1::vector::contains<0x1::string::String>(&arg0.modules, &v1), 1);
        let v2 = VoultronPlayer{
            id             : 0x2::object::new(arg3),
            owner          : 0x2::tx_context::sender(arg3),
            converted      : 0,
            last_played    : 0,
            current_streak : 0,
        };
        let v3 = PlayerCreatedEvent{
            player_id : *0x2::object::uid_as_inner(&v2.id),
            owner     : 0x2::tx_context::sender(arg3),
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<PlayerCreatedEvent>(v3);
        v2
    }

    public fun get_converted(arg0: &VoultronPlayer) : u64 {
        arg0.converted
    }

    public fun get_current_streak(arg0: &VoultronPlayer) : u64 {
        arg0.current_streak
    }

    public fun get_id(arg0: &VoultronPlayer) : 0x2::object::ID {
        *0x2::object::uid_as_inner(&arg0.id)
    }

    public fun get_last_played(arg0: &VoultronPlayer) : u64 {
        arg0.last_played
    }

    public fun get_owner(arg0: &VoultronPlayer) : address {
        arg0.owner
    }

    public fun get_total_processed(arg0: &VoultronPlayer) : u64 {
        arg0.converted
    }

    public fun get_whitelisted_modules(arg0: &WhitelistedPlayerModules) : &vector<0x1::string::String> {
        &arg0.modules
    }

    fun init(arg0: VOULTRON_PLAYERS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<VOULTRON_PLAYERS>(arg0, arg1);
        let v1 = 0x2::display::new<VoultronPlayer>(&v0, arg1);
        0x2::display::add<VoultronPlayer>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Voultron Player"));
        0x2::display::add<VoultronPlayer>(&mut v1, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://voultron.fun"));
        0x2::display::add<VoultronPlayer>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/Xv2KS1iAlsIsCUIQjMcXDCuFi3ci0bVXPivvX4Dx-IQ"));
        0x2::display::update_version<VoultronPlayer>(&mut v1);
        let v2 = WhitelistedPlayerModules{
            id      : 0x2::object::new(arg1),
            modules : 0x1::vector::empty<0x1::string::String>(),
        };
        0x2::transfer::public_share_object<WhitelistedPlayerModules>(v2);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<VoultronPlayer>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun super_admin_whitelist_modules(arg0: &0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::SuperAdminCap, arg1: &mut WhitelistedPlayerModules, arg2: 0x1::string::String) {
        0x1::vector::push_back<0x1::string::String>(&mut arg1.modules, arg2);
    }

    public fun sync_owner(arg0: &mut VoultronPlayer, arg1: &mut 0x2::tx_context::TxContext) {
        arg0.owner = 0x2::tx_context::sender(arg1);
    }

    public fun tese<T0>() {
        0x1::type_name::with_defining_ids<T0>();
    }

    public fun update_display_blob_id(arg0: &mut 0x2::display::Display<VoultronPlayer>, arg1: &0x14df736178104ac1f04525d58192a82eb390bba2422a79a69ac47046619e9d1c::config::PlayerConfig, arg2: 0x1::string::String) {
        let v0 = 0x14df736178104ac1f04525d58192a82eb390bba2422a79a69ac47046619e9d1c::config::get_string_param(arg1, 0x1::string::utf8(b"walrus_base_url"));
        if (0x1::string::is_empty(&v0)) {
            v0 = 0x1::string::utf8(b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/");
        };
        0x1::string::append(&mut v0, arg2);
        0x2::display::edit<VoultronPlayer>(arg0, 0x1::string::utf8(b"image_url"), v0);
        0x2::display::update_version<VoultronPlayer>(arg0);
    }

    public fun update_image_url(arg0: &mut 0x2::display::Display<VoultronPlayer>, arg1: 0x1::string::String) {
        0x2::display::edit<VoultronPlayer>(arg0, 0x1::string::utf8(b"image_url"), arg1);
        0x2::display::update_version<VoultronPlayer>(arg0);
    }

    public fun update_streak<T0: drop>(arg0: &mut VoultronPlayer, arg1: &WhitelistedPlayerModules, arg2: &0xdec974fe362e058b64b8215886ec45c17560e4d67da7133e75bb49f094b055ac::award_points::AwardPointsWhitelistedModule, arg3: &mut 0x2::token::TokenPolicy<0xdec974fe362e058b64b8215886ec45c17560e4d67da7133e75bb49f094b055ac::voultron_points::VOULTRON_POINTS>, arg4: &mut 0xdec974fe362e058b64b8215886ec45c17560e4d67da7133e75bb49f094b055ac::voultron_points::PointsTreasuryCapOwner, arg5: T0, arg6: &0x14df736178104ac1f04525d58192a82eb390bba2422a79a69ac47046619e9d1c::config::PlayerConfig, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x1::string::from_ascii(0x1::type_name::address_string(&v0));
        assert!(0x1::vector::contains<0x1::string::String>(&arg1.modules, &v1), 1);
        let v2 = 0x2::clock::timestamp_ms(arg7);
        let v3 = 0x14df736178104ac1f04525d58192a82eb390bba2422a79a69ac47046619e9d1c::config::get_one_day_ms(arg6);
        let v4 = 1;
        let v5 = if (arg0.last_played == 0) {
            0
        } else {
            v2 - arg0.last_played
        };
        if (arg0.last_played == 0) {
            arg0.current_streak = 1;
            arg0.last_played = v2;
        } else if (v5 >= v3 * 2) {
            arg0.current_streak = 1;
            arg0.last_played = v2;
        } else if (v5 >= v3) {
            arg0.current_streak = arg0.current_streak + 1;
            arg0.last_played = v2;
        } else {
            return
        };
        if (arg0.current_streak % 5 == 0) {
            v4 = 5;
            let v6 = DailyBonusEarnedEvent{
                player_id    : *0x2::object::uid_as_inner(&arg0.id),
                owner        : arg0.owner,
                streak_count : arg0.current_streak,
                bonus_points : 4,
                timestamp    : v2,
            };
            0x2::event::emit<DailyBonusEarnedEvent>(v6);
        };
        if (v4 > 0) {
            let v7 = PointsMintWitness{dummy_field: false};
            0xdec974fe362e058b64b8215886ec45c17560e4d67da7133e75bb49f094b055ac::award_points::award_points<PointsMintWitness>(arg2, arg3, arg4, v7, v4, arg0.owner, arg8);
        };
        let v8 = StreakUpdatedEvent{
            player_id           : *0x2::object::uid_as_inner(&arg0.id),
            owner               : arg0.owner,
            streak_bonus_points : v4,
            old_streak          : arg0.current_streak,
            new_streak          : arg0.current_streak,
            timestamp           : v2,
        };
        0x2::event::emit<StreakUpdatedEvent>(v8);
    }

    // decompiled from Move bytecode v6
}

