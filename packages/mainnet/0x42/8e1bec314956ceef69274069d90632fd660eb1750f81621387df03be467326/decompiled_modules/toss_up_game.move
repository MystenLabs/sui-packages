module 0x428e1bec314956ceef69274069d90632fd660eb1750f81621387df03be467326::toss_up_game {
    struct Jackpot has key {
        id: 0x2::object::UID,
        prize: 0x2::balance::Balance<0x571a748747d0b3583a4ca885806a7d373f08f19deecebf568b3e68b2bb07c457::blazeleon_faucet::BLAZELEON_FAUCET>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct GameResultEvent has copy, drop {
        user_address: address,
        bet_content: bool,
        bet_amt: u64,
        game_result: bool,
    }

    entry fun bet(arg0: bool, arg1: &mut 0x2::coin::Coin<0x571a748747d0b3583a4ca885806a7d373f08f19deecebf568b3e68b2bb07c457::blazeleon_faucet::BLAZELEON_FAUCET>, arg2: u64, arg3: &0x2::random::Random, arg4: &mut Jackpot, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x571a748747d0b3583a4ca885806a7d373f08f19deecebf568b3e68b2bb07c457::blazeleon_faucet::BLAZELEON_FAUCET>(arg1) >= arg2, 0);
        assert!(arg2 * 10 <= 0x2::balance::value<0x571a748747d0b3583a4ca885806a7d373f08f19deecebf568b3e68b2bb07c457::blazeleon_faucet::BLAZELEON_FAUCET>(&arg4.prize), 1);
        let v0 = 0x2::random::new_generator(arg3, arg5);
        let v1 = 0x2::random::generate_bool(&mut v0);
        let v2 = GameResultEvent{
            user_address : 0x2::tx_context::sender(arg5),
            bet_content  : arg0,
            bet_amt      : arg2,
            game_result  : v1,
        };
        0x2::event::emit<GameResultEvent>(v2);
        if (arg0 == v1) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x571a748747d0b3583a4ca885806a7d373f08f19deecebf568b3e68b2bb07c457::blazeleon_faucet::BLAZELEON_FAUCET>>(0x2::coin::split<0x571a748747d0b3583a4ca885806a7d373f08f19deecebf568b3e68b2bb07c457::blazeleon_faucet::BLAZELEON_FAUCET>(arg1, arg2, arg5), 0x2::tx_context::sender(arg5));
            0x2::transfer::public_transfer<0x2::coin::Coin<0x571a748747d0b3583a4ca885806a7d373f08f19deecebf568b3e68b2bb07c457::blazeleon_faucet::BLAZELEON_FAUCET>>(0x2::coin::from_balance<0x571a748747d0b3583a4ca885806a7d373f08f19deecebf568b3e68b2bb07c457::blazeleon_faucet::BLAZELEON_FAUCET>(0x2::balance::split<0x571a748747d0b3583a4ca885806a7d373f08f19deecebf568b3e68b2bb07c457::blazeleon_faucet::BLAZELEON_FAUCET>(&mut arg4.prize, arg2), arg5), 0x2::tx_context::sender(arg5));
        } else {
            0x2::balance::join<0x571a748747d0b3583a4ca885806a7d373f08f19deecebf568b3e68b2bb07c457::blazeleon_faucet::BLAZELEON_FAUCET>(&mut arg4.prize, 0x2::coin::into_balance<0x571a748747d0b3583a4ca885806a7d373f08f19deecebf568b3e68b2bb07c457::blazeleon_faucet::BLAZELEON_FAUCET>(0x2::coin::split<0x571a748747d0b3583a4ca885806a7d373f08f19deecebf568b3e68b2bb07c457::blazeleon_faucet::BLAZELEON_FAUCET>(arg1, arg2, arg5)));
        };
    }

    public entry fun deposit(arg0: &mut 0x2::coin::Coin<0x571a748747d0b3583a4ca885806a7d373f08f19deecebf568b3e68b2bb07c457::blazeleon_faucet::BLAZELEON_FAUCET>, arg1: u64, arg2: &mut Jackpot, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x571a748747d0b3583a4ca885806a7d373f08f19deecebf568b3e68b2bb07c457::blazeleon_faucet::BLAZELEON_FAUCET>(arg0) >= arg1, 0);
        0x2::balance::join<0x571a748747d0b3583a4ca885806a7d373f08f19deecebf568b3e68b2bb07c457::blazeleon_faucet::BLAZELEON_FAUCET>(&mut arg2.prize, 0x2::coin::into_balance<0x571a748747d0b3583a4ca885806a7d373f08f19deecebf568b3e68b2bb07c457::blazeleon_faucet::BLAZELEON_FAUCET>(0x2::coin::split<0x571a748747d0b3583a4ca885806a7d373f08f19deecebf568b3e68b2bb07c457::blazeleon_faucet::BLAZELEON_FAUCET>(arg0, arg1, arg3)));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Jackpot{
            id    : 0x2::object::new(arg0),
            prize : 0x2::balance::zero<0x571a748747d0b3583a4ca885806a7d373f08f19deecebf568b3e68b2bb07c457::blazeleon_faucet::BLAZELEON_FAUCET>(),
        };
        0x2::transfer::share_object<Jackpot>(v1);
    }

    public entry fun make_withdrawal(arg0: &AdminCap, arg1: u64, arg2: &mut Jackpot, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x571a748747d0b3583a4ca885806a7d373f08f19deecebf568b3e68b2bb07c457::blazeleon_faucet::BLAZELEON_FAUCET>(&arg2.prize) >= arg1, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x571a748747d0b3583a4ca885806a7d373f08f19deecebf568b3e68b2bb07c457::blazeleon_faucet::BLAZELEON_FAUCET>>(0x2::coin::from_balance<0x571a748747d0b3583a4ca885806a7d373f08f19deecebf568b3e68b2bb07c457::blazeleon_faucet::BLAZELEON_FAUCET>(0x2::balance::split<0x571a748747d0b3583a4ca885806a7d373f08f19deecebf568b3e68b2bb07c457::blazeleon_faucet::BLAZELEON_FAUCET>(&mut arg2.prize, arg1), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun withdraw_and_transfer(arg0: &AdminCap, arg1: u64, arg2: address, arg3: &mut Jackpot, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x571a748747d0b3583a4ca885806a7d373f08f19deecebf568b3e68b2bb07c457::blazeleon_faucet::BLAZELEON_FAUCET>(&arg3.prize) >= arg1, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x571a748747d0b3583a4ca885806a7d373f08f19deecebf568b3e68b2bb07c457::blazeleon_faucet::BLAZELEON_FAUCET>>(0x2::coin::from_balance<0x571a748747d0b3583a4ca885806a7d373f08f19deecebf568b3e68b2bb07c457::blazeleon_faucet::BLAZELEON_FAUCET>(0x2::balance::split<0x571a748747d0b3583a4ca885806a7d373f08f19deecebf568b3e68b2bb07c457::blazeleon_faucet::BLAZELEON_FAUCET>(&mut arg3.prize, arg1), arg4), arg2);
    }

    // decompiled from Move bytecode v6
}

