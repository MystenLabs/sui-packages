module 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config {
    struct SetupCap has key {
        id: 0x2::object::UID,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        config: 0x2::object::ID,
        treasury: 0x2::object::ID,
    }

    struct BrakeCap has store, key {
        id: 0x2::object::UID,
        config: 0x2::object::ID,
    }

    struct RevokedBrakeKey has copy, drop, store {
        cap_id: 0x2::object::ID,
    }

    struct Risk has copy, drop, store {
        band_half_width_bps: u64,
        drift_bps: u64,
        max_oracle_age_ms: u64,
        max_slippage_bps: u64,
        max_sell_slippage_bps: u64,
        max_rebalance_notional: u64,
        danger_buffer_bps: u64,
        defend_reward: u64,
        defend_cooldown_ms: u64,
    }

    struct Params has copy, drop, store {
        terms: 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::terms::Terms,
        risk: Risk,
    }

    struct Config has key {
        id: 0x2::object::UID,
        version: u64,
        sell_only: bool,
        collateral: 0x1::type_name::TypeName,
        params: Params,
        pending: 0x1::option::Option<Params>,
        pending_ready_ms: u64,
        setup_open: bool,
    }

    struct Treasury<phantom T0> has key {
        id: 0x2::object::UID,
        platform: 0x2::balance::Balance<T0>,
        season: 0x2::balance::Balance<T0>,
        launch_fees: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct ParamsProposed has copy, drop {
        params: Params,
        ready_ms: u64,
    }

    struct ParamsApplied has copy, drop {
        params: Params,
    }

    struct ParamsCancelled has copy, drop {
        dummy_field: bool,
    }

    struct SetupSealed has copy, drop {
        dummy_field: bool,
    }

    struct SellOnlyChanged has copy, drop {
        sell_only: bool,
        by_brake: bool,
    }

    struct BrakeIssued has copy, drop {
        cap_id: 0x2::object::ID,
        recipient: address,
    }

    struct BrakeRevoked has copy, drop {
        cap_id: 0x2::object::ID,
    }

    struct Migrated has copy, drop {
        version: u64,
    }

    struct Withdrawn has copy, drop {
        bucket: u8,
        amount: u64,
    }

    public fun new_params(arg0: 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::terms::Terms, arg1: Risk) : Params {
        let v0 = Params{
            terms : arg0,
            risk  : arg1,
        };
        check_params(&v0);
        v0
    }

    public fun admin_brake(arg0: &mut Config, arg1: &AdminCap) {
        check_admin(arg1, arg0);
        arg0.sell_only = true;
        let v0 = SellOnlyChanged{
            sell_only : true,
            by_brake  : false,
        };
        0x2::event::emit<SellOnlyChanged>(v0);
    }

    public fun admin_cap_ids(arg0: &AdminCap) : (0x2::object::ID, 0x2::object::ID) {
        (arg0.config, arg0.treasury)
    }

    public fun apply_params(arg0: &mut Config, arg1: &0x2::clock::Clock) {
        assert_version(arg0);
        assert!(0x1::option::is_some<Params>(&arg0.pending), 703);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.pending_ready_ms, 704);
        let v0 = 0x1::option::extract<Params>(&mut arg0.pending);
        check_params(&v0);
        arg0.params = v0;
        let v1 = ParamsApplied{params: v0};
        0x2::event::emit<ParamsApplied>(v1);
    }

    public fun assert_can_buy(arg0: &Config) {
        assert_version(arg0);
        assert!(!arg0.sell_only, 702);
    }

    public fun assert_collateral<T0>(arg0: &Config) {
        assert!(arg0.collateral == 0x1::type_name::with_defining_ids<T0>(), 706);
    }

    public fun assert_sealed(arg0: &Config) {
        assert!(!arg0.setup_open, 712);
    }

    public fun assert_version(arg0: &Config) {
        assert!(arg0.version == 1, 700);
    }

    public fun band_for(arg0: &Risk, arg1: u64) : 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::band::Params {
        0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::band::new_params(arg1, arg1 - arg0.band_half_width_bps, arg1 + arg0.band_half_width_bps, arg0.drift_bps)
    }

    public fun band_half_width_bps(arg0: &Risk) : u64 {
        arg0.band_half_width_bps
    }

    public fun brake(arg0: &mut Config, arg1: &BrakeCap) {
        assert!(arg1.config == 0x2::object::id<Config>(arg0), 708);
        assert_version(arg0);
        let v0 = RevokedBrakeKey{cap_id: 0x2::object::id<BrakeCap>(arg1)};
        assert!(!0x2::dynamic_field::exists<RevokedBrakeKey>(&arg0.id, v0), 709);
        arg0.sell_only = true;
        let v1 = SellOnlyChanged{
            sell_only : true,
            by_brake  : true,
        };
        0x2::event::emit<SellOnlyChanged>(v1);
    }

    public fun cancel_params(arg0: &mut Config, arg1: &AdminCap) {
        check_admin(arg1, arg0);
        assert!(0x1::option::is_some<Params>(&arg0.pending), 703);
        arg0.pending = 0x1::option::none<Params>();
        let v0 = ParamsCancelled{dummy_field: false};
        0x2::event::emit<ParamsCancelled>(v0);
    }

    fun check_admin(arg0: &AdminCap, arg1: &Config) {
        assert!(arg0.config == 0x2::object::id<Config>(arg1), 708);
        assert_version(arg1);
    }

    fun check_admin_treasury<T0>(arg0: &AdminCap, arg1: &Config, arg2: &Treasury<T0>) {
        check_admin(arg0, arg1);
        assert!(arg0.treasury == 0x2::object::id<Treasury<T0>>(arg2), 708);
    }

    public fun check_params(arg0: &Params) {
        0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::terms::check(&arg0.terms);
        check_risk(&arg0.risk);
    }

    public fun check_risk(arg0: &Risk) {
        assert!(arg0.band_half_width_bps >= 200 && arg0.band_half_width_bps <= 900, 705);
        assert!(arg0.drift_bps >= 500 && arg0.drift_bps <= 2000, 705);
        assert!(arg0.max_oracle_age_ms >= 5000 && arg0.max_oracle_age_ms <= 60000, 705);
        assert!(arg0.max_slippage_bps > 0 && arg0.max_slippage_bps <= 100, 705);
        assert!(arg0.max_sell_slippage_bps > 0 && arg0.max_sell_slippage_bps <= 100, 705);
        assert!(arg0.max_rebalance_notional >= 1000000 && arg0.max_rebalance_notional <= 100000000000, 705);
        assert!(arg0.danger_buffer_bps >= 12000 && arg0.danger_buffer_bps <= 30000, 705);
        assert!(arg0.defend_reward <= 5000000, 705);
        assert!(arg0.defend_cooldown_ms >= 60000, 705);
    }

    public fun create<T0>(arg0: SetupCap, arg1: &mut 0x2::tx_context::TxContext) : AdminCap {
        let SetupCap { id: v0 } = arg0;
        0x2::object::delete(v0);
        new_platform<T0>(arg1)
    }

    public(friend) fun credit<T0>(arg0: &mut Treasury<T0>, arg1: &mut 0x5bb7750b5bd6bdd7babb22a8e38aa4789cf4624f7e87e9ca53802c72e33141ef::referral::Registry, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<T0>, arg5: 0x1::option::Option<address>) {
        0x2::balance::join<T0>(&mut arg0.platform, arg2);
        0x2::balance::join<T0>(&mut arg0.season, arg3);
        if (0x1::option::is_some<address>(&arg5)) {
            0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::legacy::credit<T0>(arg1, 0x1::option::destroy_some<address>(arg5), arg4);
        } else {
            0x2::balance::join<T0>(&mut arg0.platform, arg4);
        };
    }

    public fun default_params() : Params {
        Params{
            terms : 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::terms::default(),
            risk  : default_risk(),
        }
    }

    public fun default_risk() : Risk {
        Risk{
            band_half_width_bps    : 500,
            drift_bps              : 1000,
            max_oracle_age_ms      : 10000,
            max_slippage_bps       : 25,
            max_sell_slippage_bps  : 50,
            max_rebalance_notional : 10000000000,
            danger_buffer_bps      : 15000,
            defend_reward          : 200000,
            defend_cooldown_ms     : 600000,
        }
    }

    public fun defend(arg0: &Risk) : (u64, u64, u64) {
        (arg0.danger_buffer_bps, arg0.defend_reward, arg0.defend_cooldown_ms)
    }

    public fun delay_ms() : u64 {
        172800000
    }

    public fun drift_bps(arg0: &Risk) : u64 {
        arg0.drift_bps
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SetupCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<SetupCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun is_sell_only(arg0: &Config) : bool {
        arg0.sell_only
    }

    public fun issue_brake_cap(arg0: &Config, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        check_admin(arg1, arg0);
        let v0 = BrakeCap{
            id     : 0x2::object::new(arg3),
            config : 0x2::object::id<Config>(arg0),
        };
        let v1 = BrakeIssued{
            cap_id    : 0x2::object::id<BrakeCap>(&v0),
            recipient : arg2,
        };
        0x2::event::emit<BrakeIssued>(v1);
        0x2::transfer::public_transfer<BrakeCap>(v0, arg2);
    }

    public fun launch_terms(arg0: &Config) : 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::terms::Terms {
        arg0.params.terms
    }

    public fun terms(arg0: &Params) : &0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::terms::Terms {
        &arg0.terms
    }

    public fun max_oracle_age_ms(arg0: &Risk) : u64 {
        arg0.max_oracle_age_ms
    }

    public fun max_rebalance_notional(arg0: &Risk) : u64 {
        arg0.max_rebalance_notional
    }

    public fun max_sell_slippage_bps(arg0: &Risk) : u64 {
        arg0.max_sell_slippage_bps
    }

    public fun max_slippage_bps(arg0: &Risk) : u64 {
        arg0.max_slippage_bps
    }

    public fun migrate(arg0: &mut Config, arg1: &AdminCap) {
        assert!(arg1.config == 0x2::object::id<Config>(arg0), 708);
        assert!(arg0.version < 1, 701);
        arg0.version = 1;
        let v0 = Migrated{version: 1};
        0x2::event::emit<Migrated>(v0);
    }

    fun new_platform<T0>(arg0: &mut 0x2::tx_context::TxContext) : AdminCap {
        let v0 = Config{
            id               : 0x2::object::new(arg0),
            version          : 1,
            sell_only        : false,
            collateral       : 0x1::type_name::with_defining_ids<T0>(),
            params           : default_params(),
            pending          : 0x1::option::none<Params>(),
            pending_ready_ms : 0,
            setup_open       : true,
        };
        let v1 = Treasury<T0>{
            id          : 0x2::object::new(arg0),
            platform    : 0x2::balance::zero<T0>(),
            season      : 0x2::balance::zero<T0>(),
            launch_fees : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        let v2 = AdminCap{
            id       : 0x2::object::new(arg0),
            config   : 0x2::object::id<Config>(&v0),
            treasury : 0x2::object::id<Treasury<T0>>(&v1),
        };
        0x2::transfer::share_object<Config>(v0);
        0x2::transfer::share_object<Treasury<T0>>(v1);
        v2
    }

    public fun new_risk(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64) : Risk {
        let v0 = Risk{
            band_half_width_bps    : arg0,
            drift_bps              : arg1,
            max_oracle_age_ms      : arg2,
            max_slippage_bps       : arg3,
            max_sell_slippage_bps  : arg4,
            max_rebalance_notional : arg5,
            danger_buffer_bps      : arg6,
            defend_reward          : arg7,
            defend_cooldown_ms     : arg8,
        };
        check_risk(&v0);
        v0
    }

    public fun params(arg0: &Config) : &Params {
        &arg0.params
    }

    public fun pending_params(arg0: &Config) : (0x1::option::Option<Params>, u64) {
        (arg0.pending, arg0.pending_ready_ms)
    }

    public fun propose_params(arg0: &mut Config, arg1: &AdminCap, arg2: Params, arg3: &0x2::clock::Clock) {
        check_admin(arg1, arg0);
        check_params(&arg2);
        arg0.pending = 0x1::option::some<Params>(arg2);
        arg0.pending_ready_ms = 0x2::clock::timestamp_ms(arg3) + 172800000;
        let v0 = ParamsProposed{
            params   : arg2,
            ready_ms : arg0.pending_ready_ms,
        };
        0x2::event::emit<ParamsProposed>(v0);
    }

    public fun release_brake(arg0: &mut Config, arg1: &AdminCap) {
        check_admin(arg1, arg0);
        assert!(arg0.sell_only, 711);
        arg0.sell_only = false;
        let v0 = SellOnlyChanged{
            sell_only : false,
            by_brake  : false,
        };
        0x2::event::emit<SellOnlyChanged>(v0);
    }

    public fun revoke_brake_cap(arg0: &mut Config, arg1: &AdminCap, arg2: 0x2::object::ID) {
        check_admin(arg1, arg0);
        let v0 = RevokedBrakeKey{cap_id: arg2};
        if (!0x2::dynamic_field::exists<RevokedBrakeKey>(&arg0.id, v0)) {
            let v1 = RevokedBrakeKey{cap_id: arg2};
            0x2::dynamic_field::add<RevokedBrakeKey, bool>(&mut arg0.id, v1, true);
        };
        let v2 = BrakeRevoked{cap_id: arg2};
        0x2::event::emit<BrakeRevoked>(v2);
    }

    public fun risk(arg0: &Config) : &Risk {
        &arg0.params.risk
    }

    public fun risk_of(arg0: &Params) : &Risk {
        &arg0.risk
    }

    public fun seal_setup(arg0: &mut Config, arg1: &AdminCap) {
        check_admin(arg1, arg0);
        assert!(arg0.setup_open, 710);
        arg0.setup_open = false;
        let v0 = SetupSealed{dummy_field: false};
        0x2::event::emit<SetupSealed>(v0);
    }

    public fun setup_open(arg0: &Config) : bool {
        arg0.setup_open
    }

    public fun setup_params(arg0: &mut Config, arg1: &AdminCap, arg2: Params) {
        check_admin(arg1, arg0);
        assert!(arg0.setup_open, 710);
        check_params(&arg2);
        arg0.params = arg2;
        let v0 = ParamsApplied{params: arg2};
        0x2::event::emit<ParamsApplied>(v0);
    }

    public(friend) fun take_launch_fee<T0>(arg0: &mut Treasury<T0>, arg1: 0x2::balance::Balance<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.launch_fees, arg1);
    }

    public fun treasury_balances<T0>(arg0: &Treasury<T0>) : (u64, u64, u64) {
        (0x2::balance::value<T0>(&arg0.platform), 0x2::balance::value<T0>(&arg0.season), 0x2::balance::value<0x2::sui::SUI>(&arg0.launch_fees))
    }

    public fun version(arg0: &Config) : u64 {
        arg0.version
    }

    public fun withdraw_launch_fees<T0>(arg0: &mut Treasury<T0>, arg1: &Config, arg2: &AdminCap, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        check_admin_treasury<T0>(arg2, arg1, arg0);
        let v0 = 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.launch_fees);
        let v1 = Withdrawn{
            bucket : 1,
            amount : 0x2::balance::value<0x2::sui::SUI>(&v0),
        };
        0x2::event::emit<Withdrawn>(v1);
        0x2::coin::from_balance<0x2::sui::SUI>(v0, arg3)
    }

    public fun withdraw_platform<T0>(arg0: &mut Treasury<T0>, arg1: &Config, arg2: &AdminCap, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        check_admin_treasury<T0>(arg2, arg1, arg0);
        let v0 = 0x2::balance::withdraw_all<T0>(&mut arg0.platform);
        let v1 = Withdrawn{
            bucket : 0,
            amount : 0x2::balance::value<T0>(&v0),
        };
        0x2::event::emit<Withdrawn>(v1);
        0x2::coin::from_balance<T0>(v0, arg3)
    }

    public fun withdraw_season<T0>(arg0: &mut Treasury<T0>, arg1: &Config, arg2: &AdminCap, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        check_admin_treasury<T0>(arg2, arg1, arg0);
        let v0 = 0x2::balance::withdraw_all<T0>(&mut arg0.season);
        let v1 = Withdrawn{
            bucket : 2,
            amount : 0x2::balance::value<T0>(&v0),
        };
        0x2::event::emit<Withdrawn>(v1);
        0x2::coin::from_balance<T0>(v0, arg3)
    }

    // decompiled from Move bytecode v7
}

