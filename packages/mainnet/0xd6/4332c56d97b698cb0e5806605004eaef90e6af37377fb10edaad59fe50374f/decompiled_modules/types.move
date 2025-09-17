module 0xd09b5bb720c8ade7ef02207b8db1736974eaabd1d0163c52607ac87dc7ba8d8d::types {
    struct ExecTicket {
        order_id: address,
        amount_borrowed: u64,
        amount_in_max: u64,
        execution_time: u64,
        cycle_number: u64,
        fee_collected: u64,
        scheduled_time: u64,
        window_end: u64,
        inflight_started_at: u64,
    }

    struct LoanTicket<phantom T0> {
        meta: ExecTicket,
        in_balance: 0x2::balance::Balance<T0>,
    }

    public fun destroy_exec_ticket(arg0: ExecTicket) : (address, u64, u64, u64, u64, u64, u64, u64, u64) {
        let ExecTicket {
            order_id            : v0,
            amount_borrowed     : v1,
            amount_in_max       : v2,
            execution_time      : v3,
            cycle_number        : v4,
            fee_collected       : v5,
            scheduled_time      : v6,
            window_end          : v7,
            inflight_started_at : v8,
        } = arg0;
        (v0, v1, v2, v3, v4, v5, v6, v7, v8)
    }

    public fun destroy_loan_ticket<T0>(arg0: LoanTicket<T0>) : (ExecTicket, 0x2::balance::Balance<T0>) {
        let LoanTicket {
            meta       : v0,
            in_balance : v1,
        } = arg0;
        (v0, v1)
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

    public fun get_fee_collected(arg0: &ExecTicket) : u64 {
        arg0.fee_collected
    }

    public fun get_in_balance<T0>(arg0: &LoanTicket<T0>) : &0x2::balance::Balance<T0> {
        &arg0.in_balance
    }

    public fun get_in_balance_mut<T0>(arg0: &mut LoanTicket<T0>) : &mut 0x2::balance::Balance<T0> {
        &mut arg0.in_balance
    }

    public fun get_inflight_started_at(arg0: &ExecTicket) : u64 {
        arg0.inflight_started_at
    }

    public fun get_meta<T0>(arg0: &LoanTicket<T0>) : &ExecTicket {
        &arg0.meta
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

    public(friend) fun new_exec_ticket(arg0: address, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64) : ExecTicket {
        ExecTicket{
            order_id            : arg0,
            amount_borrowed     : arg1,
            amount_in_max       : arg2,
            execution_time      : arg3,
            cycle_number        : arg4,
            fee_collected       : arg5,
            scheduled_time      : arg6,
            window_end          : arg7,
            inflight_started_at : arg8,
        }
    }

    public(friend) fun new_loan_ticket<T0>(arg0: ExecTicket, arg1: 0x2::balance::Balance<T0>) : LoanTicket<T0> {
        LoanTicket<T0>{
            meta       : arg0,
            in_balance : arg1,
        }
    }

    // decompiled from Move bytecode v6
}

