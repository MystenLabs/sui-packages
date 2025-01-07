module 0x70b1e12ab513b38c0bdaa0ff8bd63b13ccad47e25e654bf4cf0af16e2a389b68::fomo {
    struct FomoGame<phantom T0> has store, key {
        id: 0x2::object::UID,
        prize_pool: 0x2::coin::Coin<T0>,
        current_winner: address,
        end_time: u64,
    }

    struct FomoWinnerUpdatedEvent has copy, drop {
        previous_winner: address,
        previous_end_time: u64,
        new_winner: address,
        new_end_time: u64,
    }

    public fun claim_prize<T0>(arg0: &mut FomoGame<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg1) > arg0.end_time, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0.prize_pool, 0x2::coin::value<T0>(&arg0.prize_pool), arg2), arg0.current_winner);
    }

    public fun create_game<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = FomoGame<T0>{
            id             : 0x2::object::new(arg2),
            prize_pool     : arg0,
            current_winner : 0x2::tx_context::sender(arg2),
            end_time       : 0x2::clock::timestamp_ms(arg1) + 86400000,
        };
        0x2::transfer::share_object<FomoGame<T0>>(v0);
    }

    public fun join_game<T0>(arg0: &mut FomoGame<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg1) >= 0x2::coin::value<T0>(&arg0.prize_pool), 0);
        0x2::coin::join<T0>(&mut arg0.prize_pool, arg1);
        update_winner_and_emit_event<T0>(arg0, 0x2::tx_context::sender(arg3), arg2);
    }

    public fun update_winner_and_emit_event<T0>(arg0: &mut FomoGame<T0>, arg1: address, arg2: &0x2::clock::Clock) {
        arg0.current_winner = arg1;
        if (0x2::clock::timestamp_ms(arg2) - arg0.end_time < 86400000) {
            arg0.end_time = 0x2::clock::timestamp_ms(arg2) + 86400000;
        };
        let v0 = FomoWinnerUpdatedEvent{
            previous_winner   : arg0.current_winner,
            previous_end_time : arg0.end_time,
            new_winner        : arg1,
            new_end_time      : arg0.end_time,
        };
        0x2::event::emit<FomoWinnerUpdatedEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

