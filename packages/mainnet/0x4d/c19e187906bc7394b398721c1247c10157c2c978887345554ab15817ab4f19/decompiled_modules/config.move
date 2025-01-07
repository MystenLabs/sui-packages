module 0x4dc19e187906bc7394b398721c1247c10157c2c978887345554ab15817ab4f19::config {
    struct Config<T0: copy + drop + store> has copy, drop, store {
        t: T0,
    }

    struct Uncorrelated has copy, drop, store {
        lower_trigger_price: u128,
        upper_trigger_price: u128,
        upper_trigger_price_scalling: u128,
        lower_trigger_price_scalling: u128,
    }

    struct Stable has copy, drop, store {
        dummy_field: bool,
    }

    struct Drift has copy, drop, store {
        rebalance_adapter: u8,
        min_elapsed_time: u64,
        upper_trigger_price: u128,
        upper_trigger_price_scalling: u128,
    }

    public fun drift_trigger_price(arg0: &Config<Drift>) : u128 {
        arg0.t.upper_trigger_price
    }

    public fun drift_trigger_price_scalling(arg0: &Config<Drift>) : u128 {
        arg0.t.upper_trigger_price_scalling
    }

    public(friend) fun get_trigger_price(arg0: &Config<Uncorrelated>) : (u128, u128) {
        let v0 = &arg0.t;
        (v0.lower_trigger_price, v0.upper_trigger_price)
    }

    public(friend) fun get_trigger_price_scalling(arg0: &Config<Uncorrelated>) : (u128, u128) {
        let v0 = &arg0.t;
        (v0.lower_trigger_price_scalling, v0.upper_trigger_price_scalling)
    }

    public fun min_elapsed_time(arg0: &Config<Drift>) : u64 {
        arg0.t.min_elapsed_time
    }

    public(friend) fun new_drift_config(arg0: u8, arg1: u64, arg2: u128) : Config<Drift> {
        let v0 = Drift{
            rebalance_adapter            : arg0,
            min_elapsed_time             : arg1,
            upper_trigger_price          : 0,
            upper_trigger_price_scalling : arg2,
        };
        Config<Drift>{t: v0}
    }

    public(friend) fun new_stable_config() : Config<Stable> {
        let v0 = Stable{dummy_field: false};
        Config<Stable>{t: v0}
    }

    public(friend) fun new_uncorrelated_config(arg0: u128, arg1: u128, arg2: u128, arg3: u128) : Config<Uncorrelated> {
        let v0 = Uncorrelated{
            lower_trigger_price          : arg0,
            upper_trigger_price          : arg1,
            upper_trigger_price_scalling : arg2,
            lower_trigger_price_scalling : arg3,
        };
        Config<Uncorrelated>{t: v0}
    }

    public fun rebalance_adapter(arg0: &Config<Drift>) : u8 {
        arg0.t.rebalance_adapter
    }

    public fun set_drift_trigger_price(arg0: &mut Config<Drift>, arg1: u128) {
        arg0.t.upper_trigger_price = arg1;
    }

    public(friend) fun set_trigger_price(arg0: &mut Config<Uncorrelated>, arg1: u128, arg2: u128) {
        let v0 = &mut arg0.t;
        v0.lower_trigger_price = arg1;
        v0.upper_trigger_price = arg2;
    }

    public(friend) fun set_trigger_price_scalling(arg0: &mut Config<Uncorrelated>, arg1: u128, arg2: u128) {
        let v0 = &mut arg0.t;
        v0.lower_trigger_price_scalling = arg1;
        v0.upper_trigger_price_scalling = arg2;
    }

    // decompiled from Move bytecode v6
}

