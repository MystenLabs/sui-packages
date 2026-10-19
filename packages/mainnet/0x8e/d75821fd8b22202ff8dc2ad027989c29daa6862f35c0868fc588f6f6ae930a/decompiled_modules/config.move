module 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::config {
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
        max_pending_orders: u64,
        order_keepers: 0x2::vec_set::VecSet<address>,
        exec_fee_recipient: address,
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

    public fun add_order_keeper(arg0: &mut Config, arg1: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::AuthorityCap<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::PACKAGE, 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::ADMIN>, arg2: address) {
        assert_version(arg0);
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        let v0 = state_mut(arg0);
        let v1 = &mut v0.order_keepers;
        assert!(!0x2::vec_set::contains<address>(v1, &arg2) && 0x2::vec_set::length<address>(v1) < 8, 13863207331071197208);
        0x2::vec_set::insert<address>(v1, arg2);
        let v2 = 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::access::new();
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::events::emit_admin_action(&v2, 0x2::object::id<Config>(arg0), 77);
        let v3 = 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::access::new();
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::events::emit_admin_address(&v3, 0x2::object::id<Config>(arg0), 77, arg2);
    }

    public fun assert_version(arg0: &Config) {
        assert!(arg0.version == 1, 13835058703822225409);
    }

    public fun builders_enabled(arg0: &Config) : bool {
        state(arg0).builders_enabled
    }

    public fun cancel_extension_proposal<T0: drop>(arg0: &mut Config, arg1: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::AuthorityCap<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::PACKAGE, 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::ADMIN>) {
        assert_version(arg0);
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::access::cancel_uid<T0>(&mut arg0.id);
    }

    public fun closes_paused(arg0: &Config) : bool {
        state(arg0).closes_paused
    }

    public(friend) fun create(arg0: &mut 0x2::tx_context::TxContext) : (Config, 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::AuthorityCap<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::PACKAGE, 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::ADMIN>) {
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
            harvest_batch_cap     : 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::lp::max_entries(),
            referral_enabled      : true,
            referral_fee_bps      : 1000,
            second_level_fee_bps  : 250,
            referee_discount_bps  : 500,
            max_builder_share_bps : 2000,
            builders_enabled      : false,
            econ                  : v2,
            max_pending_orders    : 4,
            order_keepers         : 0x2::vec_set::empty<address>(),
            exec_fee_recipient    : 0x2::tx_context::sender(arg0),
            extra_fields          : 0x2::bag::new(arg0),
        };
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::extended_field::add<ConfigStateV1>(&mut v1.id, v0, v3);
        assert!(0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::safety::protocol_shares_fit(2000, 500, 1000, 250), 13836184565074886665);
        let v4 = 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::access::new();
        let v5 = &mut v1;
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::game_book::attach_config(uid_mut(&v4, v5), arg0);
        (v1, 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::mint_admin(0x2::object::id<Config>(&v1), arg0))
    }

    public fun effective_builder_share(arg0: &Config, arg1: u16) : u16 {
        let v0 = state(arg0).max_builder_share_bps;
        if ((arg1 as u64) > v0) {
            (v0 as u16)
        } else {
            arg1
        }
    }

    public fun exec_fee_recipient(arg0: &Config) : address {
        state(arg0).exec_fee_recipient
    }

    public fun grant_fee_recipient(arg0: &mut Config, arg1: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::AuthorityCap<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::PACKAGE, 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::ADMIN>, arg2: &mut 0x2::tx_context::TxContext) : 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::AuthorityCap<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::PACKAGE, 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::FEE_RECIPIENT> {
        assert_version(arg0);
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        let v0 = 0x2::object::id<Config>(arg0);
        let v1 = 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::access::new();
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::events::emit_admin_action(&v1, v0, 23);
        let v2 = 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::mint_role<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::FEE_RECIPIENT>(&mut arg0.id, v0, arg2);
        let v3 = 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::access::new();
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::events::emit_admin_id(&v3, v0, 23, 0x2::object::id<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::AuthorityCap<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::PACKAGE, 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::FEE_RECIPIENT>>(&v2));
        v2
    }

    public fun grant_game_keeper(arg0: &mut Config, arg1: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::AuthorityCap<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::PACKAGE, 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::ADMIN>, arg2: &mut 0x2::tx_context::TxContext) : 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::AuthorityCap<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::PACKAGE, 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::GAME_KEEPER> {
        assert_version(arg0);
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        let v0 = 0x2::object::id<Config>(arg0);
        let v1 = 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::mint_role<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::GAME_KEEPER>(&mut arg0.id, v0, arg2);
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::events::emit_game_keeper_granted_event(0x2::object::id<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::AuthorityCap<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::PACKAGE, 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::GAME_KEEPER>>(&v1));
        let v2 = 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::access::new();
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::events::emit_admin_action(&v2, v0, 39);
        let v3 = 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::access::new();
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::events::emit_admin_id(&v3, v0, 39, 0x2::object::id<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::AuthorityCap<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::PACKAGE, 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::GAME_KEEPER>>(&v1));
        v1
    }

    public fun grant_market_keeper(arg0: &mut Config, arg1: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::AuthorityCap<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::PACKAGE, 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::ADMIN>, arg2: &mut 0x2::tx_context::TxContext) : 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::AuthorityCap<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::PACKAGE, 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::MARKET_KEEPER> {
        assert_version(arg0);
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        let v0 = 0x2::object::id<Config>(arg0);
        let v1 = 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::access::new();
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::events::emit_admin_action(&v1, v0, 22);
        let v2 = 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::mint_role<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::MARKET_KEEPER>(&mut arg0.id, v0, arg2);
        let v3 = 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::access::new();
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::events::emit_admin_id(&v3, v0, 22, 0x2::object::id<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::AuthorityCap<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::PACKAGE, 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::MARKET_KEEPER>>(&v2));
        v2
    }

    public fun grant_pause_guardian(arg0: &mut Config, arg1: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::AuthorityCap<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::PACKAGE, 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::ADMIN>, arg2: &mut 0x2::tx_context::TxContext) : 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::AuthorityCap<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::PACKAGE, 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::PAUSE_GUARDIAN> {
        assert_version(arg0);
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        let v0 = 0x2::object::id<Config>(arg0);
        let v1 = 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::access::new();
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::events::emit_admin_action(&v1, v0, 21);
        let v2 = 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::mint_role<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::PAUSE_GUARDIAN>(&mut arg0.id, v0, arg2);
        let v3 = 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::access::new();
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::events::emit_admin_id(&v3, v0, 21, 0x2::object::id<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::AuthorityCap<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::PACKAGE, 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::PAUSE_GUARDIAN>>(&v2));
        v2
    }

    public fun harvest_batch_cap(arg0: &Config) : u64 {
        state(arg0).harvest_batch_cap
    }

    public fun is_order_keeper(arg0: &Config, arg1: address) : bool {
        0x2::vec_set::contains<address>(&state(arg0).order_keepers, &arg1)
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

    public fun max_pending_orders(arg0: &Config) : u64 {
        state(arg0).max_pending_orders
    }

    public fun min_payout_factor_bps(arg0: &Config) : u64 {
        state(arg0).econ.min_payout_factor_bps
    }

    public fun order_keepers(arg0: &Config) : vector<address> {
        *0x2::vec_set::keys<address>(&state(arg0).order_keepers)
    }

    public fun pause_ratio_bps(arg0: &Config) : u64 {
        state(arg0).econ.pause_ratio_bps
    }

    public(friend) fun propose_extension_inner<T0: drop>(arg0: &mut Config, arg1: u64) {
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::access::propose_uid<T0>(&mut arg0.id, arg1);
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

    public fun register_extension<T0: drop>(arg0: &mut Config, arg1: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::AuthorityCap<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::PACKAGE, 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::ADMIN>) {
        assert_version(arg0);
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::access::register_uid<T0>(&mut arg0.id);
    }

    public fun register_proposed_extension<T0: drop>(arg0: &mut Config, arg1: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::AuthorityCap<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::PACKAGE, 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::ADMIN>, arg2: &0x2::clock::Clock) {
        assert_version(arg0);
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::access::register_proposed_uid<T0>(&mut arg0.id, 0x2::clock::timestamp_ms(arg2));
    }

    fun remove_keeper_inner(arg0: &mut Config, arg1: address) {
        let v0 = state_mut(arg0);
        let v1 = &mut v0.order_keepers;
        assert!(0x2::vec_set::contains<address>(v1, &arg1), 13863207442740346904);
        0x2::vec_set::remove<address>(v1, &arg1);
        let v2 = 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::access::new();
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::events::emit_admin_action(&v2, 0x2::object::id<Config>(arg0), 78);
        let v3 = 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::access::new();
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::events::emit_admin_address(&v3, 0x2::object::id<Config>(arg0), 78, arg1);
    }

    public fun remove_order_keeper(arg0: &mut Config, arg1: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::AuthorityCap<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::PACKAGE, 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::ADMIN>, arg2: address) {
        assert_version(arg0);
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        remove_keeper_inner(arg0, arg2);
    }

    public fun remove_order_keeper_guardian(arg0: &mut Config, arg1: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::AuthorityCap<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::PACKAGE, 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::PAUSE_GUARDIAN>, arg2: address) {
        assert_version(arg0);
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::assert_role<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::PAUSE_GUARDIAN>(&arg0.id, 0x2::object::id<Config>(arg0), arg1);
        remove_keeper_inner(arg0, arg2);
    }

    public fun resume_ratio_bps(arg0: &Config) : u64 {
        state(arg0).econ.resume_ratio_bps
    }

    public fun revoke_cap(arg0: &mut Config, arg1: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::AuthorityCap<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::PACKAGE, 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::ADMIN>, arg2: 0x2::object::ID) {
        assert_version(arg0);
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::revoke(&mut arg0.id, arg2);
        let v0 = 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::access::new();
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::events::emit_admin_action(&v0, 0x2::object::id<Config>(arg0), 24);
        let v1 = 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::access::new();
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::events::emit_admin_id(&v1, 0x2::object::id<Config>(arg0), 24, arg2);
    }

    public fun second_level_fee_bps(arg0: &Config) : u64 {
        state(arg0).second_level_fee_bps
    }

    public fun set_builders_enabled(arg0: &mut Config, arg1: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::AuthorityCap<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::PACKAGE, 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::ADMIN>, arg2: bool) {
        assert_version(arg0);
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        let v0 = state(arg0).max_builder_share_bps;
        let v1 = state_mut(arg0);
        v1.builders_enabled = arg2;
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::events::emit_builder_config_event(0x2::object::id<Config>(arg0), v0, arg2);
        let v2 = 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::access::new();
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::events::emit_admin_action(&v2, 0x2::object::id<Config>(arg0), 37);
        let v3 = 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::access::new();
        let v4 = if (arg2) {
            1
        } else {
            0
        };
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::events::emit_admin_value(&v3, 0x2::object::id<Config>(arg0), 37, v4);
    }

    public fun set_closes_paused(arg0: &mut Config, arg1: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::AuthorityCap<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::PACKAGE, 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::PAUSE_GUARDIAN>, arg2: bool) {
        assert_version(arg0);
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::assert_role<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::PAUSE_GUARDIAN>(&arg0.id, 0x2::object::id<Config>(arg0), arg1);
        let v0 = state_mut(arg0);
        v0.closes_paused = arg2;
        let v1 = 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::access::new();
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::events::emit_admin_action(&v1, 0x2::object::id<Config>(arg0), 3);
        let v2 = 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::access::new();
        let v3 = if (arg2) {
            1
        } else {
            0
        };
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::events::emit_admin_value(&v2, 0x2::object::id<Config>(arg0), 3, v3);
    }

    public fun set_exec_fee_recipient(arg0: &mut Config, arg1: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::AuthorityCap<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::PACKAGE, 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::ADMIN>, arg2: address) {
        assert_version(arg0);
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        assert!(arg2 != @0x0, 13837593305758695443);
        let v0 = state_mut(arg0);
        v0.exec_fee_recipient = arg2;
        let v1 = 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::access::new();
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::events::emit_admin_action(&v1, 0x2::object::id<Config>(arg0), 80);
        let v2 = 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::access::new();
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::events::emit_admin_address(&v2, 0x2::object::id<Config>(arg0), 80, arg2);
    }

    public fun set_fee_params(arg0: &mut Config, arg1: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::AuthorityCap<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::PACKAGE, 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::ADMIN>, arg2: u64, arg3: u64, arg4: u64) {
        assert_version(arg0);
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        assert!(arg2 >= 8000 && arg2 <= 9000, 13837312062710087697);
        assert!(arg3 >= 1 && arg3 <= 500, 13837312071300022289);
        assert!(arg4 <= 500, 13837312075594989585);
        let v0 = state_mut(arg0);
        let v1 = &mut v0.econ;
        v1.trim_max_share_bps = arg2;
        v1.trim_c_ppm = arg3;
        v1.loss_fee_bps = arg4;
        let v2 = 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::access::new();
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::events::emit_admin_action(&v2, 0x2::object::id<Config>(arg0), 70);
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::events::emit_fee_params_event(0x2::object::id<Config>(arg0), arg2, arg3, arg4);
    }

    public fun set_harvest_batch_cap(arg0: &mut Config, arg1: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::AuthorityCap<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::PACKAGE, 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::ADMIN>, arg2: u64) {
        assert_version(arg0);
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        assert!(arg2 >= 1 && arg2 <= 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::lp::max_entries(), 13835903699983400967);
        let v0 = state_mut(arg0);
        v0.harvest_batch_cap = arg2;
        let v1 = 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::access::new();
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::events::emit_admin_action(&v1, 0x2::object::id<Config>(arg0), 31);
        let v2 = 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::access::new();
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::events::emit_admin_value(&v2, 0x2::object::id<Config>(arg0), 31, arg2);
    }

    public fun set_max_builder_share_bps(arg0: &mut Config, arg1: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::AuthorityCap<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::PACKAGE, 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::ADMIN>, arg2: u64) {
        assert_version(arg0);
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        let v0 = state(arg0);
        let v1 = v0.builders_enabled;
        assert!(arg2 <= 5000, 13837029449566912527);
        assert!(0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::safety::protocol_shares_fit(arg2, v0.referee_discount_bps, v0.referral_fee_bps, v0.second_level_fee_bps), 13837029453861879823);
        let v2 = state_mut(arg0);
        v2.max_builder_share_bps = arg2;
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::events::emit_builder_config_event(0x2::object::id<Config>(arg0), arg2, v1);
        let v3 = 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::access::new();
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::events::emit_admin_action(&v3, 0x2::object::id<Config>(arg0), 36);
        let v4 = 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::access::new();
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::events::emit_admin_value(&v4, 0x2::object::id<Config>(arg0), 36, arg2);
    }

    public fun set_max_pending_orders(arg0: &mut Config, arg1: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::AuthorityCap<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::PACKAGE, 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::ADMIN>, arg2: u64) {
        assert_version(arg0);
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        assert!(arg2 >= 1 && arg2 <= 32, 13863207485690019864);
        let v0 = state_mut(arg0);
        v0.max_pending_orders = arg2;
        let v1 = 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::access::new();
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::events::emit_admin_action(&v1, 0x2::object::id<Config>(arg0), 79);
        let v2 = 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::access::new();
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::events::emit_admin_value(&v2, 0x2::object::id<Config>(arg0), 79, arg2);
    }

    public fun set_referee_discount_bps(arg0: &mut Config, arg1: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::AuthorityCap<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::PACKAGE, 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::ADMIN>, arg2: u64) {
        assert_version(arg0);
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        let v0 = state(arg0);
        assert!(arg2 <= 5000, 13836747905870594061);
        assert!(0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::safety::protocol_shares_fit(v0.max_builder_share_bps, arg2, v0.referral_fee_bps, v0.second_level_fee_bps), 13836747910165561357);
        let v1 = state_mut(arg0);
        v1.referee_discount_bps = arg2;
        let v2 = 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::access::new();
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::events::emit_admin_action(&v2, 0x2::object::id<Config>(arg0), 34);
        let v3 = 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::access::new();
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::events::emit_admin_value(&v3, 0x2::object::id<Config>(arg0), 34, arg2);
    }

    public fun set_referral_enabled(arg0: &mut Config, arg1: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::AuthorityCap<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::PACKAGE, 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::ADMIN>, arg2: bool) {
        assert_version(arg0);
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        let v0 = state_mut(arg0);
        v0.referral_enabled = arg2;
        let v1 = 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::access::new();
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::events::emit_admin_action(&v1, 0x2::object::id<Config>(arg0), 35);
        let v2 = 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::access::new();
        let v3 = if (arg2) {
            1
        } else {
            0
        };
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::events::emit_admin_value(&v2, 0x2::object::id<Config>(arg0), 35, v3);
    }

    public fun set_referral_fee_bps(arg0: &mut Config, arg1: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::AuthorityCap<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::PACKAGE, 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::ADMIN>, arg2: u64) {
        assert_version(arg0);
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        let v0 = state(arg0);
        assert!(arg2 <= 5000, 13836184818477957129);
        assert!(0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::safety::protocol_shares_fit(v0.max_builder_share_bps, v0.referee_discount_bps, arg2, v0.second_level_fee_bps), 13836184822772924425);
        let v1 = state_mut(arg0);
        v1.referral_fee_bps = arg2;
        let v2 = 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::access::new();
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::events::emit_admin_action(&v2, 0x2::object::id<Config>(arg0), 32);
        let v3 = 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::access::new();
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::events::emit_admin_value(&v3, 0x2::object::id<Config>(arg0), 32, arg2);
    }

    public fun set_risk_globals(arg0: &mut Config, arg1: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::AuthorityCap<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::PACKAGE, 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::ADMIN>, arg2: u64, arg3: u64, arg4: u64) {
        assert_version(arg0);
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        assert!(arg2 >= 1000 && arg2 <= 10000, 13837312170084270097);
        assert!(arg3 >= 1 && arg3 <= 8, 13837312178674204689);
        assert!(arg4 <= 50000000, 13837312182969171985);
        let v0 = state_mut(arg0);
        let v1 = &mut v0.econ;
        v1.min_payout_factor_bps = arg2;
        v1.sweep_max = arg3;
        v1.liq_bounty_cap = arg4;
        let v2 = 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::access::new();
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::events::emit_admin_action(&v2, 0x2::object::id<Config>(arg0), 71);
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::events::emit_risk_globals_event(0x2::object::id<Config>(arg0), arg2, arg3, arg4);
    }

    public fun set_second_level_fee_bps(arg0: &mut Config, arg1: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::AuthorityCap<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::PACKAGE, 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::ADMIN>, arg2: u64) {
        assert_version(arg0);
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        let v0 = state(arg0);
        assert!(arg2 <= 2500, 13836466362174275595);
        assert!(0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::safety::protocol_shares_fit(v0.max_builder_share_bps, v0.referee_discount_bps, v0.referral_fee_bps, arg2), 13836466366469242891);
        let v1 = state_mut(arg0);
        v1.second_level_fee_bps = arg2;
        let v2 = 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::access::new();
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::events::emit_admin_action(&v2, 0x2::object::id<Config>(arg0), 33);
        let v3 = 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::access::new();
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::events::emit_admin_value(&v3, 0x2::object::id<Config>(arg0), 33, arg2);
    }

    public fun set_taker_fee(arg0: &mut Config, arg1: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::AuthorityCap<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::PACKAGE, 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::ADMIN>, arg2: u64) {
        assert_version(arg0);
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        assert!(arg2 <= 2, 13835340320532987907);
        let v0 = state_mut(arg0);
        v0.taker_fee_bps = arg2;
        v0.taker_fee_set = true;
        let v1 = 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::access::new();
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::events::emit_admin_action(&v1, 0x2::object::id<Config>(arg0), 1);
        let v2 = 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::access::new();
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::events::emit_admin_value(&v2, 0x2::object::id<Config>(arg0), 1, arg2);
    }

    public fun set_trading_paused(arg0: &mut Config, arg1: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::AuthorityCap<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::PACKAGE, 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::PAUSE_GUARDIAN>, arg2: bool) {
        assert_version(arg0);
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::assert_role<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::PAUSE_GUARDIAN>(&arg0.id, 0x2::object::id<Config>(arg0), arg1);
        let v0 = state_mut(arg0);
        v0.paused = arg2;
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::events::emit_pause_trading_event(0x2::object::id<Config>(arg0), arg2);
    }

    public fun set_waterfall(arg0: &mut Config, arg1: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::AuthorityCap<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::PACKAGE, 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::ADMIN>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64) {
        assert_version(arg0);
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        assert!(arg2 >= 3000 && arg2 <= 7000, 13837312311818190865);
        assert!(arg3 >= 11000, 13837312320408125457);
        assert!(arg4 >= arg3 + 1000 && arg4 <= 30000, 13837312337587994641);
        assert!(arg5 >= arg4 && arg5 <= 30000, 13837312354767863825);
        assert!(arg6 <= 2500, 13837312363357798417);
        assert!(arg7 >= 86400000 && arg7 <= 2592000000, 13837312380537667601);
        assert!(arg8 <= 7000, 13837312389127602193);
        assert!(arg10 <= 3000, 13837312393422569489);
        assert!(arg8 + arg9 + arg10 == 10000, 13837312397717536785);
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
        let v2 = 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::access::new();
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::events::emit_admin_action(&v2, 0x2::object::id<Config>(arg0), 72);
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::events::emit_waterfall_params_event(0x2::object::id<Config>(arg0), arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    public fun set_win_fee(arg0: &mut Config, arg1: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::AuthorityCap<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::PACKAGE, 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::ADMIN>, arg2: u64) {
        assert_version(arg0);
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        assert!(arg2 >= 1 && arg2 <= 500, 13835340788684423171);
        let v0 = state_mut(arg0);
        v0.win_fee_bps = arg2;
        let v1 = 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::access::new();
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::events::emit_admin_action(&v1, 0x2::object::id<Config>(arg0), 2);
        let v2 = 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::access::new();
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::events::emit_admin_value(&v2, 0x2::object::id<Config>(arg0), 2, arg2);
    }

    public(friend) fun share(arg0: Config) {
        0x2::transfer::share_object<Config>(arg0);
    }

    public fun staker_fee_bps(arg0: &Config) : u64 {
        state(arg0).econ.staker_fee_bps
    }

    fun state(arg0: &Config) : &ConfigStateV1 {
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::extended_field::borrow<ConfigStateV1>(&arg0.id, arg0.version)
    }

    fun state_mut(arg0: &mut Config) : &mut ConfigStateV1 {
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::extended_field::borrow_mut<ConfigStateV1>(&mut arg0.id, arg0.version)
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
        assert!(v0.taker_fee_set, 13835621761150091269);
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

    public fun uid_mut(arg0: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::access::Auth, arg1: &mut Config) : &mut 0x2::object::UID {
        &mut arg1.id
    }

    public fun unregister_extension<T0: drop>(arg0: &mut Config, arg1: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::AuthorityCap<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::PACKAGE, 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::ADMIN>) {
        assert_version(arg0);
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::access::unregister_uid<T0>(&mut arg0.id);
    }

    public fun win_fee_bps(arg0: &Config) : u64 {
        state(arg0).win_fee_bps
    }

    // decompiled from Move bytecode v7
}

