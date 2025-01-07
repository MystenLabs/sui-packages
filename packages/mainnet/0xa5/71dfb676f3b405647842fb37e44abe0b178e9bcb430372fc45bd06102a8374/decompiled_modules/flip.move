module 0xa571dfb676f3b405647842fb37e44abe0b178e9bcb430372fc45bd06102a8374::flip {
    struct HouseData has key {
        id: 0x2::object::UID,
        house: address,
        max_bet: u64,
        fee_percentage: u64,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        players: 0x2::vec_map::VecMap<address, Player>,
        seed: u64,
    }

    struct Player has store, key {
        id: 0x2::object::UID,
        total_win: u64,
        total_loss: u64,
        total_bet: u64,
        rewards: u64,
    }

    struct FlipEvent has copy, drop {
        id: 0x2::object::ID,
        player: address,
        bet_amount: u64,
        result: bool,
        reward: u64,
    }

    public entry fun flip(arg0: &mut HouseData, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: u64, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        if (!0x2::vec_map::contains<address, Player>(&arg0.players, &v0)) {
            let v1 = Player{
                id         : 0x2::object::new(arg5),
                total_win  : 0,
                total_loss : 0,
                total_bet  : 0,
                rewards    : 0,
            };
            0x2::vec_map::insert<address, Player>(&mut arg0.players, v0, v1);
        };
        assert!(arg3 <= arg0.max_bet, 3);
        let v2 = 0x2::vec_map::get_mut<address, Player>(&mut arg0.players, &v0);
        let v3 = give_change(arg1, arg3, arg5);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(v3));
        v2.total_bet = v2.total_bet + arg3;
        let v4 = 0x2::clock::timestamp_ms(arg2) % 2 == 1;
        let v5 = 0;
        if (v4 == arg4) {
            v2.total_win = v2.total_win + 1;
            let v6 = arg3 * 2 - arg3 * arg0.fee_percentage / 1000;
            v5 = v6;
            v2.rewards = v2.rewards + v6;
        } else {
            v2.total_loss = v2.total_loss + 1;
        };
        let v7 = FlipEvent{
            id         : 0x2::object::uid_to_inner(&v2.id),
            player     : 0x2::tx_context::sender(arg5),
            bet_amount : arg3,
            result     : v4 == arg4,
            reward     : v5,
        };
        0x2::event::emit<FlipEvent>(v7);
    }

    public entry fun claim(arg0: &mut HouseData, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::vec_map::contains<address, Player>(&arg0.players, &v0), 5);
        let v1 = 0x2::vec_map::get_mut<address, Player>(&mut arg0.players, &v0);
        assert!(v1.rewards > 0, 4);
        v1.rewards = 0;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, v1.rewards, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun deposit(arg0: &mut HouseData, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(give_change(arg1, arg2, arg3)));
    }

    public fun get_reward_flip(arg0: &HouseData, arg1: address) : u64 {
        0x2::vec_map::get<address, Player>(&arg0.players, &arg1).rewards
    }

    fun give_change(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) >= arg1, 1);
        if (0x2::coin::value<0x2::sui::SUI>(&arg0) == arg1) {
            return arg0
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg2));
        0x2::coin::split<0x2::sui::SUI>(&mut arg0, arg1, arg2)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = HouseData{
            id             : 0x2::object::new(arg0),
            house          : 0x2::tx_context::sender(arg0),
            max_bet        : 1000000,
            fee_percentage : 35,
            balance        : 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::zero<0x2::sui::SUI>(arg0)),
            players        : 0x2::vec_map::empty<address, Player>(),
            seed           : 1683859803791,
        };
        0x2::transfer::share_object<HouseData>(v0);
    }

    public entry fun withdraw(arg0: &mut HouseData, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.house == 0x2::tx_context::sender(arg2), 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

