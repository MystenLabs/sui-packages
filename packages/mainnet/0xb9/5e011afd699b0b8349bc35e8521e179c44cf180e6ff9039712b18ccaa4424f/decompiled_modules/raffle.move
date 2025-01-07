module 0x40529984528fb46b602d824b9240038c5e341476b3c3cd564223149019c188cf::raffle {
    struct LotteryGame<phantom T0> has store, key {
        id: 0x2::object::UID,
        round: u64,
        participants: 0x2::table_vec::TableVec<address>,
        balance: 0x2::balance::Balance<T0>,
        close_on: u64,
        ticket_price: u64,
        last_winner: address,
        closed: bool,
    }

    public entry fun change_price<T0>(arg0: &0x40529984528fb46b602d824b9240038c5e341476b3c3cd564223149019c188cf::house::AdminCap, arg1: &mut LotteryGame<T0>, arg2: u64) {
        arg1.ticket_price = arg2;
    }

    public fun clear_table_emergency<T0: drop + store>(arg0: &0x40529984528fb46b602d824b9240038c5e341476b3c3cd564223149019c188cf::house::AdminCap, arg1: &mut LotteryGame<T0>) {
        0x40529984528fb46b602d824b9240038c5e341476b3c3cd564223149019c188cf::utils::clear_table_vec<address>(&mut arg1.participants);
    }

    public entry fun close<T0>(arg0: &0x40529984528fb46b602d824b9240038c5e341476b3c3cd564223149019c188cf::house::AdminCap, arg1: &mut LotteryGame<T0>) {
        arg1.closed = true;
    }

    public entry fun complete<T0>(arg0: &0x40529984528fb46b602d824b9240038c5e341476b3c3cd564223149019c188cf::house::AdminCap, arg1: &mut LotteryGame<T0>, arg2: &0x2::clock::Clock, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg2) >= arg1.close_on, 0x40529984528fb46b602d824b9240038c5e341476b3c3cd564223149019c188cf::errors::ECloseTimeNotReached());
        if (0x2::table_vec::length<address>(&arg1.participants) == 0) {
            arg1.round = arg6;
            arg1.close_on = arg5;
            arg1.last_winner = @0x0;
            0x40529984528fb46b602d824b9240038c5e341476b3c3cd564223149019c188cf::utils::clear_table_vec<address>(&mut arg1.participants);
            return
        };
        0x40529984528fb46b602d824b9240038c5e341476b3c3cd564223149019c188cf::drand::verify_drand_signature(arg3, arg4, arg1.round);
        let v0 = 0x40529984528fb46b602d824b9240038c5e341476b3c3cd564223149019c188cf::drand::derive_randomness(arg3);
        let v1 = *0x2::table_vec::borrow<address>(&arg1.participants, 0x40529984528fb46b602d824b9240038c5e341476b3c3cd564223149019c188cf::drand::safe_selection(0x2::table_vec::length<address>(&arg1.participants), &v0));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, 0x2::balance::value<T0>(&arg1.balance)), arg7), v1);
        arg1.round = arg6;
        arg1.close_on = arg5;
        arg1.last_winner = v1;
        0x40529984528fb46b602d824b9240038c5e341476b3c3cd564223149019c188cf::utils::clear_table_vec<address>(&mut arg1.participants);
    }

    public entry fun create<T0>(arg0: &0x40529984528fb46b602d824b9240038c5e341476b3c3cd564223149019c188cf::house::AdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = LotteryGame<T0>{
            id           : 0x2::object::new(arg4),
            round        : arg2,
            participants : 0x2::table_vec::empty<address>(arg4),
            balance      : 0x2::balance::zero<T0>(),
            close_on     : arg1,
            ticket_price : arg3,
            last_winner  : @0x0,
            closed       : false,
        };
        0x2::transfer::public_share_object<LotteryGame<T0>>(v0);
    }

    public entry fun emergency<T0>(arg0: &0x40529984528fb46b602d824b9240038c5e341476b3c3cd564223149019c188cf::house::AdminCap, arg1: &mut LotteryGame<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, 0x2::balance::value<T0>(&arg1.balance)), arg2), 0x2::tx_context::sender(arg2));
    }

    fun length_in_table_vec<T0: drop + store>(arg0: &0x2::table_vec::TableVec<T0>, arg1: T0) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v0 < 0x2::table_vec::length<T0>(arg0)) {
            if (0x2::table_vec::borrow<T0>(arg0, v0) == &arg1) {
                v1 = v1 + 1;
            };
            v0 = v0 + 1;
        };
        v1
    }

    public entry fun open<T0>(arg0: &0x40529984528fb46b602d824b9240038c5e341476b3c3cd564223149019c188cf::house::AdminCap, arg1: &mut LotteryGame<T0>, arg2: u64, arg3: u64) {
        assert!(arg1.closed, 0x40529984528fb46b602d824b9240038c5e341476b3c3cd564223149019c188cf::errors::EGameNeedsToBeClosed());
        arg1.closed = false;
        arg1.close_on = arg2;
        arg1.round = arg3;
    }

    public entry fun participate<T0>(arg0: &0x40529984528fb46b602d824b9240038c5e341476b3c3cd564223149019c188cf::house::House, arg1: &mut LotteryGame<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg3) < arg1.close_on, 0x40529984528fb46b602d824b9240038c5e341476b3c3cd564223149019c188cf::errors::ECannotEnterAfterCloseTime());
        assert!(0x2::coin::value<T0>(&arg2) == arg1.ticket_price, 0x40529984528fb46b602d824b9240038c5e341476b3c3cd564223149019c188cf::errors::EInvalidPayment());
        assert!(length_in_table_vec<address>(&arg1.participants, 0x2::tx_context::sender(arg4)) < 0x40529984528fb46b602d824b9240038c5e341476b3c3cd564223149019c188cf::constants::PARTICIPANTS_LIMIT_PREDICTION_RAFFLE(), 0x40529984528fb46b602d824b9240038c5e341476b3c3cd564223149019c188cf::errors::ECannotParticipateLimit());
        assert!(!arg1.closed, 0x40529984528fb46b602d824b9240038c5e341476b3c3cd564223149019c188cf::errors::ECannotParticipateInLockedGame());
        0x2::balance::join<T0>(&mut arg1.balance, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, arg1.ticket_price - arg1.ticket_price * 0x40529984528fb46b602d824b9240038c5e341476b3c3cd564223149019c188cf::house::get_fee_percentage(arg0) / 100, arg4)));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg2, arg1.ticket_price * 0x40529984528fb46b602d824b9240038c5e341476b3c3cd564223149019c188cf::house::get_fee_percentage(arg0) / 100, arg4), 0x40529984528fb46b602d824b9240038c5e341476b3c3cd564223149019c188cf::constants::TREASURY_PREDICTION_RAFFLE());
        0x2::table_vec::push_back<address>(&mut arg1.participants, 0x2::tx_context::sender(arg4));
        if (0x2::coin::value<T0>(&arg2) == 0) {
            0x2::coin::destroy_zero<T0>(arg2);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, 0x2::tx_context::sender(arg4));
        };
    }

    public fun ticket_price<T0>(arg0: &LotteryGame<T0>) : u64 {
        arg0.ticket_price
    }

    // decompiled from Move bytecode v6
}

