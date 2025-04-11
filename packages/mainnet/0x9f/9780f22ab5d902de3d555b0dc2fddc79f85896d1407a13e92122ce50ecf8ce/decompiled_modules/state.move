module 0x9f9780f22ab5d902de3d555b0dc2fddc79f85896d1407a13e92122ce50ecf8ce::state {
    struct State has store {
        accounts: 0x2::table::Table<0x2::object::ID, 0x9f9780f22ab5d902de3d555b0dc2fddc79f85896d1407a13e92122ce50ecf8ce::account::Account>,
        epoch: u64,
        is_active: bool,
        inactive_stake: u64,
        active_stake: u64,
        pending_unstake: u64,
        current_volumes: Volumes,
        all_time_bet_amount: u128,
        all_time_win_amount: u128,
        all_time_profits: u128,
        all_time_losses: u128,
        active_history: 0x2::table::Table<u64, bool>,
        historic_volumes: 0x2::table::Table<u64, Volumes>,
        eod_history: 0x2::table::Table<u64, EndOfDay>,
    }

    struct Volumes has copy, drop, store {
        total_stake_amount: u64,
        total_bet_amount: u64,
        total_win_amount: u64,
    }

    struct EndOfDay has copy, drop, store {
        day_profits: u64,
        day_losses: u64,
    }

    struct HouseActivatedEvent has copy, drop {
        active_stake: u64,
    }

    struct StateEndOfDayProcessedEvent has copy, drop {
        epoch: u64,
        profits: u64,
        losses: u64,
        total_bets: u64,
        total_wins: u64,
        total_stake: u64,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : State {
        State{
            accounts            : 0x2::table::new<0x2::object::ID, 0x9f9780f22ab5d902de3d555b0dc2fddc79f85896d1407a13e92122ce50ecf8ce::account::Account>(arg0),
            epoch               : 0x2::tx_context::epoch(arg0),
            is_active           : false,
            inactive_stake      : 0,
            active_stake        : 0,
            pending_unstake     : 0,
            current_volumes     : new_volumes(),
            all_time_bet_amount : 0,
            all_time_win_amount : 0,
            all_time_profits    : 0,
            all_time_losses     : 0,
            active_history      : 0x2::table::new<u64, bool>(arg0),
            historic_volumes    : 0x2::table::new<u64, Volumes>(arg0),
            eod_history         : 0x2::table::new<u64, EndOfDay>(arg0),
        }
    }

    public fun epoch(arg0: &State) : u64 {
        arg0.epoch
    }

    public(friend) fun process_end_of_day(arg0: &mut State, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg4) > arg0.epoch, 5);
        assert!(arg0.epoch == arg1, 2);
        assert!(arg3 == 0 || arg2 == 0, 7);
        let v0 = arg0.current_volumes.total_stake_amount;
        let v1 = v0;
        if (arg2 > 0) {
            v1 = v0 + arg2;
        } else if (arg3 > 0) {
            if (v0 >= arg3) {
                v1 = v0 - arg3;
            } else {
                assert!(arg3 - v0 <= 0x9f9780f22ab5d902de3d555b0dc2fddc79f85896d1407a13e92122ce50ecf8ce::constants::precision_error_allowance(), 7);
                v1 = 0;
            };
        };
        if (arg0.pending_unstake > 0) {
            let v2 = if (arg2 > 0) {
                0x1::uq32_32::int_mul(arg0.pending_unstake, 0x1::uq32_32::add(0x1::uq32_32::from_int(1), 0x1::uq32_32::from_quotient(arg2, v0)))
            } else if (arg3 > 0) {
                if (arg3 >= v0) {
                    0
                } else {
                    0x1::uq32_32::int_mul(arg0.pending_unstake, 0x1::uq32_32::sub(0x1::uq32_32::from_int(1), 0x1::uq32_32::from_quotient(arg3, v0)))
                }
            } else {
                arg0.pending_unstake
            };
            if (v2 > v1) {
                v1 = 0;
            } else {
                v1 = v1 - v2;
            };
        };
        arg0.active_stake = v1;
        arg0.pending_unstake = 0;
        let v3 = arg0.is_active;
        desactivate(arg0);
        let v4 = arg0.current_volumes;
        arg0.current_volumes = new_volumes();
        0x2::table::add<u64, Volumes>(&mut arg0.historic_volumes, arg1, v4);
        0x2::table::add<u64, bool>(&mut arg0.active_history, arg1, v3);
        let v5 = EndOfDay{
            day_profits : arg2,
            day_losses  : arg3,
        };
        0x2::table::add<u64, EndOfDay>(&mut arg0.eod_history, arg1, v5);
        arg0.all_time_losses = arg0.all_time_losses + (arg3 as u128);
        arg0.all_time_profits = arg0.all_time_profits + (arg2 as u128);
        arg0.epoch = 0x2::tx_context::epoch(arg4);
        let v6 = StateEndOfDayProcessedEvent{
            epoch       : arg1,
            profits     : arg2,
            losses      : arg3,
            total_bets  : v4.total_bet_amount,
            total_wins  : v4.total_win_amount,
            total_stake : v4.total_stake_amount,
        };
        0x2::event::emit<StateEndOfDayProcessedEvent>(v6);
    }

    fun activate(arg0: &mut State) {
        assert!(arg0.is_active == false, 9);
        arg0.is_active = true;
        arg0.active_stake = arg0.inactive_stake;
        arg0.inactive_stake = 0;
        arg0.current_volumes.total_stake_amount = arg0.active_stake;
        let v0 = HouseActivatedEvent{active_stake: arg0.active_stake};
        0x2::event::emit<HouseActivatedEvent>(v0);
    }

    public fun active_stake(arg0: &State) : u64 {
        arg0.active_stake
    }

    fun add_pending_unstake(arg0: &mut State, arg1: u64) {
        arg0.pending_unstake = arg0.pending_unstake + arg1;
    }

    fun add_stake(arg0: &mut State, arg1: u64) {
        arg0.inactive_stake = arg0.inactive_stake + arg1;
    }

    public fun all_time_bet_amount(arg0: &State) : u128 {
        arg0.all_time_bet_amount
    }

    public fun all_time_losses(arg0: &State) : u128 {
        arg0.all_time_losses
    }

    public fun all_time_profits(arg0: &State) : u128 {
        arg0.all_time_profits
    }

    public fun all_time_win_amount(arg0: &State) : u128 {
        arg0.all_time_win_amount
    }

    fun assert_active(arg0: &State) {
        assert!(arg0.is_active == true, 8);
    }

    fun assert_epoch_up_to_date(arg0: &State, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.epoch == 0x2::tx_context::epoch(arg1), 2);
    }

    fun calculate_fee(arg0: &vector<0x9f9780f22ab5d902de3d555b0dc2fddc79f85896d1407a13e92122ce50ecf8ce::transaction::Transaction>, arg1: 0x1::uq32_32::UQ32_32) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x9f9780f22ab5d902de3d555b0dc2fddc79f85896d1407a13e92122ce50ecf8ce::transaction::Transaction>(arg0)) {
            let v2 = 0x1::vector::borrow<0x9f9780f22ab5d902de3d555b0dc2fddc79f85896d1407a13e92122ce50ecf8ce::transaction::Transaction>(arg0, v1);
            if (0x9f9780f22ab5d902de3d555b0dc2fddc79f85896d1407a13e92122ce50ecf8ce::transaction::is_debit(v2)) {
                v0 = v0 + 0x1::uq32_32::int_mul(0x9f9780f22ab5d902de3d555b0dc2fddc79f85896d1407a13e92122ce50ecf8ce::transaction::amount(v2), arg1);
            };
            v1 = v1 + 1;
        };
        v0
    }

    public(friend) fun calculate_ggr_share(arg0: &State, arg1: u64, arg2: u64) : (u64, u64) {
        let v0 = if (!0x2::table::contains<u64, Volumes>(&arg0.historic_volumes, arg1)) {
            true
        } else if (!0x2::table::contains<u64, EndOfDay>(&arg0.eod_history, arg1)) {
            true
        } else {
            !0x2::table::contains<u64, bool>(&arg0.active_history, arg1)
        };
        if (v0) {
            return (0, 0)
        };
        let v1 = 0x2::table::borrow<u64, Volumes>(&arg0.historic_volumes, arg1);
        let v2 = 0x2::table::borrow<u64, EndOfDay>(&arg0.eod_history, arg1);
        if (v1.total_stake_amount == 0 || !*0x2::table::borrow<u64, bool>(&arg0.active_history, arg1)) {
            return (0, 0)
        };
        if (v2.day_losses > 0) {
            return (0, 0x1::uq32_32::int_mul(v2.day_losses, 0x1::uq32_32::from_quotient(arg2, v1.total_stake_amount)))
        };
        if (v2.day_profits > 0) {
            return (0x1::uq32_32::int_mul(v2.day_profits, 0x1::uq32_32::from_quotient(arg2, v1.total_stake_amount)), 0)
        };
        (0, 0)
    }

    public fun current_volumes(arg0: &State) : Volumes {
        arg0.current_volumes
    }

    public fun day_losses(arg0: &EndOfDay) : u64 {
        arg0.day_losses
    }

    public fun day_profits(arg0: &EndOfDay) : u64 {
        arg0.day_profits
    }

    fun desactivate(arg0: &mut State) {
        arg0.inactive_stake = arg0.inactive_stake + arg0.active_stake;
        arg0.active_stake = 0;
        arg0.is_active = false;
    }

    public fun end_of_day_for_epoch(arg0: &State, arg1: u64) : EndOfDay {
        assert!(0x2::table::contains<u64, EndOfDay>(&arg0.eod_history, arg1), 4);
        *0x2::table::borrow<u64, EndOfDay>(&arg0.eod_history, arg1)
    }

    public(friend) fun epoch_active(arg0: &State, arg1: u64) : bool {
        assert!(arg1 <= arg0.epoch, 2);
        if (arg0.epoch == arg1) {
            return is_active(arg0)
        };
        if (!0x2::table::contains<u64, bool>(&arg0.active_history, arg1)) {
            return false
        };
        *0x2::table::borrow<u64, bool>(&arg0.active_history, arg1)
    }

    public fun inactive_stake(arg0: &State) : u64 {
        arg0.inactive_stake
    }

    public fun is_active(arg0: &State) : bool {
        arg0.is_active
    }

    public(friend) fun maybe_activate(arg0: &mut State, arg1: u64, arg2: &0x2::tx_context::TxContext) : bool {
        assert_epoch_up_to_date(arg0, arg2);
        if (is_active(arg0)) {
            return false
        };
        if (arg0.inactive_stake >= arg1) {
            activate(arg0);
            return true
        };
        false
    }

    fun new_volumes() : Volumes {
        Volumes{
            total_stake_amount : 0,
            total_bet_amount   : 0,
            total_win_amount   : 0,
        }
    }

    public fun pending_unstake(arg0: &State) : u64 {
        arg0.pending_unstake
    }

    fun process_bet(arg0: &mut State, arg1: u64) {
        arg0.current_volumes.total_bet_amount = arg0.current_volumes.total_bet_amount + arg1;
        arg0.all_time_bet_amount = arg0.all_time_bet_amount + (arg1 as u128);
    }

    public(friend) fun process_stake(arg0: &mut State, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert_epoch_up_to_date(arg0, arg2);
        add_stake(arg0, arg1);
    }

    public(friend) fun process_transactions(arg0: &mut State, arg1: &vector<0x9f9780f22ab5d902de3d555b0dc2fddc79f85896d1407a13e92122ce50ecf8ce::transaction::Transaction>, arg2: 0x2::object::ID, arg3: 0x1::uq32_32::UQ32_32, arg4: 0x1::uq32_32::UQ32_32, arg5: 0x1::option::Option<0x1::uq32_32::UQ32_32>, arg6: &0x2::tx_context::TxContext) : (u64, u64, u64, u64, u64) {
        assert_active(arg0);
        assert_epoch_up_to_date(arg0, arg6);
        update_account(arg0, arg2);
        process_transactions_for_account(arg0, arg2, arg1);
        process_volumes(arg0, arg1);
        let v0 = 0;
        if (0x1::option::is_some<0x1::uq32_32::UQ32_32>(&arg5)) {
            v0 = calculate_fee(arg1, 0x1::option::destroy_some<0x1::uq32_32::UQ32_32>(arg5));
        } else {
            0x1::option::destroy_none<0x1::uq32_32::UQ32_32>(arg5);
        };
        let (v1, v2) = 0x9f9780f22ab5d902de3d555b0dc2fddc79f85896d1407a13e92122ce50ecf8ce::account::settle(0x2::table::borrow_mut<0x2::object::ID, 0x9f9780f22ab5d902de3d555b0dc2fddc79f85896d1407a13e92122ce50ecf8ce::account::Account>(&mut arg0.accounts, arg2));
        (v1, v2, calculate_fee(arg1, arg3), calculate_fee(arg1, arg4), v0)
    }

    fun process_transactions_for_account(arg0: &mut State, arg1: 0x2::object::ID, arg2: &vector<0x9f9780f22ab5d902de3d555b0dc2fddc79f85896d1407a13e92122ce50ecf8ce::transaction::Transaction>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x9f9780f22ab5d902de3d555b0dc2fddc79f85896d1407a13e92122ce50ecf8ce::transaction::Transaction>(arg2)) {
            let v1 = 0x1::vector::borrow<0x9f9780f22ab5d902de3d555b0dc2fddc79f85896d1407a13e92122ce50ecf8ce::transaction::Transaction>(arg2, v0);
            if (0x9f9780f22ab5d902de3d555b0dc2fddc79f85896d1407a13e92122ce50ecf8ce::transaction::is_credit(v1)) {
                0x9f9780f22ab5d902de3d555b0dc2fddc79f85896d1407a13e92122ce50ecf8ce::account::credit(0x2::table::borrow_mut<0x2::object::ID, 0x9f9780f22ab5d902de3d555b0dc2fddc79f85896d1407a13e92122ce50ecf8ce::account::Account>(&mut arg0.accounts, arg1), 0x9f9780f22ab5d902de3d555b0dc2fddc79f85896d1407a13e92122ce50ecf8ce::transaction::amount(v1));
            } else {
                assert!(0x9f9780f22ab5d902de3d555b0dc2fddc79f85896d1407a13e92122ce50ecf8ce::transaction::is_debit(v1), 1);
                0x9f9780f22ab5d902de3d555b0dc2fddc79f85896d1407a13e92122ce50ecf8ce::account::debit(0x2::table::borrow_mut<0x2::object::ID, 0x9f9780f22ab5d902de3d555b0dc2fddc79f85896d1407a13e92122ce50ecf8ce::account::Account>(&mut arg0.accounts, arg1), 0x9f9780f22ab5d902de3d555b0dc2fddc79f85896d1407a13e92122ce50ecf8ce::transaction::amount(v1));
            };
            v0 = v0 + 1;
        };
    }

    public(friend) fun process_unstake(arg0: &mut State, arg1: u64, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert_epoch_up_to_date(arg0, arg3);
        assert!(0x2::tx_context::epoch(arg3) == arg0.epoch, 2);
        if (arg0.is_active) {
            add_pending_unstake(arg0, arg1);
        } else {
            remove_inactive_stake(arg0, arg1);
        };
        remove_inactive_stake(arg0, arg2);
    }

    fun process_volumes(arg0: &mut State, arg1: &vector<0x9f9780f22ab5d902de3d555b0dc2fddc79f85896d1407a13e92122ce50ecf8ce::transaction::Transaction>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x9f9780f22ab5d902de3d555b0dc2fddc79f85896d1407a13e92122ce50ecf8ce::transaction::Transaction>(arg1)) {
            let v1 = 0x1::vector::borrow<0x9f9780f22ab5d902de3d555b0dc2fddc79f85896d1407a13e92122ce50ecf8ce::transaction::Transaction>(arg1, v0);
            if (0x9f9780f22ab5d902de3d555b0dc2fddc79f85896d1407a13e92122ce50ecf8ce::transaction::is_credit(v1)) {
                process_win(arg0, 0x9f9780f22ab5d902de3d555b0dc2fddc79f85896d1407a13e92122ce50ecf8ce::transaction::amount(v1));
            } else {
                assert!(0x9f9780f22ab5d902de3d555b0dc2fddc79f85896d1407a13e92122ce50ecf8ce::transaction::is_debit(v1), 1);
                process_bet(arg0, 0x9f9780f22ab5d902de3d555b0dc2fddc79f85896d1407a13e92122ce50ecf8ce::transaction::amount(v1));
            };
            v0 = v0 + 1;
        };
    }

    fun process_win(arg0: &mut State, arg1: u64) {
        arg0.current_volumes.total_win_amount = arg0.current_volumes.total_win_amount + arg1;
        arg0.all_time_win_amount = arg0.all_time_win_amount + (arg1 as u128);
    }

    public(friend) fun refresh(arg0: &State, arg1: &mut 0x9f9780f22ab5d902de3d555b0dc2fddc79f85896d1407a13e92122ce50ecf8ce::participation::Participation, arg2: &0x2::tx_context::TxContext) {
        update_participation(arg0, arg1, arg2);
    }

    fun remove_inactive_stake(arg0: &mut State, arg1: u64) {
        if (arg0.inactive_stake >= arg1) {
            arg0.inactive_stake = arg0.inactive_stake - arg1;
        } else {
            assert!(arg1 - arg0.inactive_stake <= 0x9f9780f22ab5d902de3d555b0dc2fddc79f85896d1407a13e92122ce50ecf8ce::constants::precision_error_allowance(), 3);
            arg0.inactive_stake = 0;
        };
    }

    public fun total_bet_amount(arg0: &Volumes) : u64 {
        arg0.total_bet_amount
    }

    public fun total_stake_amount(arg0: &Volumes) : u64 {
        arg0.total_stake_amount
    }

    public fun total_win_amount(arg0: &Volumes) : u64 {
        arg0.total_win_amount
    }

    fun update_account(arg0: &mut State, arg1: 0x2::object::ID) {
        if (!0x2::table::contains<0x2::object::ID, 0x9f9780f22ab5d902de3d555b0dc2fddc79f85896d1407a13e92122ce50ecf8ce::account::Account>(&arg0.accounts, arg1)) {
            0x2::table::add<0x2::object::ID, 0x9f9780f22ab5d902de3d555b0dc2fddc79f85896d1407a13e92122ce50ecf8ce::account::Account>(&mut arg0.accounts, arg1, 0x9f9780f22ab5d902de3d555b0dc2fddc79f85896d1407a13e92122ce50ecf8ce::account::empty());
        };
    }

    fun update_participation(arg0: &State, arg1: &mut 0x9f9780f22ab5d902de3d555b0dc2fddc79f85896d1407a13e92122ce50ecf8ce::participation::Participation, arg2: &0x2::tx_context::TxContext) {
        let (v0, v1, _) = 0x9f9780f22ab5d902de3d555b0dc2fddc79f85896d1407a13e92122ce50ecf8ce::participation::current_state(arg1);
        let v3 = v1;
        let v4 = v0;
        while (v4 < 0x2::tx_context::epoch(arg2)) {
            let (v5, v6) = calculate_ggr_share(arg0, v4, v3);
            0x9f9780f22ab5d902de3d555b0dc2fddc79f85896d1407a13e92122ce50ecf8ce::participation::process_end_of_day(arg1, v4, v5, v6, arg2);
            let (v7, v8, _) = 0x9f9780f22ab5d902de3d555b0dc2fddc79f85896d1407a13e92122ce50ecf8ce::participation::current_state(arg1);
            v3 = v8;
            v4 = v7;
        };
    }

    public fun volume_for_epoch(arg0: &State, arg1: u64) : Volumes {
        assert!(0x2::table::contains<u64, Volumes>(&arg0.historic_volumes, arg1), 6);
        *0x2::table::borrow<u64, Volumes>(&arg0.historic_volumes, arg1)
    }

    // decompiled from Move bytecode v6
}

