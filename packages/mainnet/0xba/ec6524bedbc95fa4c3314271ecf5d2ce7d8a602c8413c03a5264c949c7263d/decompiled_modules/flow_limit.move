module 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::flow_limit {
    struct FlowLimit has copy, drop, store {
        flow_limit: 0x1::option::Option<u64>,
        flow_in: u128,
        flow_out: u128,
        current_epoch: u64,
    }

    public(friend) fun add_flow_in(arg0: &mut FlowLimit, arg1: u64, arg2: &0x2::clock::Clock) {
        if (0x1::option::is_none<u64>(&arg0.flow_limit)) {
            return
        };
        let v0 = (*0x1::option::borrow<u64>(&arg0.flow_limit) as u128);
        update_epoch(arg0, arg2);
        assert!(arg0.flow_in + (arg1 as u128) < v0 + arg0.flow_out, 13906834350437105666);
        arg0.flow_in = arg0.flow_in + (arg1 as u128);
    }

    public(friend) fun add_flow_out(arg0: &mut FlowLimit, arg1: u64, arg2: &0x2::clock::Clock) {
        if (0x1::option::is_none<u64>(&arg0.flow_limit)) {
            return
        };
        let v0 = (*0x1::option::borrow<u64>(&arg0.flow_limit) as u128);
        update_epoch(arg0, arg2);
        assert!(arg0.flow_out + (arg1 as u128) < v0 + arg0.flow_in, 13906834397681745922);
        arg0.flow_out = arg0.flow_out + (arg1 as u128);
    }

    public(friend) fun new() : FlowLimit {
        FlowLimit{
            flow_limit    : 0x1::option::none<u64>(),
            flow_in       : 0,
            flow_out      : 0,
            current_epoch : 0,
        }
    }

    public(friend) fun set_flow_limit(arg0: &mut FlowLimit, arg1: 0x1::option::Option<u64>) {
        arg0.flow_limit = arg1;
    }

    fun update_epoch(arg0: &mut FlowLimit, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1) / 21600000;
        if (v0 > arg0.current_epoch) {
            arg0.current_epoch = v0;
            arg0.flow_in = 0;
            arg0.flow_out = 0;
        };
    }

    // decompiled from Move bytecode v6
}

