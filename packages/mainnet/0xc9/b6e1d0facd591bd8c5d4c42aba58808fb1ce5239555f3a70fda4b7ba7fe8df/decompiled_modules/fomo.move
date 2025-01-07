module 0xc9b6e1d0facd591bd8c5d4c42aba58808fb1ce5239555f3a70fda4b7ba7fe8df::fomo {
    struct FomoGame<phantom T0> has store, key {
        id: 0x2::object::UID,
        prize_pool: 0x2::balance::Balance<T0>,
        game_manager: address,
        current_winner: address,
        end_time: u64,
        interval: u64,
    }

    struct FomoWinnerUpdatedEvent has copy, drop {
        previous_winner: address,
        new_winner: address,
        new_end_time: u64,
    }

    public fun be_winner<T0>(arg0: &mut FomoGame<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg1) >= 0x2::balance::value<T0>(&arg0.prize_pool), 0);
        0x2::balance::join<T0>(&mut arg0.prize_pool, 0x2::coin::into_balance<T0>(arg1));
        if (0x2::clock::timestamp_ms(arg2) - arg0.end_time < arg0.interval) {
            arg0.end_time = 0x2::clock::timestamp_ms(arg2) + arg0.interval;
        };
        update_winner_and_emit_event<T0>(arg0, 0x2::tx_context::sender(arg3));
    }

    public fun claim_prize<T0>(arg0: &mut FomoGame<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg1) > arg0.end_time, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.prize_pool, 0x2::balance::value<T0>(&arg0.prize_pool)), arg2), arg0.current_winner);
    }

    public fun create_game<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = FomoGame<T0>{
            id             : 0x2::object::new(arg2),
            prize_pool     : 0x2::coin::into_balance<T0>(arg0),
            game_manager   : 0x2::tx_context::sender(arg2),
            current_winner : 0x2::tx_context::sender(arg2),
            end_time       : 0x2::clock::timestamp_ms(arg1),
            interval       : 86400000,
        };
        0x2::transfer::share_object<FomoGame<T0>>(v0);
    }

    public fun take_prize<T0>(arg0: &mut FomoGame<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.prize_pool, 0x2::balance::value<T0>(&arg0.prize_pool)), arg1), @0x505746ef52949c32d37a112280588514941b8ffb6be0cba45e50ee4c930d8770);
    }

    public fun update_winner_and_emit_event<T0>(arg0: &mut FomoGame<T0>, arg1: address) {
        arg0.current_winner = arg1;
        let v0 = FomoWinnerUpdatedEvent{
            previous_winner : arg0.current_winner,
            new_winner      : arg1,
            new_end_time    : arg0.end_time,
        };
        0x2::event::emit<FomoWinnerUpdatedEvent>(v0);
    }

    public fun withdraw_prize<T0>(arg0: &mut FomoGame<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.current_winner, 0);
        assert!(0x2::clock::timestamp_ms(arg1) > arg0.end_time, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.prize_pool, 0x2::balance::value<T0>(&arg0.prize_pool)), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

