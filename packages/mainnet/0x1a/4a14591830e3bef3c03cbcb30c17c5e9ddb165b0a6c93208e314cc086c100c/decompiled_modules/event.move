module 0x1a4a14591830e3bef3c03cbcb30c17c5e9ddb165b0a6c93208e314cc086c100c::event {
    struct AddedEvent has copy, drop {
        global: 0x2::object::ID,
        lp_name: 0x1::string::String,
        coin_x_val: u64,
        coin_y_val: u64,
        lp_val: u64,
    }

    struct RemovedEvent has copy, drop {
        global: 0x2::object::ID,
        lp_name: 0x1::string::String,
        coin_x_val: u64,
        coin_y_val: u64,
        lp_val: u64,
    }

    struct SwappedEvent has copy, drop {
        global: 0x2::object::ID,
        lp_name: 0x1::string::String,
        coin_x_in: u64,
        coin_x_out: u64,
        coin_y_in: u64,
        coin_y_out: u64,
    }

    struct WithdrewEvent has copy, drop {
        global: 0x2::object::ID,
        lp_name: 0x1::string::String,
        fee_coin_x: u64,
        fee_coin_y: u64,
    }

    struct TakeFeeEvent<phantom T0> has copy, drop {
        user_addr: address,
        amount: u64,
        is_buy: bool,
    }

    struct SwapBackEvent<phantom T0> has copy, drop {
        amount_burn: u64,
        amount_lp: u64,
        amount_bonus: u64,
        amount_gov1: u64,
        amount_gov2: u64,
        amount_jackpot: u64,
        amount_dev: u64,
    }

    struct WinnerEvent<phantom T0> has copy, drop {
        tick_id: u64,
        round: u64,
        user: address,
        bonus: u64,
    }

    struct NewTickEvent<phantom T0> has copy, drop {
        round: u64,
        user: address,
        probability: u64,
        amount: u64,
        amountUSD: u64,
    }

    public(friend) fun added_event(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = AddedEvent{
            global     : arg0,
            lp_name    : arg1,
            coin_x_val : arg2,
            coin_y_val : arg3,
            lp_val     : arg4,
        };
        0x2::event::emit<AddedEvent>(v0);
    }

    public(friend) fun new_tick_event<T0>(arg0: u64, arg1: address, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = NewTickEvent<T0>{
            round       : arg0,
            user        : arg1,
            probability : arg2,
            amount      : arg3,
            amountUSD   : arg4,
        };
        0x2::event::emit<NewTickEvent<T0>>(v0);
    }

    public(friend) fun removed_event(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = RemovedEvent{
            global     : arg0,
            lp_name    : arg1,
            coin_x_val : arg2,
            coin_y_val : arg3,
            lp_val     : arg4,
        };
        0x2::event::emit<RemovedEvent>(v0);
    }

    public(friend) fun swap_back_event<T0>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        let v0 = SwapBackEvent<T0>{
            amount_burn    : arg0,
            amount_lp      : arg1,
            amount_bonus   : arg2,
            amount_gov1    : arg3,
            amount_gov2    : arg4,
            amount_jackpot : arg5,
            amount_dev     : arg6,
        };
        0x2::event::emit<SwapBackEvent<T0>>(v0);
    }

    public(friend) fun swapped_event(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = SwappedEvent{
            global     : arg0,
            lp_name    : arg1,
            coin_x_in  : arg2,
            coin_x_out : arg3,
            coin_y_in  : arg4,
            coin_y_out : arg5,
        };
        0x2::event::emit<SwappedEvent>(v0);
    }

    public(friend) fun take_fee_event<T0>(arg0: address, arg1: u64, arg2: bool) {
        let v0 = TakeFeeEvent<T0>{
            user_addr : arg0,
            amount    : arg1,
            is_buy    : arg2,
        };
        0x2::event::emit<TakeFeeEvent<T0>>(v0);
    }

    public(friend) fun winner_event<T0>(arg0: u64, arg1: u64, arg2: address, arg3: u64) {
        let v0 = WinnerEvent<T0>{
            tick_id : arg0,
            round   : arg1,
            user    : arg2,
            bonus   : arg3,
        };
        0x2::event::emit<WinnerEvent<T0>>(v0);
    }

    public(friend) fun withdrew_event(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: u64, arg3: u64) {
        let v0 = WithdrewEvent{
            global     : arg0,
            lp_name    : arg1,
            fee_coin_x : arg2,
            fee_coin_y : arg3,
        };
        0x2::event::emit<WithdrewEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

