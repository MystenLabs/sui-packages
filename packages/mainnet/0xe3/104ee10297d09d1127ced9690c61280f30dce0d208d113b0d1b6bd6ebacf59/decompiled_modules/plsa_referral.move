module 0x5b1bde6bfef532d5753cfeabfe71d409aea33701c3ab6408373d7c6803248922::plsa_referral {
    struct ReferralConfig has key {
        id: 0x2::object::UID,
        enabled: bool,
        bonus_ratio_bps: u64,
        cap_multiplier: u64,
    }

    struct ReferralRegistry has key {
        id: 0x2::object::UID,
        referrals: 0x2::table::Table<address, ReferralRecord>,
        referees_of: 0x2::table::Table<address, vector<address>>,
        total_registrations: u64,
    }

    struct ReferralRecord has copy, drop, store {
        referrer: address,
        referee: address,
        registered_at: u64,
        referral_number: u64,
    }

    struct ReferralRegistered has copy, drop {
        referrer: address,
        referee: address,
        timestamp: u64,
        referral_number: u64,
    }

    struct ReferralConfigUpdated has copy, drop {
        enabled: bool,
        bonus_ratio_bps: u64,
        cap_multiplier: u64,
    }

    public fun calculate_referral_bonus(arg0: address, arg1: &ReferralConfig, arg2: &ReferralRegistry, arg3: &0x5b1bde6bfef532d5753cfeabfe71d409aea33701c3ab6408373d7c6803248922::plsa_vault::UserDeposits, arg4: &0x2::clock::Clock) : u64 {
        if (!arg1.enabled) {
            return 0
        };
        if (arg1.bonus_ratio_bps == 0) {
            return 0
        };
        if (!0x2::table::contains<address, vector<address>>(&arg2.referees_of, arg0)) {
            return 0
        };
        let v0 = 0x2::table::borrow<address, vector<address>>(&arg2.referees_of, arg0);
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(v0)) {
            v1 = v1 + (0x5b1bde6bfef532d5753cfeabfe71d409aea33701c3ab6408373d7c6803248922::plsa_vault::calculate_user_entries(arg3, *0x1::vector::borrow<address>(v0, v2), arg4) as u128);
            v2 = v2 + 1;
        };
        let v3 = v1 * (arg1.bonus_ratio_bps as u128) / 10000;
        let v4 = (0x5b1bde6bfef532d5753cfeabfe71d409aea33701c3ab6408373d7c6803248922::plsa_vault::calculate_user_entries(arg3, arg0, arg4) as u128) * (arg1.cap_multiplier as u128);
        let v5 = if (v3 < v4) {
            v3
        } else {
            v4
        };
        if (v5 > 18446744073709551615) {
            18446744073709551615
        } else {
            (v5 as u64)
        }
    }

    public fun get_bonus_ratio_bps(arg0: &ReferralConfig) : u64 {
        arg0.bonus_ratio_bps
    }

    public fun get_cap_multiplier(arg0: &ReferralConfig) : u64 {
        arg0.cap_multiplier
    }

    public fun get_referees_of(arg0: &ReferralRegistry, arg1: address) : vector<address> {
        if (!0x2::table::contains<address, vector<address>>(&arg0.referees_of, arg1)) {
            return 0x1::vector::empty<address>()
        };
        *0x2::table::borrow<address, vector<address>>(&arg0.referees_of, arg1)
    }

    public fun get_referral_count(arg0: &ReferralRegistry, arg1: address) : u64 {
        if (!0x2::table::contains<address, vector<address>>(&arg0.referees_of, arg1)) {
            return 0
        };
        0x1::vector::length<address>(0x2::table::borrow<address, vector<address>>(&arg0.referees_of, arg1))
    }

    public fun get_referrer(arg0: &ReferralRegistry, arg1: address) : address {
        0x2::table::borrow<address, ReferralRecord>(&arg0.referrals, arg1).referrer
    }

    public fun get_total_registrations(arg0: &ReferralRegistry) : u64 {
        arg0.total_registrations
    }

    public fun has_referrer(arg0: &ReferralRegistry, arg1: address) : bool {
        0x2::table::contains<address, ReferralRecord>(&arg0.referrals, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ReferralConfig{
            id              : 0x2::object::new(arg0),
            enabled         : true,
            bonus_ratio_bps : 1000,
            cap_multiplier  : 5,
        };
        0x2::transfer::share_object<ReferralConfig>(v0);
        let v1 = ReferralRegistry{
            id                  : 0x2::object::new(arg0),
            referrals           : 0x2::table::new<address, ReferralRecord>(arg0),
            referees_of         : 0x2::table::new<address, vector<address>>(arg0),
            total_registrations : 0,
        };
        0x2::transfer::share_object<ReferralRegistry>(v1);
    }

    public fun is_enabled(arg0: &ReferralConfig) : bool {
        arg0.enabled
    }

    public entry fun register(arg0: &ReferralConfig, arg1: &mut ReferralRegistry, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.enabled, 202);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::clock::timestamp_ms(arg3) / 1000;
        assert!(v0 != arg2, 201);
        assert!(!0x2::table::contains<address, ReferralRecord>(&arg1.referrals, v0), 200);
        arg1.total_registrations = arg1.total_registrations + 1;
        let v2 = arg1.total_registrations;
        let v3 = ReferralRecord{
            referrer        : arg2,
            referee         : v0,
            registered_at   : v1,
            referral_number : v2,
        };
        0x2::table::add<address, ReferralRecord>(&mut arg1.referrals, v0, v3);
        if (!0x2::table::contains<address, vector<address>>(&arg1.referees_of, arg2)) {
            0x2::table::add<address, vector<address>>(&mut arg1.referees_of, arg2, 0x1::vector::empty<address>());
        };
        0x1::vector::push_back<address>(0x2::table::borrow_mut<address, vector<address>>(&mut arg1.referees_of, arg2), v0);
        let v4 = ReferralRegistered{
            referrer        : arg2,
            referee         : v0,
            timestamp       : v1,
            referral_number : v2,
        };
        0x2::event::emit<ReferralRegistered>(v4);
    }

    public entry fun update_config(arg0: &0x5b1bde6bfef532d5753cfeabfe71d409aea33701c3ab6408373d7c6803248922::plsa_vault::AdminCap, arg1: &mut ReferralConfig, arg2: bool, arg3: u64, arg4: u64) {
        assert!(arg3 <= 2000, 204);
        assert!(arg4 >= 1 && arg4 <= 100, 204);
        arg1.enabled = arg2;
        arg1.bonus_ratio_bps = arg3;
        arg1.cap_multiplier = arg4;
        let v0 = ReferralConfigUpdated{
            enabled         : arg2,
            bonus_ratio_bps : arg3,
            cap_multiplier  : arg4,
        };
        0x2::event::emit<ReferralConfigUpdated>(v0);
    }

    // decompiled from Move bytecode v7
}

