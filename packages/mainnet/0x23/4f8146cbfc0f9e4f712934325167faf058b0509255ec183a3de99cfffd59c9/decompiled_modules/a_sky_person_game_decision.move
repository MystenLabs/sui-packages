module 0x234f8146cbfc0f9e4f712934325167faf058b0509255ec183a3de99cfffd59c9::a_sky_person_game_decision {
    struct GameWallet<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    public fun choose<T0>(arg0: u64, arg1: &0x2::clock::Clock, arg2: &mut GameWallet<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg0 == 0x2::clock::timestamp_ms(arg1) % 2) {
            transfer_bonus_to_gamer<T0>(arg2, arg3);
        };
    }

    public fun init_game_wallet<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GameWallet<T0>{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<GameWallet<T0>>(v0);
    }

    public fun mint_and_transfer_coin_to_game_wallet<T0>(arg0: &mut 0x2::coin::TreasuryCap<T0>, arg1: &mut GameWallet<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg1.balance, 0x2::coin::into_balance<T0>(0x2::coin::mint<T0>(arg0, 1000000, arg2)));
    }

    fun transfer_bonus_to_gamer<T0>(arg0: &mut GameWallet<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.balance, 1000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

