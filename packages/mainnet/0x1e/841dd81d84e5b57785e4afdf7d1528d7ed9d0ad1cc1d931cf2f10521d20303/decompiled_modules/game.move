module 0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game {
    fun abort_status(arg0: u8) {
        assert!(arg0 != 1, 13837593980068429841);
        assert!(arg0 != 4, 13838156934317080597);
        assert!(arg0 != 5, 13836468088751128587);
        assert!(arg0 != 6, 13836186618069254153);
        assert!(arg0 != 7, 13837593997248299025);
        assert!(arg0 == 0, 13835905151682347015);
    }

    fun admin(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::AuthorityCap<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::PACKAGE, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::ADMIN>) {
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::assert_version(arg0);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::assert_admin(0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config>(arg0), arg1);
    }

    public fun award_achievement<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg3: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::AuthorityCap<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::PACKAGE, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::GAME_KEEPER>, arg4: address, arg5: u8, arg6: &0x2::clock::Clock) {
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::assert_version(arg2);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::assert_role<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::GAME_KEEPER>(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid(arg2), 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config>(arg2), arg3);
        award_inner<T0>(arg0, arg1, arg2, arg4, arg5, 0x2::clock::timestamp_ms(arg6));
    }

    public fun award_achievement_as_admin<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg3: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::AuthorityCap<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::PACKAGE, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::ADMIN>, arg4: address, arg5: u8, arg6: &0x2::clock::Clock) {
        admin(arg2, arg3);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::events::emit_admin_action(arg0, 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config>(arg2), 52);
        award_inner<T0>(arg0, arg1, arg2, arg4, arg5, 0x2::clock::timestamp_ms(arg6));
    }

    fun award_inner<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg3: address, arg4: u8, arg5: u64) {
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::assert_unpaused(arg2, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::pause_game());
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::assert_version<T0>(arg1);
        assert!(0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::enabled(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid(arg2)), 13835060567838031873);
        abort_status(0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::award(arg0, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid_mut<T0>(arg0, arg1), 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid(arg2), arg3, arg4, arg5));
    }

    fun check_crate_open<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::Account<T0>, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config) {
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::assert_unpaused(arg2, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::pause_game());
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::assert_version(arg2);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::assert_version<T0>(arg0);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::assert_exchange<T0>(arg1, 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>>(arg0));
        assert!(0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::enabled(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid(arg2)), 13835060348794699777);
        let (v0, v1) = 0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::crate_weights(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid(arg2));
        assert!(v0 + v1 > 0, 13835904782315159559);
    }

    public fun claim_daily<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::Account<T0>, arg3: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::AccountCap, arg4: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg5: &0x2::clock::Clock) {
        owner<T0>(arg1, arg2, arg3, arg4);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::assert_unpaused(arg4, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::pause_game());
        let v0 = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::owner<T0>(arg2);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        let (v2, v3, v4, v5) = 0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::preview_daily(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid(arg4), 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid<T0>(arg1), v0, v1);
        assert!(v2 != 1, 13835059412491829249);
        assert!(v2 != 2, 13835340891763638275);
        assert!(v2 == 0, 13835903846012289031);
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::commit_daily(arg0, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid_mut<T0>(arg0, arg1), 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid(arg4), v0, v5, v3, v4, v1);
    }

    public fun claim_quest<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::Account<T0>, arg3: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::AccountCap, arg4: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg5: u8, arg6: &0x2::clock::Clock) {
        owner<T0>(arg1, arg2, arg3, arg4);
        finish_quest<T0>(arg0, arg1, arg4, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::owner<T0>(arg2), arg5, 0x2::clock::timestamp_ms(arg6), false);
    }

    fun complete_inner<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg3: address, arg4: u8, arg5: u64) {
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::assert_version<T0>(arg1);
        finish_quest<T0>(arg0, arg1, arg2, arg3, arg4, arg5, true);
    }

    public fun complete_quest<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg3: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::AuthorityCap<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::PACKAGE, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::GAME_KEEPER>, arg4: address, arg5: u8, arg6: &0x2::clock::Clock) {
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::assert_version(arg2);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::assert_role<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::GAME_KEEPER>(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid(arg2), 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config>(arg2), arg3);
        complete_inner<T0>(arg0, arg1, arg2, arg4, arg5, 0x2::clock::timestamp_ms(arg6));
    }

    public fun complete_quest_as_admin<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg3: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::AuthorityCap<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::PACKAGE, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::ADMIN>, arg4: address, arg5: u8, arg6: &0x2::clock::Clock) {
        admin(arg2, arg3);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::events::emit_admin_action(arg0, 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config>(arg2), 51);
        complete_inner<T0>(arg0, arg1, arg2, arg4, arg5, 0x2::clock::timestamp_ms(arg6));
    }

    fun cosmetic_known<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: &0x1::option::Option<u8>) : bool {
        0x1::option::is_none<u8>(arg1) || 0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::cosmetic_exists(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid<T0>(arg0), *0x1::option::borrow<u8>(arg1))
    }

    fun crate_book<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::Account<T0>, arg3: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg4: u64) : &mut 0x2::object::UID {
        check_crate_open<T0>(arg1, arg2, arg3);
        let v0 = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::owner<T0>(arg2);
        let v1 = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid_mut<T0>(arg0, arg1);
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::apply_pending_effects(arg0, v1, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid(arg3), v0);
        assert!(arg4 >= 1, 13838719596507955225);
        assert!(0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::player_crates(v1, v0) >= arg4, 13837030750941872141);
        v1
    }

    fun finish_quest<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg3: address, arg4: u8, arg5: u64, arg6: bool) {
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::assert_unpaused(arg2, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::pause_game());
        assert!(0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::enabled(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid(arg2)), 13835060516298424321);
        abort_status(0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::claim_quest(arg0, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid_mut<T0>(arg0, arg1), 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid(arg2), arg3, arg4, arg5, arg6));
    }

    fun grant_season_inner<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg3: address, arg4: u64) {
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::assert_unpaused(arg2, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::pause_game());
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::assert_version<T0>(arg1);
        assert!(0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::enabled(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid(arg2)), 13835060602197770241);
        let (v0, _, _) = 0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::season(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid(arg2));
        assert!(v0 != 0, 13835905035718230023);
        assert!(arg4 >= 1 && arg4 <= 0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::max_season_reward(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid(arg2)), 13835905040013197319);
        assert!(0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::player_season_rewarded(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid<T0>(arg1), arg3) != v0, 13837875369145925651);
        assert!(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::account_exists(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid<T0>(arg1), arg3), 13837312423487209487);
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::mark_season_rewarded(arg0, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid_mut<T0>(arg0, arg1), arg3, v0);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::events::emit_season_reward_event(arg0, arg3, v0, 0);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::assert_identity<T0>(arg1);
    }

    public fun grant_season_reward<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg3: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::AuthorityCap<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::PACKAGE, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::GAME_KEEPER>, arg4: address, arg5: u64) {
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::assert_version(arg2);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::assert_role<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::GAME_KEEPER>(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid(arg2), 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config>(arg2), arg3);
        grant_season_inner<T0>(arg0, arg1, arg2, arg4, arg5);
    }

    public fun grant_season_reward_as_admin<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg3: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::AuthorityCap<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::PACKAGE, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::ADMIN>, arg4: address, arg5: u64) {
        admin(arg2, arg3);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::events::emit_admin_action(arg0, 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config>(arg2), 50);
        grant_season_inner<T0>(arg0, arg1, arg2, arg4, arg5);
    }

    fun name_ok(arg0: &vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(arg0);
        v0 >= 1 && v0 <= 32
    }

    public fun on_close<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg3: address, arg4: u64, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: bool, arg16: u64, arg17: u64) {
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
        let v2 = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::game_paused(arg2);
        let (v3, v4) = if (arg14 >= arg10) {
            (arg14 - arg10, 0)
        } else {
            (0, arg10 - arg14)
        };
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::note_trade_close(arg0, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid_mut<T0>(arg0, arg1), arg3, arg4, arg5, v0, v1, arg15, v2, v3, v4);
        if (v2) {
            0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::note_fee_credit(arg0, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid_mut<T0>(arg0, arg1), arg3, arg16);
            return
        };
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::note_close(arg0, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid_mut<T0>(arg0, arg1), 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid(arg2), arg3, 0x1::option::some<0x2::object::ID>(arg5), v0, v1, arg11, arg12, arg13, arg9, arg10, arg15, arg16, arg17);
    }

    public fun on_loss<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg3: address, arg4: u64, arg5: u64, arg6: u64) {
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::note_liquidation_loss(arg0, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid_mut<T0>(arg0, arg1), arg3, arg4);
        if (0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::game_paused(arg2)) {
            0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::note_fee_credit(arg0, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid_mut<T0>(arg0, arg1), arg3, arg5);
            return
        };
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::note_close(arg0, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid_mut<T0>(arg0, arg1), 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid(arg2), arg3, 0x1::option::none<0x2::object::ID>(), 0, 0, 1, 0, 0, 0, 0, false, arg5, arg6);
    }

    public fun on_open<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg3: address, arg4: 0x2::object::ID, arg5: u64) {
        if (!0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::enabled(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid(arg2)) || 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::game_paused(arg2)) {
            return
        };
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::note_open(arg0, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid_mut<T0>(arg0, arg1), 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid(arg2), arg3, arg4, arg5);
    }

    public fun on_open_fee<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: address, arg3: u64) {
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::note_open_fee(arg0, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid_mut<T0>(arg0, arg1), arg2, arg3);
    }

    public fun open_crate<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::Account<T0>, arg3: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::AccountCap, arg4: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg5: &0x2::random::Random, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        open_crates<T0>(arg0, arg1, arg2, arg3, arg4, 1, arg5, arg6, arg7);
    }

    public fun open_crates<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::Account<T0>, arg3: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::AccountCap, arg4: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg5: u64, arg6: &0x2::random::Random, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::assert_cap<T0>(arg2, arg3);
        let v0 = 0x2::random::new_generator(arg6, arg8);
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::open_crates(arg0, crate_book<T0>(arg0, arg1, arg2, arg4, arg5), 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid(arg4), 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::owner<T0>(arg2), arg5, &mut v0, 0x2::clock::timestamp_ms(arg7));
    }

    public fun owner<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::Account<T0>, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::AccountCap, arg3: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config) {
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::assert_version(arg3);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::assert_version<T0>(arg0);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::assert_exchange<T0>(arg1, 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>>(arg0));
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::assert_cap<T0>(arg1, arg2);
    }

    fun param_ok(arg0: u8, arg1: u64) : bool {
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::param_ok(arg0, arg1)
    }

    public fun register_achievement<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg3: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::AuthorityCap<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::PACKAGE, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::ADMIN>, arg4: vector<u8>, arg5: u8, arg6: u64, arg7: u64, arg8: u64, arg9: 0x1::option::Option<u8>) : u8 {
        admin(arg2, arg3);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::events::emit_admin_action(arg0, 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config>(arg2), 58);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::assert_version<T0>(arg1);
        assert!(0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::achievement_count(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid<T0>(arg1)) < 128, 13838436601112690711);
        assert!(name_ok(&arg4), 13835903330616213511);
        assert!(param_ok(arg5, arg6), 13835903334911180807);
        assert!(arg8 == 0 || arg5 == 8, 13835903339206148103);
        assert!(0x2817956d7c935e4b4e6ee09688d40889ad78b2b7303a572ccff2a49476eb07de::safety::achievement_mint_allowance(arg6, 0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::achievement_mint_fraction_bps(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid(arg2)), arg8) == arg8, 13835903343501115399);
        assert!(arg7 <= 0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::max_xp_grant(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid(arg2)), 13835903347796082695);
        assert!(cosmetic_known<T0>(arg1, &arg9), 13836184827067891721);
        let v0 = 0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::add_achievement(arg0, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid_mut<T0>(arg0, arg1), arg4, arg5, arg6, arg7, arg8, arg9);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::events::emit_achievement_registered_event(arg0, v0, arg4, arg5, arg6, arg7, arg8, arg9, true);
        v0
    }

    public fun register_cosmetic<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg3: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::AuthorityCap<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::PACKAGE, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::ADMIN>, arg4: vector<u8>) : u8 {
        admin(arg2, arg3);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::events::emit_admin_action(arg0, 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config>(arg2), 54);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::assert_version<T0>(arg1);
        assert!(0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::cosmetic_count(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid<T0>(arg1)) < 128, 13838436923235237911);
        assert!(name_ok(&arg4), 13835903652738760711);
        let v0 = 0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::add_cosmetic(arg0, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid_mut<T0>(arg0, arg1), arg4);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::events::emit_cosmetic_registered_event(arg0, v0, arg4);
        v0
    }

    public fun register_quest<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg3: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::AuthorityCap<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::PACKAGE, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::ADMIN>, arg4: vector<u8>, arg5: u8, arg6: u64, arg7: u64, arg8: 0x1::option::Option<u8>, arg9: u64, arg10: u64, arg11: u64) : u8 {
        admin(arg2, arg3);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::events::emit_admin_action(arg0, 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config>(arg2), 56);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::assert_version<T0>(arg1);
        assert!(0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::quest_count(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid<T0>(arg1)) < 128, 13838436772911382551);
        assert!(name_ok(&arg4), 13835903502414905351);
        assert!(param_ok(arg5, arg6), 13835903506709872647);
        assert!(arg7 <= 0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::max_xp_grant(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid(arg2)), 13835903511004839943);
        assert!(arg10 == 0 || arg10 > arg9, 13835903515299807239);
        assert!(cosmetic_known<T0>(arg1, &arg8), 13836184994571616265);
        let v0 = 0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::add_quest(arg0, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid_mut<T0>(arg0, arg1), arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::events::emit_quest_registered_event(arg0, v0, arg4, arg5, arg6, arg7, 0, arg8, true, arg9, arg10, arg11);
        v0
    }

    public fun roll_season(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::AuthorityCap<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::PACKAGE, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::ADMIN>, arg3: u64, arg4: u64) {
        admin(arg1, arg2);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::events::emit_admin_action(arg0, 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config>(arg1), 59);
        assert!(arg4 > arg3, 13835903231831965703);
        assert!(arg4 - arg3 <= 31622400000, 13835903236126932999);
        let (v0, _, _) = 0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::season(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid(arg1));
        assert!(v0 < 18446744073709551615, 13835903244716867591);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::events::emit_season_rolled_event(arg0, 0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::roll_season(arg0, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid_mut(arg0, arg1), arg3, arg4), arg3, arg4);
    }

    public fun set_achievement_active<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg3: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::AuthorityCap<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::PACKAGE, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::ADMIN>, arg4: u8, arg5: bool) {
        admin(arg2, arg3);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::events::emit_admin_action(arg0, 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config>(arg2), 57);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::assert_version<T0>(arg1);
        assert!(0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::achievement_exists(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid<T0>(arg1), arg4), 13836184882902466569);
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::set_achievement_active(arg0, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid_mut<T0>(arg0, arg1), arg4, arg5);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::events::emit_achievement_active_event(arg0, arg4, arg5);
    }

    public fun set_achievement_mint_fraction_bps(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::AuthorityCap<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::PACKAGE, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::ADMIN>, arg3: u64) {
        admin(arg1, arg2);
        assert!(arg3 <= 10000, 13835905241876660231);
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::set_achievement_mint_fraction_bps(arg0, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid_mut(arg0, arg1), arg3);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::events::emit_admin_action(arg0, 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config>(arg1), 49);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::events::emit_achievement_mint_fraction_event(arg0, arg3);
    }

    public fun set_crate_params(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::AuthorityCap<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::PACKAGE, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::ADMIN>, arg3: u64, arg4: u64) {
        admin(arg1, arg2);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::events::emit_admin_action(arg0, 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config>(arg1), 63);
        assert!(arg3 <= 0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::max_xp_grant(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid(arg1)), 13835903068623208455);
        assert!(arg4 <= 1000000000000000, 13835903072918175751);
        assert!(0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::crate_xp_ok(arg3, arg4), 13835903077213143047);
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::set_crate_params(arg0, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid_mut(arg0, arg1), arg3, arg4);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::events::emit_crate_params_event(arg0, arg3, arg4);
    }

    public fun set_crate_pool<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg3: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::AuthorityCap<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::PACKAGE, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::ADMIN>, arg4: vector<u8>, arg5: vector<u64>) {
        admin(arg2, arg3);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::events::emit_admin_action(arg0, 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config>(arg2), 53);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::assert_version<T0>(arg1);
        assert!(0x1::vector::length<u8>(&arg4) <= 128, 13835903717163270151);
        assert!(0x1::vector::length<u64>(&arg5) == 0x1::vector::length<u8>(&arg4), 13835903721458237447);
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(&arg4)) {
            let v1 = *0x1::vector::borrow<u8>(&arg4, v0);
            assert!(0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::cosmetic_exists(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid<T0>(arg1), v1), 13836185213614948361);
            assert!(*0x1::vector::borrow<u64>(&arg5, v0) >= 1 && *0x1::vector::borrow<u64>(&arg5, v0) <= 1000000, 13835903742933073927);
            let v2 = 0;
            while (v2 < v0) {
                assert!(*0x1::vector::borrow<u8>(&arg4, v2) != v1, 13835903755817975815);
                v2 = v2 + 1;
            };
            v0 = v0 + 1;
        };
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::set_crate_pool(arg0, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid_mut<T0>(arg0, arg1), arg4, arg5);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::events::emit_crate_pool_event(arg0, arg4, arg5);
    }

    public fun set_crate_weights(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::AuthorityCap<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::PACKAGE, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::ADMIN>, arg3: u64, arg4: u64) {
        admin(arg1, arg2);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::events::emit_admin_action(arg0, 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config>(arg1), 62);
        assert!(arg3 <= 1000000, 13835903115867848711);
        assert!(arg4 <= 1000000, 13835903120162816007);
        assert!(arg3 + arg4 > 0, 13835903124457783303);
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::set_weights(arg0, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid_mut(arg0, arg1), arg3, arg4);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::events::emit_crate_weights_event(arg0, 0, arg3, arg4);
    }

    public fun set_daily_drop(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::AuthorityCap<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::PACKAGE, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::ADMIN>, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        admin(arg1, arg2);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::events::emit_admin_action(arg0, 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config>(arg1), 65);
        assert!(arg3 <= 100000000000, 13835902866759745543);
        assert!(arg4 <= 100000000000, 13835902871054712839);
        assert!(arg5 <= 100000000000, 13835902875349680135);
        assert!(arg3 <= arg5, 13835902879644647431);
        assert!(arg6 >= 1 && arg6 <= 10000, 13835902883939614727);
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::set_daily(arg0, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid_mut(arg0, arg1), arg3, arg4, arg5, arg6);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::events::emit_daily_drop_event(arg0, arg3, arg4, arg5, arg6);
    }

    public fun set_game_enabled(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::AuthorityCap<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::PACKAGE, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::ADMIN>, arg3: bool) {
        admin(arg1, arg2);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::events::emit_admin_action(arg0, 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config>(arg1), 69);
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::set_enabled(arg0, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid_mut(arg0, arg1), arg3);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::events::emit_game_enabled_event(arg0, arg3);
    }

    public fun set_global_mint_cap(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::AuthorityCap<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::PACKAGE, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::ADMIN>, arg3: u64) {
        admin(arg1, arg2);
        assert!(arg3 <= 1000000000000000, 13835902952659091463);
        let v0 = 0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::wallet_mint_cap(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid(arg1));
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::set_mint_caps(arg0, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid_mut(arg0, arg1), v0, arg3);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::events::emit_mint_caps_event(arg0, v0, arg3);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::events::emit_admin_action(arg0, 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config>(arg1), 41);
    }

    public fun set_quest_active<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg3: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::AuthorityCap<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::PACKAGE, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::ADMIN>, arg4: u8, arg5: bool) {
        admin(arg2, arg3);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::events::emit_admin_action(arg0, 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config>(arg2), 55);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::assert_version<T0>(arg1);
        assert!(0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::quest_exists(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid<T0>(arg1), arg4), 13836185076175994889);
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::set_quest_active(arg0, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid_mut<T0>(arg0, arg1), arg4, arg5);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::events::emit_quest_active_event(arg0, arg4, arg5);
    }

    public fun set_quest_bounds(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::AuthorityCap<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::PACKAGE, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::ADMIN>, arg3: u64) {
        admin(arg1, arg2);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::events::emit_admin_action(arg0, 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config>(arg1), 61);
        assert!(arg3 >= 1 && arg3 <= 1000000000, 13835903163112488967);
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::set_quest_bounds(arg0, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid_mut(arg0, arg1), arg3);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::events::emit_quest_bounds_event(arg0, 0, 0, arg3);
    }

    public fun set_season_reward_ceiling(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::AuthorityCap<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::PACKAGE, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::ADMIN>, arg3: u64) {
        admin(arg1, arg2);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::events::emit_admin_action(arg0, 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config>(arg1), 60);
        assert!(arg3 >= 1 && arg3 <= 100000000000, 13835903197472227335);
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::set_season_ceiling(arg0, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid_mut(arg0, arg1), arg3);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::events::emit_season_ceiling_event(arg0, arg3);
    }

    public fun set_tier_name(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::AuthorityCap<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::PACKAGE, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::ADMIN>, arg3: u8, arg4: vector<u8>) {
        admin(arg1, arg2);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::events::emit_admin_action(arg0, 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config>(arg1), 66);
        assert!((arg3 as u64) <= 0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::tier_threshold_count(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid(arg1)), 13835902806630203399);
        assert!(name_ok(&arg4), 13835902810925170695);
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::set_tier_name(arg0, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid_mut(arg0, arg1), (arg3 as u64), arg4);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::events::emit_tier_renamed_event(arg0, arg3, arg4);
    }

    public fun set_tier_thresholds(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::AuthorityCap<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::PACKAGE, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::ADMIN>, arg3: vector<u64>) {
        admin(arg1, arg2);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::events::emit_admin_action(arg0, 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config>(arg1), 67);
        let v0 = 0x1::vector::length<u64>(&arg3);
        assert!(v0 >= 1 && v0 <= 32, 13835902733615759367);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<u64>(&arg3, v1);
            assert!(v2 > 0 && v2 <= 1000000000000000, 13835902755090595847);
            v1 = v1 + 1;
        };
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::set_tier_thresholds(arg0, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid_mut(arg0, arg1), arg3);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::events::emit_tier_table_event(arg0, arg3);
    }

    public fun set_wallet_mint_cap(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::AuthorityCap<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::PACKAGE, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::ADMIN>, arg3: u64) {
        admin(arg1, arg2);
        assert!(arg3 <= 1000000000000000, 13835902914004385799);
        let v0 = 0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::global_mint_cap(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid(arg1));
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::set_mint_caps(arg0, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid_mut(arg0, arg1), arg3, v0);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::events::emit_mint_caps_event(arg0, arg3, v0);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::events::emit_admin_action(arg0, 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config>(arg1), 40);
    }

    public fun set_win_xp(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::AuthorityCap<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::PACKAGE, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::ADMIN>, arg3: u64, arg4: u64) {
        admin(arg1, arg2);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::events::emit_admin_action(arg0, 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config>(arg1), 64);
        assert!(arg3 <= 1000000, 13835902995608764423);
        assert!(arg4 >= 1 && arg4 <= 100, 13835902999903731719);
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::set_win_xp(arg0, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid_mut(arg0, arg1), arg3, arg4);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::events::emit_win_xp_event(arg0, arg3, arg4);
    }

    // decompiled from Move bytecode v7
}

