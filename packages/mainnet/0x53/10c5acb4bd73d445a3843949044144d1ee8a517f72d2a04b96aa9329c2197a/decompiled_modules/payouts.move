module 0x5310c5acb4bd73d445a3843949044144d1ee8a517f72d2a04b96aa9329c2197a::payouts {
    struct Payout has copy, drop, store {
        shares: 0x5310c5acb4bd73d445a3843949044144d1ee8a517f72d2a04b96aa9329c2197a::float::Float,
        minimum: u64,
    }

    struct PayoutsConfig has copy, drop, store {
        inner: 0x2::vec_map::VecMap<0x5310c5acb4bd73d445a3843949044144d1ee8a517f72d2a04b96aa9329c2197a::combination::Combination, Payout>,
    }

    public fun add(arg0: &Payout, arg1: &Payout) : Payout {
        Payout{
            shares  : 0x5310c5acb4bd73d445a3843949044144d1ee8a517f72d2a04b96aa9329c2197a::float::add(arg0.shares, arg1.shares),
            minimum : arg0.minimum + arg1.minimum,
        }
    }

    public fun adjust_payouts(arg0: &mut PayoutsConfig, arg1: &0x5310c5acb4bd73d445a3843949044144d1ee8a517f72d2a04b96aa9329c2197a::combination::Combination) {
        let (v0, v1) = lower_sum(arg0, arg1);
        let v2 = v1;
        let v3 = 0x2::vec_map::get_mut<0x5310c5acb4bd73d445a3843949044144d1ee8a517f72d2a04b96aa9329c2197a::combination::Combination, Payout>(&mut arg0.inner, arg1);
        let v4 = add(&v2, v3);
        let v5 = if (0x5310c5acb4bd73d445a3843949044144d1ee8a517f72d2a04b96aa9329c2197a::float::gt(v2.shares, 0x5310c5acb4bd73d445a3843949044144d1ee8a517f72d2a04b96aa9329c2197a::float::zero())) {
            v3.shares = 0x5310c5acb4bd73d445a3843949044144d1ee8a517f72d2a04b96aa9329c2197a::float::zero();
            0x5310c5acb4bd73d445a3843949044144d1ee8a517f72d2a04b96aa9329c2197a::float::div(v4.shares, v2.shares)
        } else {
            0x5310c5acb4bd73d445a3843949044144d1ee8a517f72d2a04b96aa9329c2197a::float::one()
        };
        let v6 = if (v2.minimum > 0) {
            v3.minimum = 0;
            0x5310c5acb4bd73d445a3843949044144d1ee8a517f72d2a04b96aa9329c2197a::float::from_fraction(v4.minimum, v2.minimum)
        } else {
            0x5310c5acb4bd73d445a3843949044144d1ee8a517f72d2a04b96aa9329c2197a::float::one()
        };
        let v7 = 0;
        while (v7 < v0) {
            let (_, v9) = 0x2::vec_map::get_entry_by_idx_mut<0x5310c5acb4bd73d445a3843949044144d1ee8a517f72d2a04b96aa9329c2197a::combination::Combination, Payout>(&mut arg0.inner, v7);
            v9.shares = 0x5310c5acb4bd73d445a3843949044144d1ee8a517f72d2a04b96aa9329c2197a::float::mul(v5, v9.shares);
            v9.minimum = 0x5310c5acb4bd73d445a3843949044144d1ee8a517f72d2a04b96aa9329c2197a::float::floor(0x5310c5acb4bd73d445a3843949044144d1ee8a517f72d2a04b96aa9329c2197a::float::mul_u64(v6, v9.minimum));
            v7 = v7 + 1;
        };
    }

    public fun default() : PayoutsConfig {
        let v0 = 0x2::vec_map::empty<0x5310c5acb4bd73d445a3843949044144d1ee8a517f72d2a04b96aa9329c2197a::combination::Combination, Payout>();
        0x2::vec_map::insert<0x5310c5acb4bd73d445a3843949044144d1ee8a517f72d2a04b96aa9329c2197a::combination::Combination, Payout>(&mut v0, 0x5310c5acb4bd73d445a3843949044144d1ee8a517f72d2a04b96aa9329c2197a::combination::new(2, 1), new_payout(0x5310c5acb4bd73d445a3843949044144d1ee8a517f72d2a04b96aa9329c2197a::float::from_bps(25), usd(1000)));
        0x2::vec_map::insert<0x5310c5acb4bd73d445a3843949044144d1ee8a517f72d2a04b96aa9329c2197a::combination::Combination, Payout>(&mut v0, 0x5310c5acb4bd73d445a3843949044144d1ee8a517f72d2a04b96aa9329c2197a::combination::new(2, 2), new_payout(0x5310c5acb4bd73d445a3843949044144d1ee8a517f72d2a04b96aa9329c2197a::float::from_bps(75), usd(1500)));
        0x2::vec_map::insert<0x5310c5acb4bd73d445a3843949044144d1ee8a517f72d2a04b96aa9329c2197a::combination::Combination, Payout>(&mut v0, 0x5310c5acb4bd73d445a3843949044144d1ee8a517f72d2a04b96aa9329c2197a::combination::new(3, 0), new_payout(0x5310c5acb4bd73d445a3843949044144d1ee8a517f72d2a04b96aa9329c2197a::float::from_bps(200), usd(2000)));
        0x2::vec_map::insert<0x5310c5acb4bd73d445a3843949044144d1ee8a517f72d2a04b96aa9329c2197a::combination::Combination, Payout>(&mut v0, 0x5310c5acb4bd73d445a3843949044144d1ee8a517f72d2a04b96aa9329c2197a::combination::new(3, 1), new_payout(0x5310c5acb4bd73d445a3843949044144d1ee8a517f72d2a04b96aa9329c2197a::float::from_bps(250), usd(2500)));
        0x2::vec_map::insert<0x5310c5acb4bd73d445a3843949044144d1ee8a517f72d2a04b96aa9329c2197a::combination::Combination, Payout>(&mut v0, 0x5310c5acb4bd73d445a3843949044144d1ee8a517f72d2a04b96aa9329c2197a::combination::new(3, 2), new_payout(0x5310c5acb4bd73d445a3843949044144d1ee8a517f72d2a04b96aa9329c2197a::float::from_bps(750), usd(3000)));
        0x2::vec_map::insert<0x5310c5acb4bd73d445a3843949044144d1ee8a517f72d2a04b96aa9329c2197a::combination::Combination, Payout>(&mut v0, 0x5310c5acb4bd73d445a3843949044144d1ee8a517f72d2a04b96aa9329c2197a::combination::new(4, 0), new_payout(0x5310c5acb4bd73d445a3843949044144d1ee8a517f72d2a04b96aa9329c2197a::float::from_bps(1000), usd(3500)));
        0x2::vec_map::insert<0x5310c5acb4bd73d445a3843949044144d1ee8a517f72d2a04b96aa9329c2197a::combination::Combination, Payout>(&mut v0, 0x5310c5acb4bd73d445a3843949044144d1ee8a517f72d2a04b96aa9329c2197a::combination::new(4, 1), new_payout(0x5310c5acb4bd73d445a3843949044144d1ee8a517f72d2a04b96aa9329c2197a::float::from_bps(1250), usd(4000)));
        0x2::vec_map::insert<0x5310c5acb4bd73d445a3843949044144d1ee8a517f72d2a04b96aa9329c2197a::combination::Combination, Payout>(&mut v0, 0x5310c5acb4bd73d445a3843949044144d1ee8a517f72d2a04b96aa9329c2197a::combination::new(4, 2), new_payout(0x5310c5acb4bd73d445a3843949044144d1ee8a517f72d2a04b96aa9329c2197a::float::from_bps(1500), usd(4500)));
        0x2::vec_map::insert<0x5310c5acb4bd73d445a3843949044144d1ee8a517f72d2a04b96aa9329c2197a::combination::Combination, Payout>(&mut v0, 0x5310c5acb4bd73d445a3843949044144d1ee8a517f72d2a04b96aa9329c2197a::combination::new(5, 0), new_payout(0x5310c5acb4bd73d445a3843949044144d1ee8a517f72d2a04b96aa9329c2197a::float::from_bps(2000), usd(5000)));
        0x2::vec_map::insert<0x5310c5acb4bd73d445a3843949044144d1ee8a517f72d2a04b96aa9329c2197a::combination::Combination, Payout>(&mut v0, 0x5310c5acb4bd73d445a3843949044144d1ee8a517f72d2a04b96aa9329c2197a::combination::new(5, 1), new_payout(0x5310c5acb4bd73d445a3843949044144d1ee8a517f72d2a04b96aa9329c2197a::float::from_bps(2950), usd(10000)));
        new_config(v0)
    }

    fun err_combination_not_found() {
        abort 1
    }

    fun err_invalid_payout_settings() {
        abort 0
    }

    public fun get_payout_amount(arg0: &Payout, arg1: u64) : u64 {
        0x1::u64::max(0x5310c5acb4bd73d445a3843949044144d1ee8a517f72d2a04b96aa9329c2197a::float::floor(0x5310c5acb4bd73d445a3843949044144d1ee8a517f72d2a04b96aa9329c2197a::float::mul_u64(arg0.shares, arg1)), arg0.minimum)
    }

    public fun inner(arg0: &PayoutsConfig) : &0x2::vec_map::VecMap<0x5310c5acb4bd73d445a3843949044144d1ee8a517f72d2a04b96aa9329c2197a::combination::Combination, Payout> {
        &arg0.inner
    }

    public fun lower_sum(arg0: &PayoutsConfig, arg1: &0x5310c5acb4bd73d445a3843949044144d1ee8a517f72d2a04b96aa9329c2197a::combination::Combination) : (u64, Payout) {
        let v0 = &arg0.inner;
        let v1 = 0x2::vec_map::get_idx_opt<0x5310c5acb4bd73d445a3843949044144d1ee8a517f72d2a04b96aa9329c2197a::combination::Combination, Payout>(v0, arg1);
        if (0x1::option::is_none<u64>(&v1)) {
            err_combination_not_found();
        };
        let v2 = 0x1::option::destroy_some<u64>(v1);
        let v3 = zero_payout();
        let v4 = 0;
        while (v4 < v2) {
            let (_, v6) = 0x2::vec_map::get_entry_by_idx<0x5310c5acb4bd73d445a3843949044144d1ee8a517f72d2a04b96aa9329c2197a::combination::Combination, Payout>(v0, v4);
            let v7 = &v3;
            v3 = add(v7, v6);
            v4 = v4 + 1;
        };
        (v2, v3)
    }

    public fun minimum(arg0: &Payout) : u64 {
        arg0.minimum
    }

    public fun new_config(arg0: 0x2::vec_map::VecMap<0x5310c5acb4bd73d445a3843949044144d1ee8a517f72d2a04b96aa9329c2197a::combination::Combination, Payout>) : PayoutsConfig {
        let v0 = PayoutsConfig{inner: arg0};
        let v1 = sum(&v0);
        if (shares(&v1) != 0x5310c5acb4bd73d445a3843949044144d1ee8a517f72d2a04b96aa9329c2197a::float::one()) {
            err_invalid_payout_settings();
        };
        v0
    }

    public fun new_payout(arg0: 0x5310c5acb4bd73d445a3843949044144d1ee8a517f72d2a04b96aa9329c2197a::float::Float, arg1: u64) : Payout {
        Payout{
            shares  : arg0,
            minimum : arg1,
        }
    }

    public fun shares(arg0: &Payout) : 0x5310c5acb4bd73d445a3843949044144d1ee8a517f72d2a04b96aa9329c2197a::float::Float {
        arg0.shares
    }

    public fun sum(arg0: &PayoutsConfig) : Payout {
        let v0 = inner(arg0);
        let v1 = zero_payout();
        let v2 = 0x2::vec_map::keys<0x5310c5acb4bd73d445a3843949044144d1ee8a517f72d2a04b96aa9329c2197a::combination::Combination, Payout>(v0);
        0x1::vector::reverse<0x5310c5acb4bd73d445a3843949044144d1ee8a517f72d2a04b96aa9329c2197a::combination::Combination>(&mut v2);
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x5310c5acb4bd73d445a3843949044144d1ee8a517f72d2a04b96aa9329c2197a::combination::Combination>(&v2)) {
            let v4 = v1;
            let v5 = 0x1::vector::pop_back<0x5310c5acb4bd73d445a3843949044144d1ee8a517f72d2a04b96aa9329c2197a::combination::Combination>(&mut v2);
            v1 = add(&v4, 0x2::vec_map::get<0x5310c5acb4bd73d445a3843949044144d1ee8a517f72d2a04b96aa9329c2197a::combination::Combination, Payout>(v0, &v5));
            v3 = v3 + 1;
        };
        0x1::vector::destroy_empty<0x5310c5acb4bd73d445a3843949044144d1ee8a517f72d2a04b96aa9329c2197a::combination::Combination>(v2);
        v1
    }

    public fun usd(arg0: u64) : u64 {
        arg0 * 1000000000
    }

    public fun zero_payout() : Payout {
        Payout{
            shares  : 0x5310c5acb4bd73d445a3843949044144d1ee8a517f72d2a04b96aa9329c2197a::float::zero(),
            minimum : 0,
        }
    }

    // decompiled from Move bytecode v6
}

