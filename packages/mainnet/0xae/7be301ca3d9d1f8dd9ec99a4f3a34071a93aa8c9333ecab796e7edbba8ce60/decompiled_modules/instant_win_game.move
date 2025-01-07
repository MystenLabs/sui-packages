module 0xae7be301ca3d9d1f8dd9ec99a4f3a34071a93aa8c9333ecab796e7edbba8ce60::instant_win_game {
    struct Instant_Win_Game has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x5d2aad9075f6d13961d0d08545eaf9e3194b466f9775bc45492e87395ba3059b::faucet_coin::FAUCET_COIN>,
        win1_numbers: vector<u8>,
        win2_numbers: vector<u8>,
        win3_numbers: vector<u8>,
        win1_winning_times: u8,
        win2_winning_times: u8,
        win3_winning_times: u8,
        used_numbers: vector<u8>,
    }

    struct Admin has key {
        id: 0x2::object::UID,
    }

    fun deliverBonus(arg0: &mut Instant_Win_Game, arg1: 0x2::coin::Coin<0x5d2aad9075f6d13961d0d08545eaf9e3194b466f9775bc45492e87395ba3059b::faucet_coin::FAUCET_COIN>, arg2: u8, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        0x1::vector::push_back<u8>(&mut arg0.used_numbers, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x5d2aad9075f6d13961d0d08545eaf9e3194b466f9775bc45492e87395ba3059b::faucet_coin::FAUCET_COIN>>(0x2::coin::from_balance<0x5d2aad9075f6d13961d0d08545eaf9e3194b466f9775bc45492e87395ba3059b::faucet_coin::FAUCET_COIN>(0x2::balance::split<0x5d2aad9075f6d13961d0d08545eaf9e3194b466f9775bc45492e87395ba3059b::faucet_coin::FAUCET_COIN>(&mut arg0.balance, 0x2::coin::value<0x5d2aad9075f6d13961d0d08545eaf9e3194b466f9775bc45492e87395ba3059b::faucet_coin::FAUCET_COIN>(&arg1) * (arg2 as u64)), arg4), 0x2::tx_context::sender(arg4));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x5d2aad9075f6d13961d0d08545eaf9e3194b466f9775bc45492e87395ba3059b::faucet_coin::FAUCET_COIN>>(arg1, 0x2::tx_context::sender(arg4));
    }

    public entry fun deposit(arg0: &mut Instant_Win_Game, arg1: 0x2::coin::Coin<0x5d2aad9075f6d13961d0d08545eaf9e3194b466f9775bc45492e87395ba3059b::faucet_coin::FAUCET_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x5d2aad9075f6d13961d0d08545eaf9e3194b466f9775bc45492e87395ba3059b::faucet_coin::FAUCET_COIN>(&mut arg0.balance, 0x2::coin::into_balance<0x5d2aad9075f6d13961d0d08545eaf9e3194b466f9775bc45492e87395ba3059b::faucet_coin::FAUCET_COIN>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, 5);
        0x1::vector::push_back<u8>(&mut v1, 3);
        0x1::vector::push_back<u8>(&mut v1, 7);
        0x1::vector::push_back<u8>(&mut v2, 1);
        0x1::vector::push_back<u8>(&mut v2, 4);
        0x1::vector::push_back<u8>(&mut v2, 8);
        let v3 = Instant_Win_Game{
            id                 : 0x2::object::new(arg0),
            balance            : 0x2::balance::zero<0x5d2aad9075f6d13961d0d08545eaf9e3194b466f9775bc45492e87395ba3059b::faucet_coin::FAUCET_COIN>(),
            win1_numbers       : v0,
            win2_numbers       : v1,
            win3_numbers       : v2,
            win1_winning_times : 3,
            win2_winning_times : 2,
            win3_winning_times : 1,
            used_numbers       : 0x1::vector::empty<u8>(),
        };
        let v4 = Admin{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<Instant_Win_Game>(v3);
        0x2::transfer::transfer<Admin>(v4, 0x2::tx_context::sender(arg0));
    }

    fun isInThisArray(arg0: u8, arg1: vector<u8>) : bool {
        let v0 = 0;
        let v1 = false;
        while (v0 < 0x1::vector::length<u8>(&arg1)) {
            if (0x1::vector::borrow<u8>(&arg1, v0) == &arg0) {
                v1 = true;
                break
            };
            v0 = v0 + 1;
        };
        v1
    }

    entry fun play(arg0: &mut Instant_Win_Game, arg1: 0x2::coin::Coin<0x5d2aad9075f6d13961d0d08545eaf9e3194b466f9775bc45492e87395ba3059b::faucet_coin::FAUCET_COIN>, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg0.used_numbers) < 10, 1002);
        assert!(0x2::balance::value<0x5d2aad9075f6d13961d0d08545eaf9e3194b466f9775bc45492e87395ba3059b::faucet_coin::FAUCET_COIN>(&arg0.balance) >= 0x2::coin::value<0x5d2aad9075f6d13961d0d08545eaf9e3194b466f9775bc45492e87395ba3059b::faucet_coin::FAUCET_COIN>(&arg1) * 10, 1001);
        let v0;
        loop {
            let v1 = 0x2::random::new_generator(arg2, arg3);
            v0 = 0x2::random::generate_u8(&mut v1) % 10 + 1;
            if (!isInThisArray(v0, arg0.used_numbers)) {
                break
            };
        };
        assert!(v0 < 100, 1002);
        if (isInThisArray(v0, arg0.win1_numbers)) {
            let v2 = arg0.win1_winning_times;
            deliverBonus(arg0, arg1, v2, v0, arg3);
        } else if (isInThisArray(v0, arg0.win2_numbers)) {
            let v3 = arg0.win2_winning_times;
            deliverBonus(arg0, arg1, v3, v0, arg3);
        } else if (isInThisArray(v0, arg0.win3_numbers)) {
            let v4 = arg0.win3_winning_times;
            deliverBonus(arg0, arg1, v4, v0, arg3);
        } else {
            deposit(arg0, arg1, arg3);
        };
    }

    public entry fun withdraw(arg0: &mut Instant_Win_Game, arg1: &Admin, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x5d2aad9075f6d13961d0d08545eaf9e3194b466f9775bc45492e87395ba3059b::faucet_coin::FAUCET_COIN>(&arg0.balance) >= arg2, 1001);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x5d2aad9075f6d13961d0d08545eaf9e3194b466f9775bc45492e87395ba3059b::faucet_coin::FAUCET_COIN>>(0x2::coin::from_balance<0x5d2aad9075f6d13961d0d08545eaf9e3194b466f9775bc45492e87395ba3059b::faucet_coin::FAUCET_COIN>(0x2::balance::split<0x5d2aad9075f6d13961d0d08545eaf9e3194b466f9775bc45492e87395ba3059b::faucet_coin::FAUCET_COIN>(&mut arg0.balance, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

