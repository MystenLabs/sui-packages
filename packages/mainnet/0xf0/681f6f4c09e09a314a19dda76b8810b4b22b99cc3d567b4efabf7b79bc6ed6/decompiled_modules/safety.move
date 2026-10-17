module 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety {
    struct LimitsSetV1 has copy, drop {
        job_cap: u64,
        deposit_minimum: u64,
        payout_limit_24h: u64,
    }

    struct PausedV1 has copy, drop {
        until_ms: u64,
    }

    struct StorageOutageDeclaredV1 has copy, drop {
        since_ms: u64,
        until_ms: u64,
    }

    struct MigratedV1 has copy, drop {
        from: u64,
        to: u64,
    }

    struct RegistrationOpenedV1 has copy, drop {
        dummy_field: bool,
    }

    struct TreasurySetV1 has copy, drop {
        treasury: address,
    }

    struct TermsVersionSetV1 has copy, drop {
        terms_version: u16,
    }

    struct Guard has key {
        id: 0x2::object::UID,
        version: u64,
        paused_until_ms: u64,
        registration_open: bool,
        payout_limit_24h: u64,
        job_cap: u64,
        deposit_minimum: u64,
        storage_outage_until_ms: u64,
        storage_outage_since_ms: u64,
        treasury: address,
        admin: 0x2::object::ID,
        terms_version: u16,
    }

    public fun admin(arg0: &Guard) : 0x2::object::ID {
        arg0.admin
    }

    public fun assert_admin(arg0: &Guard, arg1: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::admin::AdminCap) {
        assert!(0x2::object::id<0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::admin::AdminCap>(arg1) == arg0.admin, 9);
    }

    public fun assert_current_version(arg0: &Guard) {
        assert!(arg0.version == 2, 1);
    }

    public fun assert_open_for_new_work(arg0: &Guard, arg1: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.paused_until_ms, 7);
    }

    entry fun declare_storage_outage(arg0: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::admin::AdminCap, arg1: &mut Guard, arg2: &0x2::clock::Clock) {
        assert_current_version(arg1);
        assert_admin(arg1, arg0);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        if (v0 >= arg1.storage_outage_until_ms) {
            arg1.storage_outage_since_ms = v0;
        };
        arg1.storage_outage_until_ms = v0 + 259200000;
        let v1 = StorageOutageDeclaredV1{
            since_ms : arg1.storage_outage_since_ms,
            until_ms : arg1.storage_outage_until_ms,
        };
        0x2::event::emit<StorageOutageDeclaredV1>(v1);
    }

    public fun deposit_minimum(arg0: &Guard) : u64 {
        arg0.deposit_minimum
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Guard{
            id                      : 0x2::object::new(arg0),
            version                 : 2,
            paused_until_ms         : 0,
            registration_open       : false,
            payout_limit_24h        : 0,
            job_cap                 : 100000000,
            deposit_minimum         : 1000000,
            storage_outage_until_ms : 0,
            storage_outage_since_ms : 0,
            treasury                : @0x0,
            admin                   : 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::admin::mint_to(0x2::tx_context::sender(arg0), arg0),
            terms_version           : 0,
        };
        0x2::transfer::share_object<Guard>(v0);
    }

    public fun job_cap(arg0: &Guard) : u64 {
        arg0.job_cap
    }

    entry fun migrate(arg0: &mut Guard) {
        migrate_to(arg0, 2);
    }

    fun migrate_to(arg0: &mut Guard, arg1: u64) {
        assert!(arg0.version < arg1, 2);
        arg0.version = arg1;
        let v0 = MigratedV1{
            from : arg0.version,
            to   : arg1,
        };
        0x2::event::emit<MigratedV1>(v0);
    }

    public(friend) fun min_budget() : u64 {
        1000000
    }

    entry fun open_registration(arg0: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::admin::AdminCap, arg1: &mut Guard) {
        assert_current_version(arg1);
        assert_admin(arg1, arg0);
        if (arg1.registration_open) {
            return
        };
        arg1.registration_open = true;
        let v0 = RegistrationOpenedV1{dummy_field: false};
        0x2::event::emit<RegistrationOpenedV1>(v0);
    }

    entry fun pause(arg0: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::admin::AdminCap, arg1: &mut Guard, arg2: &0x2::clock::Clock) {
        assert_current_version(arg1);
        assert_admin(arg1, arg0);
        arg1.paused_until_ms = 0x2::clock::timestamp_ms(arg2) + 259200000;
        let v0 = PausedV1{until_ms: arg1.paused_until_ms};
        0x2::event::emit<PausedV1>(v0);
    }

    public fun payout_limit_24h(arg0: &Guard) : u64 {
        arg0.payout_limit_24h
    }

    public fun registration_open(arg0: &Guard) : bool {
        arg0.registration_open
    }

    entry fun set_limits(arg0: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::admin::AdminCap, arg1: &mut Guard, arg2: u64, arg3: u64, arg4: u64) {
        assert_current_version(arg1);
        assert_admin(arg1, arg0);
        assert!(arg2 > 0 && arg2 <= 2000000000, 6);
        assert!(arg2 <= 2 * arg1.job_cap, 3);
        assert!(arg4 > 0 && arg4 <= 10 * arg2, 4);
        assert!(arg3 >= 1000000, 5);
        assert!(arg3 <= 500000000, 10);
        assert!(arg3 <= 2 * arg1.deposit_minimum, 11);
        arg1.job_cap = arg2;
        arg1.deposit_minimum = arg3;
        arg1.payout_limit_24h = arg4;
        let v0 = LimitsSetV1{
            job_cap          : arg2,
            deposit_minimum  : arg3,
            payout_limit_24h : arg4,
        };
        0x2::event::emit<LimitsSetV1>(v0);
    }

    entry fun set_terms_version(arg0: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::admin::AdminCap, arg1: &mut Guard, arg2: u16) {
        assert_current_version(arg1);
        assert_admin(arg1, arg0);
        arg1.terms_version = arg2;
        let v0 = TermsVersionSetV1{terms_version: arg2};
        0x2::event::emit<TermsVersionSetV1>(v0);
    }

    entry fun set_treasury(arg0: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::admin::AdminCap, arg1: &mut Guard, arg2: address) {
        assert_current_version(arg1);
        assert_admin(arg1, arg0);
        assert!(arg2 != @0x0, 8);
        arg1.treasury = arg2;
        let v0 = TreasurySetV1{treasury: arg2};
        0x2::event::emit<TreasurySetV1>(v0);
    }

    public fun storage_outage(arg0: &Guard, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) < arg0.storage_outage_until_ms
    }

    public fun storage_outage_since_ms(arg0: &Guard) : u64 {
        arg0.storage_outage_since_ms
    }

    public fun storage_outage_until_ms(arg0: &Guard) : u64 {
        arg0.storage_outage_until_ms
    }

    public fun terms_version(arg0: &Guard) : u16 {
        arg0.terms_version
    }

    public fun treasury(arg0: &Guard) : address {
        arg0.treasury
    }

    // decompiled from Move bytecode v7
}

