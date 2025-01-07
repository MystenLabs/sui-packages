module 0x21408556c892d8b927bf7e7dcbd7cf61c070bb1043b330ce83267669ad8840f5::game {
    struct Game has key {
        id: 0x2::object::UID,
        creator: address,
        reward_amount: u64,
        reward_factor: u64,
        base_epoch: u64,
        base_drand_round: u64,
    }

    struct Reward has key {
        id: 0x2::object::UID,
        game_id: 0x2::object::ID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct Ticket has store, key {
        id: 0x2::object::UID,
        game_id: 0x2::object::ID,
    }

    struct Winner has store, key {
        id: 0x2::object::UID,
        game_id: 0x2::object::ID,
    }

    public entry fun buy_ticket(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &Game, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) * arg1.reward_factor == arg1.reward_amount, 0);
        assert!(0x2::tx_context::epoch(arg2) == arg1.base_epoch, 1);
        let v0 = Ticket{
            id      : 0x2::object::new(arg2),
            game_id : 0x2::object::id<Game>(arg1),
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, arg1.creator);
        0x2::transfer::public_transfer<Ticket>(v0, 0x2::tx_context::sender(arg2));
    }

    public entry fun create(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0 && v0 % arg1 == 0, 4);
        let v1 = Game{
            id               : 0x2::object::new(arg3),
            creator          : 0x2::tx_context::sender(arg3),
            reward_amount    : 0x2::coin::value<0x2::sui::SUI>(&arg0),
            reward_factor    : arg1,
            base_epoch       : 0x2::tx_context::epoch(arg3),
            base_drand_round : arg2,
        };
        let v2 = Reward{
            id      : 0x2::object::new(arg3),
            game_id : 0x2::object::id<Game>(&v1),
            balance : 0x2::coin::into_balance<0x2::sui::SUI>(arg0),
        };
        0x2::transfer::freeze_object<Game>(v1);
        0x2::transfer::share_object<Reward>(v2);
    }

    public entry fun delete_ticket(arg0: Ticket) {
        let Ticket {
            id      : v0,
            game_id : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun end_of_game_round(arg0: u64) : u64 {
        arg0 + 0
    }

    public entry fun evaluate(arg0: Ticket, arg1: &Game, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.game_id == 0x2::object::id<Game>(arg1), 2);
        0x21408556c892d8b927bf7e7dcbd7cf61c070bb1043b330ce83267669ad8840f5::drand_lib::verify_drand_signature(arg2, end_of_game_round(arg1.base_drand_round));
        let v0 = 0x21408556c892d8b927bf7e7dcbd7cf61c070bb1043b330ce83267669ad8840f5::drand_lib::derive_randomness(arg2);
        let v1 = 0x2::object::id<Ticket>(&arg0);
        let v2 = 0x2::object::id_to_bytes(&v1);
        let v3 = 0x2::hmac::hmac_sha3_256(&v0, &v2);
        if (0x21408556c892d8b927bf7e7dcbd7cf61c070bb1043b330ce83267669ad8840f5::drand_lib::safe_selection(arg1.reward_factor, &v3) == 0) {
            let v4 = Winner{
                id      : 0x2::object::new(arg3),
                game_id : 0x2::object::id<Game>(arg1),
            };
            0x2::transfer::public_transfer<Winner>(v4, 0x2::tx_context::sender(arg3));
        };
        let Ticket {
            id      : v5,
            game_id : _,
        } = arg0;
        0x2::object::delete(v5);
    }

    public fun get_game_base_drand_round(arg0: &Game) : u64 {
        arg0.base_drand_round
    }

    public fun get_game_base_epoch(arg0: &Game) : u64 {
        arg0.base_epoch
    }

    public entry fun redeem(arg0: &mut Reward, arg1: &Game, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.balance) > 0, 4);
        assert!(0x2::object::id<Game>(arg1) == arg0.game_id, 6);
        assert!(arg1.base_epoch + 3 < 0x2::tx_context::epoch(arg2), 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, 0x2::balance::value<0x2::sui::SUI>(&arg0.balance), arg2), arg1.creator);
    }

    public entry fun take_reward(arg0: Winner, arg1: &mut Reward, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.game_id == arg1.game_id, 2);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.balance);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.balance, v0, arg2), 0x2::tx_context::sender(arg2));
        };
        let Winner {
            id      : v1,
            game_id : _,
        } = arg0;
        0x2::object::delete(v1);
    }

    // decompiled from Move bytecode v6
}

