module 0xa668c32a8246c35598572560865d1843bfce6d929e0ab5c696cae3c10b003e86::point {
    struct POINT has drop {
        dummy_field: bool,
    }

    struct Points has store {
        config: PointsConfig,
        user_points: 0x2::table::Table<address, UserPoint>,
        referral_codes: 0x2::table::Table<0x1::ascii::String, address>,
    }

    struct PointsConfig has store {
        point_per_day: u64,
        base_multiplier: u64,
        streak_threshold: u64,
        streak_denominator: u64,
        cooldown_sec: u64,
        claim_window_sec: u64,
        referral_reward_percentage: u8,
        complete_sign_up_reward: u64,
    }

    struct UserPoint has store {
        current_streak: u64,
        highest_streak: u64,
        last_sign_in_timestamp_ms: u64,
        total_points_earned: u64,
        referral_code: 0x1::ascii::String,
        referrer: 0x1::option::Option<address>,
    }

    struct PointsEvent has copy, drop {
        user: address,
        points_earned: u64,
        current_streak: u64,
        highest_streak: u64,
        total_points_earned: u64,
        reason: 0x1::string::String,
    }

    struct ReferralEvent has copy, drop {
        referrer: address,
        referee: address,
        points_earned: u64,
        total_points_earned: u64,
        reason: 0x1::string::String,
    }

    public fun new(arg0: &0xa668c32a8246c35598572560865d1843bfce6d929e0ab5c696cae3c10b003e86::app::AdminCap, arg1: &mut 0x2::tx_context::TxContext) : Points {
        let v0 = PointsConfig{
            point_per_day              : 5000,
            base_multiplier            : 1,
            streak_threshold           : 7,
            streak_denominator         : 8,
            cooldown_sec               : 86400,
            claim_window_sec           : 82800,
            referral_reward_percentage : 10,
            complete_sign_up_reward    : 100000,
        };
        Points{
            config         : v0,
            user_points    : 0x2::table::new<address, UserPoint>(arg1),
            referral_codes : 0x2::table::new<0x1::ascii::String, address>(arg1),
        }
    }

    fun calculate_points(arg0: &PointsConfig, arg1: u64) : u64 {
        let v0 = 1000;
        arg0.point_per_day * (v0 * arg0.base_multiplier + v0 * arg1 / arg0.streak_threshold / arg0.streak_denominator) / v0
    }

    public fun claim_points(arg0: &mut 0xa668c32a8246c35598572560865d1843bfce6d929e0ab5c696cae3c10b003e86::app::GilderApp, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        0xa668c32a8246c35598572560865d1843bfce6d929e0ab5c696cae3c10b003e86::blacklist::assert_not_banned(arg0, 0x2::tx_context::sender(arg2));
        let v0 = 0xa668c32a8246c35598572560865d1843bfce6d929e0ab5c696cae3c10b003e86::app::app_object_mut<0xa668c32a8246c35598572560865d1843bfce6d929e0ab5c696cae3c10b003e86::version::PointV1, Points>(arg0);
        let v1 = 0x2::tx_context::sender(arg2);
        let v2 = 0x2::clock::timestamp_ms(arg1);
        let v3 = &mut v0.user_points;
        let v4 = get_or_create_user_point(v3, v1);
        let v5 = v4;
        let v6 = (v2 - v4.last_sign_in_timestamp_ms) / 1000;
        assert!(v6 > v0.config.cooldown_sec, 100);
        if (v6 > v0.config.claim_window_sec + v0.config.cooldown_sec) {
            v4.current_streak = 0;
        };
        let v7 = calculate_points(&v0.config, v4.current_streak);
        let v8 = 0x1::vector::singleton<address>(v1);
        let v9 = 0x1::vector::singleton<u64>(v7);
        v4.current_streak = v4.current_streak + 1;
        v4.highest_streak = 0x1::u64::max(v4.highest_streak, v4.current_streak);
        v4.last_sign_in_timestamp_ms = v2;
        v4.total_points_earned = v4.total_points_earned + v7;
        let v10 = PointsEvent{
            user                : v1,
            points_earned       : v7,
            current_streak      : v4.current_streak,
            highest_streak      : v4.highest_streak,
            total_points_earned : v4.total_points_earned,
            reason              : 0x1::string::utf8(b"daily_sign_in"),
        };
        0x2::event::emit<PointsEvent>(v10);
        while (0x1::option::is_some<address>(&v5.referrer) && v7 > 0) {
            let v11 = *0x1::option::borrow<address>(&v5.referrer);
            let v12 = 0x2::table::borrow_mut<address, UserPoint>(&mut v0.user_points, v11);
            v5 = v12;
            let v13 = v7 * (v0.config.referral_reward_percentage as u64) / 100;
            v7 = v13;
            v12.total_points_earned = v12.total_points_earned + v13;
            if (v13 > 0) {
                0x1::vector::push_back<address>(&mut v8, v11);
                0x1::vector::push_back<u64>(&mut v9, v13);
                let v14 = ReferralEvent{
                    referrer            : v11,
                    referee             : v1,
                    points_earned       : v13,
                    total_points_earned : v12.total_points_earned,
                    reason              : 0x1::string::utf8(b"referred"),
                };
                0x2::event::emit<ReferralEvent>(v14);
                continue
            };
        };
        let v15 = 0xa668c32a8246c35598572560865d1843bfce6d929e0ab5c696cae3c10b003e86::app::app_key_object_mut<0xa668c32a8246c35598572560865d1843bfce6d929e0ab5c696cae3c10b003e86::version::PointV1, 0x2::coin::TreasuryCap<POINT>>(arg0);
        assert!(0x1::vector::length<address>(&v8) == 0x1::vector::length<u64>(&v9), 999);
        let v16 = 0;
        while (v16 < 0x1::vector::length<address>(&v8)) {
            let (_, _, _, _) = 0x2::token::confirm_with_treasury_cap<POINT>(v15, 0x2::token::transfer<POINT>(0x2::token::mint<POINT>(v15, *0x1::vector::borrow<u64>(&v9, v16), arg2), *0x1::vector::borrow<address>(&v8, v16), arg2), arg2);
            v16 = v16 + 1;
        };
    }

    public fun config(arg0: &0xa668c32a8246c35598572560865d1843bfce6d929e0ab5c696cae3c10b003e86::app::GilderApp) : &PointsConfig {
        &0xa668c32a8246c35598572560865d1843bfce6d929e0ab5c696cae3c10b003e86::app::object<Points>(arg0).config
    }

    entry fun generate_referral_code(arg0: &mut 0xa668c32a8246c35598572560865d1843bfce6d929e0ab5c696cae3c10b003e86::app::GilderApp, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) : 0x1::ascii::String {
        0xa668c32a8246c35598572560865d1843bfce6d929e0ab5c696cae3c10b003e86::blacklist::assert_not_banned(arg0, 0x2::tx_context::sender(arg2));
        let v0 = 0xa668c32a8246c35598572560865d1843bfce6d929e0ab5c696cae3c10b003e86::app::app_object_mut<0xa668c32a8246c35598572560865d1843bfce6d929e0ab5c696cae3c10b003e86::version::PointV1, Points>(arg0);
        let v1 = 0x2::tx_context::sender(arg2);
        let v2 = &mut v0.user_points;
        let v3 = get_or_create_user_point(v2, v1);
        if (0x1::ascii::length(&v3.referral_code) == 0) {
            let v4 = 0;
            let v5 = 0x2::random::new_generator(arg1, arg2);
            while (v4 < 10) {
                let v6 = 0x1::ascii::string(b"");
                let v7 = 0;
                while (v7 < 8) {
                    0x1::ascii::push_char(&mut v6, 0x1::ascii::char(0x2::random::generate_u8_in_range(&mut v5, 97, 122)));
                    v7 = v7 + 1;
                };
                if (!0x2::table::contains<0x1::ascii::String, address>(&v0.referral_codes, v6)) {
                    v3.referral_code = v6;
                    0x2::table::add<0x1::ascii::String, address>(&mut v0.referral_codes, v6, v1);
                    return v6
                };
                v4 = v4 + 1;
            };
            abort 101
        };
        v3.referral_code
    }

    fun get_or_create_user_point(arg0: &mut 0x2::table::Table<address, UserPoint>, arg1: address) : &mut UserPoint {
        if (!0x2::table::contains<address, UserPoint>(arg0, arg1)) {
            let v0 = UserPoint{
                current_streak            : 0,
                highest_streak            : 0,
                last_sign_in_timestamp_ms : 0,
                total_points_earned       : 0,
                referral_code             : 0x1::ascii::string(b""),
                referrer                  : 0x1::option::none<address>(),
            };
            0x2::table::add<address, UserPoint>(arg0, arg1, v0);
        };
        0x2::table::borrow_mut<address, UserPoint>(arg0, arg1)
    }

    fun init(arg0: POINT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POINT>(arg0, 3, b"GPT", b"Gilder Points Token", b"The Token Of Gilder", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POINT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<POINT>>(v1, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun mint_points_for_user_completing_sign_up(arg0: &mut 0xa668c32a8246c35598572560865d1843bfce6d929e0ab5c696cae3c10b003e86::app::GilderApp, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = config(arg0).complete_sign_up_reward;
        let v1 = 0xa668c32a8246c35598572560865d1843bfce6d929e0ab5c696cae3c10b003e86::app::app_key_object_mut<0xa668c32a8246c35598572560865d1843bfce6d929e0ab5c696cae3c10b003e86::version::PointV1, 0x2::coin::TreasuryCap<POINT>>(arg0);
        let (_, _, _, _) = 0x2::token::confirm_with_treasury_cap<POINT>(v1, 0x2::token::transfer<POINT>(0x2::token::mint<POINT>(v1, v0, arg2), arg1, arg2), arg2);
        let v6 = &mut 0xa668c32a8246c35598572560865d1843bfce6d929e0ab5c696cae3c10b003e86::app::app_object_mut<0xa668c32a8246c35598572560865d1843bfce6d929e0ab5c696cae3c10b003e86::version::PointV1, Points>(arg0).user_points;
        let v7 = get_or_create_user_point(v6, arg1);
        v7.total_points_earned = v7.total_points_earned + v0;
        let v8 = PointsEvent{
            user                : arg1,
            points_earned       : v0,
            current_streak      : v7.current_streak,
            highest_streak      : v7.highest_streak,
            total_points_earned : v7.total_points_earned,
            reason              : 0x1::string::utf8(b"completed_sign_up"),
        };
        0x2::event::emit<PointsEvent>(v8);
    }

    public fun points_from_streaks(arg0: &0xa668c32a8246c35598572560865d1843bfce6d929e0ab5c696cae3c10b003e86::app::GilderApp, arg1: vector<u64>) : vector<u64> {
        let v0 = 0xa668c32a8246c35598572560865d1843bfce6d929e0ab5c696cae3c10b003e86::app::object<Points>(arg0);
        let v1 = 0;
        let v2 = vector[];
        while (v1 < 0x1::vector::length<u64>(&arg1)) {
            0x1::vector::push_back<u64>(&mut v2, calculate_points(&v0.config, *0x1::vector::borrow<u64>(&arg1, v1)));
            v1 = v1 + 1;
        };
        v2
    }

    public fun register_with_referral(arg0: &mut 0xa668c32a8246c35598572560865d1843bfce6d929e0ab5c696cae3c10b003e86::app::GilderApp, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        0xa668c32a8246c35598572560865d1843bfce6d929e0ab5c696cae3c10b003e86::blacklist::assert_not_banned(arg0, 0x2::tx_context::sender(arg2));
        let v0 = 0xa668c32a8246c35598572560865d1843bfce6d929e0ab5c696cae3c10b003e86::app::app_object_mut<0xa668c32a8246c35598572560865d1843bfce6d929e0ab5c696cae3c10b003e86::version::PointV1, Points>(arg0);
        let v1 = 0x2::tx_context::sender(arg2);
        let v2 = &mut v0.user_points;
        let v3 = get_or_create_user_point(v2, v1);
        let v4 = 0x1::ascii::string(arg1);
        assert!(v3.referral_code != v4, 105);
        assert!(0x1::option::is_none<address>(&v3.referrer), 104);
        assert!(0x2::table::contains<0x1::ascii::String, address>(&v0.referral_codes, v4), 102);
        let v5 = *0x2::table::borrow<0x1::ascii::String, address>(&v0.referral_codes, v4);
        v3.referrer = 0x1::option::some<address>(v5);
        let v6 = &mut v0.user_points;
        let v7 = ReferralEvent{
            referrer            : v5,
            referee             : v1,
            points_earned       : 0,
            total_points_earned : get_or_create_user_point(v6, v5).total_points_earned,
            reason              : 0x1::string::utf8(b"referred"),
        };
        0x2::event::emit<ReferralEvent>(v7);
    }

    public fun set_claim_window_sec(arg0: &0xa668c32a8246c35598572560865d1843bfce6d929e0ab5c696cae3c10b003e86::app::AdminCap, arg1: &mut 0xa668c32a8246c35598572560865d1843bfce6d929e0ab5c696cae3c10b003e86::app::GilderApp, arg2: u64) {
        0xa668c32a8246c35598572560865d1843bfce6d929e0ab5c696cae3c10b003e86::app::app_object_mut<0xa668c32a8246c35598572560865d1843bfce6d929e0ab5c696cae3c10b003e86::version::PointV1, Points>(arg1).config.claim_window_sec = arg2;
    }

    public fun set_complete_sign_up_reward(arg0: &0xa668c32a8246c35598572560865d1843bfce6d929e0ab5c696cae3c10b003e86::app::AdminCap, arg1: &mut 0xa668c32a8246c35598572560865d1843bfce6d929e0ab5c696cae3c10b003e86::app::GilderApp, arg2: u64) {
        0xa668c32a8246c35598572560865d1843bfce6d929e0ab5c696cae3c10b003e86::app::app_object_mut<0xa668c32a8246c35598572560865d1843bfce6d929e0ab5c696cae3c10b003e86::version::PointV1, Points>(arg1).config.complete_sign_up_reward = arg2;
    }

    public fun set_cooldown_sec(arg0: &0xa668c32a8246c35598572560865d1843bfce6d929e0ab5c696cae3c10b003e86::app::AdminCap, arg1: &mut 0xa668c32a8246c35598572560865d1843bfce6d929e0ab5c696cae3c10b003e86::app::GilderApp, arg2: u64) {
        0xa668c32a8246c35598572560865d1843bfce6d929e0ab5c696cae3c10b003e86::app::app_object_mut<0xa668c32a8246c35598572560865d1843bfce6d929e0ab5c696cae3c10b003e86::version::PointV1, Points>(arg1).config.cooldown_sec = arg2;
    }

    public fun set_point_per_day(arg0: &0xa668c32a8246c35598572560865d1843bfce6d929e0ab5c696cae3c10b003e86::app::AdminCap, arg1: &mut 0xa668c32a8246c35598572560865d1843bfce6d929e0ab5c696cae3c10b003e86::app::GilderApp, arg2: u64) {
        0xa668c32a8246c35598572560865d1843bfce6d929e0ab5c696cae3c10b003e86::app::app_object_mut<0xa668c32a8246c35598572560865d1843bfce6d929e0ab5c696cae3c10b003e86::version::PointV1, Points>(arg1).config.point_per_day = arg2;
    }

    public fun set_referral_reward_percentage(arg0: &0xa668c32a8246c35598572560865d1843bfce6d929e0ab5c696cae3c10b003e86::app::AdminCap, arg1: &mut 0xa668c32a8246c35598572560865d1843bfce6d929e0ab5c696cae3c10b003e86::app::GilderApp, arg2: u8) {
        assert!(arg2 <= 100, 103);
        0xa668c32a8246c35598572560865d1843bfce6d929e0ab5c696cae3c10b003e86::app::app_object_mut<0xa668c32a8246c35598572560865d1843bfce6d929e0ab5c696cae3c10b003e86::version::PointV1, Points>(arg1).config.referral_reward_percentage = arg2;
    }

    public fun set_streak_denominator(arg0: &0xa668c32a8246c35598572560865d1843bfce6d929e0ab5c696cae3c10b003e86::app::AdminCap, arg1: &mut 0xa668c32a8246c35598572560865d1843bfce6d929e0ab5c696cae3c10b003e86::app::GilderApp, arg2: u64) {
        0xa668c32a8246c35598572560865d1843bfce6d929e0ab5c696cae3c10b003e86::app::app_object_mut<0xa668c32a8246c35598572560865d1843bfce6d929e0ab5c696cae3c10b003e86::version::PointV1, Points>(arg1).config.streak_denominator = arg2;
    }

    public fun set_streak_threshold(arg0: &0xa668c32a8246c35598572560865d1843bfce6d929e0ab5c696cae3c10b003e86::app::AdminCap, arg1: &mut 0xa668c32a8246c35598572560865d1843bfce6d929e0ab5c696cae3c10b003e86::app::GilderApp, arg2: u64) {
        0xa668c32a8246c35598572560865d1843bfce6d929e0ab5c696cae3c10b003e86::app::app_object_mut<0xa668c32a8246c35598572560865d1843bfce6d929e0ab5c696cae3c10b003e86::version::PointV1, Points>(arg1).config.streak_threshold = arg2;
    }

    public fun update_coin_metadata(arg0: &0xa668c32a8246c35598572560865d1843bfce6d929e0ab5c696cae3c10b003e86::app::AdminCap, arg1: &mut 0xa668c32a8246c35598572560865d1843bfce6d929e0ab5c696cae3c10b003e86::app::GilderApp, arg2: &mut 0x2::coin::CoinMetadata<POINT>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>) {
        let v0 = 0xa668c32a8246c35598572560865d1843bfce6d929e0ab5c696cae3c10b003e86::app::app_object_mut<0xa668c32a8246c35598572560865d1843bfce6d929e0ab5c696cae3c10b003e86::version::PointV1, 0x2::coin::TreasuryCap<POINT>>(arg1);
        0x2::coin::update_name<POINT>(v0, arg2, 0x1::string::utf8(arg3));
        0x2::coin::update_symbol<POINT>(v0, arg2, 0x1::ascii::string(arg4));
        0x2::coin::update_description<POINT>(v0, arg2, 0x1::string::utf8(arg5));
        0x2::coin::update_icon_url<POINT>(v0, arg2, 0x1::ascii::string(arg6));
    }

    public fun user_point_from_address(arg0: &mut 0xa668c32a8246c35598572560865d1843bfce6d929e0ab5c696cae3c10b003e86::app::GilderApp, arg1: address) : &UserPoint {
        let v0 = &mut 0xa668c32a8246c35598572560865d1843bfce6d929e0ab5c696cae3c10b003e86::app::app_object_mut<0xa668c32a8246c35598572560865d1843bfce6d929e0ab5c696cae3c10b003e86::version::PointV1, Points>(arg0).user_points;
        get_or_create_user_point(v0, arg1)
    }

    // decompiled from Move bytecode v6
}

