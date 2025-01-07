module 0x40529984528fb46b602d824b9240038c5e341476b3c3cd564223149019c188cf::prediction {
    struct Prediction has drop, store {
        participant: address,
        prediction: u64,
    }

    struct PredictionGame<phantom T0> has store, key {
        id: 0x2::object::UID,
        participants: 0x2::table_vec::TableVec<Prediction>,
        balance: 0x2::balance::Balance<T0>,
        ticket_price: u64,
        last_winners: vector<address>,
        close_on: u64,
        closed: bool,
    }

    public entry fun change_price<T0>(arg0: &0x40529984528fb46b602d824b9240038c5e341476b3c3cd564223149019c188cf::house::AdminCap, arg1: &mut PredictionGame<T0>, arg2: u64) {
        arg1.ticket_price = arg2;
    }

    public entry fun close<T0>(arg0: &0x40529984528fb46b602d824b9240038c5e341476b3c3cd564223149019c188cf::house::AdminCap, arg1: &mut PredictionGame<T0>) {
        arg1.closed = true;
    }

    public entry fun complete<T0>(arg0: &0x40529984528fb46b602d824b9240038c5e341476b3c3cd564223149019c188cf::house::AdminCap, arg1: &mut PredictionGame<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 0x40529984528fb46b602d824b9240038c5e341476b3c3cd564223149019c188cf::errors::EInvalidPayment());
        assert!(0x2::clock::timestamp_ms(arg3) >= arg1.close_on, 0x40529984528fb46b602d824b9240038c5e341476b3c3cd564223149019c188cf::errors::ECloseTimeNotReached());
        let v0 = 1000000000000000000;
        let v1 = 0x1::vector::empty<address>();
        let v2 = 0;
        let v3 = 0x2::table_vec::length<Prediction>(&arg1.participants);
        if (v3 == 0) {
            arg1.last_winners = v1;
            arg1.closed = true;
            0x40529984528fb46b602d824b9240038c5e341476b3c3cd564223149019c188cf::utils::clear_table_vec<Prediction>(&mut arg1.participants);
            return
        };
        while (v2 < v3) {
            let v4 = 0x2::table_vec::borrow<Prediction>(&arg1.participants, v2);
            v2 = v2 + 1;
            let v5 = if (v4.prediction >= arg2) {
                v4.prediction - arg2
            } else {
                arg2 - v4.prediction
            };
            if (v5 < v0) {
                v1 = 0x1::vector::empty<address>();
                0x1::vector::push_back<address>(&mut v1, v4.participant);
                continue
            };
            if (v5 == v0) {
                0x1::vector::push_back<address>(&mut v1, v4.participant);
                continue
            };
        };
        let v6 = 0x2::balance::value<T0>(&arg1.balance);
        let v7 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, v6), arg4);
        let v8 = 0x1::vector::length<address>(&v1);
        if (v8 > 0) {
            let v9 = 0;
            while (v9 < v8) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v7, v6 / v8, arg4), *0x1::vector::borrow<address>(&v1, v9));
                v9 = v9 + 1;
            };
        };
        arg1.last_winners = v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v7, 0x40529984528fb46b602d824b9240038c5e341476b3c3cd564223149019c188cf::constants::TREASURY_PREDICTION_RAFFLE());
        0x40529984528fb46b602d824b9240038c5e341476b3c3cd564223149019c188cf::utils::clear_table_vec<Prediction>(&mut arg1.participants);
        arg1.closed = true;
    }

    public entry fun create<T0>(arg0: &0x40529984528fb46b602d824b9240038c5e341476b3c3cd564223149019c188cf::house::AdminCap, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = PredictionGame<T0>{
            id           : 0x2::object::new(arg3),
            participants : 0x2::table_vec::empty<Prediction>(arg3),
            balance      : 0x2::balance::zero<T0>(),
            ticket_price : arg1,
            last_winners : 0x1::vector::empty<address>(),
            close_on     : arg2,
            closed       : false,
        };
        0x2::transfer::public_share_object<PredictionGame<T0>>(v0);
    }

    public entry fun emergency<T0>(arg0: &0x40529984528fb46b602d824b9240038c5e341476b3c3cd564223149019c188cf::house::AdminCap, arg1: &mut PredictionGame<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, 0x2::balance::value<T0>(&arg1.balance)), arg2), 0x2::tx_context::sender(arg2));
    }

    fun length_in_table_vec(arg0: &0x2::table_vec::TableVec<Prediction>, arg1: address) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v0 < 0x2::table_vec::length<Prediction>(arg0)) {
            if (0x2::table_vec::borrow<Prediction>(arg0, v0).participant == arg1) {
                v1 = v1 + 1;
            };
            v0 = v0 + 1;
        };
        v1
    }

    public entry fun open<T0>(arg0: &0x40529984528fb46b602d824b9240038c5e341476b3c3cd564223149019c188cf::house::AdminCap, arg1: &mut PredictionGame<T0>, arg2: u64) {
        assert!(arg1.closed, 0x40529984528fb46b602d824b9240038c5e341476b3c3cd564223149019c188cf::errors::EGameNeedsToBeClosed());
        arg1.closed = false;
        arg1.close_on = arg2;
    }

    public entry fun participate<T0>(arg0: &0x40529984528fb46b602d824b9240038c5e341476b3c3cd564223149019c188cf::house::House, arg1: &mut PredictionGame<T0>, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg3) == arg1.ticket_price, 0x40529984528fb46b602d824b9240038c5e341476b3c3cd564223149019c188cf::errors::EInvalidPayment());
        assert!(length_in_table_vec(&arg1.participants, 0x2::tx_context::sender(arg5)) < 0x40529984528fb46b602d824b9240038c5e341476b3c3cd564223149019c188cf::constants::PARTICIPANTS_LIMIT_PREDICTION_RAFFLE(), 0x40529984528fb46b602d824b9240038c5e341476b3c3cd564223149019c188cf::errors::ECannotParticipateLimit());
        assert!(!arg1.closed, 0x40529984528fb46b602d824b9240038c5e341476b3c3cd564223149019c188cf::errors::ECannotParticipateInLockedGame());
        assert!(0x2::clock::timestamp_ms(arg4) < arg1.close_on, 0x40529984528fb46b602d824b9240038c5e341476b3c3cd564223149019c188cf::errors::ECannotEnterAfterCloseTime());
        0x2::balance::join<T0>(&mut arg1.balance, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg3, arg1.ticket_price - arg1.ticket_price * 0x40529984528fb46b602d824b9240038c5e341476b3c3cd564223149019c188cf::house::get_fee_percentage(arg0) / 100, arg5)));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg3, arg1.ticket_price * (0x40529984528fb46b602d824b9240038c5e341476b3c3cd564223149019c188cf::house::get_fee_percentage(arg0) - 3) / 100, arg5), 0x40529984528fb46b602d824b9240038c5e341476b3c3cd564223149019c188cf::constants::TREASURY_PREDICTION_RAFFLE());
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg3, arg1.ticket_price * 3 / 100, arg5), 0x40529984528fb46b602d824b9240038c5e341476b3c3cd564223149019c188cf::constants::MAINTAINER());
        let v0 = Prediction{
            participant : 0x2::tx_context::sender(arg5),
            prediction  : arg2,
        };
        0x2::table_vec::push_back<Prediction>(&mut arg1.participants, v0);
        if (0x2::coin::value<T0>(&arg3) == 0) {
            0x2::coin::destroy_zero<T0>(arg3);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, 0x2::tx_context::sender(arg5));
        };
    }

    public fun ticket_price<T0>(arg0: &PredictionGame<T0>) : u64 {
        arg0.ticket_price
    }

    // decompiled from Move bytecode v6
}

