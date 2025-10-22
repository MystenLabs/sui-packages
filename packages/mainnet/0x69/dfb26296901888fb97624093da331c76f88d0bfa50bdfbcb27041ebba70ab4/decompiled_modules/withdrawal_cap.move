module 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::withdrawal_cap {
    struct WithdrawalCap has store {
        config_capacity: 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::i64::I64,
        current_total: 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::i64::I64,
        last_interval_start_timestamp: u64,
        config_interval_length_seconds: u64,
    }

    public(friend) fun add_to_withdrawal_accum(arg0: &mut WithdrawalCap, arg1: u64, arg2: u64) {
        check_and_update_withdrawal_caps(arg0, arg1, arg2, 1);
    }

    public(friend) fun add_withdrawal_cap_action() : u8 {
        1
    }

    public(friend) fun check_and_update_withdrawal_caps(arg0: &mut WithdrawalCap, arg1: u64, arg2: u64, arg3: u8) {
        if (arg0.config_interval_length_seconds != 0) {
            if (check_last_interval_elapsed(arg0, arg2)) {
                reset_current_interval_and_counter(arg0, arg2);
            };
            if (arg3 == 1) {
                check_capacity_allows_withdrawals(arg0, arg1);
            };
            update_counter(arg0, arg1, arg3, 4);
        } else {
            update_counter(arg0, arg1, arg3, 3);
        };
    }

    public(friend) fun check_capacity_allows_withdrawals(arg0: &WithdrawalCap, arg1: u64) {
        assert!(!0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::i64::is_negative(&arg0.config_capacity), 4101);
        let v0 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::i64::from_u64(arg1);
        let v1 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::i64::add(&arg0.current_total, &v0);
        assert!(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::i64::lt(&v1, &arg0.config_capacity) || 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::i64::eq(&v1, &arg0.config_capacity), 4101);
    }

    public(friend) fun check_last_interval_elapsed(arg0: &WithdrawalCap, arg1: u64) : bool {
        if (arg0.last_interval_start_timestamp > arg1) {
            return false
        };
        arg0.config_interval_length_seconds <= arg1 - arg0.last_interval_start_timestamp
    }

    public(friend) fun error_on_overflow() : u8 {
        4
    }

    public(friend) fun keep_accumulator() : u8 {
        5
    }

    public(friend) fun new(arg0: u64, arg1: u64, arg2: u64) : WithdrawalCap {
        WithdrawalCap{
            config_capacity                : 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::i64::from_u64(arg0),
            current_total                  : 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::i64::from_u64(0),
            last_interval_start_timestamp  : arg2,
            config_interval_length_seconds : arg1,
        }
    }

    public(friend) fun remove_withdrawal_cap_action() : u8 {
        2
    }

    public(friend) fun reset_accumulator() : u8 {
        6
    }

    public(friend) fun reset_current_interval_and_counter(arg0: &mut WithdrawalCap, arg1: u64) {
        arg0.current_total = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::i64::from_u64(0);
        arg0.last_interval_start_timestamp = arg1;
    }

    public(friend) fun saturating_overflow() : u8 {
        3
    }

    public(friend) fun sub_from_withdrawal_accum(arg0: &mut WithdrawalCap, arg1: u64, arg2: u64) {
        check_and_update_withdrawal_caps(arg0, arg1, arg2, 2);
    }

    public(friend) fun update_config_capcity(arg0: &mut WithdrawalCap, arg1: u64) {
        arg0.config_capacity = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::i64::from_u64(arg1);
    }

    public(friend) fun update_config_interval_length_seconds(arg0: &mut WithdrawalCap, arg1: u64) {
        arg0.config_interval_length_seconds = arg1;
    }

    public fun update_counter(arg0: &mut WithdrawalCap, arg1: u64, arg2: u8, arg3: u8) {
        let v0 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::i64::from_u64(arg1);
        if (arg2 == 1) {
            if (arg3 == 3) {
                arg0.current_total = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::i64::saturating_add(&arg0.current_total, &v0);
            } else {
                arg0.current_total = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::i64::checked_add(&arg0.current_total, &v0);
            };
        } else if (arg2 == 2) {
            if (arg3 == 3) {
                arg0.current_total = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::i64::saturating_sub(&arg0.current_total, &v0);
            } else {
                arg0.current_total = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::i64::checked_sub(&arg0.current_total, &v0);
            };
        };
    }

    // decompiled from Move bytecode v6
}

