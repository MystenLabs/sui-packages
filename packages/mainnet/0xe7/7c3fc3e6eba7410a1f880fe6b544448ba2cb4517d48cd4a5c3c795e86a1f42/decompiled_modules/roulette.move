module 0xe77c3fc3e6eba7410a1f880fe6b544448ba2cb4517d48cd4a5c3c795e86a1f42::roulette {
    struct RoundResult has copy, drop, store {
        round_id: u64,
        winner: address,
        pot: u64,
        payout: u64,
        winner_bet: u64,
    }

    struct PendingRound has copy, drop, store {
        round_id: u64,
        total: u64,
        ticket: u64,
        players: vector<address>,
        amounts: vector<u64>,
        spinner: address,
    }

    struct Profile has drop, store {
        referrer: 0x1::option::Option<address>,
        played: bool,
        referrals: u64,
        earned: u64,
    }

    struct Resolved has copy, drop {
        winner: address,
        winner_bet: u64,
        payout: u64,
        platform_fee: u64,
        referrer: 0x1::option::Option<address>,
        ref_fee: u64,
        spinner: address,
        spin_bonus: u64,
    }

    struct Game has key {
        id: 0x2::object::UID,
        royalty: address,
        round_id: u64,
        end_time: u64,
        total: u64,
        players: vector<address>,
        amounts: vector<u64>,
        pot: 0x2::balance::Balance<0x2::sui::SUI>,
        history: vector<RoundResult>,
        vault: 0x2::balance::Balance<0x2::sui::SUI>,
        winnings: 0x2::table::Table<address, u64>,
        pending: vector<PendingRound>,
        profiles: 0x2::table::Table<address, Profile>,
    }

    struct BetPlaced has copy, drop {
        round_id: u64,
        player: address,
        amount: u64,
    }

    struct RoundDrawn has copy, drop {
        round_id: u64,
        total: u64,
        ticket: u64,
    }

    struct RoundFinished has copy, drop {
        round_id: u64,
        winner: address,
        pot: u64,
        payout: u64,
        platform_fee: u64,
        ref_fee: u64,
        referrer: 0x1::option::Option<address>,
        spinner: address,
        spin_bonus: u64,
    }

    struct ReferrerSet has copy, drop {
        player: address,
        referrer: address,
    }

    struct Claimed has copy, drop {
        player: address,
        amount: u64,
    }

    public fun join(arg0: &mut Game, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        place_bet(arg0, 0x2::tx_context::sender(arg3), arg1, now_s(arg2));
    }

    fun split(arg0: u64, arg1: bool) : (u64, u64, u64) {
        let v0 = (arg0 as u128);
        if (arg1) {
            let v4 = v0 * 9 / 100;
            let v5 = v0 * 3 / 100;
            (((v0 - v4) as u64), ((v4 - v5) as u64), (v5 as u64))
        } else {
            let v6 = v0 * 10 / 100;
            (((v0 - v6) as u64), (v6 as u64), 0)
        }
    }

    fun begin_draw(arg0: &mut Game, arg1: u64) : u64 {
        assert!(arg0.end_time != 0, 4);
        assert!(arg1 >= arg0.end_time, 5);
        let v0 = arg0.total;
        assert!(0x1::vector::length<address>(&arg0.players) >= 2, 4);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.pot) == v0, 7);
        settle_all(arg0);
        v0
    }

    fun bind_referrer(arg0: &mut Game, arg1: address, arg2: address) {
        assert!(arg1 != arg2, 8);
        assert!(0x2::table::contains<address, Profile>(&arg0.profiles, arg2) && 0x2::table::borrow<address, Profile>(&arg0.profiles, arg2).played, 9);
        ensure_profile(arg0, arg1);
        let v0 = 0x2::table::borrow_mut<address, Profile>(&mut arg0.profiles, arg1);
        assert!(0x1::option::is_none<address>(&v0.referrer), 11);
        v0.referrer = 0x1::option::some<address>(arg2);
        let v1 = 0x2::table::borrow_mut<address, Profile>(&mut arg0.profiles, arg2);
        v1.referrals = v1.referrals + 1;
        let v2 = ReferrerSet{
            player   : arg1,
            referrer : arg2,
        };
        0x2::event::emit<ReferrerSet>(v2);
    }

    public fun claim(arg0: &mut Game, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(claim_for(arg0, v0, arg1), v0);
    }

    fun claim_for(arg0: &mut Game, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        settle_all(arg0);
        assert!(0x2::table::contains<address, u64>(&arg0.winnings, arg1), 6);
        let v0 = 0x2::table::remove<address, u64>(&mut arg0.winnings, arg1);
        assert!(v0 > 0, 6);
        let v1 = Claimed{
            player : arg1,
            amount : v0,
        };
        0x2::event::emit<Claimed>(v1);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.vault, v0), arg2)
    }

    fun credit(arg0: &mut Game, arg1: address, arg2: u64) {
        if (arg2 == 0) {
            return
        };
        if (0x2::table::contains<address, u64>(&arg0.winnings, arg1)) {
            let v0 = 0x2::table::borrow_mut<address, u64>(&mut arg0.winnings, arg1);
            *v0 = *v0 + arg2;
        } else {
            0x2::table::add<address, u64>(&mut arg0.winnings, arg1, arg2);
        };
    }

    entry fun draw(arg0: &mut Game, arg1: &0x2::clock::Clock, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = begin_draw(arg0, now_s(arg1));
        let v1 = 0x2::random::new_generator(arg2, arg3);
        finish_draw(arg0, v0, 0x2::random::generate_u64_in_range(&mut v1, 0, v0 - 1), 0x2::tx_context::sender(arg3));
    }

    fun ensure_profile(arg0: &mut Game, arg1: address) {
        if (!0x2::table::contains<address, Profile>(&arg0.profiles, arg1)) {
            let v0 = Profile{
                referrer  : 0x1::option::none<address>(),
                played    : false,
                referrals : 0,
                earned    : 0,
            };
            0x2::table::add<address, Profile>(&mut arg0.profiles, arg1, v0);
        };
    }

    fun finish_draw(arg0: &mut Game, arg1: u64, arg2: u64, arg3: address) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.vault, 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.pot));
        let v0 = arg0.round_id;
        let v1 = PendingRound{
            round_id : v0,
            total    : arg1,
            ticket   : arg2,
            players  : arg0.players,
            amounts  : arg0.amounts,
            spinner  : arg3,
        };
        0x1::vector::push_back<PendingRound>(&mut arg0.pending, v1);
        let v2 = RoundDrawn{
            round_id : v0,
            total    : arg1,
            ticket   : arg2,
        };
        0x2::event::emit<RoundDrawn>(v2);
        arg0.round_id = v0 + 1;
        arg0.end_time = 0;
        arg0.total = 0;
        arg0.players = vector[];
        arg0.amounts = vector[];
    }

    public fun get_history(arg0: &Game) : (vector<u64>, vector<address>, vector<u64>, vector<u64>, vector<u64>) {
        let v0 = arg0.history;
        let v1 = 0;
        while (v1 < 0x1::vector::length<PendingRound>(&arg0.pending)) {
            let v2 = 0x1::vector::borrow<PendingRound>(&arg0.pending, v1);
            let v3 = resolve(arg0, v2);
            let v4 = RoundResult{
                round_id   : v2.round_id,
                winner     : v3.winner,
                pot        : v2.total,
                payout     : v3.payout,
                winner_bet : v3.winner_bet,
            };
            0x1::vector::push_back<RoundResult>(&mut v0, v4);
            v1 = v1 + 1;
        };
        while (0x1::vector::length<RoundResult>(&v0) > 10) {
            0x1::vector::remove<RoundResult>(&mut v0, 0);
        };
        let v5 = vector[];
        let v6 = vector[];
        let v7 = vector[];
        let v8 = vector[];
        let v9 = vector[];
        let v10 = 0;
        while (v10 < 0x1::vector::length<RoundResult>(&v0)) {
            let v11 = 0x1::vector::borrow<RoundResult>(&v0, v10);
            0x1::vector::push_back<u64>(&mut v5, v11.round_id);
            0x1::vector::push_back<address>(&mut v6, v11.winner);
            0x1::vector::push_back<u64>(&mut v7, v11.pot);
            0x1::vector::push_back<u64>(&mut v8, v11.payout);
            0x1::vector::push_back<u64>(&mut v9, v11.winner_bet);
            v10 = v10 + 1;
        };
        (v5, v6, v7, v8, v9)
    }

    public fun get_players(arg0: &Game) : (vector<address>, vector<u64>) {
        (arg0.players, arg0.amounts)
    }

    public fun get_profile(arg0: &Game, arg1: address) : (bool, bool, bool, address, u64, u64) {
        if (!0x2::table::contains<address, Profile>(&arg0.profiles, arg1)) {
            return (false, false, false, @0x0, 0, 0)
        };
        let v0 = 0x2::table::borrow<address, Profile>(&arg0.profiles, arg1);
        let v1 = v0.earned;
        let v2 = 0;
        while (v2 < 0x1::vector::length<PendingRound>(&arg0.pending)) {
            let v3 = resolve(arg0, 0x1::vector::borrow<PendingRound>(&arg0.pending, v2));
            if (0x1::option::is_some<address>(&v3.referrer) && *0x1::option::borrow<address>(&v3.referrer) == arg1) {
                v1 = v1 + v3.ref_fee;
            };
            v2 = v2 + 1;
        };
        let v4 = 0x1::option::is_some<address>(&v0.referrer);
        let v5 = if (v4) {
            *0x1::option::borrow<address>(&v0.referrer)
        } else {
            @0x0
        };
        (true, v0.played, v4, v5, v0.referrals, v1)
    }

    public fun get_round(arg0: &Game) : (u64, u64, u64, u64, u64) {
        (arg0.round_id, arg0.end_time, arg0.total, 1000000000, 60)
    }

    public fun get_winnings(arg0: &Game, arg1: address) : u64 {
        let v0 = if (0x2::table::contains<address, u64>(&arg0.winnings, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.winnings, arg1)
        } else {
            0
        };
        let v1 = v0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<PendingRound>(&arg0.pending)) {
            let v3 = resolve(arg0, 0x1::vector::borrow<PendingRound>(&arg0.pending, v2));
            if (v3.winner == arg1) {
                v1 = v1 + v3.payout;
            };
            if (arg1 == arg0.royalty) {
                v1 = v1 + v3.platform_fee - v3.spin_bonus;
            };
            if (arg1 == v3.spinner) {
                v1 = v1 + v3.spin_bonus;
            };
            if (0x1::option::is_some<address>(&v3.referrer) && *0x1::option::borrow<address>(&v3.referrer) == arg1) {
                v1 = v1 + v3.ref_fee;
            };
            v2 = v2 + 1;
        };
        v1
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        0x2::transfer::share_object<Game>(new_game(v0, arg0));
    }

    public fun join_with_ref(arg0: &mut Game, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: address, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        bind_referrer(arg0, v0, arg2);
        place_bet(arg0, v0, arg1, now_s(arg3));
    }

    fun new_game(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : Game {
        Game{
            id       : 0x2::object::new(arg1),
            royalty  : arg0,
            round_id : 1,
            end_time : 0,
            total    : 0,
            players  : vector[],
            amounts  : vector[],
            pot      : 0x2::balance::zero<0x2::sui::SUI>(),
            history  : 0x1::vector::empty<RoundResult>(),
            vault    : 0x2::balance::zero<0x2::sui::SUI>(),
            winnings : 0x2::table::new<address, u64>(arg1),
            pending  : 0x1::vector::empty<PendingRound>(),
            profiles : 0x2::table::new<address, Profile>(arg1),
        }
    }

    fun now_s(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    fun pick_winner(arg0: &PendingRound) : (address, u64) {
        let v0 = 0x1::vector::length<address>(&arg0.players);
        let v1 = 0;
        let v2 = 0;
        let v3 = v0 - 1;
        while (v1 < v0) {
            v2 = v2 + *0x1::vector::borrow<u64>(&arg0.amounts, v1);
            if (arg0.ticket < v2) {
                v3 = v1;
                break
            };
            v1 = v1 + 1;
        };
        (*0x1::vector::borrow<address>(&arg0.players, v3), *0x1::vector::borrow<u64>(&arg0.amounts, v3))
    }

    fun place_bet(arg0: &mut Game, arg1: address, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(arg0.end_time == 0 || arg3 + 5 < arg0.end_time, 2);
        let (v1, v2) = 0x1::vector::index_of<address>(&arg0.players, &arg1);
        if (v1) {
            assert!(v0 >= 100000000, 1);
            let v3 = 0x1::vector::borrow_mut<u64>(&mut arg0.amounts, v2);
            *v3 = *v3 + v0;
        } else {
            assert!(v0 >= 1000000000, 1);
            assert!(0x1::vector::length<address>(&arg0.players) < 50, 3);
            0x1::vector::push_back<address>(&mut arg0.players, arg1);
            0x1::vector::push_back<u64>(&mut arg0.amounts, v0);
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.pot, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        arg0.total = arg0.total + v0;
        ensure_profile(arg0, arg1);
        0x2::table::borrow_mut<address, Profile>(&mut arg0.profiles, arg1).played = true;
        if (arg0.end_time == 0 && 0x1::vector::length<address>(&arg0.players) >= 2) {
            arg0.end_time = arg3 + 60;
        };
        let v4 = BetPlaced{
            round_id : arg0.round_id,
            player   : arg1,
            amount   : v0,
        };
        0x2::event::emit<BetPlaced>(v4);
    }

    fun resolve(arg0: &Game, arg1: &PendingRound) : Resolved {
        let (v0, v1) = pick_winner(arg1);
        let v2 = if (0x2::table::contains<address, Profile>(&arg0.profiles, v0)) {
            0x2::table::borrow<address, Profile>(&arg0.profiles, v0).referrer
        } else {
            0x1::option::none<address>()
        };
        let v3 = v2;
        let (v4, v5, v6) = split(arg1.total, 0x1::option::is_some<address>(&v3));
        let v7 = (((arg1.total as u128) * 5 / 1000) as u64);
        assert!(v7 <= v5, 7);
        Resolved{
            winner       : v0,
            winner_bet   : v1,
            payout       : v4,
            platform_fee : v5,
            referrer     : v3,
            ref_fee      : v6,
            spinner      : arg1.spinner,
            spin_bonus   : v7,
        }
    }

    public fun royalty_address(arg0: &Game) : address {
        arg0.royalty
    }

    public fun set_referrer(arg0: &mut Game, arg1: address, arg2: &0x2::tx_context::TxContext) {
        bind_referrer(arg0, 0x2::tx_context::sender(arg2), arg1);
    }

    public fun settle(arg0: &mut Game) {
        settle_all(arg0);
    }

    fun settle_all(arg0: &mut Game) {
        let v0 = arg0.royalty;
        while (!0x1::vector::is_empty<PendingRound>(&arg0.pending)) {
            let v1 = 0x1::vector::remove<PendingRound>(&mut arg0.pending, 0);
            let v2 = resolve(arg0, &v1);
            assert!(v2.payout + v2.platform_fee + v2.ref_fee == v1.total, 7);
            credit(arg0, v2.winner, v2.payout);
            credit(arg0, v0, v2.platform_fee - v2.spin_bonus);
            credit(arg0, v2.spinner, v2.spin_bonus);
            if (0x1::option::is_some<address>(&v2.referrer)) {
                let v3 = *0x1::option::borrow<address>(&v2.referrer);
                credit(arg0, v3, v2.ref_fee);
                let v4 = 0x2::table::borrow_mut<address, Profile>(&mut arg0.profiles, v3);
                v4.earned = v4.earned + v2.ref_fee;
            };
            let v5 = RoundResult{
                round_id   : v1.round_id,
                winner     : v2.winner,
                pot        : v1.total,
                payout     : v2.payout,
                winner_bet : v2.winner_bet,
            };
            0x1::vector::push_back<RoundResult>(&mut arg0.history, v5);
            if (0x1::vector::length<RoundResult>(&arg0.history) > 10) {
                0x1::vector::remove<RoundResult>(&mut arg0.history, 0);
            };
            let v6 = RoundFinished{
                round_id     : v1.round_id,
                winner       : v2.winner,
                pot          : v1.total,
                payout       : v2.payout,
                platform_fee : v2.platform_fee,
                ref_fee      : v2.ref_fee,
                referrer     : v2.referrer,
                spinner      : v2.spinner,
                spin_bonus   : v2.spin_bonus,
            };
            0x2::event::emit<RoundFinished>(v6);
        };
    }

    // decompiled from Move bytecode v7
}

