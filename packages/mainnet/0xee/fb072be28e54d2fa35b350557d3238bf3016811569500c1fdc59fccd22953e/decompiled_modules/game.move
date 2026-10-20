module 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game {
    fun owner<T0>(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::Account<T0>, arg2: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::AccountCap, arg3: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config) {
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::assert_version(arg3);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::assert_version<T0>(arg0);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::assert_exchange<T0>(arg1, 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>>(arg0));
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::assert_cap<T0>(arg1, arg2);
    }

    fun abort_status(arg0: u8) {
        assert!(arg0 != 1, 13837594203406860307);
        assert!(arg0 != 4, 13838157157655511063);
        assert!(arg0 != 5, 13836468312089427979);
        assert!(arg0 != 6, 13836186841407553545);
        assert!(arg0 != 7, 13837594220586729491);
        assert!(arg0 == 0, 13835905375020646407);
    }

    public fun achievement_mint_fraction_bps(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config) : u64 {
        0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book::achievement_mint_fraction_bps(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg0))
    }

    public fun achievement_unlocked<T0>(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: address, arg2: u8) : bool {
        0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book::achievement_on(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::uid<T0>(arg0), arg1, arg2)
    }

    fun admin(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>) {
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::assert_version(arg0);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::assert_admin(0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config>(arg0), arg1);
    }

    public fun award_achievement<T0>(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg2: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::GAME_KEEPER>, arg3: address, arg4: u8, arg5: &0x2::clock::Clock) {
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::assert_version(arg1);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::assert_role<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::GAME_KEEPER>(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg1), 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config>(arg1), arg2);
        award_inner<T0>(arg0, arg1, arg3, arg4, 0x2::clock::timestamp_ms(arg5));
    }

    public fun award_achievement_as_admin<T0>(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg2: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>, arg3: address, arg4: u8, arg5: &0x2::clock::Clock) {
        let v0 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::auth::issue(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg1));
        admin(arg1, arg2);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_action(&v0, 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config>(arg1), 52);
        award_inner<T0>(arg0, arg1, arg3, arg4, 0x2::clock::timestamp_ms(arg5));
    }

    fun award_inner<T0>(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg2: address, arg3: u8, arg4: u64) {
        let v0 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::auth::issue(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg1));
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::assert_unpaused(arg1, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::pause_game());
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::assert_version<T0>(arg0);
        assert!(0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book::enabled(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg1)), 13835060705276985345);
        abort_status(0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book::award(&v0, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::uid_mut<T0>(&v0, arg0), 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg1), arg2, arg3, arg4));
    }

    public fun claim_daily<T0>(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::Account<T0>, arg2: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::AccountCap, arg3: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg4: &0x2::clock::Clock) {
        let v0 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::auth::issue(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg3));
        owner<T0>(arg0, arg1, arg2, arg3);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::assert_unpaused(arg3, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::pause_game());
        let v1 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::owner<T0>(arg1);
        let v2 = 0x2::clock::timestamp_ms(arg4);
        let (v3, v4, v5, v6) = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book::preview_daily(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg3), 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::uid<T0>(arg0), v1, v2);
        assert!(v3 != 1, 13835059708844572673);
        assert!(v3 != 2, 13835341188116381699);
        assert!(v3 == 0, 13835904142365032455);
        0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book::commit_daily(&v0, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::uid_mut<T0>(&v0, arg0), 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg3), v1, v6, v4, v5, v2);
    }

    public fun claim_quest<T0>(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::Account<T0>, arg2: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::AccountCap, arg3: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg4: u8, arg5: &0x2::clock::Clock) {
        owner<T0>(arg0, arg1, arg2, arg3);
        finish_quest<T0>(arg0, arg3, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::owner<T0>(arg1), arg4, 0x2::clock::timestamp_ms(arg5), false);
    }

    public fun collect_mint<T0, T1>(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::Account<T0>, arg2: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::AccountCap, arg3: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::auth::issue(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg3));
        owner<T0>(arg0, arg1, arg2, arg3);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::assert_unpaused(arg3, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::pause_game());
        assert!(0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book::enabled(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg3)), 13835059790448951297);
        let v1 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book::take_pending(&v0, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::uid_mut<T0>(&v0, arg0), 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::owner<T0>(arg1));
        let v2 = mint_out<T0, T1>(arg0, arg3, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::owner<T0>(arg1), v1, arg4, arg5);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::assert_identity<T0>(arg0);
        v2
    }

    fun complete_inner<T0>(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg2: address, arg3: u8, arg4: u64) {
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::assert_version<T0>(arg0);
        finish_quest<T0>(arg0, arg1, arg2, arg3, arg4, true);
    }

    public fun complete_quest<T0>(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg2: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::GAME_KEEPER>, arg3: address, arg4: u8, arg5: &0x2::clock::Clock) {
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::assert_version(arg1);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::assert_role<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::GAME_KEEPER>(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg1), 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config>(arg1), arg2);
        complete_inner<T0>(arg0, arg1, arg3, arg4, 0x2::clock::timestamp_ms(arg5));
    }

    public fun complete_quest_as_admin<T0>(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg2: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>, arg3: address, arg4: u8, arg5: &0x2::clock::Clock) {
        let v0 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::auth::issue(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg1));
        admin(arg1, arg2);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_action(&v0, 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config>(arg1), 51);
        complete_inner<T0>(arg0, arg1, arg3, arg4, 0x2::clock::timestamp_ms(arg5));
    }

    fun cosmetic_known<T0>(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: &0x1::option::Option<u8>) : bool {
        0x1::option::is_none<u8>(arg1) || 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book::cosmetic_exists(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::uid<T0>(arg0), *0x1::option::borrow<u8>(arg1))
    }

    public fun daily_base(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config) : u64 {
        0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book::daily_base(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg0))
    }

    public fun fee_credit<T0>(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: address) : u64 {
        0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book::fee_credit(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::uid<T0>(arg0), arg1)
    }

    public fun fee_credit_used<T0>(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: address) : u64 {
        0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book::fee_credit_used(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::uid<T0>(arg0), arg1)
    }

    fun finish_quest<T0>(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg2: address, arg3: u8, arg4: u64, arg5: bool) {
        let v0 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::auth::issue(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg1));
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::assert_unpaused(arg1, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::pause_game());
        assert!(0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book::enabled(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg1)), 13835060649442410497);
        abort_status(0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book::claim_quest(&v0, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::uid_mut<T0>(&v0, arg0), 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg1), arg2, arg3, arg4, arg5));
    }

    public fun game_enabled(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config) : bool {
        0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book::enabled(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg0))
    }

    public fun global_mint_cap(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config) : u64 {
        0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book::global_mint_cap(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg0))
    }

    public fun global_minted<T0>(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>) : u64 {
        0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book::global_minted(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::uid<T0>(arg0))
    }

    fun grant_season_inner<T0>(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg2: address, arg3: u64) {
        let v0 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::auth::issue(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg1));
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::assert_unpaused(arg1, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::pause_game());
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::assert_version<T0>(arg0);
        assert!(0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book::enabled(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg1)), 13835060743931691009);
        let (v1, _, _) = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book::season(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg1));
        assert!(v1 != 0, 13835905177452150791);
        assert!(arg3 >= 1 && arg3 <= 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book::max_season_reward(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg1)), 13835905181747118087);
        assert!(0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book::player_season_rewarded(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::uid<T0>(arg0), arg2) != v1, 13837875510879977493);
        assert!(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::account_exists(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::uid<T0>(arg0), arg2), 13837312565221261329);
        0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book::mark_season_rewarded(&v0, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::uid_mut<T0>(&v0, arg0), arg2, v1);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_season_reward_event(&v0, arg2, v1, 0);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::assert_identity<T0>(arg0);
    }

    public fun grant_season_reward<T0>(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg2: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::GAME_KEEPER>, arg3: address, arg4: u64) {
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::assert_version(arg1);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::assert_role<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::GAME_KEEPER>(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg1), 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config>(arg1), arg2);
        grant_season_inner<T0>(arg0, arg1, arg3, arg4);
    }

    public fun grant_season_reward_as_admin<T0>(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg2: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>, arg3: address, arg4: u64) {
        let v0 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::auth::issue(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg1));
        admin(arg1, arg2);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_action(&v0, 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config>(arg1), 50);
        grant_season_inner<T0>(arg0, arg1, arg3, arg4);
    }

    public fun max_xp_grant(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config) : u64 {
        0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book::max_xp_grant(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg0))
    }

    fun mint_out<T0, T1>(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg2: address, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::auth::issue(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg1));
        let v1 = if (arg3 == 0) {
            0
        } else {
            assert!(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::has_reward_treasury<T0, T1>(arg0), 13835623775489753093);
            18446744073709551615 - 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::reward_supply<T0, T1>(arg0)
        };
        let v2 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book::issue(&v0, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::uid_mut<T0>(&v0, arg0), 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg1), arg2, arg3, 0x2::clock::timestamp_ms(arg4), v1);
        if (v2 == 0) {
            0x2::coin::zero<T1>(arg5)
        } else {
            0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::mint_reward<T0, T1>(&v0, arg0, v2, arg5)
        }
    }

    public fun minted_today<T0>(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: address) : u64 {
        0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book::minted_today(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::uid<T0>(arg0), arg1)
    }

    fun name_ok(arg0: &vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(arg0);
        v0 >= 1 && v0 <= 32
    }

    public(friend) fun on_close<T0>(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg2: address, arg3: 0x2::object::ID, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: bool, arg10: u64, arg11: u64) {
        if (0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::game_paused(arg1)) {
            return
        };
        let v0 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::auth::issue(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg1));
        0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book::note_close(&v0, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::uid_mut<T0>(&v0, arg0), 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg1), arg2, arg7, arg8, arg5, arg6, arg9, arg10, arg11);
    }

    public(friend) fun on_loss<T0>(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg2: address, arg3: u64, arg4: u64) {
        if (0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::game_paused(arg1)) {
            return
        };
        let v0 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::auth::issue(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg1));
        0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book::note_close(&v0, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::uid_mut<T0>(&v0, arg0), 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg1), arg2, 1, 0, 0, 0, false, arg3, arg4);
    }

    public(friend) fun on_open<T0>(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg2: address, arg3: 0x2::object::ID, arg4: u64, arg5: u64) {
        let v0 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::auth::issue(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg1));
        if (!0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book::enabled(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg1)) || 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::game_paused(arg1)) {
            return
        };
        0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book::note_open(&v0, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::uid_mut<T0>(&v0, arg0), 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg1), arg2, arg3, (((arg4 as u128) * (0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book::xp_per_notional_bps(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg1)) as u128) / 10000) as u64), arg5);
    }

    entry fun open_crate<T0>(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::Account<T0>, arg2: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::AccountCap, arg3: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg4: &0x2::random::Random, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::assert_cap<T0>(arg1, arg2);
        let v0 = 0x2::random::new_generator(arg4, arg6);
        let v1 = &mut v0;
        open_crate_inner<T0>(arg0, arg1, arg3, v1, arg5);
    }

    fun open_crate_inner<T0>(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::Account<T0>, arg2: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg3: &mut 0x2::random::RandomGenerator, arg4: &0x2::clock::Clock) {
        let v0 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::auth::issue(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg2));
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::assert_unpaused(arg2, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::pause_game());
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::assert_version(arg2);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::assert_version<T0>(arg0);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::assert_exchange<T0>(arg1, 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>>(arg0));
        assert!(0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book::enabled(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg2)), 13835060520593391617);
        let v1 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::owner<T0>(arg1);
        let (v2, v3) = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book::crate_status(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::uid<T0>(arg0), v1);
        assert!(v2 > 0, 13837030858316185615);
        let (v4, v5) = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book::crate_bounds(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg2));
        let v6 = 0x2::clock::timestamp_ms(arg4);
        assert!(!0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book::cooling_down(v3, v5, v6), 13836749396224245773);
        let (v7, v8) = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book::crate_weights(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg2));
        let v9 = v7 + v8;
        assert!(v9 > 0, 13835904984178622471);
        let v10 = if (0x2::random::generate_u64_in_range(arg3, 0, v9 - 1) < v7) {
            1
        } else {
            2
        };
        let v11 = v10;
        let v12 = if (v10 == 1) {
            v4
        } else {
            0
        };
        let v13 = v12;
        let v14 = 0x1::option::none<u8>();
        if (v10 == 2) {
            let v15 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book::crate_pool(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::uid<T0>(arg0));
            if (0x1::vector::length<u8>(&v15) == 0) {
                v11 = 1;
                v13 = v4;
            } else {
                let v16 = *0x1::vector::borrow<u8>(&v15, 0x2::random::generate_u64_in_range(arg3, 0, 0x1::vector::length<u8>(&v15) - 1));
                if (0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book::owns_cosmetic(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::uid<T0>(arg0), v1, v16)) {
                    v11 = 1;
                    v13 = v4;
                } else {
                    v14 = 0x1::option::some<u8>(v16);
                };
            };
        };
        0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book::commit_crate(&v0, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::uid_mut<T0>(&v0, arg0), 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg2), v1, v11, v13, v14, v6);
    }

    fun param_ok(arg0: u8, arg1: u64) : bool {
        arg0 == 0 || arg0 == 7 || arg0 == 1 && arg1 >= 1 && arg1 <= 16 || arg0 == 2 && arg1 >= 1 && arg1 <= 10000 || arg0 == 3 && arg1 >= 1 && arg1 <= 1000000 || (arg0 == 4 || arg0 == 6) && arg1 >= 1 && arg1 <= 10000 || arg0 == 8 && arg1 > 0 || arg0 == 5 && arg1 >= 1 && arg1 <= 4
    }

    public fun pending_mint<T0>(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: address) : u128 {
        0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book::pending_mint(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::uid<T0>(arg0), arg1)
    }

    public fun player_crates<T0>(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: address) : u64 {
        0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book::player_crates(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::uid<T0>(arg0), arg1)
    }

    public fun player_season_xp<T0>(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: address) : u64 {
        0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book::player_season_xp(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::uid<T0>(arg0), arg1)
    }

    public fun player_streak<T0>(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: address) : u64 {
        0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book::player_streak(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::uid<T0>(arg0), arg1)
    }

    public fun player_tier<T0>(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: address) : u8 {
        0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book::player_tier(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::uid<T0>(arg0), arg1)
    }

    public fun player_win_streak<T0>(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: address) : u64 {
        0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book::player_win_streak(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::uid<T0>(arg0), arg1)
    }

    public fun player_xp<T0>(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: address) : u64 {
        0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book::player_xp(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::uid<T0>(arg0), arg1)
    }

    public fun quest_done<T0>(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: address, arg2: u8) : bool {
        0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book::quest_done(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::uid<T0>(arg0), arg1, arg2)
    }

    public fun quest_ready<T0>(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: address, arg2: u8) : bool {
        0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book::quest_ready(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::uid<T0>(arg0), arg1, arg2)
    }

    public fun register_achievement<T0>(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg2: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>, arg3: vector<u8>, arg4: u8, arg5: u64, arg6: u64, arg7: u64, arg8: 0x1::option::Option<u8>) : u8 {
        let v0 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::auth::issue(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg1));
        admin(arg1, arg2);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_action(&v0, 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config>(arg1), 58);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::assert_version<T0>(arg0);
        assert!(0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book::achievement_count(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::uid<T0>(arg0)) < 32, 13838436884580663321);
        assert!(name_ok(&arg3), 13835903614084055047);
        assert!(param_ok(arg4, arg5), 13835903618379022343);
        assert!(arg7 == 0 || arg4 == 8, 13835903622673989639);
        assert!(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::safety::achievement_mint_allowance(arg5, achievement_mint_fraction_bps(arg1), arg7) == arg7, 13835903626968956935);
        assert!(arg6 <= 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book::max_xp_grant(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg1)), 13835903631263924231);
        assert!(cosmetic_known<T0>(arg0, &arg8), 13836185110535733257);
        let v1 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book::add_achievement(&v0, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::uid_mut<T0>(&v0, arg0), arg3, arg4, arg5, arg6, arg7, arg8);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_achievement_registered_event(&v0, v1, arg3, arg4, arg5, arg6, arg7, arg8, true);
        v1
    }

    public fun register_cosmetic<T0>(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg2: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>, arg3: vector<u8>) : u8 {
        let v0 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::auth::issue(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg1));
        admin(arg1, arg2);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_action(&v0, 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config>(arg1), 54);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::assert_version<T0>(arg0);
        assert!(0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book::cosmetic_count(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::uid<T0>(arg0)) < 32, 13838437232473014297);
        assert!(name_ok(&arg3), 13835903961976406023);
        let v1 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book::add_cosmetic(&v0, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::uid_mut<T0>(&v0, arg0), arg3);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_cosmetic_registered_event(&v0, v1, arg3);
        v1
    }

    public fun register_quest<T0>(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg2: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>, arg3: vector<u8>, arg4: u8, arg5: u64, arg6: u64, arg7: u64, arg8: 0x1::option::Option<u8>, arg9: u64, arg10: u64, arg11: u64) : u8 {
        let v0 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::auth::issue(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg1));
        admin(arg1, arg2);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_action(&v0, 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config>(arg1), 56);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::assert_version<T0>(arg0);
        assert!(0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book::quest_count(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::uid<T0>(arg0)) < 32, 13838437069264257049);
        assert!(name_ok(&arg3), 13835903798767648775);
        assert!(param_ok(arg4, arg5), 13835903803062616071);
        assert!(arg6 <= 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book::max_xp_grant(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg1)), 13835903807357583367);
        assert!(arg7 == 0, 13835903811652550663);
        assert!(arg10 == 0 || arg10 > arg9, 13835903815947517959);
        assert!(cosmetic_known<T0>(arg0, &arg8), 13836185295219326985);
        let v1 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book::add_quest(&v0, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::uid_mut<T0>(&v0, arg0), arg3, arg4, arg5, arg6, arg8, arg9, arg10, arg11);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_quest_registered_event(&v0, v1, arg3, arg4, arg5, arg6, arg7, arg8, true, arg9, arg10, arg11);
        v1
    }

    public fun roll_season(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>, arg2: u64, arg3: u64) {
        let v0 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::auth::issue(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg0));
        admin(arg0, arg1);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_action(&v0, 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config>(arg0), 59);
        assert!(arg3 > arg2, 13835903511004839943);
        assert!(arg3 - arg2 <= 31622400000, 13835903515299807239);
        let (v1, _, _) = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book::season(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg0));
        assert!(v1 < 18446744073709551615, 13835903523889741831);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_season_rolled_event(&v0, 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book::roll_season(&v0, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid_mut(&v0, arg0), arg2, arg3), arg2, arg3);
    }

    public fun season_id(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config) : u64 {
        let (v0, _, _) = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book::season(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg0));
        v0
    }

    public fun set_achievement_active<T0>(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg2: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>, arg3: u8, arg4: bool) {
        let v0 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::auth::issue(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg1));
        admin(arg1, arg2);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_action(&v0, 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config>(arg1), 57);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::assert_version<T0>(arg0);
        assert!(0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book::achievement_exists(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::uid<T0>(arg0), arg3), 13836185170665275401);
        0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book::set_achievement_active(&v0, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::uid_mut<T0>(&v0, arg0), arg3, arg4);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_achievement_active_event(&v0, arg3, arg4);
    }

    public fun set_achievement_mint_fraction_bps(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>, arg2: u64) {
        let v0 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::auth::issue(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg0));
        admin(arg0, arg1);
        assert!(arg2 <= 10000, 13835905559704240135);
        0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book::set_achievement_mint_fraction_bps(&v0, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid_mut(&v0, arg0), arg2);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_action(&v0, 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config>(arg0), 49);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_achievement_mint_fraction_event(&v0, arg2);
    }

    public fun set_crate_params(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        let v0 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::auth::issue(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg0));
        admin(arg0, arg1);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_action(&v0, 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config>(arg0), 63);
        assert!(arg2 <= 2592000000, 13835903304846409735);
        assert!(arg3 == 0 && arg4 == 0, 13835903309141377031);
        assert!(arg5 <= 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book::max_xp_grant(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg0)), 13835903313436344327);
        assert!(arg6 == 0 || arg6 <= 1000000000000000, 13835903317731311623);
        assert!(arg7 >= 1 && arg7 <= 20, 13835903322026278919);
        0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book::set_crate_params(&v0, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid_mut(&v0, arg0), arg2, arg5, arg6, arg7);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_crate_params_event(&v0, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun set_crate_pool<T0>(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg2: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>, arg3: vector<u8>) {
        let v0 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::auth::issue(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg1));
        admin(arg1, arg2);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_action(&v0, 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config>(arg1), 53);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::assert_version<T0>(arg0);
        assert!(0x1::vector::length<u8>(&arg3) <= 32, 13835904022105948167);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(&arg3)) {
            let v2 = *0x1::vector::borrow<u8>(&arg3, v1);
            assert!(0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book::cosmetic_exists(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::uid<T0>(arg0), v2), 13836185514262659081);
            let v3 = 0;
            while (v3 < v1) {
                assert!(*0x1::vector::borrow<u8>(&arg3, v3) != v2, 13835904052170719239);
                v3 = v3 + 1;
            };
            v1 = v1 + 1;
        };
        0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book::set_crate_pool(&v0, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::uid_mut<T0>(&v0, arg0), arg3);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_crate_pool_event(&v0, arg3);
    }

    public fun set_crate_weights(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::auth::issue(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg0));
        admin(arg0, arg1);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_action(&v0, 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config>(arg0), 62);
        assert!(arg2 == 0, 13835903360680984583);
        assert!(arg3 <= 1000000, 13835903364975951879);
        assert!(arg4 <= 1000000, 13835903369270919175);
        assert!(arg2 + arg3 + arg4 > 0, 13835903373565886471);
        0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book::set_weights(&v0, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid_mut(&v0, arg0), arg3, arg4);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_crate_weights_event(&v0, arg2, arg3, arg4);
    }

    public fun set_daily_drop(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::auth::issue(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg0));
        admin(arg0, arg1);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_action(&v0, 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config>(arg0), 65);
        assert!(arg2 <= 100000000000, 13835903042853404679);
        assert!(arg3 <= 100000000000, 13835903047148371975);
        assert!(arg4 <= 100000000000, 13835903051443339271);
        assert!(arg2 <= arg4, 13835903055738306567);
        assert!(arg5 >= 1 && arg5 <= 10000, 13835903060033273863);
        0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book::set_daily(&v0, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid_mut(&v0, arg0), arg2, arg3, arg4, arg5);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_daily_drop_event(&v0, arg2, arg3, arg4, arg5);
    }

    public fun set_game_enabled(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>, arg2: bool) {
        let v0 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::auth::issue(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg0));
        admin(arg0, arg1);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_action(&v0, 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config>(arg0), 69);
        0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book::set_enabled(&v0, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid_mut(&v0, arg0), arg2);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_game_enabled_event(&v0, arg2);
    }

    public fun set_global_mint_cap(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>, arg2: u64) {
        let v0 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::auth::issue(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg0));
        admin(arg0, arg1);
        assert!(arg2 <= 1000000000000000, 13835903171702423559);
        let v1 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book::wallet_mint_cap(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg0));
        0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book::set_mint_caps(&v0, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid_mut(&v0, arg0), v1, arg2);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_mint_caps_event(&v0, v1, arg2);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_action(&v0, 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config>(arg0), 41);
    }

    public fun set_quest_active<T0>(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg2: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>, arg3: u8, arg4: bool) {
        let v0 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::auth::issue(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg1));
        admin(arg1, arg2);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_action(&v0, 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config>(arg1), 55);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::assert_version<T0>(arg0);
        assert!(0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book::quest_exists(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::uid<T0>(arg0), arg3), 13836185381118672905);
        0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book::set_quest_active(&v0, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::uid_mut<T0>(&v0, arg0), arg3, arg4);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_quest_active_event(&v0, arg3, arg4);
    }

    public fun set_quest_bounds(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::auth::issue(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg0));
        admin(arg0, arg1);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_action(&v0, 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config>(arg0), 61);
        assert!(arg2 <= 2592000000, 13835903425105494023);
        assert!(arg3 == 0 && arg2 == 0, 13835903429400461319);
        assert!(arg4 >= 1 && arg4 <= 1000000000, 13835903433695428615);
        0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book::set_quest_bounds(&v0, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid_mut(&v0, arg0), arg4);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_quest_bounds_event(&v0, arg2, arg3, arg4);
    }

    public fun set_season_reward_ceiling(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>, arg2: u64) {
        let v0 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::auth::issue(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg0));
        admin(arg0, arg1);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_action(&v0, 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config>(arg0), 60);
        assert!(arg2 >= 1 && arg2 <= 100000000000, 13835903472350134279);
        0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book::set_season_ceiling(&v0, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid_mut(&v0, arg0), arg2);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_season_ceiling_event(&v0, arg2);
    }

    public fun set_tier_name(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>, arg2: u8, arg3: vector<u8>) {
        let v0 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::auth::issue(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg0));
        admin(arg0, arg1);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_action(&v0, 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config>(arg0), 66);
        assert!(arg2 < 5, 13835902982723862535);
        assert!(name_ok(&arg3), 13835902987018829831);
        0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book::set_tier_name(&v0, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid_mut(&v0, arg0), (arg2 as u64), arg3);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_tier_renamed_event(&v0, arg2, arg3);
    }

    public fun set_tier_thresholds(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>, arg2: vector<u64>) {
        let v0 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::auth::issue(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg0));
        admin(arg0, arg1);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_action(&v0, 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config>(arg0), 67);
        assert!(0x1::vector::length<u64>(&arg2) == 4, 13835902905414451207);
        let v1 = 0;
        while (v1 < 4) {
            let v2 = *0x1::vector::borrow<u64>(&arg2, v1);
            assert!(v2 > 0 && v2 <= 1000000000000000, 13835902926889287687);
            v1 = v1 + 1;
        };
        0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book::set_tier_thresholds(&v0, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid_mut(&v0, arg0), arg2);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_tier_table_event(&v0, arg2);
    }

    public fun set_wallet_mint_cap(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>, arg2: u64) {
        let v0 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::auth::issue(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg0));
        admin(arg0, arg1);
        assert!(arg2 <= 1000000000000000, 13835903128752750599);
        let v1 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book::global_mint_cap(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg0));
        0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book::set_mint_caps(&v0, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid_mut(&v0, arg0), arg2, v1);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_mint_caps_event(&v0, arg2, v1);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_action(&v0, 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config>(arg0), 40);
    }

    public fun set_win_mint(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>, arg2: u64) {
        let v0 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::auth::issue(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg0));
        admin(arg0, arg1);
        assert!(arg2 == 0, 13835903094393012231);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_win_mint_event(&v0, arg2);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_action(&v0, 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config>(arg0), 42);
    }

    public fun set_win_xp(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>, arg2: u64, arg3: u64) {
        let v0 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::auth::issue(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg0));
        admin(arg0, arg1);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_action(&v0, 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config>(arg0), 64);
        assert!(arg2 <= 1000000, 13835903218947063815);
        assert!(arg3 >= 1 && arg3 <= 100, 13835903223242031111);
        0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book::set_win_xp(&v0, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid_mut(&v0, arg0), arg2, arg3);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_win_xp_event(&v0, arg2, arg3);
    }

    public fun set_xp_per_notional_bps(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>, arg2: u64) {
        let v0 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::auth::issue(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg0));
        admin(arg0, arg1);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_action(&v0, 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config>(arg0), 68);
        assert!(arg2 <= 10000, 13835902866759745543);
        0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book::set_xp_rate(&v0, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid_mut(&v0, arg0), arg2);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_xp_rate_event(&v0, arg2);
    }

    public fun tier_name(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg1: u64) : vector<u8> {
        0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book::tier_name(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg0), arg1)
    }

    public fun tier_threshold(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg1: u64) : u64 {
        0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book::tier_threshold(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg0), arg1)
    }

    public fun wallet_mint_cap(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config) : u64 {
        0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book::wallet_mint_cap(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg0))
    }

    public fun win_mint(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config) : u64 {
        0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book::win_mint(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg0))
    }

    public fun xp_per_notional_bps(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config) : u64 {
        0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book::xp_per_notional_bps(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg0))
    }

    // decompiled from Move bytecode v7
}

