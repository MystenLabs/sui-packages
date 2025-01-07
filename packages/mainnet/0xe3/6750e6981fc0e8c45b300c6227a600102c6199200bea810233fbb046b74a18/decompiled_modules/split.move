module 0xe36750e6981fc0e8c45b300c6227a600102c6199200bea810233fbb046b74a18::split {
    struct Director has key {
        id: 0x2::object::UID,
        rounds: vector<Round>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Round has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x6ff12a5759a7507a0cf48378868c92dce4c4de4c25f11213858212f497b9ddec::chenerge_faucet::CHENERGE_FAUCET>,
        players: vector<address>,
        playersDeposit: 0x2::table::Table<address, u64>,
        totalDeposit: u64,
        drawed: bool,
        winner1: 0x1::option::Option<address>,
        winner2: 0x1::option::Option<address>,
    }

    struct EventDeposit has copy, drop {
        player: address,
        amount: u64,
    }

    struct EventDraw has copy, drop {
        winner1Index: u64,
        winner2Index: u64,
        winner1Address: address,
        winner2Address: address,
        winner1Amount: u64,
        winner2Amount: u64,
    }

    struct EventRnd has copy, drop {
        total: u8,
        winner1Index: u64,
        winner2Index: u64,
    }

    struct EventAmount has copy, drop {
        amount: u64,
        winner1PrizeAmount: u64,
        winner2PrizeAmount: u64,
    }

    public entry fun deposit(arg0: &mut Director, arg1: 0x2::coin::Coin<0x6ff12a5759a7507a0cf48378868c92dce4c4de4c25f11213858212f497b9ddec::chenerge_faucet::CHENERGE_FAUCET>, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x1::vector::is_empty<Round>(&arg0.rounds)) {
            let v0 = Round{
                id             : 0x2::object::new(arg2),
                balance        : 0x2::balance::zero<0x6ff12a5759a7507a0cf48378868c92dce4c4de4c25f11213858212f497b9ddec::chenerge_faucet::CHENERGE_FAUCET>(),
                players        : 0x1::vector::empty<address>(),
                playersDeposit : 0x2::table::new<address, u64>(arg2),
                totalDeposit   : 0,
                drawed         : false,
                winner1        : 0x1::option::none<address>(),
                winner2        : 0x1::option::none<address>(),
            };
            0x1::vector::push_back<Round>(&mut arg0.rounds, v0);
        };
        let v1 = 0x1::vector::borrow_mut<Round>(&mut arg0.rounds, 0x1::vector::length<Round>(&arg0.rounds) - 1);
        let v2 = v1;
        if (v1.drawed) {
            let v3 = Round{
                id             : 0x2::object::new(arg2),
                balance        : 0x2::balance::zero<0x6ff12a5759a7507a0cf48378868c92dce4c4de4c25f11213858212f497b9ddec::chenerge_faucet::CHENERGE_FAUCET>(),
                players        : 0x1::vector::empty<address>(),
                playersDeposit : 0x2::table::new<address, u64>(arg2),
                totalDeposit   : 0,
                drawed         : false,
                winner1        : 0x1::option::none<address>(),
                winner2        : 0x1::option::none<address>(),
            };
            0x1::vector::push_back<Round>(&mut arg0.rounds, v3);
            v2 = 0x1::vector::borrow_mut<Round>(&mut arg0.rounds, 0x1::vector::length<Round>(&arg0.rounds) - 1);
        };
        let v4 = 0x2::coin::into_balance<0x6ff12a5759a7507a0cf48378868c92dce4c4de4c25f11213858212f497b9ddec::chenerge_faucet::CHENERGE_FAUCET>(arg1);
        let v5 = 0x2::balance::value<0x6ff12a5759a7507a0cf48378868c92dce4c4de4c25f11213858212f497b9ddec::chenerge_faucet::CHENERGE_FAUCET>(&v4);
        v2.totalDeposit = v2.totalDeposit + v5;
        let v6 = 0x2::tx_context::sender(arg2);
        if (0x2::table::contains<address, u64>(&v2.playersDeposit, v6)) {
            let v7 = 0x2::table::borrow_mut<address, u64>(&mut v2.playersDeposit, v6);
            *v7 = *v7 + v5;
        } else {
            0x2::table::add<address, u64>(&mut v2.playersDeposit, v6, v5);
        };
        if (!0x1::vector::contains<address>(&v2.players, &v6)) {
            0x1::vector::push_back<address>(&mut v2.players, v6);
        };
        0x2::balance::join<0x6ff12a5759a7507a0cf48378868c92dce4c4de4c25f11213858212f497b9ddec::chenerge_faucet::CHENERGE_FAUCET>(&mut v2.balance, v4);
        let v8 = EventDeposit{
            player : v6,
            amount : v5,
        };
        0x2::event::emit<EventDeposit>(v8);
    }

    public entry fun draw(arg0: &AdminCap, arg1: &mut Director, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<Round>(&arg1.rounds) > 0, 1);
        let v0 = 0x1::vector::borrow_mut<Round>(&mut arg1.rounds, 0x1::vector::length<Round>(&arg1.rounds) - 1);
        let v1 = 0x1::vector::length<address>(&v0.players);
        assert!(v1 > 1, 2);
        assert!(!v0.drawed, 3);
        let v2 = 0x2::random::new_generator(arg2, arg3);
        let v3 = 0x2::random::generate_u64_in_range(&mut v2, 0, 1024) % v1;
        let v4 = 0x2::random::generate_u64_in_range(&mut v2, 0, 1024) % v1;
        let v5 = EventRnd{
            total        : (v1 as u8),
            winner1Index : v3,
            winner2Index : v4,
        };
        0x2::event::emit<EventRnd>(v5);
        let v6 = 0x1::vector::borrow<address>(&v0.players, v3);
        let v7 = 0x1::vector::borrow<address>(&v0.players, v4);
        let v8 = 0x2::balance::value<0x6ff12a5759a7507a0cf48378868c92dce4c4de4c25f11213858212f497b9ddec::chenerge_faucet::CHENERGE_FAUCET>(&v0.balance);
        let v9 = v8 / 2;
        let v10 = v8 - v9;
        let v11 = EventAmount{
            amount             : v8,
            winner1PrizeAmount : v9,
            winner2PrizeAmount : v10,
        };
        0x2::event::emit<EventAmount>(v11);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x6ff12a5759a7507a0cf48378868c92dce4c4de4c25f11213858212f497b9ddec::chenerge_faucet::CHENERGE_FAUCET>>(0x2::coin::from_balance<0x6ff12a5759a7507a0cf48378868c92dce4c4de4c25f11213858212f497b9ddec::chenerge_faucet::CHENERGE_FAUCET>(0x2::balance::split<0x6ff12a5759a7507a0cf48378868c92dce4c4de4c25f11213858212f497b9ddec::chenerge_faucet::CHENERGE_FAUCET>(&mut v0.balance, v9), arg3), *v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x6ff12a5759a7507a0cf48378868c92dce4c4de4c25f11213858212f497b9ddec::chenerge_faucet::CHENERGE_FAUCET>>(0x2::coin::from_balance<0x6ff12a5759a7507a0cf48378868c92dce4c4de4c25f11213858212f497b9ddec::chenerge_faucet::CHENERGE_FAUCET>(0x2::balance::split<0x6ff12a5759a7507a0cf48378868c92dce4c4de4c25f11213858212f497b9ddec::chenerge_faucet::CHENERGE_FAUCET>(&mut v0.balance, v10), arg3), *v7);
        v0.winner1 = 0x1::option::some<address>(*v6);
        v0.winner2 = 0x1::option::some<address>(*v7);
        v0.drawed = true;
        let v12 = EventDraw{
            winner1Index   : v3,
            winner2Index   : v4,
            winner1Address : *v6,
            winner2Address : *v7,
            winner1Amount  : v9,
            winner2Amount  : v10,
        };
        0x2::event::emit<EventDraw>(v12);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = Director{
            id     : 0x2::object::new(arg0),
            rounds : 0x1::vector::empty<Round>(),
        };
        0x2::transfer::share_object<Director>(v1);
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    entry fun rnd(arg0: &0x2::random::Random, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg0, arg1);
        let v1 = EventRnd{
            total        : 3,
            winner1Index : 0x2::random::generate_u64_in_range(&mut v0, 0, 100),
            winner2Index : 0x2::random::generate_u64_in_range(&mut v0, 0, 100),
        };
        0x2::event::emit<EventRnd>(v1);
    }

    // decompiled from Move bytecode v6
}

