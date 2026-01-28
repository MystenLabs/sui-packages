module 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limiter {
    struct Limiter has copy, drop, store {
        epoch_counter: 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::counter::Counter,
        period_counter: 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::counter::Counter,
        limits: 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limits::Limits,
    }

    public(friend) fun add_mint(arg0: &mut Limiter, arg1: u64, arg2: &0x2::clock::Clock, arg3: u64, arg4: u64, arg5: 0x1::option::Option<0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limits::Limits>) {
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::counter::rollover_if_needed(&mut arg0.epoch_counter, arg2, arg3);
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::counter::rollover_if_needed(&mut arg0.period_counter, arg2, arg4);
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::counter::add_mint(&mut arg0.epoch_counter, arg1);
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::counter::add_mint(&mut arg0.period_counter, arg1);
        let v0 = if (0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limit::max_mint(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limits::epoch(&arg0.limits)) == 0) {
            assert!(0x1::option::is_some<0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limits::Limits>(&arg5), 13836465679274344457);
            let v1 = 0x1::option::destroy_some<0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limits::Limits>(arg5);
            0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limit::max_mint(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limits::epoch(&v1))
        } else {
            0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limit::max_mint(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limits::epoch(&arg0.limits))
        };
        let v2 = if (0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limit::max_mint(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limits::period(&arg0.limits)) == 0) {
            assert!(0x1::option::is_some<0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limits::Limits>(&arg5), 13836465709339115529);
            let v3 = 0x1::option::destroy_some<0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limits::Limits>(arg5);
            0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limit::max_mint(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limits::period(&v3))
        } else {
            0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limit::max_mint(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limits::period(&arg0.limits))
        };
        assert!(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::counter::minted(&arg0.epoch_counter) <= v0, 13835339835201552385);
        assert!(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::counter::minted(&arg0.period_counter) <= v2, 13835621314473361411);
    }

    public(friend) fun add_redeem(arg0: &mut Limiter, arg1: u64, arg2: &0x2::clock::Clock, arg3: u64, arg4: u64, arg5: 0x1::option::Option<0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limits::Limits>) {
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::counter::rollover_if_needed(&mut arg0.epoch_counter, arg2, arg3);
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::counter::rollover_if_needed(&mut arg0.period_counter, arg2, arg4);
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::counter::add_redeem(&mut arg0.epoch_counter, arg1);
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::counter::add_redeem(&mut arg0.period_counter, arg1);
        let v0 = if (0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limit::max_redeem(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limits::epoch(&arg0.limits)) == 0) {
            assert!(0x1::option::is_some<0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limits::Limits>(&arg5), 13836465821008265225);
            let v1 = 0x1::option::destroy_some<0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limits::Limits>(arg5);
            0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limit::max_redeem(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limits::epoch(&v1))
        } else {
            0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limit::max_redeem(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limits::epoch(&arg0.limits))
        };
        let v2 = if (0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limit::max_redeem(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limits::period(&arg0.limits)) == 0) {
            assert!(0x1::option::is_some<0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limits::Limits>(&arg5), 13836465851073036297);
            let v3 = 0x1::option::destroy_some<0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limits::Limits>(arg5);
            0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limit::max_redeem(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limits::period(&v3))
        } else {
            0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limit::max_redeem(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limits::period(&arg0.limits))
        };
        assert!(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::counter::redeemed(&arg0.epoch_counter) <= v0, 13835902926889156613);
        assert!(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::counter::redeemed(&arg0.period_counter) <= v2, 13836184406160965639);
    }

    public(friend) fun limits(arg0: &Limiter) : &0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limits::Limits {
        &arg0.limits
    }

    public(friend) fun epoch_counter(arg0: &Limiter) : &0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::counter::Counter {
        &arg0.epoch_counter
    }

    public(friend) fun limits_mut(arg0: &mut Limiter) : &mut 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limits::Limits {
        &mut arg0.limits
    }

    public(friend) fun new(arg0: 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limits::Limits) : Limiter {
        Limiter{
            epoch_counter  : 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::counter::default(),
            period_counter : 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::counter::default(),
            limits         : arg0,
        }
    }

    public(friend) fun period_counter(arg0: &Limiter) : &0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::counter::Counter {
        &arg0.period_counter
    }

    public(friend) fun set_epoch_limits(arg0: &mut Limiter, arg1: 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limit::Limit) {
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limits::set_epoch_limit(&mut arg0.limits, arg1);
    }

    public(friend) fun set_period_limits(arg0: &mut Limiter, arg1: 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limit::Limit) {
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limits::set_period_limit(&mut arg0.limits, arg1);
    }

    // decompiled from Move bytecode v6
}

