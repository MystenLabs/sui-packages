module 0xaaea3c4fd777a4561420b1f92c99afe15fa7e7506653cdc8711f40e423bc0713::Suizino_core {
    struct Casino has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        cost_per_game: u64,
        casino_balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct CasinoOwnership has store, key {
        id: 0x2::object::UID,
    }

    struct GambleEvent has copy, drop {
        id: 0x2::object::ID,
        winnings: u64,
        gambler: address,
        slot_1: u8,
        slot_2: u8,
        slot_3: u8,
    }

    public fun casino_balance(arg0: &Casino) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.casino_balance)
    }

    public fun cost_per_game(arg0: &Casino) : u64 {
        arg0.cost_per_game
    }

    public entry fun depositToCasino(arg0: &CasinoOwnership, arg1: &mut Casino, arg2: u64, arg3: &mut 0x2::coin::Coin<0x2::sui::SUI>) {
        assert!(0x2::coin::value<0x2::sui::SUI>(arg3) > arg2, 1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.casino_balance, 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg3), arg2));
    }

    public entry fun gamble(arg0: &mut Casino, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(casino_balance(arg0) >= arg0.cost_per_game * 5, 2);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg1) >= arg0.cost_per_game, 1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.casino_balance, 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg1), arg0.cost_per_game));
        let v0 = 0x2::object::new(arg2);
        let v1 = pseudoRandomNumGenerator(&v0);
        let v2 = 0;
        let v3 = *0x1::vector::borrow<u8>(&v1, 0);
        let v4 = *0x1::vector::borrow<u8>(&v1, 1);
        let v5 = *0x1::vector::borrow<u8>(&v1, 2);
        if (v3 == v4 && v4 == v5) {
            let v6 = arg0.cost_per_game * (5 + 1);
            v2 = v6;
            0x2::balance::join<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg1), 0x2::balance::split<0x2::sui::SUI>(&mut arg0.casino_balance, v6));
        };
        let v7 = GambleEvent{
            id       : 0x2::object::uid_to_inner(&v0),
            winnings : v2,
            gambler  : 0x2::tx_context::sender(arg2),
            slot_1   : v3,
            slot_2   : v4,
            slot_3   : v5,
        };
        0x2::event::emit<GambleEvent>(v7);
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CasinoOwnership{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<CasinoOwnership>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Casino{
            id             : 0x2::object::new(arg0),
            name           : 0x1::string::utf8(b"Suizino"),
            description    : 0x1::string::utf8(b"A small unsafe Suizino. Created by Manolis Liolios"),
            cost_per_game  : 5000,
            casino_balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<Casino>(v1);
    }

    fun pseudoRandomNumGenerator(arg0: &0x2::object::UID) : vector<u8> {
        let v0 = 0x2::object::uid_to_bytes(arg0);
        let v1 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v1, (*0x1::vector::borrow<u8>(&v0, 0) as u8) % 4);
        0x1::vector::push_back<u8>(&mut v1, (*0x1::vector::borrow<u8>(&v0, 1) as u8) % 4);
        0x1::vector::push_back<u8>(&mut v1, (*0x1::vector::borrow<u8>(&v0, 2) as u8) % 4);
        v1
    }

    public entry fun withdraw(arg0: &CasinoOwnership, arg1: &mut Casino, arg2: u64, arg3: &mut 0x2::coin::Coin<0x2::sui::SUI>) {
        assert!(casino_balance(arg1) > arg2, 1);
        0x2::balance::join<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg3), 0x2::balance::split<0x2::sui::SUI>(&mut arg1.casino_balance, arg2));
    }

    // decompiled from Move bytecode v6
}

