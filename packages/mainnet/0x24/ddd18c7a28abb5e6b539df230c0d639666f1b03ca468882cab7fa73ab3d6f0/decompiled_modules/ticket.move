module 0x24ddd18c7a28abb5e6b539df230c0d639666f1b03ca468882cab7fa73ab3d6f0::ticket {
    struct ExecTicket {
        order_id: address,
        amount_borrowed: u64,
        amount_in_max: u64,
        execution_time: u64,
        cycle_number: u64,
        scheduled_time: u64,
        window_end: u64,
        inflight_started_at: u64,
    }

    public fun destroy_exec_ticket(arg0: ExecTicket) : (address, u64, u64, u64, u64, u64, u64, u64) {
        let ExecTicket {
            order_id            : v0,
            amount_borrowed     : v1,
            amount_in_max       : v2,
            execution_time      : v3,
            cycle_number        : v4,
            scheduled_time      : v5,
            window_end          : v6,
            inflight_started_at : v7,
        } = arg0;
        (v0, v1, v2, v3, v4, v5, v6, v7)
    }

    public fun get_amount_borrowed(arg0: &ExecTicket) : u64 {
        arg0.amount_borrowed
    }

    public fun get_amount_in_max(arg0: &ExecTicket) : u64 {
        arg0.amount_in_max
    }

    public fun get_cycle_number(arg0: &ExecTicket) : u64 {
        arg0.cycle_number
    }

    public fun get_execution_time(arg0: &ExecTicket) : u64 {
        arg0.execution_time
    }

    public fun get_inflight_started_at(arg0: &ExecTicket) : u64 {
        arg0.inflight_started_at
    }

    public fun get_order_id(arg0: &ExecTicket) : address {
        arg0.order_id
    }

    public fun get_scheduled_time(arg0: &ExecTicket) : u64 {
        arg0.scheduled_time
    }

    public fun get_window_end(arg0: &ExecTicket) : u64 {
        arg0.window_end
    }

    public(friend) fun new_exec_ticket(arg0: address, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) : ExecTicket {
        ExecTicket{
            order_id            : arg0,
            amount_borrowed     : arg1,
            amount_in_max       : arg2,
            execution_time      : arg3,
            cycle_number        : arg4,
            scheduled_time      : arg5,
            window_end          : arg6,
            inflight_started_at : arg7,
        }
    }

    // decompiled from Move bytecode v6
}

