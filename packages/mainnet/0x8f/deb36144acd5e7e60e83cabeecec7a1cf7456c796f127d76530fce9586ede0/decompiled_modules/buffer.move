module 0x203eebc39442014a1b8180f3b8ed70143dac2c5d28ba5703fe34c21052728705::buffer {
    struct Buffer<phantom T0> has store {
        balance: 0x2::balance::Balance<T0>,
        flow_rate: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::Double,
        timestamp: u64,
    }

    public fun balance<T0>(arg0: &Buffer<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun join<T0>(arg0: &mut Buffer<T0>, arg1: &0x2::clock::Clock, arg2: 0x2::balance::Balance<T0>) : 0x2::balance::Balance<T0> {
        let v0 = release<T0>(arg0, arg1);
        0x2::balance::join<T0>(&mut arg0.balance, arg2);
        v0
    }

    public fun destroy<T0>(arg0: Buffer<T0>) : 0x2::balance::Balance<T0> {
        let Buffer {
            balance   : v0,
            flow_rate : _,
            timestamp : _,
        } = arg0;
        v0
    }

    public fun flow_rate<T0>(arg0: &Buffer<T0>) : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::Double {
        arg0.flow_rate
    }

    public fun new<T0>(arg0: &0x2::clock::Clock, arg1: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::Double) : Buffer<T0> {
        Buffer<T0>{
            balance   : 0x2::balance::zero<T0>(),
            flow_rate : arg1,
            timestamp : 0x2::clock::timestamp_ms(arg0),
        }
    }

    public fun releasable_amount<T0>(arg0: &Buffer<T0>, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = timestamp<T0>(arg0);
        if (v0 > v1) {
            0x1::u64::min(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::round(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::mul_u64(flow_rate<T0>(arg0), v0 - v1)), balance<T0>(arg0))
        } else {
            0
        }
    }

    public fun release<T0>(arg0: &mut Buffer<T0>, arg1: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (arg0.timestamp < v0) {
            arg0.timestamp = v0;
        };
        0x2::balance::split<T0>(&mut arg0.balance, releasable_amount<T0>(arg0, arg1))
    }

    public fun set_flow_rate<T0>(arg0: &mut Buffer<T0>, arg1: &0x2::clock::Clock, arg2: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::Double) : 0x2::balance::Balance<T0> {
        let v0 = release<T0>(arg0, arg1);
        arg0.flow_rate = arg2;
        v0
    }

    public fun timestamp<T0>(arg0: &Buffer<T0>) : u64 {
        arg0.timestamp
    }

    // decompiled from Move bytecode v6
}

