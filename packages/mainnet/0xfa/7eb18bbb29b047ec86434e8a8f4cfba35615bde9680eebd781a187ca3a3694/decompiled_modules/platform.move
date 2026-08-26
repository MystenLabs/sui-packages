module 0xc5c833991ed1123d70b1001c0bcdb01ec5728b09f25dfc42a0edaf16005d404d::platform {
    struct PLATFORM has drop {
        dummy_field: bool,
    }

    struct PlatformCap has store, key {
        id: 0x2::object::UID,
        platform: 0x2::object::ID,
    }

    struct Platform has key {
        id: 0x2::object::UID,
        version: u64,
        fee_bps: u64,
        referral_share_bps: u64,
        creation_fee_mist: u64,
        creation_paused: bool,
        payments_paused: bool,
        treasury: 0x2::balance::Balance<0x2::sui::SUI>,
        accounts_created: u64,
        vaults_created: u64,
    }

    struct PlatformCreated has copy, drop {
        platform: 0x2::object::ID,
        publisher: address,
    }

    struct FeesUpdated has copy, drop {
        platform: 0x2::object::ID,
        fee_bps: u64,
        referral_share_bps: u64,
        creation_fee_mist: u64,
    }

    struct CreationPauseSet has copy, drop {
        platform: 0x2::object::ID,
        paused: bool,
    }

    struct PaymentsPauseSet has copy, drop {
        platform: 0x2::object::ID,
        paused: bool,
    }

    struct TreasurySwept has copy, drop {
        platform: 0x2::object::ID,
        amount_mist: u64,
        recipient: address,
    }

    public fun accounts_created(arg0: &Platform) : u64 {
        arg0.accounts_created
    }

    public(friend) fun assert_can_create(arg0: &Platform) {
        assert_version(arg0);
        assert!(!arg0.creation_paused, 4);
    }

    public(friend) fun assert_can_pay(arg0: &Platform) {
        assert_version(arg0);
        assert!(!arg0.payments_paused, 5);
    }

    fun assert_cap(arg0: &Platform, arg1: &PlatformCap) {
        assert!(arg1.platform == 0x2::object::id<Platform>(arg0), 2);
    }

    fun assert_version(arg0: &Platform) {
        assert!(arg0.version == 1, 1);
    }

    public fun bps_denominator() : u64 {
        10000
    }

    public fun cap_platform_id(arg0: &PlatformCap) : 0x2::object::ID {
        arg0.platform
    }

    public(friend) fun collect_creation_fee(arg0: &mut Platform, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = arg0.creation_fee_mist;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= v0, 6);
        if (v0 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.treasury, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v0, arg2)));
        };
        arg1
    }

    public fun creation_fee_mist(arg0: &Platform) : u64 {
        arg0.creation_fee_mist
    }

    public fun creation_paused(arg0: &Platform) : bool {
        arg0.creation_paused
    }

    public fun fee_bps(arg0: &Platform) : u64 {
        arg0.fee_bps
    }

    fun init(arg0: PLATFORM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<PLATFORM>(arg0, arg1);
        let v1 = 0x2::display::new<Platform>(&v0, arg1);
        0x2::display::add<Platform>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"ProjectX Social"));
        0x2::display::add<Platform>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"The economic backbone of the ProjectX social platform on Sui."));
        0x2::display::add<Platform>(&mut v1, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"ProjectX Protocol"));
        0x2::display::update_version<Platform>(&mut v1);
        let v2 = Platform{
            id                 : 0x2::object::new(arg1),
            version            : 1,
            fee_bps            : 0,
            referral_share_bps : 0,
            creation_fee_mist  : 0,
            creation_paused    : true,
            payments_paused    : false,
            treasury           : 0x2::balance::zero<0x2::sui::SUI>(),
            accounts_created   : 0,
            vaults_created     : 0,
        };
        let v3 = 0x2::object::id<Platform>(&v2);
        let v4 = PlatformCap{
            id       : 0x2::object::new(arg1),
            platform : v3,
        };
        let v5 = PlatformCreated{
            platform  : v3,
            publisher : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<PlatformCreated>(v5);
        0x2::transfer::public_transfer<0x2::display::Display<Platform>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<PlatformCap>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<Platform>(v2);
    }

    public fun max_platform_fee_bps() : u64 {
        3000
    }

    public fun max_referral_share_bps() : u64 {
        5000
    }

    public fun migrate(arg0: &mut Platform, arg1: &PlatformCap) {
        assert_cap(arg0, arg1);
        assert!(arg0.version < 1, 8);
        arg0.version = 1;
    }

    public fun payments_paused(arg0: &Platform) : bool {
        arg0.payments_paused
    }

    public(friend) fun record_account_created(arg0: &mut Platform) {
        arg0.accounts_created = arg0.accounts_created + 1;
    }

    public(friend) fun record_vault_created(arg0: &mut Platform) {
        arg0.vaults_created = arg0.vaults_created + 1;
    }

    public fun referral_share_bps(arg0: &Platform) : u64 {
        arg0.referral_share_bps
    }

    public fun set_creation_paused(arg0: &mut Platform, arg1: &PlatformCap, arg2: bool) {
        assert_version(arg0);
        assert_cap(arg0, arg1);
        arg0.creation_paused = arg2;
        let v0 = CreationPauseSet{
            platform : 0x2::object::id<Platform>(arg0),
            paused   : arg2,
        };
        0x2::event::emit<CreationPauseSet>(v0);
    }

    public fun set_fees(arg0: &mut Platform, arg1: &PlatformCap, arg2: u64, arg3: u64, arg4: u64) {
        assert_version(arg0);
        assert_cap(arg0, arg1);
        assert!(arg2 <= 3000, 3);
        assert!(arg3 <= 5000, 3);
        arg0.fee_bps = arg2;
        arg0.referral_share_bps = arg3;
        arg0.creation_fee_mist = arg4;
        let v0 = FeesUpdated{
            platform           : 0x2::object::id<Platform>(arg0),
            fee_bps            : arg2,
            referral_share_bps : arg3,
            creation_fee_mist  : arg4,
        };
        0x2::event::emit<FeesUpdated>(v0);
    }

    public fun set_payments_paused(arg0: &mut Platform, arg1: &PlatformCap, arg2: bool) {
        assert_version(arg0);
        assert_cap(arg0, arg1);
        arg0.payments_paused = arg2;
        let v0 = PaymentsPauseSet{
            platform : 0x2::object::id<Platform>(arg0),
            paused   : arg2,
        };
        0x2::event::emit<PaymentsPauseSet>(v0);
    }

    public fun sweep_treasury(arg0: &mut Platform, arg1: &PlatformCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert_version(arg0);
        assert_cap(arg0, arg1);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.treasury) >= arg2, 7);
        let v0 = TreasurySwept{
            platform    : 0x2::object::id<Platform>(arg0),
            amount_mist : arg2,
            recipient   : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<TreasurySwept>(v0);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.treasury, arg2), arg3)
    }

    public fun treasury_value(arg0: &Platform) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.treasury)
    }

    public fun vaults_created(arg0: &Platform) : u64 {
        arg0.vaults_created
    }

    public fun version(arg0: &Platform) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

