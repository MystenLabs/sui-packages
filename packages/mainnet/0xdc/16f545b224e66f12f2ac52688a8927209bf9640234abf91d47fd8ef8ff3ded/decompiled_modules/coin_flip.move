module 0xdc16f545b224e66f12f2ac52688a8927209bf9640234abf91d47fd8ef8ff3ded::coin_flip {
    struct Outcome has key {
        id: 0x2::object::UID,
        guess: u8,
        stake_amount: u64,
        player_won: bool,
    }

    struct FeeData has store {
        wallet1: address,
        wallet2: address,
        wallet3: address,
    }

    struct HouseData has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        house: address,
        fee_data: FeeData,
    }

    struct Game has key {
        id: 0x2::object::UID,
        stake: 0x2::balance::Balance<0x2::sui::SUI>,
        stake_amount: u64,
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

    public entry fun claim(arg0: &mut Game, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.player, 18);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.stake, 0x2::balance::value<0x2::sui::SUI>(&arg0.stake), arg1), arg0.player);
    }

    public fun game_guess(arg0: &Game) : u8 {
        arg0.guess
    }

    public fun give_change(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) >= arg1, 9);
        if (0x2::coin::value<0x2::sui::SUI>(&arg0) == arg1) {
            return arg0
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg2));
        0x2::coin::split<0x2::sui::SUI>(&mut arg0, arg1, arg2)
    }

    public fun house(arg0: &HouseData) : address {
        arg0.house
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = HouseCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<HouseCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun initialize_house_data(arg0: HouseCap, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: address, arg3: address, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) > 0, 15);
        let v0 = FeeData{
            wallet1 : arg2,
            wallet2 : arg3,
            wallet3 : arg4,
        };
        let v1 = HouseData{
            id       : 0x2::object::new(arg5),
            balance  : 0x2::coin::into_balance<0x2::sui::SUI>(arg1),
            house    : 0x2::tx_context::sender(arg5),
            fee_data : v0,
        };
        let HouseCap { id: v2 } = arg0;
        0x2::object::delete(v2);
        0x2::transfer::share_object<HouseData>(v1);
    }

    public fun outcome_guess(arg0: &Outcome) : u8 {
        arg0.guess
    }

    public entry fun play(arg0: u8, arg1: vector<u8>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &mut HouseData, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 == 1 || arg0 == 0, 14);
        assert!(balance(arg4) >= arg3, 17);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= arg3, 15);
        let v0 = give_change(arg2, arg3, arg5);
        let v1 = 0x2::coin::into_balance<0x2::sui::SUI>(v0);
        0x2::balance::join<0x2::sui::SUI>(&mut v1, 0x2::balance::split<0x2::sui::SUI>(&mut arg4.balance, 0x2::balance::value<0x2::sui::SUI>(&v1)));
        let v2 = Game{
            id              : 0x2::object::new(arg5),
            stake           : v1,
            stake_amount    : arg3,
            guess           : arg0,
            player          : 0x2::tx_context::sender(arg5),
            user_randomness : arg1,
        };
        let v3 = 0x2::object::id_bytes<Game>(&v2);
        let v4 = v3;
        0x1::vector::append<u8>(&mut v4, arg1);
        let v5 = 0x2::hash::keccak256(&v4);
        let v6 = v2.guess == *0x1::vector::borrow<u8>(&v5, 0) % 2;
        let v7 = stake(&v2);
        let v8 = 0x2::coin::take<0x2::sui::SUI>(&mut v2.stake, v7, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v8, v7 / 1000 * 25, arg5), arg4.fee_data.wallet1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v8, v7 / 1000 * 5, arg5), arg4.fee_data.wallet2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v8, v7 / 1000 * 5, arg5), arg4.fee_data.wallet3);
        if (v6) {
            0x2::balance::join<0x2::sui::SUI>(&mut v2.stake, 0x2::coin::into_balance<0x2::sui::SUI>(v8));
        } else {
            0x2::balance::join<0x2::sui::SUI>(&mut arg4.balance, 0x2::coin::into_balance<0x2::sui::SUI>(v8));
        };
        let v9 = Outcome{
            id           : 0x2::object::new(arg5),
            guess        : arg0,
            stake_amount : arg3,
            player_won   : v6,
        };
        0x2::transfer::share_object<Game>(v2);
        0x2::transfer::share_object<Outcome>(v9);
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

    public fun stake(arg0: &Game) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.stake)
    }

    public fun stake_amount(arg0: &Game) : u64 {
        arg0.stake_amount
    }

    public entry fun top_up(arg0: &mut HouseData, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public entry fun update_wallets(arg0: &mut HouseData, arg1: address, arg2: address, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.house, 12);
        arg0.fee_data.wallet1 = arg1;
        arg0.fee_data.wallet2 = arg2;
        arg0.fee_data.wallet3 = arg3;
    }

    public entry fun withdraw(arg0: &mut HouseData, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.house, 12);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, 0x2::balance::value<0x2::sui::SUI>(&arg0.balance), arg1), arg0.house);
    }

    // decompiled from Move bytecode v6
}

