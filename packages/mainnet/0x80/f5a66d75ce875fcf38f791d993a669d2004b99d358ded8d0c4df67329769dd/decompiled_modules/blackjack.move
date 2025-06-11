module 0x80f5a66d75ce875fcf38f791d993a669d2004b99d358ded8d0c4df67329769dd::blackjack {
    public fun get_action<T0, T1: drop>(arg0: &mut 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::Unihouse, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: address, arg6: 0x1::string::String) {
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::emit_blackjack_game_result<T0, T1>(arg0, arg1, arg2, arg3, arg4, 0x1::vector::empty<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::game_structs::BlackjackHand>(), 0x1::vector::empty<u8>(), arg5, arg6);
    }

    public fun max_sqrt_price() : u128 {
        79226673515401279992447579055
    }

    public fun min_sqrt_price() : u128 {
        4295048016
    }

    // decompiled from Move bytecode v7
}

