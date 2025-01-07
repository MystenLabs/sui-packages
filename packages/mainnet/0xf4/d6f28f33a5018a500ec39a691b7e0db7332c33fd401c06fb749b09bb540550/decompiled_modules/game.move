module 0xf4d6f28f33a5018a500ec39a691b7e0db7332c33fd401c06fb749b09bb540550::game {
    struct GAME has drop {
        dummy_field: bool,
    }

    struct Game has key {
        id: 0x2::object::UID,
        active: bool,
        prize: 0x1::option::Option<0x2::balance::Balance<0x2::sui::SUI>>,
        taps: u64,
        taps_per_address: 0x2::table::Table<address, u64>,
        winner: 0x1::option::Option<address>,
        initial_prize: u64,
        initial_taps: u64,
    }

    struct GameCreated has copy, drop {
        game: 0x2::object::ID,
    }

    struct GameEnded has copy, drop {
        game: 0x2::object::ID,
        winner: address,
    }

    struct GameCancelled has copy, drop {
        game: 0x2::object::ID,
    }

    struct Tapped has copy, drop {
        game: 0x2::object::ID,
        address: address,
    }

    public fun new(arg0: &0x2::package::Publisher, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0);
        assert!(arg1 > 0, 3);
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&v0);
        assert!(v1 > 0, 2);
        let v2 = Game{
            id               : 0x2::object::new(arg3),
            active           : true,
            prize            : 0x1::option::some<0x2::balance::Balance<0x2::sui::SUI>>(v0),
            taps             : arg1,
            taps_per_address : 0x2::table::new<address, u64>(arg3),
            winner           : 0x1::option::none<address>(),
            initial_prize    : v1,
            initial_taps     : arg1,
        };
        let v3 = GameCreated{game: 0x2::object::id<Game>(&v2)};
        0x2::event::emit<GameCreated>(v3);
        0x2::transfer::share_object<Game>(v2);
    }

    fun assert_admin(arg0: &0x2::package::Publisher) {
        assert!(0x2::package::from_module<GAME>(arg0), 0);
    }

    fun assert_game_is_active(arg0: &Game) {
        assert!(arg0.active, 1);
    }

    fun assert_sender_zklogin(arg0: u256, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(b"https://accounts.google.com");
        assert!(0x2::zklogin_verified_issuer::check_zklogin_issuer(0x2::tx_context::sender(arg1), arg0, &v0), 4);
    }

    public fun cancel(arg0: &0x2::package::Publisher, arg1: &mut Game, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0);
        assert_game_is_active(arg1);
        let v0 = GameCancelled{game: 0x2::object::id<Game>(arg1)};
        0x2::event::emit<GameCancelled>(v0);
        end(arg1, arg2);
    }

    fun end(arg0: &mut Game, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = GameEnded{
            game   : 0x2::object::id<Game>(arg0),
            winner : v0,
        };
        0x2::event::emit<GameEnded>(v1);
        arg0.active = false;
        arg0.winner = 0x1::option::some<address>(v0);
        0x2::pay::keep<0x2::sui::SUI>(0x2::coin::from_balance<0x2::sui::SUI>(0x1::option::extract<0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.prize), arg1), arg1);
    }

    public fun get_address_taps(arg0: &Game, arg1: address) : u64 {
        *0x2::table::borrow<address, u64>(&arg0.taps_per_address, arg1)
    }

    fun init(arg0: GAME, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<GAME>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun tap(arg0: &mut Game, arg1: u256, arg2: &mut 0x2::tx_context::TxContext) {
        assert_game_is_active(arg0);
        assert_sender_zklogin(arg1, arg2);
        let v0 = Tapped{
            game    : 0x2::object::id<Game>(arg0),
            address : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<Tapped>(v0);
        arg0.taps = arg0.taps - 1;
        update_taps_per_address(arg0, arg2);
        if (arg0.taps == 0) {
            end(arg0, arg2);
        };
    }

    fun update_taps_per_address(arg0: &mut Game, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = &mut arg0.taps_per_address;
        if (!0x2::table::contains<address, u64>(v1, v0)) {
            0x2::table::add<address, u64>(v1, v0, 0);
        };
        let v2 = 0x2::table::borrow_mut<address, u64>(v1, v0);
        *v2 = *v2 + 1;
    }

    // decompiled from Move bytecode v6
}

