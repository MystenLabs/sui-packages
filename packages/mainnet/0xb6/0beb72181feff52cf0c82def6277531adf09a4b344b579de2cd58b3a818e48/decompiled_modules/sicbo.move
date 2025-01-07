module 0xb60beb72181feff52cf0c82def6277531adf09a4b344b579de2cd58b3a818e48::sicbo {
    struct CSCHouseData has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x8cfcd7e02e562c4302cfc1f9ad9e425358fe23b42f948dd430e855227494642a::csc::CSC>,
        house: address,
        fee_keeper: address,
        public_key: vector<u8>,
        max_stake: u64,
        min_stake: u64,
        fees: 0x2::balance::Balance<0x8cfcd7e02e562c4302cfc1f9ad9e425358fe23b42f948dd430e855227494642a::csc::CSC>,
        fee_rate: u128,
    }

    struct NewGameEvent has copy, drop {
        game_id: 0x2::object::ID,
        player: address,
        dice1_randomness: vector<u8>,
        dice2_randomness: vector<u8>,
        dice3_randomness: vector<u8>,
        stake: u64,
        fee_rate: u128,
    }

    struct NewBetEvent has copy, drop {
        game_id: 0x2::object::ID,
        stake: u64,
        stake_needed: u64,
        rate: u64,
        bet: u8,
    }

    struct Outcome has copy, drop {
        game_id: 0x2::object::ID,
        player: address,
        player_won: bool,
        challenged: bool,
        amount: u64,
        bet: u8,
        result: vector<u8>,
        currency: u64,
    }

    struct Bet has key {
        id: 0x2::object::UID,
        game_id: 0x2::object::ID,
        bet: u8,
        player_won: bool,
        player: address,
        is_solved: bool,
        amount: u64,
    }

    struct CSCGame has key {
        id: 0x2::object::UID,
        guess_placed_epoch: u64,
        stake: 0x2::balance::Balance<0x8cfcd7e02e562c4302cfc1f9ad9e425358fe23b42f948dd430e855227494642a::csc::CSC>,
        dice1_randomness: vector<u8>,
        dice2_randomness: vector<u8>,
        dice3_randomness: vector<u8>,
        fee_rate: u128,
        challenged: bool,
    }

    struct HouseCap has key {
        id: 0x2::object::UID,
    }

    public fun balance(arg0: &CSCHouseData) : u64 {
        0x2::balance::value<0x8cfcd7e02e562c4302cfc1f9ad9e425358fe23b42f948dd430e855227494642a::csc::CSC>(&arg0.balance)
    }

    public entry fun claim_fees(arg0: &mut CSCHouseData, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == fee_keeper(arg0), 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x8cfcd7e02e562c4302cfc1f9ad9e425358fe23b42f948dd430e855227494642a::csc::CSC>>(0x2::coin::take<0x8cfcd7e02e562c4302cfc1f9ad9e425358fe23b42f948dd430e855227494642a::csc::CSC>(&mut arg0.fees, fees(arg0), arg1), fee_keeper(arg0));
    }

    fun compute_fee_amount(arg0: u64, arg1: u128) : u64 {
        (((arg0 as u128) * arg1 / 1000000) as u64)
    }

    public fun csc_balance(arg0: &CSCHouseData) : u64 {
        0x2::balance::value<0x8cfcd7e02e562c4302cfc1f9ad9e425358fe23b42f948dd430e855227494642a::csc::CSC>(&arg0.balance)
    }

    public fun csc_challenged(arg0: &CSCGame) : bool {
        arg0.challenged
    }

    public fun csc_max_stake(arg0: &CSCHouseData) : u64 {
        arg0.max_stake
    }

    public fun csc_min_stake(arg0: &CSCHouseData) : u64 {
        arg0.min_stake
    }

    public fun csc_player(arg0: &Bet) : address {
        arg0.player
    }

    public fun csc_player_dice1_randomness(arg0: &CSCGame) : vector<u8> {
        arg0.dice1_randomness
    }

    public fun csc_player_dice2_randomness(arg0: &CSCGame) : vector<u8> {
        arg0.dice2_randomness
    }

    public fun csc_player_dice3_randomness(arg0: &CSCGame) : vector<u8> {
        arg0.dice3_randomness
    }

    public fun csc_public_key(arg0: &CSCHouseData) : vector<u8> {
        arg0.public_key
    }

    public fun csc_stake(arg0: &CSCGame) : u64 {
        0x2::balance::value<0x8cfcd7e02e562c4302cfc1f9ad9e425358fe23b42f948dd430e855227494642a::csc::CSC>(&arg0.stake)
    }

    public fun csc_stake_in_bet(arg0: &Bet) : u64 {
        arg0.amount
    }

    fun determine_dice_from_sig(arg0: &CSCGame, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut CSCHouseData) : u8 {
        let v0 = 0x2::object::id_bytes<CSCGame>(arg0);
        let v1 = v0;
        0x1::vector::append<u8>(&mut v1, arg2);
        let v2 = csc_public_key(arg3);
        assert!(0x2::bls12381::bls12381_min_pk_verify(&arg1, &v2, &v1), 3);
        let v3 = 0x2::hash::blake2b256(&arg1);
        *0x1::vector::borrow<u8>(&v3, 0) % 6 + 1
    }

    public fun fee_keeper(arg0: &CSCHouseData) : address {
        arg0.fee_keeper
    }

    public fun fees(arg0: &CSCHouseData) : u64 {
        0x2::balance::value<0x8cfcd7e02e562c4302cfc1f9ad9e425358fe23b42f948dd430e855227494642a::csc::CSC>(&arg0.fees)
    }

    fun get_betting_rate(arg0: u8) : u64 {
        if (arg0 >= 1 && arg0 <= 4) {
            98
        } else if (arg0 == 31) {
            3000
        } else if (arg0 == 11 || arg0 == 24) {
            6000
        } else if (arg0 == 12 || arg0 == 23) {
            2000
        } else if (arg0 == 13 || arg0 == 22) {
            1800
        } else if (arg0 == 14 || arg0 == 21) {
            1200
        } else if (arg0 == 15 || arg0 == 20) {
            800
        } else if (arg0 == 16 || arg0 == 19) {
            600
        } else if (arg0 == 17 || arg0 == 18) {
            600
        } else if (arg0 >= 25 && arg0 <= 30) {
            294
        } else {
            100
        }
    }

    public fun house(arg0: &CSCHouseData) : address {
        arg0.house
    }

    public fun house_fee_rate(arg0: &CSCHouseData) : u128 {
        arg0.fee_rate
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = HouseCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<HouseCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun initialize_csc_house_data(arg0: HouseCap, arg1: u128, arg2: 0x2::coin::Coin<0x8cfcd7e02e562c4302cfc1f9ad9e425358fe23b42f948dd430e855227494642a::csc::CSC>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x8cfcd7e02e562c4302cfc1f9ad9e425358fe23b42f948dd430e855227494642a::csc::CSC>(&arg2) > 0, 7);
        assert!(arg1 <= 50000, 14);
        let v0 = CSCHouseData{
            id         : 0x2::object::new(arg4),
            balance    : 0x2::coin::into_balance<0x8cfcd7e02e562c4302cfc1f9ad9e425358fe23b42f948dd430e855227494642a::csc::CSC>(arg2),
            house      : 0x2::tx_context::sender(arg4),
            fee_keeper : @0x6032ce985e0ee81771897ddf95c3b2fb27c83d95558f8531e03e4cf130bd4709,
            public_key : arg3,
            max_stake  : 500000000000,
            min_stake  : 10000000000,
            fees       : 0x2::balance::zero<0x8cfcd7e02e562c4302cfc1f9ad9e425358fe23b42f948dd430e855227494642a::csc::CSC>(),
            fee_rate   : arg1,
        };
        let HouseCap { id: v1 } = arg0;
        0x2::object::delete(v1);
        0x2::transfer::share_object<CSCHouseData>(v0);
    }

    fun internal_start_bet_with_csc(arg0: u8, arg1: &mut CSCGame, arg2: 0x2::coin::Coin<0x8cfcd7e02e562c4302cfc1f9ad9e425358fe23b42f948dd430e855227494642a::csc::CSC>, arg3: &mut CSCHouseData, arg4: &mut 0x2::tx_context::TxContext) : Bet {
        assert!(arg0 >= 1 && arg0 <= 31, 6);
        let v0 = 0x2::coin::value<0x8cfcd7e02e562c4302cfc1f9ad9e425358fe23b42f948dd430e855227494642a::csc::CSC>(&arg2);
        let v1 = get_betting_rate(arg0);
        let v2 = v0 * v1 / 100;
        assert!(v0 <= csc_max_stake(arg3), 2);
        assert!(v0 >= csc_min_stake(arg3), 1);
        assert!(csc_balance(arg3) >= v2, 9);
        let v3 = 0x2::coin::into_balance<0x8cfcd7e02e562c4302cfc1f9ad9e425358fe23b42f948dd430e855227494642a::csc::CSC>(arg2);
        0x2::balance::join<0x8cfcd7e02e562c4302cfc1f9ad9e425358fe23b42f948dd430e855227494642a::csc::CSC>(&mut v3, 0x2::balance::split<0x8cfcd7e02e562c4302cfc1f9ad9e425358fe23b42f948dd430e855227494642a::csc::CSC>(&mut arg3.balance, v2));
        0x2::balance::join<0x8cfcd7e02e562c4302cfc1f9ad9e425358fe23b42f948dd430e855227494642a::csc::CSC>(&mut arg1.stake, v3);
        let v4 = Bet{
            id         : 0x2::object::new(arg4),
            game_id    : 0x2::object::uid_to_inner(&arg1.id),
            bet        : arg0,
            player_won : false,
            player     : 0x2::tx_context::sender(arg4),
            is_solved  : false,
            amount     : v0,
        };
        let v5 = NewBetEvent{
            game_id      : 0x2::object::uid_to_inner(&v4.id),
            stake        : 0x2::balance::value<0x8cfcd7e02e562c4302cfc1f9ad9e425358fe23b42f948dd430e855227494642a::csc::CSC>(&arg1.stake),
            stake_needed : v2,
            rate         : v1,
            bet          : arg0,
        };
        0x2::event::emit<NewBetEvent>(v5);
        v4
    }

    fun internal_start_game_csc(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: u128, arg4: &mut 0x2::tx_context::TxContext) : CSCGame {
        let v0 = CSCGame{
            id                 : 0x2::object::new(arg4),
            guess_placed_epoch : 0x2::tx_context::epoch(arg4),
            stake              : 0x2::balance::zero<0x8cfcd7e02e562c4302cfc1f9ad9e425358fe23b42f948dd430e855227494642a::csc::CSC>(),
            dice1_randomness   : arg0,
            dice2_randomness   : arg1,
            dice3_randomness   : arg2,
            fee_rate           : arg3,
            challenged         : false,
        };
        let v1 = NewGameEvent{
            game_id          : 0x2::object::uid_to_inner(&v0.id),
            player           : 0x2::tx_context::sender(arg4),
            dice1_randomness : arg0,
            dice2_randomness : arg1,
            dice3_randomness : arg2,
            stake            : 0,
            fee_rate         : arg3,
        };
        0x2::event::emit<NewGameEvent>(v1);
        v0
    }

    fun is_winner(arg0: u8, arg1: u8, arg2: u8, arg3: u8) : bool {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, arg1);
        0x1::vector::push_back<u8>(&mut v0, arg2);
        0x1::vector::push_back<u8>(&mut v0, arg3);
        let v1 = arg1 + arg2 + arg3;
        let v2 = arg1 == arg2 && arg1 == arg3;
        let v3 = if (arg0 == 1) {
            let v4 = v1 < 4 || v1 > 10;
            v4 || v2
        } else {
            false
        };
        let v5 = if (v3) {
            true
        } else if (arg0 == 2) {
            let v6 = v1 < 11 || v1 > 17;
            v6 || v2
        } else {
            false
        };
        let v7 = if (v5 || arg0 == 3 && v1 % 2 == 0 || arg0 == 4 && v1 % 2 != 0 || arg0 == 31 && !v2 || arg0 >= 5 && arg0 <= 10 && (!v2 || arg1 != arg0 - 5 + 1) || arg0 >= 11 && arg0 <= 24 && v1 != arg0 - 11 + 4) {
            true
        } else if (arg0 >= 25 && arg0 <= 30) {
            let v8 = arg0 - 25 + 1;
            !0x1::vector::contains<u8>(&v0, &v8)
        } else {
            false
        };
        if (v7) {
            return false
        };
        true
    }

    public entry fun play_with_csc(arg0: &mut Bet, arg1: &mut CSCGame, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut CSCHouseData, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.bet;
        assert!(!csc_challenged(arg1), 8);
        let v1 = determine_dice_from_sig(arg1, arg2, csc_player_dice1_randomness(arg1), arg5);
        let v2 = determine_dice_from_sig(arg1, arg3, csc_player_dice2_randomness(arg1), arg5);
        let v3 = determine_dice_from_sig(arg1, arg4, csc_player_dice3_randomness(arg1), arg5);
        let v4 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v4, v1);
        0x1::vector::push_back<u8>(&mut v4, v2);
        0x1::vector::push_back<u8>(&mut v4, v3);
        let v5 = is_winner(v0, v1, v2, v3);
        let v6 = arg0.amount + arg0.amount * get_betting_rate(arg0.bet) / 100;
        let v7 = v6;
        if (v5) {
            let v8 = compute_fee_amount(arg0.amount, house_fee_rate(arg5));
            0x2::balance::join<0x8cfcd7e02e562c4302cfc1f9ad9e425358fe23b42f948dd430e855227494642a::csc::CSC>(&mut arg5.fees, 0x2::balance::split<0x8cfcd7e02e562c4302cfc1f9ad9e425358fe23b42f948dd430e855227494642a::csc::CSC>(&mut arg1.stake, v8));
            let v9 = v6 - v8;
            v7 = v9;
            if (v0 >= 25 && v0 <= 31) {
                let v10 = v0 - 25 + 1;
                let v11 = vector_count(&v4, &v10);
                if (v11 == 2) {
                    v7 = arg0.amount + arg0.amount * 1;
                } else if (v11 == 1) {
                    v7 = arg0.amount + arg0.amount * 0;
                } else {
                    v7 = arg0.amount + arg0.amount * 2;
                };
                let v12 = csc_stake(arg1) - v7;
                0x2::transfer::public_transfer<0x2::coin::Coin<0x8cfcd7e02e562c4302cfc1f9ad9e425358fe23b42f948dd430e855227494642a::csc::CSC>>(0x2::coin::take<0x8cfcd7e02e562c4302cfc1f9ad9e425358fe23b42f948dd430e855227494642a::csc::CSC>(&mut arg1.stake, v7, arg6), csc_player(arg0));
                if (v12 > 0) {
                    0x2::balance::join<0x8cfcd7e02e562c4302cfc1f9ad9e425358fe23b42f948dd430e855227494642a::csc::CSC>(&mut arg5.balance, 0x2::coin::into_balance<0x8cfcd7e02e562c4302cfc1f9ad9e425358fe23b42f948dd430e855227494642a::csc::CSC>(0x2::coin::take<0x8cfcd7e02e562c4302cfc1f9ad9e425358fe23b42f948dd430e855227494642a::csc::CSC>(&mut arg1.stake, v12, arg6)));
                };
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x8cfcd7e02e562c4302cfc1f9ad9e425358fe23b42f948dd430e855227494642a::csc::CSC>>(0x2::coin::take<0x8cfcd7e02e562c4302cfc1f9ad9e425358fe23b42f948dd430e855227494642a::csc::CSC>(&mut arg1.stake, v9, arg6), csc_player(arg0));
            };
        } else {
            0x2::balance::join<0x8cfcd7e02e562c4302cfc1f9ad9e425358fe23b42f948dd430e855227494642a::csc::CSC>(&mut arg5.balance, 0x2::coin::into_balance<0x8cfcd7e02e562c4302cfc1f9ad9e425358fe23b42f948dd430e855227494642a::csc::CSC>(0x2::coin::take<0x8cfcd7e02e562c4302cfc1f9ad9e425358fe23b42f948dd430e855227494642a::csc::CSC>(&mut arg1.stake, v6, arg6)));
        };
        let v13 = Outcome{
            game_id    : 0x2::object::uid_to_inner(&arg1.id),
            player     : csc_player(arg0),
            player_won : v5,
            challenged : false,
            amount     : v7,
            bet        : arg0.bet,
            result     : v4,
            currency   : 1,
        };
        0x2::event::emit<Outcome>(v13);
    }

    public entry fun start_bet_with_csc(arg0: u8, arg1: &mut CSCGame, arg2: 0x2::coin::Coin<0x8cfcd7e02e562c4302cfc1f9ad9e425358fe23b42f948dd430e855227494642a::csc::CSC>, arg3: &mut CSCHouseData, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<Bet>(internal_start_bet_with_csc(arg0, arg1, arg2, arg3, arg4));
    }

    public entry fun start_game_with_csc(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut CSCHouseData, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<CSCGame>(internal_start_game_csc(arg0, arg1, arg2, house_fee_rate(arg3), arg4));
    }

    public entry fun top_up(arg0: &mut CSCHouseData, arg1: 0x2::coin::Coin<0x8cfcd7e02e562c4302cfc1f9ad9e425358fe23b42f948dd430e855227494642a::csc::CSC>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x8cfcd7e02e562c4302cfc1f9ad9e425358fe23b42f948dd430e855227494642a::csc::CSC>(&mut arg0.balance, 0x2::coin::into_balance<0x8cfcd7e02e562c4302cfc1f9ad9e425358fe23b42f948dd430e855227494642a::csc::CSC>(arg1));
    }

    public entry fun update_fee_rate(arg0: &HouseCap, arg1: &mut CSCHouseData, arg2: u128) {
        assert!(arg2 <= 50000, 14);
        arg1.fee_rate = arg2;
    }

    fun vector_count(arg0: &vector<u8>, arg1: &u8) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(arg0)) {
            if (0x1::vector::borrow<u8>(arg0, v1) == arg1) {
                v0 = v0 + 1;
            };
            v1 = v1 + 1;
        };
        v0
    }

    public entry fun withdraw(arg0: &mut CSCHouseData, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == house(arg0), 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x8cfcd7e02e562c4302cfc1f9ad9e425358fe23b42f948dd430e855227494642a::csc::CSC>>(0x2::coin::take<0x8cfcd7e02e562c4302cfc1f9ad9e425358fe23b42f948dd430e855227494642a::csc::CSC>(&mut arg0.balance, balance(arg0), arg1), house(arg0));
    }

    // decompiled from Move bytecode v6
}

