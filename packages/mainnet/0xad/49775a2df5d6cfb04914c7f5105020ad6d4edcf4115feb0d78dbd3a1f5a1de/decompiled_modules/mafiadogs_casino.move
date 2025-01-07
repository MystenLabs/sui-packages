module 0xad49775a2df5d6cfb04914c7f5105020ad6d4edcf4115feb0d78dbd3a1f5a1de::mafiadogs_casino {
    struct Outcome has key {
        id: 0x2::object::UID,
        guess: u8,
        player_won: bool,
        message: vector<u8>,
    }

    struct HouseData has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        house: address,
        public_key: vector<u8>,
    }

    struct Game has key {
        id: 0x2::object::UID,
        guess_placed_epoch: u64,
        stake: 0x2::balance::Balance<0x2::sui::SUI>,
        guess: u8,
        player: address,
        user_randomness: vector<u8>,
    }

    struct HouseCap has key {
        id: 0x2::object::UID,
    }

    public fun balance(arg0: &HouseData) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public entry fun dispute_and_win(arg0: &mut Game, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.guess_placed_epoch + 7 <= 0x2::tx_context::epoch(arg1), 13);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.stake);
        assert!(v0 > 0, 16);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.stake, v0, arg1), arg0.player);
    }

    public fun game_guess(arg0: &Game) : u8 {
        arg0.guess
    }

    public(friend) fun give_change(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) >= arg1, 9);
        if (0x2::coin::value<0x2::sui::SUI>(&arg0) == arg1) {
            return arg0
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg2));
        0x2::coin::split<0x2::sui::SUI>(&mut arg0, arg1, arg2)
    }

    public fun guess_placed_epoch(arg0: &Game) : u64 {
        arg0.guess_placed_epoch
    }

    public fun house(arg0: &HouseData) : address {
        arg0.house
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = HouseCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<HouseCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun initialize_house_data(arg0: HouseCap, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) > 0, 15);
        let v0 = HouseData{
            id         : 0x2::object::new(arg2),
            balance    : 0x2::coin::into_balance<0x2::sui::SUI>(arg1),
            house      : 0x2::tx_context::sender(arg2),
            public_key : x"90e1d8fc16ed2a258d68d720d462128903d4d6b4512e093df4168f3739cf595cc69e1bee7127d4d89d7fa695c718d14e",
        };
        let HouseCap { id: v1 } = arg0;
        0x2::object::delete(v1);
        0x2::transfer::share_object<HouseData>(v0);
    }

    public fun outcome_guess(arg0: &Outcome) : u8 {
        arg0.guess
    }

    public entry fun play(arg0: &mut Game, arg1: vector<u8>, arg2: &mut HouseData, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id_bytes<Game>(arg0);
        let v1 = v0;
        0x1::vector::append<u8>(&mut v1, player_randomness(arg0));
        assert!(0x2::bls12381::bls12381_min_pk_verify(&arg1, &arg2.public_key, &v1), 10);
        let v2 = arg0.guess == *0x1::vector::borrow<u8>(&arg1, 0) % 4;
        if (v2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.stake, stake(arg0), arg3), arg0.player);
        } else {
            0x2::balance::join<0x2::sui::SUI>(&mut arg2.balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.stake, stake(arg0), arg3)));
        };
        let v3 = Outcome{
            id         : 0x2::object::new(arg3),
            guess      : arg0.guess,
            player_won : v2,
            message    : v1,
        };
        0x2::transfer::share_object<Outcome>(v3);
    }

    public fun player(arg0: &Game) : address {
        arg0.player
    }

    public fun player_randomness(arg0: &Game) : vector<u8> {
        arg0.user_randomness
    }

    public fun player_won(arg0: &Outcome) : bool {
        arg0.player_won
    }

    public fun public_key(arg0: &HouseData) : vector<u8> {
        arg0.public_key
    }

    public fun stake(arg0: &Game) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.stake)
    }

    public entry fun start_game(arg0: u8, arg1: vector<u8>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut HouseData, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 == 1 || arg0 == 0, 14);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= 1000000000, 15);
        let v0 = give_change(arg2, 1000000000, arg4);
        let v1 = 0x2::coin::into_balance<0x2::sui::SUI>(v0);
        if (balance(arg3) >= 1000000000) {
            0x2::balance::join<0x2::sui::SUI>(&mut v1, 0x2::balance::split<0x2::sui::SUI>(&mut arg3.balance, 1000000000));
        };
        let v2 = Game{
            id                 : 0x2::object::new(arg4),
            guess_placed_epoch : 0x2::tx_context::epoch(arg4),
            stake              : v1,
            guess              : arg0,
            player             : 0x2::tx_context::sender(arg4),
            user_randomness    : arg1,
        };
        0x2::transfer::share_object<Game>(v2);
    }

    public entry fun top_up(arg0: &mut HouseData, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public entry fun withdraw(arg0: &mut HouseData, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.house, 12);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, 0x2::balance::value<0x2::sui::SUI>(&arg0.balance), arg1), arg0.house);
    }

    // decompiled from Move bytecode v6
}

