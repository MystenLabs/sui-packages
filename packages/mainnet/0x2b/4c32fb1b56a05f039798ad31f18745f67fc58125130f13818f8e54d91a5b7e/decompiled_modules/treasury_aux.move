module 0x2b4c32fb1b56a05f039798ad31f18745f67fc58125130f13818f8e54d91a5b7e::treasury_aux {
    struct TreasuryAux has store, key {
        id: 0x2::object::UID,
        last_exec_ms: u64,
        burned_today: u64,
        last_burn_day_utc: u64,
        tvyn_for_lp: u64,
    }

    public(friend) fun add_to_tvyn_for_lp(arg0: &mut TreasuryAux, arg1: u64) {
        arg0.tvyn_for_lp = arg0.tvyn_for_lp + arg1;
    }

    public fun burned_today(arg0: &TreasuryAux) : u64 {
        arg0.burned_today
    }

    public entry fun create_and_share(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TreasuryAux{
            id                : 0x2::object::new(arg0),
            last_exec_ms      : 0,
            burned_today      : 0,
            last_burn_day_utc : 0,
            tvyn_for_lp       : 0,
        };
        0x2::transfer::share_object<TreasuryAux>(v0);
    }

    public fun last_burn_day_utc(arg0: &TreasuryAux) : u64 {
        arg0.last_burn_day_utc
    }

    public fun last_exec_ms(arg0: &TreasuryAux) : u64 {
        arg0.last_exec_ms
    }

    public(friend) fun maybe_reset_daily_burn(arg0: &mut TreasuryAux, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1) / 86400000;
        if (v0 > arg0.last_burn_day_utc) {
            arg0.burned_today = 0;
            arg0.last_burn_day_utc = v0;
        };
    }

    public(friend) fun set_burned_today(arg0: &mut TreasuryAux, arg1: u64) {
        arg0.burned_today = arg1;
    }

    public(friend) fun set_last_burn_day_utc(arg0: &mut TreasuryAux, arg1: u64) {
        arg0.last_burn_day_utc = arg1;
    }

    public(friend) fun set_last_exec_ms(arg0: &mut TreasuryAux, arg1: u64) {
        arg0.last_exec_ms = arg1;
    }

    public fun tvyn_for_lp(arg0: &TreasuryAux) : u64 {
        arg0.tvyn_for_lp
    }

    // decompiled from Move bytecode v6
}

