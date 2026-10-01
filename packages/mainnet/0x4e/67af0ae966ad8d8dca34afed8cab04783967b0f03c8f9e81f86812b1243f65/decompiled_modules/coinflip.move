module 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::coinflip {
    struct FlipResolved has copy, drop {
        pool_id: 0x2::object::ID,
        player: address,
        stake: u64,
        pick_heads: bool,
        result_heads: bool,
        won: bool,
        payout: u64,
    }

    entry fun flip(arg0: &mut 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::Pool, arg1: &0x2::random::Random, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        play(arg0, arg1, arg2, arg3, arg4);
    }

    entry fun flip_with_referrer(arg0: &mut 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::Pool, arg1: &0x2::random::Random, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: bool, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::try_bind_referrer(arg0, 0x2::tx_context::sender(arg5), arg4);
        play(arg0, arg1, arg2, arg3, arg5);
    }

    fun open(arg0: &mut 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::Pool, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        let v1 = 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::win_payout(arg0, v0) - v0;
        0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::open_bet(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(arg1), v1, 0x2::tx_context::sender(arg2));
        (v0, v1)
    }

    fun play(arg0: &mut 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::Pool, arg1: &0x2::random::Random, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = open(arg0, arg2, arg4);
        let v2 = 0x2::random::new_generator(arg1, arg4);
        settle(arg0, v0, v1, arg3, 0x2::random::generate_bool(&mut v2), arg4);
    }

    fun settle(arg0: &mut 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::Pool, arg1: u64, arg2: u64, arg3: bool, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = arg3 == arg4;
        let v1 = if (v0) {
            arg1 + arg2
        } else {
            0
        };
        let v2 = 0x2::tx_context::sender(arg5);
        let v3 = FlipResolved{
            pool_id      : 0x2::object::id<0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::Pool>(arg0),
            player       : v2,
            stake        : arg1,
            pick_heads   : arg3,
            result_heads : arg4,
            won          : v0,
            payout       : v1,
        };
        0x2::event::emit<FlipResolved>(v3);
        if (v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::settle_bet(arg0, arg1, arg2, v1), arg5), v2);
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::settle_bet(arg0, arg1, arg2, v1));
        };
    }

    // decompiled from Move bytecode v7
}

