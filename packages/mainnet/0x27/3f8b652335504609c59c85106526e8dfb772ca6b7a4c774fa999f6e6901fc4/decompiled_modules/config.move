module 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config {
    struct Config has key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct ConfigStateV1 has store, key {
        id: 0x2::object::UID,
        paused: bool,
        closes_paused: bool,
        taker_fee_bps: u64,
        taker_fee_set: bool,
        win_fee_bps: u64,
        harvest_batch_cap: u64,
        referral_enabled: bool,
        referral_fee_bps: u64,
        second_level_fee_bps: u64,
        referee_discount_bps: u64,
        max_builder_share_bps: u64,
        builders_enabled: bool,
        econ: EconParamsV1,
        extra_fields: 0x2::bag::Bag,
    }

    struct EconParamsV1 has copy, drop, store {
        trim_max_share_bps: u64,
        trim_c_ppm: u64,
        loss_fee_bps: u64,
        min_payout_factor_bps: u64,
        sweep_max: u64,
        liq_bounty_cap: u64,
        staker_fee_bps: u64,
        pause_ratio_bps: u64,
        resume_ratio_bps: u64,
        surplus_floor_bps: u64,
        surplus_max_bps: u64,
        surplus_interval_ms: u64,
        surplus_staker_bps: u64,
        surplus_treasury_bps: u64,
        surplus_growth_bps: u64,
    }

    public fun assert_version(arg0: &Config) {
        assert!(arg0.version == 1, 13835058652282617857);
    }

    public fun builders_enabled(arg0: &Config) : bool {
        state(arg0).builders_enabled
    }

    public fun closes_paused(arg0: &Config) : bool {
        state(arg0).closes_paused
    }

    public(friend) fun create(arg0: &mut 0x2::tx_context::TxContext) : (Config, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::AuthorityCap<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::PACKAGE, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::ADMIN>) {
        let v0 = 1;
        let v1 = Config{
            id      : 0x2::object::new(arg0),
            version : v0,
        };
        let v2 = EconParamsV1{
            trim_max_share_bps    : 9000,
            trim_c_ppm            : 190,
            loss_fee_bps          : 200,
            min_payout_factor_bps : 3000,
            sweep_max             : 3,
            liq_bounty_cap        : 5000000,
            staker_fee_bps        : 5000,
            pause_ratio_bps       : 12500,
            resume_ratio_bps      : 15000,
            surplus_floor_bps     : 15000,
            surplus_max_bps       : 1000,
            surplus_interval_ms   : 86400000,
            surplus_staker_bps    : 5000,
            surplus_treasury_bps  : 3500,
            surplus_growth_bps    : 1500,
        };
        let v3 = ConfigStateV1{
            id                    : 0x2::object::new(arg0),
            paused                : false,
            closes_paused         : false,
            taker_fee_bps         : 0,
            taker_fee_set         : false,
            win_fee_bps           : 200,
            harvest_batch_cap     : 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::lp::max_entries(),
            referral_enabled      : true,
            referral_fee_bps      : 1000,
            second_level_fee_bps  : 250,
            referee_discount_bps  : 500,
            max_builder_share_bps : 2000,
            builders_enabled      : false,
            econ                  : v2,
            extra_fields          : 0x2::bag::new(arg0),
        };
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::extended_field::add<ConfigStateV1>(&mut v1.id, v0, v3);
        assert!(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::safety::protocol_shares_fit(2000, 500, 1000, 250), 13836184513535279113);
        let v4 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::new();
        let v5 = &mut v1;
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::game_book::attach_config(uid_mut(&v4, v5), arg0);
        (v1, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::mint_admin(0x2::object::id<Config>(&v1), arg0))
    }

    public fun grant_fee_recipient(arg0: &mut Config, arg1: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::AuthorityCap<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::PACKAGE, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::ADMIN>, arg2: &mut 0x2::tx_context::TxContext) : 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::AuthorityCap<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::PACKAGE, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::FEE_RECIPIENT> {
        assert_version(arg0);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        let v0 = 0x2::object::id<Config>(arg0);
        let v1 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::new();
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::events::emit_admin_action(&v1, v0, 23);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::mint_role<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::FEE_RECIPIENT>(&mut arg0.id, v0, arg2)
    }

    public fun grant_game_keeper(arg0: &mut Config, arg1: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::AuthorityCap<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::PACKAGE, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::ADMIN>, arg2: &mut 0x2::tx_context::TxContext) : 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::AuthorityCap<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::PACKAGE, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::GAME_KEEPER> {
        assert_version(arg0);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        let v0 = 0x2::object::id<Config>(arg0);
        let v1 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::mint_role<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::GAME_KEEPER>(&mut arg0.id, v0, arg2);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::events::emit_game_keeper_granted_event(0x2::object::id<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::AuthorityCap<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::PACKAGE, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::GAME_KEEPER>>(&v1));
        let v2 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::new();
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::events::emit_admin_action(&v2, v0, 39);
        v1
    }

    public fun grant_market_keeper(arg0: &mut Config, arg1: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::AuthorityCap<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::PACKAGE, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::ADMIN>, arg2: &mut 0x2::tx_context::TxContext) : 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::AuthorityCap<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::PACKAGE, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::MARKET_KEEPER> {
        assert_version(arg0);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        let v0 = 0x2::object::id<Config>(arg0);
        let v1 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::new();
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::events::emit_admin_action(&v1, v0, 22);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::mint_role<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::MARKET_KEEPER>(&mut arg0.id, v0, arg2)
    }

    public fun grant_pause_guardian(arg0: &mut Config, arg1: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::AuthorityCap<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::PACKAGE, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::ADMIN>, arg2: &mut 0x2::tx_context::TxContext) : 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::AuthorityCap<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::PACKAGE, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::PAUSE_GUARDIAN> {
        assert_version(arg0);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        let v0 = 0x2::object::id<Config>(arg0);
        let v1 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::new();
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::events::emit_admin_action(&v1, v0, 21);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::mint_role<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::PAUSE_GUARDIAN>(&mut arg0.id, v0, arg2)
    }

    public fun harvest_batch_cap(arg0: &Config) : u64 {
        state(arg0).harvest_batch_cap
    }

    public fun is_paused(arg0: &Config) : bool {
        state(arg0).paused
    }

    public fun liq_bounty_cap(arg0: &Config) : u64 {
        state(arg0).econ.liq_bounty_cap
    }

    public fun loss_fee_bps(arg0: &Config) : u64 {
        state(arg0).econ.loss_fee_bps
    }

    public fun max_builder_share_bps(arg0: &Config) : u64 {
        state(arg0).max_builder_share_bps
    }

    public fun min_payout_factor_bps(arg0: &Config) : u64 {
        state(arg0).econ.min_payout_factor_bps
    }

    public fun pause_ratio_bps(arg0: &Config) : u64 {
        state(arg0).econ.pause_ratio_bps
    }

    public fun referee_discount_bps(arg0: &Config) : u64 {
        state(arg0).referee_discount_bps
    }

    public fun referral_enabled(arg0: &Config) : bool {
        state(arg0).referral_enabled
    }

    public fun referral_fee_bps(arg0: &Config) : u64 {
        state(arg0).referral_fee_bps
    }

    public fun register_extension<T0: drop>(arg0: &mut Config, arg1: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::AuthorityCap<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::PACKAGE, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::ADMIN>) {
        assert_version(arg0);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::register_uid<T0>(&mut arg0.id);
    }

    public fun resume_ratio_bps(arg0: &Config) : u64 {
        state(arg0).econ.resume_ratio_bps
    }

    public fun revoke_cap(arg0: &mut Config, arg1: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::AuthorityCap<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::PACKAGE, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::ADMIN>, arg2: 0x2::object::ID) {
        assert_version(arg0);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::revoke(&mut arg0.id, arg2);
        let v0 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::new();
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::events::emit_admin_action(&v0, 0x2::object::id<Config>(arg0), 24);
    }

    public fun second_level_fee_bps(arg0: &Config) : u64 {
        state(arg0).second_level_fee_bps
    }

    public fun set_builders_enabled(arg0: &mut Config, arg1: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::AuthorityCap<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::PACKAGE, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::ADMIN>, arg2: bool) {
        assert_version(arg0);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        let v0 = state(arg0).max_builder_share_bps;
        let v1 = state_mut(arg0);
        v1.builders_enabled = arg2;
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::events::emit_builder_config_event(v0, arg2);
        let v2 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::new();
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::events::emit_admin_action(&v2, 0x2::object::id<Config>(arg0), 37);
    }

    public fun set_closes_paused(arg0: &mut Config, arg1: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::AuthorityCap<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::PACKAGE, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::PAUSE_GUARDIAN>, arg2: bool) {
        assert_version(arg0);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::assert_role<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::PAUSE_GUARDIAN>(&arg0.id, 0x2::object::id<Config>(arg0), arg1);
        let v0 = state_mut(arg0);
        v0.closes_paused = arg2;
        let v1 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::new();
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::events::emit_admin_action(&v1, 0x2::object::id<Config>(arg0), 3);
    }

    public fun set_fee_params(arg0: &mut Config, arg1: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::AuthorityCap<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::PACKAGE, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::ADMIN>, arg2: u64, arg3: u64, arg4: u64) {
        assert_version(arg0);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        assert!(arg2 >= 8000 && arg2 <= 9000, 13837311594558652433);
        assert!(arg3 >= 1 && arg3 <= 500, 13837311603148587025);
        assert!(arg4 <= 500, 13837311607443554321);
        let v0 = state_mut(arg0);
        let v1 = &mut v0.econ;
        v1.trim_max_share_bps = arg2;
        v1.trim_c_ppm = arg3;
        v1.loss_fee_bps = arg4;
        let v2 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::new();
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::events::emit_admin_action(&v2, 0x2::object::id<Config>(arg0), 70);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::events::emit_fee_params_event(0x2::object::id<Config>(arg0), arg2, arg3, arg4);
    }

    public fun set_harvest_batch_cap(arg0: &mut Config, arg1: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::AuthorityCap<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::PACKAGE, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::ADMIN>, arg2: u64) {
        assert_version(arg0);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        assert!(arg2 >= 1 && arg2 <= 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::lp::max_entries(), 13835903584019283975);
        let v0 = state_mut(arg0);
        v0.harvest_batch_cap = arg2;
        let v1 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::new();
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::events::emit_admin_action(&v1, 0x2::object::id<Config>(arg0), 31);
    }

    public fun set_max_builder_share_bps(arg0: &mut Config, arg1: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::AuthorityCap<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::PACKAGE, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::ADMIN>, arg2: u64) {
        assert_version(arg0);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        let v0 = state(arg0);
        let v1 = v0.builders_enabled;
        assert!(arg2 <= 5000, 13837029350782664719);
        assert!(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::safety::protocol_shares_fit(arg2, v0.referee_discount_bps, v0.referral_fee_bps, v0.second_level_fee_bps), 13837029355077632015);
        let v2 = state_mut(arg0);
        v2.max_builder_share_bps = arg2;
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::events::emit_builder_config_event(arg2, v1);
        let v3 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::new();
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::events::emit_admin_action(&v3, 0x2::object::id<Config>(arg0), 36);
    }

    public fun set_referee_discount_bps(arg0: &mut Config, arg1: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::AuthorityCap<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::PACKAGE, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::ADMIN>, arg2: u64) {
        assert_version(arg0);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        let v0 = state(arg0);
        assert!(arg2 <= 5000, 13836747811381313549);
        assert!(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::safety::protocol_shares_fit(v0.max_builder_share_bps, arg2, v0.referral_fee_bps, v0.second_level_fee_bps), 13836747815676280845);
        let v1 = state_mut(arg0);
        v1.referee_discount_bps = arg2;
        let v2 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::new();
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::events::emit_admin_action(&v2, 0x2::object::id<Config>(arg0), 34);
    }

    public fun set_referral_enabled(arg0: &mut Config, arg1: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::AuthorityCap<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::PACKAGE, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::ADMIN>, arg2: bool) {
        assert_version(arg0);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        let v0 = state_mut(arg0);
        v0.referral_enabled = arg2;
        let v1 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::new();
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::events::emit_admin_action(&v1, 0x2::object::id<Config>(arg0), 35);
    }

    public fun set_referral_fee_bps(arg0: &mut Config, arg1: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::AuthorityCap<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::PACKAGE, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::ADMIN>, arg2: u64) {
        assert_version(arg0);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        let v0 = state(arg0);
        assert!(arg2 <= 5000, 13836184732578611209);
        assert!(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::safety::protocol_shares_fit(v0.max_builder_share_bps, v0.referee_discount_bps, arg2, v0.second_level_fee_bps), 13836184736873578505);
        let v1 = state_mut(arg0);
        v1.referral_fee_bps = arg2;
        let v2 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::new();
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::events::emit_admin_action(&v2, 0x2::object::id<Config>(arg0), 32);
    }

    public fun set_risk_globals(arg0: &mut Config, arg1: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::AuthorityCap<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::PACKAGE, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::ADMIN>, arg2: u64, arg3: u64, arg4: u64) {
        assert_version(arg0);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        assert!(arg2 >= 1000 && arg2 <= 10000, 13837311701932834833);
        assert!(arg3 >= 1 && arg3 <= 8, 13837311710522769425);
        assert!(arg4 <= 50000000, 13837311714817736721);
        let v0 = state_mut(arg0);
        let v1 = &mut v0.econ;
        v1.min_payout_factor_bps = arg2;
        v1.sweep_max = arg3;
        v1.liq_bounty_cap = arg4;
        let v2 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::new();
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::events::emit_admin_action(&v2, 0x2::object::id<Config>(arg0), 71);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::events::emit_risk_globals_event(0x2::object::id<Config>(arg0), arg2, arg3, arg4);
    }

    public fun set_second_level_fee_bps(arg0: &mut Config, arg1: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::AuthorityCap<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::PACKAGE, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::ADMIN>, arg2: u64) {
        assert_version(arg0);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        let v0 = state(arg0);
        assert!(arg2 <= 2500, 13836466271979962379);
        assert!(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::safety::protocol_shares_fit(v0.max_builder_share_bps, v0.referee_discount_bps, v0.referral_fee_bps, arg2), 13836466276274929675);
        let v1 = state_mut(arg0);
        v1.second_level_fee_bps = arg2;
        let v2 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::new();
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::events::emit_admin_action(&v2, 0x2::object::id<Config>(arg0), 33);
    }

    public fun set_taker_fee(arg0: &mut Config, arg1: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::AuthorityCap<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::PACKAGE, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::ADMIN>, arg2: u64) {
        assert_version(arg0);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        assert!(arg2 <= 2, 13835340238928609283);
        let v0 = state_mut(arg0);
        v0.taker_fee_bps = arg2;
        v0.taker_fee_set = true;
        let v1 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::new();
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::events::emit_admin_action(&v1, 0x2::object::id<Config>(arg0), 1);
    }

    public fun set_trading_paused(arg0: &mut Config, arg1: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::AuthorityCap<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::PACKAGE, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::PAUSE_GUARDIAN>, arg2: bool) {
        assert_version(arg0);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::assert_role<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::PAUSE_GUARDIAN>(&arg0.id, 0x2::object::id<Config>(arg0), arg1);
        state_mut(arg0).paused = arg2;
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::events::emit_pause_trading_event(arg2);
    }

    public fun set_waterfall(arg0: &mut Config, arg1: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::AuthorityCap<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::PACKAGE, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::ADMIN>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64) {
        assert_version(arg0);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        assert!(arg2 >= 3000 && arg2 <= 7000, 13837311843666755601);
        assert!(arg3 >= 11000, 13837311852256690193);
        assert!(arg4 >= arg3 + 1000 && arg4 <= 30000, 13837311869436559377);
        assert!(arg5 >= arg4 && arg5 <= 30000, 13837311886616428561);
        assert!(arg6 <= 2500, 13837311895206363153);
        assert!(arg7 >= 86400000 && arg7 <= 2592000000, 13837311912386232337);
        assert!(arg8 <= 7000, 13837311920976166929);
        assert!(arg10 <= 3000, 13837311925271134225);
        assert!(arg8 + arg9 + arg10 == 10000, 13837311929566101521);
        let v0 = state_mut(arg0);
        let v1 = &mut v0.econ;
        v1.staker_fee_bps = arg2;
        v1.pause_ratio_bps = arg3;
        v1.resume_ratio_bps = arg4;
        v1.surplus_floor_bps = arg5;
        v1.surplus_max_bps = arg6;
        v1.surplus_interval_ms = arg7;
        v1.surplus_staker_bps = arg8;
        v1.surplus_treasury_bps = arg9;
        v1.surplus_growth_bps = arg10;
        let v2 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::new();
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::events::emit_admin_action(&v2, 0x2::object::id<Config>(arg0), 72);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::events::emit_waterfall_params_event(0x2::object::id<Config>(arg0), arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    public fun set_win_fee(arg0: &mut Config, arg1: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::AuthorityCap<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::PACKAGE, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::ADMIN>, arg2: u64) {
        assert_version(arg0);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        assert!(arg2 >= 1 && arg2 <= 500, 13835340668425338883);
        let v0 = state_mut(arg0);
        v0.win_fee_bps = arg2;
        let v1 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::new();
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::events::emit_admin_action(&v1, 0x2::object::id<Config>(arg0), 2);
    }

    public(friend) fun share(arg0: Config) {
        0x2::transfer::share_object<Config>(arg0);
    }

    public fun staker_fee_bps(arg0: &Config) : u64 {
        state(arg0).econ.staker_fee_bps
    }

    fun state(arg0: &Config) : &ConfigStateV1 {
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::extended_field::borrow<ConfigStateV1>(&arg0.id, arg0.version)
    }

    fun state_mut(arg0: &mut Config) : &mut ConfigStateV1 {
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::extended_field::borrow_mut<ConfigStateV1>(&mut arg0.id, arg0.version)
    }

    public fun surplus_floor_bps(arg0: &Config) : u64 {
        state(arg0).econ.surplus_floor_bps
    }

    public fun surplus_growth_bps(arg0: &Config) : u64 {
        state(arg0).econ.surplus_growth_bps
    }

    public fun surplus_interval_ms(arg0: &Config) : u64 {
        state(arg0).econ.surplus_interval_ms
    }

    public fun surplus_max_bps(arg0: &Config) : u64 {
        state(arg0).econ.surplus_max_bps
    }

    public fun surplus_staker_bps(arg0: &Config) : u64 {
        state(arg0).econ.surplus_staker_bps
    }

    public fun surplus_treasury_bps(arg0: &Config) : u64 {
        state(arg0).econ.surplus_treasury_bps
    }

    public fun sweep_max(arg0: &Config) : u64 {
        state(arg0).econ.sweep_max
    }

    public fun taker_fee_bps(arg0: &Config) : u64 {
        let v0 = state(arg0);
        assert!(v0.taker_fee_set, 13835621679545712645);
        v0.taker_fee_bps
    }

    public fun taker_fee_is_set(arg0: &Config) : bool {
        state(arg0).taker_fee_set
    }

    public fun trim_c_ppm(arg0: &Config) : u64 {
        state(arg0).econ.trim_c_ppm
    }

    public fun trim_max_share_bps(arg0: &Config) : u64 {
        state(arg0).econ.trim_max_share_bps
    }

    public fun uid(arg0: &Config) : &0x2::object::UID {
        &arg0.id
    }

    public fun uid_mut(arg0: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::Auth, arg1: &mut Config) : &mut 0x2::object::UID {
        &mut arg1.id
    }

    public fun unregister_extension<T0: drop>(arg0: &mut Config, arg1: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::AuthorityCap<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::PACKAGE, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::ADMIN>) {
        assert_version(arg0);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::unregister_uid<T0>(&mut arg0.id);
    }

    public fun win_fee_bps(arg0: &Config) : u64 {
        state(arg0).win_fee_bps
    }

    // decompiled from Move bytecode v7
}

