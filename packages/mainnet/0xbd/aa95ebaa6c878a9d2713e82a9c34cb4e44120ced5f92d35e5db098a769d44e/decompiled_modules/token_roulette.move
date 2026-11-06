module 0xbdaa95ebaa6c878a9d2713e82a9c34cb4e44120ced5f92d35e5db098a769d44e::token_roulette {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
        game_id: 0x2::object::ID,
    }

    struct Profile has store {
        wagered: u64,
        referrer: 0x1::option::Option<address>,
        referrals: u64,
        earned: u64,
    }

    struct Pending has drop, store {
        round_id: u64,
        players: vector<address>,
        amounts: vector<u64>,
        total: u64,
        ticket: u64,
        drawer: address,
        digest: vector<u8>,
    }

    struct Record has copy, drop, store {
        round_id: u64,
        winner: address,
        pot: u64,
        payout: u64,
        winner_bet: u64,
    }

    struct Outcome has copy, drop {
        winner: address,
        winner_bet: u64,
        payout: u64,
        referrer: 0x1::option::Option<address>,
        referrer_cut: u64,
        drawer_cut: u64,
        house_cut: u64,
    }

    struct Game<phantom T0> has key {
        id: 0x2::object::UID,
        unit: u64,
        round_id: u64,
        end_ms: u64,
        players: vector<address>,
        amounts: vector<u64>,
        total: u64,
        pot: 0x2::balance::Balance<T0>,
        pending: 0x1::option::Option<Pending>,
        pending_pot: 0x2::balance::Balance<T0>,
        vault: 0x2::balance::Balance<T0>,
        house: 0x2::balance::Balance<T0>,
        balances: 0x2::table::Table<address, u64>,
        profiles: 0x2::table::Table<address, Profile>,
        history: vector<Record>,
    }

    struct GameCreated has copy, drop {
        game: 0x2::object::ID,
        unit: u64,
    }

    struct BetPlaced has copy, drop {
        game: 0x2::object::ID,
        round_id: u64,
        player: address,
        amount: u64,
        total: u64,
    }

    struct RoundDrawn has copy, drop {
        game: 0x2::object::ID,
        round_id: u64,
        ticket: u64,
        drawer: address,
    }

    struct RoundFinished has copy, drop {
        game: 0x2::object::ID,
        round_id: u64,
        winner: address,
        pot: u64,
        payout: u64,
    }

    struct Claimed has copy, drop {
        game: 0x2::object::ID,
        player: address,
        amount: u64,
    }

    entry fun join<T0>(arg0: &mut Game<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        place<T0>(arg0, arg1, 0x1::option::none<address>(), 0x2::clock::timestamp_ms(arg2), arg3);
    }

    entry fun claim<T0>(arg0: &mut Game<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        settle<T0>(arg0, arg1);
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::table::contains<address, u64>(&arg0.balances, v0), 6);
        let v1 = 0x2::table::remove<address, u64>(&mut arg0.balances, v0);
        assert!(v1 > 0, 6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.vault, v1, arg1), v0);
        let v2 = Claimed{
            game   : 0x2::object::id<Game<T0>>(arg0),
            player : v0,
            amount : v1,
        };
        0x2::event::emit<Claimed>(v2);
    }

    fun credit<T0>(arg0: &mut Game<T0>, arg1: address, arg2: u64) {
        if (arg2 == 0) {
            return
        };
        if (0x2::table::contains<address, u64>(&arg0.balances, arg1)) {
            let v0 = 0x2::table::borrow_mut<address, u64>(&mut arg0.balances, arg1);
            *v0 = *v0 + arg2;
        } else {
            0x2::table::add<address, u64>(&mut arg0.balances, arg1, arg2);
        };
    }

    entry fun draw<T0>(arg0: &mut Game<T0>, arg1: &0x2::clock::Clock, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        settle<T0>(arg0, arg3);
        assert!(0x1::vector::length<address>(&arg0.players) >= 2 && arg0.end_ms != 0, 4);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.end_ms, 5);
        let v0 = 0x2::random::new_generator(arg2, arg3);
        let v1 = 0x2::random::generate_u64_in_range(&mut v0, 0, arg0.total - 1);
        start_draw<T0>(arg0, v1, 0x2::clock::timestamp_ms(arg1), arg3, 0x2::tx_context::sender(arg3));
    }

    fun ensure_profile<T0>(arg0: &mut Game<T0>, arg1: address) {
        if (!0x2::table::contains<address, Profile>(&arg0.profiles, arg1)) {
            let v0 = Profile{
                wagered   : 0,
                referrer  : 0x1::option::none<address>(),
                referrals : 0,
                earned    : 0,
            };
            0x2::table::add<address, Profile>(&mut arg0.profiles, arg1, v0);
        };
    }

    public fun get_config<T0>(arg0: &Game<T0>) : (u64, u64) {
        (arg0.unit, 100 * arg0.unit)
    }

    public fun get_history<T0>(arg0: &Game<T0>, arg1: &0x2::tx_context::TxContext) : (vector<u64>, vector<address>, vector<u64>, vector<u64>, vector<u64>) {
        let v0 = arg0.history;
        if (visible<T0>(arg0, arg1)) {
            let v1 = 0x1::option::borrow<Pending>(&arg0.pending);
            let v2 = resolve<T0>(arg0, v1);
            0x1::vector::push_back<Record>(&mut v0, to_record(v1, &v2));
            if (0x1::vector::length<Record>(&v0) > 10) {
                0x1::vector::remove<Record>(&mut v0, 0);
            };
        };
        let v3 = vector[];
        let v4 = vector[];
        let v5 = vector[];
        let v6 = vector[];
        let v7 = vector[];
        let v8 = 0;
        while (v8 < 0x1::vector::length<Record>(&v0)) {
            let v9 = 0x1::vector::borrow<Record>(&v0, v8);
            0x1::vector::push_back<u64>(&mut v3, v9.round_id);
            0x1::vector::push_back<address>(&mut v4, v9.winner);
            0x1::vector::push_back<u64>(&mut v5, v9.pot);
            0x1::vector::push_back<u64>(&mut v6, v9.payout);
            0x1::vector::push_back<u64>(&mut v7, v9.winner_bet);
            v8 = v8 + 1;
        };
        (v3, v4, v5, v6, v7)
    }

    public fun get_players<T0>(arg0: &Game<T0>) : (vector<address>, vector<u64>) {
        (arg0.players, arg0.amounts)
    }

    public fun get_profile<T0>(arg0: &Game<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) : (bool, bool, bool, address, u64, u64) {
        if (!0x2::table::contains<address, Profile>(&arg0.profiles, arg1)) {
            return (false, false, false, @0x0, 0, 0)
        };
        let v0 = 0x2::table::borrow<address, Profile>(&arg0.profiles, arg1);
        let v1 = v0.earned;
        let v2 = v1;
        if (visible<T0>(arg0, arg2)) {
            let v3 = resolve<T0>(arg0, 0x1::option::borrow<Pending>(&arg0.pending));
            if (0x1::option::is_some<address>(&v3.referrer) && *0x1::option::borrow<address>(&v3.referrer) == arg1) {
                v2 = v1 + v3.referrer_cut;
            };
        };
        let v4 = 0x1::option::is_some<address>(&v0.referrer);
        let v5 = if (v4) {
            *0x1::option::borrow<address>(&v0.referrer)
        } else {
            @0x0
        };
        (true, v0.wagered >= 100 * arg0.unit, v4, v5, v0.referrals, v2)
    }

    public fun get_round<T0>(arg0: &Game<T0>) : (u64, u64, u64, u64, u64) {
        (arg0.round_id, arg0.end_ms / 1000, arg0.total, arg0.unit, 60)
    }

    public fun get_winnings<T0>(arg0: &Game<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) : u64 {
        let v0 = if (0x2::table::contains<address, u64>(&arg0.balances, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.balances, arg1)
        } else {
            0
        };
        let v1 = v0;
        if (visible<T0>(arg0, arg2)) {
            let v2 = 0x1::option::borrow<Pending>(&arg0.pending);
            let v3 = resolve<T0>(arg0, v2);
            if (v3.winner == arg1) {
                v1 = v0 + v3.payout;
            };
            if (v2.drawer == arg1) {
                v1 = v1 + v3.drawer_cut;
            };
            if (0x1::option::is_some<address>(&v3.referrer) && *0x1::option::borrow<address>(&v3.referrer) == arg1) {
                v1 = v1 + v3.referrer_cut;
            };
        };
        v1
    }

    fun is_eligible<T0>(arg0: &Game<T0>, arg1: address) : bool {
        if (!0x2::table::contains<address, Profile>(&arg0.profiles, arg1)) {
            return false
        };
        0x2::table::borrow<address, Profile>(&arg0.profiles, arg1).wagered >= 100 * arg0.unit
    }

    entry fun join_with_ref<T0>(arg0: &mut Game<T0>, arg1: 0x2::coin::Coin<T0>, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        place<T0>(arg0, arg1, 0x1::option::some<address>(arg2), 0x2::clock::timestamp_ms(arg3), arg4);
    }

    entry fun launch<T0>(arg0: &0x2::coin::CoinMetadata<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = new_game<T0>(0x2::coin::get_decimals<T0>(arg0), arg1);
        publish<T0>(v0, arg1);
    }

    entry fun launch_with_decimals<T0>(arg0: u8, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = new_game<T0>(arg0, arg1);
        publish<T0>(v0, arg1);
    }

    fun link_referrer<T0>(arg0: &mut Game<T0>, arg1: address, arg2: address) : bool {
        if (arg2 == arg1 || !is_eligible<T0>(arg0, arg2)) {
            return false
        };
        ensure_profile<T0>(arg0, arg1);
        let v0 = 0x2::table::borrow_mut<address, Profile>(&mut arg0.profiles, arg1);
        if (0x1::option::is_some<address>(&v0.referrer)) {
            return false
        };
        v0.referrer = 0x1::option::some<address>(arg2);
        let v1 = 0x2::table::borrow_mut<address, Profile>(&mut arg0.profiles, arg2);
        v1.referrals = v1.referrals + 1;
        true
    }

    public(friend) fun new_game<T0>(arg0: u8, arg1: &mut 0x2::tx_context::TxContext) : Game<T0> {
        assert!(arg0 <= 16, 12);
        Game<T0>{
            id          : 0x2::object::new(arg1),
            unit        : pow10(arg0),
            round_id    : 1,
            end_ms      : 0,
            players     : vector[],
            amounts     : vector[],
            total       : 0,
            pot         : 0x2::balance::zero<T0>(),
            pending     : 0x1::option::none<Pending>(),
            pending_pot : 0x2::balance::zero<T0>(),
            vault       : 0x2::balance::zero<T0>(),
            house       : 0x2::balance::zero<T0>(),
            balances    : 0x2::table::new<address, u64>(arg1),
            profiles    : 0x2::table::new<address, Profile>(arg1),
            history     : 0x1::vector::empty<Record>(),
        }
    }

    public(friend) fun place<T0>(arg0: &mut Game<T0>, arg1: 0x2::coin::Coin<T0>, arg2: 0x1::option::Option<address>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        settle<T0>(arg0, arg4);
        if (arg0.end_ms != 0) {
            assert!(arg3 + 5000 < arg0.end_ms, 2);
        };
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::coin::value<T0>(&arg1);
        assert!(v1 >= arg0.unit, 1);
        let (v2, v3) = 0x1::vector::index_of<address>(&arg0.players, &v0);
        if (v2) {
            let v4 = 0x1::vector::borrow_mut<u64>(&mut arg0.amounts, v3);
            *v4 = *v4 + v1;
        } else {
            assert!(0x1::vector::length<address>(&arg0.players) < 50, 3);
            0x1::vector::push_back<address>(&mut arg0.players, v0);
            0x1::vector::push_back<u64>(&mut arg0.amounts, v1);
        };
        arg0.total = arg0.total + v1;
        0x2::balance::join<T0>(&mut arg0.pot, 0x2::coin::into_balance<T0>(arg1));
        if (arg0.end_ms == 0 && 0x1::vector::length<address>(&arg0.players) >= 2) {
            arg0.end_ms = (arg3 / 1000 + 60) * 1000;
        };
        ensure_profile<T0>(arg0, v0);
        let v5 = 0x2::table::borrow_mut<address, Profile>(&mut arg0.profiles, v0);
        v5.wagered = v5.wagered + v1;
        if (0x1::option::is_some<address>(&arg2)) {
            link_referrer<T0>(arg0, v0, *0x1::option::borrow<address>(&arg2));
        };
        let v6 = BetPlaced{
            game     : 0x2::object::id<Game<T0>>(arg0),
            round_id : arg0.round_id,
            player   : v0,
            amount   : v1,
            total    : arg0.total,
        };
        0x2::event::emit<BetPlaced>(v6);
    }

    fun pow10(arg0: u8) : u64 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        v0
    }

    fun publish<T0>(arg0: Game<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<Game<T0>>(&arg0);
        let v1 = GameCreated{
            game : v0,
            unit : arg0.unit,
        };
        0x2::event::emit<GameCreated>(v1);
        let v2 = AdminCap{
            id      : 0x2::object::new(arg1),
            game_id : v0,
        };
        0x2::transfer::share_object<Game<T0>>(arg0);
        0x2::transfer::transfer<AdminCap>(v2, 0x2::tx_context::sender(arg1));
    }

    fun resolve<T0>(arg0: &Game<T0>, arg1: &Pending) : Outcome {
        let v0 = 0;
        let v1 = *0x1::vector::borrow<u64>(&arg1.amounts, 0);
        while (v0 + 1 < 0x1::vector::length<address>(&arg1.players) && arg1.ticket >= v1) {
            let v2 = v0 + 1;
            v0 = v2;
            v1 = v1 + *0x1::vector::borrow<u64>(&arg1.amounts, v2);
        };
        let v3 = *0x1::vector::borrow<address>(&arg1.players, v0);
        let v4 = if (0x2::table::contains<address, Profile>(&arg0.profiles, v3)) {
            0x2::table::borrow<address, Profile>(&arg0.profiles, v3).referrer
        } else {
            0x1::option::none<address>()
        };
        let v5 = v4;
        let v6 = 0x1::option::is_some<address>(&v5);
        let v7 = if (v6) {
            900
        } else {
            1000
        };
        let v8 = share(arg1.total, v7);
        let v9 = if (v6) {
            share(arg1.total, 300)
        } else {
            0
        };
        let v10 = share(arg1.total, 50);
        Outcome{
            winner       : v3,
            winner_bet   : *0x1::vector::borrow<u64>(&arg1.amounts, v0),
            payout       : arg1.total - v8,
            referrer     : v5,
            referrer_cut : v9,
            drawer_cut   : v10,
            house_cut    : v8 - v9 - v10,
        }
    }

    entry fun set_referrer<T0>(arg0: &mut Game<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg1 != v0, 8);
        assert!(is_eligible<T0>(arg0, arg1), 9);
        ensure_profile<T0>(arg0, v0);
        assert!(0x1::option::is_none<address>(&0x2::table::borrow<address, Profile>(&arg0.profiles, v0).referrer), 11);
        link_referrer<T0>(arg0, v0, arg1);
    }

    public(friend) fun settle<T0>(arg0: &mut Game<T0>, arg1: &0x2::tx_context::TxContext) {
        if (!visible<T0>(arg0, arg1)) {
            return
        };
        let v0 = 0x1::option::extract<Pending>(&mut arg0.pending);
        let v1 = resolve<T0>(arg0, &v0);
        credit<T0>(arg0, v1.winner, v1.payout);
        credit<T0>(arg0, v0.drawer, v1.drawer_cut);
        let v2 = v1.payout + v1.drawer_cut;
        let v3 = v2;
        if (0x1::option::is_some<address>(&v1.referrer)) {
            let v4 = *0x1::option::borrow<address>(&v1.referrer);
            credit<T0>(arg0, v4, v1.referrer_cut);
            let v5 = 0x2::table::borrow_mut<address, Profile>(&mut arg0.profiles, v4);
            v5.earned = v5.earned + v1.referrer_cut;
            v3 = v2 + v1.referrer_cut;
        };
        0x2::balance::join<T0>(&mut arg0.vault, 0x2::balance::split<T0>(&mut arg0.pending_pot, v3));
        0x2::balance::join<T0>(&mut arg0.house, 0x2::balance::withdraw_all<T0>(&mut arg0.pending_pot));
        0x1::vector::push_back<Record>(&mut arg0.history, to_record(&v0, &v1));
        if (0x1::vector::length<Record>(&arg0.history) > 10) {
            0x1::vector::remove<Record>(&mut arg0.history, 0);
        };
        let v6 = RoundFinished{
            game     : 0x2::object::id<Game<T0>>(arg0),
            round_id : v0.round_id,
            winner   : v1.winner,
            pot      : v0.total,
            payout   : v1.payout,
        };
        0x2::event::emit<RoundFinished>(v6);
    }

    fun share(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (10000 as u128)) as u64)
    }

    public(friend) fun start_draw<T0>(arg0: &mut Game<T0>, arg1: u64, arg2: u64, arg3: &0x2::tx_context::TxContext, arg4: address) {
        assert!(0x1::option::is_none<Pending>(&arg0.pending), 7);
        assert!(0x1::vector::length<address>(&arg0.players) >= 2 && arg0.end_ms != 0, 4);
        assert!(arg2 >= arg0.end_ms, 5);
        let v0 = Pending{
            round_id : arg0.round_id,
            players  : arg0.players,
            amounts  : arg0.amounts,
            total    : arg0.total,
            ticket   : arg1,
            drawer   : arg4,
            digest   : *0x2::tx_context::digest(arg3),
        };
        0x2::balance::join<T0>(&mut arg0.pending_pot, 0x2::balance::withdraw_all<T0>(&mut arg0.pot));
        arg0.pending = 0x1::option::some<Pending>(v0);
        arg0.players = vector[];
        arg0.amounts = vector[];
        arg0.total = 0;
        arg0.end_ms = 0;
        let v1 = RoundDrawn{
            game     : 0x2::object::id<Game<T0>>(arg0),
            round_id : arg0.round_id,
            ticket   : arg1,
            drawer   : arg4,
        };
        0x2::event::emit<RoundDrawn>(v1);
        arg0.round_id = arg0.round_id + 1;
    }

    fun to_record(arg0: &Pending, arg1: &Outcome) : Record {
        Record{
            round_id   : arg0.round_id,
            winner     : arg1.winner,
            pot        : arg0.total,
            payout     : arg1.payout,
            winner_bet : arg1.winner_bet,
        }
    }

    fun visible<T0>(arg0: &Game<T0>, arg1: &0x2::tx_context::TxContext) : bool {
        if (0x1::option::is_none<Pending>(&arg0.pending)) {
            return false
        };
        0x1::option::borrow<Pending>(&arg0.pending).digest != *0x2::tx_context::digest(arg1)
    }

    entry fun withdraw_house<T0>(arg0: &AdminCap, arg1: &mut Game<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.game_id == 0x2::object::id<Game<T0>>(arg1), 10);
        let v0 = 0x2::balance::value<T0>(&arg1.house);
        assert!(v0 > 0, 6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.house, v0, arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v7
}

