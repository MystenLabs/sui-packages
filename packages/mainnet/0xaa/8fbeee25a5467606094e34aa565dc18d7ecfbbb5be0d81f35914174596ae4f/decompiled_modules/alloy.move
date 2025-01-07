module 0xaa8fbeee25a5467606094e34aa565dc18d7ecfbbb5be0d81f35914174596ae4f::alloy {
    struct NewMarket<phantom T0> has copy, drop {
        market_id: 0x2::object::ID,
        market_name: 0x1::string::String,
        round_number: u64,
        start_timestamp: u64,
        lock_timestamp: u64,
        end_timestamp: u64,
    }

    struct PlayerGuess<phantom T0> has copy, drop {
        market_id: 0x2::object::ID,
        market_name: 0x1::string::String,
        player: address,
        bet_size: u64,
        guess: u64,
        round_number: u64,
        origin: 0x1::string::String,
        start_timestamp: u64,
    }

    struct RoundResult<phantom T0> has copy, drop, store {
        market_id: 0x2::object::ID,
        market_name: 0x1::string::String,
        result: u64,
        ai_prediction: 0x1::option::Option<u64>,
        round_number: u64,
    }

    struct ALLOY has drop {
        dummy_field: bool,
    }

    struct MarketplaceTag<phantom T0> has copy, drop, store {
        marketplace_name: 0x1::string::String,
    }

    struct MarketAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MarketConfig has store, key {
        id: 0x2::object::UID,
        version_set: 0x2::vec_set::VecSet<u64>,
    }

    struct Marketplace<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        default_max_bet_balance: u64,
        locked_balance: u64,
        markets: 0x2::table::Table<0x1::string::String, Market>,
    }

    struct Market has store {
        games: 0x2::table::Table<u64, MarketInstance>,
        round_number: u64,
    }

    struct MarketInstance has store {
        market_name: 0x1::string::String,
        guesses: 0xaa8fbeee25a5467606094e34aa565dc18d7ecfbbb5be0d81f35914174596ae4f::big_queue::BigQueue<Guess>,
        round_number: u64,
        ai_prediction: 0x1::option::Option<u64>,
        ai_tx_proof: 0x1::string::String,
        result: u64,
        locked: bool,
        settled: bool,
        released: bool,
        max_bet_balance: u64,
        current_bet_balance: u64,
        start_timestamp: u64,
        lock_timestamp: u64,
        end_timestamp: u64,
    }

    struct Guess has drop, store {
        player: address,
        bet_size: u64,
        guess: u64,
        round_number: u64,
        origin: 0x1::string::String,
    }

    public fun add_version(arg0: &MarketAdminCap, arg1: &mut MarketConfig, arg2: u64) {
        0x2::vec_set::insert<u64>(&mut arg1.version_set, arg2);
    }

    fun assert_valid_version(arg0: &MarketConfig) {
        let v0 = package_version();
        assert!(0x2::vec_set::contains<u64>(&arg0.version_set, &v0), 0);
    }

    fun borrow_mut_marketplace<T0>(arg0: &mut MarketConfig, arg1: 0x1::string::String) : &mut Marketplace<T0> {
        let v0 = MarketplaceTag<T0>{marketplace_name: arg1};
        0x2::dynamic_object_field::borrow_mut<MarketplaceTag<T0>, Marketplace<T0>>(&mut arg0.id, v0)
    }

    public fun create_market<T0>(arg0: &MarketAdminCap, arg1: &mut MarketConfig, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Market{
            games        : 0x2::table::new<u64, MarketInstance>(arg4),
            round_number : 0,
        };
        0x2::table::add<0x1::string::String, Market>(&mut borrow_mut_marketplace<T0>(arg1, arg2).markets, arg3, v0);
    }

    public fun create_market_instance<T0>(arg0: &MarketAdminCap, arg1: &mut MarketConfig, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert_valid_version(arg1);
        let v0 = borrow_mut_marketplace<T0>(arg1, arg2);
        let v1 = 0x2::table::borrow_mut<0x1::string::String, Market>(&mut v0.markets, arg3);
        let v2 = MarketInstance{
            market_name         : arg3,
            guesses             : 0xaa8fbeee25a5467606094e34aa565dc18d7ecfbbb5be0d81f35914174596ae4f::big_queue::new<Guess>(5000, arg7),
            round_number        : v1.round_number,
            ai_prediction       : 0x1::option::none<u64>(),
            ai_tx_proof         : 0x1::string::utf8(b""),
            result              : 0,
            locked              : false,
            settled             : false,
            released            : false,
            max_bet_balance     : v0.default_max_bet_balance,
            current_bet_balance : 0,
            start_timestamp     : 0x2::clock::timestamp_ms(arg6),
            lock_timestamp      : arg4,
            end_timestamp       : arg5,
        };
        let v3 = NewMarket<T0>{
            market_id       : 0x2::object::uid_to_inner(&v0.id),
            market_name     : arg3,
            round_number    : v1.round_number,
            start_timestamp : 0x2::clock::timestamp_ms(arg6),
            lock_timestamp  : arg4,
            end_timestamp   : arg5,
        };
        0x2::event::emit<NewMarket<T0>>(v3);
        0x2::table::add<u64, MarketInstance>(&mut v1.games, v1.round_number, v2);
        v1.round_number = v1.round_number + 1;
    }

    public fun create_marketplace<T0>(arg0: &MarketAdminCap, arg1: &mut MarketConfig, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        assert_valid_version(arg1);
        let v0 = MarketplaceTag<T0>{marketplace_name: arg2};
        let v1 = Marketplace<T0>{
            id                      : 0x2::object::new(arg3),
            balance                 : 0x2::balance::zero<T0>(),
            default_max_bet_balance : 10000000000000,
            locked_balance          : 0,
            markets                 : 0x2::table::new<0x1::string::String, Market>(arg3),
        };
        0x2::dynamic_object_field::add<MarketplaceTag<T0>, Marketplace<T0>>(&mut arg1.id, v0, v1);
    }

    public fun deposit_market_balance<T0>(arg0: &MarketAdminCap, arg1: &mut MarketConfig, arg2: 0x1::string::String, arg3: 0x2::coin::Coin<T0>) {
        assert_valid_version(arg1);
        0x2::balance::join<T0>(&mut borrow_mut_marketplace<T0>(arg1, arg2).balance, 0x2::coin::into_balance<T0>(arg3));
    }

    fun get_result(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = if (arg0 >= arg1) {
            arg0 - arg1
        } else {
            arg1 - arg0
        };
        let v1 = if (arg0 >= arg2) {
            arg0 - arg2
        } else {
            arg2 - arg0
        };
        if (v0 == v1) {
            return 2
        };
        if (v0 > v1) {
            return 1
        };
        0
    }

    fun init(arg0: ALLOY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = MarketAdminCap{id: 0x2::object::new(arg1)};
        0x2::package::claim_and_keep<ALLOY>(arg0, arg1);
        0x2::transfer::transfer<MarketAdminCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = MarketConfig{
            id          : 0x2::object::new(arg1),
            version_set : 0x2::vec_set::singleton<u64>(0),
        };
        0x2::transfer::share_object<MarketConfig>(v1);
    }

    public fun marketplace_balance<T0>(arg0: &MarketConfig, arg1: 0x1::string::String) : u64 {
        let v0 = MarketplaceTag<T0>{marketplace_name: arg1};
        0x2::balance::value<T0>(&0x2::dynamic_object_field::borrow<MarketplaceTag<T0>, Marketplace<T0>>(&arg0.id, v0).balance)
    }

    public fun package_version() : u64 {
        0
    }

    public fun place_guess<T0>(arg0: &mut MarketConfig, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: address, arg5: u64, arg6: 0x2::coin::Coin<T0>, arg7: 0x1::string::String, arg8: &0x2::clock::Clock) {
        assert_valid_version(arg0);
        let v0 = borrow_mut_marketplace<T0>(arg0, arg1);
        let v1 = 0x2::coin::into_balance<T0>(arg6);
        let v2 = 0x2::balance::value<T0>(&v1);
        assert!(v2 >= 100000000, 1);
        assert!(v0.locked_balance + v2 <= 0x2::balance::value<T0>(&v0.balance), 7);
        v0.locked_balance = v0.locked_balance + v2;
        0x2::balance::join<T0>(&mut v0.balance, v1);
        let v3 = 0x2::table::borrow_mut<0x1::string::String, Market>(&mut v0.markets, arg2);
        let v4 = 0x2::table::borrow_mut<u64, MarketInstance>(&mut v3.games, arg3);
        assert!(v4.current_bet_balance + v2 <= v4.max_bet_balance, 8);
        v4.current_bet_balance = v4.current_bet_balance + v2;
        assert!(0x2::clock::timestamp_ms(arg8) < v4.lock_timestamp, 2);
        assert!(!v4.locked, 2);
        assert!(!v4.settled, 4);
        let v5 = Guess{
            player       : arg4,
            bet_size     : v2,
            guess        : arg5,
            round_number : v4.round_number,
            origin       : arg7,
        };
        let v6 = PlayerGuess<T0>{
            market_id       : 0x2::object::uid_to_inner(&v0.id),
            market_name     : arg2,
            player          : arg4,
            bet_size        : v2,
            guess           : arg5,
            round_number    : v3.round_number,
            origin          : arg7,
            start_timestamp : 0x2::clock::timestamp_ms(arg8),
        };
        0x2::event::emit<PlayerGuess<T0>>(v6);
        0xaa8fbeee25a5467606094e34aa565dc18d7ecfbbb5be0d81f35914174596ae4f::big_queue::push_back<Guess>(&mut v4.guesses, v5);
    }

    public fun release_unsettled_market<T0>(arg0: &MarketAdminCap, arg1: &mut MarketConfig, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: &0x2::clock::Clock, arg6: 0x1::option::Option<u64>, arg7: &mut 0x2::tx_context::TxContext) {
        assert_valid_version(arg1);
        let v0 = borrow_mut_marketplace<T0>(arg1, arg2);
        let v1 = 0x2::table::borrow_mut<0x1::string::String, Market>(&mut v0.markets, arg3);
        let v2 = 0x2::table::borrow_mut<u64, MarketInstance>(&mut v1.games, arg4);
        assert!(0x2::clock::timestamp_ms(arg5) > v2.lock_timestamp + (v2.end_timestamp - v2.lock_timestamp) / 5, 12);
        assert!(!v2.released, 6);
        assert!(!v2.settled, 4);
        let v3 = 0;
        if (0x1::option::is_some<u64>(&arg6)) {
            v3 = 0xaa8fbeee25a5467606094e34aa565dc18d7ecfbbb5be0d81f35914174596ae4f::big_queue::length<Guess>(&v2.guesses) - *0x1::option::borrow<u64>(&arg6);
        };
        while (0xaa8fbeee25a5467606094e34aa565dc18d7ecfbbb5be0d81f35914174596ae4f::big_queue::length<Guess>(&v2.guesses) > v3) {
            let v4 = 0xaa8fbeee25a5467606094e34aa565dc18d7ecfbbb5be0d81f35914174596ae4f::big_queue::pop_front<Guess>(&mut v2.guesses);
            v0.locked_balance = v0.locked_balance - v4.bet_size;
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v0.balance, v4.bet_size), arg7), v4.player);
        };
        if (0xaa8fbeee25a5467606094e34aa565dc18d7ecfbbb5be0d81f35914174596ae4f::big_queue::length<Guess>(&v2.guesses) == 0) {
            v2.released = true;
            let v5 = RoundResult<T0>{
                market_id     : 0x2::object::uid_to_inner(&v0.id),
                market_name   : arg3,
                result        : 0,
                ai_prediction : v2.ai_prediction,
                round_number  : v1.round_number,
            };
            0x2::event::emit<RoundResult<T0>>(v5);
        };
    }

    public fun remove_version(arg0: &MarketAdminCap, arg1: &mut MarketConfig, arg2: u64) {
        0x2::vec_set::remove<u64>(&mut arg1.version_set, &arg2);
    }

    public fun set_ai_prediction<T0>(arg0: &MarketAdminCap, arg1: &mut MarketConfig, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: 0x1::string::String, arg7: &0x2::clock::Clock) {
        assert_valid_version(arg1);
        let v0 = 0x2::table::borrow_mut<u64, MarketInstance>(&mut 0x2::table::borrow_mut<0x1::string::String, Market>(&mut borrow_mut_marketplace<T0>(arg1, arg2).markets, arg3).games, arg4);
        assert!(0x2::clock::timestamp_ms(arg7) < v0.lock_timestamp + (v0.end_timestamp - v0.lock_timestamp) / 5, 11);
        assert!(!v0.locked, 2);
        v0.locked = true;
        v0.ai_prediction = 0x1::option::some<u64>(arg5);
        v0.ai_tx_proof = arg6;
        v0.lock_timestamp = 0x2::clock::timestamp_ms(arg7);
    }

    public fun settle_or_continue<T0>(arg0: &MarketAdminCap, arg1: &mut MarketConfig, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: 0x1::option::Option<u64>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert_valid_version(arg1);
        let v0 = borrow_mut_marketplace<T0>(arg1, arg2);
        let v1 = 0x2::table::borrow_mut<0x1::string::String, Market>(&mut v0.markets, arg3);
        let v2 = 0x2::table::borrow_mut<u64, MarketInstance>(&mut v1.games, arg4);
        assert!(v2.locked, 3);
        assert!(!v2.settled, 4);
        assert!(!v2.released, 6);
        assert!(0x2::clock::timestamp_ms(arg7) > v2.end_timestamp, 9);
        v2.result = arg5;
        let v3 = 0;
        if (0x1::option::is_some<u64>(&arg6)) {
            v3 = 0xaa8fbeee25a5467606094e34aa565dc18d7ecfbbb5be0d81f35914174596ae4f::big_queue::length<Guess>(&v2.guesses) - *0x1::option::borrow<u64>(&arg6);
        };
        while (0xaa8fbeee25a5467606094e34aa565dc18d7ecfbbb5be0d81f35914174596ae4f::big_queue::length<Guess>(&v2.guesses) > v3) {
            let v4 = 0xaa8fbeee25a5467606094e34aa565dc18d7ecfbbb5be0d81f35914174596ae4f::big_queue::pop_front<Guess>(&mut v2.guesses);
            let v5 = get_result(v2.result, *0x1::option::borrow<u64>(&v2.ai_prediction), v4.guess);
            v0.locked_balance = v0.locked_balance - v4.bet_size;
            if (v5 == 1) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v0.balance, v4.bet_size * 2), arg8), v4.player);
            };
            if (v5 == 2) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v0.balance, v4.bet_size), arg8), v4.player);
            };
        };
        if (0xaa8fbeee25a5467606094e34aa565dc18d7ecfbbb5be0d81f35914174596ae4f::big_queue::length<Guess>(&v2.guesses) == 0) {
            v2.settled = true;
            let v6 = RoundResult<T0>{
                market_id     : 0x2::object::uid_to_inner(&v0.id),
                market_name   : arg3,
                result        : v2.result,
                ai_prediction : 0x1::option::some<u64>(*0x1::option::borrow<u64>(&v2.ai_prediction)),
                round_number  : v1.round_number,
            };
            0x2::event::emit<RoundResult<T0>>(v6);
        };
    }

    public fun withdraw_market_balance<T0>(arg0: &MarketAdminCap, arg1: &mut MarketConfig, arg2: 0x1::string::String, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert_valid_version(arg1);
        let v0 = borrow_mut_marketplace<T0>(arg1, arg2);
        assert!(0x2::balance::value<T0>(&v0.balance) - arg3 > v0.locked_balance, 10);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut v0.balance, arg3, arg4), 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v6
}

