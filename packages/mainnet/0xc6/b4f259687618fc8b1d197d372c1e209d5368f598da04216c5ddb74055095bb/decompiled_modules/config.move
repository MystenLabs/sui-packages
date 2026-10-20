module 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config {
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
        pause_ratio_bps: u64,
        resume_ratio_bps: u64,
        surplus_floor_bps: u64,
        surplus_max_bps: u64,
        surplus_interval_ms: u64,
        surplus_staker_bps: u64,
        surplus_treasury_bps: u64,
        surplus_growth_bps: u64,
    }

    struct ForceCloseMinGapKey has copy, drop, store {
        dummy_field: bool,
    }

    public fun add_order_keeper(arg0: &mut Config, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>, arg2: address) {
        assert_version(arg0);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        let v0 = state_mut(arg0);
        let v1 = &mut v0.order_keepers;
        assert!(!0x2::vec_set::contains<address>(v1, &arg2) && 0x2::vec_set::length<address>(v1) < 8, 13863208546550284363);
        0x2::vec_set::insert<address>(v1, arg2);
        let v2 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::new();
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_action(&v2, 0x2::object::id<Config>(arg0), 77);
        let v3 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::new();
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_address(&v3, 0x2::object::id<Config>(arg0), 77, arg2);
    }

    public fun admin_pause_all(arg0: &mut Config, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>) {
        assert_version(arg0);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        write_all(arg0, true, true);
    }

    public fun admin_set_category_paused(arg0: &mut Config, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>, arg2: u8, arg3: bool) {
        assert_version(arg0);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        write_category(arg0, arg2, arg3, true);
    }

    public fun admin_set_closes_paused(arg0: &mut Config, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>, arg2: bool) {
        assert_version(arg0);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        write_category(arg0, 1, arg2, true);
    }

    public fun admin_set_trading_paused(arg0: &mut Config, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>, arg2: bool) {
        assert_version(arg0);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        write_category(arg0, 0, arg2, true);
    }

    public fun admin_unpause_all(arg0: &mut Config, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>) {
        assert_version(arg0);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        write_all(arg0, false, true);
    }

    fun assert_mask_unpaused(arg0: u64, arg1: u8) {
        if (!mask_paused(arg0, arg1)) {
            return
        } else {
            assert!(arg1 != 0, 13842096939747770417);
            assert!(arg1 != 1, 13842378419019579443);
            assert!(arg1 != 2, 13838156298662051863);
            assert!(arg1 != 3, 13838437777933860889);
            assert!(arg1 != 4, 13838719257205669915);
            assert!(arg1 != 5, 13839000736477478941);
            assert!(arg1 != 6, 13839282215749287967);
            assert!(arg1 != 7, 13839563695021096993);
            assert!(arg1 != 8, 13839845174292906019);
            assert!(arg1 != 9, 13840126653564715045);
            assert!(arg1 != 10, 13840408132836524071);
            assert!(arg1 != 11, 13840689612108333097);
            assert!(arg1 != 12, 13840971091380142123);
            assert!(arg1 != 13, 13841252570651951149);
            abort 13841534049923760175
        };
    }

    public fun assert_unpaused(arg0: &Config, arg1: u8) {
        assert_mask_unpaused(pause_mask(arg0), arg1);
    }

    public fun assert_version(arg0: &Config) {
        assert!(arg0.version == 1, 13835058995880001537);
    }

    public fun builders_enabled(arg0: &Config) : bool {
        state(arg0).builders_enabled
    }

    public fun cancel_extension_proposal<T0: drop>(arg0: &mut Config, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>) {
        assert_version(arg0);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::cancel_uid<T0>(&mut arg0.id);
    }

    public fun category_paused(arg0: &Config, arg1: u8) : bool {
        mask_paused(pause_mask(arg0), arg1)
    }

    public fun closes_paused(arg0: &Config) : bool {
        state(arg0).closes_paused
    }

    public(friend) fun create(arg0: &mut 0x2::tx_context::TxContext) : (Config, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>) {
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
            harvest_batch_cap     : 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::lp::max_entries(),
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
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::extended_field::add<ConfigStateV1>(&mut v1.id, v0, v3);
        assert!(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::safety::protocol_shares_fit(2000, 500, 1000, 250), 13836184861427630089);
        (v1, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::mint_admin(0x2::object::id<Config>(&v1), arg0))
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

    public fun grant_fee_recipient(arg0: &mut Config, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>, arg2: &mut 0x2::tx_context::TxContext) : 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::FEE_RECIPIENT> {
        assert_version(arg0);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        let v0 = 0x2::object::id<Config>(arg0);
        let v1 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::new();
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_action(&v1, v0, 23);
        let v2 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::mint_role<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::FEE_RECIPIENT>(&mut arg0.id, v0, arg2);
        let v3 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::new();
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_id(&v3, v0, 23, 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::FEE_RECIPIENT>>(&v2));
        v2
    }

    public fun grant_game_keeper(arg0: &mut Config, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>, arg2: &mut 0x2::tx_context::TxContext) : 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::GAME_KEEPER> {
        assert_version(arg0);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        let v0 = 0x2::object::id<Config>(arg0);
        let v1 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::mint_role<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::GAME_KEEPER>(&mut arg0.id, v0, arg2);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_game_keeper_granted_event(0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::GAME_KEEPER>>(&v1));
        let v2 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::new();
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_action(&v2, v0, 39);
        let v3 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::new();
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_id(&v3, v0, 39, 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::GAME_KEEPER>>(&v1));
        v1
    }

    public fun grant_market_keeper(arg0: &mut Config, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>, arg2: &mut 0x2::tx_context::TxContext) : 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::MARKET_KEEPER> {
        assert_version(arg0);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        let v0 = 0x2::object::id<Config>(arg0);
        let v1 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::new();
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_action(&v1, v0, 22);
        let v2 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::mint_role<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::MARKET_KEEPER>(&mut arg0.id, v0, arg2);
        let v3 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::new();
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_id(&v3, v0, 22, 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::MARKET_KEEPER>>(&v2));
        v2
    }

    public fun grant_pause_guardian(arg0: &mut Config, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>, arg2: &mut 0x2::tx_context::TxContext) : 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PAUSE_GUARDIAN> {
        assert_version(arg0);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        let v0 = 0x2::object::id<Config>(arg0);
        let v1 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::new();
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_action(&v1, v0, 21);
        let v2 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::mint_role<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PAUSE_GUARDIAN>(&mut arg0.id, v0, arg2);
        let v3 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::new();
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_id(&v3, v0, 21, 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PAUSE_GUARDIAN>>(&v2));
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

    public fun liquidations_paused(arg0: &Config) : bool {
        category_paused(arg0, 4)
    }

    public fun loss_fee_bps(arg0: &Config) : u64 {
        state(arg0).econ.loss_fee_bps
    }

    public fun mask_paused(arg0: u64, arg1: u8) : bool {
        assert!(arg1 < 15, 13837874720605995029);
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

    public fun pause_all(arg0: &mut Config, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PAUSE_GUARDIAN>) {
        assert_version(arg0);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::assert_role<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PAUSE_GUARDIAN>(&arg0.id, 0x2::object::id<Config>(arg0), arg1);
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

    public fun pause_ratio_bps(arg0: &Config) : u64 {
        state(arg0).econ.pause_ratio_bps
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
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::propose_uid<T0>(&mut arg0.id, arg1);
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

    public fun register_extension<T0: drop>(arg0: &mut Config, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>) {
        assert_version(arg0);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::register_uid<T0>(&mut arg0.id);
    }

    public fun register_proposed_extension<T0: drop>(arg0: &mut Config, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>, arg2: &0x2::clock::Clock) {
        assert_version(arg0);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::register_proposed_uid<T0>(&mut arg0.id, 0x2::clock::timestamp_ms(arg2));
    }

    fun remove_keeper_inner(arg0: &mut Config, arg1: address) {
        let v0 = state_mut(arg0);
        let v1 = &mut v0.order_keepers;
        assert!(0x2::vec_set::contains<address>(v1, &arg1), 13863208658219434059);
        0x2::vec_set::remove<address>(v1, &arg1);
        let v2 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::new();
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_action(&v2, 0x2::object::id<Config>(arg0), 78);
        let v3 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::new();
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_address(&v3, 0x2::object::id<Config>(arg0), 78, arg1);
    }

    public fun remove_order_keeper(arg0: &mut Config, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>, arg2: address) {
        assert_version(arg0);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        remove_keeper_inner(arg0, arg2);
    }

    public fun remove_order_keeper_guardian(arg0: &mut Config, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PAUSE_GUARDIAN>, arg2: address) {
        assert_version(arg0);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::assert_role<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PAUSE_GUARDIAN>(&arg0.id, 0x2::object::id<Config>(arg0), arg1);
        remove_keeper_inner(arg0, arg2);
    }

    public fun resume_ratio_bps(arg0: &Config) : u64 {
        state(arg0).econ.resume_ratio_bps
    }

    public fun revoke_cap(arg0: &mut Config, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>, arg2: 0x2::object::ID) {
        assert_version(arg0);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::revoke(&mut arg0.id, arg2);
        let v0 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::new();
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_action(&v0, 0x2::object::id<Config>(arg0), 24);
        let v1 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::new();
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_id(&v1, 0x2::object::id<Config>(arg0), 24, arg2);
    }

    public fun second_level_fee_bps(arg0: &Config) : u64 {
        state(arg0).second_level_fee_bps
    }

    public fun set_builders_enabled(arg0: &mut Config, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>, arg2: bool) {
        assert_version(arg0);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        let v0 = state(arg0).max_builder_share_bps;
        let v1 = state_mut(arg0);
        v1.builders_enabled = arg2;
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_builder_config_event(0x2::object::id<Config>(arg0), v0, arg2);
        let v2 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::new();
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_action(&v2, 0x2::object::id<Config>(arg0), 37);
        let v3 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::new();
        let v4 = if (arg2) {
            1
        } else {
            0
        };
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_value(&v3, 0x2::object::id<Config>(arg0), 37, v4);
    }

    public fun set_category_paused(arg0: &mut Config, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PAUSE_GUARDIAN>, arg2: u8, arg3: bool) {
        assert_version(arg0);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::assert_role<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PAUSE_GUARDIAN>(&arg0.id, 0x2::object::id<Config>(arg0), arg1);
        assert!(arg3, 13863489166827061301);
        write_category(arg0, arg2, arg3, false);
    }

    public fun set_closes_paused(arg0: &mut Config, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PAUSE_GUARDIAN>, arg2: bool) {
        assert_version(arg0);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::assert_role<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PAUSE_GUARDIAN>(&arg0.id, 0x2::object::id<Config>(arg0), arg1);
        assert!(arg2, 13863488634251116597);
        write_closes_paused(arg0, arg2);
    }

    public fun set_exec_fee_recipient(arg0: &mut Config, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>, arg2: address) {
        assert_version(arg0);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        assert!(arg2 != @0x0, 13837594521234440211);
        let v0 = state_mut(arg0);
        v0.exec_fee_recipient = arg2;
        let v1 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::new();
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_action(&v1, 0x2::object::id<Config>(arg0), 80);
        let v2 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::new();
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_address(&v2, 0x2::object::id<Config>(arg0), 80, arg2);
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

    public fun set_fee_params(arg0: &mut Config, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>, arg2: u64, arg3: u64, arg4: u64) {
        assert_version(arg0);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        assert!(arg2 >= 8000 && arg2 <= 9000, 13837313381265047569);
        assert!(arg3 >= 1 && arg3 <= 500, 13837313389854982161);
        assert!(arg4 <= 500, 13837313394149949457);
        let v0 = state_mut(arg0);
        let v1 = &mut v0.econ;
        v1.trim_max_share_bps = arg2;
        v1.trim_c_ppm = arg3;
        v1.loss_fee_bps = arg4;
        let v2 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::new();
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_action(&v2, 0x2::object::id<Config>(arg0), 70);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_fee_params_event(0x2::object::id<Config>(arg0), arg2, arg3, arg4);
    }

    public fun set_force_close_min_gap_ms(arg0: &mut Config, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>, arg2: u64) {
        assert_version(arg0);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        assert!(arg2 >= 10000 && arg2 <= 900000, 13837313273890865169);
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
        let v5 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::new();
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_action(&v5, 0x2::object::id<Config>(arg0), 82);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_force_close_min_gap_event(0x2::object::id<Config>(arg0), arg2);
    }

    public fun set_harvest_batch_cap(arg0: &mut Config, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>, arg2: u64) {
        assert_version(arg0);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        assert!(arg2 >= 1 && arg2 <= 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::lp::max_entries(), 13835903992041177095);
        let v0 = state_mut(arg0);
        v0.harvest_batch_cap = arg2;
        let v1 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::new();
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_action(&v1, 0x2::object::id<Config>(arg0), 31);
        let v2 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::new();
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_value(&v2, 0x2::object::id<Config>(arg0), 31, arg2);
    }

    public fun set_max_builder_share_bps(arg0: &mut Config, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>, arg2: u64) {
        assert_version(arg0);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        let v0 = state(arg0);
        let v1 = v0.builders_enabled;
        assert!(arg2 <= 5000, 13837029741624688655);
        assert!(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::safety::protocol_shares_fit(arg2, v0.referee_discount_bps, v0.referral_fee_bps, v0.second_level_fee_bps), 13837029745919655951);
        let v2 = state_mut(arg0);
        v2.max_builder_share_bps = arg2;
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_builder_config_event(0x2::object::id<Config>(arg0), arg2, v1);
        let v3 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::new();
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_action(&v3, 0x2::object::id<Config>(arg0), 36);
        let v4 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::new();
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_value(&v4, 0x2::object::id<Config>(arg0), 36, arg2);
    }

    public fun set_max_pending_orders(arg0: &mut Config, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>, arg2: u64) {
        assert_version(arg0);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        assert!(arg2 >= 1 && arg2 <= 32, 13863208701169107019);
        let v0 = state_mut(arg0);
        v0.max_pending_orders = arg2;
        let v1 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::new();
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_action(&v1, 0x2::object::id<Config>(arg0), 79);
        let v2 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::new();
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_value(&v2, 0x2::object::id<Config>(arg0), 79, arg2);
    }

    public fun set_referee_discount_bps(arg0: &mut Config, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>, arg2: u64) {
        assert_version(arg0);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        let v0 = state(arg0);
        assert!(arg2 <= 5000, 13836748197928370189);
        assert!(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::safety::protocol_shares_fit(v0.max_builder_share_bps, arg2, v0.referral_fee_bps, v0.second_level_fee_bps), 13836748202223337485);
        let v1 = state_mut(arg0);
        v1.referee_discount_bps = arg2;
        let v2 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::new();
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_action(&v2, 0x2::object::id<Config>(arg0), 34);
        let v3 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::new();
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_value(&v3, 0x2::object::id<Config>(arg0), 34, arg2);
    }

    public fun set_referral_enabled(arg0: &mut Config, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>, arg2: bool) {
        assert_version(arg0);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        let v0 = state_mut(arg0);
        v0.referral_enabled = arg2;
        let v1 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::new();
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_action(&v1, 0x2::object::id<Config>(arg0), 35);
        let v2 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::new();
        let v3 = if (arg2) {
            1
        } else {
            0
        };
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_value(&v2, 0x2::object::id<Config>(arg0), 35, v3);
    }

    public fun set_referral_fee_bps(arg0: &mut Config, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>, arg2: u64) {
        assert_version(arg0);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        let v0 = state(arg0);
        assert!(arg2 <= 5000, 13836185110535733257);
        assert!(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::safety::protocol_shares_fit(v0.max_builder_share_bps, v0.referee_discount_bps, arg2, v0.second_level_fee_bps), 13836185114830700553);
        let v1 = state_mut(arg0);
        v1.referral_fee_bps = arg2;
        let v2 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::new();
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_action(&v2, 0x2::object::id<Config>(arg0), 32);
        let v3 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::new();
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_value(&v3, 0x2::object::id<Config>(arg0), 32, arg2);
    }

    public fun set_risk_globals(arg0: &mut Config, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>, arg2: u64, arg3: u64, arg4: u64) {
        assert_version(arg0);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        assert!(arg2 >= 1000 && arg2 <= 10000, 13837313488639229969);
        assert!(arg3 >= 1 && arg3 <= 8, 13837313497229164561);
        assert!(arg4 <= 50000000, 13837313501524131857);
        let v0 = state_mut(arg0);
        let v1 = &mut v0.econ;
        v1.min_payout_factor_bps = arg2;
        v1.sweep_max = arg3;
        v1.liq_bounty_cap = arg4;
        let v2 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::new();
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_action(&v2, 0x2::object::id<Config>(arg0), 71);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_risk_globals_event(0x2::object::id<Config>(arg0), arg2, arg3, arg4);
    }

    public fun set_second_level_fee_bps(arg0: &mut Config, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>, arg2: u64) {
        assert_version(arg0);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        let v0 = state(arg0);
        assert!(arg2 <= 2500, 13836466654232051723);
        assert!(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::safety::protocol_shares_fit(v0.max_builder_share_bps, v0.referee_discount_bps, v0.referral_fee_bps, arg2), 13836466658527019019);
        let v1 = state_mut(arg0);
        v1.second_level_fee_bps = arg2;
        let v2 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::new();
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_action(&v2, 0x2::object::id<Config>(arg0), 33);
        let v3 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::new();
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_value(&v3, 0x2::object::id<Config>(arg0), 33, arg2);
    }

    public fun set_taker_fee(arg0: &mut Config, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>, arg2: u64) {
        assert_version(arg0);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        assert!(arg2 <= 2, 13835340612590764035);
        let v0 = state_mut(arg0);
        v0.taker_fee_bps = arg2;
        v0.taker_fee_set = true;
        let v1 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::new();
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_action(&v1, 0x2::object::id<Config>(arg0), 1);
        let v2 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::new();
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_value(&v2, 0x2::object::id<Config>(arg0), 1, arg2);
    }

    public fun set_trading_paused(arg0: &mut Config, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PAUSE_GUARDIAN>, arg2: bool) {
        assert_version(arg0);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::assert_role<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PAUSE_GUARDIAN>(&arg0.id, 0x2::object::id<Config>(arg0), arg1);
        assert!(arg2, 13863488685790724149);
        write_trading_paused(arg0, arg2);
    }

    public fun set_waterfall(arg0: &mut Config, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64) {
        assert_version(arg0);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        assert!(arg2 >= 3000 && arg2 <= 7000, 13837313630373150737);
        assert!(arg3 >= 11000, 13837313638963085329);
        assert!(arg4 >= arg3 + 1000 && arg4 <= 30000, 13837313656142954513);
        assert!(arg5 >= arg4 && arg5 <= 30000, 13837313673322823697);
        assert!(arg6 <= 2500, 13837313681912758289);
        assert!(arg7 >= 86400000 && arg7 <= 2592000000, 13837313699092627473);
        assert!(arg8 <= 7000, 13837313707682562065);
        assert!(arg10 <= 3000, 13837313711977529361);
        assert!(arg8 + arg9 + arg10 == 10000, 13837313716272496657);
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
        let v2 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::new();
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_action(&v2, 0x2::object::id<Config>(arg0), 72);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_waterfall_params_event(0x2::object::id<Config>(arg0), arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    public fun set_win_fee(arg0: &mut Config, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>, arg2: u64) {
        assert_version(arg0);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        assert!(arg2 >= 1 && arg2 <= 500, 13835341080742199299);
        let v0 = state_mut(arg0);
        v0.win_fee_bps = arg2;
        let v1 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::new();
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_action(&v1, 0x2::object::id<Config>(arg0), 2);
        let v2 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::new();
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_value(&v2, 0x2::object::id<Config>(arg0), 2, arg2);
    }

    public(friend) fun share(arg0: Config) {
        0x2::transfer::share_object<Config>(arg0);
    }

    public fun staker_fee_bps(arg0: &Config) : u64 {
        state(arg0).econ.staker_fee_bps
    }

    fun state(arg0: &Config) : &ConfigStateV1 {
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::extended_field::borrow<ConfigStateV1>(&arg0.id, arg0.version)
    }

    fun state_mut(arg0: &mut Config) : &mut ConfigStateV1 {
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::extended_field::borrow_mut<ConfigStateV1>(&mut arg0.id, arg0.version)
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
        assert!(v0.taker_fee_set, 13835622053207867397);
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

    public fun uid_mut(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::Auth, arg1: &mut Config) : &mut 0x2::object::UID {
        &mut arg1.id
    }

    public fun unregister_extension<T0: drop>(arg0: &mut Config, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>) {
        assert_version(arg0);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::assert_admin(0x2::object::id<Config>(arg0), arg1);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::unregister_uid<T0>(&mut arg0.id);
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
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_pause_all_event(0x2::object::id<Config>(arg0), arg1, pause_mask(arg0), arg2);
    }

    fun write_category(arg0: &mut Config, arg1: u8, arg2: bool, arg3: bool) {
        assert!(arg1 < 15, 13837875274656776213);
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
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_pause_category_event(0x2::object::id<Config>(arg0), arg1, arg2, arg3);
    }

    fun write_closes_paused(arg0: &mut Config, arg1: bool) {
        let v0 = state_mut(arg0);
        v0.closes_paused = arg1;
        let v1 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::new();
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_action(&v1, 0x2::object::id<Config>(arg0), 3);
        let v2 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::new();
        let v3 = if (arg1) {
            1
        } else {
            0
        };
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_value(&v2, 0x2::object::id<Config>(arg0), 3, v3);
    }

    fun write_trading_paused(arg0: &mut Config, arg1: bool) {
        let v0 = state_mut(arg0);
        v0.paused = arg1;
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_pause_trading_event(0x2::object::id<Config>(arg0), arg1);
    }

    // decompiled from Move bytecode v7
}

