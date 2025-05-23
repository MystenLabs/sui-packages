module 0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::payouts {
    struct Payout has copy, drop, store {
        shares: 0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::float::Float,
        minimum: u64,
    }

    struct PayoutsConfig has copy, drop, store {
        inner: 0x2::vec_map::VecMap<0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::combination::Combination, Payout>,
    }

    public fun add(arg0: &Payout, arg1: &Payout) : Payout {
        Payout{
            shares  : 0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::float::add(arg0.shares, arg1.shares),
            minimum : arg0.minimum + arg1.minimum,
        }
    }

    public fun adjust_payouts(arg0: &mut PayoutsConfig, arg1: &0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::combination::Combination) {
        let (v0, v1) = lower_sum(arg0, arg1);
        let v2 = v1;
        let v3 = 0x2::vec_map::get_mut<0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::combination::Combination, Payout>(&mut arg0.inner, arg1);
        let v4 = add(&v2, v3);
        let v5 = if (0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::float::gt(v2.shares, 0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::float::zero())) {
            v3.shares = 0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::float::zero();
            0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::float::div(v4.shares, v2.shares)
        } else {
            0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::float::one()
        };
        let v6 = if (v2.minimum > 0) {
            v3.minimum = 0;
            0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::float::from_fraction(v4.minimum, v2.minimum)
        } else {
            0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::float::one()
        };
        let v7 = 0;
        while (v7 < v0) {
            let (_, v9) = 0x2::vec_map::get_entry_by_idx_mut<0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::combination::Combination, Payout>(&mut arg0.inner, v7);
            v9.shares = 0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::float::mul(v5, v9.shares);
            v9.minimum = 0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::float::floor(0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::float::mul_u64(v6, v9.minimum));
            v7 = v7 + 1;
        };
    }

    fun err_combination_not_found() {
        abort 1
    }

    fun err_invalid_payout_settings() {
        abort 0
    }

    public fun get_payout_amount(arg0: &Payout, arg1: u64) : u64 {
        0x1::u64::max(0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::float::floor(0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::float::mul_u64(arg0.shares, arg1)), arg0.minimum)
    }

    public fun inner(arg0: &PayoutsConfig) : &0x2::vec_map::VecMap<0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::combination::Combination, Payout> {
        &arg0.inner
    }

    public fun lower_sum(arg0: &PayoutsConfig, arg1: &0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::combination::Combination) : (u64, Payout) {
        let v0 = &arg0.inner;
        let v1 = 0x2::vec_map::get_idx_opt<0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::combination::Combination, Payout>(v0, arg1);
        if (0x1::option::is_none<u64>(&v1)) {
            err_combination_not_found();
        };
        let v2 = 0x1::option::destroy_some<u64>(v1);
        let v3 = zero_payout();
        let v4 = 0;
        while (v4 < v2) {
            let (_, v6) = 0x2::vec_map::get_entry_by_idx<0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::combination::Combination, Payout>(v0, v4);
            let v7 = &v3;
            v3 = add(v7, v6);
            v4 = v4 + 1;
        };
        (v2, v3)
    }

    public fun minimum(arg0: &Payout) : u64 {
        arg0.minimum
    }

    public fun new_config(arg0: 0x2::vec_map::VecMap<0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::combination::Combination, Payout>) : PayoutsConfig {
        let v0 = PayoutsConfig{inner: arg0};
        let v1 = sum(&v0);
        if (shares(&v1) != 0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::float::one()) {
            err_invalid_payout_settings();
        };
        v0
    }

    public fun new_payout(arg0: 0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::float::Float, arg1: u64) : Payout {
        Payout{
            shares  : arg0,
            minimum : arg1,
        }
    }

    public fun shares(arg0: &Payout) : 0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::float::Float {
        arg0.shares
    }

    public fun sum(arg0: &PayoutsConfig) : Payout {
        let v0 = inner(arg0);
        let v1 = zero_payout();
        let v2 = 0x2::vec_map::keys<0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::combination::Combination, Payout>(v0);
        0x1::vector::reverse<0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::combination::Combination>(&mut v2);
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::combination::Combination>(&v2)) {
            let v4 = v1;
            let v5 = 0x1::vector::pop_back<0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::combination::Combination>(&mut v2);
            v1 = add(&v4, 0x2::vec_map::get<0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::combination::Combination, Payout>(v0, &v5));
            v3 = v3 + 1;
        };
        0x1::vector::destroy_empty<0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::combination::Combination>(v2);
        v1
    }

    public fun zero_payout() : Payout {
        Payout{
            shares  : 0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::float::zero(),
            minimum : 0,
        }
    }

    // decompiled from Move bytecode v6
}

