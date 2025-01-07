module 0xfdc20916ccc10de146115def5058b906b756439f75a4affcb544af564ed18bac::coin_flip {
    struct Outcome has copy, drop {
        game_id: 0x2::object::ID,
        guess: u8,
        player_won: bool,
        bet_amount: u64,
    }

    struct HouseData has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        house: address,
        public_key: vector<u8>,
        max_stake: u64,
        min_stake: u64,
        fees: 0x2::balance::Balance<0x2::sui::SUI>,
        base_fee_in_bp: u16,
        capy_owner_fee_in_bp: u16,
    }

    struct Game has key {
        id: 0x2::object::UID,
        guess_placed_epoch: u64,
        stake: 0x2::balance::Balance<0x2::sui::SUI>,
        guess: u8,
        player: address,
        user_randomness: vector<u8>,
        fee_bp: u16,
    }

    struct HouseCap has key {
        id: 0x2::object::UID,
    }

    public fun balance(arg0: &HouseData) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun base_fee_in_bp(arg0: &HouseData) : u16 {
        arg0.base_fee_in_bp
    }

    public fun capy_owner_fee_in_bp(arg0: &HouseData) : u16 {
        arg0.capy_owner_fee_in_bp
    }

    public entry fun claim_fees(arg0: &mut HouseData, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.house, 12);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.fees, 0x2::balance::value<0x2::sui::SUI>(&arg0.fees), arg1), arg0.house);
    }

    public entry fun dispute_and_win(arg0: &mut Game, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.guess_placed_epoch + 7 <= 0x2::tx_context::epoch(arg1), 13);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.stake);
        assert!(v0 > 0, 16);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.stake, v0, arg1), arg0.player);
        let v1 = Outcome{
            game_id    : 0x2::object::uid_to_inner(&arg0.id),
            guess      : game_guess(arg0),
            player_won : true,
            bet_amount : v0,
        };
        0x2::event::emit<Outcome>(v1);
    }

    public fun fee_amount(arg0: &Game) : u64 {
        (((stake(arg0) as u128) * (fee_in_bp(arg0) as u128) / 10000) as u64)
    }

    public fun fee_in_bp(arg0: &Game) : u16 {
        arg0.fee_bp
    }

    public fun fees(arg0: &HouseData) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.fees)
    }

    public fun game_guess(arg0: &Game) : u8 {
        arg0.guess
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

    public entry fun initialize_house_data(arg0: HouseCap, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) > 0, 15);
        let v0 = HouseData{
            id                   : 0x2::object::new(arg3),
            balance              : 0x2::coin::into_balance<0x2::sui::SUI>(arg1),
            house                : 0x2::tx_context::sender(arg3),
            public_key           : arg2,
            max_stake            : 50000000000,
            min_stake            : 1000000000,
            fees                 : 0x2::balance::zero<0x2::sui::SUI>(),
            base_fee_in_bp       : 100,
            capy_owner_fee_in_bp : 50,
        };
        let HouseCap { id: v1 } = arg0;
        0x2::object::delete(v1);
        0x2::transfer::share_object<HouseData>(v0);
    }

    public fun max_stake(arg0: &HouseData) : u64 {
        arg0.max_stake
    }

    public fun min_stake(arg0: &HouseData) : u64 {
        arg0.min_stake
    }

    public fun outcome_guess(arg0: &Outcome) : u8 {
        arg0.guess
    }

    public entry fun play(arg0: &mut Game, arg1: vector<u8>, arg2: &mut HouseData, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(stake(arg0) > 0, 18);
        let v0 = 0x2::object::id_bytes<Game>(arg0);
        let v1 = v0;
        0x1::vector::append<u8>(&mut v1, player_randomness(arg0));
        assert!(0x2::bls12381::bls12381_min_pk_verify(&arg1, &arg2.public_key, &v1), 10);
        let v2 = arg0.guess == *0x1::vector::borrow<u8>(&arg1, 0) % 2;
        let v3 = fee_amount(arg0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg2.fees, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.stake, v3));
        let v4 = stake(arg0);
        if (v2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.stake, v4, arg3), arg0.player);
        } else {
            0x2::balance::join<0x2::sui::SUI>(&mut arg2.balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.stake, v4, arg3)));
        };
        let v5 = Outcome{
            game_id    : 0x2::object::uid_to_inner(&arg0.id),
            guess      : game_guess(arg0),
            player_won : v2,
            bet_amount : v3 + v4,
        };
        0x2::event::emit<Outcome>(v5);
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
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v0 <= arg3.max_stake, 7);
        assert!(v0 >= arg3.min_stake, 6);
        assert!(balance(arg3) >= v0, 17);
        let v1 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        0x2::balance::join<0x2::sui::SUI>(&mut v1, 0x2::balance::split<0x2::sui::SUI>(&mut arg3.balance, v0));
        let v2 = Game{
            id                 : 0x2::object::new(arg4),
            guess_placed_epoch : 0x2::tx_context::epoch(arg4),
            stake              : v1,
            guess              : arg0,
            player             : 0x2::tx_context::sender(arg4),
            user_randomness    : arg1,
            fee_bp             : base_fee_in_bp(arg3),
        };
        0x2::transfer::share_object<Game>(v2);
    }

    public entry fun start_game_with_capy(arg0: 0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::SuiFren<0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::capy::Capy>, arg1: u8, arg2: vector<u8>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut HouseData, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 == 1 || arg1 == 0, 14);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        assert!(v0 <= arg4.max_stake, 7);
        assert!(v0 >= arg4.min_stake, 6);
        assert!(balance(arg4) >= v0, 17);
        let v1 = 0x2::coin::into_balance<0x2::sui::SUI>(arg3);
        0x2::balance::join<0x2::sui::SUI>(&mut v1, 0x2::balance::split<0x2::sui::SUI>(&mut arg4.balance, v0));
        let v2 = Game{
            id                 : 0x2::object::new(arg5),
            guess_placed_epoch : 0x2::tx_context::epoch(arg5),
            stake              : v1,
            guess              : arg1,
            player             : 0x2::tx_context::sender(arg5),
            user_randomness    : arg2,
            fee_bp             : capy_owner_fee_in_bp(arg4),
        };
        0x2::transfer::public_transfer<0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::SuiFren<0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::capy::Capy>>(arg0, 0x2::tx_context::sender(arg5));
        0x2::transfer::share_object<Game>(v2);
    }

    public entry fun top_up(arg0: &mut HouseData, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public entry fun update_max_stake(arg0: &mut HouseData, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.house, 12);
        arg0.max_stake = arg1;
    }

    public entry fun update_min_stake(arg0: &mut HouseData, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.house, 12);
        arg0.min_stake = arg1;
    }

    public entry fun withdraw(arg0: &mut HouseData, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.house, 12);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, 0x2::balance::value<0x2::sui::SUI>(&arg0.balance), arg1), arg0.house);
    }

    // decompiled from Move bytecode v6
}

