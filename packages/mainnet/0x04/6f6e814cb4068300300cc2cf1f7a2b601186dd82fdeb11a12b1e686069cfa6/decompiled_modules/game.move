module 0x46f6e814cb4068300300cc2cf1f7a2b601186dd82fdeb11a12b1e686069cfa6::game {
    struct GameResult has copy, drop {
        game_id: u64,
        player: address,
        player_guess: u64,
        house_number: u64,
        player_win: bool,
        prize_amount: u64,
    }

    struct HouseAdminCap has key {
        id: 0x2::object::UID,
    }

    struct HouseData has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0xc2ef43cfeac82601ff1384bcb8ae45cfd8a632503f60fbc92aa71ea776ee1707::faucetcoin::FAUCETCOIN>,
        house: address,
    }

    struct Game has key {
        id: 0x2::object::UID,
        player: address,
        player_guess: u64,
        house_number: u64,
        bet_amount: u64,
        player_win: bool,
        timestamp: u64,
    }

    public fun generate_random(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) % 100
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = HouseAdminCap{id: 0x2::object::new(arg0)};
        0x46f6e814cb4068300300cc2cf1f7a2b601186dd82fdeb11a12b1e686069cfa6::game_counter::init_gc(arg0);
        0x2::transfer::transfer<HouseAdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun initialize_house_data(arg0: HouseAdminCap, arg1: 0x2::coin::Coin<0xc2ef43cfeac82601ff1384bcb8ae45cfd8a632503f60fbc92aa71ea776ee1707::faucetcoin::FAUCETCOIN>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0xc2ef43cfeac82601ff1384bcb8ae45cfd8a632503f60fbc92aa71ea776ee1707::faucetcoin::FAUCETCOIN>(&arg1) > 0, 0);
        let v0 = HouseData{
            id      : 0x2::object::new(arg2),
            balance : 0x2::coin::into_balance<0xc2ef43cfeac82601ff1384bcb8ae45cfd8a632503f60fbc92aa71ea776ee1707::faucetcoin::FAUCETCOIN>(arg1),
            house   : 0x2::tx_context::sender(arg2),
        };
        let HouseAdminCap { id: v1 } = arg0;
        0x2::object::delete(v1);
        0x2::transfer::share_object<HouseData>(v0);
    }

    fun is_player_win(arg0: u64, arg1: u64) : bool {
        let v0 = if (arg0 > arg1) {
            arg0 - arg1
        } else {
            arg1 - arg0
        };
        v0 < 100
    }

    public entry fun place_bet_and_create_game(arg0: &mut 0x46f6e814cb4068300300cc2cf1f7a2b601186dd82fdeb11a12b1e686069cfa6::game_counter::GameCounter, arg1: &mut HouseData, arg2: u64, arg3: 0x2::coin::Coin<0xc2ef43cfeac82601ff1384bcb8ae45cfd8a632503f60fbc92aa71ea776ee1707::faucetcoin::FAUCETCOIN>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 999, 0);
        let v0 = 0x2::coin::value<0xc2ef43cfeac82601ff1384bcb8ae45cfd8a632503f60fbc92aa71ea776ee1707::faucetcoin::FAUCETCOIN>(&arg3);
        assert!(v0 >= 100, 1);
        assert!(0x2::balance::value<0xc2ef43cfeac82601ff1384bcb8ae45cfd8a632503f60fbc92aa71ea776ee1707::faucetcoin::FAUCETCOIN>(&arg1.balance) >= v0, 2);
        let v1 = generate_random(arg4);
        let v2 = is_player_win(arg2, v1);
        if (v2) {
            let v3 = 0x2::coin::take<0xc2ef43cfeac82601ff1384bcb8ae45cfd8a632503f60fbc92aa71ea776ee1707::faucetcoin::FAUCETCOIN>(&mut arg1.balance, v0, arg5);
            0x2::coin::join<0xc2ef43cfeac82601ff1384bcb8ae45cfd8a632503f60fbc92aa71ea776ee1707::faucetcoin::FAUCETCOIN>(&mut v3, arg3);
            0x2::transfer::public_transfer<0x2::coin::Coin<0xc2ef43cfeac82601ff1384bcb8ae45cfd8a632503f60fbc92aa71ea776ee1707::faucetcoin::FAUCETCOIN>>(v3, 0x2::tx_context::sender(arg5));
        } else {
            0x2::balance::join<0xc2ef43cfeac82601ff1384bcb8ae45cfd8a632503f60fbc92aa71ea776ee1707::faucetcoin::FAUCETCOIN>(&mut arg1.balance, 0x2::coin::into_balance<0xc2ef43cfeac82601ff1384bcb8ae45cfd8a632503f60fbc92aa71ea776ee1707::faucetcoin::FAUCETCOIN>(arg3));
        };
        let v4 = Game{
            id           : 0x2::object::new(arg5),
            player       : 0x2::tx_context::sender(arg5),
            player_guess : arg2,
            house_number : v1,
            bet_amount   : v0,
            player_win   : v2,
            timestamp    : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::transfer::share_object<Game>(v4);
        let v5 = if (v2) {
            v0 * 2
        } else {
            0
        };
        let v6 = GameResult{
            game_id      : 0x46f6e814cb4068300300cc2cf1f7a2b601186dd82fdeb11a12b1e686069cfa6::game_counter::get_next_id(arg0),
            player       : 0x2::tx_context::sender(arg5),
            player_guess : arg2,
            house_number : v1,
            player_win   : v2,
            prize_amount : v5,
        };
        0x2::event::emit<GameResult>(v6);
    }

    public entry fun top_up(arg0: &mut HouseData, arg1: 0x2::coin::Coin<0xc2ef43cfeac82601ff1384bcb8ae45cfd8a632503f60fbc92aa71ea776ee1707::faucetcoin::FAUCETCOIN>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0xc2ef43cfeac82601ff1384bcb8ae45cfd8a632503f60fbc92aa71ea776ee1707::faucetcoin::FAUCETCOIN>(&arg1) >= arg2, 3);
        let v0 = 0x2::coin::into_balance<0xc2ef43cfeac82601ff1384bcb8ae45cfd8a632503f60fbc92aa71ea776ee1707::faucetcoin::FAUCETCOIN>(arg1);
        0x2::balance::join<0xc2ef43cfeac82601ff1384bcb8ae45cfd8a632503f60fbc92aa71ea776ee1707::faucetcoin::FAUCETCOIN>(&mut arg0.balance, 0x2::balance::split<0xc2ef43cfeac82601ff1384bcb8ae45cfd8a632503f60fbc92aa71ea776ee1707::faucetcoin::FAUCETCOIN>(&mut v0, arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xc2ef43cfeac82601ff1384bcb8ae45cfd8a632503f60fbc92aa71ea776ee1707::faucetcoin::FAUCETCOIN>>(0x2::coin::from_balance<0xc2ef43cfeac82601ff1384bcb8ae45cfd8a632503f60fbc92aa71ea776ee1707::faucetcoin::FAUCETCOIN>(v0, arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun withdraw(arg0: &mut HouseData, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.house, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xc2ef43cfeac82601ff1384bcb8ae45cfd8a632503f60fbc92aa71ea776ee1707::faucetcoin::FAUCETCOIN>>(0x2::coin::take<0xc2ef43cfeac82601ff1384bcb8ae45cfd8a632503f60fbc92aa71ea776ee1707::faucetcoin::FAUCETCOIN>(&mut arg0.balance, 0x2::balance::value<0xc2ef43cfeac82601ff1384bcb8ae45cfd8a632503f60fbc92aa71ea776ee1707::faucetcoin::FAUCETCOIN>(&arg0.balance), arg1), arg0.house);
    }

    // decompiled from Move bytecode v6
}

