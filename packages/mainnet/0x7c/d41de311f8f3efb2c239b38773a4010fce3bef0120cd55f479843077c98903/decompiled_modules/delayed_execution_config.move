module 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::delayed_execution_config {
    struct DelayedExecutionPolicy has copy, drop, store {
        delay_ms: u64,
        stall_timeout_ms: u64,
        stuck_threshold_ms: u64,
        gap_wait_ms: u64,
        pyth_price_buffer_ms: u64,
        pyth_channel: u8,
        svi_max_age_ms: u64,
        mint_capacity: u64,
        sell_capacity: u64,
        per_account_cap: u64,
        order_fee: u64,
        min_sell_quantity: u64,
        settle_refund_batch: u64,
        settle_payout_batch: u64,
    }

    public(friend) fun channel_tick_ms(arg0: u8) : u64 {
        if (arg0 == 2) {
            50
        } else {
            200
        }
    }

    public fun delay_ms(arg0: &DelayedExecutionPolicy) : u64 {
        arg0.delay_ms
    }

    public fun gap_wait_ms(arg0: &DelayedExecutionPolicy) : u64 {
        arg0.gap_wait_ms
    }

    public fun min_sell_quantity(arg0: &DelayedExecutionPolicy) : u64 {
        arg0.min_sell_quantity
    }

    public fun mint_capacity(arg0: &DelayedExecutionPolicy) : u64 {
        arg0.mint_capacity
    }

    public(friend) fun new() : DelayedExecutionPolicy {
        DelayedExecutionPolicy{
            delay_ms             : 800,
            stall_timeout_ms     : 5000,
            stuck_threshold_ms   : 1500,
            gap_wait_ms          : 2000,
            pyth_price_buffer_ms : 0,
            pyth_channel         : 3,
            svi_max_age_ms       : 60000,
            mint_capacity        : 100,
            sell_capacity        : 100,
            per_account_cap      : 5,
            order_fee            : 20000,
            min_sell_quantity    : 10000,
            settle_refund_batch  : 450,
            settle_payout_batch  : 900,
        }
    }

    public fun order_fee(arg0: &DelayedExecutionPolicy) : u64 {
        arg0.order_fee
    }

    public fun per_account_cap(arg0: &DelayedExecutionPolicy) : u64 {
        arg0.per_account_cap
    }

    public fun pyth_channel(arg0: &DelayedExecutionPolicy) : u8 {
        arg0.pyth_channel
    }

    public fun pyth_price_buffer_ms(arg0: &DelayedExecutionPolicy) : u64 {
        arg0.pyth_price_buffer_ms
    }

    public fun sell_capacity(arg0: &DelayedExecutionPolicy) : u64 {
        arg0.sell_capacity
    }

    public(friend) fun set_limits(arg0: &mut DelayedExecutionPolicy, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        assert!(arg1 > 0 && arg1 <= 300, 6);
        assert!(arg2 > 0 && arg2 <= 300, 7);
        assert!(arg3 > 0 && arg3 <= 300, 8);
        let v0 = 10000;
        let v1 = if (arg4 > 0) {
            if (arg4 % v0 == 0) {
                arg4 / v0 <= 4294967295
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 9);
        assert!(arg5 > 0 && arg5 <= 450, 11);
        assert!(arg6 > 0 && arg6 <= 900, 12);
        assert!(arg3 <= 0x1::u64::min(arg1, arg2), 15);
        arg0.mint_capacity = arg1;
        arg0.sell_capacity = arg2;
        arg0.per_account_cap = arg3;
        arg0.min_sell_quantity = arg4;
        arg0.settle_refund_batch = arg5;
        arg0.settle_payout_batch = arg6;
    }

    public(friend) fun set_order_fee(arg0: &mut DelayedExecutionPolicy, arg1: u64) {
        assert!(arg1 <= 1000000, 10);
        arg0.order_fee = arg1;
    }

    public(friend) fun set_timing(arg0: &mut DelayedExecutionPolicy, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u8, arg7: u64) {
        assert!(arg1 <= 5000, 0);
        assert!(arg2 >= 2000 && arg2 <= 10000, 1);
        assert!(arg3 >= 50 && arg3 <= 10000, 2);
        assert!(arg4 >= 50 && arg4 <= 10000, 3);
        assert!(arg5 <= 200, 4);
        assert!(arg7 > 0 && arg7 <= 120000, 5);
        assert!(arg6 == 2 || arg6 == 3, 13);
        let v0 = channel_tick_ms(arg6);
        let v1 = if (arg5 == 0 || arg5 == v0) {
            if (arg3 >= v0) {
                if (arg5 < arg3) {
                    if (arg3 <= arg4) {
                        arg4 < arg2
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 14);
        arg0.delay_ms = arg1;
        arg0.stall_timeout_ms = arg2;
        arg0.stuck_threshold_ms = arg3;
        arg0.gap_wait_ms = arg4;
        arg0.pyth_price_buffer_ms = arg5;
        arg0.pyth_channel = arg6;
        arg0.svi_max_age_ms = arg7;
    }

    public fun settle_payout_batch(arg0: &DelayedExecutionPolicy) : u64 {
        arg0.settle_payout_batch
    }

    public fun settle_refund_batch(arg0: &DelayedExecutionPolicy) : u64 {
        arg0.settle_refund_batch
    }

    public fun stall_timeout_ms(arg0: &DelayedExecutionPolicy) : u64 {
        arg0.stall_timeout_ms
    }

    public fun stuck_threshold_ms(arg0: &DelayedExecutionPolicy) : u64 {
        arg0.stuck_threshold_ms
    }

    public fun svi_max_age_ms(arg0: &DelayedExecutionPolicy) : u64 {
        arg0.svi_max_age_ms
    }

    // decompiled from Move bytecode v7
}

