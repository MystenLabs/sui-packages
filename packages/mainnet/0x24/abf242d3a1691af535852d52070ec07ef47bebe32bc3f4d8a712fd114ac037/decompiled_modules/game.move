module 0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game {
    fun abort_status(arg0: u8) {
        assert!(arg0 != 1, 13837594366615486481);
        assert!(arg0 != 4, 13838157320864137237);
        assert!(arg0 != 5, 13836468475298185227);
        assert!(arg0 != 6, 13836187004616310793);
        assert!(arg0 != 7, 13837594383795355665);
        assert!(arg0 == 0, 13835905538229403655);
    }

    fun admin(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg1: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::AuthorityCap<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::PACKAGE, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::ADMIN>) {
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::assert_version(arg0);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::assert_admin(0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config>(arg0), arg1);
    }

    public fun award_achievement<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::access::Auth, arg1: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg3: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::AuthorityCap<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::PACKAGE, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::GAME_KEEPER>, arg4: address, arg5: u8, arg6: &0x2::clock::Clock) {
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::assert_version(arg2);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::assert_role<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::GAME_KEEPER>(0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::uid(arg2), 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config>(arg2), arg3);
        award_inner<T0>(arg0, arg1, arg2, arg4, arg5, 0x2::clock::timestamp_ms(arg6));
    }

    public fun award_achievement_as_admin<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::access::Auth, arg1: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg3: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::AuthorityCap<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::PACKAGE, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::ADMIN>, arg4: address, arg5: u8, arg6: &0x2::clock::Clock) {
        admin(arg2, arg3);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::events::emit_admin_action(arg0, 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config>(arg2), 52);
        award_inner<T0>(arg0, arg1, arg2, arg4, arg5, 0x2::clock::timestamp_ms(arg6));
    }

    fun award_inner<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::access::Auth, arg1: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg3: address, arg4: u8, arg5: u64) {
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::assert_unpaused(arg2, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::pause_game());
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::assert_version<T0>(arg1);
        assert!(0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game_book::enabled(0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::uid(arg2)), 13835060954385088513);
        abort_status(0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game_book::award(arg0, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::uid_mut<T0>(arg0, arg1), 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::uid(arg2), arg3, arg4, arg5));
    }

    fun check_crate_open<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg1: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::Account<T0>, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config) {
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::assert_unpaused(arg2, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::pause_game());
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::assert_version(arg2);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::assert_version<T0>(arg0);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::assert_exchange<T0>(arg1, 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>>(arg0));
        assert!(0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game_book::enabled(0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::uid(arg2)), 13835060735341756417);
        let (v0, v1) = 0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game_book::crate_weights(0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::uid(arg2));
        assert!(v0 + v1 > 0, 13835905168862216199);
    }

    public fun claim_daily<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::access::Auth, arg1: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::Account<T0>, arg3: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::AccountCap, arg4: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg5: &0x2::clock::Clock) {
        owner<T0>(arg1, arg2, arg3, arg4);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::assert_unpaused(arg4, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::pause_game());
        let v0 = 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::owner<T0>(arg2);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        let (v2, v3, v4, v5) = 0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game_book::preview_daily(0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::uid(arg4), 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::uid<T0>(arg1), v0, v1);
        assert!(v2 != 1, 13835059661599932417);
        assert!(v2 != 2, 13835341140871741443);
        assert!(v2 == 0, 13835904095120392199);
        0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game_book::commit_daily(arg0, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::uid_mut<T0>(arg0, arg1), 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::uid(arg4), v0, v5, v3, v4, v1);
    }

    public fun claim_quest<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::access::Auth, arg1: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::Account<T0>, arg3: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::AccountCap, arg4: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg5: u8, arg6: &0x2::clock::Clock) {
        owner<T0>(arg1, arg2, arg3, arg4);
        finish_quest<T0>(arg0, arg1, arg4, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::owner<T0>(arg2), arg5, 0x2::clock::timestamp_ms(arg6), false);
    }

    fun complete_inner<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::access::Auth, arg1: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg3: address, arg4: u8, arg5: u64) {
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::assert_version<T0>(arg1);
        finish_quest<T0>(arg0, arg1, arg2, arg3, arg4, arg5, true);
    }

    public fun complete_quest<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::access::Auth, arg1: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg3: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::AuthorityCap<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::PACKAGE, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::GAME_KEEPER>, arg4: address, arg5: u8, arg6: &0x2::clock::Clock) {
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::assert_version(arg2);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::assert_role<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::GAME_KEEPER>(0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::uid(arg2), 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config>(arg2), arg3);
        complete_inner<T0>(arg0, arg1, arg2, arg4, arg5, 0x2::clock::timestamp_ms(arg6));
    }

    public fun complete_quest_as_admin<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::access::Auth, arg1: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg3: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::AuthorityCap<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::PACKAGE, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::ADMIN>, arg4: address, arg5: u8, arg6: &0x2::clock::Clock) {
        admin(arg2, arg3);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::events::emit_admin_action(arg0, 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config>(arg2), 51);
        complete_inner<T0>(arg0, arg1, arg2, arg4, arg5, 0x2::clock::timestamp_ms(arg6));
    }

    fun cosmetic_known<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg1: &0x1::option::Option<u8>) : bool {
        0x1::option::is_none<u8>(arg1) || 0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game_book::cosmetic_exists(0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::uid<T0>(arg0), *0x1::option::borrow<u8>(arg1))
    }

    fun crate_book<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::access::Auth, arg1: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::Account<T0>, arg3: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg4: u64) : (&mut 0x2::object::UID, vector<u64>) {
        check_crate_open<T0>(arg1, arg2, arg3);
        let v0 = 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::owner<T0>(arg2);
        let v1 = 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::uid_mut<T0>(arg0, arg1);
        assert!(arg4 >= 1, 13838719983055011865);
        assert!(0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game_book::player_crates(v1, v0) >= arg4, 13837031137488928781);
        (v1, 0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game_book::apply_pending_effects(arg0, v1, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::uid(arg3), v0))
    }

    fun finish_quest<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::access::Auth, arg1: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg3: address, arg4: u8, arg5: u64, arg6: bool) {
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::assert_unpaused(arg2, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::pause_game());
        assert!(0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game_book::enabled(0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::uid(arg2)), 13835060902845480961);
        abort_status(0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game_book::claim_quest(arg0, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::uid_mut<T0>(arg0, arg1), 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::uid(arg2), arg3, arg4, arg5, arg6));
    }

    fun grant_season_inner<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::access::Auth, arg1: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg3: address, arg4: u64) {
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::assert_unpaused(arg2, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::pause_game());
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::assert_version<T0>(arg1);
        assert!(0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game_book::enabled(0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::uid(arg2)), 13835060988744826881);
        let (v0, _, _) = 0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game_book::season(0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::uid(arg2));
        assert!(v0 != 0, 13835905422265286663);
        assert!(arg4 >= 1 && arg4 <= 0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game_book::max_season_reward(0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::uid(arg2)), 13835905426560253959);
        assert!(0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game_book::player_season_rewarded(0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::uid<T0>(arg1), arg3) != v0, 13837875755692982291);
        assert!(0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::account_exists(0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::uid<T0>(arg1), arg3), 13837312810034266127);
        0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game_book::mark_season_rewarded(arg0, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::uid_mut<T0>(arg0, arg1), arg3, v0);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::events::emit_season_reward_event(arg0, arg3, v0, 0);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::assert_identity<T0>(arg1);
    }

    public fun grant_season_reward<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::access::Auth, arg1: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg3: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::AuthorityCap<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::PACKAGE, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::GAME_KEEPER>, arg4: address, arg5: u64) {
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::assert_version(arg2);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::assert_role<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::GAME_KEEPER>(0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::uid(arg2), 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config>(arg2), arg3);
        grant_season_inner<T0>(arg0, arg1, arg2, arg4, arg5);
    }

    public fun grant_season_reward_as_admin<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::access::Auth, arg1: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg3: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::AuthorityCap<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::PACKAGE, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::ADMIN>, arg4: address, arg5: u64) {
        admin(arg2, arg3);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::events::emit_admin_action(arg0, 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config>(arg2), 50);
        grant_season_inner<T0>(arg0, arg1, arg2, arg4, arg5);
    }

    public fun level_of(arg0: u64) : u64 {
        0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game_book::level_of(arg0)
    }

    fun name_ok(arg0: &vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(arg0);
        v0 >= 1 && v0 <= 32
    }

    public fun on_close<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::access::Auth, arg1: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg3: address, arg4: u64, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: bool, arg16: u64, arg17: u64) {
        let v0 = if (arg7 < arg6) {
            arg7
        } else {
            arg6
        };
        let v1 = if (arg17 > arg8) {
            arg17 - arg8
        } else {
            0
        };
        let v2 = 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::game_paused(arg2);
        let (v3, v4) = if (arg14 >= arg10) {
            (arg14 - arg10, 0)
        } else {
            (0, arg10 - arg14)
        };
        0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game_book::note_trade_close_v2(arg0, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::uid_mut<T0>(arg0, arg1), 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::uid(arg2), arg3, arg4, arg5, v0, v1, arg15, v2, v3, v4);
        if (v2) {
            0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game_book::note_fee_credit(arg0, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::uid_mut<T0>(arg0, arg1), arg3, arg16);
            return
        };
        0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game_book::note_close(arg0, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::uid_mut<T0>(arg0, arg1), 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::uid(arg2), arg3, 0x1::option::some<0x2::object::ID>(arg5), v0, v1, arg11, arg12, arg13, arg9, arg10, arg15, arg16, arg17);
    }

    public fun on_loss<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::access::Auth, arg1: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg3: address, arg4: u64, arg5: u64, arg6: u64) {
        0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game_book::note_liquidation_loss(arg0, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::uid_mut<T0>(arg0, arg1), arg3, arg4);
        if (0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::game_paused(arg2)) {
            0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game_book::note_fee_credit(arg0, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::uid_mut<T0>(arg0, arg1), arg3, arg5);
            return
        };
        0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game_book::note_close(arg0, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::uid_mut<T0>(arg0, arg1), 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::uid(arg2), arg3, 0x1::option::none<0x2::object::ID>(), 0, 0, 1, 0, 0, 0, 0, false, arg5, arg6);
    }

    public fun on_open<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::access::Auth, arg1: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg3: address, arg4: 0x2::object::ID, arg5: u64) {
        if (!0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game_book::enabled(0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::uid(arg2)) || 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::game_paused(arg2)) {
            return
        };
        0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game_book::note_open(arg0, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::uid_mut<T0>(arg0, arg1), 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::uid(arg2), arg3, arg4, arg5);
    }

    public fun on_open_fee<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::access::Auth, arg1: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg2: address, arg3: u64) {
        0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game_book::note_open_fee(arg0, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::uid_mut<T0>(arg0, arg1), arg2, arg3);
    }

    public fun on_partial_close<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::access::Auth, arg1: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg3: address, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: bool, arg11: u64, arg12: u64) {
        on_partial_close_v2<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, 0, arg9, arg10, arg11, arg12);
    }

    public fun on_partial_close_v2<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::access::Auth, arg1: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg3: address, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: bool, arg12: u64, arg13: u64) {
        let v0 = if (arg6 < arg5) {
            arg6
        } else {
            arg5
        };
        let v1 = if (arg13 > arg7) {
            arg13 - arg7
        } else {
            0
        };
        let (v2, v3) = if (arg10 >= arg8) {
            (arg10 - arg8, 0)
        } else {
            (0, arg8 - arg10)
        };
        0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game_book::note_partial_close_v2(arg0, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::uid_mut<T0>(arg0, arg1), 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::uid(arg2), arg3, arg4, v0, v1, arg11, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::game_paused(arg2), v2, v3, arg9, arg12, arg13);
    }

    public fun open_crate<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::access::Auth, arg1: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::Account<T0>, arg3: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::AccountCap, arg4: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg5: &0x2::random::Random, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        open_crates<T0>(arg0, arg1, arg2, arg3, arg4, 1, arg5, arg6, arg7);
    }

    public fun open_crates<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::access::Auth, arg1: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::Account<T0>, arg3: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::AccountCap, arg4: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg5: u64, arg6: &0x2::random::Random, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::assert_cap<T0>(arg2, arg3);
        let (v0, v1) = crate_book<T0>(arg0, arg1, arg2, arg4, arg5);
        let v2 = 0x2::random::new_generator(arg6, arg8);
        0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game_book::open_crates(arg0, v0, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::uid(arg4), 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::owner<T0>(arg2), arg5, &mut v2, 0x2::clock::timestamp_ms(arg7), v1);
    }

    public fun owner<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg1: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::Account<T0>, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::AccountCap, arg3: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config) {
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::assert_version(arg3);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::assert_version<T0>(arg0);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::assert_exchange<T0>(arg1, 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>>(arg0));
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::assert_cap<T0>(arg1, arg2);
    }

    fun param_ok(arg0: u8, arg1: u64) : bool {
        0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game_book::param_ok(arg0, arg1)
    }

    public fun player_level_cursor<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg1: address) : u64 {
        0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game_book::player_level_cursor(0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::uid<T0>(arg0), arg1)
    }

    public fun progression_params(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config) : 0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game_book::ProgressionParams {
        0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game_book::progression_params(0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::uid(arg0))
    }

    public fun register_achievement<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::access::Auth, arg1: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg2: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg3: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::AuthorityCap<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::PACKAGE, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::ADMIN>, arg4: vector<u8>, arg5: u8, arg6: u64, arg7: u64, arg8: u64, arg9: 0x1::option::Option<u8>) : u8 {
        admin(arg2, arg3);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::events::emit_admin_action(arg0, 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config>(arg2), 58);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::assert_version<T0>(arg1);
        assert!(0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game_book::achievement_count(0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::uid<T0>(arg1)) < 128, 13838436850220793879);
        assert!(name_ok(&arg4), 13835903579724316679);
        assert!(param_ok(arg5, arg6), 13835903584019283975);
        assert!(arg8 == 0 || arg5 == 8, 13835903588314251271);
        assert!(0xfbca715d01aa8698251ea1fd8452cb5a8a4d919f1733dc705acd57b53331193c::safety::achievement_mint_allowance(arg6, 0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game_book::achievement_mint_fraction_bps(0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::uid(arg2)), arg8) == arg8, 13835903592609218567);
        assert!(arg7 <= 0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game_book::max_xp_grant(0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::uid(arg2)), 13835903596904185863);
        assert!(cosmetic_known<T0>(arg1, &arg9), 13836185076175994889);
        let v0 = 0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game_book::add_achievement(arg0, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::uid_mut<T0>(arg0, arg1), arg4, arg5, arg6, arg7, arg8, arg9);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::events::emit_achievement_registered_event(arg0, v0, arg4, arg5, arg6, arg7, arg8, arg9, true);
        v0
    }

    public fun register_cosmetic<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::access::Auth, arg1: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg3: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::AuthorityCap<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::PACKAGE, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::ADMIN>, arg4: vector<u8>) : u8 {
        admin(arg2, arg3);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::events::emit_admin_action(arg0, 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config>(arg2), 54);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::assert_version<T0>(arg1);
        assert!(0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game_book::cosmetic_count(0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::uid<T0>(arg1)) < 128, 13838437172343341079);
        assert!(name_ok(&arg4), 13835903901846863879);
        let v0 = 0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game_book::add_cosmetic(arg0, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::uid_mut<T0>(arg0, arg1), arg4);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::events::emit_cosmetic_registered_event(arg0, v0, arg4);
        v0
    }

    public fun register_quest<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::access::Auth, arg1: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg2: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg3: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::AuthorityCap<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::PACKAGE, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::ADMIN>, arg4: vector<u8>, arg5: u8, arg6: u64, arg7: u64, arg8: 0x1::option::Option<u8>, arg9: u64, arg10: u64, arg11: u64) : u8 {
        admin(arg2, arg3);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::events::emit_admin_action(arg0, 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config>(arg2), 56);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::assert_version<T0>(arg1);
        assert!(0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game_book::quest_count(0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::uid<T0>(arg1)) < 128, 13838437022019485719);
        assert!(name_ok(&arg4), 13835903751523008519);
        assert!(param_ok(arg5, arg6), 13835903755817975815);
        assert!(arg7 <= 0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game_book::max_xp_grant(0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::uid(arg2)), 13835903760112943111);
        assert!(arg10 == 0 || arg10 > arg9, 13835903764407910407);
        assert!(cosmetic_known<T0>(arg1, &arg8), 13836185243679719433);
        let v0 = 0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game_book::add_quest(arg0, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::uid_mut<T0>(arg0, arg1), arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::events::emit_quest_registered_event(arg0, v0, arg4, arg5, arg6, arg7, 0, arg8, true, arg9, arg10, arg11);
        v0
    }

    public fun roll_season(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::access::Auth, arg1: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::AuthorityCap<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::PACKAGE, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::ADMIN>, arg3: u64, arg4: u64) {
        admin(arg1, arg2);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::events::emit_admin_action(arg0, 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config>(arg1), 59);
        assert!(arg4 > arg3, 13835903480940068871);
        assert!(arg4 - arg3 <= 31622400000, 13835903485235036167);
        let (v0, _, _) = 0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game_book::season(0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::uid(arg1));
        assert!(v0 < 18446744073709551615, 13835903493824970759);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::events::emit_season_rolled_event(arg0, 0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game_book::roll_season(arg0, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::uid_mut(arg0, arg1), arg3, arg4), arg3, arg4);
    }

    public fun set_achievement_active<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::access::Auth, arg1: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg3: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::AuthorityCap<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::PACKAGE, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::ADMIN>, arg4: u8, arg5: bool) {
        admin(arg2, arg3);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::events::emit_admin_action(arg0, 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config>(arg2), 57);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::assert_version<T0>(arg1);
        assert!(0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game_book::achievement_exists(0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::uid<T0>(arg1), arg4), 13836185132010569737);
        0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game_book::set_achievement_active(arg0, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::uid_mut<T0>(arg0, arg1), arg4, arg5);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::events::emit_achievement_active_event(arg0, arg4, arg5);
    }

    public fun set_achievement_mint_fraction_bps(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::access::Auth, arg1: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::AuthorityCap<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::PACKAGE, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::ADMIN>, arg3: u64) {
        admin(arg1, arg2);
        assert!(arg3 <= 10000, 13835905628423716871);
        0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game_book::set_achievement_mint_fraction_bps(arg0, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::uid_mut(arg0, arg1), arg3);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::events::emit_admin_action(arg0, 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config>(arg1), 49);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::events::emit_achievement_mint_fraction_event(arg0, arg3);
    }

    public fun set_crate_params(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::access::Auth, arg1: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::AuthorityCap<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::PACKAGE, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::ADMIN>, arg3: u64, arg4: u64) {
        admin(arg1, arg2);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::events::emit_admin_action(arg0, 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config>(arg1), 63);
        assert!(arg3 <= 0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game_book::max_xp_grant(0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::uid(arg1)), 13835903068623208455);
        assert!(arg4 <= 1000000000000000, 13835903072918175751);
        assert!(0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game_book::crate_xp_ok(arg3, arg4), 13835903077213143047);
        0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game_book::set_crate_params(arg0, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::uid_mut(arg0, arg1), arg3, arg4);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::events::emit_crate_params_event(arg0, arg3, arg4);
    }

    public fun set_crate_pool<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::access::Auth, arg1: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg3: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::AuthorityCap<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::PACKAGE, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::ADMIN>, arg4: vector<u8>, arg5: vector<u64>) {
        admin(arg2, arg3);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::events::emit_admin_action(arg0, 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config>(arg2), 53);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::assert_version<T0>(arg1);
        assert!(0x1::vector::length<u8>(&arg4) <= 128, 13835903966271373319);
        assert!(0x1::vector::length<u64>(&arg5) == 0x1::vector::length<u8>(&arg4), 13835903970566340615);
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(&arg4)) {
            let v1 = *0x1::vector::borrow<u8>(&arg4, v0);
            assert!(0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game_book::cosmetic_exists(0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::uid<T0>(arg1), v1), 13836185462723051529);
            assert!(*0x1::vector::borrow<u64>(&arg5, v0) >= 1 && *0x1::vector::borrow<u64>(&arg5, v0) <= 1000000, 13835903992041177095);
            let v2 = 0;
            while (v2 < v0) {
                assert!(*0x1::vector::borrow<u8>(&arg4, v2) != v1, 13835904004926078983);
                v2 = v2 + 1;
            };
            v0 = v0 + 1;
        };
        0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game_book::set_crate_pool(arg0, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::uid_mut<T0>(arg0, arg1), arg4, arg5);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::events::emit_crate_pool_event(arg0, arg4, arg5);
    }

    public fun set_crate_weights(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::access::Auth, arg1: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::AuthorityCap<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::PACKAGE, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::ADMIN>, arg3: u64, arg4: u64) {
        admin(arg1, arg2);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::events::emit_admin_action(arg0, 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config>(arg1), 62);
        assert!(arg3 <= 1000000, 13835903364975951879);
        assert!(arg4 <= 1000000, 13835903369270919175);
        assert!(arg3 + arg4 > 0, 13835903373565886471);
        0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game_book::set_weights(arg0, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::uid_mut(arg0, arg1), arg3, arg4);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::events::emit_crate_weights_event(arg0, 0, arg3, arg4);
    }

    public fun set_daily_drop(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::access::Auth, arg1: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::AuthorityCap<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::PACKAGE, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::ADMIN>, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        admin(arg1, arg2);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::events::emit_admin_action(arg0, 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config>(arg1), 65);
        assert!(arg3 <= 100000000000, 13835902866759745543);
        assert!(arg4 <= 100000000000, 13835902871054712839);
        assert!(arg5 <= 100000000000, 13835902875349680135);
        assert!(arg3 <= arg5, 13835902879644647431);
        assert!(arg6 >= 1 && arg6 <= 10000, 13835902883939614727);
        0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game_book::set_daily(arg0, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::uid_mut(arg0, arg1), arg3, arg4, arg5, arg6);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::events::emit_daily_drop_event(arg0, arg3, arg4, arg5, arg6);
    }

    public fun set_fee_xp_rate(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::access::Auth, arg1: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::AuthorityCap<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::PACKAGE, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::ADMIN>, arg3: u64) {
        admin(arg1, arg2);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::events::emit_admin_action(arg0, 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config>(arg1), 99);
        assert!(0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game_book::fee_xp_rate_ok(arg3), 13835903120162816007);
        0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game_book::set_fee_xp_rate(arg0, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::uid_mut(arg0, arg1), arg3);
    }

    public fun set_game_enabled(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::access::Auth, arg1: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::AuthorityCap<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::PACKAGE, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::ADMIN>, arg3: bool) {
        admin(arg1, arg2);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::events::emit_admin_action(arg0, 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config>(arg1), 69);
        0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game_book::set_enabled(arg0, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::uid_mut(arg0, arg1), arg3);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::events::emit_game_enabled_event(arg0, arg3);
    }

    public fun set_global_mint_cap(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::access::Auth, arg1: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::AuthorityCap<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::PACKAGE, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::ADMIN>, arg3: u64) {
        admin(arg1, arg2);
        assert!(arg3 <= 1000000000000000, 13835902952659091463);
        let v0 = 0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game_book::wallet_mint_cap(0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::uid(arg1));
        0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game_book::set_mint_caps(arg0, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::uid_mut(arg0, arg1), v0, arg3);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::events::emit_mint_caps_event(arg0, v0, arg3);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::events::emit_admin_action(arg0, 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config>(arg1), 41);
    }

    public fun set_level_crates(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::access::Auth, arg1: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::AuthorityCap<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::PACKAGE, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::ADMIN>, arg3: u64) {
        admin(arg1, arg2);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::events::emit_admin_action(arg0, 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config>(arg1), 102);
        assert!(0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game_book::level_crates_ok(arg3), 13835903283371573255);
        0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game_book::set_level_crates(arg0, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::uid_mut(arg0, arg1), arg3);
    }

    public fun set_quest_active<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::access::Auth, arg1: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg3: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::AuthorityCap<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::PACKAGE, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::ADMIN>, arg4: u8, arg5: bool) {
        admin(arg2, arg3);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::events::emit_admin_action(arg0, 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config>(arg2), 55);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::assert_version<T0>(arg1);
        assert!(0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game_book::quest_exists(0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::uid<T0>(arg1), arg4), 13836185325284098057);
        0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game_book::set_quest_active(arg0, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::uid_mut<T0>(arg0, arg1), arg4, arg5);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::events::emit_quest_active_event(arg0, arg4, arg5);
    }

    public fun set_quest_bounds(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::access::Auth, arg1: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::AuthorityCap<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::PACKAGE, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::ADMIN>, arg3: u64) {
        admin(arg1, arg2);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::events::emit_admin_action(arg0, 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config>(arg1), 61);
        assert!(arg3 >= 1 && arg3 <= 1000000000, 13835903412220592135);
        0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game_book::set_quest_bounds(arg0, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::uid_mut(arg0, arg1), arg3);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::events::emit_quest_bounds_event(arg0, 0, 0, arg3);
    }

    public fun set_season_reward_ceiling(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::access::Auth, arg1: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::AuthorityCap<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::PACKAGE, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::ADMIN>, arg3: u64) {
        admin(arg1, arg2);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::events::emit_admin_action(arg0, 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config>(arg1), 60);
        assert!(arg3 >= 1 && arg3 <= 100000000000, 13835903446580330503);
        0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game_book::set_season_ceiling(arg0, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::uid_mut(arg0, arg1), arg3);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::events::emit_season_ceiling_event(arg0, arg3);
    }

    public fun set_tier_name(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::access::Auth, arg1: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::AuthorityCap<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::PACKAGE, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::ADMIN>, arg3: u8, arg4: vector<u8>) {
        admin(arg1, arg2);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::events::emit_admin_action(arg0, 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config>(arg1), 66);
        assert!((arg3 as u64) <= 0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game_book::tier_threshold_count(0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::uid(arg1)), 13835902806630203399);
        assert!(name_ok(&arg4), 13835902810925170695);
        0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game_book::set_tier_name(arg0, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::uid_mut(arg0, arg1), (arg3 as u64), arg4);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::events::emit_tier_renamed_event(arg0, arg3, arg4);
    }

    public fun set_tier_thresholds(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::access::Auth, arg1: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::AuthorityCap<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::PACKAGE, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::ADMIN>, arg3: vector<u64>) {
        admin(arg1, arg2);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::events::emit_admin_action(arg0, 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config>(arg1), 67);
        let v0 = 0x1::vector::length<u64>(&arg3);
        assert!(v0 >= 1 && v0 <= 32, 13835902733615759367);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<u64>(&arg3, v1);
            assert!(v2 > 0 && v2 <= 1000000000000000, 13835902755090595847);
            v1 = v1 + 1;
        };
        0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game_book::set_tier_thresholds(arg0, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::uid_mut(arg0, arg1), arg3);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::events::emit_tier_table_event(arg0, arg3);
    }

    public fun set_volume_xp(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::access::Auth, arg1: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::AuthorityCap<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::PACKAGE, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::ADMIN>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64) {
        admin(arg1, arg2);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::events::emit_admin_action(arg0, 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config>(arg1), 100);
        assert!(0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game_book::volume_xp_ok(arg3, arg4, arg5, arg6, arg7, arg8), 13835903184587325447);
        0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game_book::set_volume_xp(arg0, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::uid_mut(arg0, arg1), arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public fun set_wallet_mint_cap(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::access::Auth, arg1: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::AuthorityCap<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::PACKAGE, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::ADMIN>, arg3: u64) {
        admin(arg1, arg2);
        assert!(arg3 <= 1000000000000000, 13835902914004385799);
        let v0 = 0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game_book::global_mint_cap(0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::uid(arg1));
        0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game_book::set_mint_caps(arg0, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::uid_mut(arg0, arg1), arg3, v0);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::events::emit_mint_caps_event(arg0, arg3, v0);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::events::emit_admin_action(arg0, 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config>(arg1), 40);
    }

    public fun set_win_rules(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::access::Auth, arg1: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::AuthorityCap<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::PACKAGE, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::ADMIN>, arg3: u64, arg4: u64, arg5: u64) {
        admin(arg1, arg2);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::events::emit_admin_action(arg0, 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config>(arg1), 101);
        assert!(0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game_book::win_rules_ok(arg3, arg4, arg5), 13835903240421900295);
        0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game_book::set_win_rules(arg0, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::uid_mut(arg0, arg1), arg3, arg4, arg5);
    }

    public fun set_win_xp(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::access::Auth, arg1: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::AuthorityCap<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::PACKAGE, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::ADMIN>, arg3: u64, arg4: u64) {
        admin(arg1, arg2);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::events::emit_admin_action(arg0, 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config>(arg1), 64);
        assert!(arg3 <= 1000000, 13835902995608764423);
        assert!(arg4 >= 1 && arg4 <= 100, 13835902999903731719);
        0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game_book::set_win_xp(arg0, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::uid_mut(arg0, arg1), arg3, arg4);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::events::emit_win_xp_event(arg0, arg3, arg4);
    }

    // decompiled from Move bytecode v7
}

