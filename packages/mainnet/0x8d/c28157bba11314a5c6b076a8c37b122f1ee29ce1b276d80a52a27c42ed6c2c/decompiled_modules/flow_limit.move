module 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::flow_limit {
    struct FlowLimit has copy, drop, store {
        flow_limit: u64,
        flow_in: u128,
        flow_out: u128,
        current_epoch: u64,
    }

    public(friend) fun add_flow_in(arg0: &mut FlowLimit, arg1: u64, arg2: &0x2::clock::Clock) {
        if (arg0.flow_limit == 0) {
            return
        };
        update_epoch(arg0, arg2);
        assert!(arg0.flow_in + (arg1 as u128) < (arg0.flow_limit as u128) + arg0.flow_out, 9223372230128369666);
        arg0.flow_in = arg0.flow_in + (arg1 as u128);
    }

    public(friend) fun add_flow_out(arg0: &mut FlowLimit, arg1: u64, arg2: &0x2::clock::Clock) {
        if (arg0.flow_limit == 0) {
            return
        };
        update_epoch(arg0, arg2);
        assert!(arg0.flow_out + (arg1 as u128) < (arg0.flow_limit as u128) + arg0.flow_in, 9223372294552879106);
        arg0.flow_out = arg0.flow_out + (arg1 as u128);
    }

    public(friend) fun new() : FlowLimit {
        FlowLimit{
            flow_limit    : 0,
            flow_in       : 0,
            flow_out      : 0,
            current_epoch : 0,
        }
    }

    public(friend) fun set_flow_limit(arg0: &mut FlowLimit, arg1: u64) {
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

