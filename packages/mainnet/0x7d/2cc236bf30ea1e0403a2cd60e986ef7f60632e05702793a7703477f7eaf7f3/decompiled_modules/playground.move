module 0x7d2cc236bf30ea1e0403a2cd60e986ef7f60632e05702793a7703477f7eaf7f3::playground {
    struct GamePool has key {
        id: 0x2::object::UID,
        jackpot_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        current_round: u64,
    }

    struct JackpotClaimed has copy, drop {
        winner: address,
        amount: u64,
        round: u64,
    }

    public entry fun claim_jackpot(arg0: &mut GamePool, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.jackpot_pool);
        assert!(v0 > 0, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.jackpot_pool), arg2), 0x2::tx_context::sender(arg2));
        let v1 = JackpotClaimed{
            winner : 0x2::tx_context::sender(arg2),
            amount : v0,
            round  : arg0.current_round,
        };
        0x2::event::emit<JackpotClaimed>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GamePool{
            id            : 0x2::object::new(arg0),
            jackpot_pool  : 0x2::balance::zero<0x2::sui::SUI>(),
            current_round : 0,
        };
        0x2::transfer::share_object<GamePool>(v0);
    }

    // decompiled from Move bytecode v6
}

