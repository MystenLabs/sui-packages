module 0x8f7a1ff89d48c5124d156e39f4d6451f60d148151a9a06b0248428b2601b93b1::config {
    struct Config<T0: copy + drop + store> has copy, drop, store {
        t: T0,
    }

    struct Uncorrelated has copy, drop, store {
        target_adapter: 0x1::ascii::String,
        is_target_reverse: bool,
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

    public(friend) fun get_uc_is_target_reverse(arg0: &Config<Uncorrelated>) : bool {
        arg0.t.is_target_reverse
    }

    public(friend) fun get_uc_target_adapter(arg0: &Config<Uncorrelated>) : 0x1::ascii::String {
        arg0.t.target_adapter
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

    public(friend) fun new_uncorrelated_config(arg0: 0x1::ascii::String, arg1: bool, arg2: u128, arg3: u128, arg4: u128, arg5: u128) : Config<Uncorrelated> {
        let v0 = Uncorrelated{
            target_adapter               : arg0,
            is_target_reverse            : arg1,
            lower_trigger_price          : arg2,
            upper_trigger_price          : arg3,
            upper_trigger_price_scalling : arg4,
            lower_trigger_price_scalling : arg5,
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

    public(friend) fun set_uc_is_target_reverse(arg0: &mut Config<Uncorrelated>, arg1: bool) {
        arg0.t.is_target_reverse = arg1;
    }

    public(friend) fun set_uc_target_adapter(arg0: &mut Config<Uncorrelated>, arg1: 0x1::ascii::String) {
        arg0.t.target_adapter = arg1;
    }

    public fun target_adapter(arg0: &Config<Drift>) : 0x1::ascii::String {
        arg0.t.target_adapter
    }

    // decompiled from Move bytecode v6
}

