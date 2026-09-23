module 0xf7805603f871976fe85dd3ce5c9c60f7853805ed97f7813c32ea35b398134bf1::config {
    struct Config has key {
        id: 0x2::object::UID,
        version: u64,
        fee_bps: u64,
        fee_recipient: address,
        min_vesting_ms: u64,
        max_vesting_ms: u64,
        max_listing_ms: u64,
        paused: bool,
        allowed_pay: vector<0x1::string::String>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Migrated has copy, drop {
        from: u64,
        to: u64,
    }

    struct ParamsChanged has copy, drop {
        fee_bps: u64,
        fee_recipient: address,
        min_vesting_ms: u64,
        max_vesting_ms: u64,
        max_listing_ms: u64,
    }

    struct PauseChanged has copy, drop {
        paused: bool,
    }

    struct PayCoinsChanged has copy, drop {
        allowed_pay: vector<0x1::string::String>,
    }

    public fun allowed_pay(arg0: &Config) : vector<0x1::string::String> {
        arg0.allowed_pay
    }

    public fun assert_open(arg0: &Config) {
        assert_version(arg0);
        assert!(!arg0.paused, 103);
    }

    public fun assert_pay_allowed<T0>(arg0: &Config) {
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>()));
        assert!(0x1::vector::contains<0x1::string::String>(&arg0.allowed_pay, &v0), 104);
    }

    public fun assert_version(arg0: &Config) {
        assert!(arg0.version == 1, 100);
    }

    public fun fee_bps(arg0: &Config) : u64 {
        arg0.fee_bps
    }

    public fun fee_recipient(arg0: &Config) : address {
        arg0.fee_recipient
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"0000000000000000000000000000000000000000000000000000000000000002::sui::SUI"));
        let v1 = Config{
            id             : 0x2::object::new(arg0),
            version        : 1,
            fee_bps        : 100,
            fee_recipient  : 0x2::tx_context::sender(arg0),
            min_vesting_ms : 86400000,
            max_vesting_ms : 63072000000,
            max_listing_ms : 7776000000,
            paused         : false,
            allowed_pay    : v0,
        };
        0x2::transfer::share_object<Config>(v1);
        let v2 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v2, 0x2::tx_context::sender(arg0));
    }

    public fun is_pay_allowed<T0>(arg0: &Config) : bool {
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>()));
        0x1::vector::contains<0x1::string::String>(&arg0.allowed_pay, &v0)
    }

    public fun max_fee_bps() : u64 {
        500
    }

    public fun max_listing_ms(arg0: &Config) : u64 {
        arg0.max_listing_ms
    }

    public fun max_vesting_ms(arg0: &Config) : u64 {
        arg0.max_vesting_ms
    }

    public fun migrate(arg0: &AdminCap, arg1: &mut Config) {
        assert!(arg1.version < 1, 101);
        let v0 = Migrated{
            from : arg1.version,
            to   : 1,
        };
        0x2::event::emit<Migrated>(v0);
        arg1.version = 1;
    }

    public fun min_vesting_ms(arg0: &Config) : u64 {
        arg0.min_vesting_ms
    }

    public fun paused(arg0: &Config) : bool {
        arg0.paused
    }

    public fun set_params(arg0: &AdminCap, arg1: &mut Config, arg2: u64, arg3: address, arg4: u64, arg5: u64, arg6: u64) {
        assert!(arg2 <= 500, 102);
        assert!(arg3 != @0x0, 102);
        assert!(arg4 >= 86400000 && arg4 <= arg5, 102);
        assert!(arg5 <= 63072000000, 102);
        assert!(arg6 > 0, 102);
        arg1.fee_bps = arg2;
        arg1.fee_recipient = arg3;
        arg1.min_vesting_ms = arg4;
        arg1.max_vesting_ms = arg5;
        arg1.max_listing_ms = arg6;
        let v0 = ParamsChanged{
            fee_bps        : arg2,
            fee_recipient  : arg3,
            min_vesting_ms : arg4,
            max_vesting_ms : arg5,
            max_listing_ms : arg6,
        };
        0x2::event::emit<ParamsChanged>(v0);
    }

    public fun set_paused(arg0: &AdminCap, arg1: &mut Config, arg2: bool) {
        arg1.paused = arg2;
        let v0 = PauseChanged{paused: arg2};
        0x2::event::emit<PauseChanged>(v0);
    }

    public fun set_pay_coins(arg0: &AdminCap, arg1: &mut Config, arg2: vector<0x1::string::String>) {
        assert!(!0x1::vector::is_empty<0x1::string::String>(&arg2), 102);
        arg1.allowed_pay = arg2;
        let v0 = PayCoinsChanged{allowed_pay: arg2};
        0x2::event::emit<PayCoinsChanged>(v0);
    }

    public fun version(arg0: &Config) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

