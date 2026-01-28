module 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::config {
    struct Config has store {
        is_mint_redeem_enabled: bool,
        version: u64,
        epoch_duration_ms: u64,
        period_duration_ms: u64,
        limiter: 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limiter::Limiter,
        default_benefactor_limits: 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limits::Limits,
        peg_price: u64,
        extra_storage: 0x2::object::UID,
    }

    public fun new(arg0: u64, arg1: u64, arg2: 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limits::Limits, arg3: 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limits::Limits, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : Config {
        let v0 = Config{
            is_mint_redeem_enabled    : false,
            version                   : 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::constants::breaking_version_counter(),
            epoch_duration_ms         : arg0,
            period_duration_ms        : arg1,
            limiter                   : 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limiter::new(arg2),
            default_benefactor_limits : arg3,
            peg_price                 : arg4,
            extra_storage             : 0x2::object::new(arg5),
        };
        let v1 = &mut v0;
        set_epoch_duration_ms(v1, arg0);
        let v2 = &mut v0;
        set_period_duration_ms(v2, arg1);
        let v3 = &mut v0;
        set_peg_price(v3, arg4);
        v0
    }

    public(friend) fun assert_mint_redeem_enabled(arg0: &Config) {
        assert!(arg0.is_mint_redeem_enabled, 13835621550696562691);
    }

    public(friend) fun assert_valid_version(arg0: &Config) {
        assert!(arg0.version == 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::constants::breaking_version_counter(), 13835340054244884481);
    }

    public(friend) fun default_benefactor_limits(arg0: &Config) : &0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limits::Limits {
        &arg0.default_benefactor_limits
    }

    public(friend) fun default_benefactor_limits_mut(arg0: &mut Config) : &mut 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limits::Limits {
        &mut arg0.default_benefactor_limits
    }

    public(friend) fun disable_mint_redeem(arg0: &mut Config) {
        assert!(arg0.is_mint_redeem_enabled, 13836184273016979463);
        arg0.is_mint_redeem_enabled = false;
    }

    public(friend) fun enable_mint_redeem(arg0: &mut Config) {
        assert!(!arg0.is_mint_redeem_enabled, 13835902776565301253);
        arg0.is_mint_redeem_enabled = true;
    }

    public(friend) fun epoch_duration_ms(arg0: &Config) : u64 {
        arg0.epoch_duration_ms
    }

    public(friend) fun is_mint_redeem_enabled(arg0: &Config) : bool {
        arg0.is_mint_redeem_enabled
    }

    public(friend) fun limiter(arg0: &Config) : &0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limiter::Limiter {
        &arg0.limiter
    }

    public(friend) fun limiter_mut(arg0: &mut Config) : &mut 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limiter::Limiter {
        &mut arg0.limiter
    }

    public(friend) fun peg_price(arg0: &Config) : u64 {
        arg0.peg_price
    }

    public(friend) fun period_duration_ms(arg0: &Config) : u64 {
        arg0.period_duration_ms
    }

    public(friend) fun set_epoch_duration_ms(arg0: &mut Config, arg1: u64) {
        assert!(arg1 >= 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::constants::min_epoch_duration_ms() && arg1 <= 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::constants::max_epoch_duration_ms(), 13836747265920335883);
        arg0.epoch_duration_ms = arg1;
    }

    public(friend) fun set_peg_price(arg0: &mut Config, arg1: u64) {
        assert!(arg1 > 0 && arg1 <= 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::constants::max_peg_price(), 13836466018576760841);
        arg0.peg_price = arg1;
    }

    public(friend) fun set_period_duration_ms(arg0: &mut Config, arg1: u64) {
        assert!(arg1 >= 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::constants::min_period_duration_ms() && arg1 <= 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::constants::max_period_duration_ms(), 13837028788141817869);
        arg0.period_duration_ms = arg1;
    }

    public(friend) fun set_version(arg0: &mut Config, arg1: u64) {
        arg0.version = arg1;
    }

    public(friend) fun version(arg0: &Config) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v6
}

