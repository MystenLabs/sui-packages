module 0xca2ef929d600602e2a274171c840efa15e87b6d89b284d290bbcf04f5a6d03a7::player_wallet {
    struct PlayerObjectReceivedEvent<phantom T0> has copy, drop {
        player_id: 0x2::object::ID,
        object_id: 0x2::object::ID,
    }

    struct PlayerCoinsReceivedEvent<phantom T0> has copy, drop {
        player_id: 0x2::object::ID,
        value: u64,
        coins: u64,
    }

    struct PlayerFundsRedeemedEvent<phantom T0> has copy, drop {
        player_id: 0x2::object::ID,
        value: u64,
    }

    public fun redeem_balance<T0>(arg0: &mut 0x47137c6af0c5938d4d49a1c2e5af7cfe983ac50c9561d0863d2ee1d013b3ae53::player::Player, arg1: u64) : 0x2::balance::Balance<T0> {
        assert!(arg1 > 0, 1);
        let v0 = 0x2ccb0ff53146ac5830f92c0c9f8e5260160705e1f15c7f6606340a1c94c2ab98::hikida::redeem_balance<T0>(0x47137c6af0c5938d4d49a1c2e5af7cfe983ac50c9561d0863d2ee1d013b3ae53::player::uid_mut(arg0), arg1);
        let v1 = PlayerFundsRedeemedEvent<T0>{
            player_id : 0x2::object::id<0x47137c6af0c5938d4d49a1c2e5af7cfe983ac50c9561d0863d2ee1d013b3ae53::player::Player>(arg0),
            value     : 0x2::balance::value<T0>(&v0),
        };
        0x2::event::emit<PlayerFundsRedeemedEvent<T0>>(v1);
        v0
    }

    public fun inbox_address(arg0: &0x47137c6af0c5938d4d49a1c2e5af7cfe983ac50c9561d0863d2ee1d013b3ae53::player::Player) : address {
        let v0 = 0x2::object::id<0x47137c6af0c5938d4d49a1c2e5af7cfe983ac50c9561d0863d2ee1d013b3ae53::player::Player>(arg0);
        0x2::object::id_to_address(&v0)
    }

    public fun receive<T0: store + key>(arg0: &mut 0x47137c6af0c5938d4d49a1c2e5af7cfe983ac50c9561d0863d2ee1d013b3ae53::player::Player, arg1: 0x2::transfer::Receiving<T0>) : T0 {
        let v0 = 0x2::transfer::public_receive<T0>(0x47137c6af0c5938d4d49a1c2e5af7cfe983ac50c9561d0863d2ee1d013b3ae53::player::uid_mut(arg0), arg1);
        let v1 = PlayerObjectReceivedEvent<T0>{
            player_id : 0x2::object::id<0x47137c6af0c5938d4d49a1c2e5af7cfe983ac50c9561d0863d2ee1d013b3ae53::player::Player>(arg0),
            object_id : 0x2::object::id<T0>(&v0),
        };
        0x2::event::emit<PlayerObjectReceivedEvent<T0>>(v1);
        v0
    }

    public fun receive_balance<T0>(arg0: &mut 0x47137c6af0c5938d4d49a1c2e5af7cfe983ac50c9561d0863d2ee1d013b3ae53::player::Player, arg1: vector<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>) : 0x2::balance::Balance<T0> {
        assert!(!0x1::vector::is_empty<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>(&arg1), 0);
        let v0 = 0x2ccb0ff53146ac5830f92c0c9f8e5260160705e1f15c7f6606340a1c94c2ab98::hikida::receive_coins_as_balance<T0>(0x47137c6af0c5938d4d49a1c2e5af7cfe983ac50c9561d0863d2ee1d013b3ae53::player::uid_mut(arg0), arg1);
        let v1 = PlayerCoinsReceivedEvent<T0>{
            player_id : 0x2::object::id<0x47137c6af0c5938d4d49a1c2e5af7cfe983ac50c9561d0863d2ee1d013b3ae53::player::Player>(arg0),
            value     : 0x2::balance::value<T0>(&v0),
            coins     : 0x1::vector::length<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>(&arg1),
        };
        0x2::event::emit<PlayerCoinsReceivedEvent<T0>>(v1);
        v0
    }

    // decompiled from Move bytecode v7
}

