module 0x21b786ef3d4eeea87c42f4e6dcaa6692225c0a1f38bdba0f006d25ef7ab7c93e::stake_model {
    struct StakeModel has store, key {
        id: 0x2::object::UID,
        lock_period_in_days: u64,
        apr_numerator: u64,
        apr_denominator: u64,
        active: bool,
    }

    public fun new(arg0: u64, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : StakeModel {
        assert!(arg2 > 0, 201);
        StakeModel{
            id                  : 0x2::object::new(arg3),
            lock_period_in_days : arg0,
            apr_numerator       : arg1,
            apr_denominator     : arg2,
            active              : true,
        }
    }

    public fun apr_denominator(arg0: &StakeModel) : u64 {
        arg0.apr_denominator
    }

    public fun apr_numerator(arg0: &StakeModel) : u64 {
        arg0.apr_numerator
    }

    public fun assert_is_active(arg0: &StakeModel) {
        assert!(is_active(arg0), 204);
    }

    public fun assert_is_unlocked(arg0: &StakeModel, arg1: u64, arg2: &0x2::clock::Clock) {
        assert!(is_unlocked(arg0, arg1, arg2), 203);
    }

    public fun calculate_reward(arg0: &StakeModel, arg1: u64) : u64 {
        mul_div(mul_div(arg1, arg0.apr_numerator, arg0.apr_denominator), arg0.lock_period_in_days, 365)
    }

    public fun is_active(arg0: &StakeModel) : bool {
        arg0.active
    }

    public fun is_unlocked(arg0: &StakeModel, arg1: u64, arg2: &0x2::clock::Clock) : bool {
        arg1 - 0x2::clock::timestamp_ms(arg2) / 1000 >= arg0.lock_period_in_days * 86400
    }

    public fun lock_period_in_days(arg0: &StakeModel) : u64 {
        arg0.lock_period_in_days
    }

    fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg0 as u128) * (arg1 as u128) / (arg2 as u128);
        assert!(v0 <= 18446744073709551615, 202);
        (v0 as u64)
    }

    public fun set_active_status(arg0: &mut StakeModel, arg1: bool) {
        arg0.active = arg1;
    }

    // decompiled from Move bytecode v6
}

