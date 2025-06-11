module 0x12225f812cbff766677d3513ed85f89cbd26e83c5a7d61ef5b5583e58d83f47e::blackjack {
    public fun max_sqrt_price() : u128 {
        79226673515401279992447579055
    }

    public fun min_sqrt_price() : u128 {
        4295048016
    }

    public fun process_player_move<T0>(arg0: &mut 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::Unihouse, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: address, arg6: 0x1::string::String) {
        assert!(arg5 == @0xc1a02183f9184607fd75ff6f87a04b252afa0838334007ffe434a1fa380ee6b9, 1);
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::emit_blackjack_game_result<T0, 0x5e2f4359b5c0311954f502c4e1e12a845e85152b67e033ca6f8590b5781606ff::blackjack::Blackjack>(arg0, arg1, arg2, arg3, arg4, 0x1::vector::empty<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::game_structs::BlackjackHand>(), 0x1::vector::empty<u8>(), arg5, arg6);
    }

    // decompiled from Move bytecode v7
}

