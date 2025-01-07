module 0x774cca12cd3d60e5bb1d3f5ccdcdd8f3fb60fc0ab01b352c0f8fd48f438fd518::minority {
    struct Game<phantom T0> has store, key {
        id: 0x2::object::UID,
        creator: address,
        players: vector<address>,
        yes_players: vector<address>,
        no_players: vector<address>,
        fund: 0x2::balance::Balance<T0>,
        question: 0x1::string::String,
    }

    struct Player has store {
        name: 0x1::string::String,
        email: 0x1::string::String,
    }

    struct GameCrteated has copy, drop {
        id: 0x2::object::ID,
        creator: address,
    }

    public entry fun create_game<T0>(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = Game<T0>{
            id          : 0x2::object::new(arg1),
            creator     : v0,
            players     : 0x1::vector::empty<address>(),
            yes_players : 0x1::vector::empty<address>(),
            no_players  : 0x1::vector::empty<address>(),
            fund        : 0x2::coin::into_balance<T0>(0x2::coin::zero<T0>(arg1)),
            question    : 0x1::string::utf8(arg0),
        };
        let v2 = GameCrteated{
            id      : 0x2::object::id<Game<T0>>(&v1),
            creator : v0,
        };
        0x2::event::emit<GameCrteated>(v2);
        0x2::transfer::share_object<Game<T0>>(v1);
    }

    public entry fun join_game<T0>(arg0: &mut Game<T0>, arg1: 0x2::coin::Coin<T0>, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x1::vector::contains<address>(&arg0.no_players, &v0) || 0x1::vector::contains<address>(&arg0.yes_players, &v0);
        assert!(!v1, 0);
        assert!(0x1::vector::length<address>(&arg0.no_players) + 0x1::vector::length<address>(&arg0.yes_players) < 3, 1);
        if (arg2) {
            0x1::vector::push_back<address>(&mut arg0.yes_players, v0);
        } else {
            0x1::vector::push_back<address>(&mut arg0.no_players, v0);
        };
        0x2::coin::put<T0>(&mut arg0.fund, arg1);
    }

    public entry fun settle_game<T0>(arg0: &mut Game<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 2);
        assert!(0x1::vector::length<address>(&arg0.no_players) + 0x1::vector::length<address>(&arg0.yes_players) == 3, 3);
        let v0 = if (0x1::vector::length<address>(&arg0.no_players) < 0x1::vector::length<address>(&arg0.yes_players)) {
            arg0.no_players
        } else {
            arg0.yes_players
        };
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&v0)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.fund, 0x2::balance::value<T0>(&arg0.fund) / (0x1::vector::length<address>(&v0) as u64)), arg1), *0x1::vector::borrow<address>(&v0, v1));
            v1 = v1 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

