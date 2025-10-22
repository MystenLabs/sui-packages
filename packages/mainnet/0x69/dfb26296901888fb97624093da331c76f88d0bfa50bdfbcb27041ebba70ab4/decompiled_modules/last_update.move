module 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::last_update {
    struct LastUpdate has store {
        timestamp_ms: u64,
        stale: bool,
        price_status: u8,
    }

    public(friend) fun all_checks() : u8 {
        63
    }

    public(friend) fun elapsed_ms(arg0: &LastUpdate, arg1: u64) : u64 {
        if (arg1 < arg0.timestamp_ms) {
            abort 1
        };
        arg1 - arg0.timestamp_ms
    }

    public(friend) fun is_stale(arg0: &LastUpdate, arg1: u64) : bool {
        if (arg0.stale) {
            if (elapsed_ms(arg0, arg1) > 1) {
                arg0.price_status != 63
            } else {
                false
            }
        } else {
            false
        }
    }

    public(friend) fun mark_stale(arg0: &mut LastUpdate) {
        arg0.stale = true;
    }

    public(friend) fun new(arg0: u64) : LastUpdate {
        LastUpdate{
            timestamp_ms : arg0,
            stale        : true,
            price_status : 0,
        }
    }

    public(friend) fun none() : u8 {
        0
    }

    public(friend) fun price_status(arg0: &LastUpdate) : u8 {
        arg0.price_status
    }

    public(friend) fun update(arg0: &mut LastUpdate, arg1: u64, arg2: u8) {
        arg0.timestamp_ms = arg1;
        arg0.price_status = arg2;
        arg0.stale = false;
    }

    // decompiled from Move bytecode v6
}

