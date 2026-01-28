module 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::collateral_config {
    struct CollateralConfig<phantom T0> has store {
        enabled: bool,
        custodian_address: address,
        redeem_balance: 0x2::balance::Balance<T0>,
        limiter: 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limiter::Limiter,
        decimals: u8,
        default_fee: 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::collateral_fee::CollateralFee,
        oracle_id: 0x2::object::ID,
        oracle_limits: 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::oracle_limits::OracleLimits,
        extra_storage: 0x2::object::UID,
    }

    public(friend) fun decimals<T0>(arg0: &CollateralConfig<T0>) : u8 {
        arg0.decimals
    }

    public fun new<T0>(arg0: &0x2::coin_registry::Currency<T0>, arg1: 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limits::Limits, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: &0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::aggregated_oracle::AggregatedOracle, arg7: 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::collateral_fee::CollateralFee, arg8: &mut 0x2::tx_context::TxContext) : CollateralConfig<T0> {
        CollateralConfig<T0>{
            enabled           : false,
            custodian_address : arg2,
            redeem_balance    : 0x2::balance::zero<T0>(),
            limiter           : 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limiter::new(arg1),
            decimals          : 0x2::coin_registry::decimals<T0>(arg0),
            default_fee       : arg7,
            oracle_id         : 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::aggregated_oracle::id(arg6),
            oracle_limits     : 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::oracle_limits::new(arg3, arg4, arg5),
            extra_storage     : 0x2::object::new(arg8),
        }
    }

    public(friend) fun assert_is_enabled<T0>(arg0: &CollateralConfig<T0>) {
        assert!(arg0.enabled, 13835340080014688257);
    }

    public(friend) fun custodian_address<T0>(arg0: &CollateralConfig<T0>) : address {
        arg0.custodian_address
    }

    public(friend) fun default_fee<T0>(arg0: &CollateralConfig<T0>) : 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::collateral_fee::CollateralFee {
        arg0.default_fee
    }

    public(friend) fun destroy<T0>(arg0: CollateralConfig<T0>) {
        let CollateralConfig {
            enabled           : _,
            custodian_address : _,
            redeem_balance    : v2,
            limiter           : _,
            decimals          : _,
            default_fee       : _,
            oracle_id         : _,
            oracle_limits     : _,
            extra_storage     : v8,
        } = arg0;
        0x2::balance::destroy_zero<T0>(v2);
        0x2::object::delete(v8);
    }

    public(friend) fun is_enabled<T0>(arg0: &CollateralConfig<T0>) : bool {
        arg0.enabled
    }

    public(friend) fun limiter<T0>(arg0: &CollateralConfig<T0>) : &0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limiter::Limiter {
        &arg0.limiter
    }

    public(friend) fun limiter_mut<T0>(arg0: &mut CollateralConfig<T0>) : &mut 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limiter::Limiter {
        &mut arg0.limiter
    }

    public(friend) fun max_age_ms<T0>(arg0: &CollateralConfig<T0>) : u64 {
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::oracle_limits::max_age_ms(&arg0.oracle_limits)
    }

    public(friend) fun max_oracle_price<T0>(arg0: &CollateralConfig<T0>) : u64 {
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::oracle_limits::max_price(&arg0.oracle_limits)
    }

    public(friend) fun min_oracle_price<T0>(arg0: &CollateralConfig<T0>) : u64 {
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::oracle_limits::min_price(&arg0.oracle_limits)
    }

    public(friend) fun oracle_id<T0>(arg0: &CollateralConfig<T0>) : 0x2::object::ID {
        arg0.oracle_id
    }

    public(friend) fun oracle_limits<T0>(arg0: &CollateralConfig<T0>) : &0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::oracle_limits::OracleLimits {
        &arg0.oracle_limits
    }

    public(friend) fun oracle_limits_mut<T0>(arg0: &mut CollateralConfig<T0>) : &mut 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::oracle_limits::OracleLimits {
        &mut arg0.oracle_limits
    }

    public(friend) fun redeem_balance_mut<T0>(arg0: &mut CollateralConfig<T0>) : &mut 0x2::balance::Balance<T0> {
        &mut arg0.redeem_balance
    }

    public(friend) fun set_custodian_address<T0>(arg0: &mut CollateralConfig<T0>, arg1: address) {
        arg0.custodian_address = arg1;
    }

    public(friend) fun set_default_fees<T0>(arg0: &mut CollateralConfig<T0>, arg1: 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::collateral_fee::CollateralFee) {
        arg0.default_fee = arg1;
    }

    public(friend) fun set_enabled<T0>(arg0: &mut CollateralConfig<T0>, arg1: bool) {
        arg0.enabled = arg1;
    }

    public(friend) fun set_oracle<T0>(arg0: &mut CollateralConfig<T0>, arg1: &0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::aggregated_oracle::AggregatedOracle) {
        arg0.oracle_id = 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::aggregated_oracle::id(arg1);
    }

    // decompiled from Move bytecode v6
}

