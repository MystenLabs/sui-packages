module 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dividend_pool {
    struct DividendPoolEpochState has store, key {
        id: 0x2::object::UID,
        start_time: u64,
        epoch: u64,
        tokens: 0x2::balance::Balance<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dive_token::DIVE_TOKEN>,
        claimed_count: u64,
        divers_count: u64,
        tokens_per_diver: u64,
        claimable: bool,
    }

    struct DividendPool has store, key {
        id: 0x2::object::UID,
        current_epoch: u64,
        epoch_states: 0x2::table::Table<u64, DividendPoolEpochState>,
        is_active: bool,
    }

    struct DividendPoolSettleEvent has copy, drop {
        epoch: u64,
        start_time: u64,
        divers_count: u64,
        tokens_per_diver: u64,
    }

    struct DividendPoolActiveEvent has copy, drop {
        is_active: bool,
    }

    fun add_new_epoch(arg0: u64, arg1: u64, arg2: &mut DividendPool, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = DividendPoolEpochState{
            id               : 0x2::object::new(arg3),
            start_time       : arg1,
            epoch            : arg0,
            tokens           : 0x2::balance::zero<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dive_token::DIVE_TOKEN>(),
            claimed_count    : 0,
            divers_count     : 0,
            tokens_per_diver : 0,
            claimable        : false,
        };
        0x2::table::add<u64, DividendPoolEpochState>(&mut arg2.epoch_states, arg0, v0);
        arg2.current_epoch = arg0;
    }

    public(friend) fun burn_and_add_to_dividend_pool(arg0: &mut DividendPool, arg1: 0x2::coin::Coin<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dive_token::DIVE_TOKEN>, arg2: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dive_token::DIVETokenTreasuryCap, arg3: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::GlobalState, arg4: u8, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::utils::assert_valid_version(arg3);
        if (!arg0.is_active) {
            0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dive_token::burn_dive_token(arg2, arg1, arg4);
            0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::update_global_state_total_dive_token_burned(arg3, arg4, 0x2::coin::value<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dive_token::DIVE_TOKEN>(&arg1));
            return
        };
        if (!!0x2::table::is_empty<u64, DividendPoolEpochState>(&arg0.epoch_states)) {
            0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dive_token::burn_dive_token(arg2, arg1, arg4);
            0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::update_global_state_total_dive_token_burned(arg3, arg4, 0x2::coin::value<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dive_token::DIVE_TOKEN>(&arg1));
            return
        };
        update_dividend_pool_state(arg0, arg3, arg5, arg6);
        let v0 = arg0.current_epoch;
        let v1 = get_epoch_state(arg0, v0);
        let v2 = 0x2::coin::value<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dive_token::DIVE_TOKEN>(&arg1) * 3 / 20;
        if (v2 > 0) {
            let v3 = 0x2::coin::into_balance<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dive_token::DIVE_TOKEN>(arg1);
            0x2::balance::join<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dive_token::DIVE_TOKEN>(&mut v1.tokens, 0x2::balance::split<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dive_token::DIVE_TOKEN>(&mut v3, v2));
            0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dive_token::burn_dive_token(arg2, 0x2::coin::from_balance<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dive_token::DIVE_TOKEN>(v3, arg6), arg4);
            0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::update_global_state_total_dive_token_burned(arg3, arg4, 0x2::balance::value<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dive_token::DIVE_TOKEN>(&v3));
        } else {
            0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dive_token::burn_dive_token(arg2, arg1, arg4);
            0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::update_global_state_total_dive_token_burned(arg3, arg4, 0x2::coin::value<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dive_token::DIVE_TOKEN>(&arg1));
        };
    }

    public(friend) fun distribute_dive_token(arg0: &mut DividendPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dive_token::DIVE_TOKEN> {
        let v0 = get_epoch_state(arg0, arg1);
        let v1 = v0.tokens_per_diver;
        if (v1 > 0) {
            v0.claimed_count = v0.claimed_count + 1;
            0x2::coin::from_balance<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dive_token::DIVE_TOKEN>(0x2::balance::split<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dive_token::DIVE_TOKEN>(&mut v0.tokens, v1), arg2)
        } else {
            0x2::coin::zero<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dive_token::DIVE_TOKEN>(arg2)
        }
    }

    public(friend) fun dividend_pool_current_epoch(arg0: &DividendPool) : u64 {
        arg0.current_epoch
    }

    fun get_epoch_state(arg0: &mut DividendPool, arg1: u64) : &mut DividendPoolEpochState {
        0x2::table::borrow_mut<u64, DividendPoolEpochState>(&mut arg0.epoch_states, arg1)
    }

    public(friend) fun get_epoch_state_field(arg0: &DividendPool, arg1: u64) : (u64, u64, u64, u64, u64, u64, bool) {
        let v0 = 0x2::table::borrow<u64, DividendPoolEpochState>(&arg0.epoch_states, arg1);
        (v0.start_time, v0.epoch, 0x2::balance::value<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dive_token::DIVE_TOKEN>(&v0.tokens), v0.claimed_count, v0.divers_count, v0.tokens_per_diver, v0.claimable)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DividendPool{
            id            : 0x2::object::new(arg0),
            current_epoch : 0,
            epoch_states  : 0x2::table::new<u64, DividendPoolEpochState>(arg0),
            is_active     : false,
        };
        0x2::transfer::share_object<DividendPool>(v0);
    }

    entry fun init_dividend_pool(arg0: &0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::GlobalAdminCap, arg1: u64, arg2: &mut DividendPool, arg3: &0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::GlobalState, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::utils::assert_valid_version(arg3);
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::check_is_admin(arg3, arg0);
        assert!(is_dividend_pool_active(arg2), 1);
        assert!(arg1 > 0x2::clock::timestamp_ms(arg4), 0);
        let v0 = DividendPoolEpochState{
            id               : 0x2::object::new(arg5),
            start_time       : arg1,
            epoch            : 0,
            tokens           : 0x2::balance::zero<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dive_token::DIVE_TOKEN>(),
            claimed_count    : 0,
            divers_count     : 0,
            tokens_per_diver : 0,
            claimable        : false,
        };
        0x2::table::add<u64, DividendPoolEpochState>(&mut arg2.epoch_states, 0, v0);
    }

    public(friend) fun is_current_epoch_claimable(arg0: &DividendPool, arg1: u64) : bool {
        0x2::table::borrow<u64, DividendPoolEpochState>(&arg0.epoch_states, arg1).claimable
    }

    public(friend) fun is_dividend_pool_active(arg0: &DividendPool) : bool {
        arg0.is_active
    }

    entry fun set_dividend_pool_active(arg0: &0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::GlobalAdminCap, arg1: &mut DividendPool, arg2: &0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::GlobalState) {
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::utils::assert_valid_version(arg2);
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::check_is_admin(arg2, arg0);
        arg1.is_active = true;
        let v0 = DividendPoolActiveEvent{is_active: true};
        0x2::event::emit<DividendPoolActiveEvent>(v0);
    }

    public fun update_dividend_pool_state(arg0: &mut DividendPool, arg1: &0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::GlobalState, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::utils::assert_valid_version(arg1);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = arg0.current_epoch;
        let v2 = get_epoch_state(arg0, v1);
        if (v2.start_time > v0) {
            return
        };
        if ((v0 - v2.start_time) / 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::dividend_epoch_ms() > 0) {
            let v3 = 0x2::balance::zero<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dive_token::DIVE_TOKEN>();
            if (v1 > 0) {
                let v4 = get_epoch_state(arg0, v1 - 1);
                0x2::balance::join<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dive_token::DIVE_TOKEN>(&mut v3, 0x2::balance::withdraw_all<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dive_token::DIVE_TOKEN>(&mut v4.tokens));
                v4.claimable = false;
            };
            let v5 = arg0.current_epoch;
            let v6 = get_epoch_state(arg0, v1);
            let v7 = 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::total_divers_count(arg1);
            v6.divers_count = v7;
            0x2::balance::join<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dive_token::DIVE_TOKEN>(&mut v6.tokens, v3);
            if (v7 > 0) {
                v6.tokens_per_diver = 0x2::balance::value<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dive_token::DIVE_TOKEN>(&v6.tokens) / v7;
            };
            v6.claimable = true;
            let v8 = DividendPoolSettleEvent{
                epoch            : v5,
                start_time       : v6.start_time,
                divers_count     : v7,
                tokens_per_diver : v6.tokens_per_diver,
            };
            0x2::event::emit<DividendPoolSettleEvent>(v8);
            add_new_epoch(v5 + 1, 0x2::clock::timestamp_ms(arg2), arg0, arg3);
        };
    }

    // decompiled from Move bytecode v6
}

