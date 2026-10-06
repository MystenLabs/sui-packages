module 0x2afb4567587bb94b11f6436511b1a4befd502d0b7aad05d9a5ae1c5b29ac7b79::config {
    struct Config has key {
        id: 0x2::object::UID,
        version: u64,
        paused: bool,
        fee_recipient: address,
        launch_fee: u64,
        creator_bps: u64,
        max_dev_buy_bps: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct QuoteKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct QuoteParams has copy, drop, store {
        enabled: bool,
        min_start_fdv: u64,
        max_start_fdv: u64,
        min_buyback: u64,
    }

    struct Migrated has copy, drop {
        from: u64,
        to: u64,
    }

    struct ParamsChanged has copy, drop {
        fee_recipient: address,
        launch_fee: u64,
        creator_bps: u64,
        max_dev_buy_bps: u64,
    }

    struct QuoteSet has copy, drop {
        quote: 0x1::ascii::String,
        params: QuoteParams,
    }

    struct PauseChanged has copy, drop {
        paused: bool,
    }

    public fun assert_launch<T0>(arg0: &Config) : QuoteParams {
        assert_version(arg0);
        assert!(!arg0.paused, 103);
        let v0 = quote_params<T0>(arg0);
        assert!(v0.enabled, 105);
        v0
    }

    public fun assert_version(arg0: &Config) {
        assert!(arg0.version == 1, 100);
    }

    public fun creator_bps(arg0: &Config) : u64 {
        arg0.creator_bps
    }

    public fun fee_recipient(arg0: &Config) : address {
        arg0.fee_recipient
    }

    public fun has_quote<T0>(arg0: &Config) : bool {
        let v0 = QuoteKey<T0>{dummy_field: false};
        0x2::dynamic_field::exists_with_type<QuoteKey<T0>, QuoteParams>(&arg0.id, v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id              : 0x2::object::new(arg0),
            version         : 1,
            paused          : true,
            fee_recipient   : 0x2::tx_context::sender(arg0),
            launch_fee      : 1000000000,
            creator_bps     : 6250,
            max_dev_buy_bps : 1000,
        };
        0x2::transfer::share_object<Config>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun launch_fee(arg0: &Config) : u64 {
        arg0.launch_fee
    }

    public fun max_dev_buy_bps(arg0: &Config) : u64 {
        arg0.max_dev_buy_bps
    }

    public fun max_start_fdv(arg0: &QuoteParams) : u64 {
        arg0.max_start_fdv
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

    public fun min_buyback(arg0: &QuoteParams) : u64 {
        arg0.min_buyback
    }

    public fun min_creator_bps() : u64 {
        5000
    }

    public fun min_start_fdv(arg0: &QuoteParams) : u64 {
        arg0.min_start_fdv
    }

    public fun paused(arg0: &Config) : bool {
        arg0.paused
    }

    public fun quote_enabled(arg0: &QuoteParams) : bool {
        arg0.enabled
    }

    public fun quote_params<T0>(arg0: &Config) : QuoteParams {
        assert!(has_quote<T0>(arg0), 104);
        let v0 = QuoteKey<T0>{dummy_field: false};
        *0x2::dynamic_field::borrow<QuoteKey<T0>, QuoteParams>(&arg0.id, v0)
    }

    public fun set_params(arg0: &AdminCap, arg1: &mut Config, arg2: address, arg3: u64, arg4: u64, arg5: u64) {
        assert!(arg2 != @0x0, 102);
        assert!(arg3 <= 100000000000, 102);
        assert!(arg4 >= 5000 && arg4 <= 10000, 102);
        assert!(arg5 <= 2000, 102);
        arg1.fee_recipient = arg2;
        arg1.launch_fee = arg3;
        arg1.creator_bps = arg4;
        arg1.max_dev_buy_bps = arg5;
        let v0 = ParamsChanged{
            fee_recipient   : arg2,
            launch_fee      : arg3,
            creator_bps     : arg4,
            max_dev_buy_bps : arg5,
        };
        0x2::event::emit<ParamsChanged>(v0);
    }

    public fun set_paused(arg0: &AdminCap, arg1: &mut Config, arg2: bool) {
        arg1.paused = arg2;
        let v0 = PauseChanged{paused: arg2};
        0x2::event::emit<PauseChanged>(v0);
    }

    public fun set_quote<T0>(arg0: &AdminCap, arg1: &mut Config, arg2: bool, arg3: u64, arg4: u64, arg5: u64) {
        assert!(arg3 > 0 && arg3 <= arg4, 102);
        assert!(arg5 > 0 && arg5 <= arg4, 102);
        let v0 = QuoteParams{
            enabled       : arg2,
            min_start_fdv : arg3,
            max_start_fdv : arg4,
            min_buyback   : arg5,
        };
        let v1 = QuoteKey<T0>{dummy_field: false};
        if (0x2::dynamic_field::exists_with_type<QuoteKey<T0>, QuoteParams>(&arg1.id, v1)) {
            let v2 = QuoteKey<T0>{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<QuoteKey<T0>, QuoteParams>(&mut arg1.id, v2) = v0;
        } else {
            let v3 = QuoteKey<T0>{dummy_field: false};
            0x2::dynamic_field::add<QuoteKey<T0>, QuoteParams>(&mut arg1.id, v3, v0);
        };
        let v4 = QuoteSet{
            quote  : 0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>()),
            params : v0,
        };
        0x2::event::emit<QuoteSet>(v4);
    }

    public fun version(arg0: &Config) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

