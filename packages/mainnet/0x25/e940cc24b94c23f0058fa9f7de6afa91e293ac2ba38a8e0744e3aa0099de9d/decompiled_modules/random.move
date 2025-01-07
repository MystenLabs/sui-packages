module 0x25e940cc24b94c23f0058fa9f7de6afa91e293ac2ba38a8e0744e3aa0099de9d::random {
    struct RandomWinnerEvent has copy, drop {
        winner_index: u32,
    }

    entry fun pick_random_winner(arg0: u32, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg1, arg2);
        let v1 = RandomWinnerEvent{winner_index: 0x2::random::generate_u32_in_range(&mut v0, 0, arg0 - 1)};
        0x2::event::emit<RandomWinnerEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

