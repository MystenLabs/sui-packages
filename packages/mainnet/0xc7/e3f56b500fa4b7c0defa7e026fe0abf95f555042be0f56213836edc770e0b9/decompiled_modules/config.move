module 0xc7e3f56b500fa4b7c0defa7e026fe0abf95f555042be0f56213836edc770e0b9::config {
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
        target_adapter: 0x1::ascii::String,
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

    public(friend) fun new_drift_config(arg0: 0x1::ascii::String, arg1: u128) : Config<Drift> {
        let v0 = Drift{
            target_adapter               : arg0,
            upper_trigger_price          : 0,
            upper_trigger_price_scalling : arg1,
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

    public(friend) fun set_drift_trigger_price(arg0: &mut Config<Drift>, arg1: u128) {
        arg0.t.upper_trigger_price = arg1;
    }

    public(friend) fun set_target_adapter(arg0: &mut Config<Drift>, arg1: 0x1::ascii::String) {
        arg0.t.target_adapter = arg1;
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

    public fun target_adapter(arg0: &Config<Drift>) : 0x1::ascii::String {
        arg0.t.target_adapter
    }

    // decompiled from Move bytecode v6
}

