module 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config {
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

    struct PauseFlagsKey has copy, drop, store {
        dummy_field: bool,
    }

    struct PauseFlagsV1 has drop, store {
        mask: u64,
    }

    struct EconParamsV1 has copy, drop, store {
        trim_max_share_bps: u64,
        trim_c_ppm: u64,
        loss_fee_bps: u64,
        min_payout_factor_bps: u64,
        sweep_max: u64,
        liq_bounty_cap: u64,
        staker_fee_bps: u64,
        surplus_floor_bps: u64,
        surplus_max_bps: u64,
        surplus_interval_ms: u64,
        surplus_staker_bps: u64,
        surplus_treasury_bps: u64,
        surplus_growth_bps: u64,
        staker_share_min_bps: u64,
        staker_share_max_bps: u64,
        staker_cov_low_bps: u64,
        staker_cov_high_bps: u64,
    }

    struct ForceCloseMinGapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct LiqGraceKey has copy, drop, store {
        dummy_field: bool,
    }

    struct SurplusCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct SurplusCashFloorKey has copy, drop, store {
        dummy_field: bool,
    }

    public fun add_order_keeper(arg0: &mut Config, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::AuthorityCap<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::PACKAGE, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::ADMIN>, arg2: address) {
        assert_version(arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        let v0 = state_mut(arg0);
        let v1 = &mut v0.order_keepers;
        assert!(!0x2::vec_set::contains<address>(v1, &arg2) && 0x2::vec_set::length<address>(v1) < 8, 13863208610974793803);
        0x2::vec_set::insert<address>(v1, arg2);
        let v2 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::new();
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_admin_action(&v2, 0x2::object::id<Config>(arg0), 77);
        let v3 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::new();
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_admin_address(&v3, 0x2::object::id<Config>(arg0), 77, arg2);
    }

    public fun admin_pause_all(arg0: &mut Config, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::AuthorityCap<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::PACKAGE, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::ADMIN>) {
        assert_version(arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        write_all(arg0, true, true);
    }

    public fun admin_set_category_paused(arg0: &mut Config, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::AuthorityCap<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::PACKAGE, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::ADMIN>, arg2: u8, arg3: bool) {
        assert_version(arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        write_category(arg0, arg2, arg3, true);
    }

    public fun admin_set_closes_paused(arg0: &mut Config, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::AuthorityCap<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::PACKAGE, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::ADMIN>, arg2: bool) {
        assert_version(arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        write_category(arg0, 1, arg2, true);
    }

    public fun admin_set_trading_paused(arg0: &mut Config, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::AuthorityCap<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::PACKAGE, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::ADMIN>, arg2: bool) {
        assert_version(arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        write_category(arg0, 0, arg2, true);
    }

    public fun admin_unpause_all(arg0: &mut Config, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::AuthorityCap<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::PACKAGE, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::ADMIN>) {
        assert_version(arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        write_all(arg0, false, true);
    }

    fun assert_mask_unpaused(arg0: u64, arg1: u8) {
        if (!mask_paused(arg0, arg1)) {
            return
        } else {
            assert!(arg1 != 0, 13842096982697443377);
            assert!(arg1 != 1, 13842378461969252403);
            assert!(arg1 != 2, 13838156341611724823);
            assert!(arg1 != 3, 13838437820883533849);
            assert!(arg1 != 4, 13838719300155342875);
            assert!(arg1 != 5, 13839000779427151901);
            assert!(arg1 != 6, 13839282258698960927);
            assert!(arg1 != 7, 13839563737970769953);
            assert!(arg1 != 8, 13839845217242578979);
            assert!(arg1 != 9, 13840126696514388005);
            assert!(arg1 != 10, 13840408175786197031);
            assert!(arg1 != 11, 13840689655058006057);
            assert!(arg1 != 12, 13840971134329815083);
            assert!(arg1 != 13, 13841252613601624109);
            abort 13841534092873433135
        };
    }

    public fun assert_unpaused(arg0: &Config, arg1: u8) {
        assert_mask_unpaused(pause_mask(arg0), arg1);
    }

    public fun assert_version(arg0: &Config) {
        assert!(arg0.version == 1, 13835059021649805313);
    }

    public fun builders_enabled(arg0: &Config) : bool {
        state(arg0).builders_enabled
    }

    public fun cancel_extension_proposal<T0: drop>(arg0: &mut Config, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::AuthorityCap<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::PACKAGE, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::ADMIN>) {
        assert_version(arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::cancel_uid<T0>(&mut arg0.id);
    }

    public fun category_paused(arg0: &Config, arg1: u8) : bool {
        mask_paused(pause_mask(arg0), arg1)
    }

    public fun closes_paused(arg0: &Config) : bool {
        state(arg0).closes_paused
    }

    public(friend) fun create(arg0: &mut 0x2::tx_context::TxContext) : (Config, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::AuthorityCap<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::PACKAGE, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::ADMIN>) {
        let v0 = 1;
        let v1 = Config{
            id      : 0x2::object::new(arg0),
            version : v0,
        };
        let v2 = EconParamsV1{
            trim_max_share_bps    : 9184,
            trim_c_ppm            : 40,
            loss_fee_bps          : 200,
            min_payout_factor_bps : 3000,
            sweep_max             : 3,
            liq_bounty_cap        : 5000000,
            staker_fee_bps        : 5000,
            surplus_floor_bps     : 22500,
            surplus_max_bps       : 100,
            surplus_interval_ms   : 3600000,
            surplus_staker_bps    : 5000,
            surplus_treasury_bps  : 3500,
            surplus_growth_bps    : 1500,
            staker_share_min_bps  : 3000,
            staker_share_max_bps  : 7000,
            staker_cov_low_bps    : 10000,
            staker_cov_high_bps   : 20000,
        };
        let v3 = ConfigStateV1{
            id                    : 0x2::object::new(arg0),
            paused                : false,
            closes_paused         : false,
            taker_fee_bps         : 0,
            taker_fee_set         : false,
            win_fee_bps           : 200,
            harvest_batch_cap     : 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::lp::max_entries(),
            referral_enabled      : true,
            referral_fee_bps      : 1000,
            second_level_fee_bps  : 250,
            referee_discount_bps  : 500,
            max_builder_share_bps : 2000,
            builders_enabled      : false,
            econ                  : v2,
            max_pending_orders    : 3,
            order_keepers         : 0x2::vec_set::empty<address>(),
            exec_fee_recipient    : 0x2::tx_context::sender(arg0),
            extra_fields          : 0x2::bag::new(arg0),
        };
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::extended_field::add<ConfigStateV1>(&mut v1.id, v0, v3);
        assert!(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::safety::protocol_shares_fit(2000, 500, 1000, 250), 13836184887197433865);
        (v1, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::mint_admin(0x2::object::id<Config>(&v1), arg0))
    }

    public fun deposits_paused(arg0: &Config) : bool {
        category_paused(arg0, 2)
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

    fun extended_mask(arg0: &Config) : u64 {
        let v0 = PauseFlagsKey{dummy_field: false};
        if (0x2::dynamic_field::exists<PauseFlagsKey>(&arg0.id, v0)) {
            let v2 = PauseFlagsKey{dummy_field: false};
            0x2::dynamic_field::borrow<PauseFlagsKey, PauseFlagsV1>(&arg0.id, v2).mask
        } else {
            0
        }
    }

    public fun force_close_min_gap_ms(arg0: &Config) : u64 {
        let v0 = &state(arg0).extra_fields;
        let v1 = ForceCloseMinGapKey{dummy_field: false};
        if (0x2::bag::contains<ForceCloseMinGapKey>(v0, v1)) {
            let v3 = ForceCloseMinGapKey{dummy_field: false};
            *0x2::bag::borrow<ForceCloseMinGapKey, u64>(v0, v3)
        } else {
            60000
        }
    }

    public fun game_paused(arg0: &Config) : bool {
        category_paused(arg0, 11)
    }

    public fun grant_fee_recipient(arg0: &mut Config, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::AuthorityCap<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::PACKAGE, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::ADMIN>, arg2: &mut 0x2::tx_context::TxContext) : 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::AuthorityCap<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::PACKAGE, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::FEE_RECIPIENT> {
        assert_version(arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        let v0 = 0x2::object::id<Config>(arg0);
        let v1 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::new();
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_admin_action(&v1, v0, 23);
        let v2 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::mint_role<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::FEE_RECIPIENT>(&mut arg0.id, v0, arg2);
        let v3 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::new();
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_admin_id(&v3, v0, 23, 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::AuthorityCap<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::PACKAGE, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::FEE_RECIPIENT>>(&v2));
        v2
    }

    public fun grant_game_keeper(arg0: &mut Config, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::AuthorityCap<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::PACKAGE, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::ADMIN>, arg2: &mut 0x2::tx_context::TxContext) : 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::AuthorityCap<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::PACKAGE, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::GAME_KEEPER> {
        assert_version(arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        let v0 = 0x2::object::id<Config>(arg0);
        let v1 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::mint_role<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::GAME_KEEPER>(&mut arg0.id, v0, arg2);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_game_keeper_granted_event(0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::AuthorityCap<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::PACKAGE, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::GAME_KEEPER>>(&v1));
        let v2 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::new();
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_admin_action(&v2, v0, 39);
        let v3 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::new();
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_admin_id(&v3, v0, 39, 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::AuthorityCap<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::PACKAGE, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::GAME_KEEPER>>(&v1));
        v1
    }

    public fun grant_market_keeper(arg0: &mut Config, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::AuthorityCap<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::PACKAGE, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::ADMIN>, arg2: &mut 0x2::tx_context::TxContext) : 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::AuthorityCap<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::PACKAGE, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::MARKET_KEEPER> {
        assert_version(arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        let v0 = 0x2::object::id<Config>(arg0);
        let v1 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::new();
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_admin_action(&v1, v0, 22);
        let v2 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::mint_role<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::MARKET_KEEPER>(&mut arg0.id, v0, arg2);
        let v3 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::new();
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_admin_id(&v3, v0, 22, 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::AuthorityCap<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::PACKAGE, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::MARKET_KEEPER>>(&v2));
        v2
    }

    public fun grant_pause_guardian(arg0: &mut Config, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::AuthorityCap<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::PACKAGE, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::ADMIN>, arg2: &mut 0x2::tx_context::TxContext) : 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::AuthorityCap<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::PACKAGE, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::PAUSE_GUARDIAN> {
        assert_version(arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        let v0 = 0x2::object::id<Config>(arg0);
        let v1 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::new();
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_admin_action(&v1, v0, 21);
        let v2 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::mint_role<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::PAUSE_GUARDIAN>(&mut arg0.id, v0, arg2);
        let v3 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::new();
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_admin_id(&v3, v0, 21, 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::AuthorityCap<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::PACKAGE, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::PAUSE_GUARDIAN>>(&v2));
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

    public fun liq_grace_ms(arg0: &Config) : u64 {
        let v0 = &state(arg0).extra_fields;
        let v1 = LiqGraceKey{dummy_field: false};
        if (0x2::bag::contains<LiqGraceKey>(v0, v1)) {
            let v3 = LiqGraceKey{dummy_field: false};
            *0x2::bag::borrow<LiqGraceKey, u64>(v0, v3)
        } else {
            30000
        }
    }

    public fun liquidations_paused(arg0: &Config) : bool {
        category_paused(arg0, 4)
    }

    public fun loss_fee_bps(arg0: &Config) : u64 {
        state(arg0).econ.loss_fee_bps
    }

    public fun mask_paused(arg0: u64, arg1: u8) : bool {
        assert!(arg1 < 15, 13837874759260700693);
        arg0 >> arg1 & 1 == 1
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

    public fun pause_accounts() : u8 {
        14
    }

    public fun pause_all(arg0: &mut Config, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::AuthorityCap<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::PACKAGE, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::PAUSE_GUARDIAN>) {
        assert_version(arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::assert_role<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::PAUSE_GUARDIAN>(&arg0.id, 0x2::object::id<Config>(arg0), arg1);
        write_all(arg0, true, false);
    }

    public fun pause_all_mask() : u64 {
        (1 << 15) - 1
    }

    public fun pause_closes() : u8 {
        1
    }

    public fun pause_deposits() : u8 {
        2
    }

    public fun pause_fee_mint() : u8 {
        12
    }

    public fun pause_force_close() : u8 {
        5
    }

    public fun pause_game() : u8 {
        11
    }

    public fun pause_harvest() : u8 {
        6
    }

    public fun pause_liquidations() : u8 {
        4
    }

    public fun pause_lp() : u8 {
        10
    }

    public fun pause_mask(arg0: &Config) : u64 {
        let v0 = state(arg0);
        let v1 = extended_mask(arg0);
        let v2 = v1;
        if (v0.paused) {
            v2 = v1 | 1 << 0;
        };
        if (v0.closes_paused) {
            v2 = v2 | 1 << 1;
        };
        v2
    }

    public fun pause_opens() : u8 {
        0
    }

    public fun pause_referrals() : u8 {
        13
    }

    public fun pause_stake() : u8 {
        7
    }

    public fun pause_staking_claims() : u8 {
        9
    }

    public fun pause_unstake() : u8 {
        8
    }

    public fun pause_withdrawals() : u8 {
        3
    }

    public(friend) fun propose_extension_inner<T0: drop>(arg0: &mut Config, arg1: u64) {
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::propose_uid<T0>(&mut arg0.id, arg1);
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

    public fun register_extension<T0: drop>(arg0: &mut Config, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::AuthorityCap<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::PACKAGE, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::ADMIN>) {
        assert_version(arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::register_uid<T0>(&mut arg0.id);
    }

    public fun register_proposed_extension<T0: drop>(arg0: &mut Config, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::AuthorityCap<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::PACKAGE, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::ADMIN>, arg2: &0x2::clock::Clock) {
        assert_version(arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::register_proposed_uid<T0>(&mut arg0.id, 0x2::clock::timestamp_ms(arg2));
    }

    fun remove_keeper_inner(arg0: &mut Config, arg1: address) {
        let v0 = state_mut(arg0);
        let v1 = &mut v0.order_keepers;
        assert!(0x2::vec_set::contains<address>(v1, &arg1), 13863208722643943499);
        0x2::vec_set::remove<address>(v1, &arg1);
        let v2 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::new();
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_admin_action(&v2, 0x2::object::id<Config>(arg0), 78);
        let v3 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::new();
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_admin_address(&v3, 0x2::object::id<Config>(arg0), 78, arg1);
    }

    public fun remove_order_keeper(arg0: &mut Config, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::AuthorityCap<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::PACKAGE, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::ADMIN>, arg2: address) {
        assert_version(arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        remove_keeper_inner(arg0, arg2);
    }

    public fun remove_order_keeper_guardian(arg0: &mut Config, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::AuthorityCap<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::PACKAGE, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::PAUSE_GUARDIAN>, arg2: address) {
        assert_version(arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::assert_role<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::PAUSE_GUARDIAN>(&arg0.id, 0x2::object::id<Config>(arg0), arg1);
        remove_keeper_inner(arg0, arg2);
    }

    public fun revoke_cap(arg0: &mut Config, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::AuthorityCap<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::PACKAGE, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::ADMIN>, arg2: 0x2::object::ID) {
        assert_version(arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::revoke(&mut arg0.id, arg2);
        let v0 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::new();
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_admin_action(&v0, 0x2::object::id<Config>(arg0), 24);
        let v1 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::new();
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_admin_id(&v1, 0x2::object::id<Config>(arg0), 24, arg2);
    }

    public fun second_level_fee_bps(arg0: &Config) : u64 {
        state(arg0).second_level_fee_bps
    }

    public fun set_builders_enabled(arg0: &mut Config, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::AuthorityCap<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::PACKAGE, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::ADMIN>, arg2: bool) {
        assert_version(arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        let v0 = state(arg0).max_builder_share_bps;
        let v1 = state_mut(arg0);
        v1.builders_enabled = arg2;
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_builder_config_event(0x2::object::id<Config>(arg0), v0, arg2);
        let v2 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::new();
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_admin_action(&v2, 0x2::object::id<Config>(arg0), 37);
        let v3 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::new();
        let v4 = if (arg2) {
            1
        } else {
            0
        };
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_admin_value(&v3, 0x2::object::id<Config>(arg0), 37, v4);
    }

    public fun set_category_paused(arg0: &mut Config, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::AuthorityCap<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::PACKAGE, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::PAUSE_GUARDIAN>, arg2: u8, arg3: bool) {
        assert_version(arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::assert_role<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::PAUSE_GUARDIAN>(&arg0.id, 0x2::object::id<Config>(arg0), arg1);
        assert!(arg3, 13863489209776734261);
        write_category(arg0, arg2, arg3, false);
    }

    public fun set_closes_paused(arg0: &mut Config, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::AuthorityCap<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::PACKAGE, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::PAUSE_GUARDIAN>, arg2: bool) {
        assert_version(arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::assert_role<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::PAUSE_GUARDIAN>(&arg0.id, 0x2::object::id<Config>(arg0), arg1);
        assert!(arg2, 13863488660020920373);
        write_closes_paused(arg0, arg2);
    }

    public fun set_exec_fee_recipient(arg0: &mut Config, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::AuthorityCap<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::PACKAGE, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::ADMIN>, arg2: address) {
        assert_version(arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        assert!(arg2 != @0x0, 13837594585658949651);
        let v0 = state_mut(arg0);
        v0.exec_fee_recipient = arg2;
        let v1 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::new();
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_admin_action(&v1, 0x2::object::id<Config>(arg0), 80);
        let v2 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::new();
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_admin_address(&v2, 0x2::object::id<Config>(arg0), 80, arg2);
    }

    fun set_extended_mask(arg0: &mut Config, arg1: u64) {
        let v0 = PauseFlagsKey{dummy_field: false};
        if (0x2::dynamic_field::exists<PauseFlagsKey>(&arg0.id, v0)) {
            let v1 = PauseFlagsKey{dummy_field: false};
            0x2::dynamic_field::borrow_mut<PauseFlagsKey, PauseFlagsV1>(&mut arg0.id, v1).mask = arg1;
        } else {
            let v2 = PauseFlagsKey{dummy_field: false};
            let v3 = PauseFlagsV1{mask: arg1};
            0x2::dynamic_field::add<PauseFlagsKey, PauseFlagsV1>(&mut arg0.id, v2, v3);
        };
    }

    public fun set_fee_params(arg0: &mut Config, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::AuthorityCap<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::PACKAGE, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::ADMIN>, arg2: u64, arg3: u64, arg4: u64) {
        assert_version(arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        assert!(arg2 >= 8000 && arg2 <= 9184, 13837313815056744465);
        assert!(arg3 >= 1 && arg3 <= 500, 13837313823646679057);
        assert!(arg4 <= 500, 13837313827941646353);
        let v0 = state_mut(arg0);
        let v1 = &mut v0.econ;
        v1.trim_max_share_bps = arg2;
        v1.trim_c_ppm = arg3;
        v1.loss_fee_bps = arg4;
        let v2 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::new();
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_admin_action(&v2, 0x2::object::id<Config>(arg0), 70);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_fee_params_event(0x2::object::id<Config>(arg0), arg2, arg3, arg4);
    }

    public fun set_force_close_min_gap_ms(arg0: &mut Config, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::AuthorityCap<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::PACKAGE, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::ADMIN>, arg2: u64) {
        assert_version(arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        assert!(arg2 >= 10000 && arg2 <= 900000, 13837313346905309201);
        let v0 = state_mut(arg0);
        let v1 = &mut v0.extra_fields;
        let v2 = ForceCloseMinGapKey{dummy_field: false};
        if (0x2::bag::contains<ForceCloseMinGapKey>(v1, v2)) {
            let v3 = ForceCloseMinGapKey{dummy_field: false};
            *0x2::bag::borrow_mut<ForceCloseMinGapKey, u64>(v1, v3) = arg2;
        } else {
            let v4 = ForceCloseMinGapKey{dummy_field: false};
            0x2::bag::add<ForceCloseMinGapKey, u64>(v1, v4, arg2);
        };
        let v5 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::new();
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_admin_action(&v5, 0x2::object::id<Config>(arg0), 82);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_force_close_min_gap_event(0x2::object::id<Config>(arg0), arg2);
    }

    public fun set_harvest_batch_cap(arg0: &mut Config, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::AuthorityCap<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::PACKAGE, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::ADMIN>, arg2: u64) {
        assert_version(arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        assert!(arg2 >= 1 && arg2 <= 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::lp::max_entries(), 13835904017810980871);
        let v0 = state_mut(arg0);
        v0.harvest_batch_cap = arg2;
        let v1 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::new();
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_admin_action(&v1, 0x2::object::id<Config>(arg0), 31);
        let v2 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::new();
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_admin_value(&v2, 0x2::object::id<Config>(arg0), 31, arg2);
    }

    public fun set_liq_grace_ms(arg0: &mut Config, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::AuthorityCap<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::PACKAGE, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::ADMIN>, arg2: u64) {
        assert_version(arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        assert!(arg2 >= 5000 && arg2 <= 300000, 13837313458574458897);
        let v0 = state_mut(arg0);
        let v1 = &mut v0.extra_fields;
        let v2 = LiqGraceKey{dummy_field: false};
        if (0x2::bag::contains<LiqGraceKey>(v1, v2)) {
            let v3 = LiqGraceKey{dummy_field: false};
            *0x2::bag::borrow_mut<LiqGraceKey, u64>(v1, v3) = arg2;
        } else {
            let v4 = LiqGraceKey{dummy_field: false};
            0x2::bag::add<LiqGraceKey, u64>(v1, v4, arg2);
        };
        let v5 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::new();
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_admin_action(&v5, 0x2::object::id<Config>(arg0), 84);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_liq_grace_event(0x2::object::id<Config>(arg0), arg2);
    }

    public fun set_max_builder_share_bps(arg0: &mut Config, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::AuthorityCap<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::PACKAGE, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::ADMIN>, arg2: u64) {
        assert_version(arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        let v0 = state(arg0);
        let v1 = v0.builders_enabled;
        assert!(arg2 <= 5000, 13837029767394492431);
        assert!(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::safety::protocol_shares_fit(arg2, v0.referee_discount_bps, v0.referral_fee_bps, v0.second_level_fee_bps), 13837029771689459727);
        let v2 = state_mut(arg0);
        v2.max_builder_share_bps = arg2;
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_builder_config_event(0x2::object::id<Config>(arg0), arg2, v1);
        let v3 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::new();
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_admin_action(&v3, 0x2::object::id<Config>(arg0), 36);
        let v4 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::new();
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_admin_value(&v4, 0x2::object::id<Config>(arg0), 36, arg2);
    }

    public fun set_max_pending_orders(arg0: &mut Config, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::AuthorityCap<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::PACKAGE, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::ADMIN>, arg2: u64) {
        assert_version(arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        assert!(arg2 >= 1 && arg2 <= 32, 13863208765593616459);
        let v0 = state_mut(arg0);
        v0.max_pending_orders = arg2;
        let v1 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::new();
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_admin_action(&v1, 0x2::object::id<Config>(arg0), 79);
        let v2 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::new();
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_admin_value(&v2, 0x2::object::id<Config>(arg0), 79, arg2);
    }

    public fun set_referee_discount_bps(arg0: &mut Config, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::AuthorityCap<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::PACKAGE, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::ADMIN>, arg2: u64) {
        assert_version(arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        let v0 = state(arg0);
        assert!(arg2 <= 5000, 13836748223698173965);
        assert!(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::safety::protocol_shares_fit(v0.max_builder_share_bps, arg2, v0.referral_fee_bps, v0.second_level_fee_bps), 13836748227993141261);
        let v1 = state_mut(arg0);
        v1.referee_discount_bps = arg2;
        let v2 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::new();
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_admin_action(&v2, 0x2::object::id<Config>(arg0), 34);
        let v3 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::new();
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_admin_value(&v3, 0x2::object::id<Config>(arg0), 34, arg2);
    }

    public fun set_referral_enabled(arg0: &mut Config, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::AuthorityCap<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::PACKAGE, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::ADMIN>, arg2: bool) {
        assert_version(arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        let v0 = state_mut(arg0);
        v0.referral_enabled = arg2;
        let v1 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::new();
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_admin_action(&v1, 0x2::object::id<Config>(arg0), 35);
        let v2 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::new();
        let v3 = if (arg2) {
            1
        } else {
            0
        };
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_admin_value(&v2, 0x2::object::id<Config>(arg0), 35, v3);
    }

    public fun set_referral_fee_bps(arg0: &mut Config, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::AuthorityCap<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::PACKAGE, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::ADMIN>, arg2: u64) {
        assert_version(arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        let v0 = state(arg0);
        assert!(arg2 <= 5000, 13836185136305537033);
        assert!(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::safety::protocol_shares_fit(v0.max_builder_share_bps, v0.referee_discount_bps, arg2, v0.second_level_fee_bps), 13836185140600504329);
        let v1 = state_mut(arg0);
        v1.referral_fee_bps = arg2;
        let v2 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::new();
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_admin_action(&v2, 0x2::object::id<Config>(arg0), 32);
        let v3 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::new();
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_admin_value(&v3, 0x2::object::id<Config>(arg0), 32, arg2);
    }

    public fun set_retained_fee_curve(arg0: &mut Config, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::AuthorityCap<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::PACKAGE, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::ADMIN>, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        assert_version(arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        assert!(arg2 <= arg3 && arg3 <= 10000, 13837314038395043857);
        assert!(arg4 < arg5 && arg5 <= 30000, 13837314042690011153);
        let v0 = state_mut(arg0);
        let v1 = &mut v0.econ;
        v1.staker_share_min_bps = arg2;
        v1.staker_share_max_bps = arg3;
        v1.staker_cov_low_bps = arg4;
        v1.staker_cov_high_bps = arg5;
        let v2 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::new();
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_admin_action(&v2, 0x2::object::id<Config>(arg0), 83);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_retained_fee_curve_event(0x2::object::id<Config>(arg0), arg2, arg3, arg4, arg5);
    }

    public fun set_risk_globals(arg0: &mut Config, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::AuthorityCap<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::PACKAGE, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::ADMIN>, arg2: u64, arg3: u64, arg4: u64) {
        assert_version(arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        assert!(arg2 >= 1000 && arg2 <= 10000, 13837313922430926865);
        assert!(arg3 >= 1 && arg3 <= 8, 13837313931020861457);
        assert!(arg4 <= 50000000, 13837313935315828753);
        let v0 = state_mut(arg0);
        let v1 = &mut v0.econ;
        v1.min_payout_factor_bps = arg2;
        v1.sweep_max = arg3;
        v1.liq_bounty_cap = arg4;
        let v2 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::new();
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_admin_action(&v2, 0x2::object::id<Config>(arg0), 71);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_risk_globals_event(0x2::object::id<Config>(arg0), arg2, arg3, arg4);
    }

    public fun set_second_level_fee_bps(arg0: &mut Config, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::AuthorityCap<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::PACKAGE, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::ADMIN>, arg2: u64) {
        assert_version(arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        let v0 = state(arg0);
        assert!(arg2 <= 2500, 13836466680001855499);
        assert!(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::safety::protocol_shares_fit(v0.max_builder_share_bps, v0.referee_discount_bps, v0.referral_fee_bps, arg2), 13836466684296822795);
        let v1 = state_mut(arg0);
        v1.second_level_fee_bps = arg2;
        let v2 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::new();
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_admin_action(&v2, 0x2::object::id<Config>(arg0), 33);
        let v3 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::new();
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_admin_value(&v3, 0x2::object::id<Config>(arg0), 33, arg2);
    }

    public fun set_surplus_cap_bps(arg0: &mut Config, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::AuthorityCap<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::PACKAGE, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::ADMIN>, arg2: u64) {
        assert_version(arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        assert!(arg2 >= 1 && arg2 <= 1000, 13837313583128510481);
        let v0 = state_mut(arg0);
        let v1 = &mut v0.extra_fields;
        let v2 = SurplusCapKey{dummy_field: false};
        if (0x2::bag::contains<SurplusCapKey>(v1, v2)) {
            let v3 = SurplusCapKey{dummy_field: false};
            *0x2::bag::borrow_mut<SurplusCapKey, u64>(v1, v3) = arg2;
        } else {
            let v4 = SurplusCapKey{dummy_field: false};
            0x2::bag::add<SurplusCapKey, u64>(v1, v4, arg2);
        };
        let v5 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::new();
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_admin_action(&v5, 0x2::object::id<Config>(arg0), 85);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_surplus_cap_event(0x2::object::id<Config>(arg0), arg2);
    }

    public fun set_surplus_cash_floor(arg0: &mut Config, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::AuthorityCap<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::PACKAGE, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::ADMIN>, arg2: u64) {
        assert_version(arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        assert!(arg2 <= 100000000000000, 13837313703387594769);
        let v0 = state_mut(arg0);
        let v1 = &mut v0.extra_fields;
        let v2 = SurplusCashFloorKey{dummy_field: false};
        if (0x2::bag::contains<SurplusCashFloorKey>(v1, v2)) {
            let v3 = SurplusCashFloorKey{dummy_field: false};
            *0x2::bag::borrow_mut<SurplusCashFloorKey, u64>(v1, v3) = arg2;
        } else {
            let v4 = SurplusCashFloorKey{dummy_field: false};
            0x2::bag::add<SurplusCashFloorKey, u64>(v1, v4, arg2);
        };
        let v5 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::new();
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_admin_action(&v5, 0x2::object::id<Config>(arg0), 86);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_surplus_cash_floor_event(0x2::object::id<Config>(arg0), arg2);
    }

    public fun set_taker_fee(arg0: &mut Config, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::AuthorityCap<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::PACKAGE, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::ADMIN>, arg2: u64) {
        assert_version(arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        assert!(arg2 <= 2, 13835340638360567811);
        let v0 = state_mut(arg0);
        v0.taker_fee_bps = arg2;
        v0.taker_fee_set = true;
        let v1 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::new();
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_admin_action(&v1, 0x2::object::id<Config>(arg0), 1);
        let v2 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::new();
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_admin_value(&v2, 0x2::object::id<Config>(arg0), 1, arg2);
    }

    public fun set_trading_paused(arg0: &mut Config, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::AuthorityCap<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::PACKAGE, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::PAUSE_GUARDIAN>, arg2: bool) {
        assert_version(arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::assert_role<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::PAUSE_GUARDIAN>(&arg0.id, 0x2::object::id<Config>(arg0), arg1);
        assert!(arg2, 13863488711560527925);
        write_trading_paused(arg0, arg2);
    }

    public fun set_waterfall(arg0: &mut Config, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::AuthorityCap<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::PACKAGE, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::ADMIN>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        assert_version(arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        assert!(arg2 >= 15000 && arg2 <= 30000, 13837314171539030033);
        assert!(arg3 <= 2500, 13837314180128964625);
        assert!(arg4 >= 3600000 && arg4 <= 2592000000, 13837314197308833809);
        assert!(arg5 <= 7000, 13837314205898768401);
        assert!(arg7 <= 3000, 13837314210193735697);
        assert!(arg5 + arg6 + arg7 == 10000, 13837314214488702993);
        let v0 = state_mut(arg0);
        let v1 = &mut v0.econ;
        v1.surplus_floor_bps = arg2;
        v1.surplus_max_bps = arg3;
        v1.surplus_interval_ms = arg4;
        v1.surplus_staker_bps = arg5;
        v1.surplus_treasury_bps = arg6;
        v1.surplus_growth_bps = arg7;
        let v2 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::new();
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_admin_action(&v2, 0x2::object::id<Config>(arg0), 72);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_waterfall_params_event(0x2::object::id<Config>(arg0), v1.staker_fee_bps, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun set_win_fee(arg0: &mut Config, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::AuthorityCap<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::PACKAGE, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::ADMIN>, arg2: u64) {
        assert_version(arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        assert!(arg2 >= 1 && arg2 <= 500, 13835341106512003075);
        let v0 = state_mut(arg0);
        v0.win_fee_bps = arg2;
        let v1 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::new();
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_admin_action(&v1, 0x2::object::id<Config>(arg0), 2);
        let v2 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::new();
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_admin_value(&v2, 0x2::object::id<Config>(arg0), 2, arg2);
    }

    public(friend) fun share(arg0: Config) {
        0x2::transfer::share_object<Config>(arg0);
    }

    public fun staker_cov_high_bps(arg0: &Config) : u64 {
        state(arg0).econ.staker_cov_high_bps
    }

    public fun staker_cov_low_bps(arg0: &Config) : u64 {
        state(arg0).econ.staker_cov_low_bps
    }

    public fun staker_fee_bps(arg0: &Config) : u64 {
        state(arg0).econ.staker_fee_bps
    }

    public fun staker_share_max_bps(arg0: &Config) : u64 {
        state(arg0).econ.staker_share_max_bps
    }

    public fun staker_share_min_bps(arg0: &Config) : u64 {
        state(arg0).econ.staker_share_min_bps
    }

    fun state(arg0: &Config) : &ConfigStateV1 {
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::extended_field::borrow<ConfigStateV1>(&arg0.id, arg0.version)
    }

    fun state_mut(arg0: &mut Config) : &mut ConfigStateV1 {
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::extended_field::borrow_mut<ConfigStateV1>(&mut arg0.id, arg0.version)
    }

    public fun surplus_cap_bps(arg0: &Config) : u64 {
        let v0 = &state(arg0).extra_fields;
        let v1 = SurplusCapKey{dummy_field: false};
        if (0x2::bag::contains<SurplusCapKey>(v0, v1)) {
            let v3 = SurplusCapKey{dummy_field: false};
            *0x2::bag::borrow<SurplusCapKey, u64>(v0, v3)
        } else {
            100
        }
    }

    public fun surplus_cash_floor(arg0: &Config) : u64 {
        let v0 = &state(arg0).extra_fields;
        let v1 = SurplusCashFloorKey{dummy_field: false};
        if (0x2::bag::contains<SurplusCashFloorKey>(v0, v1)) {
            let v3 = SurplusCashFloorKey{dummy_field: false};
            *0x2::bag::borrow<SurplusCashFloorKey, u64>(v0, v3)
        } else {
            250000000000
        }
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
        assert!(v0.taker_fee_set, 13835622078977671173);
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

    public fun uid_mut(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::Auth, arg1: &mut Config) : &mut 0x2::object::UID {
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::assert_registered_on(arg0, &arg1.id);
        &mut arg1.id
    }

    public fun unregister_extension<T0: drop>(arg0: &mut Config, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::AuthorityCap<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::PACKAGE, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::ADMIN>) {
        assert_version(arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::unregister_uid<T0>(&mut arg0.id);
    }

    public fun win_fee_bps(arg0: &Config) : u64 {
        state(arg0).win_fee_bps
    }

    fun write_all(arg0: &mut Config, arg1: bool, arg2: bool) {
        write_trading_paused(arg0, arg1);
        write_closes_paused(arg0, arg1);
        let v0 = if (arg1) {
            pause_all_mask() & 32764
        } else {
            0
        };
        set_extended_mask(arg0, v0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_pause_all_event(0x2::object::id<Config>(arg0), arg1, pause_mask(arg0), arg2);
    }

    fun write_category(arg0: &mut Config, arg1: u8, arg2: bool, arg3: bool) {
        assert!(arg1 < 15, 13837875317606449173);
        if (arg1 == 0) {
            write_trading_paused(arg0, arg2);
        } else if (arg1 == 1) {
            write_closes_paused(arg0, arg2);
        } else {
            let v0 = if (arg2) {
                extended_mask(arg0) | 1 << arg1
            } else {
                extended_mask(arg0) & (32764 ^ 1 << arg1)
            };
            set_extended_mask(arg0, v0);
        };
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_pause_category_event(0x2::object::id<Config>(arg0), arg1, arg2, arg3);
    }

    fun write_closes_paused(arg0: &mut Config, arg1: bool) {
        let v0 = state_mut(arg0);
        v0.closes_paused = arg1;
        let v1 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::new();
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_admin_action(&v1, 0x2::object::id<Config>(arg0), 3);
        let v2 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::new();
        let v3 = if (arg1) {
            1
        } else {
            0
        };
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_admin_value(&v2, 0x2::object::id<Config>(arg0), 3, v3);
    }

    fun write_trading_paused(arg0: &mut Config, arg1: bool) {
        let v0 = state_mut(arg0);
        v0.paused = arg1;
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_pause_trading_event(0x2::object::id<Config>(arg0), arg1);
    }

    // decompiled from Move bytecode v7
}

