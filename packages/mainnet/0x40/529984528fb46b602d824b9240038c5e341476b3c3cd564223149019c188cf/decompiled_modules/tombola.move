module 0x40529984528fb46b602d824b9240038c5e341476b3c3cd564223149019c188cf::tombola {
    struct TombolaGame<phantom T0> has store, key {
        id: 0x2::object::UID,
        participants: 0x2::table_vec::TableVec<address>,
        ticket_price: u64,
        last_winner: address,
        closed: bool,
        cap: u64,
    }

    public entry fun change_cap<T0>(arg0: &0x40529984528fb46b602d824b9240038c5e341476b3c3cd564223149019c188cf::house::AdminCap, arg1: u64, arg2: &mut TombolaGame<T0>) {
        arg2.cap = arg1;
    }

    public entry fun change_price<T0>(arg0: &0x40529984528fb46b602d824b9240038c5e341476b3c3cd564223149019c188cf::house::AdminCap, arg1: &mut TombolaGame<T0>, arg2: u64) {
        arg1.ticket_price = arg2;
    }

    public entry fun close<T0>(arg0: &0x40529984528fb46b602d824b9240038c5e341476b3c3cd564223149019c188cf::house::AdminCap, arg1: &mut TombolaGame<T0>) {
        arg1.closed = true;
    }

    public entry fun complete<T0>(arg0: &0x40529984528fb46b602d824b9240038c5e341476b3c3cd564223149019c188cf::house::AdminCap, arg1: &mut TombolaGame<T0>, arg2: u64, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        if (0x2::table_vec::length<address>(&arg1.participants) == 0) {
            arg1.last_winner = @0x0;
            0x40529984528fb46b602d824b9240038c5e341476b3c3cd564223149019c188cf::utils::clear_table_vec<address>(&mut arg1.participants);
            return
        };
        0x40529984528fb46b602d824b9240038c5e341476b3c3cd564223149019c188cf::drand::verify_drand_signature(arg3, arg4, arg2);
        let v0 = 0x40529984528fb46b602d824b9240038c5e341476b3c3cd564223149019c188cf::drand::derive_randomness(arg3);
        arg1.last_winner = *0x2::table_vec::borrow<address>(&arg1.participants, 0x40529984528fb46b602d824b9240038c5e341476b3c3cd564223149019c188cf::drand::safe_selection(0x2::table_vec::length<address>(&arg1.participants), &v0));
        arg1.closed = true;
        0x40529984528fb46b602d824b9240038c5e341476b3c3cd564223149019c188cf::utils::clear_table_vec<address>(&mut arg1.participants);
    }

    public entry fun create<T0>(arg0: &0x40529984528fb46b602d824b9240038c5e341476b3c3cd564223149019c188cf::house::AdminCap, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = TombolaGame<T0>{
            id           : 0x2::object::new(arg3),
            participants : 0x2::table_vec::empty<address>(arg3),
            ticket_price : arg1,
            last_winner  : @0x0,
            closed       : false,
            cap          : arg2,
        };
        0x2::transfer::public_share_object<TombolaGame<T0>>(v0);
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

    public entry fun open<T0>(arg0: &0x40529984528fb46b602d824b9240038c5e341476b3c3cd564223149019c188cf::house::AdminCap, arg1: &mut TombolaGame<T0>) {
        assert!(arg1.closed, 0x40529984528fb46b602d824b9240038c5e341476b3c3cd564223149019c188cf::errors::EGameNeedsToBeClosed());
        arg1.closed = false;
    }

    public entry fun participate<T0>(arg0: &mut TombolaGame<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg1) == arg0.ticket_price, 0x40529984528fb46b602d824b9240038c5e341476b3c3cd564223149019c188cf::errors::EInvalidPayment());
        assert!(length_in_table_vec<address>(&arg0.participants, 0x2::tx_context::sender(arg2)) < 0x40529984528fb46b602d824b9240038c5e341476b3c3cd564223149019c188cf::constants::PARTICIPANTS_LIMIT_TOMBOLA(), 0x40529984528fb46b602d824b9240038c5e341476b3c3cd564223149019c188cf::errors::ECannotParticipateLimit());
        assert!(!arg0.closed, 0x40529984528fb46b602d824b9240038c5e341476b3c3cd564223149019c188cf::errors::ECannotParticipateInLockedGame());
        assert!(arg0.cap >= 0x2::table_vec::length<address>(&arg0.participants) + 1, 0x40529984528fb46b602d824b9240038c5e341476b3c3cd564223149019c188cf::errors::ECannotParticipateLimit());
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x40529984528fb46b602d824b9240038c5e341476b3c3cd564223149019c188cf::constants::TREASURY_TOMBOLA());
        0x2::table_vec::push_back<address>(&mut arg0.participants, 0x2::tx_context::sender(arg2));
    }

    public fun ticket_price<T0>(arg0: &TombolaGame<T0>) : u64 {
        arg0.ticket_price
    }

    // decompiled from Move bytecode v6
}

