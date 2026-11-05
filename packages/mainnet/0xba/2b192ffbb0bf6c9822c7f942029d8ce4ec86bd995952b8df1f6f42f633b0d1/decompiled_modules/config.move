module 0xba2b192ffbb0bf6c9822c7f942029d8ce4ec86bd995952b8df1f6f42f633b0d1::config {
    struct Config has key {
        id: 0x2::object::UID,
        version: u64,
        paused: bool,
        fee_recipient: address,
        launch_fee_bps: u64,
        platform_bps: u64,
        buy_bps: u64,
        sunset_bps: u64,
        max_target_fdv_bps: u64,
        keepers: 0x2::vec_set::VecSet<address>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct QuoteKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct QuoteParams has copy, drop, store {
        enabled: bool,
        min_target: u64,
        max_target: u64,
        min_start_fdv: u64,
        max_start_fdv: u64,
        limits: Limits,
    }

    struct Limits has copy, drop, store {
        max_turnover_bps: u64,
        max_dev_bps: u64,
        band_low_bps: u64,
        band_high_bps: u64,
        max_token_value_bps: u64,
        min_interval_ms: u64,
        min_ask_premium_bps: u64,
    }

    struct OpenKey<phantom T0, phantom T1> has copy, drop, store {
        dummy_field: bool,
    }

    struct OpenVaultKey<phantom T0, phantom T1> has copy, drop, store {
        dummy_field: bool,
    }

    struct OpenParams has copy, drop, store {
        enabled: bool,
        pool_id: 0x2::object::ID,
        limits: Limits,
        perf_fee_bps: u64,
        max_pool_share_bps: u64,
        max_deposit_dev_bps: u64,
        daily_deposit_bps: u64,
        min_hold_ms: u64,
    }

    struct Migrated has copy, drop {
        from: u64,
        to: u64,
    }

    struct ParamsChanged has copy, drop {
        fee_recipient: address,
        launch_fee_bps: u64,
        platform_bps: u64,
        buy_bps: u64,
        sunset_bps: u64,
    }

    struct QuoteSet has copy, drop {
        quote: 0x1::ascii::String,
        params: QuoteParams,
    }

    struct PauseChanged has copy, drop {
        paused: bool,
    }

    struct KeeperSet has copy, drop {
        keeper: address,
        allowed: bool,
    }

    struct MaxTargetFdvSet has copy, drop {
        max_target_fdv_bps: u64,
    }

    struct OpenSet has copy, drop {
        token: 0x1::ascii::String,
        quote: 0x1::ascii::String,
        params: OpenParams,
    }

    fun new(arg0: &mut 0x2::tx_context::TxContext) : Config {
        Config{
            id                 : 0x2::object::new(arg0),
            version            : 1,
            paused             : true,
            fee_recipient      : 0x2::tx_context::sender(arg0),
            launch_fee_bps     : 500,
            platform_bps       : 2000,
            buy_bps            : 6000,
            sunset_bps         : 7800,
            max_target_fdv_bps : 2500,
            keepers            : 0x2::vec_set::empty<address>(),
        }
    }

    public fun assert_keeper(arg0: &Config, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::vec_set::contains<address>(&arg0.keepers, &v0), 106);
    }

    public fun assert_open<T0>(arg0: &Config) : QuoteParams {
        assert_version(arg0);
        assert!(!arg0.paused, 103);
        let v0 = quote_params<T0>(arg0);
        assert!(v0.enabled, 105);
        v0
    }

    public fun assert_version(arg0: &Config) {
        assert!(arg0.version == 1, 100);
    }

    public fun band_high_bps(arg0: &Limits) : u64 {
        arg0.band_high_bps
    }

    public fun band_low_bps(arg0: &Limits) : u64 {
        arg0.band_low_bps
    }

    public fun buy_bps(arg0: &Config) : u64 {
        arg0.buy_bps
    }

    public fun daily_deposit_bps(arg0: &OpenParams) : u64 {
        arg0.daily_deposit_bps
    }

    public fun default_limits() : Limits {
        Limits{
            max_turnover_bps    : 1000,
            max_dev_bps         : 400,
            band_low_bps        : 4000,
            band_high_bps       : 30000,
            max_token_value_bps : 5000,
            min_interval_ms     : 600000,
            min_ask_premium_bps : 1000,
        }
    }

    public fun fee_recipient(arg0: &Config) : address {
        arg0.fee_recipient
    }

    public fun has_open<T0, T1>(arg0: &Config) : bool {
        let v0 = OpenKey<T0, T1>{dummy_field: false};
        0x2::dynamic_field::exists_with_type<OpenKey<T0, T1>, OpenParams>(&arg0.id, v0)
    }

    public fun has_quote<T0>(arg0: &Config) : bool {
        let v0 = QuoteKey<T0>{dummy_field: false};
        0x2::dynamic_field::exists_with_type<QuoteKey<T0>, QuoteParams>(&arg0.id, v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = new(arg0);
        0x2::transfer::share_object<Config>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_keeper(arg0: &Config, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.keepers, &arg1)
    }

    public fun launch_fee_bps(arg0: &Config) : u64 {
        arg0.launch_fee_bps
    }

    public fun limits(arg0: &QuoteParams) : Limits {
        arg0.limits
    }

    public fun max_deposit_dev_bps(arg0: &OpenParams) : u64 {
        arg0.max_deposit_dev_bps
    }

    public fun max_dev_bps(arg0: &Limits) : u64 {
        arg0.max_dev_bps
    }

    public fun max_pool_share_bps(arg0: &OpenParams) : u64 {
        arg0.max_pool_share_bps
    }

    public fun max_start_fdv(arg0: &QuoteParams) : u64 {
        arg0.max_start_fdv
    }

    public fun max_target(arg0: &QuoteParams) : u64 {
        arg0.max_target
    }

    public fun max_target_fdv_bps(arg0: &Config) : u64 {
        arg0.max_target_fdv_bps
    }

    public fun max_token_value_bps(arg0: &Limits) : u64 {
        arg0.max_token_value_bps
    }

    public fun max_turnover_bps(arg0: &Limits) : u64 {
        arg0.max_turnover_bps
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

    public fun min_ask_premium_bps(arg0: &Limits) : u64 {
        arg0.min_ask_premium_bps
    }

    public fun min_hold_ms(arg0: &OpenParams) : u64 {
        arg0.min_hold_ms
    }

    public fun min_interval_ms(arg0: &Limits) : u64 {
        arg0.min_interval_ms
    }

    public fun min_start_fdv(arg0: &QuoteParams) : u64 {
        arg0.min_start_fdv
    }

    public fun min_target(arg0: &QuoteParams) : u64 {
        arg0.min_target
    }

    public fun new_limits(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : Limits {
        assert!(arg0 > 0 && arg0 <= 10000, 102);
        assert!(arg1 >= 10 && arg1 <= 1000, 102);
        assert!(arg2 > 0 && arg2 < 10000, 102);
        assert!(arg3 > 10000 && arg3 <= 10 * 10000, 102);
        assert!(arg4 > 0 && arg4 <= 10000, 102);
        assert!(arg5 >= 60000 && arg5 <= 86400000, 102);
        assert!(arg6 >= arg1 && arg6 <= 5000, 102);
        Limits{
            max_turnover_bps    : arg0,
            max_dev_bps         : arg1,
            band_low_bps        : arg2,
            band_high_bps       : arg3,
            max_token_value_bps : arg4,
            min_interval_ms     : arg5,
            min_ask_premium_bps : arg6,
        }
    }

    public fun open_defaults() : (u64, u64, u64, u64, u64) {
        (2000, 1000, 100, 2000, 259200000)
    }

    public fun open_enabled(arg0: &OpenParams) : bool {
        arg0.enabled
    }

    public fun open_limits(arg0: &OpenParams) : Limits {
        arg0.limits
    }

    public fun open_params<T0, T1>(arg0: &Config) : OpenParams {
        assert!(has_open<T0, T1>(arg0), 107);
        let v0 = OpenKey<T0, T1>{dummy_field: false};
        *0x2::dynamic_field::borrow<OpenKey<T0, T1>, OpenParams>(&arg0.id, v0)
    }

    public fun open_pool_id(arg0: &OpenParams) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun open_vault_id<T0, T1>(arg0: &Config) : 0x1::option::Option<0x2::object::ID> {
        let v0 = OpenVaultKey<T0, T1>{dummy_field: false};
        if (0x2::dynamic_field::exists_with_type<OpenVaultKey<T0, T1>, 0x2::object::ID>(&arg0.id, v0)) {
            let v2 = OpenVaultKey<T0, T1>{dummy_field: false};
            0x1::option::some<0x2::object::ID>(*0x2::dynamic_field::borrow<OpenVaultKey<T0, T1>, 0x2::object::ID>(&arg0.id, v2))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    public fun paused(arg0: &Config) : bool {
        arg0.paused
    }

    public fun perf_fee_bps(arg0: &OpenParams) : u64 {
        arg0.perf_fee_bps
    }

    public fun platform_bps(arg0: &Config) : u64 {
        arg0.platform_bps
    }

    public fun quote_enabled(arg0: &QuoteParams) : bool {
        arg0.enabled
    }

    public fun quote_params<T0>(arg0: &Config) : QuoteParams {
        assert!(has_quote<T0>(arg0), 104);
        let v0 = QuoteKey<T0>{dummy_field: false};
        *0x2::dynamic_field::borrow<QuoteKey<T0>, QuoteParams>(&arg0.id, v0)
    }

    public(friend) fun register_open_vault<T0, T1>(arg0: &mut Config, arg1: 0x2::object::ID) {
        let v0 = OpenVaultKey<T0, T1>{dummy_field: false};
        assert!(!0x2::dynamic_field::exists_with_type<OpenVaultKey<T0, T1>, 0x2::object::ID>(&arg0.id, v0), 108);
        let v1 = OpenVaultKey<T0, T1>{dummy_field: false};
        0x2::dynamic_field::add<OpenVaultKey<T0, T1>, 0x2::object::ID>(&mut arg0.id, v1, arg1);
    }

    public fun set_keeper(arg0: &AdminCap, arg1: &mut Config, arg2: address, arg3: bool) {
        if (arg3) {
            if (!0x2::vec_set::contains<address>(&arg1.keepers, &arg2)) {
                0x2::vec_set::insert<address>(&mut arg1.keepers, arg2);
            };
        } else if (0x2::vec_set::contains<address>(&arg1.keepers, &arg2)) {
            0x2::vec_set::remove<address>(&mut arg1.keepers, &arg2);
        };
        let v0 = KeeperSet{
            keeper  : arg2,
            allowed : arg3,
        };
        0x2::event::emit<KeeperSet>(v0);
    }

    public fun set_max_target_fdv_bps(arg0: &AdminCap, arg1: &mut Config, arg2: u64) {
        assert!(arg2 > 0 && arg2 <= 10000, 102);
        arg1.max_target_fdv_bps = arg2;
        let v0 = MaxTargetFdvSet{max_target_fdv_bps: arg2};
        0x2::event::emit<MaxTargetFdvSet>(v0);
    }

    public fun set_open<T0, T1>(arg0: &AdminCap, arg1: &mut Config, arg2: bool, arg3: 0x2::object::ID, arg4: Limits, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64) {
        assert!(arg3 != 0x2::object::id_from_address(@0x0), 102);
        assert!(arg5 <= 3000, 102);
        assert!(arg6 > 0 && arg6 <= 2500, 102);
        assert!(arg7 >= 10 && arg7 <= 400, 102);
        assert!(arg8 > 0 && arg8 <= 10000, 102);
        assert!(arg9 >= 3600000 && arg9 <= 604800000, 102);
        let v0 = OpenParams{
            enabled             : arg2,
            pool_id             : arg3,
            limits              : arg4,
            perf_fee_bps        : arg5,
            max_pool_share_bps  : arg6,
            max_deposit_dev_bps : arg7,
            daily_deposit_bps   : arg8,
            min_hold_ms         : arg9,
        };
        let v1 = OpenKey<T0, T1>{dummy_field: false};
        if (0x2::dynamic_field::exists_with_type<OpenKey<T0, T1>, OpenParams>(&arg1.id, v1)) {
            let v2 = OpenKey<T0, T1>{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<OpenKey<T0, T1>, OpenParams>(&mut arg1.id, v2) = v0;
        } else {
            let v3 = OpenKey<T0, T1>{dummy_field: false};
            0x2::dynamic_field::add<OpenKey<T0, T1>, OpenParams>(&mut arg1.id, v3, v0);
        };
        let v4 = OpenSet{
            token  : 0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>()),
            quote  : 0x1::type_name::into_string(0x1::type_name::with_original_ids<T1>()),
            params : v0,
        };
        0x2::event::emit<OpenSet>(v4);
    }

    public fun set_params(arg0: &AdminCap, arg1: &mut Config, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        assert!(arg2 != @0x0, 102);
        assert!(arg3 <= 1000, 102);
        assert!(arg4 <= 3000, 102);
        assert!(arg5 >= 2000 && arg5 <= 9000, 102);
        assert!(arg6 >= 1000 && arg6 <= 100000, 102);
        arg1.fee_recipient = arg2;
        arg1.launch_fee_bps = arg3;
        arg1.platform_bps = arg4;
        arg1.buy_bps = arg5;
        arg1.sunset_bps = arg6;
        let v0 = ParamsChanged{
            fee_recipient  : arg2,
            launch_fee_bps : arg3,
            platform_bps   : arg4,
            buy_bps        : arg5,
            sunset_bps     : arg6,
        };
        0x2::event::emit<ParamsChanged>(v0);
    }

    public fun set_paused(arg0: &AdminCap, arg1: &mut Config, arg2: bool) {
        arg1.paused = arg2;
        let v0 = PauseChanged{paused: arg2};
        0x2::event::emit<PauseChanged>(v0);
    }

    public fun set_quote<T0>(arg0: &AdminCap, arg1: &mut Config, arg2: bool, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: Limits) {
        assert!(arg3 > 0 && arg3 <= arg4, 102);
        assert!(arg5 > 0 && arg5 <= arg6, 102);
        let v0 = QuoteParams{
            enabled       : arg2,
            min_target    : arg3,
            max_target    : arg4,
            min_start_fdv : arg5,
            max_start_fdv : arg6,
            limits        : arg7,
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

    public fun sunset_bps(arg0: &Config) : u64 {
        arg0.sunset_bps
    }

    public fun target_fits(arg0: &Config, arg1: u64, arg2: u64) : bool {
        (arg1 as u128) * (10000 as u128) <= (arg2 as u128) * (arg0.max_target_fdv_bps as u128)
    }

    public fun version(arg0: &Config) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

