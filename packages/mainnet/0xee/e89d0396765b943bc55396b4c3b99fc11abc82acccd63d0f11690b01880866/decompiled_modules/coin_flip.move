module 0xeee89d0396765b943bc55396b4c3b99fc11abc82acccd63d0f11690b01880866::coin_flip {
    struct NewGame has copy, drop {
        game_id: 0x2::object::ID,
        player: address,
        user_randomness: vector<u8>,
        guess: u8,
        stake: u64,
        fee_bp: u16,
    }

    struct Outcome has copy, drop {
        game_id: 0x2::object::ID,
        player_won: bool,
        challenged: bool,
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
        reduced_fee_in_bp: u16,
    }

    struct Game has key {
        id: 0x2::object::UID,
        guess_placed_epoch: u64,
        stake: 0x2::balance::Balance<0x2::sui::SUI>,
        guess: u8,
        player: address,
        user_randomness: vector<u8>,
        fee_bp: u16,
        challenged: bool,
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

    public fun challenged(arg0: &Game) : bool {
        arg0.challenged
    }

    public entry fun claim_fees(arg0: &mut HouseData, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == house(arg0), 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.fees, fees(arg0), arg1), house(arg0));
    }

    public entry fun dispute_and_win(arg0: &mut Game, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(guess_placed_epoch(arg0) + 7 <= 0x2::tx_context::epoch(arg1), 5);
        assert!(!challenged(arg0), 8);
        let v0 = stake(arg0);
        assert!(v0 > 0, 10);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.stake, v0, arg1), player(arg0));
        arg0.challenged = true;
        let v1 = Outcome{
            game_id    : 0x2::object::uid_to_inner(&arg0.id),
            player_won : true,
            challenged : true,
        };
        0x2::event::emit<Outcome>(v1);
    }

    public fun fee_amount(arg0: &Game) : u64 {
        ((((stake(arg0) / (2 as u64)) as u128) * (fee_in_bp(arg0) as u128) / 10000) as u64)
    }

    public fun fee_in_bp(arg0: &Game) : u16 {
        arg0.fee_bp
    }

    public fun fees(arg0: &HouseData) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.fees)
    }

    public fun guess(arg0: &Game) : u8 {
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
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) > 0, 7);
        let v0 = HouseData{
            id                : 0x2::object::new(arg3),
            balance           : 0x2::coin::into_balance<0x2::sui::SUI>(arg1),
            house             : 0x2::tx_context::sender(arg3),
            public_key        : arg2,
            max_stake         : 50000000000,
            min_stake         : 1000000000,
            fees              : 0x2::balance::zero<0x2::sui::SUI>(),
            base_fee_in_bp    : 100,
            reduced_fee_in_bp : 50,
        };
        let HouseCap { id: v1 } = arg0;
        0x2::object::delete(v1);
        0x2::transfer::share_object<HouseData>(v0);
    }

    fun internal_start_game(arg0: u8, arg1: vector<u8>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut HouseData, arg4: u16, arg5: &mut 0x2::tx_context::TxContext) : Game {
        assert!(arg0 == 1 || arg0 == 0, 6);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v0 <= max_stake(arg3), 2);
        assert!(v0 >= min_stake(arg3), 1);
        assert!(balance(arg3) >= v0, 9);
        let v1 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        0x2::balance::join<0x2::sui::SUI>(&mut v1, 0x2::balance::split<0x2::sui::SUI>(&mut arg3.balance, v0));
        let v2 = Game{
            id                 : 0x2::object::new(arg5),
            guess_placed_epoch : 0x2::tx_context::epoch(arg5),
            stake              : v1,
            guess              : arg0,
            player             : 0x2::tx_context::sender(arg5),
            user_randomness    : arg1,
            fee_bp             : arg4,
            challenged         : false,
        };
        let v3 = NewGame{
            game_id         : 0x2::object::uid_to_inner(&v2.id),
            player          : 0x2::tx_context::sender(arg5),
            user_randomness : arg1,
            guess           : arg0,
            stake           : v0,
            fee_bp          : arg4,
        };
        0x2::event::emit<NewGame>(v3);
        v2
    }

    public fun max_stake(arg0: &HouseData) : u64 {
        arg0.max_stake
    }

    public fun min_stake(arg0: &HouseData) : u64 {
        arg0.min_stake
    }

    public entry fun play(arg0: &mut Game, arg1: vector<u8>, arg2: &mut HouseData, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = stake(arg0);
        assert!(!challenged(arg0), 8);
        assert!(v0 > 0, 10);
        let v1 = 0x2::object::id_bytes<Game>(arg0);
        let v2 = v1;
        0x1::vector::append<u8>(&mut v2, player_randomness(arg0));
        let v3 = public_key(arg2);
        assert!(0x2::bls12381::bls12381_min_pk_verify(&arg1, &v3, &v2), 3);
        let v4 = 0x2::hash::blake2b256(&arg1);
        let v5 = guess(arg0) == *0x1::vector::borrow<u8>(&v4, 0) % 2;
        if (v5) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg2.fees, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.stake, fee_amount(arg0)));
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.stake, stake(arg0), arg3), player(arg0));
        } else {
            0x2::balance::join<0x2::sui::SUI>(&mut arg2.balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.stake, v0, arg3)));
        };
        let v6 = Outcome{
            game_id    : 0x2::object::uid_to_inner(&arg0.id),
            player_won : v5,
            challenged : false,
        };
        0x2::event::emit<Outcome>(v6);
    }

    public fun player(arg0: &Game) : address {
        arg0.player
    }

    public fun player_randomness(arg0: &Game) : vector<u8> {
        arg0.user_randomness
    }

    public fun public_key(arg0: &HouseData) : vector<u8> {
        arg0.public_key
    }

    public fun reduced_fee_in_bp(arg0: &HouseData) : u16 {
        arg0.reduced_fee_in_bp
    }

    public fun stake(arg0: &Game) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.stake)
    }

    public entry fun start_game(arg0: u8, arg1: vector<u8>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut HouseData, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = base_fee_in_bp(arg3);
        0x2::transfer::share_object<Game>(internal_start_game(arg0, arg1, arg2, arg3, v0, arg4));
    }

    public entry fun top_up(arg0: &mut HouseData, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public entry fun update_max_stake(arg0: &mut HouseData, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == house(arg0), 4);
        arg0.max_stake = arg1;
    }

    public entry fun update_min_stake(arg0: &mut HouseData, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == house(arg0), 4);
        arg0.min_stake = arg1;
    }

    public entry fun withdraw(arg0: &mut HouseData, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == house(arg0), 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, balance(arg0), arg1), house(arg0));
    }

    // decompiled from Move bytecode v6
}

