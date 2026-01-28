module 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::epoch_period_manager {
    struct EpochPeriodManagerRole {
        dummy_field: bool,
    }

    public fun set_default_benefactor_max_mint_per_epoch(arg0: &mut 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::Treasury, arg1: &0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::auth::Auth<EpochPeriodManagerRole>, arg2: u64) {
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limit::set_max_mint(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limits::epoch_mut(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::config::default_benefactor_limits_mut(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::config_mut(arg0))), arg2);
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::events::emit_default_benefactor_epoch_limits_updated(*0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limits::epoch(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::config::default_benefactor_limits(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::config(arg0))));
    }

    public fun set_default_benefactor_max_mint_per_period(arg0: &mut 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::Treasury, arg1: &0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::auth::Auth<EpochPeriodManagerRole>, arg2: u64) {
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limit::set_max_mint(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limits::period_mut(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::config::default_benefactor_limits_mut(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::config_mut(arg0))), arg2);
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::events::emit_default_benefactor_period_limits_updated(*0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limits::period(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::config::default_benefactor_limits(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::config(arg0))));
    }

    public fun set_default_benefactor_max_redeem_per_epoch(arg0: &mut 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::Treasury, arg1: &0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::auth::Auth<EpochPeriodManagerRole>, arg2: u64) {
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limit::set_max_redeem(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limits::epoch_mut(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::config::default_benefactor_limits_mut(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::config_mut(arg0))), arg2);
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::events::emit_default_benefactor_epoch_limits_updated(*0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limits::epoch(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::config::default_benefactor_limits(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::config(arg0))));
    }

    public fun set_default_benefactor_max_redeem_per_period(arg0: &mut 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::Treasury, arg1: &0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::auth::Auth<EpochPeriodManagerRole>, arg2: u64) {
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limit::set_max_redeem(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limits::period_mut(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::config::default_benefactor_limits_mut(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::config_mut(arg0))), arg2);
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::events::emit_default_benefactor_period_limits_updated(*0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limits::period(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::config::default_benefactor_limits(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::config(arg0))));
    }

    public fun set_epoch_duration(arg0: &mut 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::Treasury, arg1: &0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::auth::Auth<EpochPeriodManagerRole>, arg2: u64) {
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::config::set_epoch_duration_ms(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::config_mut(arg0), arg2);
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::events::emit_epoch_duration_updated(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::config::epoch_duration_ms(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::config(arg0)), arg2);
    }

    public fun set_global_epoch_limits(arg0: &mut 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::Treasury, arg1: &0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::auth::Auth<EpochPeriodManagerRole>, arg2: 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limit::Limit) {
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limiter::set_epoch_limits(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::config::limiter_mut(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::config_mut(arg0)), arg2);
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::events::emit_epoch_limits_updated(arg2);
    }

    public fun set_global_period_limits(arg0: &mut 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::Treasury, arg1: &0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::auth::Auth<EpochPeriodManagerRole>, arg2: 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limit::Limit) {
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limiter::set_period_limits(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::config::limiter_mut(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::config_mut(arg0)), arg2);
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::events::emit_period_limits_updated(arg2);
    }

    public fun set_period_duration(arg0: &mut 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::Treasury, arg1: &0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::auth::Auth<EpochPeriodManagerRole>, arg2: u64) {
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::config::set_period_duration_ms(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::config_mut(arg0), arg2);
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::events::emit_period_duration_updated(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::config::period_duration_ms(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::config(arg0)), arg2);
    }

    // decompiled from Move bytecode v6
}

