module 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limits {
    struct Limits has copy, drop, store {
        epoch: 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limit::Limit,
        period: 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limit::Limit,
    }

    public fun new(arg0: 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limit::Limit, arg1: 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limit::Limit) : Limits {
        Limits{
            epoch  : arg0,
            period : arg1,
        }
    }

    public fun default() : Limits {
        new(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limit::new(0, 0), 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limit::new(0, 0))
    }

    public fun epoch(arg0: &Limits) : &0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limit::Limit {
        &arg0.epoch
    }

    public fun epoch_mut(arg0: &mut Limits) : &mut 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limit::Limit {
        &mut arg0.epoch
    }

    public fun period(arg0: &Limits) : &0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limit::Limit {
        &arg0.period
    }

    public fun period_mut(arg0: &mut Limits) : &mut 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limit::Limit {
        &mut arg0.period
    }

    public fun set_epoch_limit(arg0: &mut Limits, arg1: 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limit::Limit) {
        arg0.epoch = arg1;
    }

    public fun set_period_limit(arg0: &mut Limits, arg1: 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limit::Limit) {
        arg0.period = arg1;
    }

    // decompiled from Move bytecode v6
}

